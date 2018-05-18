From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 18 May 2018 11:36:22 -0500
Subject: [PATCH RFC v2 2/2] nvmet-rdma: support 16K inline data
In-Reply-To: <20180518090852.GE24436@lst.de>
References: <cover.1526505524.git.swise@opengridcomputing.com>
 <e3c4d8a638b989aef554646d235aa45d633d9565.1526505524.git.swise@opengridcomputing.com>
 <20180517115203.GB30345@lst.de>
 <76914471-8d8a-cdec-e952-24b1e9a5ed72@opengridcomputing.com>
 <20180518090852.GE24436@lst.de>
Message-ID: <017801d3eec6$5b70c9d0$12525d70$@opengridcomputing.com>

> 
> On Thu, May 17, 2018@09:24:57AM -0500, Steve Wise wrote:
> > >> +	ret = kstrtouint((const char *)page, 0, &size);
> > > This cast looks bogus.
> > >
> > > Also inline_data_size shoul be and u32 as that is closest to what
> > > is on the wire, and you thus should use kstrtou32 and pass the
> > > inline_data_size straight to kstrtou32 instead of bouncing it through
> > > a local variable.
> >
> > I made it an int so it could be initialized to -1 indicating it is not
> > set by the config.? This allows the rdma transport to use its default
> > value if the config does not specify any value.? I did this so the admin
> > could totally disable inline by specifying 0.?? So I needed a value that
> > indicates "unspecified".
> 
> Ok, make sense.  So lets keep that behavior, and let every negative
> value mean default so that we don't need another error check here.
> Rest of the comments above still stands.

Agreed.  

Looking at nvmet_rdma_alloc_cmd(), I think I'll also need to fix rdma.c to
support no inline data usage.

Thanks!

Steve.
