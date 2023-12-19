Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCCBC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NERa3irkhYxZYGnWjMzDVzdKTqOHnZiyrBONnAi0354=; b=Jv2RpnPCUKc4bBIrnHOcumnU2J
	qN4dCzY/XeY82wNv6SbDqJrRo6zKTUKGodM9b9vptYuVPBUIWQwcCaQUUvkBXeIFdKaV0WvfWggCz
	Bw0E+w19Ut0oqsc/9Zuqj0dyFGTb0/f9QbdTA+DoYFF2blW/bJA0ggMG6pKiDqcRYLsfxxinK96um
	VXoGKFStx5XAAvWpy1Rp8d/yE89IcSP4/66lTh8JHYVLv9eyPWTUB7Lr2+Gnfy20t2mMfH9Zq+DW+
	HlJi+otg5/tm97hZHSVkUZVcba12ikpOxV2GFzJjx75E3EjVrlN3EFKe3KFTlNSrbMi2GVC4iYdAb
	Y6iPqvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSGE-00CqvZ-1W;
	Tue, 19 Dec 2023 05:03:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSGB-00CqvC-2p
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:03:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E04468AFE; Tue, 19 Dec 2023 06:03:11 +0100 (CET)
Date: Tue, 19 Dec 2023 06:03:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-auth: isolate auth to fabrics transports
Message-ID: <20231219050310.GB31771@lst.de>
References: <20231218221613.2803017-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218221613.2803017-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_210316_057355_94581714 
X-CRM114-Status: GOOD (  13.36  )
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

On Mon, Dec 18, 2023 at 02:16:13PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some transports don't use authentication, so contain the resources and
> handling for it to fabrics that do use it.

Is it really worth to have a separate structure for those relatively few
fields?  If so it might make sense to just have a nvme_fabrics_ctrl
structure that wraps struct nvme_ctrl.

And a somewhat more descriptive commit log would also be useful.


