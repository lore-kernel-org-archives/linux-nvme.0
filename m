Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3C0C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:37:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C58622CE3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=L44+U39fO7IRZSUvIzpK/V8zli9BEy2RMRYSTrUXliU=; b=cXLg4SZ0JmcvYNx5SSh78HgWS
	A6naTvlsYK/3L+0L27RFXW99XFftMdUSyXLvofoC2r82vqcLBTPqjcPTxC5DoWoP0JZJNP8HRQYOk
	VUkK2kfBCehKUL6+hFNHGV7usZunen1LF7vE5ymnA+ym5AIIOA6572x5HKGbIBYbfliEWMQ+jc3aZ
	AOz8CDU44+WBiMIQlpqiqx83Pr7TyiwTpGWA2j0sAqeSix/bRi3zDXY1AE7No4DzTrg7yqknDJSrU
	fy9o2K1AuXVhKbAjSy8PTJo0fp/EKmiaY74plsYSACb6qxlHaTH2zGtSAOmBBahQoqcC1QBqevtDM
	s4oEbuzCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCMg-0002Mw-U2; Tue, 12 Jan 2021 05:37:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCMc-0002Lc-Vf
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610429826; x=1641965826;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ypPN4+vhA5vxoe2UfH/LVkTa9oB+Wj3II4+fP+m/oPw=;
 b=VCiO83+YhfW/ELQAzWbXyBG2kJ5M0E1vcZ902GM7jtkbYka5rB8XSjn4
 +vuoIuuWA5vFFxtrfugP2bJQrCRQyjJICVC+4DivJIs6ShZTFOCVVcxJk
 jugLMA6KiviYpk+y6m34Vn14ox7lsbIM84rcMHpPzK+DkexBroJKdUhVt
 inLiAUc+9vdfQ97yOnxY/BsC+D1oMFApREViL3vua5QNiGZkr14wMH5W3
 V838F2bekMnymMYRFnCfvH3UsV+88FVGZwF1crpGxvLvOv3R5UUk6i82b
 EXLVN5RkeN+f8ZqEPRXRk6x7maH43pLAL1AEfl42n+7tEzU2xGrS6NrS9 Q==;
