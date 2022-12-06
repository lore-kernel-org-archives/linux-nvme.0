Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F9C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9cTo7uaLfWZ8s5iTyJ1XWhtXOVrBIqC/qtU/LhEiBo=; b=BmhqCaAc7Ol23HqnEbtzptiTDT
	t1ZgAIxTbno8bUTfx1ccYd4gRnRMleSD/PAg/onWcE1mnxrhlNvt/Hcsq21nY5ht27WCpzwu0g8v2
	XIZrumYG7drTEvYc9AUccp9Xq+KrpCvngbWyauegGZXzgrtktKHTHh79EAYuZ2GoFiTKTUs+4JP+5
	zT6aAAzo3Y4qpRMPeiUhQsMc15irHPeAR7ydkFlP2A3yDoS+jNRIVQd++0C0QNSKILDSs+SOEpiLE
	4o/GaRUwRVN06iBx5YU47Gu0onevwGHXxJuWYxX6v40wLMXRjK3SXtmkTLOzoCbYSh1I2wlKxknjs
	QwAlOXWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T9k-004dPx-3F; Tue, 06 Dec 2022 08:18:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T9h-004dJ0-F2
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:18:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C303268C4E; Tue,  6 Dec 2022 09:18:18 +0100 (CET)
Date: Tue, 6 Dec 2022 09:18:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: use the core tagset alloc/free helpers in nvme-pci
Message-ID: <20221206081818.GB8738@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_001821_663168_1A66CB19 
X-CRM114-Status: UNSURE (   8.55  )
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

Any further comments?

