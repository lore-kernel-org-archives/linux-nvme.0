Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A8C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:16:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3BD20720
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9KloAbh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fIouTdXw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uuyLIfUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3BD20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ne9OJnKNxWxdq5MUsqLBYgXNYvdV1Ba7SUb+AnIfwMo=; b=W9KloAbhzYuZaTGrXoqUFWdIu
	PSsHGDOZWjUJURSximL2Fb+anl9APa7Cg2mBrkY+PiSzQwd8U6wC5uFMYyeiQT8g1axRZBKY2RzAQ
	lqasHuQ3ZuS7/WkILpuuqMcR62NYgNsL0UYUTfm2n9zO81nNU0GOBW+Nezid3P5v26E4G748TCuTT
	qtRLzEOvLC22r2cR4fFRX5Y3t0TxoMD6friKsTrIyUDy2CjoaDyT/9tWCBqHhCxKNgOWbhJ+1ScfX
	sf6TA9Q4nuvzcYkBQMcsg3QHyKCILhvAVJ29lMKZ/wmAOkgs+lEIcPIpRwzYMjOFcBDoihnLcCQlX
	6/CJxY2zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquOi-0005Ob-0o; Thu, 02 Jul 2020 08:16:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquOd-0005N3-Uz
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:16:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593677843; x=1625213843;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BF6uCMC1+8I5m0Y5hbm/1x8AFFQTFnfEdMJr06GRmR8=;
 b=fIouTdXwFbIIZnSAWphKuil176ScAwFYpfoccEPWKib3N2c2lIpXnC38
 EEKd00/a53gZqC/fi1oVNQ5ftmDV+j2pAZEI6B6y866hUmqDlYYFFXRyg
 zXTA0shuxtrVG5OazlwzZgd39H2UC2lEWSWg5MGhzXRVQLEXeynhAAojg
 DP8af2JVJbrWj3Ta9fdhIfcN3wJQtW0O5/VYfQbwN5uoCbpupazLmgMQb
 JC2lrn/XpLQ3FkIv8Hhe0WpDKj6eL2nuzno5D8KMoZoBtzSAAp9fUt6z9
 M/mRhc67XO4N1PJSBmdP8J4U3WBtJ+b86hcOCS66Qr7/28QFj/kAf3FXP w==;
