Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB043FB5190
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UfOk2X0lFSRBSx4KRtOb9pMQYMwn2XaSodldvvel50=; b=d8PH1aZXk/TWWRGTUoN9YMIyZy
	lWzpTnp/O+CFDcQ4RASTusm0yDIa92p/o8l2xZxfyjbs5jx89HnM4PaD1+nYytrJGhdHiXk375gAg
	saMlpG6GgFI6/XSTLxhOeSBlhzTtZ6iwcAjrXGJZ3mKnQQmOLNOlX5MVxx0Tbac83qSvouD4YzsnB
	C8jV9BNJ9PnSCfX/GXYpJrn/06fLYIUXPvyJ6hyEEl+G6w8xYGO31AUa7xkl+HzHHAJDZRi4MDLtI
	LNOdmUdQdOsm41CveuialWdd4ZGfSS1lYAcyCd0r8WZ1DsnnqmjGZfxwF2p2cp8qL3yv1WtBHm4Ri
	hsWImFaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9yv0-00000005ua2-2VZg;
	Tue, 07 Apr 2026 05:24:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9yux-00000005uYw-20nY
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 05:24:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4CA968C4E; Tue,  7 Apr 2026 07:23:58 +0200 (CEST)
Date: Tue, 7 Apr 2026 07:23:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, smalin@nvidia.com,
	linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2] nvmet: introduce new mdts configuration entry
Message-ID: <20260407052358.GA6089@lst.de>
References: <253ikaa1woe.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me> <20260402132108.250386-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402132108.250386-1-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_222403_657760_FD8F2A08 
X-CRM114-Status: GOOD (  12.49  )
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

On Thu, Apr 02, 2026 at 01:21:08PM +0000, Aurelien Aptel wrote:
> +static inline u8 nvmet_ctrl_mdts(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	u8 mdts;
> +
> +	/* Limit MDTS according to port config or transport capability */
> +	mdts = req->port->mdts;
> +	if (ctrl->ops->get_mdts)
> +		mdts = min_not_zero(ctrl->ops->get_mdts(ctrl), mdts);
> +
> +	return mdts;

This could be simplified a little more:

/* Limit MDTS according to port config or transport capability */
+static inline u8 nvmet_ctrl_mdts(struct nvmet_req *req)
{
	struct nvmet_ctrl *ctrl = req->sq->ctrl;
	u8 mdts = req->port->mdts;

	if (!ctrl->ops->get_mdts)
		return mdts;
	return min_not_zero(ctrl->ops->get_mdts(ctrl), mdts);
}

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

