"""
$(TYPEDSIGNATURES)

Add a new user intent to the IBN framework.
"""
function addintent!(ibnf::IBNFramework, intent::AbstractIntent, intentissuer::IntentIssuer)
    intentdag = getidag(ibnf)
    addidagnode!(intentdag, intent; intentissuer)
end

"""
$(TYPEDSIGNATURES)
"""
function removeintent!(ibnf::IBNFramework, idagnodeid::UUID; verbose::Bool=false)
    intentdag = getidag(ibnf)
    intentdagstate = getidagnodestate(intentdag, idagnodeid)
    @returniffalse(verbose, intentdagstate == IntentState.Uncompiled)
    return removeidagnode!(intentdag, idagnodeid)
end

"""
$(TYPEDSIGNATURES)
"""
function compileintent!(ibnf::IBNFramework, idagnodeid::UUID, algorithm::IntentCompilationAlgorithm)
    intent = getidagnode(getidag(ibnf), UUID(1))
    return compileintent!(ibnf, intent, algorithm)
end

"""
$(TYPEDSIGNATURES)
"""
function uncompileintent!(ibnf::IBNFramework, idagnodeid::UUID)
end

"""
$(TYPEDSIGNATURES)
"""
function installintent!(ibnfid::IBNFramework, idagnodeid::UUID)
end

"""
$(TYPEDSIGNATURES)
"""
function uninstallintent!(ibnfid::IBNFramework, idagnodeid::UUID)
end

"""
$(TYPEDSIGNATURES)

Get spectrum availabilities along a `path` of nodes
"""
function getpathspectrumavailabilities(ibnf::IBNFramework, localnodespath::Vector{LocalNode})
    nothing
end

"""
$(TYPEDSIGNATURES)

Get the spectrum availability slots vector for `edge`
"""
function getfiberspectrumavailabilities(ibnf, edge::Edge{LocalNode}; checkfirst::Bool=true)
    nodeviews = AG.vertex_attr(getibnag(ibnf))
    if checkfirst
        @assert(
            getlinkspectrumavailabilities(getoxcview(nodeviews[src(edge)]))[edge] ==
            getlinkspectrumavailabilities(getoxcview(nodeviews[dst(edge)]))[edge]
        )
    end
    return getlinkspectrumavailabilities(getoxcview(nodeviews[src(edge)]))[edge]
end

"""
$(TYPEDSIGNATURES)

Get the spectrum availability slots vector for `edge`
"""
function getfiberspectrumavailabilities2(ibnf, edge::Edge{LocalNode}, c::Int; checkfirst::Bool=true)
    nodeviews = AG.vertex_attr(getibnag(ibnf))
    if c == 1
        return getlinkspectrumavailabilities(getoxcview(nodeviews[src(edge)]))[edge]
    elseif c ==2 
        return getlinkspectrumavailabilities(getoxcview(nodeviews[dst(edge)]))[edge]
    end
end
