Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37700C64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 14:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=lRBZ7jxcKXkJYK1FY5lmOkMKty
	1Lm7DbksQpmvWVefWEKS1f0wtidiyGmqAp+VYcnJP1sPGWgvzRbnQNkyeI/PexyG/WhfZhNL1JxbR
	Wf1L+oVjnGYqkxHkn79GOYkkGDp4LsAcTd2L3vdzV/TGgWHTnqFpU4hVyKkNW7WfsWQ5KZcmCW1mX
	Hwe1E7IR/PLcti9VXQxZ+fpZOQwCtmdovo02zXo+GfbQ7R4iAfpuEMJ2pD3/fTWa9lSYlRjZy5fZz
	8fHo5D15CT3g6EFdRwYrgGoHfJVcl6AwGdpGaz2r8sh3n5ElHjiQhOduo7DKFqCJin0vGehr/RnHM
	ssCOpF0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWe8z-009tsJ-PY; Mon, 27 Feb 2023 14:06:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWe8w-009trE-Lf
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 14:06:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0C0E67373; Mon, 27 Feb 2023 15:06:15 +0100 (CET)
Date: Mon, 27 Feb 2023 15:06:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme: fix sparse warning on effects masking
Message-ID: <20230227140615.GB18487@lst.de>
References: <20230224153424.734731-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224153424.734731-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_060618_858335_43981DEA 
X-CRM114-Status: UNSURE (   8.43  )
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

Thanks,

applied to nvme-6.3.

