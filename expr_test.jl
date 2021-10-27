macro mymac(x)
    @show x
    y = 1+x
    @show y
    return :($x+$y)
end

expr = quote 
    @show 3.0
    y = 1+3.0
    @show y
    3.0+y
end

fun(z) = z + @mymac(3.0)
gun(z) = begin 
    @show 3.0
    y = 1+3.0
    @show y
    z + 3.0+y
end 
hun(z) = z + eval(expr)
@code_lowered fun(1)
@code_lowered gun(1)
@code_lowered hun(1)
c = 0
@macroexpand @mymac(0)

function my_show(expr)
    val = eval(expr)
    print(string(expr)*" = ",val)
end

x=1
y=2
my_show(:(z=x+y))

expr = quote 
    a::Int
    b::Float64
end
st = quote 
    struct MyT2
        a::Int
    end
end
Meta.show_sexpr(st)

macro add_generic_fields()
    return esc(quote
        one_field::Int
        another::Int
        yet_another::Float64
        a::Vector
        b::Vector
        f::Function
    end)
end

struct Mt6
    @add_generic_fields()
end

macro def(name, definition)
    return quote
        macro $(esc(name))()
            esc($(Expr(:quote, definition)))
        end
    end
end

@macroexpand @def(hi, a::Int)
@def(hi, a::Int)
@macroexpand @hi 
struct MT4
    @hi
end