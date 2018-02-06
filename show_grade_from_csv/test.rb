require 'csv'    
def show_each_term(file_name)
    #NO., year, term, code, name, credit, grade, point
    puts "Show grade each term"
    year = 0
    term = 1
    haveGrade = true
    creditTemp=0
    pointTemp=0
    #find least year
    CSV.foreach(file_name) do |row|
        if year > row[1].to_i and row[1].to_i>2500 or year.zero? then
           year = row[1].to_i
        end
    end
    #calculate grade each year
    while(haveGrade) do
        haveGrade = false
        creditTemp=0
        pointTemp=0
        CSV.foreach(file_name) do |row|
            if year==row[1].to_i and term==row[2].to_i then 
                haveGrade = true
                creditTemp += row[5].to_i
                pointTemp += row[5].to_i*row[7].to_f
            end
        end   
        next if !haveGrade
            
        print " year ",year,"  term ",term,"  grade : ",(pointTemp/creditTemp*100).to_i/100.0,"\n"
            
        #update year and term
        term == 1 ? (term=2):(term=1 and year+=1)    
    end    
end

def show_all_term(file_name)
    check = false
    credit = 0
    point = 0
    r7=0
    #NO., year, term, code, name, credit, grade, point
    CSV.foreach(file_name) do |row|
        if row[0]=="0" then check = true end
        if check then
            credit += row[5].to_i
            point += row[5].to_i*row[7].to_f
        end
                
    end   
    print "Grade all term = ",(point/credit*100).to_i/100.0,"\n"
end

show_each_term("grade.csv")
show_all_term("grade.csv")