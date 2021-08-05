Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82B7C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C68160F02
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C68160F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qx55G/+g5QiHPl0DDMRkPkmgL7BzY3FDj/seucUXn/k=; b=Ew3NNRa9eDJotjAmqLumTMyOOd
	ZiU77GbTsRtmqx4PIs3AdYvC2U2YJ6yFXFYF5QtLtQV5NXilJftBlOCja94mY2PzIkXqc8b2ReaAF
	VH6O9QjwEGWHsqynhbceWx5sLFnqdr+hSbkADbMz0ImBZEINBIJGJgZ/XS9xj7esrJx2rs7g7Zhtg
	4ufdchTJXwWUNwF4LWKT33B+6wMNs7cCE7T4ALpdPI9XTxGm0jsvLI/3vBFKaBzEt4IhbkWpfQFii
	t6a4N57UGeqmRaWfzvkyHd+hT94Fx//eYALkt1lWna7ndClixHJXiwVX0DQGYR83g0ciaGqrwuXZF
	oyi2jd0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBcJK-009RDA-6r; Thu, 05 Aug 2021 12:17:18 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBcJH-009RA2-Ak
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 12:17:17 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 6067B1C0B7C; Thu,  5 Aug 2021 14:17:10 +0200 (CEST)
Date: Thu, 5 Aug 2021 14:17:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 14/17] nvme: fix nvme_setup_command metadata
 trace event
Message-ID: <20210805121709.GA20159@amd>
References: <20210727131938.834920-1-sashal@kernel.org>
 <20210727131938.834920-14-sashal@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210727131938.834920-14-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_051715_571394_4E176ED8 
X-CRM114-Status: GOOD (  14.89  )
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
Content-Type: multipart/mixed; boundary="===============1988474702069500167=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============1988474702069500167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The metadata address is set after the trace event, so the trace is not
> capturing anything useful. Rather than logging the memory address, it's
> useful to know if the command carries a metadata payload, so change the
> trace event to log that true/false state instead.

I see this makes sense for mainline, but I'm not sure if it is
severe-enough bug for -stable.

Best regards,
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEL1sUACgkQMOfwapXb+vKKkgCgu2gVX0pMthBnrewv9t4Iivam
+RkAn3pZLe940bLmbmZkDD2Wdjw3Twbt
=qbOu
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============1988474702069500167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1988474702069500167==--

