#tag Class
Protected Class clExpressionItem
Inherits clExpressionGeneric
	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(theValues as Dictionary) As double
		  dim op1 as Double = term0.Evaluate(theValues)
		  dim op2 as Double = term1.Evaluate(theValues)
		  
		  
		  select case  Operation
		    
		  case "+"
		    Return op1 + op2
		    
		  case "-"
		    Return op1 - op2
		    
		  case "/"
		    if abs(op2) < 0.00001 then
		      return 0
		      
		    else
		      Return op1 / op2
		      
		    end if
		    
		  case "*"
		    Return op1 * op2
		    
		  case else
		    Return 0
		    
		    
		  end Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explain() As string
		  dim v0 as string= term0.Explain
		  dim v1 as string= term1.Explain
		  
		  if not term0 isa clExpressionBase then v0 = "(" + v0 + ")"
		  if not term1 isa clExpressionBase then v1 = "(" + v1 + ")"
		  
		  return v0 + " " + Operation + " " + v1
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Operation As string
	#tag EndProperty

	#tag Property, Flags = &h0
		Term0 As clExpressionGeneric
	#tag EndProperty

	#tag Property, Flags = &h0
		Term1 As clExpressionGeneric
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
			Name="Operation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
