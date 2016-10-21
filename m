From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 21 Oct 2016 16:58:40 -0500
Subject: [PATCH RFC v2 0/3] connect reject event helpers
In-Reply-To: <a46f48f3-01b3-fd9b-b642-c20555759107@grimberg.me>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <a46f48f3-01b3-fd9b-b642-c20555759107@grimberg.me>
Message-ID: <001601d22be6$484e7720$d8eb6560$@opengridcomputing.com>

> 
> 
> > While reviewing:
> >
> > http://lists.infradead.org/pipermail/linux-nvme/2016-October/006681.html
> >
> > I decided to propose transport-agnostic helper functions to better
> > handle connection reject event information.  I've included a nvme_rdma
> > patch to utilize the new helpers.
> >
> > Thoughts?
> 
> Hey Steve,
> 
> This looks nice and useful. Would be great if you can
> also help other ULPs that use this (e.g. srp/srpt)

can-do!
