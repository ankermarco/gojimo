# gojimo
assets/class-diagram.svg shows the design diagram, using facade design, separate Core Data management, 
Network management and parsing JSON object in the GojimoManager class

1. On initial load, the GojimoManager checks the last modify date from HTTP request header to determine whether fetch and parse the JSON object from server
2. Save the Parsed JSON into Core Data, feed the QualificationViewController and SubjectViewControll from Core Data
