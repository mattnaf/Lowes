//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var movies: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MoviesTableViewCell
        let movie = movies[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let formattedDate = formatter.date(from: movie.releaseDate ?? "2000-01-01")
        formatter.dateFormat = "MMMM d, yyyy"
        let formattedDateSring = formatter.string(from: formattedDate ?? Date())
        
        let adjustedVoteAvg = round((movie.voteAverage!) * 10 ) / 10
        
        cell.movieTitleLabel.text = movie.title
        cell.movieDateLabel.text = formattedDateSring
        cell.movieVoteLabel.text = "\(adjustedVoteAvg)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func goButton(_ sender: Any) {
        getMovies()
    }
    
    func getMovies() {
        
        let sbText = searchBar.text ?? ""
        let query = sbText.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Network().apiKey)&language=en-US&query=\(query)&page=1&include_adult=false") else {
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,_, error in
            guard let data = data, error == nil else {
                return
            }

            do {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.movies = movieResponse.results
                    self!.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Movie Search"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! MovieDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let movie = movies[indexPath.row]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            let formattedDate = formatter.date(from: movie.releaseDate ?? "2000-01-01")
            formatter.dateFormat = "MM/dd/YY"
            let formattedDateSring = formatter.string(from: formattedDate ?? Date())
            
            destinationViewController.titleString = movie.title
            destinationViewController.releaseDateString = "Release Date: \(formattedDateSring)"
            destinationViewController.overviewString = movie.overview
            destinationViewController.posterPathString = movie.posterPath
        }
    }
    
}
