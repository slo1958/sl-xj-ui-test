#tag Class
Protected Class clExpressionGeneric
	#tag Method, Flags = &h0
		Sub Constructor()
		  FormatStr = "###,###.0"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(theValues as Dictionary) As double
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explain() As string
		  return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateFormat(theUpdateType as string)
		  if theUpdateType = "%" then 
		    FormatStr ="0.0%"
		    
		  elseif theUpdateType="x" then
		    FormatStr = "###,###.0"
		    
		  elseif theUpdateType="+" then
		    dim hasPrc as Boolean = instr(FormatStr,"%")> 0 
		    dim tmp as string= FormatStr
		    
		    tmp =  Replace(tmp,"%","")
		    tmp = tmp+"0"
		    
		    if hasPrc then tmp = tmp + "%"
		    
		    FormatStr = tmp
		    
		  elseif theUpdateType="-" then
		    dim hasPrc as Boolean = instr(FormatStr,"%")> 0
		    dim tmp as string= FormatStr
		    
		    tmp =  Replace(tmp,"%","")
		    if tmp.right(1)="0" then tmp = tmp.left(tmp.len-1)
		    
		    if hasPrc then tmp = tmp + "%"
		    
		    
		    FormatStr = tmp
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FormatStr As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FormatStr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
