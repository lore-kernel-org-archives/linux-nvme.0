Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E7DC7618B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upLVijhFz9vXDpSYIxrw1bTozRzpR5HCD/nRNuRC56g=; b=KHAkwWYxlP5JCstc4Br8frGVHt
	bhWfTt0sMqN3NYTbbQ8KjXYeICAzMCZSKXFxxMm71LWAU8f8pdyuAyCqrZW4tiv10qUYX7M2kQNyD
	FfRn41zXHDvP/wySwoSrS1DHYOzSFo+vP9wgFO5X7B2vWIutCUMWSbP/cxgj+YImFhWLpyfGVJYqB
	+4f1kRPDSXRHe7cYn7ucsYsfRjElKTpMJg1si339jMGa627Xe7cwq0uGzSBf7xmcmaPO+JMRZIKvk
	Z6QVyuUpQ0woDIYohDUjbA56/uvA1Uyvfq8Uorhyhh9LS9t1MzC0R/B/NhxY9J2w6G4l16/ZYoiIQ
	j7UOdy4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfe-00DXvN-2v;
	Wed, 15 Mar 2023 14:00:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfb-00DXty-2b
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 14:00:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33E2A67373; Wed, 15 Mar 2023 14:59:57 +0100 (CET)
Date: Wed, 15 Mar 2023 14:59:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] nvme-tcp: fix opcode reporting in the timeout
 handler
Message-ID: <20230315135957.GB26951@lst.de>
References: <20230313085623.9321-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313085623.9321-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_065959_991373_7AB9EA5C 
X-CRM114-Status: UNSURE (   9.64  )
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

Thanks, applied to nvme-6.3.

