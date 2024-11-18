Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86605D68BFA
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xV64W5kwIWa5niry6NN+3uYqPf
	9YGo+fu5BUJJgk5rmDAwKo8Ke41MhQ9TXI6HsxjoAfK4xja9gzSV/PuWJmNqdphIWFelMS1OJp8oL
	BiXXiMAvIM+7szHEnNl4QXaoSM+AikFqS87MxUQZdJ35HQ8pbb9C5UqgnO4CuYMzoE7oA09WGhPwq
	OFw1Leito9dn1uX5Fz33D6OuTDvJqMW+kPoqRIKgjNFqV1wPyMn+Ts8DKCZZA6NSK4/E0F6BW4COQ
	L82n3WP5FYdb/71NWIszvu5eZ2mDYqH0RvjNtA6SGL2gn0zCtsO+VE86gy8jc3yu4i2t5y/zH2kQZ
	+HyFq3WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4bm-0000000A3xP-0BYn;
	Mon, 18 Nov 2024 16:28:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4bj-0000000A3wt-2ApV
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 16:28:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09A7268D12; Mon, 18 Nov 2024 17:28:09 +0100 (CET)
Date: Mon, 18 Nov 2024 17:28:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/3] nvme: define the remaining used sgls constants
Message-ID: <20241118162808.GB12281@lst.de>
References: <20241118155738.2737423-1-kbusch@meta.com> <20241118155738.2737423-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118155738.2737423-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_082811_692698_74D458E3 
X-CRM114-Status: UNSURE (   8.78  )
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


