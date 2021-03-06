
code 'sce_interest'
name '利息收入'
dimensions {
	accbook null
	monthEnd name:'cfDate'
}
dataRequest {
	table 'sceMcf',{
		allDimensions (['accbook','cfDate'])
	}
	fields 'accbook,cfDate,sum(interest) value'
    groupFields 'accbook,cfDate'
	contextParams (['scene','foreignToHome'])
}
derivedHeads{
    accbook ([new Head(name:'净利息收入',aggregate:true,formula:{
        def grids=thisColGrids({parent==null})
        def a=grids.find{it.rowHeadGrid.model?.alType=='A'}
        def l=grids.find{it.rowHeadGrid.model?.alType=='L'}
        if(a && l){
            a-l
         }
    })])
}
dataGrids {
	apply selectRows({children!=null}),{
		formula {sumChildren()}
	}
}
