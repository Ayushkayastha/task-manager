
const express=require('express')
const app=express()
const tasks=require('./routes/task')
const connectDb=require('./db/connect')
require('dotenv').config()
const port=3000

app.use(express.static('./public'))
app.use(express.json())







app.use('/api/v1/tasks',tasks)
 
const start= async ()=>{
    try{
        await connectDb(process.env.MONGO_URI)
        app.listen(port,
            console.log('the port is running on port '+ port)
        )
    }
    catch(error){
        console.log(error)
    }
}

start()