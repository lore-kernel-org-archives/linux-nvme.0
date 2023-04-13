Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBEEC77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CfcwSQcNdlT0Rh8nEPENnbsVtNc8caYxkgODU6Y/uRQ=; b=VYKsVvTFj8kucyq99iFjJkKEH5
	KBoEqz3P/XILbbmRoHVmzxBB1jOJd8i2DpbVz6/Q/fgfP+UeEso/WvbF51uOziH/TWe2cQDscWBJq
	guQEdQxxPCnNXxLTiK4ihUguAQ0KqN6gzqcVe8sOGaTh4iQNeYoM5IyQeTHliOu4LrOkTxThDfv3Q
	EBIn7WLrOC4Ik4pFv/KH6YFAgzm0saHvsYNce1dbO6dwO2bWa5r+kAXuCIWI6zUtLtTIoXbrndAq6
	w44Eyy8irSKJa5i2ue9sOikRDF0YO+5QtCDC1IuTpvyK+gPIE5fp8skutCWhoagj4KwxH0etNyj0N
	UN9tw3wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqou-005C8K-16;
	Thu, 13 Apr 2023 06:52:36 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqos-005C7u-21;
	Thu, 13 Apr 2023 06:52:34 +0000
Date: Wed, 12 Apr 2023 23:52:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: dwagner@suse.de
Cc: linux-nvme@lists.infradead.org
Subject: WTF is going on with the nvme-cli build
Message-ID: <ZDemsiJi5vXd6aia@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Daniel,

can you please urgently fix nvme-cli to have a sane build system
again?

Right now it tries to download random packages over the internet
instead of not building components or failing the configuration.

That's simply not acceptable.

