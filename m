Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC91C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:To:From
	:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/M2luA5ZNvi/tJZ5BFIDGLiFRPq/3auElkUCIUUME4=; b=ITdjIF/s8++wN1IEaSGgcjLTHB
	rzK3iRB7dNlOFWANr0EEdWF2wH8qsKVuiajouJdL5XrXvZ4n+3shpPDBPoX8ZWSFmt4jvqi64jy44
	PuQEsv2sIx3ozkOB5kCPVX9bmfVXy3zMpG3BBP9AFw3IiK4g2nMNuihw78qnnS2d4ueGO0qDY5YpH
	sZGgvAYpv+AH1CG1oC3n3nRHBCbXGTiksP1UREnyxto98nHPYs+OM4Gpws6Cauw7KDlrHhdaQt+oE
	Cb4AerFuZ0Y/z4G7Mn190fl4PuSlYtk0qp9OlUX6js1W7Egp17ylD69kae/xY38aTY5U+un/BV/1z
	j8QwSngw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrdBZ-006F6j-Sb; Thu, 19 May 2022 10:15:13 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrdBX-006F5k-5Q
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 10:15:13 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 18C43320082A
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 06:15:06 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
 by compute2.internal (MEProxy); Thu, 19 May 2022 06:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scriven.org; h=
 cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm3; t=1652955305; x=1653041705; bh=l/M2luA5ZN
 vi/tJZ5BFIDGLiFRPq/3auElkUCIUUME4=; b=jGaTItLwr6vBjabWnmnAkMhWQd
 nE4oymwIB7lPtmF2bPDNxJFElZkHovq5+t4RvGJTDbI/M6yr4hGDOj+Ft0bacSMX
 15dvXxnIjrv41l9gdgbOS7IzpmJC9MVF5Rx44EkGpeRSOnnSYYDd/ZdE5Ijsq05i
 juhvM95eieQ+Gc5XbIfwym1ehrNnS1RsMXKTj1yHDoHXnfyot7CHmuJnsmaliNLz
 s2AaNxTALkkIZWvdN8vqMONnc9v6GmV0FgMj6jBYu77BjAzlM9A80EfWnWvLq4K/
 +cunmQctxGuNAhg8dGzZj0S/UlQHAlbjhDJ0dVGSrWTUaSDg/5CxcUWwS+VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1652955305; x=1653041705; bh=l/M2luA5ZNvi/tJZ5BFIDGLiFRPq
 /3auElkUCIUUME4=; b=FflmYSMMbJRMCZlOvri5BiEWKHM5hcmMv1NESKn/VUKE
 Me2d+J3KjnqG10x4eHF+9uPM+SFdB22NKgv+8Twete8pukqf0qHMTy/chZ//8fB9
 yBXZmOGvuJ5ndZCFRL8EGD5qhnCBgua+9KMVu5vpL2GDApQspA95zcSeS1UuFS33
 WTohSqtIvfOIs5fBeKzaqZmvRKQhKj4dRyfQdm4Okv7rw39Z6OynC4QmhtKo7k2M
 6xCdzcnW/+GzuUHL82UGeonhZ6HpBEqqtWUpP8uktwGyegvdxTXUKOyLdOHsZHIc
 wq4ZL7qpb15lgTPQDu1e1RRPe82ZcdnSkPBvnCnp9Q==
X-ME-Sender: <xms:qRiGYnX02fIgDvKydj60pOvvGaDr0IT_27CmsIHR7nTLzW5akOVvrQ>
 <xme:qRiGYvlPQFJWQA7CTcnsIWnpcMh4xYwj-eBZ18BAG1ZL-HwqcZdUaHGGqtQDz5xCV
 pbQ6QQL2jHqAcLR07s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedriedugddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
 dtreertdenucfhrhhomhepfdforghrtghoshcuufgtrhhivhgvnhdfuceomhgrrhgtohhs
 sehstghrihhvvghnrdhorhhgqeenucggtffrrghtthgvrhhnpeeiuedttddvleelvdfhhe
 evjeefkeevteefkefgtefgudegieevledtheefjefhveenucffohhmrghinhepphhrohig
 mhhogidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmrghrtghoshesshgtrhhivhgvnhdrohhrgh
