Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB8CCD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 05:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QBkGS6uM9TgbkM2B7X/tE/A3u+1j2Zx3NteG5KnypJ0=; b=JxvjdqhQWWz2LZt4dRa1CiSakX
	/gyaCakmUL2eKd6gtOHES0dok9TRoGj/ZvjsFaTqny3/rvltOgK1EX8ZhhfMn910qyi2SzuK9DW4n
	DcxndFViCrjXjddqirl4XnWrszHIlUrZpV6TFxEXeqcyP9YKyujB/+/CYiBN3ScCGSdcG7ShgICJE
	RdYBpPGePhkeYz7ccjbO/K9M3KurJSJRr8FaT+LjVBFjtUIJfKE6fBXV22o9dN4029kjjL3Fvw2DN
	cOM4WGqApZx5vERWryJxtdTUQ/aFG1mSZgeUsnrqTlagq0UsorOqtqBMR/cdRtY8Sga1qSouLjBnW
	Z9aA9m8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkij-00000007MpX-33gB;
	Fri, 15 May 2026 05:04:21 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkih-00000007Mou-1UiP
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 05:04:20 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-bd373f83042so541140266b.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 22:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778821457; cv=none;
        d=google.com; s=arc-20240605;
        b=fKdcK2gb0vBoQ86GnuIhjiVYDaMdQ+kvIifQD0cfHZ3GhaqXRiKpGgK27jC6SYf1Or
         pc5YUuOdBsk6fiYPyaC59hROLmGIB9+yX3BuRZav0DWN4Lnofkqhu3wRn5Ejrc/I9dIy
         YHDosuRZIldtTG+yyF8Guq061vh3aoPwghT8wo1aa9LhabTzIgShxuhAQIDMp7EOo5l7
         gNYpSuDGkBT9AhEj7Yyc6DzfY8xkOYFGilcqex+tN2HeS5R1m2ZJm2ADPRoKB2DrChIL
         1pf+4V/UoyJWgRPqZMxI6NXVHKGcotPRe2tdr2dXeF0BKylg85NOr5KPqrZNmH2YCpeZ
         aSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QBkGS6uM9TgbkM2B7X/tE/A3u+1j2Zx3NteG5KnypJ0=;
        fh=cDUQ9FMkjCZo44XF1ifU3FnJWbtri5hQbQaPe2GRtxc=;
        b=cqQITCBoCzd2zcaeUPQOvLwBhMPAcPoKxOXDodkPcKuLbBLZL64e2Bkt0snXrTqxAT
         fpSelPLZ0Tfx8sZPtL62PgYPLWfETCTbp+ajqrFvV+bE4vmDEsAvwBTkQgeiBUyOqaVE
         9StktY16nugPkbuKH8Sjk84kY9V0eG/iRMJAM+fXWkc2PHXHf8C8aO3JJz1HyT9izvZj
         aEaLQagqgQOmf0Zkm9cOPY36LWBQofD58FUXcP7Q74vO/2tIFPxrtNJJUaL1uKqxzycS
         Ttqk2y910LAObEkc+r0k+SVmaPb/ioxr9c3ikmS1cGLVtkYZ2D3sdAEQvWWIQX84dZCe
         fiNQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821457; x=1779426257; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBkGS6uM9TgbkM2B7X/tE/A3u+1j2Zx3NteG5KnypJ0=;
        b=f1OpPnjNdoHKoDja8al6zZBti/VcPICE91HOvk4sImX5WxKM+C5bKH+kiT3Z0e9nPB
         9o1cCvfQtqbPAjfWCSJbxbwLgxlHfC4g/B4+es4P7lPkaqZmhQpJGs8F2kr1Y9yYQV7o
         qrXh9WQ3fqOYUIQbHLDnENM/rLv/DZN+85fsblVLe8gY6AASY0yYLsixUHt1ArVRcf+e
         XyRclOs8gBzjQ6Oa28I6fdWim55R55pnH3uVIHFk+t2hPo/iRSn/EfeLB1LFPDPRqs1K
         oc2m1Wq1EHxhlW3SDYosvYpKUwpq1n2X8WP7P8LFFuq8egXMvUMfxzMD2KNmSM2Bpl8e
         glEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821457; x=1779426257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBkGS6uM9TgbkM2B7X/tE/A3u+1j2Zx3NteG5KnypJ0=;
        b=le0HY38dRS9XZIzlSO+dVf0r/xASCWCc5ogRHcvbcNQODfXiLzAjbnLm/Edg/TJ2Fp
         a61nfRBNxUpHHrpufJKoTB0pHvQZC1cG5NWvmeJsR5oUsIzfPlU1I5IP9ZXxICH11N+3
         V5rS+pJYXlknSBX94Xuzmz7BPE2Tb09aPNdE5/xfh1/HyTmf+x7hYqZ1e9+3xHjFz0SA
         j9w7DvgHQR9GwXH7xYI5bSW1cSXIpEJcyjtKW0ZuBZw+jMY3UVIvSlC8Fnwltun5Zbwc
         HjWZog+5CGiOM2t23q+LwKBPt//i3/hygzTGXFudVls0Vj58nCx3glhffARYkdQj+EBa
         wwgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9w+NjCNoeuCZTeKoK72aNuxb+Ygb4qcV8CaOcE4IFtX28B3kuoMFu55rUzrv6uBAX51UkQbjrASU/R@lists.infradead.org
