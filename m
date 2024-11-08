Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97585D5C0C3
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luttdhYS4kJfYLUQ9lCmBWrCs5d96Xl+6byXwGbK9uk=; b=4zgLhNO2ldVxC4+e78xUiB3tvF
	NvbpD7wJW7vdiLUXkNjeUwFaDiDKK8xQo+V5k/fThSEIHLs56yY6nqs45PRB77sye89PMTnaGMV7e
	J5JEPh4LVV/2qgo3VbGyISs7G/OYJhUkVrydUKGoLU8yfcZOmTQWvhDIKw7XtL9AVqxvdu5uDGIlh
	9dRg4mTFiZW2bvE8D7CVCrK5ATiRxxlcrhTg3IvpPkCdRtcrZA9ldzggMQbCUi/IbKitu7BdoJ6j7
	nnhsK1zmtZvQSyFPx+G6Cl38PUKIu2NUSQN467wxynVvCMPZXUq/vKZJ46mAwhDzvVb4A+7meYj3f
	CXis1UXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9NsD-0000000ATRj-2QkN;
	Fri, 08 Nov 2024 12:13:57 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Ngh-0000000ARGR-2DYM
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:02:06 +0000
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C83591140113;
	Fri,  8 Nov 2024 07:01:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 07:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731067319;
	 x=1731153719; bh=luttdhYS4kJfYLUQ9lCmBWrCs5d96Xl+6byXwGbK9uk=; b=
	RaLb6wKQ3UAcuG69bL01FogbpbQ4HHL/U1BdXvQrAQkIhJunkO9f6++/cdqdhZSb
	PUDv5Ab+1UxP+NLhgaMzcw54FzgMo7KUQRGWUt9DdFD6r2GaaJNN8V9r68qyCdef
	xUTzkUpxo1Ry262eVGgyJc0tN/+w4ydAaI+RIdAMSrOiDRx5dLwNfc7myEFlRaxh
	L3iLgxDCrD4s45PVW7dIWvyAf9Yx9rzsveYav1rpV7lsb4xoRlghDOUhQR6pymkl
	FW0uvtROekx8joDLRbP4iv49B5owBiq7wArR48LLOQREMuP1KfrAHL1ItOc6GB/c
	bYOK6OzFRid640augZjA3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731067319; x=
	1731153719; bh=luttdhYS4kJfYLUQ9lCmBWrCs5d96Xl+6byXwGbK9uk=; b=I
	oNBoMkRRQyaV+HOXyaPQmifzKsT2Mc08dlczw+UUg8Qs0W5qyW/qdA5YPmvtJyjd
	9yL2cSvOFmhYW81rgTk9nQNnm+yq+4rQnhuZa+GuUOCMx4LZf0dJowleRiUqZ0qi
	yevbYqyM19ApHV60ONQeu05c4ceeTgoXFhu2HBhG/qKIlXO0OZDdclwTE7cBU2um
	kRHQnujpaDrk/ffmY25NUK5YloQFiakiYRV4cSNscz5nr8FMAx61l1gctrEV3Lh2
	Ngq0RJcQ9mZWNSu3eb4Lxz3Km4OlXR8MnPEmeFj3b17TPKoDX5qpvi1YIV7M4tKT
	Rjd35PjX1CjMYJzYvti6A==
X-ME-Sender: <xms:tv0tZ8Kw1hV_9W3dSYhWDFNWFIT9YLHKZb1jtCNwIgmjeSd38RY0kQ>
    <xme:tv0tZ8KqBaZOtkUzCvRMzyHgXooFQffrppEzlq9Qv7AZFQqyd9C9SiHSQasLJNyUq
    wRDjuU6Kfk9n071T2Y>
X-ME-Received: <xmr:tv0tZ8tYDGaOsn0YqOfqGV_N5oovEMHPoMKqlVHW9Iw0kapdEs3X_u1iJxgLVFptpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefvdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:tv0tZ5acD7WVI-kkA7QZPOgYUyb6YF0e7lo71UiMqkxtX45xesrr4Q>
    <xmx:tv0tZzY04MiZI6nXV4uwNU1gYZyX6fZ6lknnupdrAM1K_nG0f0j3bA>
    <xmx:tv0tZ1BbDW08I_6ZK2CriaX_9gT0eIi6kps_2fKvGglAsHinOubtQg>
    <xmx:tv0tZ5ZSF2-__7uunQmv-jT5SoGK3ePPrYWyLk6EjO2C6y7vHrMmkw>
    <xmx:t_0tZ35pF0Vq9c9f7CUzsJAiMYaDFAeIuLircPdT0hqo2wiEdwrASx1e>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:01:57 -0500 (EST)
Message-ID: <0d8aea5b-51c8-4f4b-882a-c41fbf566475@bjorling.me>
Date: Fri, 8 Nov 2024 13:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 01/13] nvmet: implement id ns for nvm command set
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-2-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_040204_370129_6AD09E5E 
X-CRM114-Status: GOOD (  13.66  )
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
> We don't report anything here, but it's a mandatory identification for
> nvme 2.1.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 081f0473cd9ea..8d06dba42bcb3 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -685,6 +685,20 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>   		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
>   }
>   
> +static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +				   NVME_IDENTIFY_DATA_SIZE);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -706,8 +720,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   	case NVME_ID_CNS_CS_NS:
>   		switch (req->cmd->identify.csi) {
>   		case NVME_CSI_NVM:
> -			/* Not supported */
> -			break;
> +			nvme_execute_identify_ns_nvm(req);
> +			return;
>   		case NVME_CSI_ZNS:
>   			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>   				nvmet_execute_identify_ns_zns(req);

Looks good.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

