Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B36C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 00:37:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21D164F8C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 00:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21D164F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=skH85v0QOssCnX1hupG5YaIWU7eLeeeRlo62mly8WCU=; b=NjMEtb0N9ef+pLIgLarO5h5qx
	3j5/s+xGeDA88ahsNAoIj7thJoIvRyfCn74sqOCM9t6VXjcixlJ02AVWKiuqAXKsxyFR/oyF55Ifn
	MBZQH2gN3lVFhxFmAWaYepwRWeVYoqfPzQODghaC4i0Pp27OCVGDBHQuNIJhQox3iCRyYYRYiEwDQ
	F7y4QHFwai2grH+E5zNW4bUe0TzusnUY+oeeHnlNMtLEzwewd6xX+kFi13HgGGx/yI7Fdb9Z4HshO
	BuX+uteW+5/YfU/SqYGtXFa1Sp0/fvNKFuhxGCsDD3sihpNtgfpOdJSKUo3pxBvukXnh35XusLele
	rmmXfV+QA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKVoB-00AKBK-3f; Fri, 12 Mar 2021 00:37:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKVny-00AKAW-Gk
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 00:37:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615509446; x=1647045446;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qRua0IUXe8gAz0UrMfqRvoOQWZF001+sHHtGxqvflmw=;
 b=HuF3nBUsHJfBARWnGjZPn5ci1TnpDPZdgP64YGsXS7JxfVW2Vlom0M42
 RI13xCv3QDmFRwS01WJXqWUmQuD6Asa6DkDMtgk5J7jtwuTHC8eKOTe7c
 v+X5Boy0pxW2Fvgpc+SaZ3/ZdJq/LZAcwRUrZGVlztJ2xtHg8GtosBsr1
 3tlkOhdloqE2OgiViD5KCRfBauX495LRknjPzt9TuFTOK8pCPlCLg9Iul
 qNJrJD1bCO7ERlrujPwq0DNfdecj4uWISqKImC7ROwivOXhzPA5XzAqrj
 g5QTLiRGco1Nc7gNlJ1rNilUHwnLTGMWgJz8GGfel/1OdsrRbadFLVFLn A==;
IronPort-SDR: /YvoLw4fhVeQiZF9WWmuw0jW6EKju+Sx5+SC/UZ3jJ7RftE2LlHwuZi7KUNuHDMD0pJN08Ykwp
 ZOeOVok556cwtI3Kan9kNU+wKe/rj3pY7YJW3fzfNj+mGu+uZ2eHOoSWBK+5gfDZf0dnzrilJI
 yWiU+Z2jWGdhDALDaxJ95X3wU9J37mdEnyaxWjml6SfdVRvRCZpWhCmyQ2Pp1Jx3waTiNU61AX
 MdcDKRMNwe50wK3jagbXasDXMmBT/HDA+gOgE8TLgT6UkYz2++eTv10SctyqpgzpluMN1qysQi
 VvE=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; d="scan'208";a="166462636"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
 by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 08:37:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiCQtqbkCa5i0M81L5SGmaQu0tyhl/ngCRKvQP76K3mEud5CHauTSC7mDploRQfWUT3XVN5etudWRSg6Zs4OsLGvc1J5KnTEpkKDpxtCFiiFn3aIZh527apllUPeWvYeXdzWQvy4EW27gxsLwfx4hxs+Tbo2685Ld3mNmDmOKUV91R6PLik4KtbbWLioC2BDrbmfUlL46F1EBxrTxJnjBwKrLHM5WA2o+l71MZipSquEBGFQb9shiLzsog6yBvoJSKNp04RsSXG5L+zO7ii/tGkXqR5KmpIAp/JNFJgU1ywd60ykfmNBX2ZkERsbHEJaH3g+Ep2kKjopCMTdUZ3uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI6lfYXYknxKtWc5DOdXxmzP255Y5NC1x/r+hRdp724=;
 b=JPsCI/VfWLzH2iyy5o6DeZnJH1/5KO4EaC3GdT97TNKZmMWymIG7rjhPRKeoc18KWDj8PkdyuKVAvq1rE+4OdFGc9DKvhsRrylKfmkIxHvhRbz3XZhSeWzhuAy7m75nE+UOHDMMAVmHrdrJqB5hBEX5rL8e7kbxEG8Gbq9x4q8MlpFoABgx6Y93mzQ+v4bd7a9ra6TYRArnTXlmflfyEslctw2buYhOzOOuvyGBFdQZbmIiLb+OMFTYijrjZ9ummHk41jIgdbOLTmbQGFmj971JGMMvjeFPv+nD2Q7H6S3Alye6olOW/Sg+4CHeOyMFvO0LHLiIorqf4Z3ZyInsQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI6lfYXYknxKtWc5DOdXxmzP255Y5NC1x/r+hRdp724=;
 b=FAHJjf5fbFIqeqgwo1wijxji9kEHJU/CZ7f1ehJi/elO6lTXRISYMx1BO1GTLqCqIOqrsaucGNiAc82A8AKAq5msxKbIOE0rf4h/LLOQ2RIITL0mbGCyHdgIDSoaLrkTxkja/qsenHhTeYC8WDGqb4leWYMewCkmxcAwmj4jNWU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4529.namprd04.prod.outlook.com (2603:10b6:208:4b::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 00:37:17 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Fri, 12 Mar 2021
 00:37:17 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 3/3] nvmet: add nvmet_req_bio put helper for backends
