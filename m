From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:52:09 +0200
Subject: [PATCH v6 05/10] nvmet: implement namespace identify
 descriptor list
In-Reply-To: <ac55e56a-a47e-1e53-c537-b940de99c746@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-6-jthumshirn@suse.de> <20170608074414.GD13953@lst.de>
 <ac55e56a-a47e-1e53-c537-b940de99c746@suse.de>
Message-ID: <20170608075209.GA14359@lst.de>

On Thu, Jun 08, 2017@09:49:35AM +0200, Johannes Thumshirn wrote:
> On 06/08/2017 09:44 AM, Christoph Hellwig wrote:
> >> +	if (sg_zeroout_area(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE, off)
> > 
> > Shouldn;t the third argument be NVME_IDENTIFY_DATA_SIZE - off in theory?
> > It's probably fine as is as the S/G helpers deal with overflows
> > gracefully, but still..
> 
> Ahm yes. *doh*
> 
> Can you fix it up when applying?

Sure.
