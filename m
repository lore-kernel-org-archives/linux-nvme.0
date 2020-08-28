Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BDC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:03:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AADE2080C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2KlvxQgI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MfhsGhcr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uEta3WlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AADE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=isfiSPUGasSeDEM7fBOFesgfH6Uq8ILBsi5PR1tuwiM=; b=2KlvxQgIb8l5wcta2hK28Gr5Qg
	ZJeBLm/Ec+JF9aEz5bm5X7vnmQK0QWqcy+rkDV3ada8Nm3hbakmi3aCTG0BSWxWwvfnueRGBcRjlE
	koGqc4xCDzm0cBxPVv1QU412TLNcvrrvSasmn/73zYo15dW0uvpRFSQoXlmLszU8zrBx31IPaygXe
	vtfTeS5f0qgsUcgCrL0Op/Zpm7cZMJ3ar8wm9PVwZnaLbEq9t5qKFHLeHJxzfKBC4mWf+YnbJ3dO5
	5YXoIcutqd9T8zJOYF/JznKwMJ82ELkfkjTFmKldEoV8Wb1RbA1Y3EGneq8Y/QU1a2K5Qk7lkZBFX
	i5pI1xlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSnr-0004Ph-Bz; Fri, 28 Aug 2020 01:03:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSno-0004Ok-EQ
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598576628; x=1630112628;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HTSoeBf33UcXypE1PZgWC8r3MlG5mGIVSdz9/xQrwAo=;
 b=MfhsGhcrTmOYNoDATwMLpaOFFz7uL/aq4Gl7etijMh+p+CPk3zSst2WL
 jbzrX7IA9jPqVTwP52kJ8Hw1HarY4L++WMvslmj3IktZ6SejSQgJzyGBT
 pov84EdOxq3aZPQwlVBJ55YJDiJmEKtFSV4pREotS3ueKG79LfXIRRnGI
 Af1EgetrspVIHrBnL776ybUSbgmY9G4CFt3DIm9aTfoUtw33d1Ra0nvom
 xjsnF7aMKqE1SPm3g/Zp4gGHojn+jvNGkAD+YfH2h0kgCUShPlUM7c6gq
 6lw87AIXTkVd2DOFCY+ggzo6smCHCrmgwpecRjZ2sftPQ36V7FE5aT/e8 w==;
IronPort-SDR: 62lyyUQUVWq1nCMAs+S4ZHbG42FTMtRFjSUm2UQkOPvFzLK6CLtSA9cEyYMZanxbJE+4BQgYQQ
 NcRkjSIIS3cvlCwBNldlU07MReOSb5S2dDD26nQmbbd3jw6SYfTSd+txyRog0RVh1UBDVo9qPa
 X0TTNQ5hYswmOX8JIRvTjiKdUqBrDLNxPlS7dOjIPLO6N1mQHSNQpinZ6mOW7lIVymyk5bLyTL
 Xe5dfuU8Fk9o137FckUb6XwbUNKizwZV48X9qkSppGvMQpXm7uVbTSlh5LyMsL+hoP9WZSLBBE
 r+o=
X-IronPort-AV: E=Sophos;i="5.76,361,1592841600"; d="scan'208";a="249259564"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 09:03:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfVFqhe2lT/174lY9HrOvelG5zIXFbcu9QD30WN+ovMuxrESK76Wz8CdNAIjFQO0QmMFQGIGOaaCVSmDTUiVaN7nJUE/aUFaJ1oZAUb2FAJg7ZNyslEgYJuFPqziqWKQYlpv7IngIKIh6AlezXECJ9QCl5v/8PR19L1p3Yz6iSE6ycCq0VrHtI1KWsaGwTBTaDkd1Q6oRqJqih7ED1qMyb6+tmnzy1ZTt6crLDsMsO+HTVyQLjFwqnwAcvAaNaEP1lF12+xw7Gs/mD5yh7BwV7Q61QZsAnAv3gy2PckNGkr+CHIM8Wgi2QhzyjEp0CesAAL5nr8vnrRwPK4iAZHbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XC+mmIS+Vs7UOds5WUEs3mHFs0R5C0tqLWkt5fzAX0=;
 b=ZDs1SY4szl07vzL0KxqdFNbOMVj2ZNQVoMlqAi7n3Xw6m5/rsw+yj+7jAEotr48Qq3DL0pNG3jv1E83FlJeOYFhfd99Qm9vn9GwXxN5AXUheRmroK+Yzn9gogwgd4g/M4+OqD3UtCq0sFXQJl8LY61BnuvtE2OOdIqMB8/WDJvpx96Ly9o8qaBPjUJzWAWDM5V8qxvlC8Apef6OInrGODoV66QAUjdTmK6KijoLpRZPl0qfw4Zhmay2AztG+kWvIFWz99Er3xvB4AZTcDlNuI2ZqnQmca1sHxUucS2YmhTmAoMCKpbMbP5qypOhrZeoJpju67jcqoLHJVqMs/P5zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XC+mmIS+Vs7UOds5WUEs3mHFs0R5C0tqLWkt5fzAX0=;
 b=uEta3WlI24E+jndixX1jph/uxoSai7ILjbrDJH+5b+M5xxPtvEUxI85rhj+2ivjRtYfRl3ik3D2BKIMrbdZEGBOd7nLy4QodhQTXWTCSaPSAqzSdRFQ7nZ3M5xBPAEY160QxSwnFbicJVjCqycKPA2apF1/+1sCH4NkJomenLj0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 01:03:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 01:03:30 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Thread-Topic: [PATCHv2] nvme: only use power of two io boundaries
