Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D03DC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:49:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B248661168
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B248661168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GakNvXwfzlns6+5RaOU5QQM+rKmhCSwUf3MZ3xQ/D5I=; b=Cvwfb6DR6YYBtap4E8uaX0oZU
	ZEho86wXoeTgX1rQqydLPVL7ADzTNEjHo0/zKP/PvsT40KnXyrys/A6CoY4uVtPv3M7MEiPI/dmfs
	vqLn71wtGOENEazZBZNvL81U7DpZOwUO+sBY2TV2jo3HUWIXYc3g5YA7SeQ1uGMdBqld4etVTYlKg
	BVsMNA9MUrpM4O9r7TIX/Gg+geMKQcavtaom1B1NbFjfv9026X2VKwRDmfcjx6bKpCi4Zn5fAn85w
	bZaYhZMr2S6w16Dl4L2iOuXUEOBlFX/cXALIexV5IhkE+2SMdBbBtml4PUDNbaUUg1n2MLiB9aB8y
	sWUDSKUgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUk1U-00AD7R-2a; Fri, 09 Apr 2021 05:49:40 +0000
Received: from new4-smtp.messagingengine.com ([66.111.4.230])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUk0A-00AClI-La
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:48:24 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 82DA95807D2;
 Fri,  9 Apr 2021 01:48:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 09 Apr 2021 01:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=JCvWMnMwbOkR6m43AUigRuddtht
 XjKbt9IibVxjnKvY=; b=TiI0GSIStmWZ/30Lla1vDjawsIUMcMiysEdzQYh/iGA
 kvsYY5gNYuvWQTVJm3gc0MaVUD+Wo8fBYNmqvM85EuT8qk3bQKNfdnsPUY018PX6
 YaWSv/b8azQ0XtHpqd+YfQ5HTAYFefC4nHfmAfCkAGG8+GHzWjoPll9wHVSAHauI
 9HwfujpxEIi7194v1vqhhXF5VhLcHqygZTxwE/3DLoXhC1qs21HIo/MJlMvtOASx
 SE51VRoZTPrvKyHm8LJ6BTe3atLB2kk+po1D6wpxldmrerQAJH1tNXdkUQpkUftm
 bnPZ7LeSBZDvIM2AmawsYaJTyKIKHaL8Dl1ORTlXCUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JCvWMn
 MwbOkR6m43AUigRuddthtXjKbt9IibVxjnKvY=; b=fjJhCKJDCKkkyBv6jDZNZz
 8MRcVe88L2U8BCW3Y53QZu9S1WHrauGPGzKt8xfJk9/+EEip/4QYP1hTgxii06sD
 K+Z9UJulYb3ovOSnyHj1XOcm1HWCzFA8vMu0YEkL20GbT0aZ4Ft6aN4M3hr9WMN6
 81bAtfy3sFPSpoQRUt9MwgRTx/qceLWk5DVgVM9Sz9rFbSdh0Y2OR73b3R14KXUY
 IQ0U/CqR0JUIQheovg3yfhjcoW0VV2f88XGsiKxxjp+c7wE4sYYgiwPDRAzWheiR
 yeBG8AhoyVzO3w8MGHdHjtc5oJ60TTIB/50NUklv9MVUnqE0vx/V6IdcCwuBhyEg
 ==
X-ME-Sender: <xms:nOpvYEqJffK-XM8B-xQ-fwHMX9IemuFyuWIquM8CIG9cldC8omvmWw>
 <xme:nOpvYKoM-gy_D7d7PvaEnq4u_vRUVwvbtEjG3Wr136CXB2sbn9C890VJsuvDvtJ-w
 mQ-2GM1xUTJ91-iHqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudektddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:nepvYJN48D2T6B5qTKFCf9KRXaUQBuj33SVLtLOGFFlpfrsDG0VQ_Q>
 <xmx:nepvYL7UHlK7fu65wk0cHvsE_9fXMajmaayXf9C_aVuxWZJkjp-eDQ>
 <xmx:nepvYD4Nr8mNaS-0BuvujzralnYdu9nBLqqmnJzTCNhhRY2HcY6Low>
 <xmx:nupvYAxrC2S09dvtaxIYE7ZQkg7Nk2Ta2OOQWbFEdWX7j1GQmrmy6w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 62C7F108005C;
 Fri,  9 Apr 2021 01:48:11 -0400 (EDT)
