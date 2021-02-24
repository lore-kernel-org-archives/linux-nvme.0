Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D0C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:59:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480C164EC3
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480C164EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OnLYBK2oZVhEcc/vEuzLqv+JeniNfCjzSq8tZrvOJZs=; b=kAP3m5satR4rcbES0ibNIq2VU
	dDVhpJhOp1mpV5EIwLAl1sWrtM+1dBqM+XfLAgnivUAwVtc8ubkIApfWPHtsLgT/GO0FooHPQp15n
	Y0QJyOaNbhMAfJleGvnPj/LG9Sr+MvCswvEr3UwLMPQC93Da0X1qUsjCnZF2gl1S1RCE3xs9AymUD
	CVgd/sTfihSl0RW6FXE6TtEfZ6WN7g5W/B2era5Vu6mvac212dycqRAiPRv3UD/LxSInI2+2y69KT
	LvU6vUu/+6mzuCPlBC/RF8TNB6dPJt+qzYMrFND1VY+u1yG2Os9ywGw64+b5fEzEcZ8yYt4W1v2Nv
	9DFBx6yAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqxD-0005a7-5j; Wed, 24 Feb 2021 09:59:35 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqxA-0005Zc-8f
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 09:59:33 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6036237f0000>; Wed, 24 Feb 2021 01:59:27 -0800
Received: from [172.27.0.5] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 09:59:25 +0000
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
To: Christoph Hellwig <hch@lst.de>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
 <20210224094347.GA5965@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <119dbae3-9dc8-a5d8-0f35-20d619931db6@nvidia.com>
Date: Wed, 24 Feb 2021 11:59:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224094347.GA5965@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614160767; bh=xkoXJ8dDEw3I1SxMelgAvRW8dTDMncwDdzZZ3fhfT1A=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=cQd5wiVsf11lZCcKnilSWtUzpC7iF8Wss3QzlkS/YSN9Kr51Op+VHYuy2f5SGMlQn
 CwSg2mJOuLppw8ieN1QdUwUBhy4+vxvsUuzL8fttSNZGi9ui3GKtLOXSVTLpLgqZpg
 zuaQQF1UYScYOWTyxiL87KmPTHnKRo946o6807yD/lJ7i8CGZ8PjP/NWI2QFxqxevZ
 7Zsf9drHi7fBOoE4aMyx46/ilS8eI5Q3jwZidoMJEHNyi7KmbQI8ypqAV+35TbA0Qn
 1p0kWWntZqSJZy6bTBFBu+EQ8+a6bDyFohX5hSXeP5cxMSIXcqT+sFegi1kuw/IBr7
 mLqgiJdw+FO/A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_045932_452410_13F75046 
X-CRM114-Status: GOOD (  22.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, oren@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/24/2021 11:43 AM, Christoph Hellwig wrote:
> So looking at this and Chaitanya patch I think this version simplifies
> things quite nicely, and it also happens to get rid of the RCU annotation
> sparse warnings.
>
> Let me know what you think of the incremental cleanup and micro-opimization
> below, though:
>
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 3da285e22e9209..2ca13dd7e7b88a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -313,34 +313,40 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
>   }
>   
> -static int nvmet_id_set_model_number(struct nvme_id_ctrl *id,
> -				      struct nvmet_subsys *subsys)
> +static u16 nvmet_set_model_number(struct nvme_id_ctrl *id,
> +		struct nvmet_subsys *subsys)
>   {
> -	int ret = 0;
> +	u16 status = 0;
>   
>   	mutex_lock(&subsys->lock);
>   	if (!subsys->model_number) {
> -		subsys->model_number = kstrdup(NVMET_DEFAULT_CTRL_MODEL,
> -					       GFP_KERNEL);
> -		if (!subsys->model_number) {
> -			ret = -ENOMEM;
> -			goto out_unlock;
> -		}
> +		subsys->model_number =
> +			kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
> +		if (!subsys->model_number)
> +			status = NVME_SC_INTERNAL;
>   	}
> -	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
> -		       strlen(subsys->model_number), ' ');
> -out_unlock:
>   	mutex_unlock(&subsys->lock);
> -	return ret;
> +
> +	return status;
>   }
>   
>   static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_subsys *subsys = ctrl->subsys;
>   	struct nvme_id_ctrl *id;
>   	u32 cmd_capsule_size;
>   	u16 status = 0;
> -	int ret;
> +
> +	/*
> +	 * If there is no model number yet, so it now.  It will then remain
> +	 * stable for the life time of the subsystem.
> +	 */
> +	if (!subsys->model_number) {
> +		status = nvmet_set_model_number(id, subsys);

you don't need the id argument here.

Otherwise looks good and it can be squashed to my patch.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
