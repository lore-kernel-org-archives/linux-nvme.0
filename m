Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA3FC00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7tU+IG41sGbrGJxFhVsXzXkGTETH/yClz9JTE7BPK0=; b=c25JG9q/lCTaVOMAW8VliJRFnt
	1JohqPeMg5Djh8SNGfFEWLMLOTr3ibeK5Lp/ehfh1cVeZFeX/BWBIV23Sj1QoMO+MlLNp8IhBrzHo
	qNE9Z7oOLYyVYzvJnITE1cW+HvJ81sdhxFoTF4rPwG5tDNagAPCLWjihq2avy6jqv9ZQM3Neer/7t
	c47UGyLVLtjh41TfdOqwkXm+QPLxxvnEiVL3w2SKcPXT1Q3qhhYbfJxgH7XP/YWE4buYPu+n1Rkh0
	1w6UGdBKRTPbTRTIyqTcP36wn283WZTo5Ff4oK2hbrlalsZhjbOj9iTPc4MmSAfIEGDV5cYgKO/TG
	K9RS6xpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIQIe-0046Q1-8l; Thu, 19 Jan 2023 08:29:32 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIQIX-0046Ob-1F
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 08:29:31 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E29065C0046;
	Thu, 19 Jan 2023 03:29:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 19 Jan 2023 03:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1674116963; x=1674203363; bh=J7
	tU+IG41sGbrGJxFhVsXzXkGTETH/yClz9JTE7BPK0=; b=oP1uP1ofoKtrBhikJJ
	H/iyFmRXBi790tp4NGKpMWeX4WucWyDGQTY8WSZv71gkX6O6l4riG1VokZ4A5goj
	Cbk9CwXNTtk3aD7NV9rDsnAB6qbILYoL1RIUCeMuazg89dx0YOSxPr/LKLcmtKVt
	f5ek9qtj5bkTbBxzrGFBgngLrgjR426CFtfE43tHDKeP4D5Rmy2F4imyOtpHGcxp
	LTml3nvnE5qPMzp8VEnUrhoH97XEYyaKY0ZoHOoA8rlQQDwdXgnYR6I4OAmlKRYh
	vv14njMrF+UkN8pN4Dt7d+rBkASzaElU0b7eRQ9OW+RLOU+mmvv1LhXg3fXcpVrT
	4l+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1674116963; x=1674203363; bh=J7tU+IG41sGbrGJxFhVsXzXkGTET
	H/yClz9JTE7BPK0=; b=PZzX7Q1lQH3z0tCWemwbV6QNNvfU93en+QqkPPf+7qq+
	0tCnE3J3B/gnpWJijqq9fKvCgkV2s52Dxhhej9z1VHGrkRZZ0Olt9FXkxVsQp8Rn
	h4y55uzfhxE6alOu9e1CYLoWNJmrNDM+7aiFNrs3uVuRFHjHI/l8Zd5YM16xH+g1
	/X2W/UoAJgqWU7N4DmbdZiBT1JkX2l6k7pcpKcBpuKvm3lkwQTSIhXmqnZ+jHi0j
	9qrkMA5dcI2LEzGPzwbs1xwZFnpvnszS3JDwY/zmNF76b9FSp0E1aiuScBSOl9Yx
	Dbg5pQlO0LOUvM4jH2vzcIiCkJUJ5h9ssIEQ4X4W2Q==
X-ME-Sender: <xms:Y__IY2fMYE3RETmvP6T5ShCZfEQcvsZaB24rvu_iNO-bGyK-IeFFRg>
    <xme:Y__IYwOuxfJ2dflGCcSEjge56QF_lkxGfZ6XcdA0hzmyavcPVtaFtqay8cZs33DBj
    mku73u4rkOJkd1waqk>
X-ME-Received: <xmr:Y__IY3ghpvSeSFikhvzlWs8qXvrXKX39g-AOI39uKsOQW-jgXzVFSogqtFu9Q0wGAcJkOaw224EB57lZBBAnMFOJMA265A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeeggfdvgffgveetueeuffduueejtedvleektdffvdevleejtdejtdfhvdel
    vdfgtdenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Y__IYz98UZwJ5WwHffjHulyz4lL1NeTkMChWgjrOZyQtzTXClzE2bg>
    <xmx:Y__IYytFqiwYcRpezEWwGaO0ABoKxK9_XG9ye2yVbSpj0krMNtZ9Ow>
    <xmx:Y__IY6GxLo0knAwCPtVXZx5lK3LBa_NHtPxBVTWMVNeC03g5Dfnzfg>
    <xmx:Y__IYwBYgMx6U3a6_ow2E7YoOaV5TGvSoiHeL1fANc1b93B3kg8OCQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 03:29:21 -0500 (EST)
Date: Thu, 19 Jan 2023 09:29:20 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8j/YLA9O7Q+haE/@cormorant.local>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
 <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/wMxtvFL3yVWbTgo"
Content-Disposition: inline
In-Reply-To: <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_002925_589671_CA253B48 
X-CRM114-Status: GOOD (  19.31  )
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


--/wMxtvFL3yVWbTgo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 17 13:11, Martin Wilck wrote:
> On Tue, 2023-01-17 at 07:37 +0100, Christoph Hellwig wrote:
> > On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > > Good morning Christoph,
> > >=20
> > > Yep, the above works.
> >=20
> > Context for the newly added: This is dropping the newly added
> > PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> > other boot tests) to fail.=C2=A0 Any idea what could be going wrong the=
re
> > probably in userspace?
>=20
> If this is an aarch64 userspace issue, maybe related to
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D107678 ?
>=20
> That bug causes segfaults of user space programs if for some reason the
> unwind code is invoked. It happens only if libgcc_s.so is compiled with
> gcc 13, and the pauth CPU feature is enabled in qemu.
>=20
> Martin
>=20

I just observed the same panic on qemu emulated ppc64 as well. It's
pretty rare, maybe 1 in 20. 'rootwait' or removing the the prefer
asynchronous probe fixes it as well.

--/wMxtvFL3yVWbTgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPI/18ACgkQTeGvMW1P
DelXYAf9H5/rtUW2fNjGQYkeNQY3NOPT2QtRx6Ix2uuwGaM5ICTJCK97IE7ZMCZ9
yAIgFKDJc9Cyho+FnlzmTWYWVxIXDoQQktj3fUrFSRajxRBzVTJynC8m9O0We6cm
YBJvPxpfjOfst5SAq3PVjTX6r88xd4FPfbm0r11efWp0U0egEt6HpeUFA1hnPjoL
jsH062D2VVDEAM5pi2tSeKbWi1CLt5pN+aC16Q64x3zQUcTjh1T/QHGPii0Gjjsh
ds0d3lZA4WGUstS+ufRtZno+wQt/qW8lekGBidIaAmuUhVpupbaOzirNkNc8FGGR
5/YSRyr/+v4A3Z7tNo5hp36wfB/yQw==
=cc4b
-----END PGP SIGNATURE-----

--/wMxtvFL3yVWbTgo--

