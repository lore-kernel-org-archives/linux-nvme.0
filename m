Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED5C5B543
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZaYfANRHxPJfwY2Ec0dCf9g+tUnQCVVVD04Q668M64=; b=xNKM8pduoGNTtjfyPtlY4tf4Fc
	evYad6RHLUfiyIv0SDOwolGneY9ZUisGMUvYqCuYAZ0uSKStJZT7Z5fRjOEMaf+/iVnABPnbfNXBU
	JwJ+GWfiHXwA6+qd0cmtuJ1URfVvsNoEXe6OD1qT0AH9ONGGYzNbZGddsJHiFpZxv7IWazS2osNnv
	1wWk79WiG746WOpGV8QYnR+m0ryDqWlMMMgiPrU2XPtm4XnB6b7qaWYNcvXpOFsIO4ehH3K/4reuW
	kH+VyWCWknBWaAtb103RqbrdCW76X38dsB5p5rU7KF4YQ1tSiaLwfjkfe1EWcsR2JLaLiTN5BUT5e
	HSRNTAgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLtvP-00000006UVC-0ake;
	Mon, 02 Jun 2025 01:25:15 +0000
Received: from mail-24422.protonmail.ch ([109.224.244.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLtgT-00000006RLt-2oJ1
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 01:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shdwchn.io;
	s=protonmail; t=1748826584; x=1749085784;
	bh=EZaYfANRHxPJfwY2Ec0dCf9g+tUnQCVVVD04Q668M64=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=r51K+RnibSqXDJ9sWk4GZdY60sU1KizK+DyFBcAKY8RThoaAP/Swpnp1dIc8e34SX
	 Z44YuP/bfbAHGBzXW5rhr8hagTRjc7ovBTeylmoNNuQWkHReLY/vPks1I34ltDioMB
	 hgSBJVgMTbP7SakEVCm7RZkGm6YmpXKGNXZnL4ntmLYpb3KnD+WZsl2/q8h/6fSlA+
	 j++gg4jd4dUZeNs/eToITse25ypPc6rPwTTgYWGRFa+9Y0FQddK/2WEHzzV+OSKPiq
	 WDi2SExIp13Z/EGlYwg6AFUIdh2sDOsEIowKUAOcl9bXaW8isatesCpJNyKX0/HhG5
	 WUCsLesJTRtzA==
Date: Mon, 02 Jun 2025 01:09:41 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: Andrey Brusnik <dev@shdwchn.io>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-usb@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 220175] New: NVMe SSD doesn't work via Thunderbolt enclosure on Framework 13 (Ryzen AI 300)]
Message-ID: <JeHMKChVhpNReeCujhPWnnVXkEuC9YpTrwt8mqZ8c8wwMQqeIg7ZVlAmqRlJ9MCmgak5KvAdVJkGDr-vfehzT0T66ALA082JEOMaXGrE6Qg=@shdwchn.io>
In-Reply-To: <20250529222223.GA119209@bhelgaas>
References: <20250529222223.GA119209@bhelgaas>
Feedback-ID: 27773722:user:proton
X-Pm-Message-ID: b8164dfafc7d193af4022fa99ba236eeb36c7ed4
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba"; charset=utf-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_180950_512971_C8A67ECF 
X-CRM114-Status: GOOD (  10.30  )
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba
Content-Type: multipart/mixed;boundary=---------------------02b76b9018760c600334190c3c7e05f7

-----------------------02b76b9018760c600334190c3c7e05f7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Friday, May 30th, 2025 at 02:22, Bjorn Helgaas <helgaas@kernel.org> wro=
te:

> IIUC, if you boot while the SSD in the enclosure is already attached
> to the USB 3.2 port, everything works fine? Could you please attach a
> complete dmesg log from such a boot to the bugzilla, just as a
> baseline?

I added a complete dmesg with USB 3.2 (and USB4 too) connection before boo=
t to the bugzilla. USB 3.2 connection works fine both when connected befor=
e boot and when hotplugged. Is any other information I can provide needed?

--
Andrey
-----------------------02b76b9018760c600334190c3c7e05f7--

--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmg8+cUJkC2//WlsAqGpFiEEowm2UA7MQsEG7isELb/9aWwC
oakAAHLgAQDHDnoBE5k8UqkQkiCJutsW6wbD18grUGgGPBvEoMsmogD/cDPr
BM4C+1+peIvFcYEZW8gXPKf0cLx2NGskPTppswc=
=ROpA
-----END PGP SIGNATURE-----


--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba--


