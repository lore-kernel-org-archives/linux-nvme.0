Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF05BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gkXpk55u1PGtSRZ5orhABhS3U6cGpcNjrvoSiD85Ppc=; b=TFw4XpHOl4MNrQ11zTXu8dDzMg
	V7nHSE54PVco1xQz9k9s05pkiwNMMc/1rCdbnQreMJ7JHxm2aIEtJgK3LIat2hOWI+TWCzZIswLV7
	NM0Kd5MiUf87rLXb/J9DbaJ4UqTXBozJ/DXxG6q/cyvPwB7kpXDYEmUBmCMhxSxMeNu9yZLioWGE+
	42/9K3qnU+WT4VZ5q6DDw6bxYBDkwoOXIgG1cAE7Xfy9/pvs+md05J/PB04dX1Akq7DfOjGiMU5UX
	khlIz4nyutL7Rm71H4w97Rdae3TgeqN2672rquDP53lHwRiiN02TF99PRmumCwbdIi6jEVkJXmS8A
	59WQI6Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBuYu-00CVwf-TU; Thu, 14 Jul 2022 08:51:08 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBuYp-00CVtk-1P
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 08:51:07 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 18CAD32008FC;
	Thu, 14 Jul 2022 04:51:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Jul 2022 04:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1657788659; x=1657875059; bh=gkXpk55u1PGtSRZ5orhABhS3U6cGpcNjrvo
	SiD85Ppc=; b=Lv9YT/FdTdVxrkAv/FNCdTraXg5v8TlkAdO217Ah3/1xg8WRLbH
	OTI3BU53fsgI2/xKBpPhHPOx4ONhtCSgmNi5ulKNijrHNRT0aZ7LY4ItaGQ8LwhW
	/WaTwW2X5PQHdsyJupKFsTPxEl13RAR7z/H5HTYOW/xjy2OiiTTmmm51cwKvffUE
	iDoPorHejkE2TAiZ2FPsoXKfHXLWiztba01lOeUvhqwtbatJsTICd7v6MDBO0PRR
	Ipri4ypJWJSqRqtsDsB476GehMIwlNQDh+ZqeVt9wm3a0CUIv4HIqPhR+hJkw9Yz
	IEbJOCFMwH4NqyvqaRZmWle3nKrH3ht5Oew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657788659; x=
	1657875059; bh=gkXpk55u1PGtSRZ5orhABhS3U6cGpcNjrvoSiD85Ppc=; b=E
	QZtgKPxkdMTX7xE0u90HsxCGzTOc/1jVJpjbAh1yZe/kNHxaxSjQ/sMuOu/sKjbk
	+UlLcs6G0Or9yEGvEfzRKWPu7SfC/StVVZFu3ntchgQB8ajy+lioPTa0sk1lSb0r
	PqhFq/WOm94bTZw3U36n+Jm5GYF6iNP31AZtXExmXzeZCrD5Gn+/bBZLcceQYUcT
	4mKpth3kVNwDxSs2yyvlS7h6KbIRIFizqxxsrh4Jj5815MKURNlc5J2QliVdLFZZ
	wfaFSGqJMKPxSzsu0izqCRCauEqKTHyeuB9dRlh/FCvy97tJ8LLEC2MMUOx3nMjG
	AKrfs0jvE8RGCTjnm8xKA==
X-ME-Sender: <xms:8tjPYu-uOYkn0sD2dCdnzQzla0nwjVuXTuQQjhQ9P-Lu4FJimVi9xg>
    <xme:8tjPYutRBA-zE_Lbtwl9QaBv5oBmE-V46WPQQ4bd9XbMcYrbrJu-enRhK34x3CvT9
    Lc1IqIbL7dMa7_1Qq4>
X-ME-Received: <xmr:8tjPYkBbdIzG7B4Ik6fAccTdpGsHnl6mRwmpB8A7CKtj2Tt-B7vD7t6IN82m8Lb2re1giBheHaCH-CAOeHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnhepleeuhedtlefhveethfetgfffudevjefhfeeftddtveevteegveejvdekfedtgeet
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:8tjPYmfGaTs2u5WaffgFD8d871bNnwf2OlZKTmq1OvwtnEQfHYrZ3A>
    <xmx:8tjPYjPIgcl6E5uZD0mMNZoA1PSqmgLt4HMItVmCEMXRzNLcwJMB0Q>
    <xmx:8tjPYgmsCrCyFBgUMI-UMm609GxdqVxL2_AlEtd4UUOIgh_NyiuecA>
    <xmx:89jPYormazpGpaIJiiv-F__9fKBuVssbaRQpnDRNdtEkveUB3ffezQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 04:50:57 -0400 (EDT)
Date: Thu, 14 Jul 2022 10:50:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: shadow doorbell on admin queue
Message-ID: <Ys/Y8N0y1lpMwyZH@apples>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="909vGvavICrf63QX"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_015104_465960_DCD86563 
X-CRM114-Status: GOOD (  12.13  )
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


--909vGvavICrf63QX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Jinhao, our QEMU GSoC intern is working on nvme performance improvements
and while implementing shadow doorbells an interesting issue came up.

The spec states that when enabling shadow doorbells, it is for all
queues (including the admin queue). However, the kernel will currently
not update the shadow doorbell for the admin queue, which causes trouble
if the device expects it to.

The kernel is not the only driver doing this - SPDK doesn't update it
either[1]. At least one virtual target implementing shadow doorbells
(SPDK's vfio-user target) jumped on the band-wagon and simply expects
the driver to not update it. In QEMU, Keith came up with a hack to
update the shadow doorbell from the device side, allowing both compliant
and non-compliant drivers to work. Just fixing it on the driver side is
a problem, because it will break targets that expects the non-compliant
behavior (i.e. always expecting mmio on the admin queue).

Question is if the kernel even wants to do anything about this at all? I
kinda already know the answer here - "spec is screwed up", but I wanted
to raise the issue here for feedback prior to potentially starting a
process with the NVMe TWG to sort out there.


  [1]: https://github.com/spdk/spdk/issues/2147

--909vGvavICrf63QX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmLP2O4ACgkQTeGvMW1P
Del3Tgf9GkkouRIcRrUlAgbqHwegTwJBe7F+7xCxbQaZvCKWsLKMlxAOukA8t9m4
OBiGkF6eC1kfRQfE7kyooucw159Tah42RPSrC6ZsMr5z/Rw/B71gph8GLBieqdS8
68DtyVge1timKCEqPjMO2OBq48N6R4KPPJx0zsay4VpcJNKQFtqu70FqLOo+tlDO
gKz/1p5PGQwXETqfUhc4281waED9NghjUcSBoV98tzsPnJtxTeRwKScYbnI5Dvhf
zhDIXcSX/TpCZ0vQpqGOoW4iYbSutgseYhMa9Lp1iBUm3pqhM+FmTNebixx61HZP
Q5LXO6Z5RmiD85lerBE3gBY2PpNW4A==
=afbn
-----END PGP SIGNATURE-----

--909vGvavICrf63QX--

