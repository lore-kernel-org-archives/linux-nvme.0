Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2295FD29FB8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wh33XYvE3EFXD0lyYJ/X+nZuzGwRO1/pcvc5Ri3nWQY=; b=L1jKdGgRqVKyUKiMbTFY/MnRDa
	IYvjKjnSV2PD105suPjvkmy8+cT8agpsupW9qY0bJ2QOs+OTrVjNPZ6PYb9jV3uZybaQf5+tya3a3
	JbwcDhm12Iqka4EjUvii46VfUk1ID1cBn+qpv5GRoWL1eMfhE98zWp5Sg91LAs92AJkktGRn+pYYt
	ygj/c6Rirk0tuf1t7M+BqL5iqq1dBebdYF+elpp24IGKy062Jch+9DDZoLP+APTxOY999INHmbErT
	AldUKnKtmgExL5EVPVKhFs2gHlKhZMDOIz5yK5+Z5sIhkb2HpCojK9wHIEOmsER7/LvzPbpfgfFot
	wxzk8McA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8b0o-00000002DIj-2Y42;
	Wed, 06 Nov 2024 08:03:34 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8aui-00000002C2D-2PbL
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 07:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730879831; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Wh33XYvE3EFXD0lyYJ/X+nZuzGwRO1/pcvc5Ri3nWQY=;
	b=RPkycmOv0u01sxTITxQVSWGubrmhnLGD7YdbPZIohSlTMQGzg/mULCELn2WR3I9rYbpqtG2r9/GHkuD8ks7yCk4FVvMx59WW9ZyLgiaoo8n1BqVsaKFi/YXZQeDIjAJeomoX+mQncMh3hrqiXRYraa8OnZ6jfGsawc5JkkCjgVA=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIqM5cS_1730879826 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 15:57:07 +0800
Message-ID: <9614c5af-7418-47b9-833e-388cdf1bdca4@linux.alibaba.com>
Date: Wed, 6 Nov 2024 15:57:06 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv3 11/11] nvme: add rotational support
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-12-kbusch@meta.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241105174904.3612888-12-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_235717_148643_ADD61570 
X-CRM114-Status: GOOD (  17.47  )
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


在 2024/11/6 01:49, Keith Busch 写道:
> From: Matias Bjørling <matias.bjorling@wdc.com>
>
> Rotational devices, such as hard-drives, can be detected using
> the rotational bit in the namespace independent identify namespace
> data structure. Make the bit visible to the block layer through the
> rotational queue setting.
>
> Note that rotational devices typically can be used to generate random
> entropy, the device is therefore also added as a block device that adds
> entropy.
>
> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   include/linux/nvme.h     | 1 +
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4361fc7e8a225..a47149858be59 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -42,6 +42,7 @@ struct nvme_ns_info {
>   	bool is_readonly;
>   	bool is_ready;
>   	bool is_removed;
> +	bool is_rotational;
>   };
>   
>   unsigned int admin_timeout = 60;
> @@ -1615,6 +1616,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
>   		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
>   		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
>   		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
> +		info->is_rotational = id->nsfeat & NVME_NS_ROTATIONAL;
>   	}
>   	kfree(id);
>   	return ret;
> @@ -2162,6 +2164,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	else
>   		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
>   
> +	if (info->is_rotational)
> +		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;
> +

May I pose a question, what does BLK_FEAT_ADD_RANDOM do?

I see the scsi call add_disk_randomness() in scsi_end_request() if 
request_queue has

BLK_FEAT_ADD_RANDOM flag, but I dont see any calls in the patchset.

Best Regards,

Guixin Liu

>   	/*
>   	 * Register a metadata profile for PI, or the plain non-integrity NVMe
>   	 * metadata masquerading as Type 0 if supported, otherwise reject block
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 9bd37ec01c072..5976285192ae4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -563,6 +563,7 @@ enum {
>   	NVME_NS_FLBAS_LBA_SHIFT	= 1,
>   	NVME_NS_FLBAS_META_EXT	= 0x10,
>   	NVME_NS_NMIC_SHARED	= 1 << 0,
> +	NVME_NS_ROTATIONAL	= 1 << 4,
>   	NVME_LBAF_RP_BEST	= 0,
>   	NVME_LBAF_RP_BETTER	= 1,
>   	NVME_LBAF_RP_GOOD	= 2,