IronPort-SDR: UWP1CbVax3DzEglTWt3QImfqNBsmLXjc1ALo9kB+jVQw4nzeP9yeMW3sR0UG438Y8c1nyOcDxk
 E9eEXLNy3XeH9NCgPeTQRATMZHEnWddJC+TJ0fkkMlbkBpFfG2YqxAxr+u+969Dbeuoa5UhRsl
 /oKCeFNLMI85llVZ7CHjnWjthtdv40g2BPs93Myb+hXEtmFfnUdWzJ1KPiScCRp4HkJ89Gf4JB
 DGAYYlQS73WpiQNn5pNYvYGdMFQqeVsotaiufafVcIBYf1PKNOLgBDsiuHji8EPlpUxfyu1YpK
 UjE=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267509059"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:37:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpsqKAwC6axYnLFfjGsC+9s6+7GqEYTgmcifLzK0SKYYvDDwKfovgJPMsylk5G/yNsMlWBTvD1TPx3lhkBdt1UMKxkAVQ8N3vCU/n9Z85OBQsEtZyVQ1DEmN3a+D7/EiD5UvW5/06M6Lek0ekub8taW1kRg7GATYtdSie3ke0Mv2qkgwm54MWMYpPHRLo1q+gL6RFxeGKNjacgsYbn22MXWu6YTEr1+N6BhC6IUdKUQY65aFIuOKfiiabK3VTDn2aYMcLViyyYGoZrRhigk77bksgYQuF23Aas63/oyVyPCltHUea0hWBpF+XP57/MxZDifj8yNCU7VRTt8bnZTH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjhfVbpjdcDlnyFpxcFAJ914bffCdxYcMS+priMSni8=;
 b=X+oVjhp/nT0r5lPgZEDLDW9oMmZ5MvXEYZn4h1fjWDn1XYC5tuRP6fRV4bUKBt/SOd8W1sTLMCu9fp1+Oa2qLh1nW2MsfdlVPbrLq4djjiuh41QCjf17V5uaMwM68aMiO9vLs1nKfD/32cIr6hJMfvI//CboB+tWZFQaUM93f+9ObWYi/MmPuVTaClQa8KsN7U2AtZDFb8ir5BoYZ06fKmMwapH6OnWY+NdeobL3F8CJ1GXtKR4LXw+kzbMcFV0CJYuvzGA+/oqEvsw94+vWaF076zdX5nvhwxEILefZunrivqJ7Jtbtr/QfO4AnY6lq0iAfLO7aItzE5/gtuMZ/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjhfVbpjdcDlnyFpxcFAJ914bffCdxYcMS+priMSni8=;
 b=L39Px/MDt41pxNs8Q0qwsY+TfJbW8R9RP84dYPtluwMt7LPRuJSYXz0vQUp5J0Z0XZRI+dFhIxCrmAVpRLdm4AzXSh0icZ534B3LlSsP4hOkgxmH2BB5b5OeRSsgQjT/wwR68ascO1eB7gbmsRKL1Fg+/68yWcQui+4HUx0dxPc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5060.namprd04.prod.outlook.com (2603:10b6:208:5a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 05:37:03 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:37:03 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Topic: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Index: AQHW6Js572EHK7u67kumSX8SZd7ojg==
Date: Tue, 12 Jan 2021 05:37:03 +0000
Message-ID: <BL0PR04MB651444A9A810E0DA8D958431E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f5be839-5434-4e34-43fd-08d8b6bc174c
x-ms-traffictypediagnostic: BL0PR04MB5060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB50601AD8E4A0DA92D25D2308E7AA0@BL0PR04MB5060.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LM1J+SUyx6e/Xn27DsSyt/Xr3viPg4/nwVtDaq/XoM/wdFW4nWVDEZe26mJ4K7i0Xz2Plgo7K41BsUC0LtpCmJ7EUGFZe2GNCubIL94KvLwA2ZtOM+7QYWom6ALI8//RDPmjye8QereeYFM//EPAxki7wcM5TCdNIvI9wIniy1qsV34/8cpS+oh7vhzsU3vnXHtW1rfclih32aWzvs3fE0YzAyrlyuyRwg1/tlCFx0ys86aW1fNDfn5mWnXYUQjxD+J/vYXYupapaL2b7bP97UOTEJhXebxUUwjLlaiHAfCIj5QJhEgeb8nRAeh9sTBgXA0GKymysGV0F+m8Zn48C4AcJraQuy5XNivBhgzsGr69uTXkYXlxd4BCFJVvUbl9o0V5RrLpcWkBjibC6GxMvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(64756008)(66446008)(186003)(4326008)(7696005)(33656002)(66476007)(91956017)(76116006)(478600001)(66556008)(8676002)(71200400001)(6506007)(54906003)(53546011)(110136005)(2906002)(8936002)(52536014)(316002)(86362001)(55016002)(9686003)(83380400001)(5660300002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?drgNx8+xlpdzkcf+9l8krFMOy8/eE2Y223dCIlF3VuT1dE2gubB61uVWgC?=
 =?iso-8859-1?Q?my+pne10MJAIlo3QR2/dqco2u33rABiALVkXDVHwYtNF8x+HdsUfy6VGuw?=
 =?iso-8859-1?Q?AmTNGYAdm9DuserDcj3L87Qa8SPrJWqnhO3hdWGgeRv3XvT2hcY2cO2Tb+?=
 =?iso-8859-1?Q?Y6Iq1KLFZ3HyP1jMxq/vAGx/d6J2r6knNbVcSLFtwCMdCSxLnXg/w/yECW?=
 =?iso-8859-1?Q?NS4FKMAFkwFqm/v2mFJEsa5mFtIXoP+qVPzw/+8QnLoXFbtEkhfj1jE86l?=
 =?iso-8859-1?Q?98yZFjELOn34FflCPSsSa83rVwW6ABuxWyA7TykFupn+qVoH06Tc+CbAYd?=
 =?iso-8859-1?Q?3gl/CZe55HMMqhCXW8OppFtDqPLQgjTmbY8treFjrH4VPTXo88YrHUP36I?=
 =?iso-8859-1?Q?f5KWe4pKCPyqQpbJ6UygzN1bvE3fsfG6sWBAf77wU5wrfIdISRiiGkoG3W?=
 =?iso-8859-1?Q?ejT5ScL0u8eS32mHI7ruUbZy3LMGAS6ydZ0Fr64x/+Gw/0dZ311Ind3li0?=
 =?iso-8859-1?Q?mDtb08b/eGv3qXaoKgKiA2lheMMSujRMjAeAPEB+S9ELGRkfro6uFAH6OL?=
 =?iso-8859-1?Q?gSq/MQTIG/97BVSoPLz5PEShEOSdY/H+FSIHVaSncxu7vrjMCrtFAk3M8X?=
 =?iso-8859-1?Q?U0OIEtSvg1y7PH1TgCS7BlQ5LO8PJlX1mA+jN4qdwz1Tl9BG8kZyQUA4Ii?=
 =?iso-8859-1?Q?B5XGTC8/ljI5FDMVWBlIKZDHDwW/RG7gEiMGmCo3MxI2GqFA1U+kk4iq/s?=
 =?iso-8859-1?Q?EWJebAl7uSqhuGKRrpxlmU8XfwD9YCtVa4cgbu5Vfa2vFd0VcdtTJrx/87?=
 =?iso-8859-1?Q?MbMpuzKDFU41IFgJDLiLElRyjtt3A7VcVKRKmSjvKNxwSsP3ENN5EAccVx?=
 =?iso-8859-1?Q?THYPkxdOMHYAzgPdMUb/aXYJ0buFD9oPtQq1kGjpD/z/5yO5VM25DTEIxW?=
 =?iso-8859-1?Q?LvL/mPebUE/aXQmpIIULaIH7jzWbTNpYLp/tiiWxDUDuee9sy0MdXtSVmH?=
 =?iso-8859-1?Q?nqjLSRqm3V6dUOmZGa+P5IGBdl1Of+TMRskzKLxJfT8ySDCxdytpoxuOAd?=
 =?iso-8859-1?Q?RKndxHnhg6MxX4fAV6UijnA3PrzAR2bXbqVFW8I607S9?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5be839-5434-4e34-43fd-08d8b6bc174c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:37:03.3139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGP3fBOQ+GtXF4OhlgKgQSBc3vpRSpI1S94ygokpE5h2Dj2bHhco73Ol9NSDTAKLkI85OFN87ekaKg2qr5n54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_003707_291037_E0E78352 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/12 13:27, Chaitanya Kulkarni wrote:
> With the addition of the zns backend now we have three different
> backends with inline bio optimization. That leads to having duplicate
> code for allocating or initializing the bio in all three backends:
> generic bdev, passsthru, and generic zns.
> =

> Add a helper function to reduce the duplicate code such that helper
> function accepts the bi_end_io callback which gets initialize for the
> non-inline bio_alloc() case. This is due to the special case needed for
> the passthru backend non-inline bio allocation bio_alloc() where we set
> the bio->bi_end_io =3D bio_put, having this parameter avoids the extra
> branch in the passthru fast path. For rest of the backends, we set the
> same bi_end_io callback for inline and non-inline cases, that is for
> generic bdev we set to nvmet_bio_done() and for generic zns we set to
> NULL. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c |  7 +------
>  drivers/nvme/target/nvmet.h       | 16 ++++++++++++++++
>  drivers/nvme/target/passthru.c    |  8 +-------
>  drivers/nvme/target/zns.c         |  8 +-------
>  4 files changed, 19 insertions(+), 20 deletions(-)
> =

> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 6178ef643962..72746e29cb0d 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -266,12 +266,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *=
req)
>  =

