Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB0EC3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 18:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F290D20705
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 18:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1NPKTDy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mweWcg/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F290D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wRhI8sjpfj5lW/fNDoh+SFY2Z/RP1vLFq2Ry3ncx/ps=; b=g1NPKTDyQ4qzDu
	yC7coBqh4AFMhLfKvC3GFHexZtUUmF0bG4iO5PFbkmZJySdr7RDnzLTh2jjkQEIEB1YccaB+JPYoi
	Si4q6Kvo2jTJy/ZUAk5mec7aHuinabOZmTaCbwszXKeIIg9pij+d8rklVUTzs2UgK1LPYh8EBuuGM
	IbzrF7dq47GTGkW/FkvNGlP3P8P8ePJAdAjwcY/CU420GPpnRyRTZPtmqzNRWlw+3qaVLP32ptLPU
	UESGDsO32k/3EAHlhRkw8jjShDv8XN7b1HlspQ+FAwtS0ZyYboAGJn8EpwYGnjx1q/xsasF+EhWd3
	I1cQkrhDGDj0TXV0UlLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVffq-0000tv-BV; Mon, 04 May 2020 18:18:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVffm-0000tC-L3
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 18:18:36 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 142B820661;
 Mon,  4 May 2020 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588616314;
 bh=U7NrlTtZGJ/ze2uiB5FejyGDxTZBN2BQ8uU0DGla7yE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mweWcg/71B6I6ZsNuVuTN2qEG5CJeNoUR/1szNdqlUwZN2nX/RPDMKq7tnnbYF2i5
 zLRwUjurrReSHZIhwnlydLx7/U4NItK4zRD3PUKTVZNCZv1x8J82vBa56ffD4DTEIM
 T9ayRWepGQObWbmhfn5jk+12q5470gyEEksic5LA=
Date: Mon, 4 May 2020 11:18:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvme-pci: reshuffle nvme_queue members
Message-ID: <20200504181832.GA2278084@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-3-kbusch@kernel.org>
 <20200501125704.GC5197@lst.de>
 <20200501150815.GA22665@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501150815.GA22665@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_111834_710363_C39BFDA1 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 02, 2020 at 12:08:15AM +0900, Keith Busch wrote:
> On Fri, May 01, 2020 at 02:57:04PM +0200, Christoph Hellwig wrote:
> > On Mon, Apr 27, 2020 at 04:52:43PM -0700, Keith Busch wrote:
> > > All the io path hot members can fit within the first 64-bytes, which is
> > > a common cacheline. Order the members of this struct so those members
> > > fit in and align to that window.
> > 
> > Do we even want to share a cacheline for the submission vs completion
> > path?  I know other places try to keep the deliberately separate.
> 
> We usually complete on the same CPU that submitted, so it appears
> beneficial to fit both sides in the same line. I'll try it out both
> ways, though I don't think I'll be able to measure a difference.

If there are more cpus than queues, there is a real benefit to
separating submit and complete into different cache lines, otherwise
they invalidate each other when submissions occur on cpus different than
completions. The extra space provides more flexibility arranging the
struct, so I'll experiment with that a bit more.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
