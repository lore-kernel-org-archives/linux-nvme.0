From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 09:15:49 +0100
Subject: [PATCH 2/4] nvmet: fix computation of io vector number
In-Reply-To: <CACVXFVNTOVcP7N_MCZ+JEUJX09WUH0Ds3yZ_DELrSkAfPEDrpg@mail.gmail.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-3-ming.lei@redhat.com> <20190326073800.GB21617@lst.de>
 <CACVXFVNTOVcP7N_MCZ+JEUJX09WUH0Ds3yZ_DELrSkAfPEDrpg@mail.gmail.com>
Message-ID: <20190327081549.GF20525@lst.de>

On Tue, Mar 26, 2019@03:50:01PM +0800, Ming Lei wrote:
> On Tue, Mar 26, 2019@3:38 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I'd rather see this merged with the last one (and patch 3 dropped as
> > it just gets removed entirely in 4) - that fixes all the issues together
> > and doesn't require your patch 1 as as a workaround first.
> 
> Patch 1 isn't a workaround, which is needed for stable tree, and
> the other fixes won't work without patch 1.
> 
> However, we may revert patch 1 for 5.1 in which multi-page bvec
> is supported.

Lets do it another way around - put the proper fix into 5.1-rc and
only apply patch 1 for stable.  No need to put something in and
immediately revert it.
