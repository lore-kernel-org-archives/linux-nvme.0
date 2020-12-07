Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8BC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:00:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EA123403
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EA123403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vetehhyL2zdWLwztL+D9QgLexGlckS8iWmHwkxgH/2A=; b=YQJekeLfGVfDyLVBceQqoi5wY
	9w9MeqpbaESfCopGpQ9jiugIC9OTUPgT0+z4mVe7TZlRnapixCeWXLbdR5pJ9pmDIh+qSVp70Q8YZ
	Zi+iozvEhZjPMw7vRDqwn93PZhuCYovJhxlPZ5BjGh8dU6PiJgzHCOMTyoG07o+GsP9qjUmQKy0C1
	xBLUGaCdJu2VSjYHspn1Q1zvNRTI8AYUXmV7L/543V6WQhu+epgMaoJ9ONgOc25TOjaIz2LQZIdKh
	mxv7mtWmumNknIwzF5Z0gweheMuau+deCQDwERBymiYJtyoX0Us9b8xUlBfBFU5GiF5qbe71zbhpI
	m2sjEP78g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmG7s-0004rl-RX; Mon, 07 Dec 2020 13:00:24 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmG7m-0004mV-EU
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 13:00:19 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 0FFF8E91;
 Mon,  7 Dec 2020 08:00:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 07 Dec 2020 08:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PR9uLY
 7bMTXb3ccEUWjKah2caVoXSIMVfxwaCLvgNBE=; b=Dp3qhOp8E8VI1eDEaGBn2P
 0bmQe+ei+wquG+5rF25NZ2wLqEeTxBQUC/O5SpPyPycEb86TdfJPGufeqIu/zFzp
 tSi934lnHI/jfZg2jVgVt/LFdwSXEPLwbrVVULh2COQlnB8bIbJ6z8x8bpJ53m/X
 w4wwIDcAIILYqC+sWG0dJDtOv72NHnLnPHO3M8XEkEqw59bGe6g+qsiu5GIbSZnQ
 yxGr1h5QkmXcuelqEjZPVkTwgAwQ/JzwgWWCN1dHzaGN4ul9Y6UayzyPqrAJIOsA
 BtHk2BUWfttB8lq/oFONiBU/IHm0KnUjhggeoYHjy51/pDor+v8gJnvH0WXR9i9g
 ==
X-ME-Sender: <xms:WifOXypM9_2YDi1EacapM8qALGbTEEgo-ZXGAX_-pLjU5ZLPyBeHcQ>
 <xme:WifOX9nn_YZKCC3BkHiCH7YEPlG_1yCe7YKl6-LhrVjyPu-LZcIcO86UpyuzMeF6a
 RmocR4N3VnDKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedggeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
 iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
 durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
 drtghomh
X-ME-Proxy: <xmx:WifOXy3LXfdYwi_ZVz7D9Gt7DJF2RaCYQHtQdFa7HrBnxbQHra8eng>
 <xmx:WifOX6R-NBPC_jIS9eEfXz0BZASSVT6H03dNWw5wkNxNioat3liiLQ>
 <xmx:WifOX7xBCS_56QHqiAgk3BEp-2gGEuYdltM3tCwzu7J-p5uHDt0YYA>
 <xmx:WyfOX-8NTQfrDfHgAaHM44yN-_X7_bB9PMdIK-jlBwyWqIHrShR9Gw>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id 45DE01080057;
 Mon,  7 Dec 2020 08:00:09 -0500 (EST)
Date: Mon, 7 Dec 2020 14:00:04 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201207130004.GG1244@mail-itl>
References: <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl>
 <20201204110847.GU201140@mail-itl> <20201204120803.GA20727@lst.de>
 <20201204122054.GV201140@mail-itl>
 <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
 <CAKf6xpvdD-XJoRO91B+Lwc=0Sb6Luw2X8Y9sH_MQsAWhZmj+hw@mail.gmail.com>
 <293433c5-d23b-63e7-d607-9d24f06c46b4@suse.com>
 <20201207114805.GF1244@mail-itl>
 <9bf64b27-51e8-a734-e15e-8da6d2eda736@suse.com>
