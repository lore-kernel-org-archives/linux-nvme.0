From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jul 2018 15:03:27 +0300
Subject: [PATCH v1] nvmet: Don't use uuid_le type
In-Reply-To: <27beef69-2f59-94dd-f592-a051a2cefcbd@grimberg.me>
References: <20180716095908.7690-1-andriy.shevchenko@linux.intel.com>
 <27beef69-2f59-94dd-f592-a051a2cefcbd@grimberg.me>
Message-ID: <6259b86a67bc8530e2ca3bce26b7114fe78d1410.camel@linux.intel.com>

On Mon, 2018-07-16@13:27 +0300, Sagi Grimberg wrote:
> > -	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
> > +	memcpy(&id->nguid, &ns->nguid, 16);
> 
> how about memcpy(&id->nguid, &ns->nguid, sizeof(ns->nguid));

I suppose should be sizeof(id->nguid), but I don't care much as long as
it doesn't use uuid_le type here.

-- 
Andy Shevchenko <andriy.shevchenko at linux.intel.com>
Intel Finland Oy
