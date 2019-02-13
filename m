From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 13 Feb 2019 13:51:35 -0500
Subject: [PATCH] scsi: lpfc: fix calls to dma_set_mask_and_coherent()
In-Reply-To: <20190212183452.GA25206@infradead.org>
References: <20190211150502.9999-1-emilne@redhat.com>
 <20190212080627.GC10547@infradead.org>
 <9572ae3b0131ad1c74d6a775f819437e3d4f1795.camel@redhat.com>
 <20190212183452.GA25206@infradead.org>
Message-ID: <b6c893813618e954e726e5182ec36e8d6ee170b4.camel@redhat.com>

On Tue, 2019-02-12@10:34 -0800, Christoph Hellwig wrote:
> On Tue, Feb 12, 2019@10:37:45AM -0500, Ewan D. Milne wrote:
> > 
> > It looks like this would introduce a different problem.  "error" is set to
> > -ENODEV earlier in the two functions so that the various error paths will return
> > that value.  If it is overwritten with a successful result from the call to
> > dma_set_mask_and_coherent() but a later call to e.g. ioremap() fails, the
> > functions will incorrectly return a value indicating that they have succeeded.
> > 
> > It also appears as if the patches to hptiop, hisi_sas and bfa need to be fixed up.
> > I don't have a test environment for these, although I might be able to modify the
> > test environment for bfa.  Martin/James, what about the others?
> 
> I don't have a test environment for them either, and I doubt many
> people have.  If you don't feel comfortable I can send a fix for
> them.

[ removed cc: stable ]

Thanks, I have the patches written but Hannes has posted already.
I prefer to test before posting but in this case testing one driver with
a similar pattern is better than not having a fix available, I think.
As long as it gets enough review.

-Ewan
