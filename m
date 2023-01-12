Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68994C54EBE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YIYUHf4h/jjkAP78zYa0AhqxUa06r/hPvjMS+MwCYqY=; b=3+npXpUGfqjKLnprK7LXeA9jqB
	QAHP4nleDDEo/jPfo3EGtoOyG6WkBynmIgvE4LYpVhZPyJeqUPiU9No5CxAihS2ihTFTKwtFTymXq
	ThHj22ZSRKjetHvczLgkks4OZpsL5z/u+J2KHRDDpgQXlOsxC4g4JiMqPHl+cFdGwG2kaP0QT/oX+
	PXWAUC7ra9IhJmXpuvQByGMnMht+tOzBei+UxQUTep/r2D5I6WacjsmAX5sVx8nna1m+vWavBPRwG
	fVjEPkNkqhgEpZN2hmg/LR8tl3I9kHi8uO9NXonbJQW01WymBuEgI3Vc9WDVKLf4/fQIdXagowP2H
	UMRxrBQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1eV-00G4wh-CM; Thu, 12 Jan 2023 17:46:11 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1eN-00G4uN-GE
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 17:46:09 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 539E15C0065;
	Thu, 12 Jan 2023 12:45:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 12 Jan 2023 12:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1673545559; x=1673631959; bh=YI
	YUHf4h/jjkAP78zYa0AhqxUa06r/hPvjMS+MwCYqY=; b=CNLK6ejrNhHREjaeVt
	erte2GCMeMlz+RVuhotellaU3Usw6vZ+gbwvL9TxTWr0DOc3d495zhi57+RVIwHv
	/uIEZDkfglqQAq8uO1vrkj/YkktdZl7qLe0g/z1A6mWn+oNXLVFHugaByk9OvhS6
	blQHW5guxL0MitDvS9l4vggsZM80gxGHifC6+4WI1Q67nxkaDIIAQTtGOTavH2a5
	vwuweQR6pxmPobsJ0JptkwCswJghNXB3n3VLiQE2mvxphUN6m7Ccv8ToplzE/KEl
	9BvZ+HxvvasNmev4jJ1SC8x4dG5bPlLnYttIwyjqx2jOC6FkrFeIMweqIUwzakVN
	KxVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1673545559; x=1673631959; bh=YIYUHf4h/jjkAP78zYa0AhqxUa06
	r/hPvjMS+MwCYqY=; b=Wi+ONRpheuRQbX0NBqPFYtKJ7X6Nb5tNTy/QNhWKsVlb
	TnCwmVSF5yQL1+1eGVOnB9PoA+RWWJ4F55HMaeu32jiZ5GBIv1TihBphTBPC4EwJ
	FEJDBvUWHz044Sg3y65BsVMdlO2+GP6jlLQcMm26tjRImDZSxXkxm0xtd23FMPBf
	hKbKhtbQI+EhBykE9uyo8TOi8BzwX7UCGBeqvXZByc/IYt6NuomP9cIjapO+Pnuv
	kHuxJjsomKOLa5eZ40vx2lQP4wbjzYC0zqD6H9WRYs13UK00crlzo9LF+5M8h7LX
	lgpgdR4l9hOIYmZiTD51h5yiNwnricSpwYHudWeOlQ==
X-ME-Sender: <xms:VkfAY37AiCTtfpNcKpsxQrjb5nuU8nuP6UrYOnCx1soTttDGcYkEVw>
    <xme:VkfAY85FSWvlgXroQd4KjoYsJYaGEz8GVP0Ns5lN0z1tn5HVhmTV7zkm9kIzhhmkm
    3l8aiUOJfKg7WMnGOE>
X-ME-Received: <xmr:VkfAY-ckMnhCUVxtsPY75nWXHdWaPL1Uw_Fuxb33I5rOWXcvpU8kbNI9cqud-vsgrBjXamSOTbUVnFP-U5E0pwDeicTOMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepkeeiffejgfeukeehvdegfeeuheehvdfgheelkedugffgjeevveeiheehleeh
    jedunecuffhomhgrihhnpegtthhrlhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VkfAY4KsWNZ4oZbVHy-Ygu1LHhAFtwv__inyXh9XzCs4uPIeblJBhA>
    <xmx:VkfAY7ID2u4jOJgmccr5nvSvJmPtAMW8wSmEzn_GcaroGfS84Vv9WQ>
    <xmx:VkfAYxwbJNc7wv_tifDgtgw-RXyjdfqsNtEFon0v39HsdBDaIoa7kg>
    <xmx:V0fAY4rf56NDLhLt3lcLTPJWCjm-rebfDrsCie9xDlx2ZZiAH9bmNw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 12:45:56 -0500 (EST)
Date: Thu, 12 Jan 2023 18:45:55 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8BHUzcbdQ/SFBY9@cormorant.local>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEiXUOj3Uq/gzfSM"
Content-Disposition: inline
In-Reply-To: <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_094604_078521_8521AC4D 
X-CRM114-Status: GOOD (  21.18  )
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


--yEiXUOj3Uq/gzfSM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 12 09:34, Keith Busch wrote:
> On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
> >=20
> > The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
> > am wondering if there is something going on with the kernel driver (but
> > I certainly do not rule out that hw/nvme is at fault here, since
> > pin-based interrupts has also been a source of several issues in the
> > past).
>=20
> Does it work if you change the pci_irq_assert() back to pci_irq_pulse()?
> While probably not the "correct" thing to do, it has better results in
> my testing.
>=20

A simple s/pci_irq_assert/pci_irq_pulse broke the device. However,

	diff --git i/hw/nvme/ctrl.c w/hw/nvme/ctrl.c
	index 03760ddeae8c..0fc46dcb9ec4 100644
	--- i/hw/nvme/ctrl.c
	+++ w/hw/nvme/ctrl.c
	@@ -477,6 +477,7 @@ static void nvme_irq_check(NvmeCtrl *n)
		 return;
	     }
	     if (~intms & n->irq_status) {
	+        pci_irq_deassert(&n->parent_obj);
		 pci_irq_assert(&n->parent_obj);
	     } else {
		 pci_irq_deassert(&n->parent_obj);


seems to do the trick (pulse is the other way around, assert, then
deassert).

Probably not the "correct" thing to do, but I'll take it since it seems
to fix it. On a simple boot loop I got the timeout about 1 out of 5. I'm
on ~20 runs now and have not encountered it.

I'll see if I can set up a mips rootfs and test that. Guenter, what MIPS
machine/board(s) are you testing?

--yEiXUOj3Uq/gzfSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPAR1IACgkQTeGvMW1P
DemIGwf/ZFJZmI/8XrBPelfu1rr9TEbFYfvu8n7LxgCvRoHsHSo/pxvHFEfgR2/r
NVEWa+2flmvUVb9LD/2WKQu7yePEGpgFIfQRUDzK0vozQIN9w87ovqe+hSOW4xa/
O6Mz6aEQ/iRdlqh4J3iEBz+hV5Pt/YO2NX0a3cfnOFaXGEzL0nLMkWU3E7j1MoZy
C8l//jvhzurybBGPsnDM2jdKUmvmv5XkrtgdkzV8/Bk2HdoOdslfu7hgD80uF/1m
IsSoeOhMt/Tc5uOULwK21W8VzdmSib10w8XudrGlI1kMNydxZQgEyKe9w3YL5LPs
+VnMW/L+YivaRiNLyoW/F7BA2CXKQA==
=X6qn
-----END PGP SIGNATURE-----

--yEiXUOj3Uq/gzfSM--

