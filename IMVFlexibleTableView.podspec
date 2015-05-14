Pod::Spec.new do |s|  
  s.name             = "IMVFlexibleTableView"  
  s.version          = "0.0.4"  
  s.summary          = "a PullRefreshTable which can custom refresh style." 
 


  s.homepage         = "https://github.com/inmovation/IMVFlexibleTableView"  
  
  s.license          = 'MIT'  
  s.author           = { "Creolophus" => "civilian0304@gmail.com" }  
  s.source           = { :git => "https://github.com/inmovation/IMVFlexibleTableView.git", :tag => s.version.to_s }  

  
  s.platform     = :ios, '5.0'  
  

  s.requires_arc = true  
  
  s.source_files = 'IMVFlexibleTableView/*'  

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'  
  
end  
