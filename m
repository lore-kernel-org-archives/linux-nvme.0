Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4C7CF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyTFCepw49Sr70nwPNZmsLl+RmB8rqYR5jxnwLmIumE=; b=rSwfJbKHiBnHdluxrFj1L7sRi0
	gwD6qN023Gs15M7jJ+L2a0oDZLF3OKm/1QWSYPFHH3DHcKMMqzJHJpd4H/yQxjIBLp9M4kae1BvN6
	IOIpSaZ82K0dG7TuJ7w6CUGi6+UNmTh+alfVioN2hBfQnqSv94wlowOEnxJddRiHApi2tzK0E3TwO
	CWn7He4twlQhvCW6/XNGaN4Vq9Zg+XVaLI2El2gM8B2sDHvun+0zc6KpbGFI3HQ6jYaVEoS+tWpL1
	uJiuWhwGAXnK80xguTrYdN0KoPagrsN/cbNy871Sc7AuN9PSn3EMp2ePN64uZjkm8KmznWcSt6rMI
	yPRGcV8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st24t-00000001rRW-0qDK;
	Tue, 24 Sep 2024 09:43:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st22F-00000001qaj-2NxC
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:40:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C249D227A8E; Tue, 24 Sep 2024 11:40:40 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:40:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v6 3/3] io_uring: enable per-io hinting capability
Message-ID: <20240924094040.GB27855@lst.de>
References: <20240924092457.7846-1-joshi.k@samsung.com> <CGME20240924093257epcas5p174955ae79ae2d08a886eeb45a6976d53@epcas5p1.samsung.com> <20240924092457.7846-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924092457.7846-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_024043_808201_574B9970 
X-CRM114-Status: UNSURE (   8.69  )
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

Per-I/O hints really can't work for file system interfaes.  They
will have to be a clear opt in to support for regular files.

I'll do a more detailed review when I'm back next week.