X-ME-Proxy: <xmx:qRiGYjYbKGyoFChAgSiq5ofsuLiu-kceyaviDgOSmH-BByIi08Gfjg>
 <xmx:qRiGYiWGMUSfWCYv6UEjhZeCOmdsIYl7lx_iKu-Uc0SfMTtRU7qshA>
 <xmx:qRiGYhkg-4Mi_tTl_npS3V1UUBN2JGCFoCydeOY9kNiuLrSFmQho0g>
 <xmx:qRiGYtyYJjlPPol8Dw94PYUaMH10hRlxLQg0_h6ZuDrEEX7fy4fbyA>
Feedback-ID: ia0c1472a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5696E2A20069; Thu, 19 May 2022 06:15:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <4486f6fd-0fa8-4cee-9cbe-35f017ea6ceb@www.fastmail.com>
In-Reply-To: <YoKQ4YHKEZxd8C2N@infradead.org>
References: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
 <YoFYIJ3/yEK1RGTK@kbusch-mbp> <YoKQ4YHKEZxd8C2N@infradead.org>
Date: Thu, 19 May 2022 11:14:41 +0100
From: "Marcos Scriven" <marcos@scriven.org>
To: linux-nvme@lists.infradead.org
Subject: Re: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_031511_499487_C7681F39 
X-CRM114-Status: GOOD (  27.14  )
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

Thank you for your help Keith and Cristoph. I've been doing some more investigations.

On Mon, 16 May 2022, at 18:58, Christoph Hellwig wrote:
> On Sun, May 15, 2022 at 01:44:32PM -0600, Keith Busch wrote:
> > Some of the behavior you're describing has been isolated to specific
> > drive+platform combinations in the past, but let's hear your results from the
> > follow up experiements before considering if we need to introduce a dmi
> > type quirk.
> 
> Also, are we even sure this is related to power states?
> 

That's a good question - somehow I assumed this was the case after every post I saw mentioning this error was about changing latency.

> >  
> > > Anyway, with all that background, I'm happy to try NVME_QUIRK_NO_DEEPEST_PS for 15b7:5011 locally, and submit here if it works.
> > 
> > I think that's worth trying. Alternatively, you could just mess with the
> > module's param 'nvme_core.default_ps_max_latency_us' value and see if only the
> > deepest states or if any low power state is problematic.
> 
> Maybe even just nvme_core.default_ps_max_latency_us=0 to verify it
> really is power state related as a start.
> 

I have now tried both of these options (separately and together), and the issue still occurs. I confirmed settings in command line:

cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-5.13.19-6-pve root=/dev/mapper/pve-root ro quiet video=efifb:off acpi_enforce_resources=lax nvme_core.default_ps_max_latency_us=0 pcie_aspm=off

Does this mean it's definitively not a power state issue?

The slightly positive news is I now have a fairly dependable way of replicating the issue. I've described it over in the Proxmox forums (https://forum.proxmox.com/threads/what-processes-resources-are-used-while-doing-a-vm-backup-in-stop-mode.109779/) but in short, just backing up a container (from the affected drive, to an unaffected one) has about a 30% chance of causing the drive to go offline. I suppose the fact this happens is another indicator it's not to do with lowering power states (autonomous or otherwise) if it's happening right when the disk is being read.

I tried running strace on the process to see if I could see anything obvious about what the process is doing while it fails, vs what happens when it completes without error. I can't see anything obvious.

Another thing I tried was a raw dd read from the affected disk to dev/null, to see if it was something about intensive reading that causes this, and it did not happen. During that the controller temp maxes out at 63C. nvme smart-log doesn't show any critical warnings.

I'm wondering if there's anything that would help me identify if it's a hardware issue (PSU, SSD, motherboard) in terms of low leve debugging or BIOS settings.

As an complete aside on mailgroup protocol, my understanding is text only, and 'inline' style. Responses come both from the group and directly from the people replying - should I "reply all" or just the group? For now, I've gone for the latter.

