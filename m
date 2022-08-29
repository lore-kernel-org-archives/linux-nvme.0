Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3336ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFw13/JpuwM6WmRRIWNkIvgmdmbGu76vHOYFOSWSQ/U=; b=0L0Resj2skwaqEYJkzAoCVWn1k
	gxy/Ox1EV1Gab6CbWifQwWNl2fOlB4/OKNuEOJ6RmI9sO3MTK94nNbzRAe4I5EFymko/6MTgtACXM
	A1ULMQ7uBgJLpbYYU1IwKh/mpBPhzYnQXI5qt/yRP8XY3dd9Kv5iGI/cV69RYtI+4jOseWe6Gp8d9
	6wHCV4DfoX1dcsh+1ZhXiYxmzdP4kB2zTXdHaT9igVyHZn6Ui5WuYttBSMid0PU0ccF1xMBNK9ddL
	iqrlPhEFWYOvDALMH1nwK8Jjin4rPZurlSjigC+sLjlM1sb+tp4V11khvc2ZLYJrxLZNJs3edUvti
	/IjRYhOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSfGs-00AspS-1d; Mon, 29 Aug 2022 13:57:46 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSedR-00Ac8S-3T
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 13:17:04 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGW7m2h1fzYd16;
	Mon, 29 Aug 2022 21:12:36 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 21:16:58 +0800
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
To: Max Gurtovoy <mgurtovoy@nvidia.com>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
Date: Mon, 29 Aug 2022 21:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_061701_827118_68133AC1 
X-CRM114-Status: GOOD (  21.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2022/8/29 18:43, Max Gurtovoy wrote:
> hi,
> 
> On 8/29/2022 11:12 AM, Chao Leng wrote:
>> Now some rdma HBA alread support DIX-DIF: host buffer to host HBA use
>> DIX, host HBA to target use DIF.
>> This patch add DIX support for nvme-rdma.
>> Test results:
>> The performance of different I/O sizes all be optimized.
>> The CPU usage of 256k size I/Os can reduce more than 20%.
> 
> You're adding a new PI guard type for 16bit mode only, aren't you ?
No, Now DIX just be defined for 16bit mode.
> 
> I don't think the subject and commit message is correct.
> 
> Can you attach to commit message please the table of performance numbers before and after the patch ?ok, I will give you the detailed performance numbers later.
> 
> You can mention that also in iser, if supported, the default is to use IP_CHECKSUM for DIX and not CRC.
According to DIX define:DIX = IP_CHECKSUM.
To reduce CPU utilization, the end-to-end DIF for SCSI protocols is DIX-DIF when supported by hardware.
> 
> 
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 19 ++++++++++++++-----
>>   drivers/nvme/host/nvme.h |  1 +
>>   drivers/nvme/host/rdma.c | 24 ++++++++++++++++--------
>>   3 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2429b11eb9a8..7055d3b7b582 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1623,7 +1623,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>>   static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>> -                u32 max_integrity_segments)
>> +                u32 max_integrity_segments, bool dix_support)
>>   {
>>       struct blk_integrity integrity = { };
>> @@ -1631,7 +1631,11 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>>       case NVME_NS_DPS_PI_TYPE3:
>>           switch (ns->guard_type) {
>>           case NVME_NVM_NS_16B_GUARD:
>> -            integrity.profile = &t10_pi_type3_crc;
>> +            if (dix_support)
>> +                integrity.profile = &t10_pi_type3_ip;
>> +            else
>> +                integrity.profile = &t10_pi_type3_crc;
>> +
>>               integrity.tag_size = sizeof(u16) + sizeof(u32);
>>               integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>>               break;
>> @@ -1649,7 +1653,11 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>>       case NVME_NS_DPS_PI_TYPE2:
>>           switch (ns->guard_type) {
>>           case NVME_NVM_NS_16B_GUARD:
>> -            integrity.profile = &t10_pi_type1_crc;
>> +            if (dix_support)
>> +                integrity.profile = &t10_pi_type1_ip;
>> +            else
>> +                integrity.profile = &t10_pi_type1_crc;
>> +
>>               integrity.tag_size = sizeof(u16);
>>               integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>>               break;
>> @@ -1674,7 +1682,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>>   }
>>   #else
>>   static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>> -                u32 max_integrity_segments)
>> +                u32 max_integrity_segments, bool dix_support)
>>   {
>>   }
>>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
>> @@ -1900,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>           if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>>               (ns->features & NVME_NS_METADATA_SUPPORTED))
>>               nvme_init_integrity(disk, ns,
>> -                        ns->ctrl->max_integrity_segments);
>> +                        ns->ctrl->max_integrity_segments,
>> +                        ns->ctrl->dix_support);
>>           else if (!nvme_ns_has_pi(ns))
>>               capacity = 0;
>>       }
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index bdc0ff7ed9ab..92cf93cf120b 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -276,6 +276,7 @@ struct nvme_ctrl {
>>       u32 max_hw_sectors;
>>       u32 max_segments;
>>       u32 max_integrity_segments;
>> +    bool dix_support;
>>       u32 max_discard_sectors;
>>       u32 max_discard_segments;
>>       u32 max_zeroes_sectors;
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 3100643be299..0f63b626b3d4 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -872,6 +872,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>>           IBK_INTEGRITY_HANDOVER)
>>           pi_capable = true;
>> +    if (ctrl->device->dev->attrs.sig_guard_cap & IB_GUARD_T10DIF_CSUM)
>> +        ctrl->ctrl.dix_support = true;
>> +
>>       ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
>>                               pi_capable);
>> @@ -1423,10 +1426,10 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>>   static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>>           struct nvme_command *cmd, struct ib_sig_domain *domain,
>> -        u16 control, u8 pi_type)
>> +        u16 control, u8 pi_type, enum ib_t10_dif_bg_type dif_type)
>>   {
>>       domain->sig_type = IB_SIG_TYPE_T10_DIF;
>> -    domain->sig.dif.bg_type = IB_T10DIF_CRC;
>> +    domain->sig.dif.bg_type = dif_type;
>>       domain->sig.dif.pi_interval = 1 << bi->interval_exp;
>>       domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>>       if (control & NVME_RW_PRINFO_PRCHK_REF)
>> @@ -1441,7 +1444,7 @@ static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>>   static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>>           struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs,
>> -        u8 pi_type)
>> +        u8 pi_type, bool dix_support)
>>   {
>>       u16 control = le16_to_cpu(cmd->rw.control);
>> @@ -1450,16 +1453,20 @@ static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>>           /* for WRITE_INSERT/READ_STRIP no memory domain */
>>           sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
>>           nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
>> -                     pi_type);
>> +                     pi_type, IB_T10DIF_CRC);
>>           /* Clear the PRACT bit since HCA will generate/verify the PI */
>>           control &= ~NVME_RW_PRINFO_PRACT;
>>           cmd->rw.control = cpu_to_le16(control);
>>       } else {
>>           /* for WRITE_PASS/READ_PASS both wire/memory domains exist */
>>           nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
>> -                     pi_type);
>> -        nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control,
>> -                     pi_type);
>> +                     pi_type, IB_T10DIF_CRC);
>> +        if (dix_support)
>> +            nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
>> +                    control, pi_type, IB_T10DIF_CSUM);
>> +        else
>> +            nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
>> +                    control, pi_type, IB_T10DIF_CRC);
>>       }
>>   }
>> @@ -1501,7 +1508,8 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
>>           goto mr_put;
>>       nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
>> -                req->mr->sig_attrs, ns->pi_type);
>> +                req->mr->sig_attrs, ns->pi_type,
>> +                ns->ctrl->dix_support);
>>       nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
>>       ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
> .

