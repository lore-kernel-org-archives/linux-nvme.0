Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F506C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 05:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LwJ/abNRX7aFFZkeeuc/XW1llVcC6HjEGYxiPk+st+g=; b=sLyIKB7JkeVLNbeZf/oA2zaUH8
	329/pPJozCt6SwXb1x3srdxHqrUw6ZOLs4Shqpqn9j3Uu9jXTpXTDOjPoM5d9WVB8IhYHWZUB0E24
	D0OprKSAk/uI6Rji9i4WkXEvw50EcoTThgUbHIv40cHltkItvyK+ojt5dsZoPvHl/IelMAr1fRxxM
	HZLkRo83n+PfuT9/4lkWu5btugL5U/eLP0gfS0+MkLOHjpkqGEaJsVuyRiQptvDy7m58JcLRtcS5D
	rObj7o+MOKYBq0vvdBwJ+mSiR+zSudC3kagKAEom2kDXwJQ0xVdrX0Y1cYAGrgMwDuM5+l41gWt8V
	6jXEkuCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkcy-0097FA-1u;
	Wed, 06 Dec 2023 05:39:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkcs-0097Ep-1N
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 05:39:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A9CB227A8E; Wed,  6 Dec 2023 06:39:04 +0100 (CET)
Date: Wed, 6 Dec 2023 06:39:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: introduce nvme_check_ctrl_fabric_info helper
Message-ID: <20231206053903.GA18935@lst.de>
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_213914_630444_A7A0C106 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

> +static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)

Overly long line.

I'd also rename this to something like nvmf_validate_identify_ctrl.

Otherwise this looks good.

