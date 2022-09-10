Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B80ECAAD5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 05:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptW4C9eeXYWPChJiSCFp689+NEWgas5KQn85lcrnMYo=; b=Xvbzk4hqazAWhvSFiHbUvX7IM0
	V4IEAv8Vxxnmnu766vu3lPbV7bWvu1s2NyFVDEpFWdLtoEckEYDusGvNrCyEcXk3NTPjnkQVxy3ja
	bZMuBfr2TpEw/XrcaXtgGi1hIBdCxx64tXGeZ4g/JZpVLzq714MdbO1brZrtMupL1Fe/H7i2joBwF
	KmHl9WPITspQqZ4Qs9MMO+l99q7qo6DSOee2MsyhNEp2RaAhiBKgZcf3wE+pG/K0wrL7kLigPPSYL
	pwPf9jqKRfSa4tE9ChRYq6e4LzDJfdAVkQpz5zTMuykiMn43MjGYfanlA6IdaGAuGwYBfvPdYCVij
	Gp4ybgnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt6A-006SZ1-Pv; Sat, 10 Sep 2022 05:32:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt67-006SYH-L1
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 05:32:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3939F68B05; Sat, 10 Sep 2022 07:32:03 +0200 (CEST)
Date: Sat, 10 Sep 2022 07:32:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Rafael Antognolli <Rafael.Antognolli@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp
 buffers
Message-ID: <20220910053203.GB23052@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_223207_850531_1E3DF123 
X-CRM114-Status: GOOD (  15.45  )
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

On Fri, Sep 09, 2022 at 10:19:16PM +0300, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms. Seeing the
> opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> respectively we must make sure the passed buffers are cacheline-aligned to
> prevent the denoted problem.

Same comment as for the previous one, this should work, but I think
separate allocations for the DMAable buffers would document the intent
much better.  Given that the opal initialization isn't a fast path
I don't think that the overhead should matter either.

