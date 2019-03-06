require_relative '../app/models/Student.rb'

describe Student do
  let (:adam) {Student.create(full_name: 'Adam Moran', pin_number: '06211989'.to_i)}

  it "Student should have a name" do
    expect(adam.full_name).to(eq('Adam Moran'))
  end
end
