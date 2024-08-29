module DividedRectangles

export optimize

# Structure to store information about each rectangle
struct DirectRectangle
    center::Vector{Float64}  
    value::Float64           
    divisions::Vector{Int}   
    radius::Float64          
end

# Identifies the rectangles to explore further
function get_potentially_optimal_rects(rectangles::Vector{DirectRectangle}, min_radius::Float64)
    optimal_rects = DirectRectangle[]

    # Sorts the rectangles by size and then by function value
    sort!(rectangles, by = r -> (r.radius, r.value))

    for rect in rectangles
        if !isempty(optimal_rects) && rect.radius == optimal_rects[end].radius
            continue  
        end
        if !isempty(optimal_rects) && rect.value <= optimal_rects[end].value
            pop!(optimal_rects)  
        end
        push!(optimal_rects, rect)
    end

    filter!(r -> r.radius >= min_radius, optimal_rects)
    return optimal_rects
end

# Splits the rectangle into smaller pieces
function divide(rect::DirectRectangle, g)
    n = length(rect.center)
    smallest_division = minimum(rect.divisions)
    divisions_copy = copy(rect.divisions)

    smaller_rectangles = DirectRectangle[]
    for i in 1:n
        if rect.divisions[i] == smallest_division
            delta = 3.0^(-smallest_division-1)
            divisions_copy[i] += 1

            new_center1 = rect.center + delta * (i == 1 ? 1.0 : 0.0)
            new_center2 = rect.center - delta * (i == 1 ? 1.0 : 0.0)

            push!(smaller_rectangles, DirectRectangle(new_center1, g(new_center1), copy(divisions_copy), delta))
            push!(smaller_rectangles, DirectRectangle(new_center2, g(new_center2), copy(divisions_copy), delta))
        end
    end

    return smaller_rectangles
end

# Main function that runs the DIRECT optimization algorithm
function optimize(f, a::Vector{Float64}, b::Vector{Float64}; max_iterations::Int = 100, min_radius::Float64 = 1e-5)
    g = x -> f(x .* (b .- a) .+ a)
    n = length(a)
    initial_center = fill(0.5, n)
    initial_rectangle = DirectRectangle(initial_center, g(initial_center), fill(0, n), sqrt(0.5^n))

    rectangles = [initial_rectangle]

    for _ in 1:max_iterations
        optimal_rects = get_potentially_optimal_rects(rectangles, min_radius)
        setdiff!(rectangles, optimal_rects)
        for rect in optimal_rects
            append!(rectangles, divide(rect, g))
        end
    end

    best_rect = rectangles[argmin(r -> r.value, rectangles)]
    return best_rect.center .* (b .- a) .+ a
end

end # End of module
