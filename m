Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF8AFD2D9A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=esqrTt008RXPYzryLAjA6Tzr87
	oMvkiotZK55axye61Y+0XzWA8q+XWJrzHvVVMXiAz3wPeRksXuZIYFE8uvR3mcC7Yzf0MSyqUwV2q
	QLWqUnjsXFqcStvHt4irGfFSsctG5AEg+3Y+tHNLHeDeMawGuaRrr8P3FU3TjRE7CBVdCMA/URvA+
	TAOxQjeajZ9/NnG6MQpTt+mEJEbfpAmFM2xpX5R7h8PD504CzOzI9t/IqCZtlnDwwq3JwHdcm6euc
	byL8VGucdIWT4EBOvuEqlLzseJI7Ho+EybYIj+vr9BtQ8KY7M3wSMftBQxcHUme56bYARbYNgHxz5
	UKA9M0dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxaK-00000009dwm-2mfZ;
	Tue, 10 Mar 2026 13:57:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxaI-00000009dvw-03uu
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:57:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0376E68C4E; Tue, 10 Mar 2026 14:57:13 +0100 (CET)
Date: Tue, 10 Mar 2026 14:57:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
Message-ID: <20260310135712.GA8242@lst.de>
References: <20260307194636.2755443-2-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307194636.2755443-2-iam@sung-woo.kim>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_065718_197126_D58A2C0E 
X-CRM114-Status: GOOD (  11.13  )
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


