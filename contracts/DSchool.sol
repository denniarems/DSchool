pragma solidity ^0.5.12;

contract DSchool {
    // Structure of Student
    struct Student {
        uint stdId;
        string name;
        uint age;
    }
    // Structure of Approver
    struct Approver{
        uint approverId;
        string name;
        string skill;
        uint skillRank;
    }
    // Structure of Task
    struct Task{
        string name;
        string tech;
        uint stdId;
        address student;
        uint[] approvers;
        uint approvedTime;
        bool valid;
    }
    // nested mapping for approver to check whether he is voted already 
    mapping (address => mapping (uint => bool)) public approvedList;
    // mapping for Students by Address 
    mapping (address => Student) Std;
    // mapping for Address by Address 
    mapping (address => Approver) Evaluator;
    // Assignments Array  
    Task[] public Assignments ;
    // to create unique ids for student and approver
    uint public CurrentStdId = 0;
    uint public CurrentEvaId = 0;
    

    //Rules for Doing Operations
    modifier userRegister(uint number) {
        if(number == 0){
            require(Evaluator[msg.sender].approverId == 0,"Evaluator Can't be Student");
            require(Std[msg.sender].stdId == 0,"Already Registered");
        }else{
            require(Std[msg.sender].stdId == 0,"Student Can't be Evaluator");
            require(Evaluator[msg.sender].approverId == 0,"Already Registered");
        }
        _;
    }
    modifier onlyStudent() {
        require(Evaluator[msg.sender].approverId == 0,"Must be Student");
        require(Std[msg.sender].stdId > 0,"Student Must Registered");
        _;
    }
    modifier onlyApprover() {
        require(Std[msg.sender].stdId == 0,"Must be Evaluator");
        require(Evaluator[msg.sender].approverId > 0,"Evaluator Must Registered");
        _;
    }
    modifier eligibility(uint _position) {
        require( keccak256(abi.encodePacked(Assignments[_position].tech)) ==  keccak256(abi.encodePacked(Evaluator[msg.sender].skill)),"You Don't Know , What Tech it is ");
        require( Evaluator[msg.sender].skillRank > 1000,"Need credibility Score More than 1000 ");
        // require(Assignments[_position].valid == false, "Approval limit reached!"); 
        require(approvedList[msg.sender][_position] == false, "You have already approved this assignment!");
        _;
    }
    // Register a Student
    function setStudent( string memory _name, uint _age) public userRegister(0)  {
        CurrentStdId++;
        Std[msg.sender] = Student(CurrentStdId,_name, _age);
    }

    // View a Student
    function getStudent() public view returns (uint _stdId,string memory _name, uint _age){
        _stdId = Std[msg.sender].stdId;
        _name = Std[msg.sender].name;
        _age = Std[msg.sender].age;
    }
    // Register a Approver
    function setApprover(string memory _name,string memory _skill, uint _skillRank) public userRegister(1) {
        CurrentEvaId++;
        Evaluator[msg.sender] = Approver(CurrentEvaId,_name, _skill,_skillRank);
    }
    // View a Approver
    function getApprover() public view returns (uint _evaId,string memory _name,string memory _skill, uint _skillRank){
        _evaId = Evaluator[msg.sender].approverId;
        _name = Evaluator[msg.sender].name;
        _skill = Evaluator[msg.sender].skill;
        _skillRank = Evaluator[msg.sender].skillRank;
    }
    // Project Submission
    function taskSubmission(string memory _name,string memory _tech) public onlyStudent{
        Task memory task;
        task.name = _name;
        task.tech = _tech;
        task.stdId = Std[msg.sender].stdId;
        task.student = msg.sender;
        task.approvers;
        task.approvedTime = 0;
        task.valid = false;
        Assignments.push(task);
   
    }
    //Voting
    function Upvoting(uint _position) public onlyApprover eligibility(_position) returns (bool) {
        // uint counter = Assignments[_position].approveCount;
        uint evalId = Evaluator[msg.sender].approverId;
        Assignments[_position].approvers.push(evalId);
        approvedList[msg.sender][_position] = true;
        if(Assignments[_position].approvers.length == 5){
            Assignments[_position].valid = true;
            Assignments[_position].approvedTime = now;
        }
        return approvedList[msg.sender][_position];
    }

    // To view Total Assignments
    function TotalTasks() public view returns(uint _total) {
        return Assignments.length;
    }
    // To view a Assignment
    function viewAssignment (uint _position) public view  returns (string memory _name,string memory _tech,uint _stdId,uint[] memory _approvers,uint _time,bool _valid){
        return(Assignments[_position].name,Assignments[_position].tech,Assignments[_position].stdId,Assignments[_position].approvers,Assignments[_position].approvedTime,Assignments[_position].valid);
    }
}
