Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28790C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tToWoykwXkP4MoNaylr4diAaLmps8mWrPxzjavOk7Ns=; b=cKBBIyc3XTWHlqwF8mPyNx34hQ
	N3+sHu+inWZMsGwfa7zxvToURWjS4t3+iOUzlo4qlfLBbNyzb+XtCAzIfy6Pe4OtAiNRqvplBE+g2
	mQXAS7Yauxfl0EIok15B8mt7itWwd6ukLO5OoH5ArVY3mJ88ZT7IIpVyeTEXsd6b1fTAVhACs0azt
	pzv937ndVKeRInrDEguSUFAP2MVsIAeAW02RDYps+y+bKK0C8hyVzn6VF7HZIzHG7ZMAWY2r34aB8
	G/8HrX+4K7vcnDHBnFLMiyba0gRebBh0Gh3zWeaJIEwNi5V2MuO9jclnS1xzpmary4XLjTNgfeV4V
	TmDGw9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Ui7-000fq4-OP; Wed, 14 Dec 2022 16:34:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Ui5-000fod-6Q
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 16:34:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BE94761881;
	Wed, 14 Dec 2022 16:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7E0C433EF;
	Wed, 14 Dec 2022 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671035660;
	bh=075edqSoC5eSRsJ5OJeh1GS5gC7Z0xW+1dUNNdmhXCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQs6zuAj67wuWO6HuTmYICv24qvSs1oFSLGPtQJmtxD8cXp+hfQrbvsIGEYIIvb3r
	 sP/MK1sNqszMqcbs3vDKCGUi0xRZCeX6UW8rrRt+1MlqJo/Nnmlhi7yCFPrXCNX4hu
	 DMzV9pmtsnT1IbrOkoTJJ+4Ael/TrFWGrzw5fkK/eISjbYWxscRPA9OOvMJs5v3JmN
	 QLdoNk/GRk1Hnj4z/1N8tH1vTxKrD4AAbltLE7kzvVpzb7CGs5iUcuwDr9K9iLY6uO
	 UH7+I56YSNNdWPhyUPP2p/XU/OaWLCNCKPtp+XQlnPuH2tOrncjrptXwPqIa1PWTaa
	 yrX3sSppqCdAQ==
Date: Wed, 14 Dec 2022 09:34:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme: assign known effects at controller
 initialization time
Message-ID: <Y5n7CVj7b3Jr8dWY@kbusch-mbp.dhcp.thefacebook.com>
References: <20221214161347.764071-1-hch@lst.de>
 <20221214161347.764071-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214161347.764071-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_083421_290637_5743ED28 
X-CRM114-Status: GOOD (  14.19  )
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

On Wed, Dec 14, 2022 at 05:13:45PM +0100, Christoph Hellwig wrote:
>  
> +static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +{
> +	int ret;
> +
> +	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
> +		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
> +		if (ret < 0)
> +			return ret;

In the unlikely case where ret > 0, like the controller is very
confused, we need to fall through to allocate the default ctrl->effects.

> +	} else {
> +		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
> +		if (!ctrl->effects)
> +			return -ENOMEM;
> +	}