IronPort-SDR: aBIYY4Unm3M1FnZHw/wW94+vEmN5aSR5+rMsUvFaxLYeH5hVr/xj1PWNevpVynwwc6/hmiFvPn
 UjWFM2pKQTnn9Dwi2YCQ7Vv51Lnr9o6IDqkJexUUMl7ksj+LyVyjXzWXMF98okHdR1mzS0YPOB
 bJMicthn4JKb9JG46OZGJ/I6V9TfYWJ04GhUU9XmX3wQRcAYh7feNiINkj1U7n12ZXlLR7qT3o
 +ffU7uFS55FNPrx7Q+w85B0z2udNoFPVt22dWUa3y7B95ncgBnNSSDwK4x9G0U5/jlVLLooQBF
 4CM=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="244482635"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:17:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZFVuCNrSHNH5cNYR9H4rFXK6bVDwtgfEKsK4eGBZVs2Fl10z0soG6okO9Of9RiUb60i8AP69PaB2UMFnE5DwwH5aCZCKWLIUdMNAvHCY5X8JnREVe0mcGLLvrQKY0KiqX//VLgbR375OvPyxpC5ofFHezLEMfjevvSwnOQdXiIQcTrc8hnZIbK+ZAR7ts+DLUA5ZDXUakVs4KZg14glHhjBx82dHDsyPoeehJ2FTY0acLS22NMx7bk/FoHGq9xJVkgtSYr7TxyGNGx7ywDXSDT8U4IJ1XvzKUdTDg+0oZxrJmqw5VGapVy47Nn5y7lztcXK5XAnBvxeubEt/af5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8KWItM9eclKG7Qq2UzdQjaE2Mu7kkV8XnlFOrr5FlY=;
 b=aa/V4Dcq4sn7FjWETTq70I9yVV9adqUIRzAqqpZAbtvjGNrCKGPzbCEa4ynAx5352FRWPOT51RU1UHlA6acwr0QQ7kZm8ksfxcGGvFMz/5ztd6mxlWhCcRfsVqbcel9gWCX8HFS9Vy1KWkNBji4KgLM9qrk3wcElmQSSrQDKyXbHwsqrwVjpbuS9o93bYKitnTmVGR+FVWw4IgD+CFUJIbn5pvxF9nhg0DxPcnqXtQAv0uNACvgtslOsuDkj0fIHtY05E/yegyOvwrl+D9UoKFvcyXesOT36pwN3jV9QKfqAGHacU/O1e3DwHK4Vk6NdmPQcPC5LpfGPv0vNPjhG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8KWItM9eclKG7Qq2UzdQjaE2Mu7kkV8XnlFOrr5FlY=;
 b=uuyLIfUKtllLTRkm6B45l+qTzg1NXhXf5+HGJC2WfCdyl/XWw+G0bfMZSH4Hra/kt4fbv9cuakciSvGbmiqxpt0jkmJ/w1l76tonnGKJqTxvOdUE4u3ny2dNHyJPi4gPkVjZ98hNB9kOAr8yzH74sXXOUZ4bNs0aex/ikdWv97k=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0759.namprd04.prod.outlook.com (2603:10b6:903:e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 08:16:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:16:37 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Index: AQHWUD261Ibfrs0qX0+rwW8ysnw6hw==
Date: Thu, 2 Jul 2020 08:16:37 +0000
Message-ID: <CY4PR04MB3751A70BE6C1EA7DC930C9C3E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c280d97c-64cc-4544-c365-08d81e603dac
x-ms-traffictypediagnostic: CY4PR04MB0759:
x-microsoft-antispam-prvs: <CY4PR04MB0759A0738BBA46D34ACC2460E76D0@CY4PR04MB0759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DQjCTKleb/NdlDimQpav9ByLrHwbCPdoIfTBIYAuvhCJltE2mCY1jYdCvCQ3YkrNqY2mzHEq91VYCKXfmEsRaU03zNdPD8nPfPOtp3hJsRjSyng1LgYZyw6x/332VuALToQBbHb8V5WO03HUFW3wQmjtZaxw15XMHuTJmc0grvjqcAcLZv+Ft6e5mWmtUixYK3BIvEaUyHHP0qWGT7yLr2bF2eIaS/L+B9LEdYutNLQwogX4onVXS/0nJOEC/VtojLkfHVBUNJw/1ythoAbDLf5mY26YFxwFFMFiI/tkKxU/ZdPVolFQzsXjqf2FVEQIM45IdvXo3WhRs1WWwQwLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(66446008)(5660300002)(55016002)(52536014)(186003)(7696005)(26005)(6506007)(9686003)(4326008)(53546011)(86362001)(2906002)(33656002)(8676002)(66476007)(66556008)(64756008)(66946007)(316002)(110136005)(76116006)(54906003)(91956017)(8936002)(66574015)(71200400001)(7416002)(83380400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: o46GK/5fq7J69TCiWKWjRGnQlSCFrbyXq/bxcxAwgc78VjVhpWXLU/jAgn0EMTzTYTMtUXeNDX51WECUG06vX33Ct/96PJFtq3KiJDzDzQ9IuSZRAQcsKRzdBLDDbnxNSvzdolRE2Y23Md8INvLoLclgmVESEEAwZ7xkBiHTkcuGv77fmDDy2OIIZ5Fjoiod3EhAt4qtTVZTSGXTj5my7BqJIYQabNRj64ApF6kO4Ur91g5xm7Dsmyeo8VlHG0uKGYnbS4HpN7goL6aflTOweGnozIdEBzjjG2FC/KJrcm5FUnVM8LY1aNOGCWzN+TTHYVl6EP4xWeyc29M5bIke2UXrDnm3KA9Ijn8YFI5OvggtzOu9bJc3pmOM5eyP/0cIRjj3FT2Q+meNzM0FXfoMz9SrN4kd6Nt2oexbzvb4iAf7Yt8HR3bJg/Bm7tdI/bk4LH1p8jwB4lRIdsds4O7dp7F46s00VucEYK/TIkr+9R2ffcW+Lf6YaPO49mJfqfTL
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c280d97c-64cc-4544-c365-08d81e603dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:16:37.2251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXS3FPS2HZHSaCaK7lbnrJw6NidnVUK4hjb+DN2OrL/sjYlcmIQcW80xuYLWNJ0ziQOt5MdDI2AzcCeHzYbnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_041640_156132_AF0F6064 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "mb@lightnvm.io" <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Since the number of zones is calculated through the reported device
> capacity and the ZNS specification allows to report the total number of
> zones in the device, add an extra check to guarantee consistency between
> the device and the kernel.
> =

> Also, fix a checkpatch warning: unsigned -> unsigned int in the process
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/nvme/host/core.c |  2 +-
>  drivers/nvme/host/nvme.h |  6 ++++--
>  drivers/nvme/host/zns.c  | 39 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1f5c7fc3d2c9..8b9c69172931 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1994,7 +1994,7 @@ static int __nvme_revalidate_disk(struct gendisk *d=
isk, struct nvme_id_ns *id)
>  	case NVME_CSI_NVM:
>  		break;
>  	case NVME_CSI_ZNS:
> -		ret =3D nvme_update_zone_info(disk, ns, lbaf);
> +		ret =3D nvme_update_zone_info(disk, ns, lbaf, le64_to_cpu(id->nsze));
>  		if (ret)
>  			return ret;
>  		break;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 662f95fbd909..ef80e0b4df56 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -407,6 +407,7 @@ struct nvme_ns {
>  	u32 sws;
>  	u8 pi_type;
>  #ifdef CONFIG_BLK_DEV_ZONED
> +	u64 nr_zones;
>  	u64 zsze;
>  #endif
>  	unsigned long features;
> @@ -700,7 +701,7 @@ static inline void nvme_mpath_start_freeze(struct nvm=
e_subsystem *subsys)
>  =

>  #ifdef CONFIG_BLK_DEV_ZONED
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> -			  unsigned lbaf);
> +			  unsigned int lbaf, sector_t nsze);
>  =

>  int nvme_report_zones(struct gendisk *disk, sector_t sector,
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
> @@ -720,7 +721,8 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(=
struct nvme_ns *ns,
>  =

>  static inline int nvme_update_zone_info(struct gendisk *disk,
>  					struct nvme_ns *ns,
> -					unsigned lbaf)
> +					unsigned lbaf

missing a comma here. Does this even compiles ?

> +					sector_t nsze)
>  {
>  	dev_warn(ns->ctrl->device,
>  		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index b34d2ed13825..d785d179a343 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -32,13 +32,36 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  =

> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)
> +{
> +	struct nvme_command c =3D { };
> +	struct nvme_zone_report report;
> +	int buflen =3D sizeof(struct nvme_zone_report);
> +	int ret;
> +
> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;
> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c.zmr.slba =3D cpu_to_le64(0);
> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));
> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;
> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;
> +	c.zmr.pr =3D 0;
> +
> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);
> +	if (ret)
> +		return ret;
> +
> +	return le64_to_cpu(report.nr_zones);
> +}
> +
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> -			  unsigned lbaf)
> +			  unsigned int lbaf, sector_t nsze)
>  {
>  //	struct nvme_effects_log *log =3D ns->head->effects;
>  	struct request_queue *q =3D disk->queue;
>  	struct nvme_command c =3D { };
>  	struct nvme_id_ns_zns *id;
> +	sector_t cap_nr_zones;
>  	int status;
>  =

>  	/* Driver requires zone append support */
> @@ -80,6 +103,20 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>  		goto free_data;
>  	}
>  =

> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);
> +	if (!ns->nr_zones) {
> +		status =3D -EINVAL;
> +		goto free_data;
> +	}
> +
> +	cap_nr_zones =3D nvme_lba_to_sect(ns, le64_to_cpu(nsze)) >> ilog2(ns->z=
sze);
> +	if (ns->nr_zones !=3D cap_nr_zones) {
> +		dev_err(ns->ctrl->device, "inconsistent zone count: %llu/%llu\n",
> +			ns->nr_zones, cap_nr_zones);
> +		status =3D -EINVAL;
> +		goto free_data;
> +	}
> +

I am not opposed to this, but I am not sure if this adds anything to the ch=
ecks
in blk_revalidate_disk_zones() as that does a full zone report that is chec=
ked
against capacity. This seems more like a test of the drive conformance, che=
cking
that the report header nr_zones is correct...

>  	q->limits.zoned =3D BLK_ZONED_HM;
>  	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
