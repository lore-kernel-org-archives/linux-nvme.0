From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 13 Jul 2016 10:12:04 -0500
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <57865802.1030408@grimberg.me>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org> <577005C3.4000802@grimberg.me>
 <20160628084105.GA13533@lst.de>
 <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>
 <010501d1d216$86c0f0c0$9442d240$@opengridcomputing.com>
 <20160630063637.GB5191@lst.de>
 <002c01d1d2d5$777d9180$6678b480$@opengridcomputing.com>
 <57861339.7090705@grimberg.me> <578613C8.7030005@grimberg.me>
 <001f01d1dd12$c5fb8500$51f28f00$@opengridcomputing.com>
 <57865479.1080707@grimberg.me>
 <005501d1dd16$1a32f060$4e98d120$@opengridcomputing.com>
 <57865802.1030408@grimberg.me>
Message-ID: <006101d1dd18$ea3524c0$be9f6e40$@opengridcomputing.com>

> 
> 
> >> Think of a case where we posted unsignaled send, got a successful reply
> >> from the peer, now we drain the qp, and the send which belongs to a
> >> transaction that we already completed is flush with error. Does that
> >> sound like a correct behavior?
> >
> > Well, from the specification, yes.    From
> > https://tools.ietf.org/html/draft-hilland-rddp-verbs-00#section-8.1.3.1 :
> >
> > ----
> > An Unsignaled WR is defined as completed successfully when all of
> >     the following rules are met:
> >
> >
> >     *   A Work Completion is retrieved from the CQ associated with the
> >         SQ where the unsignaled Work Request was posted,
> >
> >     *   that Work Completion corresponds to a subsequent Work Request on
> >         the same Send Queue as the unsignaled Work Request, and
> >
> >     *   the subsequent Work Request is ordered after the unsignaled Work
> >         Request as per the ordering rules. Depending on the Work Request
> >         used, this may require using the Local Fence indicator in order
> >         to guarantee ordering.
> > ---
> 
> OK, thanks for educating me :)
>

No problem. :)  By the way, IB Verbs has the same rules.  From 1.3 of the IBTA
spec:
----
10.8.6 UNSIGNALED COMPLETIONS

An unsignaled Work Request that completed successfully is confirmed
when all of the following rules are met:

. A Work Completion is retrieved from the same CQ that is associated
with the Send Queue to which the unsignaled Work Request
was submitted.

. That Work Completion corresponds to a subsequent Work Request
on the same Send Queue as the unsignaled Work Request.

C10-108: The CI shall not access buffers associated with an Unsignaled
Work Request once a Work Completion has been retrieved that corresponds
to a subsequent Work Request on the same Send Queue.
----

 
> > So in your example, even though the application knows the SEND made it
because
> > the peer replied and genereated an RQ completion, the iwarp provider does
not
> > know the SEND made it...
> 
> So we have two options here:
> 
> 1. always make sure not to free anything related to SQEs until we
> destroy the QP (hopefully won't bite us again, which is not a good
> bet given that the sequence is not trivial).
> 
> 2. always signal sends for iWARP (yukk...)
> 
> I pick poison 1 (for now...)
>

I agree.
