Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E36C7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYoTCikiF3mOWbHSKg9CxNJmBT0oqbo7zNZegpHWbfA=; b=BmrKSiPZAUs1y4BoHiRM1Djgbs
	Fcdn+xbZYpMIZAM+b7hTjX3NxnBSEEH/ISVa2MUfUrn5TOl9c3EdfdhCZriSf+9JcDVBVzLMAuYJF
	S9ekHVNbn7RVUGKbp5x4lDvUk3dLIvyo6WKHiCOGmlUXrOo0UuF8YFRy44cSlqdmFM4KnbOrZ6jZW
	8mYGx1sO8CpXksV5NhYkM63Fvqixi9BRl+2LHYt9puaEecpQl9xCzzfUVcUY6wHjhxh4CSoodUuIa
	mx9j4u3WXVezpdpTHEhlR1qE9LuyWcE7l/DSac9nh232VrvkXc6Vo6+TbHuMSH2Oje9rLjRAK8NZt
	PDeMNwIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJi8-00000007fk1-2M1M;
	Wed, 25 Jun 2025 06:34:20 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJi5-00000007fic-2w1I
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:34:18 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1217914a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Jun 2025 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750833256; x=1751438056; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYoTCikiF3mOWbHSKg9CxNJmBT0oqbo7zNZegpHWbfA=;
        b=TJ0VGo3lJyCOU7bKidSlTlW0JpEG6O9f3ISdHx3B8UPQ7hYP0BUPicv7fPdDiPxtBE
         DPItrv6Kb4jp6s05wHPboG6fleZFm0sUCq0MUxJFOkh+5KVqVHh5KVwZRyCu001St8zG
         wYrEQzdzwhJyMFFfEeDFV5RStmy/03RRnNC7QoIO0FyzgRnHdy/C+AX7KPbj/hormDcy
         3zz1decF9DCmfkOLDFWtq+CpZ8805eN/TMPIh3zj8CvcyLx/bsM4aoTWDB74L1GlqvRT
         0Z2dj2m9nArdM215WzYWNRqwKvbrlfzzA/ExGaas60hehb8KTGSOXMJeKHiZqH2HLVA1
         IRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750833256; x=1751438056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYoTCikiF3mOWbHSKg9CxNJmBT0oqbo7zNZegpHWbfA=;
        b=W5EJL/aJAkhlLv6STWNkFxK0gIN4ehhGIP95YCK8Ap3LSPzj8qTjGee/get/Nbv0K0
         CX6yPf31lV+BYA6bckoivmsecSNWz3PWSJ8BeYVpX9yKhcoaqPp3BJnFXEyTW92TjgXz
         J5iEHigTnc7fx1lFALUMC+hXGlj1PPjOITD1deZ4Uolp/FuXKiHqIcOxr81mbJs2cOO/
         u9w+oNfp6L7Xu5zo+Cg7K9Ko0Az3C2WxSVEVgpxEW2VHFFF1ZEDh65bDKgtU7Z9Gfyk2
         ocfJGo9EA6Cs3TpPWJE7KfTRw4R0ZCjyZZ15fT5R/oKpqcPt2eIMVQVVnrpTgW7Jbuh8
         bPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcIJsqOq5XZAJZVwsu8SqyGAkIIkOGyzGA9nuEjaJ3NFvHGAnCUT5JASfjTcJ54ACGn5ADK4l5/37b@lists.infradead.org
X-Gm-Message-State: AOJu0YxmOWsBWnSQTNJEq7QJOr7xDLfD0tU/Q5yTtC8NDJoyOhFhLxzi
	bNGOPf6aK2phqBwQiD4UqL/RcG/nX4JoXF3LjLgUHE43ebUNAlk53Bwl
X-Gm-Gg: ASbGncsIojnKLglluHdAPeRTeZiHrm50Wn9e9arlGeEzArxorn6EjW67dOVkKPvI5ro
	k5AydEs4+XoIiMbkqMukrImAx9lQrkdz53FMnqqZ0K2c4zzYmOvhCWQ3fVhnUnzPw86JygZBBJl
	+zTX61fuAMH0cFpAW0KYtC4YD2t/m2BdOU57qFWdIfTMf8ZctVWLmKpjr+M9w29GOuZrbqSc2GP
	+/HjAhpF5ZbKHxGerYTPW2CQefTxsg3plyvJ9+yR8k0/8IFyvxFpgyl32I2gFxQi2CyKtuwV64s
	VQ7kcBxy3UfpoWH++kpwG1nU5nt8Hi7VC2AqqrM9luiqE7i3+Fq1VclW1CfAvg==
X-Google-Smtp-Source: AGHT+IFZKk8R5zsCq3X62KXZ4uowJyvTYfVGUn7HH/IVWXAWOCIlMIUoGwCzkX3BD8hp2z8zFAXlRA==
X-Received: by 2002:a17:90b:2ed0:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-315f25c9b3fmr2804456a91.7.1750833256160;
        Tue, 24 Jun 2025 23:34:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53bdbf4sm967119a91.22.2025.06.24.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 23:34:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E4D274207D12; Wed, 25 Jun 2025 13:34:11 +0700 (WIB)
