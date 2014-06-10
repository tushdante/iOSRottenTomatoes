# Rotten Tomatoes App

Basic app that uses the rotten tomatoes api to display top movies

		
Time spent: 20 hours

Completed user stories:

 * [x] User can view a list of movies from Rotten Tomatoes.  Poster images must be loading asynchronously.
 * [x] User can view movie details by tapping on a cell
 * [x] User sees loading state while waiting for movies API.  (Library used: MBProgressHUD)
 * [x] User sees error message when there's a networking error.  You may not use UIAlertView to display the error.  See this screenshot  * [x] for what the error message should look like: network error screenshot.
 * [x] User can pull to refresh the movie list.
 * [ ] All images fade in (optional)
 * [ ] For the large poster, load the low-res image first, switch to high-res when complete (optional)
 * [ ] All images should be cached in memory and disk. In other words, images load immediately upon cold start (optional).
 * [ ] Customize the highlight and selection effect of the cell. (optional)
 * [ ] Customize the navigation bar. (optional)
 * [ ] Add a tab bar for Box Office and DVD. (optional)
 * [ ] Add a search bar. (optional)

 # Additional Requirements

  * [x] Must use Cocoapods.
  * [x] Asynchronous image downloading must be implemented using the UIImageView category in the AFNetworking library.
  
![alt tag](https://raw.githubusercontent.com/tushdante/iOSRottenTomatoes/master/rtTest.gif)