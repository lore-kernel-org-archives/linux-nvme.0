Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19971C64E90
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 00:07:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B11206B2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 00:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B11206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b/FJ9UsEGza9IThcj1UEFOyHT/JPfjKgei6tp/7wgJg=; b=ppwQpWJc54+DyCA6u5qp6mhk3
	cmQYMR9jBB01aj3g9/7Fpggnk8he/LNaPq1f4CgX/JYNs8F+BaH2ulBqydLbsFn4t/3v97StL7acq
	0AzZghd1ppDx/jZ27rPPAWplEbCpjpZdnqQyxf6g38C/ziLP4QEODnGrCZJONsIuVRiQ1DeL9gNMK
	XileYuPX/Bx/Q3hz134ingUXPGEwoeqinYViY7JEJW3zd0eRcLPa9sNaj0iRfpXgik3iS+OGkv/yN
	tSz1MFKGgJHiYsad68NM20UBrFQgoZ6LHTQ3kUTktf4H+n4euxiJ78u/gKj3+Mdr6FtLB0K/Y/CZ2
	MvXN1Mx1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkFfc-0006Jf-Qi; Wed, 02 Dec 2020 00:06:56 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkFfZ-0006J6-Cd
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 00:06:54 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 88B111799;
 Tue,  1 Dec 2020 19:06:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 01 Dec 2020 19:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=E3EbcJ
 HFHLEW7HSWgf1YTf/R/Eh3htYBTGHlDnSfmRw=; b=q8wQ3AI30wYwlNcaRfGCOA
 iBud1K1gEOnHvp/BGQ1Bu50La48mGg70aR+oLvARFRWmmnxoYKDyjFXk5N4OIPZk
 jF3rL319XabmrUtkphjPjVWWMtucvTJGScMbrOPgM+ZkbVtUB5fsDdbY5nJ36GTG
 KJEvYCyeJz4fuVrDs6rYy3ApMshRE9st9HZZhWHPRDopCW/WdbaiE/Y9W6GXxeRu
 c7o60X/rB4BC8/9VukK3Gf58Qmr3J+MIQG4h22yGsW2tI500GkwdLdJE1jMUiq0r
 rJ0geMdQJ5Z9h6+7C8UWDmhJHKxaoI4t7xHYc+NPwTqXPa7ggkfSp0NiLcDpVYWg
 ==
X-ME-Sender: <xms:l9rGX3N80vEB2JZubfSU0MUN-HLtkyWRc5ZwCZLY27yQypIImuwFaQ>
 <xme:l9rGXz-6lAILf0ThhjNPYau_LX4kCH4sqc3sKwSyYgqGBMd-3WB3jGv1OlqtTrY-L
 ypdb0KiwQjMIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeifedgudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
 iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
 durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
 drtghomh
X-ME-Proxy: <xmx:l9rGX_pnMXUdOsHCLuScXluqpCtuw1H-l2j76b_jAcvJOLHh6zJ8OA>
 <xmx:l9rGX97WEJF5FDu6WXIopx4CLCh39Y2fbG9r7Snv_pIZS633YeTJsg>
 <xmx:l9rGX3PdiT_Vbw4Pg20YGES6996GuUHqmTofNuJTCJ4IGRin24M72w>
 <xmx:mNrGX0vVGZKptGuht2yKaaTnxh8iyivzTqw_BV2ohlWVPzqI3jKz-Q>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id 643CC1080064;
 Tue,  1 Dec 2020 19:06:46 -0500 (EST)
Date: Wed, 2 Dec 2020 01:06:42 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201202000642.GJ201140@mail-itl>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_190653_560072_D43A47A5 
X-CRM114-Status: GOOD (  21.76  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="===============0850662574953189118=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============0850662574953189118==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ivwvlL43CqGAdkOw"
Content-Disposition: inline


--ivwvlL43CqGAdkOw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9

On Tue, Dec 01, 2020 at 01:40:10AM +0900, Keith Busch wrote:
> On Sun, Nov 29, 2020 at 04:56:39AM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > I can reliably hit kernel panic in nvme_map_data() which looks like the
> > one below. It happens on Linux 5.9.9, while 5.4.75 works fine. I haven't
> > tried other version on this hardware. Linux is running as Xen
> > PV dom0, on top of nvme there is LUKS and then LVM with thin
> > provisioning. The crash happens reliably when starting a Xen domU (which
> > uses one of thin provisioned LVM volumes as its disk). But booting dom0
> > works fine (even though it is using the same disk setup for its root
> > filesystem).
> >=20
> > I did a bit of debugging and found it's about this part:
> >=20
> > drivers/nvme/host/pci.c:
> >  800 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct req=
uest *req,
> >  801         struct nvme_command *cmnd)
> >  802 {
> >  803     struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> >  804     blk_status_t ret =3D BLK_STS_RESOURCE;
> >  805     int nr_mapped;
> >  806=20
> >  807     if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
> >  808         struct bio_vec bv =3D req_bvec(req);
> >  809=20
> >  810         if (!is_pci_p2pdma_page(bv.bv_page)) {
> >=20
> > Here, bv.bv_page->pgmap is LIST_POISON1, while page_zonenum(bv.bv_page)
> > says ZONE_DEVICE. So, is_pci_p2pdma_page() crashes on accessing
> > bv.bv_page->pgmap->type.
>=20
> Something sounds off. I thought all ZONE_DEVICE pages require a pgmap
> because that's what holds a references to the device's live-ness. What
> are you allocating this memory from that makes ZONE_DEVICE true without
> a pgmap?

Well, I allocate anything myself. I just try to start the system with
unmodified Linux 5.9.9 and NVME drive...
I didn't managed to find where this page is allocated, nor where it gets
broken. I _suspect_ it gets allocated as ZONE_DEVICE page and then gets
released as ZONE_NORMAL which sets another part of the union to
LIST_POISON1. But I have absolutely no data to confirm/deny this theory.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--ivwvlL43CqGAdkOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl/G2pIACgkQ24/THMrX
1yyx4wf/Zi8Z07v/CvMezOpouMaWwo5NBdv39KateLARp8au9B7uxEw3qmdt6ntJ
k1QbFSTlRMkzcUH8I5iPVKRwsN5B1jQgvqTqRsBIXsSEBKdza6gsQ8GA5whupK/g
h0RfJDKekwB7E4vy56N9Bb7srrMYIZCWBxz9YiqkDz2Rj7Qr8obD+qScvqMK1Ttb
tOh8QioFVulN3ZkvTTJRTnuErK4ym7dEnwMcvl0WhPOJ1YR23IxnLCYKYuYtQxuY
iAEErImIy6cMFJIJA7RjEu0E5TcjV8F4IZuyfZBMimbefvH73dILgCfuclOlPid6
GGSgO1fqWB8mVG9ysuhkFlnHW4jyWQ==
=W3B5
-----END PGP SIGNATURE-----

--ivwvlL43CqGAdkOw--


--===============0850662574953189118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0850662574953189118==--

