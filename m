Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1350AE6C5E3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 00:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8vY9GEAqN2936R1SalY5+kyI8hW415Yv8/yGTl0OwiI=; b=OnJ+3/lXd1+5GwOQx3rNLN4iK4
	96J8wHBVbhJSKo2NJcU76mfOG2sTkR9n9vG1WfeoJtVi5g+NoiuREJFRKzAbKlcgUBH4sKmuarNtO
	Y5X+yWZtFEInfy04KzCh4bd8q228HUGDIwHgWjPfsvylNPuJzjwx40Ls4fb5MbMN/ueZXnCFBB2L8
	Gh136AZ+glh2ouaIuY6wRFZTqc7bbJ140HkIQSFu55nZ//0XFvnLH2xezortJKHbEdTkPU81lYSMh
	lD7FuisUTuKjrXojyCPRBnjt0vQfJSTTcDP4jtQRGBpoTuL/+b6HMCf2w6dzivNPiMid0Ih2j/Jay
	gCNXvEDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGsC-00000007pW9-2JCg;
	Tue, 03 Dec 2024 00:34:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGsA-00000007pVB-1QUY
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 00:34:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF90468BEB; Tue,  3 Dec 2024 01:34:35 +0100 (CET)
Date: Tue, 3 Dec 2024 01:34:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: remove two deallocate zeroes quirks
Message-ID: <20241203003435.GB6890@lst.de>
References: <20241202175410.1207643-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202175410.1207643-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_163438_513728_892DC0FC 
X-CRM114-Status: UNSURE (   9.88  )
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

I guess we actually do need it for the other two can can't remove it
entirely?


