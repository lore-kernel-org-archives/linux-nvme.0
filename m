Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DFCD5C0C0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQWrjidlES3FMXq+B26EYY3Q/5Eyx2k5MwouKumKjGg=; b=QslpAxUywboz4NP93KPFSZjyqH
	3/EEzwdyoQwbFBX9iAKFdD3ndIGT3Vx+WxRObjOWsPTHaUgbHTqFS1YtPfCzBuDUgCMGfokk/8HdN
	nMgHz6abC3KjHgpS06unIUqs2KWrGLks1C6jA5t5IbWLRphLawdaTcGhlcJxLxe3M+xtnCrHfTPBS
	sbMaagpqGSlCCZkOLeABNqHPtAwZbCGmntcrkGivC0hOz1dmV5NXBU0mAtFfW8BcXJoUMbg3U+uE8
	psQXViSP7LYcU64uotNRp4IS+JV28IvPWYZdnVRc0ZVnb7P80hE7Hz5RoSJxWO7wdO77mm6fhfZpJ
	ONKSSwKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O19-0000000AVDs-42Pc;
	Fri, 08 Nov 2024 12:23:11 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Nut-0000000ATuB-0fDV
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:16:44 +0000
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C6D5114015F;
	Fri,  8 Nov 2024 07:16:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 07:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731068202;
	 x=1731154602; bh=cQWrjidlES3FMXq+B26EYY3Q/5Eyx2k5MwouKumKjGg=; b=
	bwvX3bym+pP3f5OM+kZOD8qv7AR/pEPExx/U3JkMTCeqGGmFXxW3Thq8rrVdcJjU
	i9jRM4p0El2clNiTSV9a3qeKTOCaK994i2SXbkHrmjMPiwflV8io8LSLRdGIayS0
	emaA64kejRLEG9ox6r/mJYuO4EFklTwuC8bgNBNd/EVmvm/0T6j0pDUbTvI20Hr4
	Ps/7sFqukRJ9/oq9sPHMmrSeXmW7nqibmvunV1yu0ERAYFV7ZsqoM3hUqPchhHwA
	6jnJdc+g5wMM0BM7JaGXYJyjP1D8Sxf87968yGUxkHfpCTV/TG5cEC/XqEZ4xqCA
	vTIq05otNO9kTX0FKRc2ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731068202; x=
	1731154602; bh=cQWrjidlES3FMXq+B26EYY3Q/5Eyx2k5MwouKumKjGg=; b=m
	KJ2HIaYOyN+HqLp4pQdbUqdGfDNBF39/yXJFbJcfIxu+vdR1qe/85Mv6+cAgCTyu
	RpyQRKUx/LJNP7ww3BKmive69rZI9uTgO8Z6+NatEfTrU4SlyWsnDBomWAv947kk
	CvHXRshADDpbEvA5JH+RBPPGzen7hcr2oqOGIeHvj8B0MPtlsZN8V60YQYV2NC1S
	cRpzXFAKC9CK9v1ioyS1WxTiotWg1Z3TGLtAnEJr3h6wfh85enGy4GQI/GELvtCX
	RyhAsI7iJX0Pxy9waZyLKZADwGm8+4FCZ96qdnUNBQmTTmmQWpEDPA0yXDxMfdhR
	Wj6//xEeERAJl6jt4Ju4A==
X-ME-Sender: <xms:KQEuZ6LALF0cNI17zYPVUpKWoupA7XLOAu3_lyymmC_2gWr19MDL6g>
    <xme:KQEuZyKtbTrDrDUz7fBjFBeI6z-uORdeRgF_Rorq1ifbMHOkuQ3lQx61V2UNM3B-p
    CKAj5_lIa-zLvoI-ys>
X-ME-Received: <xmr:KQEuZ6ub93hOFxhoaG126OjCjiCh3g7ABZqTZdCPjnnzx6XPDGuOTgG6CKwcOXPq5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:KQEuZ_ZV0AezI-OXu8y4KkV0jmACdXF4N3vlj5K3fOc7_5IuSl6o9A>
    <xmx:KQEuZxZi-08u_Y9HI6RwPXnFLwbH21k87cmthEqQvAmZ5aS-OJ0RHQ>
    <xmx:KQEuZ7AjV-kRKbGpbRhMPQXsxAXdP8KL-3Vdz2DCq3Zoy7-zK3oUsA>
    <xmx:KQEuZ3bjB53XYFFTALkTN1_MsntmElaL1C6RgDnRq-iCSiUuQN0zFA>
    <xmx:KgEuZ97DBNfr7A2aQT8-_87jWZx5iqzbfaZivnKJZEEVLfmYFdQn5uqS>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:16:40 -0500 (EST)
Message-ID: <c8fa77c7-fa5e-407d-bb15-93f56c6b4967@bjorling.me>
Date: Fri, 8 Nov 2024 13:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 03/13] nvmet: implement supported log pages
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-4-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_041643_298457_86EBFD78 
X-CRM114-Status: GOOD (  14.45  )
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
>   drivers/nvme/target/admin-cmd.c | 27 +++++++++++++++++++++++++++
>   include/linux/nvme.h            |  9 +++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index a13242e791c0f..712b962fe77ac 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -71,6 +71,31 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
>   	nvmet_req_complete(req, 0);
>   }
>   
> +static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
> +{
> +	struct nvme_supported_log *logs;
> +	u16 status;
> +
> +	logs = kzalloc(sizeof(*logs), GFP_KERNEL);
> +	if (!logs) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	logs->lids[NVME_LOG_SUPPORTED] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_ERROR] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_SMART] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_FW_SLOT] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_CHANGED_NS] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_CMD_EFFECTS] = cpu_to_le32(NVME_LIDS_LSUPP);
> +	logs->lids[NVME_LOG_ANA] = cpu_to_le32(NVME_LIDS_LSUPP);
> +
> +	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
> +	kfree(logs);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
>   		struct nvme_smart_log *slog)
>   {
> @@ -323,6 +348,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   		return;
>   
>   	switch (req->cmd->get_log_page.lid) {
> +	case NVME_LOG_SUPPORTED:
> +		return nvmet_execute_get_supported_log_pages(req);
>   	case NVME_LOG_ERROR:
>   		return nvmet_execute_get_log_page_error(req);
>   	case NVME_LOG_SMART:
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 0f263c7e63192..692d606edeed3 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1245,6 +1245,7 @@ enum {
>   	NVME_FEAT_WRITE_PROTECT	= 0x84,
>   	NVME_FEAT_VENDOR_START	= 0xC0,
>   	NVME_FEAT_VENDOR_END	= 0xFF,
> +	NVME_LOG_SUPPORTED	= 0x00,
>   	NVME_LOG_ERROR		= 0x01,
>   	NVME_LOG_SMART		= 0x02,
>   	NVME_LOG_FW_SLOT	= 0x03,
> @@ -1262,6 +1263,14 @@ enum {
>   	NVME_FWACT_ACTV		= (2 << 3),
>   };
>   
> +struct nvme_supported_log {
> +	__le32	lids[256];
> +};
> +
> +enum {
> +	NVME_LIDS_LSUPP	= 1 << 0,
> +};
> +
>   /* NVMe Namespace Write Protect State */
>   enum {
>   	NVME_NS_NO_WRITE_PROTECT = 0,

Looks good. The patch description could be updated to say it's required 
for NVMe 2.0 and later devices.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

