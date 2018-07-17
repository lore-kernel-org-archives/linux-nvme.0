From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:14:38 +0200
Subject: [PATCH v1] nvmet: Don't use uuid_le type
In-Reply-To: <6259b86a67bc8530e2ca3bce26b7114fe78d1410.camel@linux.intel.com>
References: <20180716095908.7690-1-andriy.shevchenko@linux.intel.com>
 <27beef69-2f59-94dd-f592-a051a2cefcbd@grimberg.me>
 <6259b86a67bc8530e2ca3bce26b7114fe78d1410.camel@linux.intel.com>
Message-ID: <20180717131438.GC13582@lst.de>

On Mon, Jul 16, 2018@03:03:27PM +0300, Andy Shevchenko wrote:
> On Mon, 2018-07-16@13:27 +0300, Sagi Grimberg wrote:
> > > -	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
> > > +	memcpy(&id->nguid, &ns->nguid, 16);
> > 
> > how about memcpy(&id->nguid, &ns->nguid, sizeof(ns->nguid));
> 
> I suppose should be sizeof(id->nguid), but I don't care much as long as
> it doesn't use uuid_le type here.

Yes, please use sizeof of the destination field instead of an opencoded
number.
