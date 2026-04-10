### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

begin
    using Plots

    t_vals = range(0, π, length=100)

    anim = Animation()

    for t in t_vals

        # always use same initial guess (simple + works)
        q = solve_position(t; initial_guess=[0.05, 0.05, 0.0, 0.0, 0.0])

        s1, s2, x3, y3, θ3 = q

        x1 = s1*cos(θ1)
        y1 = s1*sin(θ1)

        x2 = s2*cos(θ2)
        y2 = s2*sin(θ2)

        xB1 = x3 - (L/2)*cos(θ3)
        yB1 = y3 - (L/2)*sin(θ3)

        xB2 = x3 + (L/2)*cos(θ3)
        yB2 = y3 + (L/2)*sin(θ3)

        p = plot(
            xlim=(-0.12, 0.12),
            ylim=(-0.12, 0.12),
            aspect_ratio=:equal,
            legend=false,
            title="Dual-Slider Motion",
            xlabel="x [m]",
            ylabel="y [m]"
        )

        plot!(p, [-0.12, 0.12], [-0.12, 0.12], linestyle=:dash)
        plot!(p, [-0.12, 0.12], [0.12, -0.12], linestyle=:dash)
        plot!(p, [xB1, xB2], [yB1, yB2], linewidth=4)
        scatter!(p, [x1, x2], [y1, y2], markersize=6)
        scatter!(p, [x3], [y3], markersize=4)

        frame(anim, p)
    end

    gif(anim, "motion.gif", fps=20)
end
