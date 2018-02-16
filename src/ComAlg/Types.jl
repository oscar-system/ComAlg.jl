mutable struct MPolyIdlSet{T <: MPolyElem{ <: RingElem}}
  R::MPolyRing{T}
  function MPolyIdlSet{T}(R::MPolyRing{T})
    return new(R)
  end
end

function show(io::IO, I::MPolyIdlSet)
  println(io, "Set of ideals of $(I.R)\n")
end

mutable struct MPolyIdl{T <: MPolyElem{ <:RingElem}}
  gens::Array{T, 1} # initial generators
  parent::MPolyRing{T}
  std::Array{T, 1} # a Groebner basis is known/ computed
  ishomogenous::Bool
  hilbert::Any #PowerSeries

  function MPolyIdl{T}(gens::Array{T, 1})
    r = new()
    r.gens = gens
    return r
  end
end

function show(io::IO, I::MPolyIdl)
  println(io, "ideal in $(I.parent.R), generated by $(I.gens)\n")
end


######################################################################
mutable struct ModField{T <: Nemo.FieldElem}
  ring::Nemo.Field
  dim::Int

  function ModField(R, n::Int) 
    r = new()
    r.ring = R
    r.dim = n
    return r
  end
end

function Base.show{T}(io::IO, M::ModField{T})
  println(io, "free module of rank $(M.dim) over $(M.ring)\n")
end

mutable struct ModFieldElem{T <: Nemo.FieldElem}
  coeff::Array{T, 1} # TODO: figure out how to declare a matrix...
  parent::ModField{T}

  function ModFieldElem{T}(M::ModField, c::Array{T, 1})
    r = new()
    r.parent = M
    r.coeff = c
    return r
  end
end

function Base.show(io::IO, x::ModFieldElem)
  println(io, x)
end


mutable struct ModFieldToModFieldMor{T <: Nemo.FieldElem} <: Map{ModField, ModField}
  header::Hecke.MapHeader
  map::MatElem{T}

  function ModFieldToModFieldMor(M::ModField, N::ModField, map::MatElem{T})
    r = new()
    r.header = Hecke.MapHeader(M, N)
    r.map = map
    return r
  end
end


#############################################################
# same again for Euc, ModDed
# and
# Subquo....