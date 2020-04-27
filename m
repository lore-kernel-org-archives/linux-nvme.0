Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C05C4CECD
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890DB214AF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6UA7bAb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U1fwagw+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SnNF8Dr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890DB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZF6vFSE/Uu37wIDrf+5dyeiVqp8mJV7OQTsBg3nNbyE=; b=O6UA7bAb73H7Zl
	aqQkVYJyXThkuTPXfmph1xci6Zuwe8+FC5YvC30Bkn1cGdh5H02V8QrsSsdLpf2P5O7OIwfQk9dJD
	U4dAQSroqpcigN41AmYtcRy19IAA9xPcRpk9zgKRjRmwm8l4bziCzVIRAeVsAKK02GXlm3GL8BPdi
	f1fLXlKo8igGEn/kNQuOas6tJH+nrCQOA9TlAcZrlWGund0WW7NIeNEpwgs4v9deDUe5I39b4O3R+
	/VPrr8F5naLo3Th5uiSxVpzeoMVumj0dQd+CcoZw64uEzcyMaE9BrTUy/1NriWbzFXqed/NwiZDbf
	VW6dqpSFqvr3RHJCCjyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT8P6-0005L2-IG; Mon, 27 Apr 2020 18:22:52 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT8P3-0005I3-RU
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 18:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588011770; x=1619547770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=egnvTXsuIzziGDuyhitbj1+y1J2wsq8mH1Uoh4xdtWM=;
 b=U1fwagw+PiZST0/QcBLWxdoQYr6atwDBxAPQonjmAy78X1oNm95Ha9C3
 STrpZsanHP+9EdfGyGok0jZ0U4C3NmVG01Pc6u92HQ3Xpn1ztweSF6R5E
 iA0jEa4arpLvtcxnkbcr2aK0tjnOak5nCtPYPa2WFx+pOcjK923geOSNi
 FDBb/LDtH0Lqx999NiuBvWvUS9a98DOqOJ4jOpsZrpdv1KycPPLqhLTLT
 OLej16MqLJod6Gbl5BM9vXwImshq+68W3jO/LLolZiEUhFTk/dI7TtDrt
 gAAGHGixNcGtocNxlBGkHCUtvV7HblfsfR2QzCm+YhGo+ymgOq7ZPY4kL g==;
IronPort-SDR: 2VtzdZOvhL4iSaU9dh16WtFzCb+IdjinHHZX6qvsAGudmSAyEpR3Do2ppPU34Lw7fs0QU5AFN8
 0D993AKMHa35J28y08MrMTOGcy1t6nAXodPluHwP12Zxo8lY10zUiXptc9UcJJnJbEeU88BZ9k
 ml1sHeA8LQ7iPDAtsqXubNxnsG4x3SX2ldo5s57Qj1hS2iaqyH+55dlaaw9abPK/9pZAcFtqmb
 QecVf3VqrTNGXbbdPA6ePvMhprHCW5ZC8+JJUrbRScWtC74zryFXA6ogKkYFtFstd4l7EyrsN0
 8qY=
X-IronPort-AV: E=Sophos;i="5.73,325,1583164800"; d="scan'208";a="136584561"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 02:22:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho71buUmdq07O9qOQrg9Kw5nOVtmpO2wQGHOog+qModJUMTwXPvTLo1SRq7W7qsfwiSgrB/enAmuA/LMk3GHi4kfrwHoKgzTv0fl8Q0Mxlm38yMbWxS1hgLold3IWK241J6RJG9Cn2ZrlviUjkQwVC7vA9LhYkOIej2Pnai2a/GP30AMXn8J/zL68Fyyl32BDKxx5Z1m9/Bz5caYZ0or0ZD2sSzHFjS27TtPvk2xngrjFkHUZt3uJsxLbdVx67cxVC4aXgWyPmRQ0Elk5pGizF8UuiRoN/ZOKtWwvoTkIhVcMzVaeTWEZbcoammFTRlqeUCVAHmt7/bCBA1Xj8tuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u107N/75NFyHmgk2EAOtxJiANwRsmRS9+cirqK7OOOA=;
 b=HiZPWG9nDHFB3ABj0qCM2T+H/aY61Vc7gI6hcyaWg5XF7uxY9PaGwdbQ+9rkfJ0J0oEMg9BgjkCguYCUDmC6jG2ENDbl9MP9+OQkbM9lhvSsWdVyYPX9g5HCs2AOZXVCAPevCI2TTIEcBbI90vYppT7dbCBv7+7/cYi/6XN1FqqLscPdrHi6/FLzlSWcE9GWB9NbswQ6wPrUB5dpX5MinZlqgSaG53fWE7s0Tzf1yEAjMfPSe8hTpyZxA151jbEzAw68HHjEsd2WRT92hnSw7qckgmnM74sIR4tGxr4mMloxEx9QuKX/dZKQKqctfO4iaMyNlkAiUtIgmFwCZqQAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u107N/75NFyHmgk2EAOtxJiANwRsmRS9+cirqK7OOOA=;
 b=SnNF8Dr2Wt/+gV77vxfDXYjt1oXD7JvUIsXO6vw8hgSwpK6GRuLmw8QDwN1G+q+SGJeoR9XLD4z8G/eG2KdKjfISh1lgtxAFx9Q/PIcYYAse7kzVi4aS26RMtL4dnoWUqmzN5JbV3JWtZR5MGwdfl73//qrQoC6vPIv8awZqQ5g=
