// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    uint public taskCount;

    struct Task {
        uint id;
        string content;
        bool completed;
        address creator;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(uint indexed id, string content, address indexed creator);
    event TaskToggled(uint indexed id, bool completed);

    constructor() {
        createTask("Welcome to the Blockchain Todo List");
    }

    function createTask(string memory _content) public {
        require(bytes(_content).length > 0, "Content cannot be empty");

        taskCount++;
        tasks[taskCount] = Task({
            id: taskCount,
            content: _content,
            completed: false,
            creator: msg.sender
        });

        emit TaskCreated(taskCount, _content, msg.sender);
    }

    function toggleCompleted(uint _id) public {
        Task storage task = tasks[_id];
        require(task.creator == msg.sender, "Not your task");
        task.completed = !task.completed;

        emit TaskToggled(_id, task.completed);
    }

    function getTask(uint _id) public view returns (Task memory) {
        return tasks[_id];
    }
}
