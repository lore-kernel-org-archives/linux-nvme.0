Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B4C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxOKadv0f36OUSMWitFuZQnmOGS5qCuBt00e0DPJuXM=; b=pabEfCCrOtC3ziRjtfAFFHZlMU
	5H3w2BrCUw5EXoB6vRoHWUfr4zMT0Pq4/gQcIUmxaHHgcVBdF9TRkycMoLuvlEyLjP3VWBfyqhl/4
	P9UOfT3CN9OtaZBq19DPxz1Zx9RedJCt41lvvoxTziEJqJfIIrlFgDILQxSuNJg2DoXp7sho4J/99
	XPUZezD1ZrcH/Zz/y3oxVlhjNwellcEqbKWXO/iMkkxHQbfjRfLm8ig30c3VjOVzSjhlI3PdcHQ3m
	tnGx+rsB7uCh4B2Gt+h7lcQkmj2v0KVVyT1XOs5MBtfGbbrHt8yPmzmvrsZKRV4rzv53mCyB5nUwj
	Fgdy5Rag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4TJ-0000000E45H-3ISN;
	Wed, 14 May 2025 05:16:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4TG-0000000E44x-2zqi
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:15:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A28268AA6; Wed, 14 May 2025 07:15:54 +0200 (CEST)
Date: Wed, 14 May 2025 07:15:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/7] nvme-pci: remove struct nvme_descriptor
Message-ID: <20250514051554.GA24437@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-4-hch@lst.de> <CADUfDZr+CffCFTafw5BB8q3otr=Sw8GxP81_YxxBKUAmQkAbhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZr+CffCFTafw5BB8q3otr=Sw8GxP81_YxxBKUAmQkAbhQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_221558_890886_61F6E8AB 
X-CRM114-Status: GOOD (  13.16  )
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

On Tue, May 13, 2025 at 06:07:11PM -0700, Caleb Sander Mateos wrote:
> > -       union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
> > +       void *meta_descriptor;
> 
> It looks like only the sg_list variant of meta_list is currently used.
> Should this just be a struct nvme_sgl_desc *?

Good question.  type safety is always good, and given how the metadata
pointer work adding anything else is highly unlikely.  OTOH it would
make things a little less symmetric, but I guess we can live with that.

