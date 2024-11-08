Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935FAD5C0C1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMCz6Qy7wMDDmSM5vjpMfBAuWpkdmDUJcdymdpwhv/Q=; b=h41ihL1X8Z840iNvLNhHrTI0Z6
	y5HCbi914tGjsyCsrkv6X+MgD0oTyiOybTXscld6hEdmhfgIsU6olXH/Q8cvnQyTwz8Gqr5ypAG6Z
	u2GyHCD3u9zSnFxWXvMiQ4AhaEJHYE4oU4qXxRkOvQY4lTAzGWH/Advv41weRuOf8IcAI8mFXsofp
	1ePoZgrfPhjJBgQ0cME9G9srYgWUzIb8194uGY9tbRih7WgE/3trqasxQ9IfA49bLTQKAMQmQyDz3
	Gcp5R0bfrJiziVjXvl8dzumz3P9Aj0PVyMH/mfeTQiLrHOYHuN3LTOPMYhfNZACb8Yn6szQ/ktidd
	Oi/HmVzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9OHZ-0000000AYUK-23tH;
	Fri, 08 Nov 2024 12:40:09 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9OEv-0000000AY94-0Mrr
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:38:04 +0000
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F0BEF13801CA;
	Fri,  8 Nov 2024 07:37:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 08 Nov 2024 07:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731069443;
	 x=1731155843; bh=mMCz6Qy7wMDDmSM5vjpMfBAuWpkdmDUJcdymdpwhv/Q=; b=
	IV/JCSjlCbQBzbQBl03QIZ5FlDYTWyc9qOOVWhBxzkmvkpYI5ULrFXSGL6bNpo6R
	RTtPGZguE9ObHsz5bC2mHlcZYjqEWvWWvyeMDWL9KLewsHis4zp+j6RBeo7JEBuI
	EngjwUB293f+AUSGGEI3PSN6Qa+aE1DqBfs4AJw33tn4jWpv1u3G50pWFg86p1x7
	tlZyf/MOd/CCi3xZ8X67rb++mRA8dkbiUzTHfng5viaz/X27iM8TepvP4aYWOilF
	dj8rwGRPOweM3tYTje3IK2kKDXbI1Y5v3MlRfRtTo5SAbkTbcAyRayax6ZhfxlQ7
	P8v/tMnmhSXmMKIxk26ZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731069443; x=
	1731155843; bh=mMCz6Qy7wMDDmSM5vjpMfBAuWpkdmDUJcdymdpwhv/Q=; b=R
	Sk4as7Z6kBw1s/65xaX7j6rC5nN13jKm8IdF4kDufiVad7Wt0UvXYrQMICW1q5r6
	ToagoWR7mpThtHttDqWrCDMzcKhJql2K2r59RDElh0Ib8r53EuroRckZ7WKYRhFQ
	zhr9HJqWyL4RP0n6DQgaVNI4vrjWsH/HbNxKhLSQrqLk1WMzf21uRbOBKbBvCQWy
	2EAHdLRsxIQofPtUgVmqmOHm60dj3OEJX/gpAJbE7DgX8LoKlkraPVXfxhFZ6b6K
	Pi83zZ3HBtRVcLk3GMxj0v4BH30l3ENeo6B5hV680vCrGvb002nuYvyArebeJF22
	T2G0MC0i8/0fOCDt/Hh0w==
X-ME-Sender: <xms:AwYuZ45PZNbRbWzVk0_h3ESm8FVeTMYj0SrhXZQjEzFmpuBGGf18Uw>
    <xme:AwYuZ56PDSuvz4YUmUQf2A8bgQmN3J_PM_4mCsmbeZ_izvHvpaiPnM4T4Qx3wqg95
    gROyadbPWXKyAW0uGI>
X-ME-Received: <xmr:AwYuZ3dy1uSuyAL-an2ErGBh1sYNbSwsBJionHaNPPZ2dMkw1l_NkAjPEasxGHkkaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeflecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:AwYuZ9ISvRa6pAo6IIyt4G9KIFoTL8MlR9cIdpbLmS18OxbtdThehQ>
    <xmx:AwYuZ8JzRT8e7Gd6H3KHQ_v_bCcEXG10JOO-ZNCpy85_J_BacF9peA>
    <xmx:AwYuZ-wxUcoxZF6Ek9oqD0-iI7ctI4OMY2S07_ImcNPBP6wUXEglZQ>
    <xmx:AwYuZwLbmTdQitSw2A2a_APf5mJ3CiGgTNH0Q_cNLR12oMIzbRWWAQ>
    <xmx:AwYuZ1o9kk9oG4P1ubZdjkymBJIIDDbAZe4dSRSyICZlHvV4eEeAiLE2>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:37:22 -0500 (EST)
Message-ID: <081aae9f-8edf-40a7-935b-c28385c5c413@bjorling.me>
Date: Fri, 8 Nov 2024 13:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 06/13] nvmet: declare 2.1 version compliance
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-7-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_043725_609646_0FA5B872 
X-CRM114-Status: GOOD (  12.06  )
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
> The target driver implements all the mandatory logs, identifications,
> features, and properties up to nvme sepcification 2.1.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/nvmet.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 190f55e6d7532..f902a630a5cf4 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -21,7 +21,7 @@
>   #include <linux/radix-tree.h>
>   #include <linux/t10-pi.h>
>   
> -#define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
> +#define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
>   
>   #define NVMET_ASYNC_EVENTS		4
>   #define NVMET_ERROR_LOG_SLOTS		128

Looks good.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

