Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C17CC54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcwsIVlHtv79TdmxNQZaGKBWwwRTovuwEgs1lf2B1Bk=; b=OueMwtxAhHwVQSPhgPH4GJ91kI
	SZwZMQC9a9f/Y3jUwCclUhS5/o+d8MU+OZfgXs/BJ/wn/QXJcHWO6wXgjGTdkZld5/zwE7P/m1In9
	d4wStIJYKTYVwC2FyMPxGWF9GPYbBL6B3xfPYY2GtN2gwzWLcGy2uBzhVTGCCx0ebAHWNMEjKeyz6
	Wk0u6mLj9qstI81xbsHI5rOAkWrA+mowHejm8uPjMpqFVBZ64Q0yK70/moxsbaKcgJ+g9fn7j0HZy
	xkNfxe5kRG1XEH5iLsyddVPUer7ux8vtsoUXqeyksncNPW+Aw1uziaSFTAn0HEXB1JB4frB7WrBkk
	KHsSVJsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXum-004X0e-Tv; Mon, 30 Jan 2023 17:25:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXqI-004UYd-DF
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 17:21:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 313A668C7B; Mon, 30 Jan 2023 07:45:24 +0100 (CET)
Date: Mon, 30 Jan 2023 07:45:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v10 00/25] nvme-tcp receive offloads
Message-ID: <20230130064523.GA31758@lst.de>
References: <20230126162136.13003-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126162136.13003-1-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_092118_643915_B58AD214 
X-CRM114-Status: UNSURE (   7.66  )
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

FYI, before someone jumps to far ahead, the nvme side needs a strong
ACK from Sagi as our primary nvme-tcp maintainer.

