using LinearAlgebra
using Random
using Symbolics

# --- Define your maps here ---

# T should take a vector and return a vector
function T(v; b=0, c=0)
    # TODO: implement the map T(x,y,z) = (2x - 4y + 3z + b, 6x + cxyz)
    x = v[1]
    y = v[2]
    z = v[3]
    return [2*x - 4*y + 3*z + b, 6*x + (c * x * y * z)] 
end

# --- Numerical check (random vectors) ---
# Check if a map is linear by testing additivity and homogeneity
function is_linear_numerical(map; num_tests=100, tol=1e-10)
    # TODO: generate random vectors and scalars
    # TODO: test additivity:   map(v1 + v2) ≈ map(v1) + map(v2)
    # TODO: test homogeneity:  map(λ * v) ≈ λ * map(v)    
    for i = 1:num_tests
        randomV1 = [rand(-1000:1000), rand(-1000:1000), rand(-1000:1000)]
        randomV2 = [rand(-1000:1000), rand(-1000:1000), rand(-1000:1000)]
    
        leftCommute = map(randomV1 + randomV2)
        rightCommute = map(randomV1) + map(randomV2)

        #homegeneity:
        lam = rand(-1000:1000)
        leftHomogen = map( lam * randomV1)
        rightHomogen = lam * map(randomV1)

        if ((leftCommute != rightCommute) || (leftHomogen !=rightHomogen))
            return false
        end
    end

    return true
end


map1 =  v -> T(v; b=10, c=10) #should be non-linear
map2 = v -> T(v; b=0, c = 0) # should be linear

#println( is_linear_numerical(map1))
#println( is_linear_numerical(map2))


# --- Symbolic check (proof) ---
# Check if a map is linear by testing additivity and homogeneity
# symbolically. Returns the simplified residuals so you can see
# exactly what breaks linearity.
function is_linear_symbolic(map, n_in)
    #  create symbolic variables for v1, v2, and λ
    #   use @variables x1, x2, ...  or use Symbolics.variable(:x, i)
    #  compute additivity residual:   simplify.(map(v1 + v2) - (map(v1) + map(v2)))
    # compute homogeneity residual:  simplify.(map(λ * v) - λ * map(v))
    #  return whether both residuals are zero, and the residuals themselvesi
    
    @variables x1 x2 x3 y1 y2 y3 lam
    leftCommute  = map( [x1, x2, x3] + [y1, y2,y3])
    rightCommute = map([x1, x2, x3]) + map([y1, y2, y3])
    
    vector1 = [x1, x2, x3]
    homogeneityTest = simplify.(expand.(map(lam * vector1) - (lam* map(vector1))))
    additivityTest = simplify.(leftCommute - rightCommute)
    if (iszero(additivityTest) && iszero(homogeneityTest)) 
        return true
    end    
    return false
end

map3 =  v -> T(v; b=10, c=10) #should be non-linear
map4 = v -> T(v; b=0, c = 0) # should be linear
println( is_linear_symbolic(map3, 0))
println( is_linear_symbolic(map4, 0 ))

# --- Matrix extraction ---

# Extract the matrix representation of a linear map
# by applying it to standard basis vectors
function extract_matrix(map, n_in, n_out)
    # TODO: build the matrix column by column using basis vectors e1, e2, ...
end

