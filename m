From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 09:11:12 -0700
Subject: [PATCH 1/2] nvme-rdma: tell fabrics layer admin queue depth
In-Reply-To: <20160808070534.GA12902@lst.de>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-2-git-send-email-james_p_freyensee@linux.intel.com>
 <970b69cc-b439-63ac-b26e-90f3581b49de@grimberg.me>
 <20160808070534.GA12902@lst.de>
Message-ID: <1470672672.3379.3.camel@linux.intel.com>

On Mon, 2016-08-08@09:05 +0200, Christoph Hellwig wrote:
> On Sun, Aug 07, 2016@10:20:38AM +0300, Sagi Grimberg wrote:
> > 
> > No need for admin_sqsize member, its always set to NVMF_AQ_DEPTH-1,
> > just use that...
> 

Ok, but this allows the code to grow into the ASQSZ field (whenever
this is implemented or not), which is done on discovery that each new
controller discovered could have a different size Admin queue field.

But I'm perfectly happy using this,it makes the code a bit easier.

> Agreed.
> 
