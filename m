From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 09:35:11 +0200
Subject: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180626145532.GA6628@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-2-jthumshirn@suse.de>
 <20180626145532.GA6628@localhost.localdomain>
Message-ID: <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>

On Tue, Jun 26, 2018@08:55:32AM -0600, Keith Busch wrote:
> On Tue, Jun 26, 2018@03:51:40PM +0200, Johannes Thumshirn wrote:
> > @@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> >  	}
> >  
> >  	cmd->common.command_id = req->tag;
> > +	nvme_req(req)->ctrl = ctrl;
> >  	if (ns)
> >  		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
> >  	else
> 
> I don't think we need to do this per-io. The request coming from the
> controller's tagset, so we can do this just once at .init_request time,
> right?

Agreed, but as it's Sagi's patch I'd like to hear his opinion on this
before changing it.

Byte,
       Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