Received: from BYAPR04MB5015.namprd04.prod.outlook.com (2603:10b6:a03:47::33)
 by BYAPR04MB3862.namprd04.prod.outlook.com (2603:10b6:a02:ad::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 18:22:46 +0000
Received: from BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076]) by BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 18:22:46 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Thread-Topic: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Thread-Index: AQHWHJBF5J2JgQiUdUSwnibdYIeruaiNQxmAgAAFd4A=
Date: Mon, 27 Apr 2020 18:22:46 +0000
Message-ID: <20200427182245.GA547726@localhost.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
In-Reply-To: <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Niklas.Cassel@wdc.com; 
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 271aa722-a0fb-4a2e-994e-08d7ead7fc25
x-ms-traffictypediagnostic: BYAPR04MB3862:
x-microsoft-antispam-prvs: <BYAPR04MB3862EB3BA10020F0FF5C191EF2AF0@BYAPR04MB3862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5015.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(4326008)(71200400001)(1076003)(2906002)(66574012)(478600001)(5660300002)(6916009)(8676002)(33656002)(7416002)(86362001)(66476007)(64756008)(9686003)(6486002)(186003)(26005)(6512007)(91956017)(66446008)(316002)(66946007)(66556008)(54906003)(6506007)(8936002)(81156014)(76116006)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Xu1KxKX9Em1OGDDXRX5AXBmp0zk2bhfpIiDCIywKVXah1ds/ZOKWxGhELZ7jwx13J2iOWowj9QPnKk63aNNXuHgH5PNaBpLljWTR8upB8S/f/sZIuWQLpt/0kreSaat7rieQtzhTwXKdLrrbaRyFmduIclIwT6voyEzKdDGBf3//lw+UJH2rZri8OD3kxHfFxXtbdM2i32OBv2g4UNM64vhwDM+iLflkeuN5Bq/vPAmDJvBA/1zadBZkFUmtcmEh8EnXq9RC2fTAEyMqY/zEqgLLBuLoCqQeQKs0fipdTyrhp43QLvu9NKKIB56DzG7/0HI9rNg0PTimtgynjQtozHrw1UuC3kxtVQsgTQzoTs+2yMk9yeO+7HmwwSCu4jKL96+/W0H+JuS3PtQ9T6AFCDijRt5KOjaHeraYbUJiSogjRvr0K+0W6ICVX3GNdOK
x-ms-exchange-antispam-messagedata: /Xx53yRRZ/Z1GcR3XnJlnD7up0jwF2G7ApruTDvrwIZLBc7mn/2upknxX6l8vKDPBJnSj0xCB+5LxovZ2pqW8RtNEqNBUNUNor1Xn4dSeqVmrT+CHIfBOWAPB9nI3eff6LZMm6MJxHoPVPNvjq1GnMfgA6D9RuWq5bQQGkjMKlAny3KAXTzVZTvzY4S6oLB/W0060+uFPTFA8X4xMC5ZxjTqgJ1m8yhFYpg1bf5y94YlkFz8xqKNqKKkq3agTyromEE5wzw5aaOPco7OPLaOhy88NH4wXdkt4we+S+XUv+gfwrPf0s1zRkExsTOfXp9BNgqvoMCYIDkUS8p7Yg5bLQSCfsUvUHAgr/HuMnkxm5fG7fw9CGcG0lT545BvDNfLriOAthSDUKtpU0UYOstSC3TjqQzwJ07NfBq+PvtM16YTiqaIVjJXWVl8IBWbFbNw0IBZBptZiwEzFncAfS9xwJnEXnvmn7yzToZw99Na6/zJY0uBkZkJA+xhMmQOs+UpwAI9Dzv+TJH4PdoOF9cZygalfebsyIU1+ypLx8w3QCBsFQQx0TR3YAg7Pjx6vVvB3xfe/mRsZ2jx5v9Dvx7InQCb+eSrLW7llto+taX062XSj4kpsqzsbDV1fJKzS0DD0enbjjA1AlyHXrX3qptu52Fn2JNT/ZcEplbjbC/dK/Smn3iEbSfcbyQISoiHJmP63xNR8sQMOaAIO9ErVkfopyKs59xWWdw487RFqY7+10EqEZxIGNto4ELTE3SXLdQXB/IW5vvib55Um3G29gwtjRxhKnovgBEUqaACLxz5TE4=
x-ms-exchange-transport-forked: True
Content-ID: <2C0B76D1975B0F479825BFE0FF922E9B@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271aa722-a0fb-4a2e-994e-08d7ead7fc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 18:22:46.3533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umv3FiSPn02KxF3aekLDJt0bYvlMykg64oxE60H8mTcu8JMyyOgviCe/9qIUQiH3Ey7CgSbfg8A56MyH1GO0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3862
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_112249_989760_2E5F9DB4 
X-CRM114-Status: GOOD (  23.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Igor Konopko <igor.j.konopko@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 27, 2020 at 08:03:11PM +0200, Javier Gonz=E1lez wrote:
> On 27.04.2020 14:34, Niklas Cassel wrote:
> > When jumping to the out_put_disk label, we will call put_disk(), which =
will
> > trigger a call to disk_release(), which calls blk_put_queue().
> > =

> > Later in the cleanup code, we do blk_cleanup_queue(), which will also c=
all
> > blk_put_queue().
> > =

> > Putting the queue twice is incorrect, and will generate a KASAN splat.
> > =

> > Set the disk->queue pointer to NULL, before calling put_disk(), so that=
 the
> > first call to blk_put_queue() will not free the queue.
> > =

> > The second call to blk_put_queue() uses another pointer to the same que=
ue,
> > so this call will still free the queue.
> > =

> > Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > drivers/nvme/host/core.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > =

> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 91c1bd659947..f2adea96b04c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,=
 unsigned nsid)
