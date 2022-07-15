Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E8C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 07:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTM3Px1TfF0GywBqvK63xALU6EnWwOZIQ3cKvvPZ8nU=; b=MAk/Sff61YlCUTM+TWMyorpKQl
	IqR920TAZCxKt5exN46eUp3wl6TPXXuYptHH073c+tb40Mk9ObagmKWH9QHtYz1RWqoMa0w6hpSXq
	f1PLS+Yt8D68fq3D1FfqTyoLObTwGl2byrjOPWHRclGzd0CvaduJN98e/fqXAYgx19+MoPoVT1cJ2
	ddmoaYGKiQzSc1MhQbiTrYnuwhZHDxGJv13Lkcq6spPQ3oeVZ0zFsnd9Td+aBMwNySuFF9tngfWRw
	FvyQC0JofkG4fyI+zdjntEWbU+xrKdnzQIsl9GEuT3P2CvTckjubS3dB93yIOwMeHC6/xm1VMbuOV
	V20OXfGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCFQM-004o64-M2; Fri, 15 Jul 2022 07:07:42 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCFQH-004o4O-Qp
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 07:07:41 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4D7985C0159;
	Fri, 15 Jul 2022 03:07:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Jul 2022 03:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1657868853; x=1657955253; bh=VT
	M3Px1TfF0GywBqvK63xALU6EnWwOZIQ3cKvvPZ8nU=; b=fTGPIr6Mir0Ukq9o4n
	Xryc64SGzGYpeJE2CPtuJ7a3l6Krer3TdXF7xECrItlBahPxIK0uGioAHnV8wkAa
	gkbaHsJzDoD5I4hatMIrORPI5V/7BOcd8NzNCU5+W9Ntmj7pIgEmjNbjO7hvjHT3
	5tCbl+BBAEwWd/51kMocu6wjJ45aXnrE0ZCheYSneG9a0CHtZTF6+PDDx7yMa9Ve
	DIfbhftX4VKdCx7ZojpryzWEETBgix6fZgOTafiBVEYDqx4XnQfOjTQRjcBIvalM
	+3+AXa+2EANwwiORC43R8tyU4JJ/Sv78qLPO7xVPQyNJzXndZP3JuXo1pZb+cMjd
	3u4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1657868853; x=1657955253; bh=VTM3Px1TfF0GywBqvK63xALU6EnW
	wOZIQ3cKvvPZ8nU=; b=UhXMvSvEFrFAXYNBi1Sc5eMMLZauo0Fzrh9T7bE+Tl77
	ii5dWN+RmvpSl7/xhqalseUp65FqwJ349+rcUIY2YH2L2PWyLZK2uycXuDeT4lHb
	mxBPK6LPqT9dh+WPstBxM/An3PiNmFEpGSGtflfdcdsVBzU8D/XYBzKgDpjDEAdH
	M86YUzw8dcC3Eynbt9o4/qjFh+Om6UN91vnun267ZLCMqdkrQJHmuCJVc1saLBYC
	Weitf4fsWwCaTJt/AuFchqHa55je5llC9vVC3b4TFixkAAb6spHED0ctB7D2DfjK
	V4ZdURmAy2FHkcnyAmc7Qtf2YVQTyhhbHb+VXfd6ZQ==
X-ME-Sender: <xms:NBLRYtuZVRc8zTSop2jeakVsD40hrPN790JP8WksrNl-v5xQdBSO2Q>
    <xme:NBLRYmdgh99wYfv4yBKG31oeqdNJdQGhnish0iyb9ahUju2iWt9_Zg3DaSOoswomb
    uPtRUXMxxdUOCiF0k4>
