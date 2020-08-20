Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD477C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED0B208A9
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XejotSJ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmZfB2nv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5yGnKX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED0B208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bkVF2B2O7eYmoeBY1Zjq7lzhSsFRj6KmLdZUqgiXDJM=; b=XejotSJ9KAQJRUvhlY7TeS7B4
	ZonLmqsGTpdXj5z/FhfFBzWesJpt1yufwnLDvSGPLZQoJDqDq4R1C8Bs4Tn9gc7eeoTNy2Psi+wlt
	MQ2qI+ssOcRg6yA+qPDrvKjMxdyJu1g3roOoQQddcTW2EG3hNDiwHpdUw7gOLRao71FswRi98m6cS
	BhSb8/7nfP4OL88LosSxOKMkARBincx0A+HTXvhm3lMFFzvmQmVstfuOto5a5Hi4xgnrgUeIfrXDW
	ss4UT+MrDLg1EkZ0y7bUL5A5dCwFCucp8dQUfCRDhyXQ4z5g7CDpfQFgmhYqBWl7rFT7NZLpyEGsX
	iurc9x05g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8o24-0006LF-Ot; Thu, 20 Aug 2020 17:07:20 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8o21-0006KJ-TD
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 17:07:18 +0000
Date: Thu, 20 Aug 2020 19:07:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597943235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jlvtjajrYXjF/1spfrNL4IaV3D7DPvsLkUvhddqIoA=;
 b=ZmZfB2nvVJyg4zXwM8VWNcoTwzukQ5Yga7nuhM0yTBPOCLRYACUkA8NtraPFH0RKjZmxkS
 CvxJlhOyfLO8c/CgGgFqRp1S8dyq6vwOYR3qr/zxiUyD/2DsUyNMS7qHRt3nlj1edEdpyQ
 o6K95FIkVrtMOZ34upntnyM8YPjO4uQ5a2on5QayTP68rDAH1CSGtiGVDHRLdrNk7sdMRF
 qHuOlNQNln5fOaza9nRuSqE1UKJIQD3RrLew5MizgC6lEHNK1Nl2OP/gnZ1lOg8eHzRgj/
 fmYOFT4z6TyYBRbHJdDbrjbg03sICy2LQ2Ko++GLkzjTRcLjgum9WN7/aSLv4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597943235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jlvtjajrYXjF/1spfrNL4IaV3D7DPvsLkUvhddqIoA=;
 b=f5yGnKX71cuEFvCE8bDQJFc79TQ3ypU/os8nwaj9GsAVwGbRGgbGYD4gREAYAwPNqYgdtp
 bRsn/tN0BK7faIBQ==
From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200820170729.GA4116@lx-t490>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_130718_061000_9757EC86 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 09:35:38AM -0600, Jens Axboe wrote:
> On 8/17/20 9:58 AM, Jens Axboe wrote:
> > On 8/17/20 8:56 AM, Keith Busch wrote:
> >> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
> >>> Hello,
> >>>
> >>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
> >>> laptop. PCI nvme detection fails, and the kernel becomes not able
> >>> anymore to find the rootfs / parse "root=".
> >>>
> >>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
> >>> fixes the problem and makes me able to boot v5.9-rc1.
> >>
> >> The fix is staged in the nvme tree here:
> >>
> >>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
> >
> > That would have been nice to have in -rc1...
>
> And now we're getting very close to shipping items for -rc2, and it's still
> not in. Can we please get the nvme pull request out for -rc2?
>

I keep wondering that myself. Completely breaking the boot like this is
really not nice -- and for x86-64 laptops no less :-(

The fix is really small and isolated. "Urgent pull requests", containing
only a fix or two, were created *exactly* for this reson...

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
