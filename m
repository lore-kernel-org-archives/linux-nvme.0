Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CBFE7C4F4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSKsF7kw8yuEjEtI3kFNrg0/ffjX1OkH5lHupDNlfX4=; b=0+28D69TdUenThxQ/SMhqtyLao
	9bbfPW31ATHBec9JhpHoIFidADjriA9YwGZsw9jZCDMhJIIX2z9YmLHlKsFXMStbC5zPvRqQCYorR
	sVOHl3OkYkAczEMBQg1qm25DX9b8JkPmkoiakZcCU9KorZM9+WxV/y/4CIRXxU0KtWVXaXhcLTCvm
	BbNPMdB/gxrxLzqfyL8hm+7JmNJe31OrTtuqHx7JIhCoCrLOfeM2Po40nsafLpux6YgGGeZ5iCuvT
	OEwbssv27uhPLlpTrvr0qErc5/81/zDRLY7ubgUkt4EeZHQJYDGMSkHiKVyHelMfuFh2uLJY/cmS5
	1LdpAHYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJfo-001flE-0j;
	Thu, 05 Oct 2023 08:25:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJfn-001fl7-2g;
	Thu, 05 Oct 2023 08:25:31 +0000
Date: Thu, 5 Oct 2023 01:25:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Syms <mark.syms@cloud.com>
Cc: linux-nvme@lists.infradead.org,
	Ross Lagerwall <ross.lagerwall@cloud.com>,
	Andrew Cooper <andrew.cooper@cloud.com>
Subject: Re: NVMe fabric multipathing
Message-ID: <ZR5y+2P/NQ25/Rkv@infradead.org>
References: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
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

Hi Mark,

On Mon, Oct 02, 2023 at 01:22:59PM +0100, Mark Syms wrote:
> We have a requirement to report information about the status of NVMe
> multipath controllers on an NVMe over fabrics deployment. In
> particular the total number of "known" paths and the number of
> "currently active" paths. As far as we can see right now, when a path
> to an NVMe target device, when using Fibre Channel, is blocked, all
> local information about the affected controller is flushed leaving
> just the currently active controller(s) present.

What do you mean with "blocked"?