Thread-Index: AQHWfIew8sPeVGuOyUGnBvqGhC5QdQ==
Date: Fri, 28 Aug 2020 01:03:30 +0000
Message-ID: <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 636c10d0-d22e-4943-b2e9-08d84aee2dcd
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-microsoft-antispam-prvs: <CY4PR04MB096878931BDF4873BDDFE2B2E7520@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3IiKYcPKERyN3biZR3LmLiEcSjW8vbQyqLq0NfCye/rBuFaMjlvnayp43pUD1x0RoJdgzi3cErIu5X/bAN0rOqcaDKRO2Th8LheorNDXPNsSlCQk6gFlZX1hE9sgNH9ZExYUF538KkEgeoQxaxOcrVhxaDGQgYdvVeO8UGxpADBX2AN8ax7n+a0G7d+PoKfLLjKqBRqxkbbLHC8P8Bf1OSTzQ0A0A8HyOPsCE3F/WxI63l+rLl1zVx9jaOR3G/gBdLT1+OdslyTWuAi00KvKY12oaspwQQrVJHmHyNoN140+/Ps+pepGBto1C5zi/jQFimoRj2FAhYZHIAZcND4x7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(76116006)(91956017)(33656002)(86362001)(66476007)(66556008)(71200400001)(316002)(66946007)(5660300002)(53546011)(6506007)(7696005)(186003)(8676002)(52536014)(64756008)(66446008)(110136005)(2906002)(83380400001)(478600001)(8936002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: E9YOE9i7SkxlyzaZkj4T1vCCoXfrF7EcvR8gLJ2xa7rtsGooS8PI/nujSFKxe55Gn816kxW1CBrfC/Kt1xMF5Si1crGMtUBO8qvs4abiMRCzvAqjvAbd2SSgw/uQ1liyzFBBjIDb3Fdyx0AibtAGiVQBIevxWH6E++odN5lLWjYs6z8jb2Y1nJQ/zz2xmDXBG/OIIh4DGmBoUyD506lTyFvu3GyOFLH9YbHId/bVb3aKv4GcrbJVtFmTZ8g58q5++xXjDIPgWDV+nXFP17cC+y0zGUZyZe9S2uUm2IC9/FliNJekElbBXvIU1JsCZSKZySO/7nW+2IANBB1rCzDDKaiLTNvG/46qbPBtnD7SWBS2CxDjPJbQDymFDCJO/snGzo4BH1M3AAVJZnkX4vZ80DxLtHS/lmQupEHMK9HyISDoGqZdj9mN0lvNbgtoAMSo2AorMc+7vM9I9gfQarokRk42hM+uzFZx7zFCIh7LjIrzQkjM0QIomIAlVHoP9bXwOk5Vh2oM7RmgTkxAaRGA7F3RcDdI6+zVAp5zZBWZr6VrinqRxRi/SO953gYQvtKvbO7t2nuUYpqQUGVGERnPTNFOas5rDPPJo3ehUt8wFPXTEIMFHb+XyX73zrewDpZ7hgii6e5zd3L0pH+qBqm6zbM5KOQjfsQSeaLGyQcVNfoP8Gxao4N3Ysp4xLkIcNXJgmkdsslrJ/MOADggi56YsQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636c10d0-d22e-4943-b2e9-08d84aee2dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:03:30.3302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRxrTw4pk+wJ636+AYeRbGOhCC8ULd+K882HhHNkJ1slbSUSo88q6jprBZNXmVUozmOebXE3iQ/VwBB8+uLhzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210336_797847_BB240097 
X-CRM114-Status: GOOD (  19.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/08/28 0:35, Keith Busch wrote:
> The kernel requires a power of two for boundaries because that's the
> only way it can efficiently split commands that cross them. A
> controller, however, may report a non-power of two boundary.

I can understand that using a power of 2 limit for splitting can be more
efficient CPU-wise, but I do not think the kernel "requires" such a limit
alignment for splitting BIOs. BLK_SAFE_MAX_SECTORS is 255 after all. What I am
missing here ?

> 
> The driver had been rounding the controller's value to one the kernel
> can use, but splitting on the wrong boundary provides no benefit on the
> device side, and actually incurs additional submission overhead from
> non-optimal splits. Don't provide any boundary hint if the controller's
> value can't be used and log a warning when initially observing a disk's
> unreported io boundary.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Warn for the namespace with unusable io boundary.
> 
>  drivers/nvme/host/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 154942fc64eb..9bbbd600621f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2097,8 +2097,12 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  		}
>  	}
>  
> -	if (iob && !blk_queue_is_zoned(ns->queue))
> -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> +		blk_queue_chunk_sectors(ns->queue, iob);
> +	else if (iob && !(disk->flags & GENHD_FL_UP))
> +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
> +			ns->head->ns_id, iob);

Isn't this going to generate a warning all the time for a ZNS drive ?

> +
>  	nvme_update_disk_info(disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
