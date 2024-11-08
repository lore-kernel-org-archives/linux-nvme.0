Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51830D5C0C0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jlSr3f+xPfeWgDzorqq5poDzPrMYDulZM0Pzq7c0MZc=; b=i4393zE0Ye86XYehQkLfLcwX3i
	BeqK6yyfRTr+f+rAoRz4Vr6wjUdUazhxIwgPibpHbXs/4wkdehb8opPpYvTa8HEJp+Z1v0OuBNcfN
	IMr1j14xI3ybSm+tZ6fbDA4M8+GltcmltYhCbyjhKBmWTLnZTY9xut/MrOWYT7KFrJEAGebmZXLB9
	28Bel94c+zCLyDr6Zl9zC4ElmuhZx7FHz+XSX1i/udeuxr/nq/l52A5B+5MUKpm1WMHSNo2sJSWsZ
	PaZZc58Rh70k+bsOy/AnJv9ClkUO66UnrZs6uB254dT8P1oy0ZHjagQpkFISvkpyjs9g2TDHEURcV
	H9tmkzdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O5J-0000000AWLv-3tLE;
	Fri, 08 Nov 2024 12:27:29 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O27-0000000AVZB-3PJ1
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:24:13 +0000
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4AD311400EB;
	Fri,  8 Nov 2024 07:24:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 07:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731068650;
	 x=1731155050; bh=jlSr3f+xPfeWgDzorqq5poDzPrMYDulZM0Pzq7c0MZc=; b=
	g53a98Fz4w33bHsgtGKzqzYQor8kl06g3SQfOpBAVE7rkGD/WjIrOllcDiE21XFl
	FysugUZKWlond2xw+wFs9pbw0xeJ++vRVuOhPXH163TYjy16+Y2JU55Guu35sPyZ
	I/WGx6h1DhYey7TSlWTxBmGm6fEsIhGx+7cQvrIH4wvgV6DNNLeIAKQZErwzaggP
	qkDtUCAUt6b80sYVwdXUTX4896f8q6XC9zVbAP2F1iYtQHrRoI7a0ztKA/DY5zcF
	vzQXp3BygkAN5dQwt2ZdwWGtKbsQ623HgOjfqYRQkDIRRK+/lirBx5EO3w3nGePa
	jV3SBiCCrVnPLfFXZ4oeKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731068650; x=
	1731155050; bh=jlSr3f+xPfeWgDzorqq5poDzPrMYDulZM0Pzq7c0MZc=; b=O
	xF+YmoxqBzAXu4fKcWF8WdKaWWmguG4JBQCnMblju4pTBgSOUp6AZ3Ra9Fym/Bz0
	5lXzixyPpzQiuVo9BLqXOI7jsfiHud/hhpbbjuP+ugBxS+YucxQ3NJZoMFKvuFr+
	qW50Vbcx90D6qVklxZU44c5Zt8drBXlBnZM0xwZI2JwWNLHtGKtELkcgcdC5Hqf9
	kufcG+vScN9vhkJXn/iewwka+KsCYvN1GIf3QPZZEnu+4NnGzh4+zVBoebyRsHcm
	hGIABzY3m1D2rw8NxjWL6K68d+16eHdhLlcTqSxM8iriye2mr6Nq9NGFdwYnN030
	B/demRgiKV0E7bztCkImA==
X-ME-Sender: <xms:6QIuZ8j6z8MKncfhoB11_316WPEhUYPV9tivzSErIZ4SO6WBi79M_w>
    <xme:6QIuZ1CTMyNqi1X-f8MiQPyCG7agZHBdWtaI2v5N5kOJ1JMuNR1c2Th4YcNCsxxvb
    AqoFikF_-58ZQK6OIo>
X-ME-Received: <xmr:6QIuZ0Hxb3hcvnC2DYUAs8bIVyEu83v4sNJTq1c1pS3OXu3cZ8kWiGFVDuKg4zG3KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepofgrthhirghsuceujhpprhhlihhnghcuoehmsegsjhhorhhlihhnghdrmh
    gvqeenucggtffrrghtthgvrhhnpeekfeeiuedtvdetgeeutdehvddugffgveegveekgeeg
    feekueffffefleelveeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmhgvpdhnsggprhgtphhtthhopeejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehksghushgthhesmhgvthgrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepmhgrthhirghsrd
    gsjhhorhhlihhnghesfigutgdrtghomhdprhgtphhtthhopehktghhsehnvhhiughirgdr
    tghomhdprhgtphhtthhopehkrghnihgvsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6QIuZ9SKOeV0Iblgq7mG54cFOaXMNR5ZsSlb5VAC3RxyIvDbOMCfuA>
    <xmx:6QIuZ5xY7lvsuLA5AuOfJS2s3nUYv8bDNAvu5o9Mc55FWK2E2Ae0gA>
    <xmx:6QIuZ75-zsCWSvcMcJvOIQpKk24vGMBvW0ZPEDGaj022s-pZrqyG5A>
    <xmx:6QIuZ2w8kKtFmF2e8J2gAiuhAaVHV-GgjtjkZoTLDi_C5fi7_s02hQ>
    <xmx:6gIuZ4yR6AmzdXqdKQgq1zeI8P54MDqli_VdhxpSwVn2eD-Y_XNkeuAA>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:24:08 -0500 (EST)
