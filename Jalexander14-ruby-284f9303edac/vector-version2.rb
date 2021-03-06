#!/usr/bin/ruby

class Vector

  # create accessor methods
  attr :x
  attr :y
  attr :z

  # like a constructor --- create a vector
  def initialize x, y, z 
    @x = x
    @y = y
    @z = z
  end

  # add another vector to this vector
  # result is a new vector --- the sum
  def add v
    Vector.new @x + v.x, @y + v.y, @z + v.z
  end

  # subtract another vector from this vector
  # result is a new vector --- the difference
  def subtract v
    Vector.new @x - v.x, @y - v.y, @z - v.z
  end

  # create a new vector that has the same direction
  # as this vector but a different length
  def scale factor
    Vector.new factor * @x, factor * @y, factor * @z
  end

  # compute the dot product of this vector with
  # another vector
  def dot v 
    @x * v.x + @y * v.y + @z * v.z
  end

  # compute the length (magnitude) of this vector
  def magnitude
    Math.sqrt self.dot self
  end

  # create a new vector that has the same direction
  # as this vector but a length of one
  def normalize
    mag = self.magnitude
    Vector.new @x/mag, @y/mag, @z/mag
  end

  # compute the cross product of this vector with
  # another vector
  def cross v
    x = @y * v.z - @z * v.y
    y = @z * v.x - @x * v.z
    z = @x * v.y - @y * v.x
    Vector.new x, y, z
  end

  # produce a printable representation of this vector
  def to_s
    "(" + x.to_s + "," + y.to_s + "," + z.to_s + ")"
  end

end

class Line

  # create accessor methods
  attr :head
  attr :tail

  # like a constructor --- create a line
  def initialize head, tail
    @head = head
    @tail = tail
  end

  # create a vector that points from
  # the tail to the head of this line
  def vector
    head.subtract tail
  end

  # compute the length of this line
  def length
    self.vector.magnitude
  end

  # produce a vector of length one
  # that points from the tail toward the head
  def direction
    self.vector.normalize
  end

  # find the midpoint of this line
  def midpoint 
    (@head.add @tail).scale 0.5
  end

  # create a string that describes this
  # line in the SVG (Scalable Vector Graphics)
  # language
  def svg
    '<line x1= "' + @head.x.to_s + '" ' + 
    'y1= "' + @head.y.to_s + '" ' +
    'x2= "' + @tail.x.to_s + '" ' +
    'y2= "' + @tail.y.to_s + '" ' +
    "\n\t" +
    'style="stroke:rgb(0,0,0);stroke-width:2"/>'
  end

end

