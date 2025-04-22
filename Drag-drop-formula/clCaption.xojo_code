#tag Class
Protected Class clCaption
	#tag Method, Flags = &h0
		Function Between(theVar as integer, theMin as integer, theMax as integer) As Boolean
		  return (theMin <= theVar) and (theVar <= theMax)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildOperationLabel(theOp1 as clCaption, theOperand as string, theOp2 as clCaption) As string
		  tmpOp1 = theOp1
		  tmpOp2 = theOp2
		  tmpOper = theOperand.trim
		  
		  dim tmp as string
		  
		  if RequiresParenthesis(tmpOp1.mLabel) then
		    tmp = tmp + "(" + theOp1.mLabel + ")"
		    
		  else
		    tmp = tmp  + theOp1.mLabel  
		    
		  end if
		   
		  tmp = tmp + " " + tmpOper+" "
		  
		  if RequiresParenthesis(tmpOp2.mLabel)  then
		    tmp = tmp + "(" + theOp2.mLabel + ")"
		    
		  else
		    tmp = tmp  + theOp2.mLabel
		    
		  end if
		   
		  return tmp 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theSource as clCaption, theXLocation as integer, theYLocation as integer, theOrderPosition as integer)
		  XLocationBase = theXLocation
		  YLocationBase = theYLocation
		  OrderPosition = theOrderPosition
		  
		  mLabel = theSource.mLabel
		  Expression = theSource.Expression
		  
		  mHeight = 20
		  mWidth = 100
		  
		  ShowExplanation = false
		  StockItem = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theLabel as string, theXLocation as integer, theYLocation as integer, theOrderPosition as integer)
		  XLocationBase = theXLocation
		  YLocationBase = theYLocation
		  mLabel = theLabel
		  OrderPosition = theOrderPosition
		  
		  mHeight = 20
		  mWidth = 100
		  
		  ShowExplanation = false
		  StockItem = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawMe(g as Graphics)
		  'if DragMode then
		  'g.ForeColor = rgb(200,200,200)
		  'g.FillRoundRect(XLocation, YLocation - 10,   ColumnWidth, 15, 8,8)
		  '
		  'end if
		  
		  
		  g.ForeColor = rgb(0,0,0)
		  g.TextSize = 12
		  g.Bold = false
		  
		  
		  mHeight = g.StringHeight(mLabel, ColumnWidth-10)
		  mWidth = g.StringWidth(mLabel)
		  if mWidth > ColumnWidth- 10 then mWidth = ColumnWidth -10
		  
		  
		  g.DrawString  mLabel,  XLocation + ColumnWidth - mWidth, YLocation,ColumnWidth-10
		  
		  
		  
		   
		  
		  if EXtraMessage.Ubound >= 0 then  
		    
		    dim xmWidth as integer
		    dim xmHeight as integer
		    
		    dim ymLocation as integer = 60//YLocation
		    
		    g.TextSize = 14
		    g.Bold = true
		    
		    for each s as String in ExtraMessage
		      dim w as integer = g.StringWidth(s)
		      
		      if w > xmWidth then xmWidth = w
		      
		      xmHeight = xmHeight + cLineHeight
		      
		    next
		    
		    g.ForeColor = rgb(250,250,250)
		    g.FillRect XLocation, ymLocation - 20, xmWidth+20, xmHeight+10
		    
		    g.ForeColor = rgb(128,128,128)
		    g.DrawRect XLocation, ymLocation - 20, xmWidth+20, xmHeight+10
		    
		    //ymLocation = ymLocation + 5
		    
		    for each s as String in ExtraMessage
		      g.DrawString s, XLocation+10, ymLocation
		      ymLocation = ymLocation + cLineHeight
		      
		    next
		    
		  end if
		  
		  
		  if ShowExplanation and EXtraMessage.Ubound < 0 then
		    dim tmpExplain as string = Expression.Explain
		    
		    dim ymLocation as integer = 60//YLocation
		    
		    dim yVerticalLine as integer = XLocation + ColumnWidth - mWidth / 2
		    
		    dim xmWidth as integer
		    dim xmHeight as integer
		    
		    xmWidth =  g.StringWidth(tmpExplain)
		    xmHeight =  cLineHeight
		    
		    g.ForeColor = rgb(128,128,128)
		    g.DrawLine yVerticalLine, ymLocation, yVerticalLine, YLocation - 5
		    
		    g.ForeColor= rgb(250,250,250)
		    g.FillRect yVerticalLine - xmWidth / 2 - 10 , ymLocation - 20, xmWidth + 20 , 30
		    
		    g.ForeColor = rgb(128,128,128)
		    g.DrawRect yVerticalLine - xmWidth / 2 - 10 , ymLocation - 20, xmWidth + 20 , 30
		    
		    g.DrawString tmpExplain, yVerticalLine - xmWidth / 2 , ymLocation
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explain() As string
		  Return Expression.Explain
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MovedTo(x as integer, y as integer)
		  dim XDelta as integer 
		  dim YDelta as integer
		  
		  XDelta = x - XMouse
		  YDelta = y - YMouse
		  
		  XLocationMoving = XLocationMoving + XDelta
		  YLocationMoving = YLocationMoving + YDelta
		  
		  XMouse = x
		  YMouse = y
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MovingCaptionOnObject(theMovingCaption as clCaption) As Boolean
		  //
		  // Returns true if the moving caption overlaps self
		  //
		  
		  if theMovingCaption = nil then   return False
		  
		  if theMovingCaption.XLocationMoving + theMovingCaption.ColumnWidth < XLocation + ColumnWidth - mWidth then Return false
		  
		  if theMovingCaption.XLocationMoving + theMovingCaption.ColumnWidth - theMovingCaption.mWidth > XLocation + ColumnWidth then return false
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OnTheMove() As Boolean
		  return Moving
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PointInObject(x as integer, y as integer) As Boolean
		  //if XLocation > x or x > XLocation+mWidth+5 then return false
		  
		  if XLocation + ColumnWidth - mWidth > x or x > XLocation + ColumnWidth  then return false
		  
		  if YLocation-cLineHeight > y or y > YLocation + mHeight then return false
		  
		  return true
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RequiresParenthesis(theExpr as String) As Boolean
		  return instr(theExpr,"+") > 0  or instr(theExpr,"/") > 0 or instr(theExpr,"-")> 0 or instr(theExpr,"*")>0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOverlapping(Overlapping as clCaption)
		  
		  redim EXtraMessage(-1)
		  
		  OverlappingItem = Overlapping
		  
		  if Overlapping = nil then
		    
		  elseif abs( Overlapping.YLocation - me.YLocationMoving) < 5 then
		    
		    //
		    // Starting visible x location of moving item is given by XLocationMoving + ColumnWidth - mWidth
		    // End visible x location  of moving item is given by XLocationMoving + ColumnWidth  
		    //
		    // Starting visible x location of overlapped item is given by XLocation  + ColumnWidth - mWidth
		    // End visible x location  of overlapped item is given by XLocation  + ColumnWidth
		    //
		    
		    dim x0Moving as integer = me.XLocationMoving  + me.ColumnWidth - me.mWidth
		    dim x1Moving as integer = me.XLocationMoving  + me.ColumnWidth 
		    dim x0Overlaped as integer = Overlapping.XLocation + Overlapping.ColumnWidth - Overlapping.mWidth
		    dim x1Overlaped as integer = Overlapping.XLocation + Overlapping.ColumnWidth  
		    
		    if x1Moving < x0Overlaped then // should not reach this place
		      dim err as integer
		      
		    elseif x1Overlaped < x0Moving then // should not reach this place
		      dim err as integer
		      
		    elseif x0Moving < x0Overlaped and x1Moving < x0Overlaped + 10  then // overlap by 10 pix max on the left
		      EXtraMessage.Append BuildOperationLabel(me , "-" , Overlapping)
		      
		    elseif x1Moving > x1Overlaped and x0Moving > x1Overlaped - 10 then  // overlap by 10 pix max on the right
		      EXtraMessage.Append BuildOperationLabel(Overlapping , "-" , me)
		      
		    else
		      
		      EXtraMessage.Append BuildOperationLabel(me , "+" , Overlapping)
		       
		    end if
		    
		  elseif Overlapping.YLocation < me.YLocationMoving then
		    EXtraMessage.Append   BuildOperationLabel(Overlapping  , " / " , me)
		    
		  elseif Overlapping.YLocation > me.YLocationMoving and me.YLocationMoving > Overlapping.YLocation - 30 then 
		    EXtraMessage.Append BuildOperationLabel(me , " / " , Overlapping)
		    
		  else
		    
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartMoving(x as integer, y as integer)
		  XMouse = x
		  YMouse = y
		  
		  XLocationMoving = XLocationBase
		  YLocationMoving = YLocationBase
		  
		  Moving = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StopMoving() As clCaption
		  Moving = false
		  
		  dim tmpCaption as   clCaption
		  dim tmpExpression as   clExpressionItem
		  
		  XLocationEndMoving = XLocationMoving
		  YLocationEndMoving = YLocationMoving
		  
		  XLocationMoving = -1
		  YLocationMoving = -1
		  
		  if EXtraMessage.Ubound = 0 then
		    tmpCaption = new clCaption(EXtraMessage(0), OverlappingItem.XLocation, OverlappingItem.YLocation, OverlappingItem.OrderPosition)
		    tmpExpression = new  clExpressionItem
		    tmpExpression.Term0 = tmpOp1.Expression
		    tmpExpression.Term1 = tmpOp2.Expression
		    tmpExpression.Operation = tmpOper
		    tmpCaption.Expression = tmpExpression
		    
		  else
		    
		  end if
		  
		  redim ExtraMessage(-1)
		  OverlappingItem = nil
		  
		  return tmpCaption
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function XLocation() As integer
		  if Moving then
		    return XLocationMoving
		    
		  else
		    return XLocationBase
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function YLocation() As integer
		  if Moving then
		    return YLocationMoving
		    
		  else
		    return YLocationBase
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DragMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Expression As clExpressionGeneric
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EXtraMessage() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		mHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		mLabel As string
	#tag EndProperty

	#tag Property, Flags = &h0
		Moving As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		mWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OrderPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OverlappingItem As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowExplanation As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		StockItem As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		tmpOp1 As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		tmpOp2 As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		tmpOper As String
	#tag EndProperty

	#tag Property, Flags = &h0
		XLocationBase As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		XLocationEndMoving As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private XLocationMoving As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private XMouse As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		YLocationBase As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		YLocationEndMoving As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private YLocationMoving As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private YMouse As Integer
	#tag EndProperty


	#tag Constant, Name = cLineHeight, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cMemoBackgroundColor, Type = Color, Dynamic = False, Default = \"&cE5E09E00", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ColumnWidth, Type = Double, Dynamic = False, Default = \"100", Scope = Public
	#tag EndConstant


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
			Name="XLocationBase"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="YLocationBase"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Moving"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OrderPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mLabel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DragMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="XLocationEndMoving"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="YLocationEndMoving"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="tmpOper"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StockItem"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowExplanation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
