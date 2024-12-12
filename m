Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BD9E77180
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 06:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1veTsBCtOJySm4RUgKDwnkIozaxKVrVF6NWe0LlFAI=; b=07EW9b9DDrTPU7W8sL2X89ehdt
	d5+OI9bKuXGdBnx5phi/eIhoC0H1XMpQq4db3drijtXYRZDjj5PdzzxGkVCrgEONSWgv+Hk2WYziO
	OGzGIUrmaFMZKloZY3kQNcmASUXXQXcnDZ28pjIb4KF/lrmmClQEmZih49+BcUfmuxCbwmendB6/C
	UacQIhibI39uFoT8J3/BoYSt1fPcOQpZJfldAWz+r67kHHLMjfIw6w0Q1tdrv5oVyb4FRSn3aQOkB
	IQFbm9OIf9iB732EeXYRELkjoVWP4o1K5MusYF9T53EBacwWIqOMgpcrvHwXgyIA5O8Aniy2iHmsG
	dTdJWz6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLceP-0000000H2Xi-3qoO;
	Thu, 12 Dec 2024 06:26:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcb0-0000000H1ur-0z9B
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 06:22:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78D1368D0E; Thu, 12 Dec 2024 07:22:41 +0100 (CET)
Date: Thu, 12 Dec 2024 07:22:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: define pr_fmt()
Message-ID: <20241212062241.GA5586@lst.de>
References: <877fbfffe61b9b17bfd7d4338f879e27b33e9b71.1733737768.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877fbfffe61b9b17bfd7d4338f879e27b33e9b71.1733737768.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_222246_412335_3D5A7E09 
X-CRM114-Status: GOOD (  11.64  )
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

On Mon, Dec 09, 2024 at 11:49:28AM +0200, Baruch Siach wrote:
> Make pr_err() call from nvme_find_rq() produce messages with prefix, to
> ease debug.

Really?  If you want useful information there I don't think the prefix
is very useful.  You'd be better off passing the nvme_ctrl and then
use dev_err based on that.


