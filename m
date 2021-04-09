Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C693C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:39:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A57061107
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57061107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pJwQs/VJ/vOPpf7wlTlhmuynGBvJaFYN9P2mcaFQq60=; b=I13yKJQDPTuacpwAcNcDc7ayP
	cq2FF0TtnGdQ9AxkXJ+cj5eOM8WBwaN0v2mpV7D/2HZBdnU/YcHYneWAKDfuOBz22GXX/74ub2Oyf
	zNCUndmeiqCBwMMlOcSnM4ywqldXrY04SeVycXNTlrcX1Qm3YSo0rmpZ+v1UOUcx5GFU8N0J9nGV8
	BkqSWCHJbPrJTivdbUpqK9lpcI46Wgte6+9H/VcLtiZ1R0AuSDpPKrINOls1ZEFDPVW/OAVI3URvU
	/2KWpbEGP77dUHJi9KMlsJq7aTPTq9L0QotLohXs3XzA+0DYbRPspA0OFuNLM16C3MokP0mwGGnWO
	AVfCwdpjg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUjrb-00AAc8-VK; Fri, 09 Apr 2021 05:39:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUjrH-00AAWr-Bw
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:39:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E426668BEB; Fri,  9 Apr 2021 07:39:02 +0200 (CEST)
Date: Fri, 9 Apr 2021 07:39:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/13] nvme: let namespace probing continue for
 unsupported features
Message-ID: <20210409053902.GA2575@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-13-hch@lst.de>
 <20210408224259.GA28814@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408224259.GA28814@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_063908_220941_D2E837CA 
X-CRM114-Status: GOOD (  15.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 09, 2021 at 07:42:59AM +0900, Keith Busch wrote:
> On Thu, Apr 08, 2021 at 02:08:41PM +0200, Christoph Hellwig wrote:
> > Instead of failing to scan the namespace entirely when unsupported
> > features are detected, just mark the gendisk hidden but allow other
> > access like the upcoming per-namespace character device.
> 
> This part looks fine for what it is, but I thought we were going even
> further by allocating a namespace for the generic char device even if
> its Command Set Indicator was unsupported by the kernel.

We need a currently unpublished TP (don't remember the number offhand)
that adds another new Identify page for that.  So it is on the TODO
list but can't be done yet.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