X-ME-Received: <xmr:NBLRYgzulPV9Cd5AWD5dzxyrQyjQvMB-DIwFuJzMVLNgUgqp8kE7gkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudektddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
    ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:NBLRYkOPO35PkonxUF9tu2E6efbZqm0OM0n4C4k5T7KCJ8O3-UY0Zw>
    <xmx:NBLRYt_1GaqVFzeum-y7k0Zp-ds3VxX4XnBkj3obz3R-TLx-spo6JA>
    <xmx:NBLRYkWmbkzaAEpuGTw-F2dSmlhxyP75oLmt-KCSjfQdWmiYrNsr5g>
    <xmx:NRLRYpa_jY3B8GIspJUFF81KokJbd7nrQNGTo2kwHfM1wmfaxk_mew>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 03:07:31 -0400 (EDT)
Date: Fri, 15 Jul 2022 09:07:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: shadow doorbell on admin queue
Message-ID: <YtESMhylPsbF08IB@apples>
References: <Ys/Y8N0y1lpMwyZH@apples>
 <YtAjEzTmdrmaY9hw@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8cul/sBuDiDkv4i"
Content-Disposition: inline
In-Reply-To: <YtAjEzTmdrmaY9hw@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_000739_222454_AF8BBBC3 
X-CRM114-Status: GOOD (  25.45  )
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


--H8cul/sBuDiDkv4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14 08:07, Keith Busch wrote:
> On Thu, Jul 14, 2022 at 10:50:56AM +0200, Klaus Jensen wrote:
> > Hi,
> >=20
> > Jinhao, our QEMU GSoC intern is working on nvme performance improvements
> > and while implementing shadow doorbells an interesting issue came up.
> >=20
> > The spec states that when enabling shadow doorbells, it is for all
> > queues (including the admin queue). However, the kernel will currently
> > not update the shadow doorbell for the admin queue, which causes trouble
> > if the device expects it to.
> >=20
> > The kernel is not the only driver doing this - SPDK doesn't update it
> > either[1]. At least one virtual target implementing shadow doorbells
> > (SPDK's vfio-user target) jumped on the band-wagon and simply expects
> > the driver to not update it. In QEMU, Keith came up with a hack to
> > update the shadow doorbell from the device side, allowing both compliant
> > and non-compliant drivers to work. Just fixing it on the driver side is
> > a problem, because it will break targets that expects the non-compliant
> > behavior (i.e. always expecting mmio on the admin queue).
> >=20
> > Question is if the kernel even wants to do anything about this at all? I
> > kinda already know the answer here - "spec is screwed up", but I wanted
> > to raise the issue here for feedback prior to potentially starting a
> > process with the NVMe TWG to sort out there.
>=20
> The driver has been this way forever, so either (a) no one was actually u=
sing
> this feature, or (b) every target implementing shadow doorbells has the s=
ame
> non-spec implementation. Either way, we can't very well change it now, an=
d it
> looks like shadows can't reliably be used on a live queue anyway. I think=
 you'd
> have to refine this feature with the TWG.

I agree - initializing the shadow values on the admin queue is a little
wonky. I'll bring this up with my reps in the TWG.

Thanks!

--H8cul/sBuDiDkv4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmLREi0ACgkQTeGvMW1P
DemJCgf+IpMwln3FxifNPB0LSixftXcQwKu4CTPffbIMrnwBWqZhC4ehNfUX1Zaf
tqpHcr3/ec2nmdt/QTe9xFYtUT/5K8SxjbVwoR7qGGqh0GXb5spA0tWX7mo1/Ore
4ThDCq+MmnUAe4BmVKEWSJkUO1Uw1B783WXq68P5/WGONNMjAo73ZBQNEX3MgPTs
gUESIWaSVi8yYjtfMd1gWTZQ8fCWICmq//WDr1InCTdAosCPU30yrF3R1aVUieQ6
T6HoasN1m0AEd9eIplUIbpKtw9lKk4xjY41kbhlpioHXyoIaFDhOhMrAHNDMg1ZI
yf2vKNpcgYRI4tM4Sx2V+Jm+m/oXcQ==
=Lijo
-----END PGP SIGNATURE-----

--H8cul/sBuDiDkv4i--

