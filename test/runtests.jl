using MINDFul, Test
using Graphs, AttributeGraphs
using JLD2, UUIDs

const MINDF = MINDFul

## single domain 

# load data
domains_name_graph = first(JLD2.load("data/itz_IowaStatewideFiberMap-itz_Missouri__(1,9)-(2,3),(1,6)-(2,54),(1,1)-(2,21).jld2"))[2]

ag1 = first(domains_name_graph)[2]

ibnag1 = MINDF.default_IBNAttributeGraph(ag1)

# get the node view of a single random vertex
nodeview1 = vertex_attr(ibnag1)[1]
dagnodeid1 = UUID(1)

# # router port LLI
rplli1 = MINDF.RouterPortLLI(1, 2)
@test MINDF.canreserve(MINDF.getrouterview(nodeview1), rplli1)
@test MINDF.reserve!(MINDF.getrouterview(nodeview1), dagnodeid1, rplli1)
# test router reservations
let 
    routerreservations = MINDF.getreservations(MINDF.getrouterview(nodeview1))
    @test length(routerreservations) == 1
    @test first(routerreservations) == (dagnodeid1 => rplli1)
end
@test MINDF.unreserve!(MINDF.getrouterview(nodeview1), dagnodeid1)
@test MINDF.canreserve(MINDF.getrouterview(nodeview1), rplli1)
@test length(MINDF.getreservations(MINDF.getrouterview(nodeview1))) == 0


# # try out transmissionmodule reservation
# transmissionmodulereservationentry1 = MINDF.TransmissionModuleReservationEntry(1, 1, 1, 1)

# @test MINDF.canreserve(nodeview1, transmissionmodulereservationentry1)
# MINDF.reserve!(nodeview1, dagnodeid1, transmissionmodulereservationentry1)
# @test !MINDF.canreserve(nodeview1, transmissionmodulereservationentry1)
# # test transmission module resetvations
# let
#     transmodreservations = MINDF.gettransmissionmodulereservations(nodeview1)
#     @test length(transmodreservations) == 1
#     @test first(transmodreservations) == (dagnodeid1 => transmissionmodulereservationentry1)
# end
# # test router reservations
# let 
#     routerreservations = MINDF.getreservations(MINDF.getrouterview(nodeview1))
#     @test length(routerreservations) == 1
#     @test first(routerreservations) == (dagnodeid1 => 1)
# end
# # test oxc reservations
# let
#     oxcreservations = MINDF.getreservations(MINDF.getoxcview(nodeview1))
#     @test length(oxcreservations) == 1
#     @test first(oxcreservations) == (dagnodeid1 => MINDF.OXCSwitchReservationEntry(0,1,0,0:0))
# end

# MINDF.unreserve!(nodeview1, dagnodeid1)
# @test MINDF.canreserve(nodeview1, transmissionmodulereservationentry1)
# # test all reservations are empty
# @test isempty(MINDF.gettransmissionmodulereservations(nodeview1))
# @test isempty(MINDF.getreservations(MINDF.getrouterview(nodeview1)))
# @test isempty(MINDF.getreservations(MINDF.getoxcview(nodeview1)))


# # still remains to develop/test 
# # - transmission modes
# # - OXCSwitchReservationEntries for spectrum slots and nodes
