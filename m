From: hch@lst.de (Christoph Hellwig)
Date: Fri, 27 Jul 2018 17:14:01 +0200
Subject: [PATCH V2] nvmet: use Retain Async Event bit to clear AEN
In-Reply-To: <4af8eacd-cddc-9327-0580-fa045ff0170d@suse.de>
References: <20180726210041.15129-1-chaitanya.kulkarni@wdc.com>
 <4af8eacd-cddc-9327-0580-fa045ff0170d@suse.de>
Message-ID: <20180727151401.GA30285@lst.de>

On Fri, Jul 27, 2018@03:18:06PM +0200, Hannes Reinecke wrote:
> >  	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
> > @@ -176,7 +189,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
> >  	if (!status)
> >  		status = nvmet_zero_sgl(req, len, req->data_len - len);
> >  	ctrl->nr_changed_ns = 0;
> > -	clear_bit(NVME_AEN_CFG_NS_ATTR, &ctrl->aen_masked);
> > +	nvmet_clear_aen(req, NVME_AEN_CFG_NS_ATTR);
> >  	mutex_unlock(&ctrl->lock);
> >  out:
> >  	nvmet_req_complete(req, status);
> > 
> Doesn't this apply to the NS CHANGED log page, too?

That code is the changes ns log page..

> IIRC RAE is a generic bit, and not restricted to implementation in
> individual log pages ...

Somewhat generic - only for log pages that have an associated AEN.
The only other one is the ana change log in the ana series.  I'll
make sure to cover that as well when merging this patch and the ANA
series.
