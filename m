Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31AEC5320E
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6q+DC9qEi4FRPHzOR4JhQ0nGEEP7YVA8G4HC6P+cUdg=; b=n5jRXRKUb2UE7zkxDUUuj2m063
	H0FM0VaPzCL2Ms8mfwL0tfTQyzR/Q+tYe6FaNGiMAd7uvXKRZ/RkILUp5yPRmHb6bkjWGHBEeFHxy
	wzAolRUeQSROttm+nAOOt0/OiXAlmn9q60F1BuMReIHXI9SHItGqK2KC65ukBKxB8QRKpavtH+6rc
	ERInKc+hdpDhNqRdJeI17A2t/PlsvzJ2fg8JQeBERbDfFrycPIycxwVWQXTynWupL/UN5k8o4+hm5
	qIhvcyEnQAMnAAbxC2le38GVBYemnhRMFfNU/pFTCklxn2un63s/D28birbSPONuqnuCJpHLRBB5m
	/9m+LTYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shx1P-00000002qmA-2VrG;
	Sat, 24 Aug 2024 20:06:03 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shx1L-00000002qld-33qE
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 20:06:02 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B2CB31F36F1;
	Sat, 24 Aug 2024 22:05:57 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724529958; bh=6q+DC9qEi4FRPHzOR4JhQ0nGEEP7YVA8G4HC6P+cUdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fR6UW6h84uQyCzzVZNSO0UWSzM5bGYLmY1G76UqvJUBOJXPzsISmYl/OWFY5HBXxV
	 MDkPHxv+1rabIGBdc8lw/KrqFnp/+ThasVMTP9xmaTAKfphiA5FYFaRYqZryLtfndw
	 4ovWnUZkv06IGKawoXxwJNia+R34Y4769D8oG3m/FOI55O0qbXjSJ/h67h7etOWn0M
	 v31Al/bNYDgPvfI/md3dxAMfx+MVdGYmt+hR7GQqe/Md97Rrv4aCWfr0lt57YdbqhO
	 RQdS3uf6P9OlV1AQFLcx67uZ9cQi+2nqE3iwduF6NypvU0JZ6jalCuhtKb0gsuCq6t
	 ah3J7uG9R0cog==
Date: Sat, 24 Aug 2024 22:05:56 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240824220556.0e2587d5@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240823084458.4394b401@meshulam.tesarici.cz>
	<SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_130559_963222_EFBD755A 
X-CRM114-Status: GOOD (  25.98  )
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

On Fri, 23 Aug 2024 20:40:16 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Thursday, August 22=
, 2024 11:45 PM
>[...]
> > > Discussion
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > * Since swiotlb isn't visible to device drivers, I've specifically
> > > named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
> > > something swiotlb specific. While this patch set consumes MAY_BLOCK
> > > only on the DMA direct path to do throttling in the swiotlb code,
> > > there might be other uses in the future outside of CoCo VMs, or
> > > perhaps on the IOMMU path. =20
> >=20
> > I once introduced a similar flag and called it MAY_SLEEP. I chose
> > MAY_SLEEP, because there is already a might_sleep() annotation, but I
> > don't have a strong opinion unless your semantics is supposed to be
> > different from might_sleep(). If it is, then I strongly prefer
> > MAY_BLOCK to prevent confusing the two. =20
>=20
> My intent is that the semantics are the same as might_sleep(). I
> vacillated between MAY_SLEEP and MAY_BLOCK. The kernel seems
> to treat "sleep" and "block" as equivalent, because blk-mq has
> the BLK_MQ_F_BLOCKING flag, and SCSI has the=20
> queuecommand_may_block flag that is translated to
> BLK_MQ_F_BLOCKING. So I settled on MAY_BLOCK, but as you
> point out, that's inconsistent with might_sleep(). Either way will
> be inconsistent somewhere, and I don't have a preference.

Fair enough. Let's stay with MAY_BLOCK then, so you don't have to
change it everywhere.

>[...]
> > > Open Topics
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. swiotlb allocations from Xen and the IOMMU code don't make use
> > > of throttling. This could be added if beneficial.
> > >
> > > 2. The throttling values are currently exposed and adjustable in
> > > /sys/kernel/debug/swiotlb. Should any of this be moved so it is
> > > visible even without CONFIG_DEBUG_FS? =20
> >=20
> > Yes. It should be possible to control the thresholds through
> > sysctl. =20
>=20
> Good point.  I was thinking about creating /sys/kernel/swiotlb, but
> sysctl is better.

That still leaves the question where it should go.

Under /proc/sys/kernel? Or should we make a /proc/sys/kernel/dma
subdirectory to make room for more dma-related controls?

Petr T

