Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9E1CCD185
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jdIjHOIc+x1UmurbwfxAvNk4r5qMzupSwQTHANWUImk=; b=msRtYv+CKcx9L2/KT1bfODvZxN
	k/O2BKHjRCtandbh4Y0vh1Wv8KBqt/XtDW8UMHFF1jooM1EMlhMluHcWz2dB7CRefhH2yBHyAFIMW
	4w83waJGbPOjXnhZ7Um7Z7mXfBuMnAOqE+4DZqO8pRILykmWP05zAlISBEWnMb1bR1Clx+aHIcL2a
	EKQ880aMZoFa4NGqwxyyTragEihAFy2hyQ1fjrJQXOzxpwm2d4t1e3eoSfACq6onk3VKEOGNfumgC
	hke3y2zgLWUoSs8srbkwhbEjiSKoiEgjqJ8WcjCNM2M3F1LWVNddXfr9yEDhmEY+S3YbqWgaYuMBe
	6xfcj95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7E7K-00000008glr-1Y6c;
	Fri, 10 Oct 2025 14:29:10 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7E7H-00000008glT-2uba
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 14:29:09 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 77F3A480BCD;
	Fri, 10 Oct 2025 10:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1760106543;
 h=message-id : subject : from : to : date : content-type :
 mime-version : from; bh=jdIjHOIc+x1UmurbwfxAvNk4r5qMzupSwQTHANWUImk=;
 b=JUq0P8RPw2RpOtgJnYRlZULthj1xYkv8QGlaNPee3FSZIV11AbOGLGVMdgwM36ezR+bXm
 6RJNjpJHv41Q9IHAA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1760106543;
	cv=none; b=VYlVL79n5em/yJi2IeWsq0zjsuh8yJnuEbxJazzwTRdlqsrJG8DAF0pua8Jx7YjZIzYbPnX0X5zSQ4r9OE7QEqygMrKkwvVH41d9Da9RQlr+kh37XKv7DZ1iizAPvsvaDd1JP8Q6wDm5H1dCOqH8nZDWCw/RsTz1alKtEjly1Xg4L5xRO+9lSsiKWRaXWg81cGhoxKhpg21yUKKNEX5xjfm71b5ZoRnsw+79tLeOQIXWwF2CPCJErzuoj3gZZ6Uzug7XWNEbO6fKhxKLb3a+YSaNcc9u0RyEfc5/sBQavAnRukvBlqmZVuljtMq/DKWg7CcHhAiidWf1v4ic1aILoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1760106543; c=relaxed/simple;
	bh=MTLbX/igiP4DDhf0AdTdsrfQICui0FHb/8fIU86/M44=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 Autocrypt:Content-Type:User-Agent:MIME-Version; b=UA8uJUK0ugkS9f3felOPhZ2Q0Cu6recwNac4Yj9MVFdxgLR4nIt1gC+o6rglsYbY70TSOiL7MkbLtVxv7p54cI2OQ7L0/yQILa0RqMB/xkmsHRLiN99neBNp2jTLHulz4z+03p7LnGKQ8fDhQSB4YCQr+4AmZ4vJFSUlnbrAeznObCiqcfpqWoJ6N5RRO0k+soKWTnlr5GEMxmnG2W8LQlWCSaHLKSsQeQMozcwQxNrrlWpPTK0bDT6cErprFZpBMNu5ThTG/93o/lgN47lalQBx8z6oJ31dhoJoT8svk1dL45AlTBO3bpvLBm75pvOEudcwFXpyDxhxwGHNSnlIpg==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1760106543;
 h=message-id : subject : from : to : date : content-type :
 mime-version : from; bh=jdIjHOIc+x1UmurbwfxAvNk4r5qMzupSwQTHANWUImk=;
 b=cCe/anBNY3Etb5L81JqhmlZpLIq7yvjwyYrkb8rnw6j9BZliA8KDgA7qbCy5SAemyYCNK
 CJPJUF7FN3uSMcj/0e3z+swc3MxR2I6xbSdR+OoeSlrBLXJo/Ewbs7x7HyKu3kGSpYfZSNZ
 jhwSBoVFWX2cPuq00zBsid6LorZt18lVq9KC1EdN1KdoT67XMuaCY67SAcCtCeGpGlJdiDD
 3PthPumn8Bcv6WXEK4rRcI+5iY8LUDElIo9IfqVb2bBfZspaRBGmXpV4A8fd0svDDnzi6UX
 TtxQ5rNiD3kYSxNPwNPWLPdn28/ySp24/HqIcKG5FimV2X/OOkYqQ9OVZtwQ==
Received: by srv8.prv.sapience.com (Postfix) id 51B7528003F;
	Fri, 10 Oct 2025 10:29:03 -0400 (EDT)
Message-ID: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Subject: mainline boot fail nvme/block?
From: Genes Lists <lists@sapience.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Fri, 10 Oct 2025 10:29:02 -0400
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-cDtzTbyIsJ0vqi01o7jJ"
User-Agent: Evolution 3.58.0 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_072908_235901_C2D8161D 
X-CRM114-Status: UNSURE (   9.81  )
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


--=-cDtzTbyIsJ0vqi01o7jJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mainline fails to boot - 6.17.1 works fine.
Same kernel on an older laptop without any nvme works just fine.

It seems to get stuck enumerating disks within the initramfs created by
dracut.

Subject to bisect verification, it may have started after commit

  e1b1d03ceec343362524318c076b110066ffe305

  Merge tag 'for-6.18/block-20250929' of=20
  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
partitioned:

    # lsblk -f
    NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE% MOUNTPOINTS   =20
    sr0
    nvme0n1
    =E2=94=9C=E2=94=80nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
    =E2=94=9C=E2=94=80nvme0n1p2 ext4        1.0   root  77.7G    42% /=20
    =E2=94=94=E2=94=80nvme0n1p3 crypto_LUKS 2                         =20
      =E2=94=94=E2=94=80home    btrfs             home  1.3T    26% /opt
                                                    /home            =20



Will try do bisect over the weekend.


--=20
Gene

--=-cDtzTbyIsJ0vqi01o7jJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaOkYLgAKCRA5BdB0L6Ze
2/qsAP4lLRpZ6r2E5shHmQZVzY2BFM+HT8xJAkQrIIjtipIW5AEAoFZg3GMMBWlO
1nQd0PPxtwczQ/5XLQzf2WRiQqftGAE=
=ZfXG
-----END PGP SIGNATURE-----

--=-cDtzTbyIsJ0vqi01o7jJ--

