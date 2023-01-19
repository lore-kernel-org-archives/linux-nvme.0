Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFFCC00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTtK7Ojrab9jhaD9uxbY7B3P3jlR4lI+Icwjn/s7Wps=; b=NlW853bNHPvErXz5rS7vPNWkuE
	r/YKUqSYULgzfetprwryM9CEK80Stz+lSmlcbFcuac9CQB4xpI90p5Cp7gCCWJjv8zV1ex0zZN6bp
	edHZNcABo71nH60l6quSSXu/QnZs40tm77WZ9BtDl3IkZXCk4CIrPBzsbM0jEIjDQ1HzCGwy9wSyb
	9yK5TDGgc2ZmNYogXByVs59MN9vt723C7ROuZ3xJSOgkYUXBVfXs0JSvQY1PrWYffURed53r0V3bO
	TuhDX9aUIHVFp9VYghc6wbwechz+Ae97oJcAfId4+NqdQ0k+AqUCO8zo39+GvFaBWSHnDGzSITEcr
	WATfVeJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPgL-003wdG-Vl; Thu, 19 Jan 2023 07:49:57 +0000
Received: from soltyk.jannau.net ([144.76.91.90])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPf9-003w4t-56; Thu, 19 Jan 2023 07:48:44 +0000
Received: by soltyk.jannau.net (Postfix, from userid 1000)
	id 2656026F67C; Thu, 19 Jan 2023 08:48:36 +0100 (CET)
Date: Thu, 19 Jan 2023 08:48:36 +0100
From: Janne Grunau <j@jannau.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230119074836.GC3576@jannau.net>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
 <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
 <20230118052450.GA24742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118052450.GA24742@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_234843_372030_1249857D 
X-CRM114-Status: GOOD (  19.04  )
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

Hej,

On 2023-01-18 06:24:50 +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:25:00PM +0100, Janne Grunau wrote:
> > +		/*
> > +		 * Always reset the NVMe controller on shutdown. The reset is
> > +		 * required to shutdown the co-processor cleanly.
> > +		 */
> 
> Hmm.  This comment doesn't seem to match the discussion we had last
> week.  Which would be:
> 
> 		/*
> 		 * NVMe requires a reset before setting up a controller to
> 		 * ensure it is in a clean state.  For NVMe PCIe this is
> 		 * done in the setup path to be able to deal with controllers
> 		 * in any kind of state.  For for Apple devices, the firmware
> 		 * will not be available at that time and the reset will
> 		 * time out.  Thus reset after shutting the NVMe controller
> 		 * down and before shutting the firmware down.
> 		 */

yes, it differs from the discussion last week. I tried to issue the 
reset later in the setup path after the firmware was brought back up.  
That fixes the hang but the device is still not useable. So it appears 
we need to reset the controller before the firmware is shutdown.

Janne

