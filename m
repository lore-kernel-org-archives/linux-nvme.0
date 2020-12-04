Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F8FC4361A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 12:21:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC5722795
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 12:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC5722795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4DSU8IFA9OLL6TlovTqF7qDuNEoSNLNspPditdpt45o=; b=AWYY2zjJ1lEBBEQpNYOpmW7x+
	gHApxRYERbHS67heiSu+k173mCu0t7+qpu2IT7+BIG3eO2ktUhNkkRPQT0UMi6l3rDvHZ0X/yfTAY
	t5yQF+5eZ/Kix0fRQddlGyfcQs6Gm01V8jrCX2Kg2EgH9BiNIrYvPLxKuXFu6jKGTc0FJwTuqHIJF
	jfg+xFP4caYIv//m8kWeNBkEiXtphDpyvbd5IJRntRJibK1GOr22kqE0bHbTdH1qOPxuDzMgXdMgT
	DOEVrv/qBbARameYBmLSKHe7wZ09v869KT2WaIJtXsMUOhmHklT+DDwQoPKaaxaxlHMH1mE82vPLG
	z9iUG50UA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klA5G-0006sx-5g; Fri, 04 Dec 2020 12:21:10 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klA5D-0006rg-41
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 12:21:08 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 7D48F378;
 Fri,  4 Dec 2020 07:21:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 04 Dec 2020 07:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DCUEX7
 nYunDYFqZ66Iy4I5yxcBSzLhwsOOKi4sQNbxE=; b=jkuCdY3OXTe4z6HTv8gsMK
 THIBhv0L3s3BJ4huVkWib64+kuNu8WHLfpjA0c+/LqoJcYj8kqr1ucQrbPZDKIxU
 Bb+2rMa79seYtfrVKbTLx99//zM00bAiaqvffwGjri9ErlN2e0uUv8JqlNXJt/k7
 /TicAtQY+/pASlRra/Rf8gA5ZH/H3D/J20HiVsrEngoZzbby1B8u6VdrH+cfnzvc
 KAY0eN0nUC92VHywjbcRoq8DLlpaPTgcYjGk5HgN2gB+iNBqk8GrZKaj5dwhPIwG
 66iD1UeCqagDxaQ1DurXfXyFPlo6p/LLl9gKXEl3prXBp/+3WtmYxysfT2HF8mkg
 ==
X-ME-Sender: <xms:qynKXwSjrZx3CdVygWImNiUIt-H-1Ix-BMYv95GxLB56kORMrG9F6g>
 <xme:qynKX9wcCr6HqR-LcjbyfJZ3cO2prBEEO2IsewewuNErBOe-o5zu7sJ3ODY-r2GNj
 09eSZmCWVMxWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeikedgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
 iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
 durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
 drtghomh
X-ME-Proxy: <xmx:qynKX91JbFohpmDykhajFlzyB76jBqEP8gkQAto8mwKVZ-yXuapycA>
 <xmx:qynKX0BtF81arDY7PNYsEhYxzS3CHV_fVY3rVjxGSXqzT5--J3j6tg>
 <xmx:qynKX5jIZNJH9z_bWhR6LSEZco6vjtZbk0bhU2GQuPT10QLMkSLdpA>
 <xmx:rSnKX5ciGKP_FiNkCvScwmc82ipCUF4NANsxLL3CxUikpTnih9X_kQ>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id F371E1080059;
 Fri,  4 Dec 2020 07:20:57 -0500 (EST)
Date: Fri, 4 Dec 2020 13:20:54 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201204122054.GV201140@mail-itl>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl>
 <20201204110847.GU201140@mail-itl> <20201204120803.GA20727@lst.de>
MIME-Version: 1.0
In-Reply-To: <20201204120803.GA20727@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_072107_294646_64413871 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: Juergen Gross <jgross@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Content-Type: multipart/mixed; boundary="===============4945494027949319209=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============4945494027949319209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0vPiNU+Cgjd3emdO"
Content-Disposition: inline


--0vPiNU+Cgjd3emdO
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9

On Fri, Dec 04, 2020 at 01:08:03PM +0100, Christoph Hellwig wrote:
> On Fri, Dec 04, 2020 at 12:08:47PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > culprit:=20
> >=20
> > commit 9e2369c06c8a181478039258a4598c1ddd2cadfa
> > Author: Roger Pau Monne <roger.pau@citrix.com>
> > Date:   Tue Sep 1 10:33:26 2020 +0200
> >=20
> >     xen: add helpers to allocate unpopulated memory
> >    =20
> > I'm adding relevant people and xen-devel to the thread.
> > For completeness, here is the original crash message:
>=20
> That commit definitively adds a new ZONE_DEVICE user, so it does look
> related.  But you are not running on Xen, are you?

I am. It is Xen dom0.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--0vPiNU+Cgjd3emdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl/KKacACgkQ24/THMrX
1yyQigf/Ummc+PwREciQfLShPK41N+ndzLA5XCtY+J8j4jCaXFLTiLe0qmJ+dbio
TiB1PJ4wUlJ5A6OA2nE69SG+xBCSeBkO/uaMOTNdkqjTMadsTbgZwC8eNOLNqmmp
LHN8g6+Z+nT1A1v5vpNdHb9mFb7kCSNuTlqMMbUSGspw9LDPXGhpHB/r+6AZSS4v
DXXb+ZKK82wI01M7lLDzpBtAYNRI5EOoRNK3RC5DlBLjd0ZYzOAtckZ6TKPSm22K
QMo1CWOuCeE6so2nH3aIcEiHI076PVSy0WqCmjskFb3zxZ5YW4VL7695mg7Vhr/E
HU6X5ein1vG+FyxHWtI1jMNQpGk1Sg==
=6oGg
-----END PGP SIGNATURE-----

--0vPiNU+Cgjd3emdO--


--===============4945494027949319209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4945494027949319209==--

