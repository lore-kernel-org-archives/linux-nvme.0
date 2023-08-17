Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF54C2FC0F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQ4KvZviHGr9y/nWdkCdgQJYFdxBNJ1zpQBRqwmYGXc=; b=FNdeDe2K16bYlZCbamWt3lJaEu
	nuuNbjvhEBhjBnXZM9kHn5GFh9hHGzQUsTdCUlwWTHUUfDlGRYl3mQyLVuuipTHBjbUcGLS5IBP/F
	myn1g3HwQKS2Uk2706yHtqM1DQCIqr16dSvHFifI9tv/WlijMyuVxyW+wpZphSap19AqG4iNq38UE
	VUES73/ztGK5dtZijWBD7pGahLeiVGOshKZDFUg31Bd4NLf/2y5s/+FDpgSsiopmchJNvMxNzlWL5
	81bsBLMWLZ1bHHaHpvFPnfAsN20EUHcDm4tQAhe0iK1zB9SxJQWzvC+5hgExRV4pSo2iJjRNjdnc3
	J1CwnTnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWTFb-005Pmn-34;
	Thu, 17 Aug 2023 03:00:43 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWTFZ-005Pkg-0u
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 03:00:42 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565f9b2f626so909904a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Aug 2023 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692241239; x=1692846039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ4KvZviHGr9y/nWdkCdgQJYFdxBNJ1zpQBRqwmYGXc=;
        b=htYHUnR5XLsKO1d90gH4lPfj+7hhoGcxRSrx8YhJmnwn4hgGe8/OV6ms5+vezYkj7M
         aLPDEUo4Lhq+Vl205rS0jmTxTapm2JE/Z5gQQOfKCRZFI3iK95HOx8eB5V7yZDyydBGz
         Cv6CPgrioKY3S9YYSiU21dLQRehMjwDs5h03yXHCHgjSAcmD8BFHX8MTCy9E1CYmR3Wx
         pciwfn7akpRcuguRV9rTgvSkdz5yu6+Qd04Lag/JzzTYkjVOfQB0F7I0bSSCH37vqD4e
         YysWfAz4g/G7HPoiSqUQRvkF7CjRkpH3R3Fqe/BPLKBEd4bZ0Is9s5F4/o2yd8tvudXh
         Ny1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241239; x=1692846039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4KvZviHGr9y/nWdkCdgQJYFdxBNJ1zpQBRqwmYGXc=;
        b=e1XEXc7N1XYRizk9hV5Y3K9rPqY8bOG5Eom6xJ1h5aKkzCNbs2IgBrAwE2QmK33ysD
         CQ0OVSqO+1Ze4r/qNO9qKoBjwT5//8wzF74/U4j7vpRgw0s0ryZN9GDPJfVJf0sqVPsi
         QlxyrD2UqFRGbsN0vPLj9D+4Y8xRe+Rx//yxI+3Q1lRtbtXT7bI+Jr9yNghs/U/HtR/S
         bM05qcxJufVaCRT1fytRceO5PKadnFSgj9XroMeVajUMW+pWyXP7Jyf+dwClAyqtpyCN
         Y3uyeUp23rIfBLVkSA0iDApCIWJjK9379Ex4YUPjCjPjxP7dFWNj4ktcMB8vUm6tNDzD
         QgWw==
X-Gm-Message-State: AOJu0YwsUUjpl+aCAiWiiLoe9QxgRa4vqWDT477GHatpptgsUqth9U1a
	Alv0YpRmjoDfcfZ1/9wyPypReStr/m0=
X-Google-Smtp-Source: AGHT+IGEOQsi1YfGleaR1ny8ZUhghxdnwyqjvX8wr5c+fpVO+EwVkp0G7JV1pfeknW19d8AcPzTwPQ==
X-Received: by 2002:a17:90a:c302:b0:269:85d:2aef with SMTP id g2-20020a17090ac30200b00269085d2aefmr3337017pjt.20.1692241239547;
        Wed, 16 Aug 2023 20:00:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id gx3-20020a17090b124300b0026b45fb4443sm449973pjb.4.2023.08.16.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:00:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 7230B81A1A74; Thu, 17 Aug 2023 10:00:33 +0700 (WIB)
Date: Thu, 17 Aug 2023 10:00:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	Ricky WU <ricky_wu@realtek.com>, Arnd Bergmann <arnd@arndb.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hch@lst.de,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Possible nvme regression in 6.4.11
Message-ID: <ZN2NUIg3k5VgMg63@debian.me>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5UPcTpC6Zd9UUWNK"
Content-Disposition: inline
In-Reply-To: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_200041_314681_22E0673E 
X-CRM114-Status: GOOD (  17.41  )
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


--5UPcTpC6Zd9UUWNK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:39:34PM -0400, Genes Lists wrote:
>=20
> Also reported to bugzilla [1]
>=20
> Failure happens on 1 laptop with samsung ssd.
>=20
> Boot log manually transcribed:
>=20
> kernel: nvme nvme0: controller is down; will reset: CSTS:0xffffffff,
> PCI_STATUS=3D0xffff
> kernel: nvme nvme0: Does your device have a faulty power saving mode
> enabled?
> kernel: nvme nvme0: try "nvme_core.default_ps_max_latency_us=3D0
> pcie_aspm=3Doff" and report a bug
> kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to D0,
> device inaccessible
> kernel: nvme nvme0: Disabling device after reset failure: -19
> mount[353]: mount /sysroot: can't read suprtblock on /dev/nvme0n1p5.
> mount[353]:       dmesg(1) may have more information after failed moutn
> system call.
> kernel: nvme0m1: detected capacity change from 2000409264 to 0
> kernel: EXT4-fs (nvme0n1p5): unable to read superblock
> systemd([1]: sysroot.mount: Mount process exited, code=3Dexited, status=
=3D32/n/a
> ...
>=20
> All kernels are upstream, untainted and compiled on Arch using:
>=20
>  gcc version 13.2.1
>=20
> Kernels Tested:
>  - 6.4.10 - works fine
>  - 6.4.11 - fails
>  - 6.5-rc6 - fails
>  - 6.4.11 + nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff - fai=
ls
>  - 6.4.11 with 1 revert below - fails
>=20
>     Revert "nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and
> 512G"
>     This reverts commit 061fbf64825fb47367bbb6e0a528611f08119473.
>=20
> Hardware:
>   model name      : Intel(R) Core(TM) i7-7820HQ CPU @ 2.90GHz
>   stepping        : 9
>   microcode       : 0xf4
>=20
> nvme:
> 04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe S=
SD
> Controller SM961/PM961/SM963
>         Subsystem: Samsung Electronics Co Ltd SM963 2.5" NVMe PCIe SSD
>         Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
>         Memory at edb00000 (64-bit, non-prefetchable) [size=3D16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [b0] MSI-X: Enable+ Count=3D33 Masked-
>         Kernel driver in use: nvme
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 101bd907b4244a
#regzbot title: can't change Samsung SSD power state due to ASPM mode check=
ing
#regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=3D217802

--=20
An old man doll... just what I always wanted! - Clara

--5UPcTpC6Zd9UUWNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZN2NSgAKCRD2uYlJVVFO
o4nLAQCs5bkzknjQjUeWT0ZbGYBdZZcflxXUCkhcUDKBcXBupwD/RZvBrJN3bPq1
E0kmmZWzmDfVkywfHXImiHjV04CCnQA=
=qeoB
-----END PGP SIGNATURE-----

--5UPcTpC6Zd9UUWNK--