Date: Wed, 25 Jun 2025 13:34:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
	rdunlap@infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] docs: nvme: fix grammar in
 nvme-pci-endpoint-target.rst
Message-ID: <aFuYYwceVvdc896_@archie.me>
References: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
 <20250625041643.174110-6-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K9CDCDqAKhwmhjDL"
Content-Disposition: inline
In-Reply-To: <20250625041643.174110-6-alok.a.tiwari@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_233417_739404_2609F843 
X-CRM114-Status: GOOD (  24.68  )
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


--K9CDCDqAKhwmhjDL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 09:16:34PM -0700, Alok Tiwari wrote:
> diff --git a/Documentation/nvme/nvme-pci-endpoint-target.rst b/Documentat=
ion/nvme/nvme-pci-endpoint-target.rst
> index b699595d1762b..2f75c8a267de5 100644
> --- a/Documentation/nvme/nvme-pci-endpoint-target.rst
> +++ b/Documentation/nvme/nvme-pci-endpoint-target.rst
> @@ -6,20 +6,20 @@ NVMe PCI Endpoint Function Target
> =20
>  :Author: Damien Le Moal <dlemoal@kernel.org>
> =20
> -The NVMe PCI endpoint function target driver implements a NVMe PCIe cont=
roller
> -using a NVMe fabrics target controller configured with the PCI transport=
 type.
> +The NVMe PCI endpoint function target driver implements an NVMe PCIe con=
troller
> +using an NVMe fabrics target controller configured with the PCI transpor=
t type.
> =20
>  Overview
>  =3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The NVMe PCI endpoint function target driver allows exposing a NVMe targ=
et
> +The NVMe PCI endpoint function target driver allows exposing an NVMe tar=
get
>  controller over a PCIe link, thus implementing an NVMe PCIe device simil=
ar to a
>  regular M.2 SSD. The target controller is created in the same manner as =
when
>  using NVMe over fabrics: the controller represents the interface to an N=
VMe
>  subsystem using a port. The port transfer type must be configured to be
>  "pci". The subsystem can be configured to have namespaces backed by regu=
lar
>  files or block devices, or can use NVMe passthrough to expose to the PCI=
 host an
> -existing physical NVMe device or a NVMe fabrics host controller (e.g. a =
NVMe TCP
> +existing physical NVMe device or an NVMe fabrics host controller (e.g. a=
 NVMe TCP
>  host controller).
> =20
>  The NVMe PCI endpoint function target driver relies as much as possible =
on the
> @@ -181,10 +181,10 @@ Creating an NVMe endpoint device is a two step proc=
ess. First, an NVMe target
>  subsystem and port must be defined. Second, the NVMe PCI endpoint device=
 must
>  be setup and bound to the subsystem and port created.
> =20
> -Creating a NVMe Subsystem and Port
> -----------------------------------
> +Creating an NVMe Subsystem and Port
> +-----------------------------------
> =20
> -Details about how to configure a NVMe target subsystem and port are outs=
ide the
> +Details about how to configure an NVMe target subsystem and port are out=
side the
>  scope of this document. The following only provides a simple example of =
a port
>  and subsystem with a single namespace backed by a null_blk device.
> =20
> @@ -234,8 +234,8 @@ Finally, create the target port and link it to the su=
bsystem::
>          # ln -s /sys/kernel/config/nvmet/subsystems/nvmepf.0.nqn \
>                  /sys/kernel/config/nvmet/ports/1/subsystems/nvmepf.0.nqn
> =20
> -Creating a NVMe PCI Endpoint Device
> ------------------------------------
> +Creating an NVMe PCI Endpoint Device
> +------------------------------------
> =20
>  With the NVMe target subsystem and port ready for use, the NVMe PCI endp=
oint
>  device can now be created and enabled. The NVMe PCI endpoint target driv=
er
> @@ -303,7 +303,7 @@ device controller::
> =20
>          nvmet_pci_epf nvmet_pci_epf.0: Enabling controller
> =20
> -On the host side, the NVMe PCI endpoint function target device will is
> +On the host side, the NVMe PCI endpoint function target device is
>  discoverable as a PCI device, with the vendor ID and device ID as config=
ured::
> =20
>          # lspci -n

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--K9CDCDqAKhwmhjDL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFuYYwAKCRD2uYlJVVFO
o+PHAQCE+vUOXn1bwzmLgPVFqN1ctK+E0hBGYsbXnSjp1YwkaQD/VheYmW0A5xSG
N42MKwkgxkBAeH0q5RtTr7GF1IFBgw4=
=vspR
-----END PGP SIGNATURE-----

--K9CDCDqAKhwmhjDL--