MIME-Version: 1.0
In-Reply-To: <9bf64b27-51e8-a734-e15e-8da6d2eda736@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_080018_629254_287CEB80 
X-CRM114-Status: GOOD (  23.38  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Jason Andryuk <jandryuk@gmail.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Christoph Hellwig <hch@lst.de>,
 Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Content-Type: multipart/mixed; boundary="===============8154114891484029867=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============8154114891484029867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Content-Disposition: inline


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9

On Mon, Dec 07, 2020 at 01:00:14PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> On 07.12.20 12:48, Marek Marczykowski-G=C3=B3recki wrote:
> > On Mon, Dec 07, 2020 at 11:55:01AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> > > Marek,
> > >=20
> > > On 06.12.20 17:47, Jason Andryuk wrote:
> > > > On Sat, Dec 5, 2020 at 3:29 AM Roger Pau Monn=C3=A9 <roger.pau@citr=
ix.com> wrote:
> > > > >=20
> > > > > On Fri, Dec 04, 2020 at 01:20:54PM +0100, Marek Marczykowski-G=C3=
=B3recki wrote:
> > > > > > On Fri, Dec 04, 2020 at 01:08:03PM +0100, Christoph Hellwig wro=
te:
> > > > > > > On Fri, Dec 04, 2020 at 12:08:47PM +0100, Marek Marczykowski-=
G=C3=B3recki wrote:
> > > > > > > > culprit:
> > > > > > > >=20
> > > > > > > > commit 9e2369c06c8a181478039258a4598c1ddd2cadfa
> > > > > > > > Author: Roger Pau Monne <roger.pau@citrix.com>
> > > > > > > > Date:   Tue Sep 1 10:33:26 2020 +0200
> > > > > > > >=20
> > > > > > > >       xen: add helpers to allocate unpopulated memory
> > > > > > > >=20
> > > > > > > > I'm adding relevant people and xen-devel to the thread.
> > > > > > > > For completeness, here is the original crash message:
> > > > > > >=20
> > > > > > > That commit definitively adds a new ZONE_DEVICE user, so it d=
oes look
> > > > > > > related.  But you are not running on Xen, are you?
> > > > > >=20
> > > > > > I am. It is Xen dom0.
> > > > >=20
> > > > > I'm afraid I'm on leave and won't be able to look into this until=
 the
> > > > > beginning of January. I would guess it's some kind of bad
> > > > > interaction between blkback and NVMe drivers both using ZONE_DEVI=
CE?
> > > > >=20
> > > > > Maybe the best is to revert this change and I will look into it w=
hen
> > > > > I get back, unless someone is willing to debug this further.
> > > >=20
> > > > Looking at commit 9e2369c06c8a and xen-blkback put_free_pages() , t=
hey
> > > > both use page->lru which is part of the anonymous union shared with
> > > > *pgmap.  That matches Marek's suspicion that the ZONE_DEVICE memory=
 is
> > > > being used as ZONE_NORMAL.
> > > >=20
> > > > memmap_init_zone_device() says:
> > > > * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> > > > * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
> > > > * ever freed or placed on a driver-private list.
> > >=20
> > > Second try, now even tested to work on a test system (without NVMe).
> >=20
> > It doesn't work for me:
> >=20
> > [  526.023340] xen-blkback: backend/vbd/1/51712: using 2 queues, protoc=
ol 1 (x86_64-abi) persistent grants
> > [  526.030550] xen-blkback: backend/vbd/1/51728: using 2 queues, protoc=
ol 1 (x86_64-abi) persistent grants
> > [  526.034810] BUG: kernel NULL pointer dereference, address: 000000000=
0000010
>=20
> Oh, indeed. Silly bug. My test was with qdisk as backend :-(
>=20
> 3rd try...

Now it works :)

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl/OJ1UACgkQ24/THMrX
1ywkjAf+Mf2G0ndFf12si0XOBlJIxCtaJF+I+52yefMe26dEIGqgetpMs6U5rfec
9mX2MR0B+UP1PApuXI72PKcGbefvtvD3k5wrB2xYYsEPp5AbE01pbL6X0ruIkHGH
VqfoT2rv1Qay8fGSyiyG+FGGVl4jRSHKeLe3CHkdmj0zly9Id5WWND/pSLPS7czJ
/ieBAxTIYjBvKYpJi8kgxfUdYQTAeaYNbUMSnkyxmpP+VeTDWg5r+mCGAGt25KAk
J5u9btEgWSsPylQp3+qjVvqahEdulTcNzVi/B4TdPoJcmVBuQ1WpE27VKyrkZboY
Bj/c8yLu5uIhrc7McUnGumZe4iW+bg==
=lL4Q
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--


--===============8154114891484029867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8154114891484029867==--

