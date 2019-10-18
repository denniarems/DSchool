
### AV Blockchain Task

> Use case:​ Decentralised university/learning system.
>
> Description:​ As the world is moving to decentralised system in every vertical, may it me BFSIor SCM. Similarly there is a high need to evaluate a learner/student from multiple approvers (and not just one person). The exam/task will be evaluated by Peers(Approver/Evaluator) whichhas credibility to do so. Every Evaluator will have credibility score (image something similar to Stackoverflow score of user) which will be for a particular technology and if it is more than 1K then evaluator can get task/assignment to approve. When a student submits a task, it needs to get a upvote from at least 5 Evaluator.
> 2 types of Actors:
>
> 1. Student
> 2. Evaluator
>
> Input: ​Task, Technology and Student’s unique number.
> Process/Business rule:​ Approval based on score and technology credibility of the Evaluator.
> Output:​ Technology certificate to Student with approved Mentors along with time stamp.

### Solution

# DSchool
 > Decentralised university/learning system.


### INSTRUCTIONS FOR SETTING-UP  APPLICATION Requirements:
    - [X] NodeJs stable npm latest
    - [X] Truffle stable npm latest
    - [X] Ganache GUI(Recamended) version v2.1.1

### Steps:
    1.Clone & Navigate into main directory
    2.Run "npm install","truffle migrate --reset" and "npm start"
    3.Open Browser & navigate LocalHost- http://localhost:3000 or Ip Address- http://127.0.0.1:3000

> There are three pages in this application

    • Student
       1. Register Student.
       2. View Student.
       3. Task Submission.
    • Evaluater
       1. Register Evaluator.
       2. View Evaluater.
       3. Upvote Tasks.
    • Task
       1. Lists Varifed and UnVarifed Tasks.

