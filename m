Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB4C43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 00:52:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD7A206E2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 00:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wxx2mDFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRdEqXGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD7A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQE7QAgZLAQNYg06sj1+6SjYeLEkATPcn1WJojOHMtQ=; b=Wxx2mDFqiYalrk
	e44kpWSpsEVgXtmmqGF/64JiQNtm94W5A4cduOULJiU/tkGjnbKTQ5H7LLrp6UCucVUdCk+LwbSUc
	cNNYK74T6pevZkTXDaDNH5eSMDgSDwCMS0/0VhtBf/cu8XuzF0PBvb007bEqvcumtA7bQvoW7fHOK
	RFFrHM3H0J8ral/Bmyp8NizvuzkCqbgUDKvPV5IPTTgOqu62gBhsI3G/rOp10USqzKfTMzaKrziWe
	OBPIhzeF+83J4K/cbirPGHqJAxTuB+6B0ZBMKtIjE0+Nifa+yogJSbiQFMBwbNRcVGDcBDx0Yj5rO
	Qm1qCinXF4fRN2NjCJ1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifZCQ-0007TX-1i; Fri, 13 Dec 2019 00:52:54 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifZCM-0007SQ-OP
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 00:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576198369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTa596pRnxsTbOIWtNuG1hw2bBiDPaolhZ9HkyeTN3A=;
 b=WRdEqXGgTRe8Vz4KxqOFQRLyiiAd496BWTppxZfKJhyxR586qiHDWxVyOkeJiBtxE+sOAj
 j5CaepvkvYb1ROT8KRSLOfcZ+CJFBqvCOIV60Zo/rSi+X3NHqH2ypRzQ79so+rfBBTZI0Z
 vcmrhJtsg3er/1RCVrEIV2cFDvGT0hE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-3dUa16TNOviyDogake-DzA-1; Thu, 12 Dec 2019 19:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238C91005510;
 Fri, 13 Dec 2019 00:52:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F30B1001925;
 Fri, 13 Dec 2019 00:52:39 +0000 (UTC)
Date: Fri, 13 Dec 2019 08:52:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/4] nvme/pci: Complete commands from primary handler
Message-ID: <20191213005235.GA30695@ming.t460p>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-3-kbusch@kernel.org>
 <6d55a705-6a43-5b47-166c-5d2b458fd6a5@grimberg.me>
 <20191210202506.GA26810@redsun51.ssa.fujisawa.hgst.com>
 <c58e2cb5-e03c-c56f-8c67-a791ac1eb2c6@grimberg.me>
 <20191211173532.GB493@redsun51.ssa.fujisawa.hgst.com>
 <79442e8d-719a-7510-deea-cc23694fdec0@grimberg.me>
 <20191212010240.GA29574@redsun51.ssa.fujisawa.hgst.com>
 <20191212225552.GB24463@ming.t460p>
 <20191212233039.GA69218@C02WT3WMHTD6>
MIME-Version: 1.0
In-Reply-To: <20191212233039.GA69218@C02WT3WMHTD6>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3dUa16TNOviyDogake-DzA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_165250_894782_F26D3C51 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2019 at 04:30:39PM -0700, Keith Busch wrote:
> On Fri, Dec 13, 2019 at 06:55:52AM +0800, Ming Lei wrote:
> > On Thu, Dec 12, 2019 at 10:02:40AM +0900, Keith Busch wrote:
> > > On Wed, Dec 11, 2019 at 04:40:47PM -0800, Sagi Grimberg wrote:
> > > > > Perhaps we can cycle the effective_affinity through the smp_affinity?
> > > > 
> > > > Not sure I follow your thoughts.
> > > 
> > > The only way the nvme driver's interrupt handler can saturate a
> > > cpu requires the smp_affinity have multiple online cpus set. The
> > 
> > As Sagi mentioned, there can be 24 drives, each drive can be 1:1
> > mapping, so each CPU may have to handle interrupts from 24 drives/queues,
> > then the CPU may become slower compared with the 24 hardware/queues.
> 
> If it's 1:1 queue:cpu, then it doesn't matter how many devices you
> have. Processes can't submit commands on that cpu while that cpu
> is servicing device interrupts, but the device can't send interrupts
> if processes can't submit commands.
> 

OK, but still not sure it is good to cycle the effective_affinity through the
smp_affinity:

1) the top half(primary interrupt handler) still might saturate the CPU

1) task migration isn't cheap from one CPU to another one

2) in theory we only need to do that when one interrupt target CPU is saturated,
but changing thread's affinity has to be done beforehand, so this way may hurt
performance when the CPU is never saturated. I believe that should be usual case.


Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
