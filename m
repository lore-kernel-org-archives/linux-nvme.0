From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Oct 2018 16:54:50 -0600
Subject: [PATCH 04/16] nvme-core: Complain if nvme_init_identify() fails
In-Reply-To: <1539037602.64374.42.camel@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-5-bvanassche@acm.org>
 <20181008221650.GA5979@localhost.localdomain>
 <1539037602.64374.42.camel@acm.org>
Message-ID: <20181008225450.GA6023@localhost.localdomain>

On Mon, Oct 08, 2018@03:26:42PM -0700, Bart Van Assche wrote:
> On Mon, 2018-10-08@16:16 -0600, Keith Busch wrote:
> > On Mon, Oct 08, 2018@02:28:42PM -0700, Bart Van Assche wrote:
> > > This patch avoids that Coverity complains that some but not all callers of
> > > nvme_init_identify() check the return value of that function. See also
> > > Coverity ID 1423964.
> > 
> > That seems like an odd thing to complain about. If we required the
> > return value be checked, we have the "__must_check" attribute. In this
> > particular path, we don't care if nvme_init_identify returns an error,
> > and the failure is logged in kernel messages within the function already.
> > 
> > Is there another way to suppress the complaint?
> 
> One way is to change nvme_init_identify(ctrl) into the following:
> 
> if (nvme_init_identify(ctrl) < 0) {
> }
> 
> However, I'm not sure we should do that. Another possibility is to mark the
> complaint in the Coverity database as "intended". That means that the return
> value is ignored on purpose.

Right, I was hoping for a way to suppress the complaint without changing
the code since it is intended as-is.
