From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 20 Nov 2017 21:29:49 +0000
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <20171120192402.GK29075@ziepe.ca>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
 <20171113203444.GJ22610@ziepe.ca>
 <75a7cfe3-58e0-b416-0b5b-beba1e8207fd@grimberg.me>
 <20171114024822.GN22610@ziepe.ca>
 <fd911816-576f-5a8e-eb41-b9081c960685@grimberg.me>
 <20171120192402.GK29075@ziepe.ca>
Message-ID: <1511213388.2396.45.camel@wdc.com>

On Mon, 2017-11-20@12:24 -0700, Jason Gunthorpe wrote:
> On Mon, Nov 20, 2017@02:10:13PM +0200, Sagi Grimberg wrote:
> > > > > It is too bad we can't re-size CQs.. Can we?
> > > > 
> > > > I wish we could, but its an optional feature so I can't see how we can
> > > > use it.
> > > 
> > > Well, it looks like mlx4/5 can do it, which covers a huge swath of
> > > deployed hardware..
> > > 
> > > I'd say make an optimal implementation using resize_cq and just a working
> > > implementation without it?
> > 
> > I can experiment with it, sure. Do you think that its a must have for
> > first phase though?
> 
> Not clear to me.. Bart?

Hi Jason,

Having the completion queue pool implementation use resize_cq internally if
supported by the HCA sounds interesting to me. This would help to avoid that
the CQ pool implementation uses more memory than needed. Sagi, if you don't
have the time to work on this please let me know. In that case I will try to
free up some time and implement this myself.

Bart.
