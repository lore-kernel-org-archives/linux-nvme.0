From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Jan 2019 08:46:28 -0700
Subject: [PATCH] nvme-cli: minor cleanup for sibmit_io()
In-Reply-To: <a9136048-6118-ab5b-72da-9f702ea0c5a4@acm.org>
References: <20190129071202.174535-1-chaitanya.kulkarni@wdc.com>
 <a9136048-6118-ab5b-72da-9f702ea0c5a4@acm.org>
Message-ID: <20190129154628.GA17132@localhost.localdomain>

On Tue, Jan 29, 2019@06:50:56AM -0800, Bart Van Assche wrote:
> On 1/28/19 11:12 PM, Chaitanya Kulkarni wrote:
> > -	} else {
> > +	} else
> >   		buffer_size = cfg.data_size;
> > -	}
> 
> Does nvme-cli follow the kernel coding style? The kernel coding style guide
> explicitly mentions that braces should be balanced. So this patch changes
> codes that conforms to that style guide into code that does not conform.

Yes, kernel is the coding style we try to adhere to for this project. Most
of the changes here are in that direction, so I'll just fix up this one
on the commit.
