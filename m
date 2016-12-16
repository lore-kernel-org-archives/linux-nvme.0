From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Dec 2016 10:27:04 -0500
Subject: [PATCH] nvme-cli: fabrics: remove libudev dependency
In-Reply-To: <20161216080419.GA22912@infradead.org>
References: <1481846751-2896-1-git-send-email-keith.busch@intel.com>
 <20161216080419.GA22912@infradead.org>
Message-ID: <20161216152703.GA8888@localhost.localdomain>

On Fri, Dec 16, 2016@12:04:19AM -0800, Christoph Hellwig wrote:
> We can have multiple controllers with the same nqn, and they should all
> be deleted with this option.  Also I think factoring the removal code
> in the inner block into a separate function would make this a bit more
> readable.

I also noticed that the description for the 'nqn' field is LIST, but
we're not splitting that item. Was this supposed to be a comma separated
value of nqn's?

Thanks for the other comments; I'll fix those up.
