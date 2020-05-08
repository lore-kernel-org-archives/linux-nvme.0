Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B60C38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 21:00:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861202173E
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BwGk0eUy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2QE56J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861202173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xb7TfD6iCC6mzU8iBBOrJ1XoXP9gWNaNV1ksizcZz/8=; b=BwGk0eUySx6JCi
	kZgJLoRHorGgXq1dpLBwiIXH7bV7d9+yVy7Q15z2/sp/VvUBqPO0tZmuCgvrDnxRt5Ad841QcQnc2
	TAQPANBWq9sasvBBTijqMpGI+GMu1ecUOdEr8e8oJabziUv5v9QFXjBdN+iobVLLRVwAdEdSAf2Qu
	Rbjvtqog4gqgnkdaW7V8V2Ff3i+R7i+4hnpqgSfCzMOdHzhpCL1PnKw4p7uSesrNDUwGD6N6xY0QF
	E/lBJfGWsfh8YlL/urMaq69zPAyJFiHCL/SeQgRg1qsXx0rxJhtvHSGnfoeC4bDG4mjz8CzcEn85A
	hKab6ywj0fhkXamSZ9OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jXA6n-0001SW-R9; Fri, 08 May 2020 21:00:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXA6m-0001SB-4L
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 21:00:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 54A572173E;
 Fri,  8 May 2020 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588971635;
 bh=NLlqr5MpbhQBQxQf5EupuOLOIwlCzSJ6TEwz9kdWdu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x2QE56J0hr8nB0idFoEe5h6/1haEw1otvcID5gjOAXxJvo1XvdbD9yyQPpm8FHmtX
 vvr9APMWfjm1Wiih8TMb8VjRhsE3PMdpxH3ztl4w7hKa6zBzAUsxmsdxRbscl/ofBn
 4Ev4yYEHneUoHp77s+tjGJ1GfWXdqbged7R+6Suk=
Date: Fri, 8 May 2020 14:00:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: dma read memory barrier for completions
Message-ID: <20200508210033.GA2814530@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200508200406.2814437-1-kbusch@kernel.org>
 <34740788-df94-d2e0-fa63-5568e379cdd9@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34740788-df94-d2e0-fa63-5568e379cdd9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_140036_191587_A511BA36 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
 hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2020 at 01:12:50PM -0700, Sagi Grimberg wrote:
> 
> > Control dependencies do not guarantee load order across the condition,
> > allowing a CPU to predict and speculate memory reads.
> > 
> > Commit 324b494c2862 inlined verifying a new completion with its
> 
> I think we need a "Fixes" tag to get it into stable 5.6.y right?

5.6 doesn't include the commit that reintroduced inline completion
handling, so there's no stable this would apply to.

But really, the driver handled completions inline with the phase for
most of its existence (3.3 - 4.17). It was only recently we had the
split handling, so I'm not sure why its only an issue now unless
more recent compilers and/or CPU made it more likely.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
