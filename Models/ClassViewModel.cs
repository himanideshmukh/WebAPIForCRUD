using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPIForCRUD.Models
{
    public class ClassViewModel
    {
        public int Item_ID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public decimal? Price { get; set; }
    }
}