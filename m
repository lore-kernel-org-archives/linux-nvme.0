From: minwoo.im@samsung.com (Minwoo Im)
Date: Fri, 26 Apr 2019 08:32:43 +0900
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <1556206735.161891.146.camel@acm.org>
References: <1556206735.161891.146.camel@acm.org>
 <20190411151832.26481-1-minwoo.im.dev@gmail.com>
 <20190425144408.GA17039@lst.de>
 <CGME20190425153912epcas3p3315474cec2b50b074022566cd3fed14d@epcms2p7>
Message-ID: <20190425233243epcms2p7d18d61cb381488a2baf671b0297ab70d@epcms2p7>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Bart Van Assche
> Sent: Friday, April 26, 2019 12:39 AM
> To: Christoph Hellwig; Minwoo Im
> Cc: Keith Busch; Jens Axboe; Sagi Grimberg; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH 0/2] nvme: Check size of command structures
> 
> On Thu, 2019-04-25@16:44 +0200, Christoph Hellwig wrote:
> > I'm not sure we are going a little too crazy with all these
> > BUILD_BUG_ONs.  It would be a lot easier if we could just throw
> > the assert into the struct defintion somehow, but that would need
> > compiler magic..
> 
> How about something like the following just after each structure definition?
> 
> static inline void nvmf_common_command_size_check(void)
> {
>         BUILD_BUG_ON(sizeof(struct nvmf_common_command) != 64);
> }

Agree with that we don't have to BUILD_BUG_ON() in .c level.  If it's in header,
that would be better than as it is now. 
But, I'm concerning that if we do that, per one structure will have a one static
inline function to check the size of it which might make code too long. ;)

> 
> Bart.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
