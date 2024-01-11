Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEBEC47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAbu2AJr6hMrYiv5YASkyqea3msxlW3h7iXeFfmV7Oo=; b=0ubxHoIiXjqHmEpyAtYjBoh6q0
	bqhJFcVtTTjcisFgvpj+Zs9O1L5QtcHwmfyZ8/gg4D6LwILYefoJsqjt5pT5AfEYpHhHX23lCyhko
	pS5nzaBNqRcPipz1L7dX78V48OEFnYbyWg0ZT18k20Zt+nt/ah5E9jgvMZ/ZkKp9fCdX7FRWCC7LR
	uMdLvDoeyShtbyOKxhGq4Zddr+gS2s5iRrZgXfnLSg6roLF19blfKnva8n7ZY0Jsb8hUNqG1AJYGB
	M7rmzNbjM+mus98V3gV1Heo4At1sMyBQoJF5rk+GpZylzzvlOOIgvXoJEJue97X9DlXHvy47dTZyL
	6SleFjHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxir-000YpW-2T;
	Thu, 11 Jan 2024 16:16:01 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxio-000YoV-2f
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 16:16:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EAD46B81EDB;
	Thu, 11 Jan 2024 16:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0150C433F1;
	Thu, 11 Jan 2024 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704989756;
	bh=OcQvQmDPaGYN0IFEl4kvVBaIu08mpHNZJfaZ7uE7I4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbAXh8jVK96rz78JDnXF6CDvDD0XZvUYn9AO+pwbpmF4vwjqQmtR0Les8jxeKjhky
	 1nm4REC9NGJZAGLVbnS1J/94HrePpQFc4kDSN1p89svLsyEL4GbcTp75ou6ZCdA2e+
	 J5tl/8R2OOncWdh2UUl6x9YjuUYYQhWkeuXR0+R0fsY4CfKRzsIO01cewCzIx0624E
	 2Jb1IYKi9d9YBu6Fq9nFVK2qXXz9tNHcP5JIZaCWMCr9xAJulOotmb7+0rD5mrRiET
	 2EO9fanUS2VeB+r1m4crV3NEGPJzIOOj0FNsNJiNnO3Ef57/0vmgxcQEHq6Kv0fneM
	 8vbPFQdKgrdSQ==
Date: Thu, 11 Jan 2024 09:15:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Do not terminate commands when in RESETTING
Message-ID: <ZaAUOqa7OKtxXU1X@kbusch-mbp.dhcp.thefacebook.com>
References: <20240111072929.29381-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111072929.29381-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_081559_044004_3B0B0308 
X-CRM114-Status: GOOD (  10.70  )
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

On Thu, Jan 11, 2024 at 08:29:29AM +0100, hare@kernel.org wrote:
> +	if (ctrl->state == NVME_CTRL_RESETTING && qid > 0) {
> +		/* Avoid interfering with firmware download */
> +		if (!WARN_ON(work_pending(&ctrl->fw_act_work)))
> +			return BLK_EH_RESET_TIMER;
> +	}
> +
>  	if (ctrl->state != NVME_CTRL_LIVE) {

Unfortunately I submitted a fix late in 6.7 that changes all the
ctrl->state checks to use the READ_ONCE helper. Let's wait for block
tree's 6.8 to sync back to mainline, then redo this patch with those
updates included to avoid the conflicts.

