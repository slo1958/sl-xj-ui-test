#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   689
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1195515606
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   908
   Begin Canvas Canvas1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   510
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   28
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   826
   End
   Begin TextArea TextArea1
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   49
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   682
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollbarVertical=   False
      Styled          =   True
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   False
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   542
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   172
   End
   Begin TextArea TextArea2
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   126
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   28
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   543
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   280
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		  pct = new Picture(canvas1.Width, Canvas1.Height,32)
		   
		  
		  // Create dummy data
		  
		  DummyRecord.Append  new Dictionary 
		  DummyRecord.Append new Dictionary
		  DummyRecord.Append new Dictionary
		  
		  AddItem("Gross sales", array(1000.0, 980.0, 12345.0), true)
		  AddItem("Volume", array(560.0, 400.0, 6142.0), true)
		  AddItem("Net sales", array(900.0, 700.0, 9800.0), true)
		  AddItem("PTerm Disc.",array( 900*0.03, 0, 300.0),false)
		  AddItem("Cash Disc.", array(900*0.02, 0, 150.0), false)
		  
		  RefreshCanvas
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  pct = new Picture(canvas1.Width, Canvas1.Height,32)
		  RefreshCanvas
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddItem(theLabel as string, values() as Double, addToChart as Boolean)
		  
		  dim tmpCaption as clCaption
		  
		  dim tmpExpression as clExpressionBase = new clExpressionBase(theLabel)
		  
		  dim tmpLoc as integer  
		  
		   
		  
		  //
		  // Create entry for stock
		  //
		  tmpLoc = CaptionStock.Ubound + 1
		  tmpLoc = cYStart + 25 * tmpLoc
		  
		  tmpCaption = new clCaption(theLabel,10, tmpLoc, CaptionStock.Ubound + 1)
		  tmpCaption.Expression = tmpExpression
		  tmpCaption.StockItem = true
		  CaptionStock.Append tmpCaption
		  
		  
		  //
		  // Create entry for table
		  //
		  
		  if addToChart then 
		    tmpLoc = Captions.Ubound+1
		    tmpLoc = cXStart + 150 * tmpLoc
		    
		    tmpCaption = new clCaption(theLabel,tmpLoc, cYmin, Captions.Ubound + 1)
		    tmpCaption.Expression = tmpExpression
		    tmpCaption.StockItem = false
		    Captions.Append tmpCaption
		     
		  end if
		  
		  for i as integer = 0 to values.LastIndex
		    DummyRecord(i).Value(theLabel) = values(i)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub closeTextArea(bSaveText as Boolean)
		  
		  if EditCaption <> nil and  TextArea1.Text.Trim.Len > 0  and bSaveText then
		    
		    EditCaption.mLabel = TextArea1.Text .Trim
		     
		  end if
		  
		  EditCaption = nil 
		  TextArea1.Visible = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshCanvas()
		  Canvas1.Refresh  false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resequence()
		  for i as integer = 0 to Captions.Ubound
		    Captions(i).OrderPosition = i
		    Captions(i).XLocationBase = cXStart + i * 150
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetDragMode()
		  
		  for each item as clCaption in Captions
		    item.dragMode = false
		    
		  next
		  
		  CurrentCaption = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetShowExplain()
		  for each item as clCaption in Captions
		    item.ShowExplanation = false
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateCaptionLocations(x as integer, y as integer)
		  
		  if CurrentCaption = nil then Return
		  
		  dim newCaption as clCaption = CurrentCaption.StopMoving
		  
		  if newCaption <> nil then
		    // New item to create ( we are overlapping another item)
		    Captions.Insert(newCaption.OrderPosition,newCaption)
		    
		    Resequence
		    
		    
		  elseif CurrentCaption.YLocationEndMoving < 5 and not CurrentCaption.StockItem then
		    // remove selected item
		    Captions.Remove CurrentCaption.OrderPosition
		    
		    Resequence
		    
		    
		  elseif ( CurrentCaption.YLocationEndMoving )  < CurrentCaption.YLocationBase   then
		    //elseif y < CurrentCaption.YLocationBase   then
		    // PointInVerticalZone(y, cYmin) then
		    // end in zone, relocate ( note : we are not overlapping another item) ?
		    
		    dim itemAtRight as integer=-1
		    dim item as integer = 0
		    
		    if CurrentCaption.StockItem then
		      // clone
		      CurrentCaption = new clCaption(CurrentCaption,-1, cYmin,-1)
		      
		    else
		      Captions.Remove CurrentCaption.OrderPosition
		      
		    end if
		    
		    
		    while (item <= Captions.Ubound) and (itemAtRight <0 )
		      if CurrentCaption.XLocationEndMoving < Captions(item).XLocationBase Then
		        itemAtRight = item
		        
		      end if
		      item = item + 1
		      
		    wend
		    
		    if itemAtRight < 0 then
		      Captions.Append CurrentCaption
		      
		    else
		      Captions.Insert(itemAtRight, CurrentCaption)
		      
		    end if
		    
		    Resequence
		    
		  end if
		   
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Captions() As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		CaptionStock() As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentCaption As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		DummyRecord() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		EditCaption As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		FormatCaption As clCaption
	#tag EndProperty

	#tag Property, Flags = &h0
		pct As Picture
	#tag EndProperty


	#tag Constant, Name = cXStart, Type = Double, Dynamic = False, Default = \"200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cYMin, Type = Double, Dynamic = False, Default = \"100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cYStart, Type = Double, Dynamic = False, Default = \"100", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  
		  if pct = nil then return
		  
		  pct.Graphics.ForeColor = rgb(255,255,255)
		  pct.Graphics.FillRect (0,0,pct.Width, pct.Height)
		  
		  pct.Graphics.ForeColor = rgb(12,12,12)
		  
		  
		  for each item as clCaption in Captions
		    
		    item.DrawMe pct.Graphics
		    
		     for i as integer = 0 to 2
		      dim vl as double = item.Expression.Evaluate(DummyRecord(i))
		      dim st as String = format(vl, item.Expression.FormatStr )
		      
		      pct.Graphics.ForeColor = rgb(10,10,10)
		      pct.Graphics.TextSize = 12
		      pct.Graphics.bold = false
		      
		      pct.Graphics.DrawString st, item.XLocationBase + item.ColumnWidth - pct.Graphics.StringWidth(st), item.YLocationBase + 50+i*20
		      
		      
		    next
		    
		  next
		  
		  
		  for each item as clCaption in CaptionStock
		    
		    item.DrawMe pct.Graphics
		    
		  next
		  
		  
		  g.DrawPicture pct,0,0
		  
		  return
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  if CurrentCaption <> nil then
		    call CurrentCaption.StopMoving
		    
		  end if
		  
		  if EditCaption <> nil then
		    closeTextArea true
		    
		  end if
		  
		  CurrentCaption = nil
		  
		  for each item as clCaption in Captions
		    item.dragMode = true
		    
		    if item.PointInObject(x,y) then 
		       
		      CurrentCaption = item
		      CurrentCaption.StartMoving(x,y)
		      return true
		      
		    else
		      
		      
		    end if
		    
		  next
		  
		  // 
		  // In stock ?
		  //
		  for each item as clCaption in CaptionStock
		    item.dragMode = true
		    
		    if item.PointInObject(x,y) then
		       
		      CurrentCaption = item
		      CurrentCaption.StartMoving(x,y)
		      return true
		      
		    else
		      
		      
		    end if
		    
		    
		  next
		  
		  // 
		  // in data ?
		  //
		  
		  if y >cyMin + 50 - 15 then
		    
		    for each item as clCaption in Captions
		      
		      if item.PointInObject(x,cyMin+5) then
		        FormatCaption = item
		        
		        dim menu as new MenuItem
		        
		        if instr(item.Expression.FormatStr,"%") = 0 then
		          menu.Append new MenuItem("%","%")
		          
		        else
		          menu.Append new MenuItem("xxx0.0xx","x")
		          
		        end if
		        
		        menu.Append new MenuItem("-")
		        menu.Append new MenuItem("x.0 => x.00","+")
		        menu.Append new MenuItem("x.00 => x.0","-")
		        
		        dim tmp as MenuItem = menu.PopUp()
		        
		        if tmp<> nil then
		          item.Expression.UpdateFormat(tmp.Tag)
		          
		        end if
		        
		        return true
		        
		      else
		        
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		  
		  
		  
		  Return false
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  if CurrentCaption = nil then Return
		  
		  
		  dim tmpCaption as clCaption = nil
		  
		  CurrentCaption.MovedTo(x,y)
		  
		  for each item as clCaption in Captions
		    if  (item <> CurrentCaption )  and item.MovingCaptionOnObject(CurrentCaption)    then
		      //if item.PointInObject(x,y) and item <> CurrentCaption then
		      tmpCaption = item 
		      
		    else
		      
		    end if
		    
		  next
		  
		  CurrentCaption.SetOverlapping(tmpCaption)
		  
		  
		  RefreshCanvas 
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  if CurrentCaption <> nil   then UpdateCaptionLocations(x,y)
		  
		  ResetDragMode
		  
		  RefreshCanvas
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick(X As Integer, Y As Integer)
		  
		  for each item as clCaption in Captions
		     
		    if item.PointInObject(x,y) then
		      EditCaption = item
		      TextArea1.Left = item.XLocationBase + canvas1.Left
		      TextArea1.Top = Item.YLocationBase -15 + canvas1.Top
		      
		      TextArea1.Width = item.ColumnWidth
		      
		      TextArea1.Height = 60
		      TextArea1.Text = item.mLabel
		      TextArea1.Visible = true
		      TextArea1.SetFocus 
		      
		      return
		    else
		      
		      
		    end if
		    
		  next
		  
		  
		  Return
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  dim foundCaption as clCaption
		  
		  for each item as clCaption in Captions
		    if item.PointInObject(x,y) then
		      foundCaption = item
		      
		    end if
		    
		  next
		  
		  ResetShowExplain
		  
		  if foundCaption = nil then 
		    TextArea2.Text =  ""
		    RefreshCanvas
		    Return
		    
		  end if
		  
		  if foundCaption.mLabel = foundCaption.Explain then
		    TextArea2.Text =  ""
		    RefreshCanvas
		    Return
		    
		  end if
		  
		  foundCaption.ShowExplanation = true
		  
		  TextArea2.Text = foundCaption.Explain
		  RefreshCanvas
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextArea1
	#tag Event
		Sub LostFocus()
		  closeTextArea true
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  if key=chr(9) or key=chr(13) or key=chr(27) then
		    closeTextArea key<>chr(27)
		    
		  end if
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="pct"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
