Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FD8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Dec 2021 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lb7kM4YAisHWG/xpOq2BUblqPQsH2mfIVfpAb4VIglk=; b=KmquCSdcZpP/aXCYtQTZtoK6OS
	8dxDNxqkyzOx7cmOig8Z10nH1HtLKbASHqtksb4ZNDEpX2ij2XvviWF154n0/E3YFYxynaTq+388t
	5HhnrnyGAEsu7C1EeKtJuONm8OyeqZ2Ai41hlzWSA6fJ8KlDWaUk7U5Ilp2zF/dalM4OuZi00ugf8
	6HEpUKQ22sM/LrMFnS6ImSIXHvIrfb09iXY296+Xh8rgMyFCD9jRgZ745gzkxglFkHn0IAt56crWV
	5Ndq7DY4wlqbB4pHgpRx9ekzeP7/bb+/dYg/Vkn1OyFg2qEoy3u95iw8km1OMg3FAygFbbT74mKR9
	cwSf6SRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2qQ6-003zJT-Ae; Thu, 30 Dec 2021 08:04:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2qG2-003vJi-I8
 for linux-nvme@lists.infradead.org; Thu, 30 Dec 2021 07:53:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 715A768AFE; Thu, 30 Dec 2021 08:53:48 +0100 (CET)
Date: Thu, 30 Dec 2021 08:53:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20211230075348.GA5073@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-3-kbusch@kernel.org> <20211229174602.GC28058@lst.de>
 <20211229210446.GC2493133@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229210446.GC2493133@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_235354_794152_2627AF22 
X-CRM114-Status: GOOD (  16.82  )
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

On Wed, Dec 29, 2021 at 01:04:46PM -0800, Keith Busch wrote:
> On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> > > +			rq_list_move(rqlist, &requeue_list, req, prev, next);
> > > +
> > > +			req = prev;
> > > +			if (!req)
> > > +				continue;
> > 
> > Shouldn't this be a break?
> 
> The condition just means we're at the beginning of the rqlist. There may
> be more requests to consider, so we have to continue.
> 
> Or are you saying any failed prep should just abandon the batched
> sequence? If so, we would need to concat the return list with the rest
> of rqlist before breaking.

No, I misunderstood the check,

