From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jun 2015 15:04:28 +0000 (UTC)
Subject: [PATCH] NVMe: Remove the redundant sg_mar_end()
In-Reply-To: <1434626571-1652-1-git-send-email-wangyijing@huawei.com>
References: <1434626571-1652-1-git-send-email-wangyijing@huawei.com>
Message-ID: <alpine.LNX.2.00.1506181458240.15930@localhost.lm.intel.com>

On Thu, 18 Jun 2015, Yijing Wang wrote:
> sg_init_table() already called sg_mark_end(),
> remove the redundant one.

Your repository must be pointing to an older branch. This function doesn't
exist in the most current driver staged in the linux-block/for-next tree.

> @@ -1708,7 +1708,6 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
> 		length -= (PAGE_SIZE - offset);
> 		offset = 0;
> 	}
> -	sg_mark_end(&sg[i - 1]);
> 	iod->nents = count;
>
> 	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
