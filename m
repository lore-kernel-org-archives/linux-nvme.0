Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4633C38142
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q6rz6TOszzqYBgi19e5Lr4aBvloXINprAi989KqAPHI=; b=3i7QOCql2Yxpq2jwWwYB1xoinU
	7hHiX8wvqz650xtcPN3pqchF+lz+6PIf6mCClcIb9wCUH3ubnpuAY6cAHowBorhlFyECW06HLlLz6
	bK9ngCSYYhFIHgO626gowP8HDp3EAPWeG4vhwNh8q0SdGeK/XIZl0kHshtTx/LiWwj04SN2dy5UZP
	HETfoJ0+w+JEmeGQlpcQ1AtfB5Ey1XnZrx8He1rkYeOgNf+Yn8Y2WXM0ZXN6CaIfVmQ87xT99ymlj
	kH7hMxJZtsagRQhX5kKl0mxMx8CK8d5evP00LxvEq3xb3qo8+2wl2IC1d+K7TC51hJYxLo8Pivkt5
	noBM7uyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPLi-003qiX-Ku; Thu, 19 Jan 2023 07:28:38 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPLf-003qho-Fr
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 07:28:37 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C0265C009F;
	Thu, 19 Jan 2023 02:28:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 02:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1674113314; x=1674199714; bh=q6
	rz6TOszzqYBgi19e5Lr4aBvloXINprAi989KqAPHI=; b=X0deQFi/sFkISkIwc0
	Z8XHVm0Pol2npvJkEkMd8TQoTTwQgVyOEiACiB3vEICUPi+tCCXiO964lh+bC3tg
	jIqzacJCwfUOZMGwiMQqJCRIFtc5DipBfYu+a1mi8hpdDpzS7DPhUWf4LmTH/Tw9
	fAr7FwIgs5OWgkz8j5OSp+PWqvrLfImNjt8pqUN8SWdiHUfDDCEQTR1btkzCzGqo
	irAUCrn0mRJGI8t4ad+lw0GSVOJPosqn8M00P94pO0pq7UGuwexbiTMvH0KjBdYe
	AbXGDG2lB23e0u6vSepyfxcmG3jXNmmphcKwupRsKQRMNWhc+oRKy45Yb1n1bvPe
	XuXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1674113314; x=1674199714; bh=q6rz6TOszzqYBgi19e5Lr4aBvloX
	INprAi989KqAPHI=; b=M9YeHXpFA+efSITLAFjcZX8xgGYhJH1Q7HMIWdxUI1vQ
	T7JEOpdhP+LZK4/XzlX0OU39KojTd6ns5woz8FQbjODuRDvIrAkTdQSwVoiWYaB+
	paK1QhRYGIu8VBf2NQFiU5ekP+vazRt4xz8xyLFwmcjZEvvmadzeCxvi5Y5dOsmB
	sj1L1dcxDdyqKP0ec0XWgxyfX71TI5O0AQo2oNuaQ/yADdU2onREd9atrvAHDHes
	ob8k11uPQpX0P62rqvs86ImPE0XdIU7g5L0LowzCo6RzdhZBhdmxAuGCuXy4olQj
	PrWTFhOKAUt8oEuXaHk+RES6Z8NZqeG/x2fcNTII4Q==
X-ME-Sender: <xms:IfHIY5bQw4YaMGGmRkE9spX0kSJn20yqAM10BlpD_rQx_PZ-Mg8GhQ>
    <xme:IfHIYwawBPVvWDtF9FMoWWWPz2yLgE4v1BFIhbz0nWnVWA6kKc3rI6TGqPettNsiY
    iqW33UBtQYZb11buR0>
X-ME-Received: <xmr:IfHIY7-uDPol7cBJsAJ1O8ZGBvfp8WCGIVo_zi1qfdWI9CNLFNaiXd2Q9cKBknQyt5kPEXe9qHKfzEftntLTr5LhijsRjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
    ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:IfHIY3ptXduY-MseKEfEPckRoebKuLJUu5MbyTPOgJ8mqwx4uyYm7g>
    <xmx:IfHIY0r93kvbGLBdgF5z2x-yvizWG5MnoQmJcAUaD2XJRkxn5660ng>
    <xmx:IfHIY9TwoNKK9-gKpGCHm7gIM_TUMOIJEwNJKb6CN5uOXIAkmJDCkA>
    <xmx:IvHIYxh2hxdTJWbDCvbpeVu_cupXIsIztNSgy0TCqNpaY0h_HCrmKg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 02:28:31 -0500 (EST)
Date: Thu, 19 Jan 2023 08:28:30 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8jxHuVYoTo6KcH4@cormorant.local>
References: <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp>
 <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
 <Y8iulgdgOdVCjuKE@kbusch-mbp>
 <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
 <Y8jBG/j8w2R43kYd@kbusch-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b9PjqAhA9tYv0Qnk"
Content-Disposition: inline
In-Reply-To: <Y8jBG/j8w2R43kYd@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_232835_909695_09A3654E 
X-CRM114-Status: GOOD (  20.41  )
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


--b9PjqAhA9tYv0Qnk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 18 21:03, Keith Busch wrote:
> On Thu, Jan 19, 2023 at 01:10:57PM +1000, Alistair Francis wrote:
> > On Thu, Jan 19, 2023 at 12:44 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > Further up, it says the "interrupt gateway" is responsible for
> > > forwarding new interrupt requests while the level remains asserted, b=
ut
> > > it doesn't look like anything is handling that, which essentially tur=
ns
> > > this into an edge interrupt. Am I missing something, or is this really
> > > not being handled?
> >=20
> > Yeah, that wouldn't be handled. In QEMU the PLIC relies on QEMUs
> > internal GPIO lines to trigger an interrupt. So with the current setup
> > we only support edge triggered interrupts.
>=20
> Thanks for confirming!
>=20
> Klaus,
> I think we can justify introducing a work-around in the emulated device
> now. My previous proposal with pci_irq_pulse() is no good since it does
> assert+deassert, but it needs to be the other way around, so please
> don't considert that one.
>=20
> Also, we ought to revisit the intms/intmc usage in the linux driver for
> threaded interrupts.

+CC: qemu-riscv

Keith,

Thanks for digging into this!

Yeah, you are probably right that we should only use the intms/intmc
changes in the use_threaded_interrupts case, not in general. While my
RFC patch does seem to "fix" this, it is just a workaround as your
analysis indicate.

--b9PjqAhA9tYv0Qnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPI8R0ACgkQTeGvMW1P
Den7Xwf/as8sQo8Blioh/lVMAozoftSiWaqZ4j1NZkaqDVAIy3Pv5tjDEVW62NTx
O8zYegRxq52Iag48NGpvbeDY1nLJ050CyUKwrdb4VgqHOlmlSiHzqDIPV5I9AYck
EM/2UNp9hGczLZtP+Zb4D+32ih+IUBcLpLUE1shr3zKB/y5rb/Y9fKksGBtCifBX
+W6tiCm1v7IASYWtWNlZeJzfTLYcGIwWzqRtnq54I1Kfv6or71koCwNmQrUwt93L
fHsPdNsbJIjIPCSGUvH5nYU7O9TYzbG1Vr93NxUC1X2FbQIsnAtchXuh31hRNYlH
iqIAVkPtkHRNM+vce8uSGliwcLwDiw==
=O9qQ
-----END PGP SIGNATURE-----

--b9PjqAhA9tYv0Qnk--

