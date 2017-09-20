From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 20 Sep 2017 14:04:37 +0200
Subject: [PATCH 2/2] nvme-rdma: give up reconnect if state change fails
In-Reply-To: <f1725d24-e8b5-8fcc-255e-58630074aac5@grimberg.me>
References: <1505905573-25371-1-git-send-email-sagi@grimberg.me>
 <1505905573-25371-2-git-send-email-sagi@grimberg.me>
 <20170920112717.qi4txbrbwefw74gx@linux-x5ow.site>
 <f1725d24-e8b5-8fcc-255e-58630074aac5@grimberg.me>
Message-ID: <20170920120437.zhjt5sjeqdckguu4@linux-x5ow.site>

On Wed, Sep 20, 2017@02:29:18PM +0300, Sagi Grimberg wrote:
> 
> > >   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> > > -	WARN_ON_ONCE(!changed);
> > > +	if (!changed) {
> > > +		/* We are probably in DELETING state */
> > 
> > Shouldn't we check if we're really in DELETING instead of just speculating we
> > are?
> 
> I can add a WARN_ONCE.

Works for me.

With that change,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
