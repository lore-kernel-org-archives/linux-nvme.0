From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 13 Jul 2016 09:28:07 -0500
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <578613C8.7030005@grimberg.me>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org> <577005C3.4000802@grimberg.me>
 <20160628084105.GA13533@lst.de>
 <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>
 <010501d1d216$86c0f0c0$9442d240$@opengridcomputing.com>
 <20160630063637.GB5191@lst.de>
 <002c01d1d2d5$777d9180$6678b480$@opengridcomputing.com>
 <57861339.7090705@grimberg.me> <578613C8.7030005@grimberg.me>
Message-ID: <001f01d1dd12$c5fb8500$51f28f00$@opengridcomputing.com>

 
> 
> > Hi Steve,
> >
> > Sorry for the late response, I was on vacation.
> >
> > The patch looks fine,
> >
> > Reviewed-by: Sagi Grimberg <sagi at imberg.me>
> 
> Although, I think that we really should fix the
> double completion for unsignaled wqes in cxgb4...
> it might bite us elsewhere down the road.

Double completion?  When the QP exits RTS with pending unsignaled SQ WRs, cxgb4
doesn't know if those were actually completed by hardware, so they are completed
with FLUSH_ERR status.  I _could_ change cxgb4 to just eat those, but I'm a
little worried about breaking the iWARP Verbs semantics.  Perhaps I shouldn't
be.  It does seem to be causing lots of pain...
