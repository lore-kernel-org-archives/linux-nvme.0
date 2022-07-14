Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF2AC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mlokBh0bWHTvcV1HgjZls27ofPdWus0C/hCAOOoaf9I=; b=S/31LhE4z6n4KqnCjrMCdPQsEZ
	u7Qeid/LaJSbhLH2hI46o59NnljQZ+UhQIHoW0MT/GAIBq8CugYy4bSKdhoZTv6uR7RXeZEW/iE7b
	pbADjO6Ro6fombQ4QpOZFC2bH893GWOsqmbILQ+L3aeV3NZ2gSC9+Wu0j2lltcGH0juKtSgnE6HZI
	kD2jJr77FLnhoRnwwsrw8z1pfCKkAHwGk8j9IWY7zvRX7evcL0Wcd9oAfimgPY0+bqnNpKqsMAVWm
	TwPDm7SQ7q8MUWODnySK1aUNfnz/GUFTZSIl5N9Okr98IAb97pg0DQJQJ4DRuqOhNK08tfVB4NvJo
	O5RIUcGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBtu3-00CC6P-NK; Thu, 14 Jul 2022 08:08:55 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBttz-00CC1R-K7
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 08:08:54 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 866383200942;
	Thu, 14 Jul 2022 04:08:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 14 Jul 2022 04:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1657786125; x=1657872525; bh=mlokBh0bWHTvcV1HgjZls27ofPdWus0C/hC
	AOOoaf9I=; b=3iuYEUeZODBg8DN6MEpxcppTHJgYkUP4qBRDhEMX4a8X6TTiHgr
	gaQn81xh+L4wvUohIdCnBv7T7eef3zPlkpMFBnkRwrevq+J+at+AOsbDog+TmAlt
	6x5eJSzRRh/BfuY8j6TdzV6sLWKAsIOYpEa+y/gfvX2UYEcgIDPkvsIF4NMsQL0I
	G9/jE8kU5oGxrpuLX+1xGW7EAr7sIckF7k+PTs+DTKnObmqNjsONoU6pRftohsuJ
	Tjt6TO7bLKIy9UK18YjWY32fu5ylIpYfS/AliJSmhmBUGPTPochTFNrtAVTMoA27
	e9XTFfkFzHtouCu0aTa5Hqo24Zj7W+fElHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657786125; x=
	1657872525; bh=mlokBh0bWHTvcV1HgjZls27ofPdWus0C/hCAOOoaf9I=; b=r
	naRhEAv493mLml7UQdDmP2DtCCPmzVqx8bXGWw3VjkrIZ2qZ/qOtMmRsuqGc8hpN
	rCeuRaWgN6IegsCg1U7CapehJFGeTEKesNeOIj38DmhisV823u2GdQD6oGneqPZ+
	fkHMpuKFHev3TeiMEyw6DZsqwiD6X7jqOlPpDYFovSI6yM3BOelYtzWck7pVg1zu
	FIKAGgqXcTZQ2U0sAUaT3wJCcHHu0mFyEQrG+7dikbsjwL6SxZCiAoC8CPLjHQ6c
	O4rsKkOEESxKuuk+F1g51fsezoxTGBKVXkIqRYhwR+sU6nial/OzSEr4i905YFJk
	AYVVXUqytKiDU0g6Nwn9A==
X-ME-Sender: <xms:DM_PYqVcrN0V69aYqN3TjT5Jgk7rVTjEpTv2MnMTYtmzoCh8r3dRpA>
    <xme:DM_PYmnMsQP0Xlftlnx29FhyJ4auvcFt0vfaMzKlw7BLXZ846LCflNwoAzYT-xEjr
    0aYc1nKCa7TRguEeh0>
X-ME-Received: <xmr:DM_PYua2hsZ2hRpAYj3wWa6kFlNFNu5IAQUMu8XlDKbJ2yHM1iUhfXIlbpL7P6TK9VKiWx-olh46pa8zGRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpedtjefgteejuedvkeefjefgieekueetvdduheffkeehjeevleehhedvgfeiudeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
    hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:DM_PYhXwmeRKCJiJRLMiaTPH1OJxA3mLLQQMEeRw1B631Oe95MaSmw>
    <xmx:DM_PYknb3Wh1UJRibUZnmoWnG1_Ve-S188f03Oegr5-3p1g88jkMQQ>
    <xmx:DM_PYmeQrO8LluE5ep-OLAwU3JZtfMgWIuCeE_oDY_6O4yJdvsOHOA>
    <xmx:Dc_PYlBRtp4FVGXZKKQTXJWcrwFpslMyaBi3CXp_37h3YvRjuOUKYA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 04:08:43 -0400 (EDT)
Date: Thu, 14 Jul 2022 10:08:41 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: issuing flush to all namespaces
Message-ID: <Ys/PCWCY8YWsoIci@apples>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="35Asndjm6eExYUDD"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_010852_583063_00C8551E 
X-CRM114-Status: UNSURE (   8.06  )
X-CRM114-Notice: Please train this message.
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


--35Asndjm6eExYUDD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Since the (very reasonable) changes that cause the driver to check that
the nsid of the command corresponds to the nsid of the namespace being
targeted it is no longer possible to issue a flush to all namespaces:

   # nvme flush /dev/nvme0n1 -n 0xffffffff
   flush: Invalid argument

Now, I think we can all agree that Flush is the odd one out here, but
can we do anything about it? The char devices also check the nsid, so
they can't be used either.

--35Asndjm6eExYUDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmLPzwcACgkQTeGvMW1P
Delffgf/R/ldTtHYoyQreikwabSB7jnOF/bvvKD3P1H4yZdylBKoiE+Y3zSlZU/1
mXpNnVkIHdRxm+E7ypWMmwCIB22tGJerJUnpvnzhJD6+OpqSojprnq+UWCSXxNSK
Pd0q4NbHV6PNZ0MlOSAIZzvuz/0hTwBe9jccqt3r6B0JkN6uaZtvUtgNDVG30Cjp
LNok/OfMMCrhn360mHZ5cfxhlKMfNFG2le5kniwj7PU1zVaycEGq6no4XKfNNT95
9vhjW/JICQKCHs9soqqQQ1u9hXm86Qatv0Zzm/4I8ih7czED3ZWAgVVDlKD/TB9/
eOmR4IRLQFPUFpsJ+e/MR4GuV+jF7A==
=U0Um
-----END PGP SIGNATURE-----

--35Asndjm6eExYUDD--

