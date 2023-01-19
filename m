Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049FC00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 06:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUo5UlMqNon9N8bRN5lqdB/3h9o2bwf4pZEOMD+1dWw=; b=3yrImEvxL8UicniwinO9w282Ir
	WloXoo2wR1wvMpsJpMIJ34xPLLqzaOrgHvz6qsXo2q9uFVekRy+cI1f45A+y8BTowt1HRqhG+pTxN
	OqYmljpOMXLchFDCaEderq9Qya74Bj3z6tZTLrzkD4AovGanC8xdqvZHJHw5cCWuWcZ2TcE1nDJMY
	XBv44lQF0lrbm2leCcyvJkQwrxlRVMAITJVgWdH49b4grYx7FVBH2tBYGuaccaoKyzUwhDEyx+aiB
	1vOJ4b4esm7ABInDzfnGKxKl/7iOgL19WhSETtGwxeLaZrgqIxSkIjSUJm+QEMMm3Kn5t7fNSpwwG
	LMmiKu/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIOCa-003itd-J9; Thu, 19 Jan 2023 06:15:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIOCQ-003isP-Ok; Thu, 19 Jan 2023 06:15:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 657DC67373; Thu, 19 Jan 2023 07:14:53 +0100 (CET)
Date: Thu, 19 Jan 2023 07:14:52 +0100
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
Message-ID: <20230119061452.GA17695@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net> <20230118052450.GA24742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118052450.GA24742@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_221458_970451_3684AF0B 
X-CRM114-Status: GOOD (  20.10  )
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

Folks, can you chime in if this comment makes sense?  I'd really
like to send the patches off to Jens before rc5.

On Wed, Jan 18, 2023 at 06:24:50AM +0100, Christoph Hellwig wrote:
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
---end quoted text---

