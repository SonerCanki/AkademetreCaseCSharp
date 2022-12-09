using AkademetreCaseCSharp.Models;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using FastMember;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text.Json;

namespace AkademetreCaseCSharp.Controllers
{
    public class HomeController : Controller
    {
        static DataTable table = new DataTable();
        public IActionResult Index()
        {
            return View(table);
        }

        public IActionResult CreateExcel(string data)
        {
            if (data == null)
            {
                return RedirectToAction("Index");
            }
            var persons = System.Text.Json.JsonSerializer.Deserialize<List<Person>>(data, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

            using (var reader = ObjectReader.Create(persons))
            {
                table.Load(reader);
            }

            var fileName = "Output_" + DateTime.Now.ToString("dd/MM/yyyy/HH/MM/ss") + ".xlsx";
            var filePath = Path.Combine(Environment.CurrentDirectory + "/wwwroot/documents/", fileName);

            DataTable table2 = (DataTable)JsonConvert.DeserializeObject<DataTable>(data);
            using (SpreadsheetDocument document = SpreadsheetDocument.Create(filePath, SpreadsheetDocumentType.Workbook))
            {
                WorkbookPart workbookPart = document.AddWorkbookPart();
                workbookPart.Workbook = new Workbook();

                WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();
                var sheetData = new SheetData();
                worksheetPart.Worksheet = new Worksheet(sheetData);

                Sheets sheets = workbookPart.Workbook.AppendChild(new Sheets());
                Sheet sheet = new Sheet() { Id = workbookPart.GetIdOfPart(worksheetPart), SheetId = 1, Name = "Sheet1" };

                sheets.Append(sheet);

                Row headerRow = new Row();

                List<string> columns = new List<string>();
                foreach (DataColumn column in table2.Columns)
                {
                    columns.Add(column.ColumnName);

                    Cell cell = new Cell();
                    cell.DataType = CellValues.String;
                    cell.CellValue = new CellValue(column.ColumnName);
                    headerRow.AppendChild(cell);
                }

                sheetData.AppendChild(headerRow);

                foreach (DataRow dsrow in table2.Rows)
                {
                    Row newRow = new Row();
                    foreach (String col in columns)
                    {
                        Cell cell = new Cell();
                        cell.DataType = CellValues.String;
                        cell.CellValue = new CellValue(dsrow[col].ToString());
                        newRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(newRow);
                }

                workbookPart.Workbook.Save();
            }
            return Json("/documents/" + fileName);
        }

        public IActionResult CreateExcelForTable()
        {

            var fileName = "Output_" + DateTime.Now.ToString("dd/MM/yyyy/HH/MM/ss") + ".xlsx";
            var filePath = Path.Combine(Environment.CurrentDirectory + "/wwwroot/documents/", fileName);

            //DataTable table = (DataTable)JsonConvert.DeserializeObject<DataTable>(data);
            using (SpreadsheetDocument document = SpreadsheetDocument.Create(filePath, SpreadsheetDocumentType.Workbook))
            {
                WorkbookPart workbookPart = document.AddWorkbookPart();
                workbookPart.Workbook = new Workbook();

                WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();
                var sheetData = new SheetData();
                worksheetPart.Worksheet = new Worksheet(sheetData);

                Sheets sheets = workbookPart.Workbook.AppendChild(new Sheets());
                Sheet sheet = new Sheet() { Id = workbookPart.GetIdOfPart(worksheetPart), SheetId = 1, Name = "Sheet1" };

                sheets.Append(sheet);

                Row headerRow = new Row();

                List<string> columns = new List<string>();
                foreach (DataColumn column in table.Columns)
                {
                    columns.Add(column.ColumnName);

                    Cell cell = new Cell();
                    cell.DataType = CellValues.String;
                    cell.CellValue = new CellValue(column.ColumnName);
                    headerRow.AppendChild(cell);
                }

                sheetData.AppendChild(headerRow);

                foreach (DataRow dsrow in table.Rows)
                {
                    Row newRow = new Row();
                    foreach (String col in columns)
                    {
                        Cell cell = new Cell();
                        cell.DataType = CellValues.String;
                        cell.CellValue = new CellValue(dsrow[col].ToString());
                        newRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(newRow);
                }

                workbookPart.Workbook.Save();
            }
            return Json("/documents/" + fileName);
        }
    }
}