class Triangle
  # create accessor methods
  attr :a
  attr :b
  attr :c

  # like a constructor --- create a Triangle
  def initialize a, b, c
    @a = a
    @b = b
    @c = c
  end

  # create a unit vector that is
  # perpendicular to this triangle
  def normal
    u = (b.subtract a).normalize
    v = (b.subtract c).normalize
    (u.cross v).normalize
  end

  # divide this triangle into four smaller triangles
  # result is an array that contains the 4 smaller triangles
  def subdivide
    #ab = (midpoint a, b).normalize
    #bc = (midpoint b, c).normalize
    #ca = (midpoint c, a).normalize
    ab = (Line.new a, b).midpoint.normalize
    bc = (Line.new b, c).midpoint.normalize
    ca = (Line.new c, a).midpoint.normalize
    smallerTriangles = Array.new
    smallerTriangles << (Triangle.new a, ab, ca)
    smallerTriangles << (Triangle.new ab, b, bc)
    smallerTriangles << (Triangle.new bc, c, ca)
    smallerTriangles << (Triangle.new ab, bc, ca)
  end

  # describe this triangle in the 
  # SVG (Scalable Vector Graphics) language
  def svg radius, illumination
    translation = Vector.new radius, radius, 0
    p0 = (@a.scale radius).add translation
    p1 = (@b.scale radius).add translation
    p2 = (@c.scale radius).add translation

    p01 = Line.new p0, p1
    p12 = Line.new p1, p2
    p20 = Line.new p2, p0

    r1 = Integer(rand(255))
    g1 = Integer(rand(255))
    b1 = Integer(rand(255))

    r2 = Integer(rand(255))
    g2 = Integer(rand(255))
    b2 = Integer(rand(255))

    r3 = Integer(rand(255))
    g3 = Integer(rand(255))
    b3 = Integer(rand(255))

    '<polygon points = "' + 
    Integer(p0.x).to_s + "," + Integer(p0.y).to_s + " " +
    Integer(p1.x).to_s + "," + Integer(p1.y).to_s + " " +
    Integer(p2.x).to_s + "," + Integer(p2.y).to_s + 

    '">' + "\n" +
    '   <animate id="a1" attributeName="fill"' + "\n" +
    '            attributeType="HTML"' + "\n" +
    '            from="rgb(' +
    r1.to_s + "," + g1.to_s + "," + b1.to_s + ')"' + "\n" +
    '            to="rgb(' +
    r2.to_s + "," + g2.to_s + "," + b2.to_s + ')"' + "\n" +
    '            dur="3s"' + "\n" +
    '            begin="0s; a3.end"/>' + "\n" +
    '   <animate id="a2" attributeName="fill"' + "\n" +
    '            attributeType="HTML"' + "\n" +
    '            from="rgb(' +
    r2.to_s + "," + g2.to_s + "," + b2.to_s + ')"' + "\n" +
    '            to="rgb(' +
    r3.to_s + "," + g3.to_s + "," + b3.to_s + ')"' + "\n" +
    '            dur="3s"' + "\n" +
    '            begin="a1.end"/>' + "\n" +
    '   <animate id="a3" attributeName="fill"' + "\n" +
    '            attributeType="HTML"' + "\n" +
    '            from="rgb(' +
    r3.to_s + "," + g3.to_s + "," + b3.to_s + ')"' + "\n" +
    '            to="rgb(' +
    r1.to_s + "," + g1.to_s + "," + b1.to_s + ')"' + "\n" +
    '            dur="3s"' + "\n" +
    '            begin="a2.end"/>' + "\n" +
    '</polygon>' + "\n" + "\n"
  end

  private

  # find the midpoint of an edge
  # (u and v are vectors that point
  # to the edge's endpoints)
  #def midpoint u, v
  #  (u.add v).scale 0.5
  #end

end

class Polyhedron
  # create accessor methods
  attr :faces

  # like a constructor --- create a polyhedron
  def initialize
    # create 4 faces of an octahedron that
    # lie on the near side of the x-y plane.

    north = Vector.new 0.0, 1.0, 0.0
    east = Vector.new 1.0, 0.0, 0.0
    south = Vector.new 0.0, -1.0, 0.0
    west = Vector.new -1.0, 0.0, 0.0
    near = Vector.new 0.0, 0.0, 1.0

    northeast = Triangle.new north, east, near
    southeast = Triangle.new east, south, near
    southwest = Triangle.new near, south, west
    northwest = Triangle.new north, near, west

    @faces = [northeast, southeast, southwest, northwest] 
  end

  # divide each triangular face of this polyhedron into
  # four smaller triangular faces
  def subdivide
    smallerFaces = Array.new

    @faces.each { |t| smallerFaces.concat t.subdivide }

    @faces = smallerFaces
  end

  # produce a description of this polyhedron
  # in the HTML (HyperText Markup Language)
  # and SVG (Scaleable Vector Graphics) languages.
  # The result may be displayed with a Web browser.
  def html
    radius = 256 

    illumination = Vector.new 1, 2, 3
    illumination = illumination.normalize
    polys = String.new
    @faces.each { |t| polys << (t.svg radius/2, illumination) << "\n" }

    "<html>" + "\n" +
    "<body>" + "\n" +
    "<h1>A Polyhedron</h1>" + "\n" +

    '<svg xmlns="http://www.w3.org/2000/svg"' + "\n" +
    'version="1.1" height="' + (2 * radius).to_s +
      '" width="' + (2 * radius).to_s + '">' + "\n" +
    # Embedded javascript function not used, was intended for true randomnise
    '<script type="text/javascript">' + "\n" + 
    '   function() {' + "\n" +
    '      return Math.random() * 255; }' + "\n" +
    '</script>' + "\n" +

    polys + "\n" +

    "</svg>" + "\n" + 
    "</body>" + "\n" + 
    "</html>"  
  end

end

# Create a polyhedron.
p = Polyhedron.new

# Subdivide the faces.
# (Repeat this next statement 1, 2, or more times.)
p.subdivide
p.subdivide
p.subdivide
p.subdivide
# p.subdivide

# Output the HTML and SVG.
# Redirect this output into a file,
# then open the file with a Web browser.
out_file = File.new("vector_rb-results2.html", "w")
out_file.puts(p.html)

system("firefox vector_rb-results2.html")