X-Gm-Message-State: AOJu0YwrFQABUJpOq8PTQ2+39uJrw4e2PiDoG/DzjKPO24ilLokK90Ec
	NJiAmyf5sTrMWQbAZAOJfqjxTi4RRAXX5kte8uA3E6sm/yeepmNSVf47kRAac/MUH6QvOXhwFnq
	cN6qz/97yGtF9nD0kgHn6AUsrtLU+Rpo=
X-Gm-Gg: Acq92OHs4ksxBLj1B2vpj6a2EIPmx/ZdQfJnJegZ/HAzRZ74i0iYsfpuY0g6IAbzpZs
	5g0C7cjfPnelA7mV+YPei5mCufQIo6dgLO8A2cnbQUTF4gZwWt/6q+5Kd2bkZTDAonCvasLNqiE
	3mbi0ZdZNvV+0H1OuYPgsZMvnaD7X0GzJwhuOu2ay/GcE9UI9z+sPu6Tumj8UJmqxVZPMuYJDAI
	DjY81Ht/z+O0VoirXKFNUxNdb+myUE2k31Z7EmgzExX21vGlEc903FK0LDMwGLs6arz6A18hDbx
	FQXuWLBfhD48hvzKLSA=
X-Received: by 2002:a17:907:5c6:b0:bd4:f598:cc3d with SMTP id
 a640c23a62f3a-bd517ab0e92mr105047866b.41.1778821457071; Thu, 14 May 2026
 22:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260428022911.1288485-1-coshi036@gmail.com> <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu> <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
 <20260508090427.GA20593@lst.de>
In-Reply-To: <20260508090427.GA20593@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 01:04:05 -0400
X-Gm-Features: AVHnY4J1515o6HCPVFX3gLUloCgbMv-6usf9vtHTU91Rj1TY_uP_p-Kla2idlkg
Message-ID: <CACd_6n3Ob8=uSo4jNT0b3dZoj_+Kn50PgXhXwr0Dr88rEkO0mg@mail.gmail.com>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Jens Axboe <axboe@kernel.dk>, Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_220419_412488_785C9500 
X-CRM114-Status: GOOD (  19.15  )
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

On Fri, May 8, 2026, Christoph Hellwig wrote:
> My memories from the fabrics working group back in the day is that
> we explicitly intended to support it in PCIe.  The wording in the
> spec referring to transport specs I can find is:
>
> The NVMe Transport binding specification for the associated NVMe
> Transport defines:
>
>  o the minimum Keep Alive Timeout value, if any;
>  o the maximum Keep Alive Timeout value, if any; and
>  o if the Keep Alive Timer feature is required to be supported and
>    enabled.
>
> which does not read to me like there is any required language in
> the transport spec to require keep alive.

Thanks for recalling the working-group history and the spec citation - both
will appear in the v2 commit message.  "PCIe MAY support KATO,
not required" will be the foundation for v2's frame.

Chao


On Fri, May 8, 2026 at 5:04=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
> > > This field specifies the timeout value for the Keep Alive feature in
> > > milliseconds.  [...]
> > > The default value for this field is 0h for NVMe transports that do no=
t require use of the Keep Alive
> > > feature (e.g., NVMe over PCIe). For NVMe transports that require use =
of the Keep Alive feature
> > > (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> > >
> > > To me, it sounds like for nvme-pci, keep alive isn't required, but co=
uld
> > > be activated.
> >
> > The spec says the support is subject to the Transport binding
> > specification, which does not exist in the PCIe transport spec.
>
> My memories from the fabrics working group back in the day is that we
> explicitly intended to support it in PCIe.  The wording in the spec
> referring to transport specs I can find is:
>
> The NVMe Transport binding specification for the associated NVMe Transpor=
t
> defines:
>
>  o the minimum Keep Alive Timeout value, if any;
>  o the maximum Keep Alive Timeout value, if any; and
>  o if the Keep Alive Timer feature is required to be supported and enable=
d.
>
> which does not read to me like there is any required language in the
> transport spec to require keep alive.

