From: keith.busch@intel.com (Keith Busch)
Date: Mon, 31 Jul 2017 03:13:09 -0400
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
 <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
Message-ID: <20170731071309.GD8674@localhost.localdomain>

On Mon, Jul 31, 2017@09:45:37AM +0300, Sagi Grimberg wrote:
> Chaitanya,
> 
> > In order to enable SGL mode for the driver, the user can set the
> > sgl_threshold module parameter. This parameter can be used
> > in the two modes:-
> > 
> > 1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
> > 2. Set up the IO size threshold to determine whether to use
> >      SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
> >      use SGL only for IOs which are >= 4096 in the size).
> 
> The fact that you introduce a sgl_threshold implies that prps
> are better than sgls for small I/O sizes, are sgls better
> than prps to large I/O size?

It can't possibly be just a matter of the IO size. It must be a matter of
physical continuity as well. Considering that each SG entry is twice the
size of a PRP entry, PRP must be faster for a physically discontiguous
buffer if only because the PRP list is half the size.

I've no device to test with, but I'd guess SGL is only better if the
number of SGE's happens to be less than half the number of the equivalent
PRP entries. Something like this:

  if (iod->nents <= ((blk_rq_bytes(req) / dev->page_size) / 2))
    /* Use SGL */
  else
    /* Use PRP */
