From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 20 Jul 2016 08:51:03 -0500
Subject: [PATCH 1/3] iw_cm: free cm_id resources on the last deref
In-Reply-To: <578F3B92.2050803@grimberg.me>
References: <cover.1468879135.git.swise@opengridcomputing.com>
 <93c3c47c16406ef00184011948424a9597e4c6b8.1468879135.git.swise@opengridcomputing.com>
 <578F3B92.2050803@grimberg.me>
Message-ID: <027401d1e28d$c15bcca0$441365e0$@opengridcomputing.com>


> 
> > Remove the complicated logic to free the cm_id resources in iw_cm event
> > handlers vs when an application thread destroys the device.  I'm not sure
> > why this code was written, but simply allowing the last deref to free
> > the memory is cleaner.  It also prevents a deadlock when applications
> > try to destroy cm_id's in their cm event handler function.
> 
> The description here is misleading. we can never destroy the cm_id
> inside the cm_id handler. Also, I don't think the deadlock was on cm_id
> removal but rather on the qp referenced by the cm_id. I think the change
> log can be improved.
>

I'll reword it. 
 
> The patch looks fine to me.
