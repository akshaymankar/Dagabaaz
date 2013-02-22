Pipeline = function(json){
    this.name = json.name
    this.status = json.lastBuildStatus
    this.stages = []
    for(var i=0; i < json.stages.length; i++){
        this.stages[i] = new Pipeline(json.stages[i])
    }
}