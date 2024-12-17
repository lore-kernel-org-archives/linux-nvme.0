Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C7E7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 04:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2Z5OjJLokTSHIzUIAeDV6YXJISE2TdfyCbqEP4/txI=; b=sXaObgdInNZ1g5wqocn3CBFHCu
	+e74jxyvyRZ5TOUhfJwP3lT8LhxXa+MFuOXhQ115yCcjYoxZ2ANh5p7t7rmfnRI9zdt4jVdiIe8g4
	Emat98lH44c3C7znDZe/wrJFOqrAoVVDv7FUW+x1ngjacStcH1BwNe6euWuquTMP/L2ZM1dpMr4u3
	KOfEFxyX48IKNOriZ2cq1zzGv3TRlfHgVP1MLMXkMN+z1euiJtq9ere27msEMn9NiH+Z06y6MqjMQ
	z55zvw6Xvu6d1uPaTE3GT46HxCimRwhjfNXuYjm7h9CutFSFykqNzJi5Y/qCHT8rvvujK3iL3vtbc
	OCnRDgeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNPcO-0000000CBW3-2egR;
	Tue, 17 Dec 2024 04:55:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNPcL-0000000CBVZ-3cKY
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 04:55:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6443968BEB; Tue, 17 Dec 2024 05:55:28 +0100 (CET)
Date: Tue, 17 Dec 2024 05:55:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241217045527.GA16091@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143224.GA16111@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_205534_049897_2FEA0C3C 
X-CRM114-Status: GOOD (  16.03  )
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

On Fri, Dec 13, 2024 at 03:32:24PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 09:51:45PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:
> 
> This sounds like there is some other I/O path that still reorders,
> which got messed up.  What storage driver is this using?  The repro
> material talks about an ata disk, but I'm still curious if it's ahci
> or some other driver, or a SAS HBA?

Do you have the information on what hardware is used for this test?


