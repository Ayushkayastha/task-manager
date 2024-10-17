
const { default: mongoose } = require('mongoose')
const Task=require('../models/task')

const getAllTasks=async  (req,res)=>{
    try{
        const task= await Task.find({})
        res.status(201).json(task)
    }
    catch(error){
        res.status(500).json({msg:error})
    }
  
}

const createTasks=async  (req,res)=>{
    try{
        const task= await Task.create(req.body)
        res.status(201).json(task)
    }
    catch(error){
        res.status(500).json({msg:error})
    }
  
}

const getTasks=async  (req,res)=>{
    try{
        const taskID = req.params.id;
        const task= await Task.findOne({_id: taskID})
        if(!task)
        {
            res.status(404).json({msg:"no user with this id"+taskID})
        }
        res.status(201).json(task)
    
    }
    catch(error){
        res.status(500).json({msg:error})
    }
  
}


const deleteTasks=async(req,res)=>{
    try{
        const taskID = req.params.id;
        const task=await Task.findOneAndDelete({_id:taskID})
        if(!task)
        {
             return res.status(404).json({msg:"no user with this id"+taskID})
        }
       return res.status(201).json(task)
    }
    catch(error){
        return res.status(500).json({msg:error})
    }
}

const updateTasks= async (req,res)=>{
    try{
        const taskID = req.params.id;
        const Data= req.body;
        const task=await Task.findOneAndUpdate({_id:taskID},req.body,{new: true, runValidators: true})

        if(!task)
        {
            res.status(404).json({msg:"no user with this id"+taskID})
        }
        res.status(201).json(task)
        }
    catch(error){
        res.status(500).json({msg:error})
    }
}


module.exports={
    getAllTasks,
    createTasks,
    getTasks,
    updateTasks,
    deleteTasks,
    }