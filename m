From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Dec 2016 23:25:03 -0800
Subject: [PATCH] nvme-cli: fabrics: remove libudev dependency
In-Reply-To: <20161216152703.GA8888@localhost.localdomain>
References: <1481846751-2896-1-git-send-email-keith.busch@intel.com>
 <20161216080419.GA22912@infradead.org>
 <20161216152703.GA8888@localhost.localdomain>
Message-ID: <20161217072503.GA15478@infradead.org>

On Fri, Dec 16, 2016@10:27:04AM -0500, Keith Busch wrote:
> On Fri, Dec 16, 2016@12:04:19AM -0800, Christoph Hellwig wrote:
> > We can have multiple controllers with the same nqn, and they should all
> > be deleted with this option.  Also I think factoring the removal code
> > in the inner block into a separate function would make this a bit more
> > readable.
> 
> I also noticed that the description for the 'nqn' field is LIST, but
> we're not splitting that item. Was this supposed to be a comma separated
> value of nqn's?

It wasn't supposed to be a list, but now that you mention it a list
of nqn might actually be useful.
