From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 12 Oct 2016 10:43:43 -0700
Subject: [PATCH 5/7 v2] nvme-fabrics: Add host FC transport support
In-Reply-To: <20161012092411.GF12972@infradead.org>
References: <57f82b12.se5DjK6l/GWAoAxA%james.smart@broadcom.com>
 <20161012092411.GF12972@infradead.org>
Message-ID: <1476294223.5410.74.camel@linux.intel.com>

On Wed, 2016-10-12@02:24 -0700, Christoph Hellwig wrote:
> > 
> > +	??To configure a NVMe over Fabrics controller use the
> > nvme-cli tool
> > +	??from https://github.com/linux-nvme/nvme-cli.
> 
> Talking about nvme-cli, can you post the FC support patches for that
> as well?

Yes, this would be good, esp since Christoph and I have been writing
man pages and mention "fc" in one of the parameters.

(In fact, providing an fc example in the man pages would go a long way
to enabling fc people using nvme-cli).

I'll try and give your series a look after this patchset is resubmitted
with Christoph's feedback.

J
