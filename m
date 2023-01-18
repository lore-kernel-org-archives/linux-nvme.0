Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B66C004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/VERFlewyBndmKXD50t1bXMXQuHPnE/gbvcvqC1DXI=; b=a/gX045/ztubY7EOZWhBMfl8g8
	Ol00ifXfiQrJ7f/Fhz6EfbThS9iQLCpynbcwtEEA1e0AieGFAh208gcss9Ck+awUXR8xXGRLdbxHO
	nHnbdfzDmMBPBMqYp66Cz6GCuZ2nrs71EOum4ziVTEQ9a0tF3W6G6hnc34rxro+bTj4HWrXo7PvQW
	xQmjUd9xo9ykXbZHZk+76S9kTfF1G5/AAn+2mlk7qq4bP0teIwcsXybEw8GeBO8/fOpC781XrH3gA
	xbShULWtvd3kVRVQbVjdNwSDbNUMx9kBNCq8kvUCaLPt5kPd2UqZ/E95r9FSq3xYdki6cMTyL8KQF
	73leYgwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI0wm-00GxV7-ET; Wed, 18 Jan 2023 05:25:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI0wa-00GxT2-F3; Wed, 18 Jan 2023 05:25:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74CF167373; Wed, 18 Jan 2023 06:24:50 +0100 (CET)
Date: Wed, 18 Jan 2023 06:24:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230118052450.GA24742@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_212504_686524_6BE469F2 
X-CRM114-Status: GOOD (  14.80  )
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

On Tue, Jan 17, 2023 at 07:25:00PM +0100, Janne Grunau wrote:
> +		/*
> +		 * Always reset the NVMe controller on shutdown. The reset is
> +		 * required to shutdown the co-processor cleanly.
> +		 */

Hmm.  This comment doesn't seem to match the discussion we had last
week.  Which would be:

		/*
		 * NVMe requires a reset before setting up a controller to
		 * ensure it is in a clean state.  For NVMe PCIe this is
		 * done in the setup path to be able to deal with controllers
		 * in any kind of state.  For for Apple devices, the firmware
		 * will not be available at that time and the reset will
		 * time out.  Thus reset after shutting the NVMe controller
		 * down and before shutting the firmware down.
		 */

