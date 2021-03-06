Attribute VB_Name = "Module1"
Sub thisWorkbook():
Dim ws As Worksheet
For Each ws In ActiveWorkbook.Worksheets
ws.Activate
lastRow = ws.Cells(Rows.Count, 1).End(xlUp).row
Cells(1, "I").Value = "Ticker"
Cells(1, "J").Value = "Yearly Change"
Cells(1, "K").Value = "Percent Change"
Cells(1, "L").Value = "Total Stock Volume"
Dim openPrice As Double
Dim closePrice As Double
Dim yearlyChange As Double
Dim Ticker As String
Dim percentChange As Double
Dim volume As Double
volume = 0
Dim row As Double
row = 2
Dim column As Integer
column = 1
Dim i As Long
openPrice = Cells(2, column + 2).Value
For i = 2 To lastRow
If Cells(i + 1, column).Value <> Cells(i, column).Value Then
Ticker = Cells(i, column).Value
Cells(row, column + 8).Value = Ticker
closePrice = Cells(i, column + 5).Value
yearlyChange = closePrice - openPrice
Cells(row, column + 9).Value = yearlyChange
If (openPrice = 0 And closePrice = 0) Then
percentChange = 0
ElseIf (openPrice = 0 And closePrice <> 0) Then
percentChange = 1
Else
percentChange = yearlyChange / openPrice
Cells(row, column + 10).Value = percentChange
Cells(row, column + 10).NumberFormat = "0.00%"
End If
volume = volume + Cells(i, column + 6).Value
Cells(row, column + 11).Value = volume
row = row + 1
openPrice = Cells(i + 1, column + 2)
volume = 0
Else
volume = volume + Cells(i, column + 6).Value
End If
Next i
yearChangeLastRow = ws.Cells(Rows.Count, column + 8).End(xlUp).row
For j = 2 To yearChangeLastRow
If (Cells(j, column + 9).Value > 0 Or Cells(j, column + 9).Value = 0) Then
Cells(j, column + 9).Interior.ColorIndex = 10
ElseIf Cells(j, colum + 9).Value < 0 Then
Cells(j, column + 9).Interior.ColorIndex = 3
End If
Next j
Cells(2, column + 14).Value = "Greatest % Increase"
Cells(3, column + 14).Value = "Greatest % Decrease"
Cells(4, column + 14).Value = "Greatest Total Volume"
Cells(1, column + 15).Value = "Ticker"
Cells(1, column + 16).Value = "Value"
For l = 2 To yearChangeLastRow
If Cells(l, column + 10).Value = Application.WorksheetFunction.Max(ws.Range("K2:K" & yearChangeLastRow)) Then
Cells(2, column + 15).Value = Cells(l, column + 8).Value
Cells(2, column + 16).Value = Cells(l, column + 10).Value
Cells(2, column + 16).NumberFormat = "0.00%"
ElseIf Cells(l, column + 10).Value = Application.WorksheetFunction.Min(ws.Range("K2" & yearChangeLastRow)) Then
Cells(3, column + 15).Value = Cells(j, column + 8).Value
Cells(3, column + 16).Value = Cells(j, column + 10).Value
Cells(3, column + 16).NumberFormat = "0.00%"
ElseIf Cells(l, column + 11).Value = Application.WorksheetFunction.Max(ws.Range("L2:L" & yearChangeLastRow)) Then
Cells(4, column + 15).Value = Cells(l, column + 8).Value
Cells(4, column + 16).Value = Cells(l, column + 11).Value
End If
Next l
Next ws
End Sub