Message-ID: <71b6f647-5383-4feb-a799-0ad7064007ef@bjorling.me>
Date: Fri, 8 Nov 2024 13:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 04/13] nvmet: implement supported features log
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-5-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_042412_071380_D35E6C8A 
X-CRM114-Status: GOOD (  14.50  )
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

On 07-11-2024 20:38, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This log is required for nvme 2.1.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 31 +++++++++++++++++++++++++++++++
>   include/linux/nvme.h            | 11 +++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 712b962fe77ac..7a879e2cd8555 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -89,6 +89,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
>   	logs->lids[NVME_LOG_CHANGED_NS] = cpu_to_le32(NVME_LIDS_LSUPP);
>   	logs->lids[NVME_LOG_CMD_EFFECTS] = cpu_to_le32(NVME_LIDS_LSUPP);
>   	logs->lids[NVME_LOG_ANA] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
>   
>   	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
>   	kfree(logs);
> @@ -342,6 +343,34 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
> +{
> +	struct nvme_supported_features_log *features;
> +	u16 status;
> +
> +	features = kzalloc(sizeof(*features), GFP_KERNEL);
> +	if (!features) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	features->fis[NVME_FEAT_NUM_QUEUES] = cpu_to_le32(NVME_FIS_FSUPP |
> +							  NVME_FIS_CSCPE);
> +	features->fis[NVME_FEAT_KATO] = cpu_to_le32(NVME_FIS_FSUPP |
> +						    NVME_FIS_CSCPE);
> +	features->fis[NVME_FEAT_ASYNC_EVENT] = cpu_to_le32(NVME_FIS_FSUPP |
> +							   NVME_FIS_CSCPE);
> +	features->fis[NVME_FEAT_HOST_ID] = cpu_to_le32(NVME_FIS_FSUPP |
> +						       NVME_FIS_CSCPE);
> +	features->fis[NVME_FEAT_WRITE_PROTECT] = cpu_to_le32(NVME_FIS_FSUPP |
> +							     NVME_FIS_NSCPE);
> +
> +	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
> +	kfree(features);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
> @@ -367,6 +396,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   		return nvmet_execute_get_log_cmd_effects_ns(req);
>   	case NVME_LOG_ANA:
>   		return nvmet_execute_get_log_page_ana(req);
> +	case NVME_LOG_FEATURES:
> +		return nvmet_execute_get_log_page_features(req);
>   	}
>   	pr_debug("unhandled lid %d on qid %d\n",
>   	       req->cmd->get_log_page.lid, req->sq->qid);
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 692d606edeed3..4b896fa651e02 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1256,6 +1256,7 @@ enum {
>   	NVME_LOG_TELEMETRY_CTRL = 0x08,
>   	NVME_LOG_ENDURANCE_GROUP = 0x09,
>   	NVME_LOG_ANA		= 0x0c,
> +	NVME_LOG_FEATURES	= 0x12,
>   	NVME_LOG_DISC		= 0x70,
>   	NVME_LOG_RESERVATION	= 0x80,
>   	NVME_FWACT_REPL		= (0 << 3),
> @@ -1271,6 +1272,16 @@ enum {
>   	NVME_LIDS_LSUPP	= 1 << 0,
>   };
>   
> +struct nvme_supported_features_log {
> +	__le32	fis[256];
> +};
> +
> +enum {
> +	NVME_FIS_FSUPP	= 1 << 0,
> +	NVME_FIS_NSCPE	= 1 << 20,
> +	NVME_FIS_CSCPE	= 1 << 21,
> +};
> +
>   /* NVMe Namespace Write Protect State */
>   enum {
>   	NVME_NS_NO_WRITE_PROTECT = 0,

Looks good. Same comment wrt to 2.1 vs 2.0 as the previous patch.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

