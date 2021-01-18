Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F258C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:29:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9989122CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9989122CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y3TE1WDYHGzSOBeI5OTQKg3b/BnnuioBZu/a49M0XsM=; b=xQhKsQ8bhnonrIe0q6u2DrnQD
	nhlDjAGMX1BYqT6tqBulvGFvblakWzEKht56gloyM8mIr5Lax/Cr+S+YVsceK6sfPmSCV9JL+htJR
	YZ49S5pMU1Gq6j5fIwXHX+cdUSItynsbYaUvsJrUHn2APqdSBPVlGfSTzzh2XepzdFKQ3dVhQhoV4
	wszohJSK/qyyTCt1sBwEePuxodmnvktZmQR94GK5pePXdWR74u5LdJrvOVi3Nzgt7XqqQbVaiVcdv
	8P0vOjB/0DJlPywDT2TNCPyau4NrylJxiBLzCVjocnc+PoCXwg4EOe1zuAG8jEfXbwSsRo9fYfE3W
	a2bb1GB/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZHF-0000h4-8E; Mon, 18 Jan 2021 18:29:21 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZHC-0000fZ-Vk
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:29:20 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 40A395C017E;
 Mon, 18 Jan 2021 13:29:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 18 Jan 2021 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=TrwoMjews7HeqMv3rqhxGGZrx63
 dLxThYRqHNKQaQHw=; b=lPZ4+SBA1r7o5A5UVLaiZnMi3b1gr0+40OgPXepEqQd
 bBSYn4H0JA3nwqIjxX8RV0ruiOYwZKVE2XJnXQ+UywVu6We+y8oUVxw35TBZhFMg
 za1BTTp2Qxzjidy03ucMoks/zQ0kwzMxQb/NV2CYE3YLZT6Yby69s06FkJZBQVld
 j6ge3GivDOPc5Z3zlNaNo4hsezhv7v0EWoxwTUr9TQr/HWOdseuMDtPRXrTmALje
 6RjdnMGJYga1KCTbEsZj8FmQmboYfJuEIOBsl8TA4/mn8UUsqz0CS49qUpj48cpS
 lWDsb/4a/5V+bmZyyAp1pH3lf+FVsgTDBC0p/EvU2iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TrwoMj
 ews7HeqMv3rqhxGGZrx63dLxThYRqHNKQaQHw=; b=g9TXwBu8DP0yHAEovVMVqF
 qn5vaEI9w3HWF0NCbte2NxoaBO1O9w3UAVx5QWPZa/zK92iGmJ2T4zpjKeLV9IbN
 Afc6AD4Ka8xMS9mS5RpDxoRjoZIUt9uRh60VDHh4K/8aqXUJdQVij6+QrV+M9BsC
 HbnU3gW513JkqrpDk5USdClH41UK/9eub2Uz2EtJuoRezRA76ylty6lZkj6v3QNr
 4Z0B0+2PN2PYYtwjWTY4qf/YQzMHwwP2eAikyK/V5FR8XrEP5pu1UvDdJ8Zawvkb
 4vGiYPUMFwQxADG/rB8gvpbwCeaonllOITrSrDjgkYtoy7NLeI6sfckhS6S15CnQ
 ==
X-ME-Sender: <xms:edMFYF23wDGRpykbnayjbvs1lV65Xxck-5WlYT0h0cd9qKv92oTrXQ>
 <xme:edMFYPWoBTgmLTg1Kcn0TX5yetaqqczXmkwqRS-7cVIBEXqcLWq2fju6NJIyaSrTQ
 Nd363OprC8v1TPlS8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdduudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:edMFYPWR2xC57X2vw4WszoDuaUi1RjciPrNMLlj0J7p-5WofwpC43A>
 <xmx:edMFYOe-3OCp72W-tgo5d0xqqaplVj9hEcIjScQLMFbtLbz3t2pFeg>
 <xmx:edMFYIVTBmupV7dCFGFDssPX-oPVZc8Rr4ak6iO4YlSXEFjDkPVsDw>
 <xmx:e9MFYOFXI5-85xDLMC72GSRF4DX6RFhhVAK9JfyMuVUv26g7NIT8kA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 71454240064;
 Mon, 18 Jan 2021 13:29:12 -0500 (EST)
Date: Mon, 18 Jan 2021 19:29:10 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAXTdohFxR5J9hwY@apples.localdomain>
References: <20210115063046.274495-1-its@irrelevant.dk>
 <20210118175956.GD9901@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210118175956.GD9901@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_132919_194850_A6F09617 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Content-Type: multipart/mixed; boundary="===============4768241840194207350=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============4768241840194207350==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zh8nUPFMjIf71aB"
Content-Disposition: inline


--9zh8nUPFMjIf71aB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 18 18:59, Christoph Hellwig wrote:
> Thanks,
>=20
> applied to nvme-5.11 with a little tweak to remove the cmbmsc local
> variable and a comment explaining what is going on.
>=20

Sweet. Thanks!

--9zh8nUPFMjIf71aB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmAF03MACgkQTeGvMW1P
DekhmQf+N40f5rDRmSO7CSlFQfYPi1ynofliDqBI66v4OxHRADZzgnezvED991Sf
kuaIBY+2CbBWpYmgHJt/M4C+EvsG46EpCCKYafu749XfswVkNGsKOPkBFl/4n5z6
1odJHh7U/m1YGOpxKJ58k2ciqWAVeymThGqfSAyYZhqbhPToemWH1ryPoLhuJp84
EWYW0xiwLM74dP4AzRY+r0osYR+qU7ZxEXNwdWq0r2UXS/ErAghTzSKODhzVtwYI
zuiW8m3Sv2nOWK9b7zUjgI/7cH43En6xzxJtJm7t7ffbBbfiy5dDG42Ra8REJZ5k
eKd5vJkp7yBPzL9EJ75U7gvcgf7Ycg==
=uyHI
-----END PGP SIGNATURE-----

--9zh8nUPFMjIf71aB--


--===============4768241840194207350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4768241840194207350==--

