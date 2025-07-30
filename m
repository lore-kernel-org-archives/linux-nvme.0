Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A2CC87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRywZUWFCSSDWNmuNC/r2Ug4Wg49PToh6BzkG3dnVCk=; b=tbJBx7t/Nd5A52E0UozpTuzjzK
	p8B0K1zHb760GRV6dT7Ko1Y+Ft6DrREtkt1TIWRKi1P0EmX3ALI/xdSqb9C9V7ffNqLACU3P3L8Bh
	2322SztEtWRRm+3zYBjS7SDa14Pk3eZBy0MSCqqFAf7GtCVr7H5imtIP0aWVSVnf9hLUUR3ljvn8v
	Xfnk7WDx21QSrV609vGRbl0/38G0AW5awrr7gRC+y3NJBe6iPldtMzZxghGHVHwYJuyJSTUrdScNt
	auR52dG0A6oqzKMM8OOZ86H9aqyAOOwIkPL8rOpZk8ifRQD6AheYgskehMT/CYgV2TQqqkJipaNwv
	TIcNugaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh9aY-00000001xGV-3D3v;
	Wed, 30 Jul 2025 16:23:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh9aV-00000001xFl-3c0M
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 16:23:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5180968B05; Wed, 30 Jul 2025 18:23:21 +0200 (CEST)
Date: Wed, 30 Jul 2025 18:23:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730162321.GA22255@lst.de>
References: <20250723202801.2909506-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723202801.2909506-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_092332_041536_C845F477 
X-CRM114-Status: GOOD (  11.39  )
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

On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments.

This created multiple rejects.  Can you resend against the current
tree?  If you don't want to deal with the nvme tree, maybe resend
just before/after rc1?


