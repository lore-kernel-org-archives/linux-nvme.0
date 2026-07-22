Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43894C4452D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Mime-Version:
	From:Cc:Message-Id:Content-Transfer-Encoding:In-Reply-To:References:Subject:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0looZ9aon4cGCkg0z4IHJEYlanw6R6RXQv4CamlhTEc=; b=N9/v6ZA+1WoP+gfyZAkPq87hkH
	s1PVI/fVg69wZj0NGWZWdwbxdX2u1bx4YkqUYKyEQhjmHKvGwXJ57Spt5ufKZV4l0qiSQLUFlVceT
	q172UoLlvufmy5A9RgWj+8pzeEndzTdpCFyQuKmEnuJfVQz04Ff7CfyrIA9C0fo49v9XpKIkVNt6X
	W0bVWJpOc9yDxz0PcaJpDH08X9ELczDZMMXDZzpVkPUkmU9LAeJIU/SnCFQX1oN2punNdULjpXi+1
	caifMRPXF7SIxAEASHPaWAJ2+uuWwfH2yXROhLYhT8ySygTLFdgvAlVdytSgABP5hPehm5kxNuXJn
	EEjuqD/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmMbJ-0000000AkOV-3fIJ;
	Wed, 22 Jul 2026 02:22:25 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmMbH-0000000AkNx-2JjZ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 02:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784686936; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0looZ9aon4cGCkg0z4IHJEYlanw6R6RXQv4CamlhTEc=;
 b=QRE3wsss5iCvsJ7e4AEF8CgAXW9i/BVmxwcE3S+FQlg35n3bkxyF17ELVL2U6xM4ydVda/
 I5LRb9+7JC3SMSj1G9z2IzuaDq5h8soxboUAJ6SYi6T/V12JzxdfO2c4p0d1TPRozgUgzk
 uNWjYiJ9Eg6gmWBwkyWWpdv/AwZDHkVaqAhNn/U3Mzc7cZIMmbPPsvtbbAWcEUmx2OPsT9
 /B0JzGKCNe5Qy+RiTePpBA1OJx1WFMG118+YJtFXRwI6+cuZvyPACEnDiBQyx9XwH2oeEt
 dMhxMu9kK9gVzCdcCW5e3protgcD0PirVG+Z8nHEnxHlPx86pd5PHVmESHjGlA==
Date: Wed, 22 Jul 2026 10:22:11 +0800
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>, 
	"axboe" <axboe@kernel.dk>, "sagi" <sagi@grimberg.me>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
References: <20260715075703.15578-1-jun1.zeng@intel.com> <20260715075703.15578-2-jun1.zeng@intel.com> <allEmTmXCFosxIOr@kbusch-mbp> <20260720150539.GB17986@lst.de> <20260721083739.69676-1-changfengnan@bytedance.com>
	<al-MJGguFULZhYDO@kbusch-mbp>
In-Reply-To: <al-MJGguFULZhYDO@kbusch-mbp>
Content-Transfer-Encoding: quoted-printable
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.1b934443.ec75.4a64.b2bc.6f822eb9e4bb@bytedance.com>
Cc: "andriy.shevchenko" <andriy.shevchenko@intel.com>, 
	"gang.cao" <gang.cao@intel.com>, "jun.i.jin" <jun.i.jin@intel.com>, 
	"jun1.zeng" <jun1.zeng@intel.com>, 
	"liang.a.fang" <liang.a.fang@intel.com>, 
	"linux-kernel" <linux-kernel@vger.kernel.org>, 
	"linux-nvme" <linux-nvme@lists.infradead.org>, "tglx" <tglx@kernel.org>, 
	"yong.hu" <yong.hu@intel.com>, <guzebing@bytedance.com>
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a602956+83e1b2+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_192223_839684_304E3096 
X-CRM114-Status: GOOD (  12.42  )
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


> From: "Keith Busch"<kbusch@kernel.org>
> Date:=C2=A0 Tue, Jul 21, 2026, 23:11
> Subject:=C2=A0 Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: <hch@lst.de>, <andriy.shevchenko@intel.com>, <axboe@kernel.dk>, <gang=
.cao@intel.com>, <jun.i.jin@intel.com>, <jun1.zeng@intel.com>, <liang.a.fan=
g@intel.com>, <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.o=
rg>, <sagi@grimberg.me>, <tglx@kernel.org>, <yong.hu@intel.com>, <guzebing@=
bytedance.com>
> On Tue, Jul 21, 2026 at 04:37:39PM +0800, Fengnan Chang wrote:
> > @@ -1618,6 +1748,8 @@ static inline bool nvme_poll_cq(struct nvme_queue=
 *nvmeq,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cq=
e requires a full read memory barrier
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_rmb()=
;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sq_head)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*sq_head =3D le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].sq_head)=
;
>=C2=A0
> This is the wrong criteria to determine the outstanding depth. The spec
> allows the controller to move this forward after it has read an entry.
> The commands may still be in progress, so the depth of future
> completions to expect can't depend on this value.
>=C2=A0
> But in general, I agree with the spirit of where this is going.

Thanks for your feedback.=C2=A0 I=E2=80=99d like to hear more opinions from=
 others.=C2=A0
If this is the right direction, I=E2=80=99ll continue to improve this patch=
.

Hi Jens, Christoph, Sagi:=C2=A0
what do you think?

Thanks.
Fengnan.

>=C2=A0
> For MSI, you can make use of the INTMS/INTMC NVMe registers to make this
> even more efficient. Your patch disables the irq at the cpU level, but
> the device is still emitting those messages for no reason.
>=C2=A0

