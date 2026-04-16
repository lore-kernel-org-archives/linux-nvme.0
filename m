Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D9F433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEThEVmRzVlLCYqHgzw0tI8k+Bk0WGWPQs3d6qY9Wk0=; b=ioGA9dzHCFF1WbDm7Xj6AXnBhV
	U0Odb/i0aBOhiyu2RgsJ6zghX4IAIFYwm5GldkJ12G4ALCU7VoUMd3zRpYwkzQEO35acqATt4yBEe
	l+IoCAFqNmRSkjJySdBe+xZ0Y91AcU5qX1E9rMPXxYVNXhSBLUfchQns0VfNd3bbuTmxNoaa1y8IO
	S6NgUlOETH4ypk1O7qMsZUUinUpMshsw78NJr7Dlq9uoyCRqNoWlqybV/p/eAYCZdHQSBozpHnB87
	sfvTGJZwvg2jPGqOl9/k71ywInV2nYcLE2qHYHpsZA5M/uPIdPQ1XuHooRu/SkXMNiAYyHMvDw8O3
	ZbDyf0Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF6C-00000001z60-2rbr;
	Thu, 16 Apr 2026 05:17:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF6A-00000001z5Q-1fzI
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:17:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C46F76732A; Thu, 16 Apr 2026 07:17:03 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:17:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tao Jiang <tanroame.kyle@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add quirk for Memblaze Pblaze5
 (0x1c5f:0x0555)
Message-ID: <20260416051703.GA14917@lst.de>
References: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_221706_574616_0CEFF3C8 
X-CRM114-Status: UNSURE (   8.47  )
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

Me, another broken device :(  I wonder how these people test their
hardware..

Reviewed-by: Christoph Hellwig <hch@lst.de>

