describe("Pipeline", function(){
    it("should return js object from json", function(){
        var json = {
            name: "test",
            lastBuildStatus: "Success",
            stages: [{
                name: "subtest",
                lastBuildStatus: "Failure",
                stages: []
            }]
        };
        var pipeline = new Pipeline(json);
        expect(pipeline.name).toBe("test");
        expect(pipeline.status).toBe("Success");
        expect(pipeline.stages[0].name).toBe("subtest");
        expect(pipeline.stages[0].status).toBe("Failure");
    });
});