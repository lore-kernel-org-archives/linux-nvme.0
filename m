Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758B5C6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 01:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YnoP4CfSzRI7B0x8z3TDL7Q7n79xb2O7rBMVbvQQcqA=; b=Z6m6IG6pNPMgZTSXqy2zGMmAhO
	Tx38nT1ytHvuqjJ7nrkwJwBxVJ39zN8B/FKUdYuHOp64IBtz95lkwsPwwRaWgcGhLBlW/cfeRoTd9
	pSB7f4HchFJeqG/Hx5U53YS00+RhRSkD/hUWi7Q9Ld/j7RRI2g5KqkcNa8n1Yr8YygUXDpvrdrfLQ
	P0okpy50/jNCMJ3nzSbX4I/ZrRMm2F0cmWePH3QwpNmCzNTxjVbyoh7P+4nhM4bVMKEf97jktWVa6
	XReskShFlJc2tpzOZrV87z+hBMzhMgzZi1kcxZ2S7iuzQVfiDxKuXvVS5la0hJ3FFAmjzC1NPWetf
	phLKGNVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaoqx-0083zl-E2; Wed, 21 Sep 2022 01:48:43 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaoqs-0083rz-Jf
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 01:48:41 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MXLn76jNPz14RMs;
	Wed, 21 Sep 2022 09:44:27 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:48:33 +0800
Subject: Re: [PATCH] nvme: copy firmware_rev on each init
To: Keith Busch <kbusch@fb.com>, <linux-nvme@lists.infradead.org>,
	<hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Jeff Lien <jeff.lien@wdc.com>
References: <20220919194508.1704346-1-kbusch@fb.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <50851cfd-ae9b-290d-1d27-942682840e79@huawei.com>
Date: Wed, 21 Sep 2022 09:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220919194508.1704346-1-kbusch@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_184838_868746_43DDE897 
X-CRM114-Status: GOOD (  15.66  )
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



On 2022/9/20 3:45, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The firmware revision can change on after a reset so copy the most
> recent info each time instead of just the first time, otherwise the
> sysfs firmware_rev entry may contain stale data.
> 
> Reported-by: Jeff Lien <jeff.lien@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea6694fd550f..e56ecc7fda2d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2893,7 +2893,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	nvme_init_subnqn(subsys, ctrl, id);
>   	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
>   	memcpy(subsys->model, id->mn, sizeof(subsys->model));
> -	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
>   	subsys->vendor_id = le16_to_cpu(id->vid);
>   	subsys->cmic = id->cmic;
>   
> @@ -3112,6 +3111,8 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   				ctrl->quirks |= core_quirks[i].quirks;
>   		}
>   	}
> +	memcpy(ctrl->subsys->firmware_rev, id->fr,
> +	       sizeof(ctrl->subsys->firmware_rev));
Perhaps it would be better to place it near the call to nvme_init_subsystem.
>   
>   	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
>   		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
> 
Anyway, looks good to me.

Reviewed-by: Chao Leng <lengchao@huawei.com>

