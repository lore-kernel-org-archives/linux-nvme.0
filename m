Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4241C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814EE208B3
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1AYQsJ0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LliNBby4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814EE208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YMUogYxuvf/XzkQBHQt59oX+nWlBMlI4hUaLxMyCbVY=; b=N1AYQsJ0UVUj45YNrDTxWCvyp
	cI5dCovLxp57X4xUgcA0UXp95qk0PAOPjHZBuCdsA2ZZiiOcBrhEEDcmUeBedYgKUQSK8OrDJq+dv
	a7WY7AHybCaE8bJ4qUbpILBCLM/3r44ptm/jAGr2OqBzvZsqaP1Zr5FrIx7y5/k1GFItxiFD3mt1T
	xTiUrdXfxEVV/TuX97OZtxDEyR1NHs+dU4r7ExVOd414HQFMHuBiJ6PHzB1K86dUQYS8cVRqwZmsk
	JaF0unyxZdhos0asie1KN7CoFmTlAQFSqpmc8VITFtZKbExjYJwAk7Z37UYZONZb1rf6ObU3rQqwL
	/rqi9hehg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8o6s-0007Qn-JW; Thu, 20 Aug 2020 17:12:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8o6r-0007QI-F2
 for linux-nvme@merlin.infradead.org; Thu, 20 Aug 2020 17:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sNKOyAN070cUsV8VT5l3bx4jOXj3jbU+B3Xnf+xMJbU=; b=LliNBby4Jz/n3J8MwHRrJ2CQzi
 o6j9/rormt1Yg0F5ZhXEUvyqbxEHD7jkgg2KjSzf63lvQ3cFu5wq8FRi3WG6kyPEcjoYhzK13hW8y
 T376qiV0+ZwOI97/wM5AVpa2qUxF0CtK4rHu8JxocQAn0n49vw3o6ULWF+cDs6IHlqINTR0jZib6S
 ElYPOzdyai+/g6bSIZJKEwjqezLha3dcJrPscd22VAq/UQ+hoeIuAV5FDVDk0v385NeUbh3dVqVXL
 /nuGd7667wv90lywivb6L3pLCCgWgOYoJJEGlJ4uLJc/zqP0L3IEAQHWSos3Tc7pMIRU0NPEflc2a
 QMH2hVOg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k8o6p-0004aM-1f; Thu, 20 Aug 2020 17:12:15 +0000
Date: Thu, 20 Aug 2020 18:12:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200820171214.GA15207@infradead.org>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Ahmed S. Darwish" <a.darwish@linutronix.de>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
> To be fair, I've only heard this one complaint about it, so hopefully it's
> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
> just fine :-)

The cause for this is the weird NVMe of by ones, where 0 in a field
means 1.  So for the overflow to happen you need a controller that
supports USHORT_MAX queue entries.  Which don't seem to be all that
common.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
