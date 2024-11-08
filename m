Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2274D5C0C5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T77HiWp66sy0ycHdH28+PaGJpG7e2NuLzU2bnCIzxWM=; b=BJZbrkv6/bcekDjYScaJbPaMgs
	l2I26BpN3EQzMeXWo6fvjnGCcZeRqBzgtftemZaZLiSXSfxYIFw0LPOcxwcIPXSFp0TwebIUCi2fG
	6uCGDMA2IXqj0B+r60onkT6hftbMso7KP/ABMKjVwa/jf6R4Yx4HmriLGtjS894az3P1dk3BWDMZi
	rFvo0HLqM1yT1DNCijRh1fNNOVPDV6vb+9cNiLIJwNq8Yc6tlCFUkgKqnSXXB+WKNyHz25mv49k5I
	o1s8pAlr3BETdTAfQVM4sVWrIi5NNw8dA9kOKlXgLiy0MQx96KtbtHb4JKdTZpwAxXZna+nUbliwh
	HaMbeGUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9PKC-0000000AjbT-1MrB;
	Fri, 08 Nov 2024 13:46:56 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9OBl-0000000AXiW-00ZN
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:34:48 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 34357138052D;
	Fri,  8 Nov 2024 07:34:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 07:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731069248;
	 x=1731155648; bh=T77HiWp66sy0ycHdH28+PaGJpG7e2NuLzU2bnCIzxWM=; b=
	diYhp+Rr3oDH2v3XsMgApCW+eEuFq5PU1N/Ati+8IWcZ9rJpL4FOeHfUvrgB5zCe
	hSzLgIYZmSmWdD5qExvTvBc9wmzPaekhBvW8luYMPlapXIpxTpBkLV3pyAZjILQa
	jgHTYUamFknNdxBBRLl6fUbDyc2TvManaiYYPjV39uquH0F5AaZRZMKECqWGKapv
	J+tuIo+XOXSbPuKxbv4Bx33fxCPCnnnm/Ta/kj8BfFDQPiZkClNBI9K1DoSY1Obm
	K+xsV72j8haMewb1gsHC2J32Y9TM0PHD391JhU33JZPQKSrRVXo9/JbV7Le2O8F4
	rv+9I6fGwn9afxA8I1EjAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731069248; x=
	1731155648; bh=T77HiWp66sy0ycHdH28+PaGJpG7e2NuLzU2bnCIzxWM=; b=Q
	u2+iCMM8eimTlZiR/7Hcn0aSaa0RU1LD/GFQ2NHT0mCM3rroNgrn1+ytfbWnodzm
	yqZsg69AlCmg6n/HH7vlPeHmtniNtwD13Vzhv4i6z+zRxZVMUfU2mOsLoh9RbXT/
	XXoCtbvoZ36z7FNn1QNYghn5hH5PEY6Gx+DntGl6T0DYB+74fV0AaTgfnh8I6AZ4
	mNU1jv43kwLRxH2saerHmOvpC//nu0QJz961wfDhOacRvIeIm3DSzcw/VznINHnD
	p2fTjanOC1NItg34Dh+S/bM4a8ngxLD7rYsL4syDONDmMmitUPS4ek0T1ny65/vc
	aPscfuX921Rlrqt5UX+lg==
X-ME-Sender: <xms:PwUuZ2RgRwQloCMtBDwjeoFvM_HUONDJ1x2OIZ4l6xzWrcSu9KKfUg>
    <xme:PwUuZ7z-I8_GcFQn9MbLG3NA-rhXSgjNOR_cSLzHEmb9-3oPmcRPyMZWCxBUjTawP
    QKOVjki04iTK3GA_U8>
X-ME-Received: <xmr:PwUuZz224F1Ustv3_By9A_-7pK5g1yCS2EwIN8P6CoyUdDtTJgmwjpN1uOXx_Cu2mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:PwUuZyDShwcLevipu0AvRUa6ZGcbmZowFFzJ9qpBsvci1WWiX7hE-g>
    <xmx:PwUuZ_j7YO3sVji2bdJ_6TtYbyGdF2HsOGFmccugIEA9ltXak3R0Ow>
    <xmx:PwUuZ-q0Mg54gisdfv24ewcX1dXARoz2bc_PmSarWs0TZWH-wWg42Q>
    <xmx:PwUuZyjVdsBBZok8gWI9q2jkqbCywTpntaF7Bnx99yF4GYAuJEd4fg>
    <xmx:QAUuZ_ivur_U2lzB75qyyoNS9MRpaDvPlQ0U2f3mLSzMUxRqIuT07QwJ>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:34:06 -0500 (EST)
Message-ID: <bb072c97-f1a0-4ad2-8bbc-fda6302e4739@bjorling.me>
Date: Fri, 8 Nov 2024 13:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 05/13] nvmet: implement crto property
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-6-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-6-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_043409_133295_E43A4801 
X-CRM114-Status: GOOD (  12.28  )
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
> This property is required for nvme 2.1. The target only supports ready
> with media, so this is just the same value as CAP.TO.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index c4b2eddd5666a..bb80db6a7950b 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -64,6 +64,9 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
>   		case NVME_REG_CSTS:
>   			val = ctrl->csts;
>   			break;
> +		case NVME_REG_CRTO:
> +			val = NVME_CAP_TIMEOUT(ctrl->csts);
> +			break;
>   		default:
>   			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   			break;

Looks good.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

