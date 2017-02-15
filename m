From: parav@mellanox.com (Parav Pandit)
Date: Wed, 15 Feb 2017 14:51:21 +0000
Subject: [PATCH] nvmet: Fixed avoided printing nvmet: twice in error logs.
In-Reply-To: <07938b52-ca0c-f2bb-d8f8-4964475edf93@grimberg.me>
References: <1486591039-1177-1-git-send-email-parav@mellanox.com>
 <07938b52-ca0c-f2bb-d8f8-4964475edf93@grimberg.me>
Message-ID: <VI1PR0502MB30084AD770E0262118E8443CD15B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Ok. I will a patch set with two patches in it as they will be dependent.
Thanks for the review.

> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Wednesday, February 15, 2017 2:55 AM
> To: Parav Pandit <parav at mellanox.com>; hch at lst.de; linux-
> nvme at lists.infradead.org
> Subject: Re: [PATCH] nvmet: Fixed avoided printing nvmet: twice in error
> logs.
> 
> 
> > This patch avoids printing "nvmet:" twice in error logs as its already
> > coming through pr_fmt macro.
> > It makes some of the logs more verbose by including qid to it.
> > It avoid code duplication for checking controller status for admin and
> > io queue by having common function for both that further can be reused
> > by other transports.
> > Fixed typo reported by Max Gurtovoy.
> 
> Hey Parav,
> 
> This looks good but please split this patch to:
> 1. nvmet_check_ctrl_status()
> 2. remove "nvmet:" from logging
> 
> > @@ -645,6 +645,22 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn,
> const char *hostnqn, u16 cntlid,
> >  	return status;
> >  }
> >
> > +int nvmet_check_ctrl_status(struct nvmet_req *req, struct
> > +nvme_command *cmd)
> 
> Please return u16 status here.
