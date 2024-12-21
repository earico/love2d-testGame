-- global helper functions to be used in other classes
function Collision(a, b)
    return (
    a.x - a.size / 2 < b.x + b.size / 2 and
    a.x + a.size / 2 > b.x - b.size / 2 and
    a.y - a.size / 2 < b.y + b.size / 2 and
    a.y + a.size / 2 > b.y - b.size / 2
  )
end

function CollisionResponse(a, b)

end