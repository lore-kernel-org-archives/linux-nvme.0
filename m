Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563FBC19F28
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bp/g6eNlnCBAoZ0LWknApR0tx19tg/4ymXOK+EaQ2xI=; b=nm6JxJGHn3MvwgX7TyAsJsJNFk
	ogEDo6xdBPZbmA0S9FP0m8A0plDOYUi2Yinuzoi0YroDaW+oxf71oj68ka7zqKaIg0QNH0uielUgp
	F8zq7AWeuWT3jwou+ysAHx5ZBAEpfzPN6IzwmV81kiokdqDZsUa89o+6YcUd7Oa4kDgSkov5vytKE
	mqFBMW8/BOMrJwCINDNcRq4xphDy8zjWg1DzBVU3eq6XVc/LKyt/09MFgE/D7UST48wQ16+QM5sLa
	Xqoq7ykR9qWFyFwz21d5gVLeR/9SzTQPpcfdtIcr1kdrH9v5v8weZrdVW7+k8oKAeTugeXVILTmjM
	+/FcEr2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGivp-00F2G4-2k; Wed, 27 Jul 2022 15:26:41 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGivm-00F2AR-Kc
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 15:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bp/g6eNlnCBAoZ0LWknApR0tx19tg/4ymXOK+EaQ2xI=; b=PGKLeNIv6uHmwfWjKHrBIZJjtU
	YcVbDBx12Zx6rEP8m7PHB9OY5VmANeGtzN/g+el8JBPwOnDURJW68ZevdlXKf72dILCEjMA7z8QkS
	ZC0PRbXypxE3ld9TjNqEg3nmZ16XaL8Dw0ZrqcAVPFvEKLrKUjgIfa8nhqPm9nvVP5CL0URUuE2Om
	xPsiekYDg9QEe6MjhHuEUoQVbIEDMaaBxx2+RIehyCgEncFobpl1mM0T8zO1LHsAtwRmehd4wRpjF
	IxCMBJrz/aCbsrztgCs3+w8AW5nWAq1l0QYziAyfTLMv84wgvMxkg3co2D3ofoV08tkfV4w9tQCb6
	C43YC4rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oGiva-00GPdH-T3;
	Wed, 27 Jul 2022 15:26:26 +0000
Date: Wed, 27 Jul 2022 16:26:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFZIrvTaKBQtml/@ZenIV>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuFHeT0UaQsYssin@ZenIV>
 <YuFQPYvOHzpVimJA@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFQPYvOHzpVimJA@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_082638_708456_0F09B93A 
X-CRM114-Status: GOOD (  14.81  )
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

On Wed, Jul 27, 2022 at 08:48:29AM -0600, Keith Busch wrote:

> > This, BTW, is completely insane - what happens if you follow that
> > with close(map.fd)?  A bunch of dangling struct file references?
> 
> This should have been tied to files registered with the io_uring instance
> holding a reference, and cleaned up when the files are unregistered. I may be
> missing some cases here, so I'll fix that up.

???

Your code does the following sequence:
	file = fget(some number)
	store the obtained pointer in a lot of places
	fput(file)

What is "may be missing" and what kind of "registration" could possibly
help here?  As soon as fget() had returned the reference, another thread
might have removed it from the descriptor table, leaving you the sole holder
of reference to object.  In that case it will be destroyed by fput(), making
its memory free for reuse.

Looks like you have some very odd idea of what the struct file lifetime rules
are...

> > I really don't understand what you are trying to do here
> 
> We want to register userspace addresses with the block_device just once. We can
> skip costly per-IO setup this way.

Explain, please.  How will those be used afterwards and how will IO be matched
with the file you've passed here?

