using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPIForCRUD.Models;

namespace WebAPIForCRUD.Controllers
{
    public class ItemsController : ApiController
    {
        public IHttpActionResult GetAllItems()
        {
            IList<ClassViewModel> items = null;
            using (var x = new ThinkBridgeTestEntities())
            {
                items = x.tblItemMasters
                    .Select(c => new ClassViewModel()
                    {
                        Item_ID = c.Item_ID,
                        Name = c.Name,
                        Description = c.Description,
                        Price = c.Price
                    }).ToList<ClassViewModel>();
            }
            if (items.Count == 0)
                return NotFound();

            return Ok(items);
        }
        public IHttpActionResult InsertNewItem(ClassViewModel item)
        {
            if (!ModelState.IsValid)
                return BadRequest("Invalid Data, Please Recheck.");

            using (var x = new ThinkBridgeTestEntities())
            {
                x.tblItemMasters.Add(new tblItemMaster()
                {
                    Name = item.Name,
                    Description = item.Description,
                    Price = item.Price
                });
                x.SaveChanges();
            }
            return Ok();
        }

        public IHttpActionResult UpdateItem(ClassViewModel item)
        {
            if (!ModelState.IsValid)
                return BadRequest("Invalid Data, Please Recheck.");

            using (var x = new ThinkBridgeTestEntities())
            {
                var CheckExistingItem = x.tblItemMasters.Where(c => c.Item_ID == item.Item_ID)
                    .FirstOrDefault<tblItemMaster>();
                if (CheckExistingItem != null)
                {
                    CheckExistingItem.Name = item.Name;
                    CheckExistingItem.Description = item.Description;
                    CheckExistingItem.Name = item.Name;

                    x.SaveChanges();
                }
                else
                    return NotFound();
            }
            return Ok();
        }

        public IHttpActionResult Delete(int id)
        {
            if (id <= 0)
                return BadRequest("Please enter valid item id.");

            using (var x = new ThinkBridgeTestEntities())
            {
                var item = x.tblItemMasters.Where(c => c.Item_ID == id).FirstOrDefault();

                x.Entry(item).State = System.Data.Entity.EntityState.Deleted;
                x.SaveChanges();
            }
            return Ok();
        }
    }
}
