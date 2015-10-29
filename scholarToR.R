suppressMessages(library(scholar))
suppressMessages(library(ggplot2))
suppressMessages(library(grid))
suppressMessages(library(gridExtra))

prof=get_profile('qZLGnroAAAAJ')
his=get_citation_history('qZLGnroAAAAJ')

his$year=as.factor(his$year)

PimpMyPlot <- theme(text=element_text(size=10,family="Helvetica"))+
  theme(axis.line=element_line(colour='black'))+
  theme(axis.text=element_text(colour="black"))+
  theme(panel.grid.major.y=element_line(linetype='dotted',colour='black',size=0.3))+
  theme(panel.grid.minor.y=element_blank())+
  theme(panel.grid.major.x=element_blank())+
  theme(axis.ticks=element_line(colour='black'))+
  theme(panel.background=element_rect(fill='transparent',colour="NA"))+
  theme(plot.background=element_rect(fill='transparent',colour="NA"))+
  theme(plot.margin = unit(c(3,1,1,1), "lines"))+
  theme(axis.title=element_text(size=10,face="bold"))

png('scholarCites.png',width=1000,height=800,res=300,bg = "transparent")
  plot=ggplot(his,aes(x=year,y=cites))
    plot=plot+geom_line(stat='identity',aes(group=1),colour='black')+
    geom_point(size=3,colour='black',fill='#f26c4f',pch=21)+
    xlab('')+
    ylab('Citations')+
    #annotate('text',label=format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"),x=-Inf,y=Inf,vjust=1.5,hjust=-0.05,size=3,colour='gray')+
    #annotate('text',label=paste('h-index:',toString(prof$h_index)),x=-Inf,y=Inf, vjust=3,hjust=-.05)+
    PimpMyPlot
    
print(plot,vp=viewport(height=.9))    
grid.text(x=.95, y=.9,just='right', label=paste('Citations:',prof$total_cites),gp=gpar(col="black", fontsize=11,fontfamily='Helvetica',fontface='bold'))
grid.text(x=.95, y=.82,just='right', label=paste('h-index:',prof$h_index),gp=gpar(col="black", fontsize=11,fontfamily='Helvetica',fontface='bold'))
grid.text(x=.95, y=.05,just='right', label=format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"),gp=gpar(col="grey50", fontsize=11,fontfamily='Helvetica',fontface='bold'))
grid.text(x=.95, y=.12,just='right', label='source:scholar.google.com',gp=gpar(col="grey50", fontsize=11,fontfamily='Helvetica',fontface='bold'))

invisible(dev.off())
