Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9281FC982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gwlulflL6QkfgxVr6WWnSEzrOH
	7SzhlpP6+Rfg6nwaiOJ27jpdjeEAuQA4HYMAV9S54e+9/9q7YvUR3sHkSo7KkyzTI6seViFqktvrG
	AWbRnwZ06YyELkdtixV+BxEK/28OvPAQb/f/GK95OfTuB8+Z1EA1qRzdogRgaIsXy9q/OaM4NOIpS
	b8D9QQ+BBFZIHmhSQ7cWbksWU3FkzFUh7v0PqCRKFQBmLMTPVyQAeFie89+euJGsEdmAQzs8TdE68
	DS++ACUHtsr3xskCOKt2yzIYHy7FOzGTDvyusZLv/CeM8yb1brDjIPLhAuVTuIO7BjM/VSvkSx6KI
	53FmlMpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Xig-0000000EMyc-48xc;
	Fri, 18 Sep 2026 12:29:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Xid-0000000EMx2-1qcI
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:29:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50EB868BEB; Fri, 18 Sep 2026 14:29:27 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:29:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: reject too-short SGL segments
Message-ID: <20260918122927.GA17028@lst.de>
References: <20260915035123.3792935-1-4ncienth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915035123.3792935-1-4ncienth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_052931_625383_548384E3 
X-CRM114-Status: UNSURE (   9.25  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


