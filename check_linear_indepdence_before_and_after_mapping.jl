using LinearAlgebra
# Linear Independence
# A list of vectors v1, v2, ..., vn is linearly independent if the only
# solution to a1*v1 + a2*v2 + ... + an*vn = 0 is a1 = a2 = ... = an = 0.

"""
Theorem: if we do a mapping and the result is linearly independent, the origian list of vectors has got to be linearly independent as well..

Testing this out here. Proof is in Axler.
"""
function is_linear_independent( vectors... )
    # build a linear transform
    T = hcat(vectors...)
    nullSpace = nullspace(T)
    if ( iszero(nullSpace) )
        return true
    else
        return false
    end 
end


#theorem 
#maps that end up with image vectors as linearly independent, always have original vectors also as linearly independent 
function apply_map(A)
    return v -> A * v
end

newMap1 = rand(-10:10, 3,3) # a 3x3 matrix/map made up of random numbers between -10 and 10


v1 = [1,2,3]
v2 = [2,4,6]
v3 = [0,0,1]

#find their image in the new space, also R3
applyNewMap1 = apply_map(newMap1)
v1_ = applyNewMap1(v1)
v2_ = applyNewMap1(v2)
v3_ = applyNewMap1(v3)

println("**********:")
println("U ---transforms_into----> W" )
println("linear indepdence of image:")
println(is_linear_independent(v1_,v2_,v3_))
println("linear independence of original:")
println(is_linear_independent(v1,v2,v3))

####################################--
println("**********:")

v1 = [0,0,1]
v2 = [1,0,0]
v3 = [0,1,0]

print("attempting on $([v1 , v2, v3])")
#find their image in the new space, also R3
applyNewMap1 = apply_map(newMap1)
v1_ = applyNewMap1(v1)
v2_ = applyNewMap1(v2)
v3_ = applyNewMap1(v3)

println("U ---transforms_into----> W" )
println("linear indepdence of image:")
println(is_linear_independent(v1_,v2_,v3_))
println("linear independence of original:")
println(is_linear_independent(v1,v2,v3))


####################################--
println("**********:")

v1 = [0,0,1]
v2 = [1,0,0]
v3 = [0,1,0]

print("attempting to map $([v1 , v2, v3]) to [0,0,0] [0,0,0], [0,0,0]")

newMap2 = rand(0:0, 3,3)

applyNewMap2 = apply_map(newMap2)
v1_ = applyNewMap2(v1)
v2_ = applyNewMap2(v2)
v3_ = applyNewMap2(v3)

println("U ---transforms_into----> W" )
println("linear indepdence of image:")
println(is_linear_independent(v1_,v2_,v3_))
println("linear independence of original:")
println(is_linear_independent(v1,v2,v3))



""" 

output:

**********:
U ---transforms_into----> W
linear indepdence of the image:
false
linear independence of original:
false
**********:

U ---transforms_into----> W

attempting to map on [[0, 0, 1], [1, 0, 0], [0, 1, 0]]

linear indepdence of image:
true

linear independence of original:
true
**********:

U ---transforms_into----> W

attempting to map [[0, 0, 1], [1, 0, 0], [0, 1, 0]] via map [0,0,0] [0,0,0], [0,0,0]


linear indepdence of image:
false
linear independence of original:
true
"""

 









