From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 26 Mar 2019 15:39:14 +0800
Subject: [PATCH 1/4] nvmet: set loop queue's segment boundary mask as
 PAGE_SIZE - 1
In-Reply-To: <CACVXFVODbii+X6M6=k41-gBhWzRQ9vpbsmLnzoJT4wkoi5C7gw@mail.gmail.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-2-ming.lei@redhat.com>
 <20190326073622.GA21617@lst.de>
 <CACVXFVODbii+X6M6=k41-gBhWzRQ9vpbsmLnzoJT4wkoi5C7gw@mail.gmail.com>
Message-ID: <CACVXFVOAZd30hszq_AQU7_yAESRUFh9BqP-p+kK2z+6szTPC1Q@mail.gmail.com>

On Tue, Mar 26, 2019@3:37 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Tue, Mar 26, 2019@3:36 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Note that in many cases allocating larger pages in the other targets
> > would be useful.  Given that you fix the one places where we made a page
> > size assumption I don't see a great need to limit outselves here.
>
> block device backed ns still needs this patch.

Also both the 2nd & 3rd fixes depend on this patch too.


Thanks,
Ming Lei
