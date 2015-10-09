From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 9 Oct 2015 14:11:54 -0600
Subject: [PATCH 3/3] nvme: refactor nvme_queue_rq
In-Reply-To: <1444409756-7317-4-git-send-email-hch@lst.de>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
 <1444409756-7317-4-git-send-email-hch@lst.de>
Message-ID: <20151009201154.GA29924@localhost.localdomain>

Hi Christoph,

> +	if (!nvme_setup_prps(dev, iod, blk_rq_bytes(req)))
> +	    	goto out_unmap;
Git am complains about whitespacing here.


The set looks fine to me. I'm tempted to do some performance testing with the microoptimizations present here. Have you seen any results yourself?
