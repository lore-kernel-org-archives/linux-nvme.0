From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 May 2015 16:35:37 +0000 (UTC)
Subject: [PATCH 04/11] nvme: remove the unused dma_addr_t arguments to
 nvme_{get, set}_features
In-Reply-To: <20150511135425.GO4003@linux.intel.com>
References: <1431100836-28112-1-git-send-email-hch@lst.de>
 <1431100836-28112-5-git-send-email-hch@lst.de>
 <20150508190351.GM4003@linux.intel.com> <20150509155322.GA32628@lst.de>
 <20150511135425.GO4003@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1505111623210.15930@localhost.lm.intel.com>

On Mon, 11 May 2015, Matthew Wilcox wrote:
>                res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
>                                                        dma_addr + 4096, NULL);
>
> Looks like it was (inadvertently?) deleted in February by Keith's patch to
> add metadata support.  Keith?

I recall we talked about this on the mailing list. There didn't seem
to be a reason to use this feature in Linux and it wasn't a complete
implementation from reading only the first range. No objections at the
time to remove it, but I'll add it back if there is one now.
