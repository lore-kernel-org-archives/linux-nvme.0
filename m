From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 8 May 2015 15:03:51 -0400
Subject: [PATCH 04/11] nvme: remove the unused dma_addr_t arguments to
 nvme_{get, set}_features
In-Reply-To: <1431100836-28112-5-git-send-email-hch@lst.de>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
 <1431100836-28112-5-git-send-email-hch@lst.de>
Message-ID: <20150508190351.GM4003@linux.intel.com>

On Fri, May 08, 2015@06:00:29PM +0200, Christoph Hellwig wrote:
>  int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
> -					dma_addr_t dma_addr, u32 *result)
> +		u32 *result)
>  {
>  	struct nvme_command c;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.features.opcode = nvme_admin_get_features;
>  	c.features.nsid = cpu_to_le32(nsid);
> -	c.features.prp1 = cpu_to_le64(dma_addr);
>  	c.features.fid = cpu_to_le32(fid);
>  
>  	return __nvme_submit_sync_cmd(dev->admin_q, &c, result, 0);

Wait, what?  The PRP1 field is used for LBA Range Type and Autonomous
Power State Transitions.
