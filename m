Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E426CCFA03
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rMtOlXVr1sORaIBCN/o1BbktuClkJCjCaSX2p+vPOU=; b=aDS9pX//aY1ZKqkycR1cq2uSd8
	eeqxIxPaMONQZ9+dSrTAi2NFFtZWNwwQeeJfI0UsxG8LSPZ8xcfvSE97uFID0N0J2UF/A3dbYWqZx
	4QODQ6Q7DToj7slpjHAR7eluRVCfIa3cDo88yTCJKrLZbwVUj30EopOmltKb7YRkQ3fxjReN+iTlG
	RWisapxIQ7XN8hdtWQqKTGU3zfl5DAJpL9SNC+KVvrdCmVa7APDX61HuA1VkzUCjE4/BeoS1n/3tg
	w6f0Fjtk/sFuFqZkDm7fIed48ocZuusY/OgegXQ6sVXedU/IHF0rMDrzwN+TO7+oLAAn5v4wVdxWr
	pdluUdwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGxxq-0000000FMzU-3xea;
	Thu, 06 Nov 2025 11:15:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGxxn-0000000FMz4-1Pij
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 11:15:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAEA9227A87; Thu,  6 Nov 2025 12:15:28 +0100 (CET)
Date: Thu, 6 Nov 2025 12:15:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.de, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251106111528.GB31430@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <20251105132023.GC19044@lst.de> <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_031535_522206_CC949FED 
X-CRM114-Status: GOOD (  11.16  )
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

On Thu, Nov 06, 2025 at 01:01:51PM +1000, Alistair Francis wrote:
> We don't actually need this memset at all, it's a mistake from my
> rebase, I'll drop it.
> 
> Do you still want me to just directly pass req->sq->sc_c in?

I think that's much cleaner.  OTOH we might as well just merge your fix
ASAP and clean this entire mess up later, so given that everything
looks correct:

Reviewed-by: Christoph Hellwig <hch@lst.de>


