Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A94C4741F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:50:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4121B2083B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1s9PxuSP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CaLMXSNu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Djb0SJsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4121B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+E70GWlaHTxJYgayxfggvVuzYRc0a+QqgwyiC1JwomQ=; b=1s9PxuSP4ANl+fi46/Dl4ieDR
	M6SyIvdnh7qsSJ1TfTLm8inU+LmI9MmXSrc6I4R3l0+92TNyLk6cng9goHRWY+wmaBUvL/3PbQlrI
	z435jgKM4k1/a5hJ/T8hw3hPPJhI4+6VdeLQXUpVhNyU7MmyLB716GuFCEO4/pA8g8kn0XpH9/c+l
	RPJVjvv6ECukREmXFk69yA5Z5F3Dgs3IxZ/iyU9E2UKI45xNUBE1KMW7S0Ebffd0xREhyw2lSq2sz
	30mNz/7wFlLxMXKhoFN0oRutu728C3P6Rfj1gMJim/RR+RE2nosk1iQKzF8fNLsIm48yB+VUGEa+/
	/F2DnhPxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuU4-0000Gh-J7; Mon, 28 Sep 2020 14:50:32 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuU2-0000Fp-Dj
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601304631; x=1632840631;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aw1ga9HxZoiYw8izZpHVD05gzS8kTNZhM/VY1IqLDcE=;
 b=CaLMXSNuTI7aV+G7FA1oiWxOLCVGgqzKtlBLi6fe/wnGazzuQ9PXg0w8
 pPR1HsMqeyXy5jw+Njvt3XQLLxj0NoC83StqG+dY3jHTjIufbc6O4BakR
 A0S+6iiZv1+6dejI4ujWxnWohix1mCO+DKf06Utd9fzV0HSaQ/Jp1z8to
 3CF+V8Wrmtcg1WU/P63Tk/YdW8W+Ac9TAduykBqoPmwlsqdH0D2Jmb1Tq
 kTK4uJ3NkLY/ygommM+jhuRmkG6LFZh+DkYxOHdAemDg/VBIo2ID97yUe
 r7TFOU6+1NeACbOagnOLaNBaDAwu1r+vjL8ExYDTAM+GNyHMDiir25TZ5 w==;
IronPort-SDR: vteRK2a8fh+a4uYCnKAZ5zfjKPHfAaXevuMtQLutWJcTljsRNHHSrnVmYs1rC+mcG27+FvfrKR
 zz0IevLL4J7IhJO6eiZJB72U2/2t6Z39lsJ0TdpeHa1MPwbJ9uP+706sKApEB4R06bYclJCKzv
 W0NlIDcGg5/yT3Rvds4t2PHsE/Tllp/Z/YQe5ubCxYumL7rSeRy4qchpVdhp2E5i6V6/Kiz+ZO
 PNySKRpV2eu05YOdTKfmaYjj01m0G/8aV8b+EMd8KnXk9awq7V8votJE0MfSnDLv3rJz+EUoQd
 9vo=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="149668588"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:50:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrdVgtAxR4Ist+ZaJ6kIYXsJ0d8irlfYmiWm4T6brvVcGzkoyP+5sQSoNUHvkxzzDcXRRFGsrf7MQk39BFZQqkUOS+ik7uGWlL+JrNNVbVdhlUDxT4Z7pyGqHx/YMXJTQEsI6DkHgYMJHsJAfLlggloOjORsqLcH8pzZWfN9XhHOkB+agSi159MXTXqOTPK0YHSS/98Qv+/aShyfSkaOx7Ih0eTpFzmli/I44cy7I0C8m78XPpuecMQ+83GLDZ0fx3+zv2CSVbH8AZQByGKOd+1snVmEySU0WkkmKIzXaPqrDRiVn7Y56GoI/5smJ1Q7ZSukV1CGadd64CKUbcSR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EijrxdFTREfP+ERFMCxfa0czkUwRbsTojMYy0E0v5A=;
 b=gsRyba8bMPVKQHjGx8eMmeL6TRoCqu/3VO+5cVR+BqXUB4T812KXdD1ZDSMnTCnfqbXMm2cWi1FkWacbk5xFGRHqKcxv1o9hWNarGWj4IZcwXPZqYNzv36caZ1bS1+MI76uX6Yt9Dpz51X1kF0U6TVMc85ZUy08GjQQnW/h9cdbgwRLqGjow6U1qfVGM5/oYRcuwABPHpyoQNaX21XxeqZZYaIKoKMq1jceFU9GqJ2zTggUfP0g6X6sdFh1HsQglZOeHhlKQFYuexvOI9bgabsI/1qA70tftDqf6ekzBPPlhaoAYEZgHkZjKQrJ6oq7ITMevcIUsNsjNSzSyhwkXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EijrxdFTREfP+ERFMCxfa0czkUwRbsTojMYy0E0v5A=;
 b=Djb0SJsa0giUVHEJ57bPI4VDUCTNpF9KKeIhXlzcFXxRoCU5QZrH8SHKxSZmt4Zoz2r8/69cXgy1kgg467VTipcVqG7Rje853xpabqPJK9GmBHkbYg7pr+R8YC9wC+GaOuB6RzPeG58qMDcpx27OCMc46BcFfW74Wsk+iFuEyjA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1255.namprd04.prod.outlook.com (2603:10b6:910:58::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 14:50:28 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:50:27 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 11/20] nvme: clean up the check for too large logic block
 sizes
