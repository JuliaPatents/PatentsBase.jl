fams = [
    DummyFamily([
        DummyApplication(
            DummyID("app1"),
            Date(2000,1,1),
            []
        ),
        DummyApplication(
            DummyID("app2"),
            Date(2001,1,1),
            [DummyCitation("app1"), DummyCitation("app3")]
        ),
        DummyApplication(
            DummyID("app3"),
            Date(2001,5,30),
            [DummyCitation("app1"), DummyCitation("app2"), DummyCitation("app4")]
        )
    ]),
    DummyFamily([
        DummyApplication(
            DummyID("app4"),
            Date(2003,1,1),
            [DummyCitation("app1"), DummyCitation("app1003")]
        )
    ]),
    DummyFamily([
        DummyApplication(
            DummyID("app5"),
            Date(2005,1,1),
            [DummyCitation("app1")]
        ),
        DummyApplication(
            DummyID("app6"),
            Date(2005,1,15),
            [DummyCitation("app4")]
        ),
    ]),
]

@testset "citation graph (applications)" begin

    graph = citationgraph(applications(fams[1]))

    @test ne(graph) == 3
    @test has_edge(graph, 1, 2)
    @test has_edge(graph, 1, 3)
    @test has_edge(graph, 2, 3)

end

@testset "citation graph (families)" begin

    graph = citationgraph(fams)

    @test ne(graph) == 3
    @test has_edge(graph, 1, 2)
    @test has_edge(graph, 1, 3)
    @test has_edge(graph, 2, 3)
end
