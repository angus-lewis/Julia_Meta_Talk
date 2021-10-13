x = 0.0
w = x
for n in 1:3
    w += n
end

expr = quote 
    y = x 
    for n in 1:3
        y+=n
    end
end
println(eval(expr))

begin 
    z = x
    for n in 1:3
        z += n
    end
end




println(x)
println(y)
println(z)
println(w)