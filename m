Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE1CCAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mUrSThk24lZEiZ0cjbsU79fk1HqXd4mIs4aWUfUOZmI=; b=rBTsCSU5Zy7Hj9pw9I6pV7LY/I
	jln8DSZn+tqAP8Cf2GUkERw3D8B5z2MqM+e/UEf+LPTv2C/ZGPxkROBqyO4CshOsGUiTpK/poskn+
	W6UcX9sv0pR5p6OMdwwpqP9ECEE2W8tXCVcpKrLlcq/xex6CvbPZJaJytiTLBxUnkAGM9fZVUh/U+
	meb/1Nr7JbZwmdUnKvIGZ5c4WlXygyELQS2BBprz5tNqudvkTta4nvIzE+o9xlc+MPYM2tJJ/BZZ/
	tFM/972gDOALnOU81ASoH9/TTWEJKuc3gqUV+uv20LUkOdgQHOzVGIVKJsQHkLl/ZxGv+RBgRCfhT
	SbNghGXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Vow-00000004enF-0Jaj;
	Tue, 30 Sep 2025 08:34:50 +0000
Received: from mx1.emlix.com ([178.63.209.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Vot-00000004elV-1JN4
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 08:34:49 +0000
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 9933F5F7AD;
	Tue, 30 Sep 2025 10:34:41 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, stable@kernel.org
Subject: Backporting of 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 to 5.4?
Date: Tue, 30 Sep 2025 10:34:35 +0200
Message-ID: <5015244.GXAFRqVoOG@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1934306.tdWV9SEqCh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_013447_508584_A7560256 
X-CRM114-Status: GOOD (  11.99  )
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

--nextPart1934306.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Cc: linux-nvme@lists.infradead.org, stable@kernel.org
Date: Tue, 30 Sep 2025 10:34:35 +0200
Message-ID: <5015244.GXAFRqVoOG@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

Hi all,

I just noticed that 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 ("nvme: fix=20
multipath crash caused by flush request when blktrace is enabled") has not =
been=20
backported into 5.4 stable kernels, leaving CVE-2022-50388 unfixed. I assum=
e=20
this has happened because it did not trivially apply.

Is this assumption correct? In this case please see the patch I'll send as=
=20
reply. If not, what is the reason?

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart1934306.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iM8EAAEIADkWIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaNuWGxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQq+RR+17trfwDfgQAn/eOCo73OLoxGmPkl0Yn
FNQ91eB3jnON1YShXWwBH1OuZoG9jntT31JzVWKkVmVBH9MHxVNBotyOn0SVRFOg
wxlhzObIWVDyKzEsIzF49iPVqPfohUSHeCcjAC/zkNulvOGk4p6C3dbdv7Z51ohz
Ze3xGCLZrlnsr0PFaO3d3SU=
=xIRa
-----END PGP SIGNATURE-----

--nextPart1934306.tdWV9SEqCh--