Thread-Topic: [PATCH V12 3/3] nvmet: add nvmet_req_bio put helper for backends
Thread-Index: AQHXFkZml8ppWIotokqvo4jgnd3OIA==
Date: Fri, 12 Mar 2021 00:37:17 +0000
Message-ID: <BL0PR04MB6514705F1E1E609E22F673B4E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc8aaa12-1bb8-455b-a54f-08d8e4eefd51
x-ms-traffictypediagnostic: BL0PR04MB4529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4529C752ED1D9E898BAB9FA4E76F9@BL0PR04MB4529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjdROX982/t8ct8oKPmh/4pLgzMwEOCXHSVwwY/anQOkAwIniukp5bxt1PhWeCcjuyve/11qHgp6jaXzjQNmOTb4zT3c+bKpQqUX2Zzn4i6RJWzqGKA0A72USVDT+F5WyZLJm0SAMgw3GyzL6GRfrDKa10wRofJVO6sjAsJbZRAibI/C3DbJ5XlXI3NcJwnSWB0Zw8FnxBZmeHEQ7/rGsuVwzVYNYlxFOk6jyCcF+16BUL6FXhdZW7UuNkEwb7/bouY7aEcSNR/czaPR7sbZfaHw9AYFypdLB39aL5FupPauG9DOOvbsCEicOumF3fCTzGSqbOCNgQ5vxIS32Coie+XOp9OXDzcdUbOVl0UqE41m04IacmtpRNcn3cvlKRZpERY2avOnkM+92LNeXd6k+XVG3ruikiph2KYVx1D1QXMxSRUykQJcP3AaU19SyTA0unHybdku2hW85ivEjpeK2ix5ZUYhs6HwbzjaFe+ozGyce6jY6Gulb5wZF2nQ243GI4gKijPoPNxgEKOs1iK6XQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(76116006)(54906003)(8936002)(64756008)(8676002)(9686003)(66476007)(66446008)(71200400001)(5660300002)(316002)(2906002)(7696005)(52536014)(186003)(33656002)(66556008)(55016002)(6506007)(53546011)(83380400001)(4326008)(478600001)(91956017)(66946007)(110136005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zacZR+3+Iqw1NWzmGCuBjCXNvTT8DZQ/Rixm9iije1159IYlzuk4NYazAV7S?=
 =?us-ascii?Q?SzSV5VY6Zr+wggAbqIxCmoIb3QrmVIUzOExXs+Jtj9lOi32DQ2oQrnGf5Ghr?=
 =?us-ascii?Q?vI2IIFD6j36gnA62TVF4S0sRpeqVFZv1bYgTe4CRE6zc299jrsHP/9u0QHNe?=
 =?us-ascii?Q?Dv2NhpcLRvVLAaragTVPOMBvNyM5LAxsQ9E0UTHsaCz5vY3DyYBQyOHIaXRk?=
 =?us-ascii?Q?QSOrAEvtWt565eHpaaW+tBuBp6UYoBj1lVKMoxbU/26ne64Lb/M1b2UaazSf?=
 =?us-ascii?Q?x+eS9b0bTDwRS/Sze10TsC8ilIwDbgrVGiS6RpomrRF+EtGPSgyIszb7PrX3?=
 =?us-ascii?Q?SZ4jAQtTmwlovXNSU47+J95KdUgRwZP+Mp3gCFHMcwsrdDgG76gyZOX//I+O?=
 =?us-ascii?Q?JT0aUNhfyD4Xgo8EhR8dMZ7sEMYrQyIRHaTlb09a0tKrv2qJKr94Ma+0JAOZ?=
 =?us-ascii?Q?lfukhIe7iQwSonVQCrjDQiW+LJiqFkeaVGo3BQQbSOHoZiz7VAeFIwFlSmsm?=
 =?us-ascii?Q?3PpmEQsGM/twqRHQ+Akksq3aFdstfwS5poo8mw6K/ge0mMI8I5yFNOIEMe9O?=
 =?us-ascii?Q?Hyr0HDsfFmUW4lB2fIuu9fXprmjh82ICAB0OZ2UFCdxlmLV2+1ascnxu8LSB?=
 =?us-ascii?Q?DxBkEZ0/QobHI5OiSvWHe+GkJN7ZgjNXm3pGQsXhyEZ6iAE184nOP21Zx6sD?=
 =?us-ascii?Q?tDj5fdHAPiwiaUSvxkY71RodObe/bSdbkQvxOBu5/o/99vRRyg8H7LEPOii0?=
 =?us-ascii?Q?MWffL4/vg65OexwP+EZQdF2kchcdU1f45Hz7pV/5FAc5fkZXw7CrR7blzxl9?=
 =?us-ascii?Q?BCvlBes6/Sv9kvXoXn1W4G16AgOwX5vOLSVkwICmgtALiOPVC3DqipnMTCQ4?=
 =?us-ascii?Q?RIjq5o0HvWw7bIfvustL/lWk/gl40FqE7edvOywWp0LnKPifmm8514t/Q3bh?=
 =?us-ascii?Q?sYFVSlbIdnLm4aGA9DdE8iuBmLgzNdxwwfX1X9yQqK+wggKSvqq7BZrnhLoK?=
 =?us-ascii?Q?kvgAyPHfFymJ1PYEN68c+odMy4+TnBYsmhA0h9jarpCQlC1pODvlf5IgUwQl?=
 =?us-ascii?Q?wABByElrrmbWZiM1Qo+dh277HYPhbtTFcc4BElgB/t4x+U3+Os8FtTmVrNdS?=
 =?us-ascii?Q?dQRLXjV8lTwsT6eXhYxYMhi8N4KQ6ET4Gb9v60e+zLU6JzZ1YPpxUkSLHdjI?=
 =?us-ascii?Q?KmtXmHFWSIHN9/CnTUAD3aCaUoTYbWWArkwxHBvYB84nczMpdrRuz7VH8+5i?=
 =?us-ascii?Q?YzX1lMcaL3hpTUTuSEcoq/LMumNdteUZGm6HFB0WAAOT0sL81teb1Z20ylbh?=
 =?us-ascii?Q?apS4c4STUNhcEUZmm4yC5Fh5CIbR56KJXtWODK8gl82/ejnLCQX8n2upBRiX?=
 =?us-ascii?Q?Q8u5gpq8WikQ4YqK/11QCZSNx9yl3oTFvtFImh4YNJjOcmVNEQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8aaa12-1bb8-455b-a54f-08d8e4eefd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 00:37:17.5056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl4p53okzIrXjDAUzZUpODFoHNCjxMg9DsTNMvGd2mffBs9JDH+0g7jtVwbc/Mo25T0USr4m2q/K5bp0ABRUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4529
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_003727_206732_8B801119 
X-CRM114-Status: GOOD (  16.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/03/11 16:16, Chaitanya Kulkarni wrote:
> With the addition of zns backend now we have three different backends
> with inline bio optimization. That leads to having duplicate code in
> for freeing the bio in all three backends: generic bdev, passsthru and
> generic zns.
> 
> Add a helper function to avoid duplicate code and update the
> respective backends.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +--
>  drivers/nvme/target/nvmet.h       | 6 ++++++
>  drivers/nvme/target/passthru.c    | 3 +--
>  drivers/nvme/target/zns.c         | 3 +--
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index ada0215f5e56..ca39d787d71f 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -173,8 +173,7 @@ static void nvmet_bio_done(struct bio *bio)
>  	struct nvmet_req *req = bio->bi_private;
>  
>  	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
> -	if (bio != &req->b.inline_bio)
> -		bio_put(bio);
> +	nvmet_req_bio_put(req, bio);
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index f3fccc49de03..2f1bd3ac34a2 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -654,4 +654,10 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
>  }
>  
> +static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
> +{
> +	if (bio != &req->b.inline_bio)
> +		bio_put(bio);
> +}
> +
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 26c587ccd152..011aeebace55 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -206,8 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>  		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
>  				    sg->offset) < sg->length) {
> -			if (bio != &req->p.inline_bio)
> -				bio_put(bio);
> +			nvmet_req_bio_put(req, bio);
>  			return -EINVAL;
>  		}
>  	}
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index e12629b02320..112d213583ea 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -326,7 +326,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>  						 bio->bi_iter.bi_sector);
>  
>  out_bio_put:
> -	if (bio != &req->b.inline_bio)
> -		bio_put(bio);
> +	nvmet_req_bio_put(req, bio);
>  	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
>  }
> 

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
