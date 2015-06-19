From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 19 Jun 2015 09:19:34 +0800
Subject: [PATCH] NVMe: Remove the redundant sg_mar_end()
In-Reply-To: <alpine.LNX.2.00.1506181458240.15930@localhost.lm.intel.com>
References: <1434626571-1652-1-git-send-email-wangyijing@huawei.com>
 <alpine.LNX.2.00.1506181458240.15930@localhost.lm.intel.com>
Message-ID: <55836E26.8070206@huawei.com>

On 2015/6/18 23:04, Keith Busch wrote:
> On Thu, 18 Jun 2015, Yijing Wang wrote:
>> sg_init_table() already called sg_mark_end(),
>> remove the redundant one.
> 
> Your repository must be pointing to an older branch. This function doesn't
> exist in the most current driver staged in the linux-block/for-next tree.

Sorry, my repository is linus's master branch, this code has been removed in latest nvme-core.c, please drop this patch.

Thanks!
Yijing.

> 
>> @@ -1708,7 +1708,6 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
>>         length -= (PAGE_SIZE - offset);
>>         offset = 0;
>>     }
>> -    sg_mark_end(&sg[i - 1]);
>>     iod->nents = count;
>>
>>     nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
> 
> 


-- 
Thanks!
Yijing
