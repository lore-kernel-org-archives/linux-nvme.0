From: hch@lst.de (Christoph Hellwig)
Date: Fri, 18 May 2018 11:08:52 +0200
Subject: [PATCH RFC v2 2/2] nvmet-rdma: support 16K inline data
In-Reply-To: <76914471-8d8a-cdec-e952-24b1e9a5ed72@opengridcomputing.com>
References: <cover.1526505524.git.swise@opengridcomputing.com>
 <e3c4d8a638b989aef554646d235aa45d633d9565.1526505524.git.swise@opengridcomputing.com>
 <20180517115203.GB30345@lst.de>
 <76914471-8d8a-cdec-e952-24b1e9a5ed72@opengridcomputing.com>
Message-ID: <20180518090852.GE24436@lst.de>

On Thu, May 17, 2018@09:24:57AM -0500, Steve Wise wrote:
> >> +	ret = kstrtouint((const char *)page, 0, &size);
> > This cast looks bogus.
> >
> > Also inline_data_size shoul be and u32 as that is closest to what
> > is on the wire, and you thus should use kstrtou32 and pass the
> > inline_data_size straight to kstrtou32 instead of bouncing it through
> > a local variable.
> 
> I made it an int so it could be initialized to -1 indicating it is not
> set by the config.? This allows the rdma transport to use its default
> value if the config does not specify any value.? I did this so the admin
> could totally disable inline by specifying 0.?? So I needed a value that
> indicates "unspecified".

Ok, make sense.  So lets keep that behavior, and let every negative
value mean default so that we don't need another error check here.
Rest of the comments above still stands.

> >> +#define NVMET_DEFAULT_INLINE_DATA_SIZE	-1
> > 0 makes much more sense as the default, and then we don't even need
> > a name for it.
> 
> I wanted the user to be able to disable inline by setting it to 0.? Is
> that not needed?? Maybe by adding back the nvmet_fabrics_ops field will
> alleviate this issue.? Perhaps a default_inline_size field that rdma
> sets to PAGE_SIZE.? Then configfs can default it to that.?

As said above I think we can keep the negative means default, I'd
still use the plain -1 instead of a define there.

> 
> >> +#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
> >> +#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
> > So for 64k pages the minimum is bigger than the maximum? :)
> 
> For 64k pages, the default is 64K and the max is 64K.

Indeed, sorry.
