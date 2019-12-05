Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B513C43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79D424670
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBSXybwu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTLXCTLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D424670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/Ah7fdukdYlXk3nCjvpawA51CiB/0DO43/axxoVFGE=; b=HBSXybwukcABN+
	boHVPmijBdrFlvaD9vHrMRZKyRG/kf544gzWFmC1y7p6va2DnOSmZmlDHkL7mEkA6EexOXsSLsyiz
	c9KlvxzmHO9zdwqv1mTW7y+4NHokYjx4zEHTR560uS+0Vw+920/TztMG1APhf2V+SaBmuTqP0XLac
	/60HVx88deNyIfklx94DJy0ZORmeZfnv60eCtcjCLeg87NI3639ztFjBqhAj9k01fe34toL36mb16
	EF4TjzHXJAcqiAdH/aETlvrNCsvPGGO2kucUSsjvva+Tu+4SkuoDdyeHmL+Dvf9lClrA7LtT5Xge0
	w8MZFXJE6f0VxhaiRRRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icy2y-0002FZ-Pw; Thu, 05 Dec 2019 20:48:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icy2w-0002FB-J0
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 20:48:23 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9EE1524670;
 Thu,  5 Dec 2019 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575578902;
 bh=dEoC9AZzhU8jPf9Mu2KZm8N1mMXRGwudxGlbDxoLqrQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTLXCTLQIFBUetmYpasefx6FhAKfFuhXiEU7nzoKxYnarWxwCHv/owrH+PeyrAjpR
 K7wyGVbmQkZ8kDjn/QugIfW3lIu/THINV7I+4gD3ukVJwPx2Oa1TOLYrBaaBaY7lcI
 ztPDn5pnAAsR9Xnw9PN68nducqYzYLFf1pJNpNWY=
Date: Fri, 6 Dec 2019 05:48:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH] nvme/pci: Remove last_sq_tail
Message-ID: <20191205204812.GA27699@redsun51.ssa.fujisawa.hgst.com>
References: <20191205200825.27651-1-kbusch@kernel.org>
 <149bb39b-e8ab-36a5-f319-18ef5e3567b6@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <149bb39b-e8ab-36a5-f319-18ef5e3567b6@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_124822_650312_E22CC716 
X-CRM114-Status: GOOD (  12.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 05, 2019 at 01:31:20PM -0700, Nadolski, Edmund wrote:
> On 12/5/2019 1:08 PM, Keith Busch wrote:
> > We don't allocate enough tags to wrap the submission queue. Remove
> > tracking for this condition.
> 
> Can we ensure that this presumption won't change?

If we did have more tags, there'd be no guarantee we could even dispatch
them, and we'd have to track the CQE sq_head value to ensure an available
slot. There's really no performance win to adding that overhead to the
driver. On top of that, I'm aware there are more than a few controllers
that will break if we wrap the submission queue. So I don't see this
changing.
 
> > @@ -462,21 +461,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
> >   /*
> >    * Write sq tail if we are asked to, or if the next command would wrap.
> 
> Comment needs to be updated.

Yep, that comment would be outdated with this patch.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
