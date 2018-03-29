From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 29 Mar 2018 10:15:21 -0600
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
In-Reply-To: <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
Message-ID: <bb89dec3-97d9-67a1-f62e-05aac713a13e@deltatee.com>



On 29/03/18 10:14 AM, Bart Van Assche wrote:
> On Thu, 2018-03-29@10:07 -0600, Logan Gunthorpe wrote:
>> +	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
>> +			    ((fod->io_dir == NVMET_FCP_WRITE) ?
>> +				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
>> +			    /* note: write from initiator perspective */
> 
> If you have to repost this patch please remove the four superfluous parentheses.

Ok, will do.

Thanks,

Logan
