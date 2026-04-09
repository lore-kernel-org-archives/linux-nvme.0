Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC6DE98FB5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WsnGULpPEU5RgQW1VEtCO3y8qTnBfkMnKkKlIKgjz3A=; b=nCqfvVZjvYqHv9exI0cjLySrI1
	I4a+hUz+uIcuwjoXNERq18JAe1EpowDhRm7wkFli75/9vmWlJtvfHB0koUO/i8ogwEOOGNUeuCWT7
	FD7gIAQ7vidrKwVH31H1ihd1TCQc3lPsXomYrdn6GITslUbKTsW/NGOlAg7rR0a72CMnq1Y3gweSk
	TFxLpqpTZ/MIGg9lj0EDfycLHB1tF5uXkYTmyz5W0BX87DRazd8CewpKrsTAsMD2nnUaE2xOVrrHL
	BNjUnX9v6okE1DyNVZUoe+RnNDitVe/AEqrw0WiMLX6zcsLRXI9n7MDI35FuWlvB7sxOMKl2CpvSl
	sTgWTpPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAibf-00000009kjv-3PgA;
	Thu, 09 Apr 2026 06:11:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAibd-00000009kiP-0SLl
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:11:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B06A68D07; Thu,  9 Apr 2026 08:11:03 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:11:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <20260409061101.GB6470@lst.de>
References: <20260408075131.6221-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408075131.6221-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_231109_283952_CB610385 
X-CRM114-Status: UNSURE (   8.71  )
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

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> +		/* Tell nvmet_tcp_socket_error() teardown is already in progress. */

Overly long line.

Otherwise looks good.

