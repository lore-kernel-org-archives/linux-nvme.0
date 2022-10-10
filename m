Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B94DC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41c0A6WdAy3bfGOkVXNpgAaM5P4bVnZRzLSDZWoDN48=; b=Ln4FF+ENf3hABso263SAXqUKSD
	KgCwNvyCOn3tsNsu66F16nsP/sB8LYnlGayi6QGaPGgzb4foixCeznuLJQikUq0iK62QT2MV6QHYf
	XS8PJ2Nr8itvQUOfjyCZSmFgqdaL6pIhIRImFHznrH/sC0T/Y5NEPNoqEKxy/HzZKnM6y/+C+i9dG
	cOgCUp+f0q0TdO5LARrVGupeX8uAxiNoObYj3IK13xMBeRHFT8iw10ta8BI9hs1WfohyMUp5C7EqD
	rV9Kuz+ZIOfOPu2R95UMT5hzbTZBFoT9+Vbef+HQrtL+JT/9XDs+peOHJBqMem5ECMg9MLwRcqm4h
	NQW2YjCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho7E-00Hao0-4X; Mon, 10 Oct 2022 08:26:24 +0000
Received: from [2001:4bb8:18a:723b:a4c6:ca32:f222:93bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho7C-00Hamz-GX; Mon, 10 Oct 2022 08:26:22 +0000
Date: Mon, 10 Oct 2022 10:26:20 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet: fix workqueue MEM_RECLAIM flushing dependency
Message-ID: <Y0PXLA3yTnX7n5SA@infradead.org>
References: <20220928063910.46862-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928063910.46862-1-sagi@grimberg.me>
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

On Wed, Sep 28, 2022 at 09:39:10AM +0300, Sagi Grimberg wrote:
> The keep alive timer needs to stay on nvmet_wq, and not
> modified to reschedule on the system_wq.

Does it?  The keep alive timeout is required for making progress
under heavy memory pressure.

