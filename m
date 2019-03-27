From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 27 Mar 2019 16:26:26 +0800
Subject: [PATCH 1/4] nvmet: set loop queue's segment boundary mask as
 PAGE_SIZE - 1
In-Reply-To: <20190327081508.GE20525@lst.de>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-2-ming.lei@redhat.com>
 <20190326073622.GA21617@lst.de>
 <CACVXFVODbii+X6M6=k41-gBhWzRQ9vpbsmLnzoJT4wkoi5C7gw@mail.gmail.com>
 <20190327081508.GE20525@lst.de>
Message-ID: <CACVXFVNeSboKKSvYkpTvdVC-Ou-Zun-7ziULcTR3SDM+T_E-ng@mail.gmail.com>

On Wed, Mar 27, 2019@4:15 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 26, 2019@03:37:36PM +0800, Ming Lei wrote:
> > On Tue, Mar 26, 2019@3:36 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Note that in many cases allocating larger pages in the other targets
> > > would be useful.  Given that you fix the one places where we made a page
> > > size assumption I don't see a great need to limit outselves here.
> >
> > block device backed ns still needs this patch.
>
> Then we need to fix that code as well.  Or even better make bio_add_page
> handle the larger than page case fine if it really doesn't do that yet.

Given loop is the only exception, this patch is exactly the fix, right?

Thanks,
Ming Lei
