# Video Catalogue
## Overview  
The Video Catalogue is a simple project to present my iOS developing skill and architecture ability.

## Orientation
I haven't include all dependent cocoapods in this repo. Please install pods before open the project.   

Please run below command in the terminal under project folder.    
 
     $pod install  
    
After install pods, please use Xcode to open the ```VideoCatalogue.xcworkspace```.     

### Architeture

MVVM without RxSwift

### Model
I use Codable Struct to build the data model. The response data is an Array of catalogue.

### ServerManager
I can use simple URLSession to get json data in a couple of lines code. However, if so, the project will be hard to extend and test.   

The reason I create the ServerManager is for dependency injection, unit test and multi-services managerment.   

### Unit Test
Use XCTest framework for test ViewModel by feed mock data.   
Use XCTest framework for test API Web Service Call.  

## Feedback

I would love to hear your feedback. File an issue,  send me an email: [jiang.yi@siphty.com](mailto:jiang.yi@siphty.com).

### Q&A

1. Why use MVVM design pattern?
2. Why use MVVM without reactive?
3. Why use Kingfisher pod?

Enjoy!  
Yi Jiang