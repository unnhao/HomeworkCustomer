﻿using ClosedXML.Excel;
using HomeworkCustomer.Models;
using Omu.ValueInjecter;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HomeworkCustomer.Controllers
{
    public class CustomerController : Controller
    {
        客戶資料Repository repo;
        客戶分類Repository repoCategory;

        public CustomerController()
        {
            repo = RepositoryHelper.Get客戶資料Repository();
            repoCategory = RepositoryHelper.Get客戶分類Repository(repo.UnitOfWork);
        }
        public ActionResult Index(string sortOrder, string searchString, int? 客戶分類Id)
        {
            ViewData["sortOrder"] = sortOrder;
            ViewBag.客戶分類Id = new SelectList(repoCategory.All(), "Id", "客戶分類名稱");
            var datas = repo.All();

            if (!String.IsNullOrEmpty(searchString))
            {
                datas = datas.Where(p => p.客戶名稱.Contains(searchString));
            }

            if (客戶分類Id.HasValue)
            {
                datas = datas.Where(p => p.客戶分類Id == 客戶分類Id);
            }

            switch (sortOrder)
            {
                case "客戶名稱_desc":
                    datas = datas.OrderByDescending(p => p.客戶名稱);
                    break;
                case "統一編號_desc":
                    datas = datas.OrderByDescending(p => p.統一編號);
                    break;
                case "統一編號":
                    datas = datas.OrderBy(p => p.統一編號);
                    break;
                case "電話_desc":
                    datas = datas.OrderByDescending(p => p.電話);
                    break;
                case "電話":
                    datas = datas.OrderBy(p => p.電話);
                    break;
                case "傳真_desc":
                    datas = datas.OrderByDescending(p => p.傳真);
                    break;
                case "傳真":
                    datas = datas.OrderBy(p => p.傳真);
                    break;
                case "地址_desc":
                    datas = datas.OrderByDescending(p => p.地址);
                    break;
                case "地址":
                    datas = datas.OrderBy(p => p.地址);
                    break;
                case "Email_desc":
                    datas = datas.OrderByDescending(p => p.Email);
                    break;
                case "Email":
                    datas = datas.OrderBy(p => p.Email);
                    break;
                default:
                    datas = datas.OrderBy(s => s.客戶名稱);
                    break;
            }
            return View(datas);
        }
        public ActionResult Create()
        {
            var 客戶分類data = repoCategory.All();
            ViewBag.客戶分類Id = new SelectList(repoCategory.All(), "Id", "客戶分類名稱");
            return View();
        }

        [HttpPost]
        public ActionResult Create(客戶資料 customer)
        {
            if (ModelState.IsValid)
            {
                repo.Add(customer);
                repo.UnitOfWork.Commit();
                return RedirectToAction("Index");
            }
            
            return View(customer);
        }

        public ActionResult Edit(int? id)
        {
            if (!id.HasValue)
            {
                return HttpNotFound();
            };
            ViewBag.客戶分類Id = new SelectList(repoCategory.All(), "Id", "客戶分類名稱");
            var data = repo.All().Where(p => p.Id == id).FirstOrDefault();

            return View(data);
        }
        [HttpPost]
        public ActionResult Edit(int id, 客戶資料 customer)
        {
            var data = repo.All().Where(p => p.Id == id).FirstOrDefault();

            if (ModelState.IsValid)
            {
                data.InjectFrom(customer);

                repo.UnitOfWork.Commit();

                return RedirectToAction("Index");
            }

            return View(data);
        }

        public ActionResult Delete(int? id)
        {
            if (!id.HasValue)
            {
                return HttpNotFound();
            };

            var data = repo.All().Where(p => p.Id == id).FirstOrDefault();

            return View(data);
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection form)
        {

            var data = repo.All().Where(p => p.Id == id).FirstOrDefault();
            repo.Delete(data);
            repo.UnitOfWork.Commit();
            return RedirectToAction("Index");
        }


        public ActionResult Details(int? id)
        {
            if (!id.HasValue)
            {
                return HttpNotFound();
            }

            var data = repo.All().Where(p => p.Id == id).FirstOrDefault();

            return View(data);
        }

        [HttpPost]
        public ActionResult GetReport()
        {
            // 參考 https://dotblogs.com.tw/rexhuang/2017/05/18/230611
            using (XLWorkbook wb = new XLWorkbook())
            {
                var data = repo.All().Select(p => new { p.客戶名稱, p.統一編號, p.電話, p.傳真, p.地址, p.Email });
                var ws = wb.Worksheets.Add("cusdata", 1);
                ws.Cell(1, 1).InsertData(data);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    memoryStream.Seek(0, SeekOrigin.Begin);
                    return this.File(memoryStream.ToArray(), "application/vnd.ms-excel", "Report.xlsx");
                }
            }
        }
    }
}