Thread-Topic: [PATCH 11/20] nvme: clean up the check for too large logic block
 sizes
Thread-Index: AQHWlZPY4maKHGO/JUy0t0t+M/LWAQ==
Date: Mon, 28 Sep 2020 14:50:27 +0000
Message-ID: <CY4PR04MB375140467CD740CD8E677FDAE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f73231b0-c87d-459a-0197-08d863bdd700
x-ms-traffictypediagnostic: CY4PR04MB1255:
x-microsoft-antispam-prvs: <CY4PR04MB12556FCE224FE18C838F2B3CE7350@CY4PR04MB1255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsdUyFM/Q40WTLxO/pI4l031KN0fhOWesFsmJXTWtL9MaZn53xQNlON2bhBuakIXDuvrPkKl4zCW1PzsJRR78BdxM5qYRsJrfxb1tSmyzIrQi/X8RYu+L3/PY/A/0fSX2a61aWy5do6IDrVXoYqeYR87QPwf2lKNrGGHKFMarJz5xMvay9C4tl74tuHaEQc71UkNtCpOyOpWT5IqG2RGJsvK0i5rQ4A/VT+rqdY488grsKOWyUo6IEFcIEIE8rQqL3UB/r6rFxKfuTl30dSRhpYkFwKU0vQ6OGNa81xfWnNM35TdEZ4YOF+hrAxHd3ZL9bn1fKtpmeF99SsLJ/pg4qDPZgEyOFvAaxGi7V+S+Y5fkzFYmlv7wO8jbOrIPC3r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(52536014)(91956017)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(9686003)(71200400001)(316002)(110136005)(83380400001)(55016002)(4326008)(33656002)(7696005)(86362001)(54906003)(8936002)(186003)(478600001)(2906002)(8676002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7mDST5dgqps0DijIhQQfPlMhB35NXIf9NHMnb7DrTCoEY0BaCiX6PngpK5PkYDX+wImoAzZJcV3qIypzjBpHDa50fIxUyjxdIKT34pwzu3xiQulzM7ieswPq9MuV5+3IZI4AG0eb2886j7I4SadE5TUCrfby7Osh/7d9BlhT6dC9/4oZS56Hg+UP+bBasZ+ovOINydPl6mZwB+TgMq7GWo1e/KJxZL/nMS0xgY0hVtm0YZ+CKrFJtoF4xu89yjWYlat0e4Xiw0KsGIkxQ/MeJwxO8M/XHYDMdi7mV8BTExxNU+3njWKSjZ02VAahLMdvI1bqcRQ24AkOZpOYJjTt5xIXp+lI6g4mzA2Hpwl0DsZ2NE1HcwtscckyeZ84MjT53eOl5lXPyxj6cCUPZk1wCC3+wkZAHCU152WIXRpIzEvTM2HZLia7PL32CydtjKgcAw16A9xfB17ZMF16F10ZHe9f/LyPsI2AHke+0UxuAv+K9z9WtBXZ/WSdjoWtlTemFA4/B5krGGipYnlgeWBSHzdEaJLG5pbRBdIshmQtVpM2GTE/cHp178ZdOYC8EHxLO0dHOWIBJekMlhq4CMWLAWCqETp1VG3ZLJEus4JKOirjNPxq/BhhTNythuEXewwGkJPQiuHuFX9asScO/CHUzcLCsPvh6+nnuebgA+QVRnhLAMLa1wn50Fx236HY8QBviJqrgINgKfOBasLhPpExbw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73231b0-c87d-459a-0197-08d863bdd700
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:50:27.8876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuVZoNb5rF/d9r0jzk63jvBlPuxojGiisC1KOTJkgifzcXnFRuVgGn+R8ZZBpQSFaBCCvUBiEs7Ab6/x8tYRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_105030_585112_167A9897 
X-CRM114-Status: GOOD (  19.48  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> Use a single statement to set both the capacity and fake block size
> instead of two.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 82cd03c0ba21ba..0114fe47de3571 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2017,8 +2017,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	unsigned short bs = 1 << ns->lba_shift;
>  	u32 atomic_bs, phys_bs, io_opt = 0;
>  
> +	/*
> +	 * The block layer can't support LBA sizes larger than the page size
> +	 * yet, so catch this early and don't allow block I/O.
> +	 */
>  	if (ns->lba_shift > PAGE_SHIFT) {
> -		/* unsupported block size, set capacity to 0 later */
> +		capacity = 0;
>  		bs = (1 << 9);

		bs = (1 << SECTOR_SHIFT);

is cleaner I think.

>  	}
>  
> @@ -2055,13 +2059,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	blk_queue_io_min(disk->queue, phys_bs);
>  	blk_queue_io_opt(disk->queue, io_opt);
>  
> -	/*
> -	 * The block layer can't support LBA sizes larger than the page size
> -	 * yet, so catch this early and don't allow block I/O.
> -	 */
> -	if (ns->lba_shift > PAGE_SHIFT)
> -		capacity = 0;
> -
>  	/*
>  	 * Register a metadata profile for PI, or the plain non-integrity NVMe
>  	 * metadata masquerading as Type 0 if supported, otherwise reject block
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
