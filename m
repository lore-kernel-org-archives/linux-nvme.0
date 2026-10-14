Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19272CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Mime-Version:Subject:To:Content-Transfer-Encoding:Message-Id:Date:
	Content-Type:From:Cc:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TY/xSqncSuEedRGyadYwHJ/EqM8rGORcOlBn4Wx3l6U=; b=fbD8KOuzZ6GBItVN4/wH4AFPQ3
	qIQR1Q01QMDfepN+1sHRXhAcOaXRYhp8A4xr8FYm6L0dUCu4BOcOCxf/qR1oohppPHO5IVVdL2F40
	4LbYM0HViP454RvimZC6HcL4MTiC6Y85MnnVE4wp/vbvWIb51Cx5gC6ikDywRkPLiRnmqxqwA0EnK
	1HhKpd2IGpSremAdBeDEBP5ac4v0SUPXv3RdfHF4+0Fbzjy1J29qgCDjYJ88M09vp/3RDitZOvyaa
	9JwqUvNOgkRiHk7OZu95pK6YAaTUcmGboZgFfP2EaY10jx/D5+JzdWfYEPnf14esSlIHy/m+YkYYh
	FqLv+yjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGttg-0000000EpyT-1fmg;
	Wed, 14 Oct 2026 07:59:36 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGttY-0000000Epwy-3bZR
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791964754; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TY/xSqncSuEedRGyadYwHJ/EqM8rGORcOlBn4Wx3l6U=;
 b=j1JWBXs4ix3DWSJBtPB1kvoZVhv+xgllKPKGq8caK3GTDgvuvvTvAYNXXyIdOR7xJ9iO/Q
 r2geFt1keIoOEXKDU334NVl2K0LZyVgFmr4mvpvvDmxKQD02FR7GsGofXuE0aDkP9s1jnr
 Fszd4PJwbtp6rlNSdU/O8s1G2GCPtPJf9DHEud+/yv69AwMu72QvHYRpI6sQcL7smcj+Q9
 dfm+THL9TePwdezhaTjc7oR1tJBFk+WBHKAlQpJJzEkVIPW/7g9YzKse8wgVL4se+Np7pN
 EJHaSCwILX7HdXeNcfI46KnQraAogtcDex2FggGnBXwAVzN4NX0az4oGEbAZEg==
Cc: <hch@lst.de>, <linux-pci@vger.kernel.org>, <tglx@kernel.org>, 
	<namjain@linux.microsoft.com>, "Keith Busch" <kbusch@kernel.org>
From: "Fengnan" <changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 15:58:57 +0800
X-Lms-Return-Path: <lba+26acf3650+b28434+lists.infradead.org+changfengnan@bytedance.com>
User-Agent: Mozilla Thunderbird
Message-Id: <5613ca2a-c8c7-4418-b792-5d7ddc903960@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Fengnan <changfengnan@bytedance.com>
To: "Keith Busch" <kbusch@meta.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Mime-Version: 1.0
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_005928_972429_A5F35C2E 
X-CRM114-Status: GOOD (  16.83  )
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

Hi Keith:

I ran some quick tests using your patch on the PS1010 and SN861.=20
For 4K random reads with QD=3D8, both drives showed a performance drop
of about 19%.=20
With QD=3D64/128, there was an improvement of roughly 10=E2=80=9320%.

I think the reason is that the current logic still relies on the QD
depth to determine whether to switch, but a high QD doesn't necessarily
mean that using the poll mode will be more efficient.

As for DIM, I tried using it based on my V2 patch, but the result was
that I either had to add several new DIM functions to perform similar
checks, or I still ended up with a performance regression.

Here is detail data=20
https://docs.google.com/spreadsheets/d/1VOR0xB5yk-z6IMwwRvp8R0yd4k_tMi_wI27=
Pl-dEQVg/edit?gid=3D789521759#gid=3D789521759

Based on the results, it doesn=E2=80=99t perform as well as my previous pat=
ch=EF=BC=9A
https://docs.google.com/spreadsheets/d/1rer4Nl5HHxSO-D3NrrHuHSfpR9s1kLhpLjz=
h7h7Mbmw/edit?gid=3D875909538#gid=3D875909538



=E5=9C=A8 2026/10/14 06:35, Keith Busch =E5=86=99=E9=81=93:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Just adding another nvme hybrid interrupt and polling mechanism to the
> lists. There's some recent alternatives mentioned in the links below,
> but I'm trying one last time to leverage the DIM framework. Performance
> wise, this at least doesn't seem any worse than anything else proposed,
> though I've only been able to test on mid-level hardware so far.
>=20
> This one here as some irq prep patches that help some when transitioning
> from irq to polling for MSI-x enabled NVMe completions. These should be
> generally applicable, so isn't necessarily tied to how it gets used in
> the last patch if someone else finds it useful too.
>=20
> Links:
>=20
>   [1] https://lore.kernel.org/linux-nvme/20261009050556.2817978-1-namjain=
@linux.microsoft.com/
>=20
>   [2] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfeng=
nan@bytedance.com/
>=20
> Keith Busch (3):
>   genirq: Add disable_irq_nowait()
>   PCI/MSI: Implement irq_mask_nowait() for MSI-X
>   nvme-pci: hybrid irq+polling
>=20
>  drivers/irqchip/irq-msi-lib.c |   1 +
>  drivers/nvme/host/Kconfig     |   2 +
>  drivers/nvme/host/pci.c       | 624 ++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/trace.c     |   1 +
>  drivers/nvme/host/trace.h     |  26 ++
>  drivers/pci/msi/irqdomain.c   |   6 +
>  drivers/pci/msi/msi.h         |   8 +-
>  include/linux/interrupt.h     |   1 +
>  include/linux/irq.h           |   4 +
>  kernel/irq/chip.c             |  31 ++
>  kernel/irq/internals.h        |   1 +
>  kernel/irq/manage.c           |  21 ++
>  12 files changed, 698 insertions(+), 28 deletions(-)
>

