# Elaine M. Wright
# Micro 475 Final Project 

# Load required libraries
library(devtools)
library(shiny)
library(specanalysis)

# Define UI for application that chooses two files to upload
if (interactive()) {
  
ui <- fluidPage(
  
  # Title panel ----
  titlePanel("Specanalysis"),
  
  # Display elements in a vertical fashion
  verticalLayout(
    
    # Set working directory FIRST
    a(textInput("path",
                label = "Enter Working Directory",
                placeholder = "C:\\...")
    ),
    
    # Create first file upload for standards
    a(fileInput("file1", 
                label = "Choose Standards File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv"),
                buttonLabel = "Upload")
      ),
      
    # Create second file upload for samples
    a(fileInput("file2", 
                label = "Choose Samples File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv"),
                buttonLabel = "Upload"),
      
      # Action Button for User to Click to Display Plot 
      a(actionButton("createplot", "Create Plot"))
      ),
    
    tags$hr(),
    a(checkboxInput("header", "Header", TRUE)
      ),
    
    
    mainPanel(
      tableOutput("contents")
      )
    ) # End of vertical layout
  )


# Define server logic required to upload file
server <- function(input, output) {
  
  # After the user selects and uploads their sample file, 
  # it will be shown as a data frame.
  # The function specifically chooses to pull "file2" because
  # "file2" is the Samples file, which is the one the user will want a 
  # preview of the data frame for. A preview of the data frame for "file1" 
  # or the standards file is not necessary or requested by the user.
    output$contents <- renderTable({
    inFile1 <- input$file1
    inFile2 <- input$file2
    
    # Indicates to the user that no data
    # is present if they have forgotten to upload one of their files
    if (is.null(inFile2))
      return(NULL)
    if (is.null(inFile1))
      return(NULL)
    
    # Reads the csv and assign it to an object
    stds <- read.csv(inFile1$datapath, header = input$header)
    samples <- read.csv(inFile2$datapath, header = input$header)
    
    # Check data format - confirms data frame formation occurs
    # appropriately so the package will function properly
    stds <- check_set(stds)
    samples <- check_set(samples)
    
    # Pull spectral information (See Jake's code/comments on GitHub)
    home.directory <- input$path
    p_stds <- analyze_set(stds, home = home.directory)
    p_samples <- analyze_set(samples, home = home.directory)
    
    # Creating calibration curve and assign to an object
    calibration <- calibrate_set(p_stds)
    
    # Calculate concentration of sample set and assign to an object
    proc_samples <- calc_conc(p_samples, curve = calibration)
    
    # Use ggplot2 here to display plot
    # a graph displaying the calibration curve as well as the sample
    # data
    # Geoms to use: geom_scatter and geom_line
    # Data for plot: user input files and working directory
  })
}

shinyApp(ui, server)
}#End of interactive()