>  	sector =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>  =

> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
> -		bio =3D &req->b.inline_bio;
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> -	} else {
> -		bio =3D bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> -	}
> +	bio =3D nvmet_req_bio_get(req, NULL);
>  	bio_set_dev(bio, req->ns->bdev);
>  	bio->bi_iter.bi_sector =3D sector;
>  	bio->bi_private =3D req;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 7361665585a2..3fc84f79cce1 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -652,4 +652,20 @@ nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>  }
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  =

> +static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
> +					    bio_end_io_t *bi_end_io)
> +{
> +	struct bio *bio;
> +
> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
> +		bio =3D &req->b.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +		return bio;
> +	}
> +
> +	bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);

I have a doubt about the use of GFP_KERNEL here... Shouldn't these be GFP_N=
OIO ?
The code was like this so it is may be OK, but without GFP_NOIO, is forward
progress guaranteed ? No recursion possible ?

> +	bio->bi_end_io =3D bi_end_io;
> +	return bio;
> +}
> +
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthr=
u.c
> index b9776fc8f08f..54f765b566ee 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -194,13 +194,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *r=
eq, struct request *rq)
>  	if (req->sg_cnt > BIO_MAX_PAGES)
>  		return -EINVAL;
>  =

> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
> -		bio =3D &req->p.inline_bio;
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> -	} else {
> -		bio =3D bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
> -		bio->bi_end_io =3D bio_put;
> -	}
> +	bio =3D nvmet_req_bio_get(req, bio_put);
>  	bio->bi_opf =3D req_op(rq);
>  =

>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 2a71f56e568d..c32e93a3c7e1 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -296,13 +296,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req=
 *req)
>  		return;
>  	}
>  =

> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
> -		bio =3D &req->b.inline_bio;
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> -	} else {
> -		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);
> -	}
> -
> +	bio =3D nvmet_req_bio_get(req, NULL);
>  	bio_set_dev(bio, req->ns->bdev);
>  	bio->bi_iter.bi_sector =3D sect;
>  	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> =

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
