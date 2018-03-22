using Gadfly, DataFrames

σ(a, γ) = a * (1-a^2) / (1 + a^2 - 2*a*cos(γ))^(3/2)
coord(γ) = map(x -> σ(1/x,γ), 2:4)

function main()

	γ0 = 0:0.01:π

	f1, f2, f3 = map(i -> map(x -> x[i], map(coord, γ0)), 1:3)

	df1 = DataFrame(γ=collect(γ0),y=f1,index=repeat(["y/a=2"], inner=[315]))
	df2 = DataFrame(γ=collect(γ0),y=f2,index=repeat(["y/a=3"], inner=[315]))
	df3 = DataFrame(γ=collect(γ0),y=f3,index=repeat(["y/a=4"], inner=[315]))

	pl = plot(
		layer(df1, x=:γ, y=:y, color=:index, Geom.line),
		layer(df2, x=:γ, y=:y, color=:index, Geom.line),
		layer(df3, x=:γ, y=:y, color=:index, Geom.line),
		Guide.title("Surface Charge Density"),
		Guide.xlabel("γ"), Guide.ylabel("-4πa^2σ/q")
		  )
	draw(SVG("HW1.svg", 1000px, 600px), pl);
	run(`inkscape -z HW1.svg -e HW1.png -d 300 --export-background=WHITE`)
end

main()
