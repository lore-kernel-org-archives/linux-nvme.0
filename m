Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D6DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZQ87jNcSibaMijJAzuGXRUbsF1UNcQwuDJmlmj6JJs=; b=nr008gGiUpBIQGPWX1O6eG6u0g
	qIwFPF4swfC/7jNAmwhxSTR5XFQNDxJp9awRAk/hAH+kdXBCONe5oSFA0ojsh0qnG/plx8iCtQW9i
	CuAA8ZwHlFOO75rmtl5SRlEgsNyiz+gmfrEjAc2goazWOvs3XUXEir3tyViCAZwrbFolmo40Z9vLu
	I4dgQMCBijNGP5fZPtN6mVtPvJT2PkEGDtkoCoW/Xf5Mj6fu6GC7Yfk6xyI37D2bVZus6KQQFg43a
	hd6mLgZLlZbr0r2FDKC77+rGvN9xIX2g5UasTUdsYPysvY5sOeQUn8d2RXLnTJBrSUOCXc9F/0OdQ
	FjR2IDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMZ2m-00B0tP-Lz; Tue, 22 Feb 2022 17:33:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nMYyk-00Azgh-NF; Tue, 22 Feb 2022 17:29:34 +0000
Date: Tue, 22 Feb 2022 09:29:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YhUdfqXy0wCDQywm@infradead.org>
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
 <YhUbhsy+C7Q16ihM@infradead.org>
 <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
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

On Tue, Feb 22, 2022 at 10:26:16AM -0700, Jens Axboe wrote:
> Hmm?
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=93e2c52d71a6067d08ee927e2682e9781cb911ef

Indeed.  I somehow had a stale block-5.17 branch locally.

