Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45703C77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTt4xyeYtRLd7ZOhnf0h8vdCr1/quUH3YFrLBoEIhlk=; b=VxDKFTboJVTnxkt7C2ASqGO2q3
	EcxIRsEmqHYfwLz2WWd9BGuSMLHPY3sOFVc6P1tPIS0bI1upQqH9P06IIEJFFCev0uZ6P/6f/bCBA
	plAxIEgMwuNLhm2SoTqLykGM4Cjwn5MPeQ/5MVO+vBmugQsZ0cvmmJHqh44jGgHSEdmOdsD6rQxHA
	7MuCqJbxpIcZlYsRkgcC2VwkZ2cmkjMj2UlTgJlqQnSKTzmvCtDNd2TgFWMiObNTP0poU/oCXBNzj
	bGUBoV2dB+yOWp4VARY7+5uo3f582/GeZOZt1JMeerwqenb/EwkssVWBzMCeAH72ghyxEZc+wjxYp
	FAxQrbQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px66b-008pWB-1r;
	Thu, 11 May 2023 13:13:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px66Y-008pTQ-1L
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:13:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5FCB68D08; Thu, 11 May 2023 15:12:59 +0200 (CEST)
Date: Thu, 11 May 2023 15:12:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/3] nvme-fabrics: unify common code in admin and io
 queue connect
Message-ID: <20230511131259.GA29790@lst.de>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com> <20230510180231.18865-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510180231.18865-2-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_061310_624146_317C1C62 
X-CRM114-Status: GOOD (  13.13  )
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

On Wed, May 10, 2023 at 09:02:29PM +0300, Max Gurtovoy wrote:
> +static struct nvmf_connect_data *nvmf_connect_data_prepare(struct nvme_ctrl *ctrl,

Overly long line.  Maybe shorten the function name a little?

> +	if (qid) {
> +		cmd->connect.sqsize = cpu_to_le16(ctrl->sqsize);
> +	} else {
> +		cmd->connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
> +
> +		/*
> +		 * For admin queue, set keep-alive timeout in seconds
> +		 * granularity (ms * 1000)
> +		 */
> +		cmd->connect.kato = cpu_to_le32(ctrl->kato * 1000);
> +	}

Not sure the "For admin queue, " part here adds any value.  That's
pretty obvious from the code.

