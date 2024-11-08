Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0519D5D69F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wS2GdrPgnV4644iPyjTnHKmy0rH65KGjhemfSICXkPM=; b=WkI7jGSDTz3v02LiIwUnM255x7
	iYakyY0kgZ1SuGtpGpymgBtl6esC+hhXUvmkrJm34Dd9dW+B66hATwxYSvnSFrIwuVJ1PfthMmadp
	EYRHLxr84PqxELbrS5/vCk6hh4hx28AQUa2AFU7pIBvcnHUiFt9iRlBVc5CgWbhDvQ5TduFK71NtT
	ywbtEnMgfatFPK4zJKLMPegFOXKkHlAZEGX9eHbxMZ5gh6aNAhgwrT7Ps48UgO1ogkSz/Pl1jJzjQ
	JaSXEG/6tjFdbYCgIUIV+4IFE1xpS++fHkuU0Wrampy/0Q/Xezsst+oD3pa5O9uz4LuJp4BiWox9W
	MfoOMd1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9E1T-00000008xVU-0BJX;
	Fri, 08 Nov 2024 01:42:51 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9E1Q-00000008xTo-28jD
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 01:42:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731030164; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wS2GdrPgnV4644iPyjTnHKmy0rH65KGjhemfSICXkPM=;
	b=h486Uvu1yaP1BXlxES8WBjlCqhJ/EvILiO+GnWdeL76+5B439hIqHpt4X3dBxCdn8QM++jJhX+fjr4O5j5p4/VX5yKl9b/BTwhsHdQqfCFhcJnfqaXX2I+WnyUaQVxlfWEz52kcpvFb3mj8PUNNKOJMhnaOFoMy/DfEwoegmjp4=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIx8lGh_1731030161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 09:42:43 +0800
Message-ID: <527bc309-6695-470d-aa02-33e89eb73b08@linux.alibaba.com>
Date: Fri, 8 Nov 2024 09:42:40 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv4 09/13] nvmet: implement csi identify ns
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com, kch@nvidia.com,
 Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-10-kbusch@meta.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241107193849.995554-10-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_174249_023465_4525E4BC 
X-CRM114-Status: GOOD (  12.81  )
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


在 2024/11/8 03:38, Keith Busch 写道:
> From: Keith Busch <kbusch@kernel.org>
>
> Implements reporting the I/O Command Set Independent Identify Namespace
> command.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
>   include/linux/nvme.h            |  1 +
>   2 files changed, 33 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 6d3a1d2103bf3..516af7b419189 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -893,6 +893,35 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep *id;
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	id->nstat = NVME_NSTAT_NRDY;
> +	id->anagrpid = req->ns->anagrpid;

Well, I think you overlooked my comments for v3,

should use cpu_to_le32(req->ns->anagrpid) here.

Best Regards,

Guixin Liu

> +	id->nmic = NVME_NS_NMIC_SHARED;
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> +		id->nsfeat |= NVME_NS_ROTATIONAL;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -940,6 +969,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
>   		nvmet_execute_identify_nslist(req, true);
>   		return;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_id_cs_indep(req);
> +		return;
>   	case NVME_ID_CNS_ENDGRP_LIST:
>   		nvmet_execute_identify_endgrp_list(req);
>   		return;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 93a0abfab5b0e..22375c87591a2 100644
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

