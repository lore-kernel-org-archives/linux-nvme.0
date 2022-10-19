Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D450C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKSDhDxNNcFlEQPseCzxpWq6Saa/SiE+FdqWA79aEng=; b=cUaKBulY9q0yrnO3/oiq7ApiOX
	JVXbOeZSG7S0TXojcbKd9+yGcYPIB0PLMWhTHnHR6HLrQmpZsmJxgelDCU682MZBMhal4XEIYTb7R
	egJnUHPbdbbhDv0Kt0Ste/ijA7AKX1NQX9gTTa1KRx2YFROj1VnHep05OhgYvD9ZeRmanNM5TNWrl
	li3PNTfmLo7AzlzF9oxnyl9/rD1fnRKnQFwMQ49qbJqZIB57+83nVHEwUlLlU21Py1kkQcdHiN2e7
	WXDQIulVkLZC4YKQrvqOl6C99/WS9vouc4JbEnXbqoO4HUBiNwxwTCQ2qMVl1cV3CK10rIXibe8gP
	Ymax3A3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3Sh-00GAUB-WE; Wed, 19 Oct 2022 07:26:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3SP-00GARc-O0
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:25:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 830AA68C4E; Wed, 19 Oct 2022 09:25:35 +0200 (CEST)
Date: Wed, 19 Oct 2022 09:25:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019072535.GA11402@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_002541_962770_21B4C86A 
X-CRM114-Status: GOOD (  14.57  )
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

On Wed, Oct 19, 2022 at 10:15:26AM +0300, Sagi Grimberg wrote:
> nvme-tcp will opportunistically try a network send directly from
> .queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.
>
> nbd though can block in .queue_rq() with blocking network sends, however
> afaict nbd allocates a tagset per nbd_device, and also a request_queue
> per device, so its effectively the same if the srcu is in the tagset or
> in the request_queue.

Yes, the only multiple request_queue per tag_set cases right now
are nvme-tcp and mmc.  There have been patches from iSCSI, but they
seem to be stuck.