> > =

> >       return;
> >  out_put_disk:
> > +      /* prevent double queue cleanup */
> > +      ns->disk->queue =3D NULL;
> >       put_disk(ns->disk);
> >  out_unlink_ns:
> >       mutex_lock(&ctrl->subsys->lock);
> > --
> > 2.25.3
> > =

> What about delaying the assignment of ns->disk?
> =

> diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
> index a4d8c90ee7cc..6da4a9ced945 100644
> --- i/drivers/nvme/host/core.c
> +++ w/drivers/nvme/host/core.c
> @@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, un=
signed nsid)
>         disk->queue =3D ns->queue;
>         disk->flags =3D flags;
>         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
> -       ns->disk =3D disk;
> =

>         __nvme_revalidate_disk(disk, id);
> =

> @@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, un=
signed nsid)
>                 }
>         }
> =

> +       ns->disk =3D disk;
> +

Hello Javier!


The only case where we jump to the out_put_disk label, is if the
nvme_nvm_register() call failed.

In that case, we want to undo the alloc_disk_node() operation, i.e.,
decrease the refcount.

If we don't set "ns->disk =3D disk;" before the call to nvme_nvm_register(),
then, if register fails, and we jump to the put_disk(ns->disk) label,
ns->disk will be NULL, so the recount will not be decreased, so I assume
that this memory would then be a memory leak.


I think that the problem is that the block functions are a bit messy.
Most drivers seem to do blk_cleanup_queue() first and then do put_disk(),
but some drivers do it in the opposite way, so I think that we might have
some more use-after-free bugs in some of these drivers that do it in the
opposite way.


Kind regards,
Niklas

>         down_write(&ctrl->namespaces_rwsem);
>         list_add_tail(&ns->list, &ctrl->namespaces);
>         up_write(&ctrl->namespaces_rwsem);
> =

> =

> Javier
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
