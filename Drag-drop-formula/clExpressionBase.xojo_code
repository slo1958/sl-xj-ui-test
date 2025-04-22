#tag Class
Protected Class clExpressionBase
Inherits clExpressionGeneric
	#tag Method, Flags = &h1000
		Sub Constructor(theFieldName as String)
		  Super.Constructor
		  FieldName = theFieldName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(theValues as Dictionary) As double
		  if theValues.HasKey(FieldName) then
		    return theValues.Value(FieldName)
		    
		  else
		    Return 0
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explain() As string
		  return FieldName
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		FieldName As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FormatStr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="FieldName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
