From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 May 2016 17:39:54 -0400
Subject: [PATCHv2] NVMe: Sync reset and scan work
In-Reply-To: <20160524155938.wzzsmje6bhlkghwk@c203.arch.suse.de>
References: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
 <20160524155938.wzzsmje6bhlkghwk@c203.arch.suse.de>
Message-ID: <20160524213954.GD24347@localhost.localdomain>

On Tue, May 24, 2016@05:59:38PM +0200, Johannes Thumshirn wrote:
> On Tue, May 24, 2016@09:06:10AM -0600, Keith Busch wrote:
> >  
> > +static int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> > +{
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
> > +		return -EPERM;
> 
> Is there a specific reason why you're using EPERM instead of EINVAL? I always
> understood EPERM as a privilege level error code, while EINVAL would be a more
> appropriate error code for an illegal state transition, IMHO.

The EPERM description sounded about right: "Operation not permitted". The
user just attempted a reset at an impermissable time, but didn't give any
illegal arguments. The exact same action could very well be successful
a moment later. Maybe EBUSY or EAGAIN?
