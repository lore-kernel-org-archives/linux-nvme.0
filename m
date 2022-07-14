Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A523C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9GWd0sBaI8nv9Ual241B75ITmlchqE33wNYl8IpyxI=; b=yXWDiVIOkk7wpLAExn8eWXbwIc
	Q3ZMfXDQse7NtoLWe0B/Cd28tg0hqNscjs16gZ+DACaBnZylTeDpthfyAXwhOyUPnZ7rUY743repW
	CVuzuSn5refsAKuI+1uH/zNyb9nre07e9wHB+/yVpsc32M1kLOOIjPuAhS7b/y9dqLXNRyWCcoQ3X
	+hOx0PVqAPxjJM4nQFKnP6e178VqStBW/onDaqcyS3b9AyEQySRwoar+c7JHunv1/opq71WoEmbvX
	q//stvX/mJwdWB7UZXnJWy0dWIocj64x3SKXsjetV5pnSLVTwAnp7Z3f8cYK4rmTTnmNUisrJKQEi
	r6J9c39A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBu1K-00CGMX-VE; Thu, 14 Jul 2022 08:16:26 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBu1I-00CGKr-09
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 08:16:25 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id B538832008FB;
	Thu, 14 Jul 2022 04:16:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Jul 2022 04:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1657786582; x=1657872982; bh=N9
	GWd0sBaI8nv9Ual241B75ITmlchqE33wNYl8IpyxI=; b=2y9R7r9nBhoJf154cb
	L1iKXRf5aYQqzRYmb/6w7EunmOk/g6BlMs1hSr7u2geDpEAghtGEYdNIfEZPIRf+
	Mt2W5gaL3D7JhLFOUrgTEuAl2H5+2yw8hQf6PZ6ADmeeSNSggu2v29Gj04YjhkJ1
	MdM2Gqf9Zuq4HCiU2MGHmbMCTMT1eCS2xQ1BkRLm7Zhte7nSwa1YnWh83ORmcrEk
	ZT2LhyB0pMcL0La1eIvf3hlQcUeor/0Mio8wln2o6z//KQO69F18dlLPN+QsVPuD
	NFHWMZH5feFQQ10NjlCkCUEKaY4/H0zMI8UYTKtVoY1lM9w4L/kQX2C0caA3PkUb
	jAEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1657786582; x=1657872982; bh=N9GWd0sBaI8nv9Ual241B75ITmlc
	hqE33wNYl8IpyxI=; b=ac3YGl1RDvuERGtv8i1dVeL4l+MWIZV95TIgyExt/cgO
	BNyWiXRBeo5QNevxFGD0FwkqOzNd0Zgw8UcibQHU7JjCk+Etv4SjbowvqdGPg33/
	mjlYDa0SMEvETqQ3ljP/w/mSPD4hCsrTFAXli92LXnFkoYiyFaDQhGFmcyoutOfj
	AU/D7KfZKZDzoJ8MKxrLWUPD0Eml+jF93Gtko4ElsaabSgpvG3f25M2pLiu87XLq
	C+s6hbwn8AAk+CXMQiVPX+zKXWxadc/YB7QmKdccQlUr0pZmq0FJg/Mh7E4pF9v4
	lpMDrGAMIPSxejonkMmGwj+ismBBGwagNlEEu+35NA==
X-ME-Sender: <xms:1dDPYi9BIUJmxQpSD8ZtHillYrj-tHzDBnVEZXovtMIgVPwwutGpUA>
    <xme:1dDPYisXAyolDXwg44tDYXWGBz3lbKeKQbos3OSd0NI23I55GezGbtmBw5utQOSFu
    kbBcRa4TagHboE_pUw>
X-ME-Received: <xmr:1dDPYoDXJUczMAZI6ozHkR-PvsmZIXZhg5_wh8bCgVkVwW2qEeqxiAPjkhYdKBDvuG_2TcfNlOwt_w3bp2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:1dDPYqctnTltaKnkYERY8grySJP_qtTy6KRJLUkEAMyra7pKdDsT6A>
    <xmx:1dDPYnM-KOOw9ho1R_I7oLgxFVRNcwP8DgdzldWFr7uHkPs4f-hi6g>
    <xmx:1dDPYkmFKK0LQz3KXtzvLaawl_7slYFZct_9T9G7paKe4bWwqs7Q6A>
    <xmx:1tDPYsquWFl0iuw8Zy_czHNVcCNfeoCelejKKbACFqQP33eKioJFcg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 04:16:20 -0400 (EDT)
Date: Thu, 14 Jul 2022 10:16:19 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: issuing flush to all namespaces
Message-ID: <Ys/Q08orzDQgIp4X@apples>
References: <Ys/PCWCY8YWsoIci@apples>
 <20220714081103.GA30086@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Mmg9sYRIVeTrqEr"
Content-Disposition: inline
In-Reply-To: <20220714081103.GA30086@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_011624_096977_BB4E1B86 
X-CRM114-Status: GOOD (  17.33  )
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


--8Mmg9sYRIVeTrqEr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14 10:11, Christoph Hellwig wrote:
> On Thu, Jul 14, 2022 at 10:08:41AM +0200, Klaus Jensen wrote:
> > Hi,
> >=20
> > Since the (very reasonable) changes that cause the driver to check that
> > the nsid of the command corresponds to the nsid of the namespace being
> > targeted it is no longer possible to issue a flush to all namespaces:
> >=20
> >    # nvme flush /dev/nvme0n1 -n 0xffffffff
> >    flush: Invalid argument
> >=20
> > Now, I think we can all agree that Flush is the odd one out here, but
> > can we do anything about it? The char devices also check the nsid, so
> > they can't be used either.
>=20
> Don't do it.  Sending flush to all namespaces wasn't even clearly
> defined until I think NVMe 1.4 with the supported bits.  It doesn't
> really make much sense and there is no point in supporting it in Linux.

Alright, I hear you :) Thanks!

--8Mmg9sYRIVeTrqEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmLP0M8ACgkQTeGvMW1P
Den2Ygf/VN4DIHyrPukigfU3PjbzozHbvi1J3b0WFHdtLlOPylF80lVuvFmO5De/
GfXT69jcnh6rpWXovKQXRz8FiYJaPDDx6rxQyBh9S2gcT8GZEehOVFeaKOH+qThS
EXfpmip78P7RB/gW3wg95vbJ3N/RJIp02G1qiZg58ZE/GRWePqBxV9bMpclNGipI
D2xyo+cHIN+FMV5oUab1neUDZFCGuhDM1AwkRlC+mQR6/jRolu5AuW53h5F/jawp
T4sehopK+G1Mjq6UfJh8DnYuImycvuuzOeiXDhqHUAW7m1gd23Ew7Bm2vpZjdeKU
0VWiHqYcHCe+7P0H1zmLY/aUqeLFow==
=jB5C
-----END PGP SIGNATURE-----

--8Mmg9sYRIVeTrqEr--

