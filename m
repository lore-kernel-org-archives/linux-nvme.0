Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC02AC021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gkjIgJEVkr+P7QwxqKpisV6/73NE1KJ6/2gUZAf6iac=; b=NjKrNZbJodsduCMwY8VjGGnxzN
	kdDiGLSXFu2I1XU7n+QGkP3aRSoV1/13z3fly4eKCHsayCr3JKpK1L8toSyGkS7T4+4Kykh3VHxDv
	F0I0desWw4w632Am7Oqe3gTm40drseYSb0vUK35eaI9N8abFlxcwyCXhA7+MN1mpDfDbGJrRTytJ+
	XpQinoIcj4HjGRQedUFkifzSuzQCL2kj5GAknJbv9Y8vlpTfus1btcIU5Dsgs6XE1RZ3p8QediUlV
	P3yrxeu1NviDCU3ytl0SyzLgSJY7Hf8584ueP2BZmxq2VAox55BHj8+Kzll9hY5vi+d/Z8vPsxUfU
	Cv3oBcGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl49M-00000000Nqm-1brm;
	Thu, 20 Feb 2025 10:51:24 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl49I-00000000No6-2H6l
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 10:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202502; t=1740048672;
	bh=gkjIgJEVkr+P7QwxqKpisV6/73NE1KJ6/2gUZAf6iac=;
	h=Date:From:To:Subject:From;
	b=hKonaL5+3O07COfvxs5ktLj3UuEv7StUlBfhoVMmdbPlmdZurEzRvV+x0DMGVQbw/
	 YIOJy2rPJbeUseRtqoSBjL7DafXHz48V2Tf+++YR4jqtyvaWwC9+gRQFhFxYegRiVz
	 VwwPbQ744B50WkGpeM1a8aLByiJc7RSM47hVnRA5eDwGBnrP4riNb1/ynv9cteJ8o4
	 GZG3pNZhNFHF7+YhwLi1AWZjQNILa4pLIwKAj8zkSRcxbNCGqZs3gVFlFc1SbFwJ2C
	 fM/O16OekU/NS2FcPEZb6uC5k2jchAF58yYE49MYKEx4BdsCzi50e3gWDDLowHeu82
	 +Y1GS/kv05nyg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Yz96S5dg1z4wcm; Thu, 20 Feb 2025 21:51:12 +1100 (AEDT)
Date: Thu, 20 Feb 2025 21:51:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-nvme@lists.infradead.org
Subject: Intermittent init failure with KLEVV CRAS C910 4TB device
Message-ID: <Z7cJHFHqhy1Eidp2@zatzit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5sNRdAouIa3YkGne"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_025121_516745_B75CBE35 
X-CRM114-Status: GOOD (  17.27  )
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


--5sNRdAouIa3YkGne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to debug an intermittent failure to initialize the NVMe
driver with 4TB Klevv CRAS C910 M.2 NVMe SSDs.  These were very cheap
devices, so I'm guessing it's a hardware or firmware flaw, but I'm
hoping it will be possible to find a driver workaround.

I'm a kernel developer, but unfamiliar with the NVMe or storage
subsystems, I'm hoping someone here can help me debug this.

Approximately every second boot, the nvme driver fails to probe these
SSDs with the errors:

[   36.175032] nvme nvme2: Device not ready; aborting reset, CSTS=3D0x1
[   36.175032] nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1

Possibly salient observations:

 * Occurs both with a Debian distro kernel and a locally built
   v6.14-rc3-60-g6537cfb395f3 kernel
 * I have two identical devices (consecutive serial numbers)
 * I've only ever seen the failure at first probe, never a failure
   once the device is already probed and in use.  Once successfully
   booted, I was able to copy ~2.5T onto the devices without
   additional problems.
 * I'm currently booting from a  different NVMe drive of another brand
   & model, and I see the failures around one boot out of two
 * I was previously attempting to boot from these devices, and I hit
   the error nearly every boot.
 * When booting from these devices, GRUB didn't appear to have any
   trouble, leading to the odd situation of the kernel failing to see
   the disk it was loaded from.
 * The devices appear in lspcsi as:
01:00.0 Non-Volatile memory controller: Realtek Semiconductor Co., Ltd. RTS=
5772DL NVMe SSD Controller (DRAM-less) (rev 01)
02:00.0 Non-Volatile memory controller: Realtek Semiconductor Co., Ltd. RTS=
5772DL NVMe SSD Controller (DRAM-less) (rev 01)

I've made some instrumentation in my kernel and have discovered:

 * The failure always seems to occur in nvme_disable_ctrl() called
   from nvme_pci_configure_admin_queue().
 * We appear to be writing 0 to CC[EN] ok, but CSTS[RDY] is never
   cleared.
 * Increasing the timeout tenfold does not help
 * Enabling NVME_QUIRK_DELAY_BEFORE_CHK_RDY doesn't appear to change
   anything
    * Even if I also vastly increase NVME_QUIRK_DELAY_AMOUNT
 * Enabling NVME_QUIRK_QDEPTH_ONE doesn't appear to change anything
 * Adding a large msleep() before writing CC[EN]=3D0 doesn't seem to help

The devices also appear to have a bad NID (although only one of the 3
ids is non-unique, AFAICT).  Enabling NVME_QUIRK_BOGUS_NID works
around that problem, but doesn't appear to affect the probe problem.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--5sNRdAouIa3YkGne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAme3CRsACgkQzQJF27ox
2GekAw//YbuD1ClqI9yhEAnViM6nMniJBK2oteWAvRX4nI5D4a2BVR/MSiUp6aBs
3PcE8ab4uWncoCvlOTeSHlrB2GrX3hQuXMKb9RJsUCAi3VNQKvsWVA2OBmUJsNQn
VEug+04vbdUt39I/2hafI9T2iYTfXKguxzPp0OHAasrpAt+Nsg4zIKlIdCjm+JH5
bk7gmuCxWwcVAy9r7xY+zrqQbOtmLrZrV2S8oS4qJbpQbNaFcz9DFpan+gpg146p
XwnQ5fEMkQTJjH6w6tsnL4lmmscAuAQcD15IucldC1VFhZ/wucMtsdycUdLyzYXy
g+0Pz8LTpc/wjZ90DsqNlqQ18ljx9Rmrzy8KKbt0f9WnCmuMpDsazK7lSj9MSPt6
pGzeQuWKvIuHzn75GAFGQje8YJQ82dbKfwztQ+yo7AdKUpklg6ZzFYfraXSZqFGo
LGscEPJaTUczL+jwiVQM0+cHz6M/5vahHnzBmrOxcmivzsINfn2L1yAFCoZ6ythy
VJ9j+wZ1wXdCusEqPCZ3TWnBUanG9LjLYi6o7tn5pp/rLfxHN9bxEL1jPaKBGjYg
2rTkhtHN/bNET66tRcwlqVuHQH9kMtK3TZrKTxviCt2qCH0TEIK9nn1A22ZGCrvj
Gxdh/7r/owsMgc3799ZHWdpG0XBbzYfNiR2gVPV9ua2yPu9PY7s=
=5nv5
-----END PGP SIGNATURE-----

--5sNRdAouIa3YkGne--

