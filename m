Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D67C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 11:21:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F4E22257
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 11:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2CVb6uZr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZRpLwfSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F4E22257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z7nJFxJdadw0mIH6DpvHCpvYX1Bc7QMW2tweVL2K3yw=; b=2CVb6uZrhT8/t/8JVACPaEDvw
	EvhAxP38miiTx3fUtZPYKDlgnOh97W719CQZRnJcnPh8qZVkqT6lr0xbKFMN5+FVOywim09DttRp+
	+Uyk0iNACmmcoicQTvPo8knTBq8syW9vUGL3h76zo9zzPOF1hb2MEWm1Yg8CgpmnoZp28Z6rzIs7j
	/5bK+ZRWXNF3XK8okAD+4d9KLsmOp6aZBcI+Oyl41vr+8PRjefnxfnaD7YhirQAmmsJ1I1BnBf9mC
	Wi9ftoSNTOa1wLd2G2m4IWghj9kd47bl5tUxK+VwLDIIyqr1kqspTRsmkcVqv0hWiz1t+WisFodh2
	A2QJvTZLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUTE2-0003aC-Ab; Mon, 19 Oct 2020 11:21:14 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUTDw-0003Zd-GW
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 11:21:12 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8d766c0000>; Mon, 19 Oct 2020 04:20:12 -0700
Received: from [172.27.0.178] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 11:20:55 +0000
Subject: Re: [PATCH v2 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
To: Logan Gunthorpe <logang@deltatee.com>, <linux-nvme@lists.infradead.org>
References: <20201016221905.4686-1-logang@deltatee.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <7fbd6b56-cda5-a9b3-7323-99d9704fbec5@nvidia.com>
Date: Mon, 19 Oct 2020 14:20:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016221905.4686-1-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603106412; bh=UwKKPe5gkuh3CuIKMd9+V40bsxf+uDFVnDGDDLEhvYE=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=ZRpLwfSSVm9ubL9P73C7RkedMizS3XD+BpXSIgiFswUfI/2N6GqJHvE0oDfZy4lnh
 t4eg9cbcP5FPqXnvX6iDjdDeS8u55HlCOcrzYPq583gPlxn6kBUGcCjsgtomBMcZmm
 +/rDfeoXqDPG/l4ygmUNjKop3ywF0rxrY4KJsnPDYtv9N1mA+/4D1DxeAFzI94Bahn
 eIXwsZWT7h+8Pv2CHgyaueX4/IhndnUmvhkYn9lm/AXScWTAP9aoUXaSGj7wapentc
 Jcd4gF6m4Q7ULEZMOAlhuVVDTrTK6mdJF/CwzPv0XBbJrwewX5aCCsYoMk4erbHe1V
 YaXKrQhEO+pEw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_072108_616523_9C389DB7 
X-CRM114-Status: GOOD (  20.48  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/17/2020 1:19 AM, Logan Gunthorpe wrote:
> nvmet_passthru_map_sg() only supports mapping a single BIO, not a chain
> so the effective maximum transfer should also be limitted by BIO_MAX_PAGES
> (presently this works out to 1MB).
>
> For PCI passthru devices the max_sectors would typically be more limitting
> than BIO_MAX_PAGES, but this may not be true for all passthru devices.
>
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/target/passthru.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index dacfa7435d0b..1ab88df3310f 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -26,7 +26,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
>   	u16 status = NVME_SC_SUCCESS;
>   	struct nvme_id_ctrl *id;
> -	u32 max_hw_sectors;
> +	int max_hw_sectors;
>   	int page_shift;
>   
>   	id = kzalloc(sizeof(*id), GFP_KERNEL);
> @@ -48,6 +48,13 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
>   				      pctrl->max_hw_sectors);
>   
> +	/*
> +	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
> +	 * the mdts based on BIO_MAX_PAGES as well
> +	 */
> +	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << (PAGE_SHIFT - 9),
> +				      max_hw_sectors);

can 9 be replaced with SECTOR_SHIFT ?


> +
>   	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
>   
>   	id->mdts = ilog2(max_hw_sectors) + 9 - page_shift;
>
> base-commit: bbf5c979011a099af5dc76498918ed7df445635b

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
