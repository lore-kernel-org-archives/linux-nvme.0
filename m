Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003A4D5C0C1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmpMcKZOFnNQ2jcpCRtEcemg1aGkHJ/XZMZKCEEzRV8=; b=D35owNbUxPkkB9QVLwF4ZqWLhY
	M2UTCkOPRCD13d/fp4S1UP/odLzOPUycYQeYyjF+QSO1eVIdmlfiCB6J5Bb4G1mMW473nPcSI2bdH
	9yDDA6emh03bQR+xcIPa0jlZuhd/j0VkjIM6Yg1ex/pw2YIGEuWoMhHyahoUeNmEzVfmzTIiGC7fv
	JuUwEH4h6Snlse5k0lDg7ZQr7XOukikwstxHY8K1fvsTHR4WlO4LpGRCT29ED/dBIN+i/M1W/QwNB
	2xCkxemPsfDqD1T+y9LF+DokKhvOlavX6w6hN+uE9xcr4CLz1VTih7Umb1RgoocQEbcPlvk4ahm1L
	kuxnV2KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9O10-0000000AVAk-1DCz;
	Fri, 08 Nov 2024 12:23:02 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9NpH-0000000AT1c-0Mnk
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 12:10:56 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B277213805D8;
	Fri,  8 Nov 2024 07:10:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 07:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731067853;
	 x=1731154253; bh=hmpMcKZOFnNQ2jcpCRtEcemg1aGkHJ/XZMZKCEEzRV8=; b=
	Pha8EZSnuGefTCb4HeO8r4Hk50U+Z/fW35p3JZjKS5ekJmI59U9WhKQ3mUMrfG5t
	/S/py0TflwusarUeXxbDhViPDm5uKjnxtzHG1ikqnz7DPUF8o2qHUFFLautZwIAu
	kOQcUruK2ePRkoPQJbqBPuC6qo5dFX6jhJW4RxQtwQedgviHwwWjFXHrH4ezpyPk
	N5p56lR7I064FItwEjtB7wn6TXY6mf+1rsJJ2i33GDR7ePVO9w5BOXMqqSXe/cKt
	zp/Jt2glTbiAdxm4Vo3Y3KEDE7W+t/VoMitqkjhu/ognYW03qBCWUHGMAwNzXAp4
	KpZ5nh9/o6qKVTcIvmofWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731067853; x=
	1731154253; bh=hmpMcKZOFnNQ2jcpCRtEcemg1aGkHJ/XZMZKCEEzRV8=; b=k
	ERmqAVpPkp9z/u/Kf3jriJiNNI2yu78E/cQW8hnhWTromb2/pc7Uu73rnx+iJdTY
	UFc0EcJP7yh8NChkJIz5Mo/rUmNImSZBoYgfuSJrmmYVOFdjtLr8vhapfalTVNv+
	sSlTfCPuh6ofR0PIBlMB6tMLGIRthV+ZwDf90f4brZikUgwGLtJR//DOPYCDD/6d
	iiI0JGzGUxWXrhDACo3YKOwuIknCb99nKZrgFOfAUSERVHzkKKIq0jAGocWGe8Rg
	EKqdIoXJill7Ch9TaQYUwKAkvrGoULqpG0o6reUepgHFKzcxISapZq2ut82axqHZ
	kr0P0YHHxUU3W5qC2C3yg==
X-ME-Sender: <xms:zP8tZ47rVq1JO8-XsYQDWhkpPK7vl_t9LC5X9RJOcviVl0B1DVzOOQ>
    <xme:zP8tZ577gXhGZPObi4oSOH6QNmLUcYu2SbE79l_KnVbZp7CmtWLorikZOm69T_zKD
    3avJ9FuwQsJIt19v3A>
X-ME-Received: <xmr:zP8tZ3ducAjKBhdq5BKaf45Kg21ZHVf2xx_AY2Mo3XSIHAKW0hWijtK4-tTLa-uzZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeffecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:zP8tZ9Jetee3NLqBiRl40t_R_7OesQsq4VeDyz-7KYDoBCWc-LtkWA>
    <xmx:zP8tZ8LPRV1VNYhb_7tGRCQ9E8w40lm_a6x9HmikfdsWFo_7A86-4w>
    <xmx:zP8tZ-xdILPOiW4NwqOAB424O98YdjPBybAv_EiSTOlBnvBsTYP1Dg>
    <xmx:zP8tZwKXVwmhqc_80LWBHpLBmzOt2-Nr4kiMtouKZhtBsKFWXHT92A>
    <xmx:zf8tZ1qp-dIzc-ggmL0WUtGvi-5D7uMDPV87Aj5JL6osaF0MQl1bBEw_>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:10:51 -0500 (EST)
Message-ID: <649ab1f6-3659-4f05-90dc-99932e465ea7@bjorling.me>
Date: Fri, 8 Nov 2024 13:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 02/13] nvmet: implement active command set ns list
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, matias.bjorling@wdc.com, kch@nvidia.com,
 kanie@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-3-kbusch@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241107193849.995554-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_041055_226481_77F69FB1 
X-CRM114-Status: GOOD (  15.67  )
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
> This is required for nvme 2.1 for targets that support multiple command
> sets. We support NVM and ZNS, so are required to support this
> identification.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 9 +++++++--
>   include/linux/nvme.h            | 1 +
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 8d06dba42bcb3..a13242e791c0f 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -576,7 +576,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> -static void nvmet_execute_identify_nslist(struct nvmet_req *req)
> +static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
>   {
>   	static const int buf_size = NVME_IDENTIFY_DATA_SIZE;
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> @@ -606,6 +606,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>   	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>   		if (ns->nsid <= min_nsid)
>   			continue;
> +		if (match_css && req->ns->csi != req->cmd->identify.csi)
> +			continue;
>   		list[i++] = cpu_to_le32(ns->nsid);
>   		if (i == buf_size / sizeof(__le32))
>   			break;
> @@ -712,7 +714,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   		nvmet_execute_identify_ctrl(req);
>   		return;
>   	case NVME_ID_CNS_NS_ACTIVE_LIST:
> -		nvmet_execute_identify_nslist(req);
> +		nvmet_execute_identify_nslist(req, false);
>   		return;
>   	case NVME_ID_CNS_NS_DESC_LIST:
>   		nvmet_execute_identify_desclist(req);
> @@ -743,6 +745,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
> +		nvmet_execute_identify_nslist(req, true);
> +		return;
>   	}
>   
>   	pr_debug("unhandled identify cns %d on qid %d\n",
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b58d9405d65e0..0f263c7e63192 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -522,6 +522,7 @@ enum {
>   	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
>   	NVME_ID_CNS_CS_NS		= 0x05,
>   	NVME_ID_CNS_CS_CTRL		= 0x06,
> +	NVME_ID_CNS_NS_ACTIVE_LIST_CS	= 0x07,
>   	NVME_ID_CNS_NS_CS_INDEP		= 0x08,
>   	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
>   	NVME_ID_CNS_NS_PRESENT		= 0x11,

Looks good.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

