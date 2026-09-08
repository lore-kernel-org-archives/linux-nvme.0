Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3135FC79F82
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6C+kqlSOe7BujVcYU2aVBwDDH4BGfUwRRd45FnKQPo=; b=ZCYfQuue0U/xU0K0ElKfzO/8wC
	FN6l1/N5Wo1U87mpeJ/avfisau/E3hkUrQg6WJU28L8b6MVcRJSnQm5lc4gzH3twKw3YsBagITZ23
	79sYyg4KLpTuyh4dn++mwNnDblP0aub2Wk2ATvGrIZRfLMpMyqA+//kYBejoIKKWKcuxkyo3P9r8H
	cz97aonCVJUmKO4b3WzQvGefPabKGvX8k93S5yhqIQY76U8ISGGkafj4XzZB3crl+aMCbj25mRU9a
	DHY/2NLZdtibcgYGWrfZkKYYzDps9sF1HIZZ50dY+Focnf1zl7DGSaCOmVpvn7gON6STRBhqPrk/2
	/RGplMEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3zL8-00000009ldB-3O7A;
	Tue, 08 Sep 2026 17:10:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3zL4-00000009lcr-3a7m
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 17:10:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB238601FE;
	Tue,  8 Sep 2026 17:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F791F00A3A;
	Tue,  8 Sep 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887429;
	bh=Z6C+kqlSOe7BujVcYU2aVBwDDH4BGfUwRRd45FnKQPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aAIz/3f6hk5iNzHcort2vtou+3a9eSXltdWQsLlZ5lAatr1FdXRwicyV34tRBgJ2t
	 P0aSbVjInjRBzMv9Z6SFLQb5Tc2Cj9YUjxVEy6E5BYEedUFH41lEyebZHKXxfvKxCC
	 l8jXTPRFCmx4ALloY+2OKNbkybPBmdThVwLqEzZnT0lVVtGJXp+KrblkzPCwPQeyi0
	 FqpzLOMHh4/+gPt/lwVs48001tMO89T4s7F+Y8T3J3x6O7lfVxq/UxaLQCk/llwCTH
	 +3Kik1Ew0x+J/qqoKqOO6asG7zKbNVM1TLDHZ6hf8+7kZlVBCoDXAazrnD2sCFsEw8
	 dvxdWXYGV42BA==
Date: Tue, 8 Sep 2026 11:10:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Message-ID: <aqBBgzV1Q9pP7Z44@kbusch-mbp>
References: <20260903152623.614951-1-kbusch@meta.com>
 <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me>
 <aqAZ6S6lBILltRwq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqAZ6S6lBILltRwq@kbusch-mbp>
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

On Tue, Sep 08, 2026 at 08:21:29AM -0600, Keith Busch wrote:
> On Sun, Sep 06, 2026 at 03:04:42AM +0300, Sagi Grimberg wrote:
> > I'm wandering if you guys can do the same --duplicate-connect and setting
> > mpath with round-robin/queue-depth would get you the same result? Perhaps
> > we can add this flag to nvme discover/connect-all for simplicity?
> 
> Thanks, I'll give that suggestion a try. I think I also need to tie the
> "duplicate_connect" option to the module's wq_unbound option too.

Initial results show there's some promise to this suggestion, however, I
think in addition to the wq_unbound, it looks like I also need to adjust
the "io_cpu" to change to the submitter's CPU. I incorporated that in
this RFC, but there's also a proposal specifically for that here:

  https://lore.kernel.org/linux-nvme/20260820083634.71689-1-saravanand@crusoe.ai/

I need to catch up on the discussion there, but from what I can tell,
the cpu hint provided to the queue work appears to be important.

