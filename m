From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 11 Jul 2016 09:12:17 -0700
Subject: [PATCH] nvme-loop: add configfs dependency
In-Reply-To: <20160710121417.GA21551@lst.de>
References: <20160707090144.3061799-1-arnd@arndb.de>
 <577E68A5.8080709@kernel.dk> <20160710121417.GA21551@lst.de>
Message-ID: <1468253537.9164.52.camel@linux.intel.com>

On Sun, 2016-07-10@14:14 +0200, Christoph Hellwig wrote:
> On Thu, Jul 07, 2016@08:35:17AM -0600, Jens Axboe wrote:
> > Thanks Arnd, applied.
> 
> Actually I think we should replace the select with the depends.  In
> fact I though I had done that a while ago, but I must have messed it
> up.
> 
> Btw - do you plan to grab patches directly from the list now or
> do you want me to queue them up?  There are a few more pending on
> the list that should go in:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2016-June/005150.html
> (whole series)
> 
> http://lists.infradead.org/pipermail/linux-nvme/2016-July/005290.html
> (needs the attribution fixed to be from Ming)

I can re-send the patch changing "Fix by: " to "From: " if that helps.

Jay
