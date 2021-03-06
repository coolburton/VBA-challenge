Attribute VB_Name = "Module1"
Sub Stock()

For Each ws In Worksheets

    Range("i1").Value = "Ticker"
    Range("j1").Value = "Yearly Change"
    Range("k1").Value = "Percent Change"
    Range("l1").Value = "Total Stock Volume"
    
    
    Dim ticker As String
    Dim open_price As Double
    Dim close_price As Double
    Dim yearly_change As Double
    Dim percent_change As Double
    Dim volume As Double
    Dim row As Integer
    Dim i As Long
    
    lastrow = ws.Cells(Rows.Count, 1).End(xlUp).row
    row = 2
    volume = 0
    open_price = Range("c2").Value
    
    
    
    For i = 2 To lastrow
    
        If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
           
           ticker = Cells(i, 1).Value
           Cells(row, 9).Value = ticker
                      
           close_price = Cells(i, 6).Value
           yearly_change = close_price - open_price
           Cells(row, 10).Value = yearly_change
           
           If (open_price = 0 And yearly_change = 0) Then
               percent_change = 0
           ElseIf (open_price = 0 And yearly_change <> 0) Then
               percent_change = 1
           Else
           percent_change = yearly_change / open_price
           Cells(row, 11).Value = percent_change
           Cells(row, 11).NumberFormat = "0.00%"
           End If
           
           volume = volume + Cells(i, 7).Value
           Cells(row, 12).Value = volume
           
           open_price = Cells(i + 1, 3).Value
           row = row + 1
           volume = 0
           
        Else
        
           volume = volume + Cells(i, 7).Value
        
        End If
        
                  
    Next i
    
    
    Dim j As Long
    
    newlastrow = ws.Cells(Rows.Count, 9).End(xlUp).row
    
    For j = 2 To newlastrow
        
        If Cells(j, 10) >= 0 Then
        Cells(j, 10).Interior.Color = vbGreen
        Else
        Cells(j, 10).Interior.Color = vbRed
        
        End If
    
    Next j
    
    
        Range("o2").Value = "Greatest % Increase"
        Range("o3").Value = "Greatest % Decrease"
        Range("o4").Value = "Greatest Total Volume"
        Range("p1").Value = "Ticker"
        Range("q1").Value = "Value"
        
    Dim k As Long
    
    For k = 2 To newlastrow
        
        If Cells(k, 11).Value = WorksheetFunction.Max(Range("k2:k" & newlastrow)) Then
           Cells(2, 16).Value = Cells(k, 9).Value
           Cells(2, 17).Value = Cells(k, 11).Value
           Cells(2, 17).NumberFormat = "0.00%"
           
        ElseIf Cells(k, 11).Value = WorksheetFunction.Min(Range("k2:k" & newlastrow)) Then
           Cells(3, 16).Value = Cells(k, 9).Value
           Cells(3, 17).Value = Cells(k, 11).Value
           Cells(3, 17).NumberFormat = "0.00%"
           
        ElseIf Cells(k, 12).Value = WorksheetFunction.Max(Range("l2:l" & newlastrow)) Then
           Cells(4, 16).Value = Cells(k, 9).Value
           Cells(4, 17).Value = Cells(k, 12).Value
        
    End If
    
    
    Next k
    
    
Next ws

           
        
End Sub

