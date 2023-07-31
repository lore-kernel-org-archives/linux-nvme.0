Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E9C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yj32Z4uprL3OyQ2speBlNpV9aNtjSpuXnPP9C9MGlWM=; b=SrFzg2YUnj/B/3JiC6bMRECLSy
	EQwC+Fy8C8pPjq6yDkCT8W6RVP7cgnDX88hysa/h+fkKqN6VxuK47Amk/6WoOp/N+FXCEwRBPH1Gw
	otwC4g9cxIAOHZ2+sOA38BaakM9uoRp2cPyf1rKTbrhmGT5GJDZshpy8mHqy8y76FTSww4md6/jkj
	CHw1aU126t4cX+pWqAQnMeV9UIefiNFOHkzeBxCZGxJZDz70ysLFh8USNUEAEIyAKoRbcmfqUA3WB
	T263eByab4Ud9XncpY755OGphduFJPhcvhaAUqyaMSzurCQ15ui0lwPQWNJEDaUqQNpOK+ABc+C5M
	PMHaupEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTKV-00Fsrt-31;
	Mon, 31 Jul 2023 13:53:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTJb-00Fs4x-1u
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 13:52:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E72F767373; Mon, 31 Jul 2023 15:51:52 +0200 (CEST)
Date: Mon, 31 Jul 2023 15:51:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Mark O'Donovan <shiftee@posteo.net>, linux-nvme@lists.infradead.org,
	kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Message-ID: <20230731135152.GA6016@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net> <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_065203_806859_803D1082 
X-CRM114-Status: GOOD (  10.43  )
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

On Mon, Jul 31, 2023 at 02:00:37PM +0200, Markus Elfring wrote:
> Are imperative change descriptions still preferred?

It doesn't fucking matter.  Please stop spamming nvme contributors.