Date: Fri, 9 Apr 2021 07:48:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Padmakar Kalghatgi <p.kalghatgi@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "tasleson@redhat.com" <tasleson@redhat.com>,
 "tbzatek@redhat.com" <tbzatek@redhat.com>,
 "prakash.v@samsung.com" <prakash.v@samsung.com>,
 "d.palani@samsung.com" <d.palani@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "mohit.kap@samsung.com" <mohit.kap@samsung.com>,
 "krish.reddy@samsung.com" <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Message-ID: <YG/qmMKsFIvGuQoX@apples.localdomain>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210408074826.GA12847@test-zns>
 <BYAPR04MB49656C8E6D8157608DCF73A686739@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49656C8E6D8157608DCF73A686739@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_064820_886003_92754375 
X-CRM114-Status: GOOD (  13.89  )
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
Content-Type: multipart/mixed; boundary="===============1620492829914855440=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============1620492829914855440==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gdgqpH9k63gVx3tY"
Content-Disposition: inline


--gdgqpH9k63gVx3tY
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  9 03:58, Chaitanya Kulkarni wrote:
>On 4/8/21 00:52, Padmakar Kalghatgi wrote:
>> On Wed, Apr 07, 2021 at 11:16:02PM +0000, Chaitanya Kulkarni wrote:
>>> On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>>>> Along with this, we planned to implement the sideband MI command handl=
ing in QEMU.
>>> why ?
>>>
>>>
>>>
>> Add MI command emulation and avoid HW dependency for development and
>> testing.
>>
>
>Absolutely not. With this logic we have to implement entire NVMe command
>set.Current QEMU implementation is lean, I'd like to keep that way and not
>bloat it just for the sake of testing unless there is a kernel component
>that is consuming MI interface and I don't think so we will have it
>anytime soon.
>

I don't see why this would bloat the nvme device. The out-of-band=20
mechanism would necessarily be implemented by a separate qdev device=20
that would "listen in" on relevant QEMU busses (PCI, nvme-bus). I expect=20
this to look something along the lines of ipmi_sim.

The QEMU nvme device is a PCI device, I don't see that changing. It can=20
implement the in-band tunneling mechanism through the NVMe-MI=20
Send/Receive commands, but the real work would be handed off to the=20
nvme-mi qdev device.

At least I think that's how I would do it.

--gdgqpH9k63gVx3tY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmBv6pQACgkQTeGvMW1P
Del3uQf+PFd9dR1vaJDPJssECKG3nDSZh3EOVLC8FItXNGJsZFBykRJiW/c9wTad
0seTB90clPgce9VafRsB8d2PeiEswl5eLRTPc2T1pCS7aiG/raqlTrSEoWE0LGDY
bkQY1KNyWwI7lZLbvy3pM/KiGn7jLU7cB3Vd/irZi4S2ImaZCsibn4fM1aIG3cgF
cU1nqDq4v7s6cY+PZf8LR4SIozNum3OUOsEWH2EZ1VEFqkL3jgGahdGsCpt3qW71
mJhI9X0c1WB4s3/jRGl1h8CrD7F8B4r62IrGr9/QjMMrGcFDoC2kYIkYozXiKORS
QnWFdMeAMPlmEIvtRS9KSCJgHEAWVA==
=O8Uy
-----END PGP SIGNATURE-----

--gdgqpH9k63gVx3tY--


--===============1620492829914855440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1620492829914855440==--

