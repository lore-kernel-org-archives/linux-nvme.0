Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6ABC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:40:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E757922CB2
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E757922CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=miGVyv9eP6RiUoaKm7N8wAOzDSVvidcVqL9Om3dWBgM=; b=tMMxcODwrXQaceq+wih2T4x3P
	TqMAKTA37NTtEGEyGedyX0FY93lWa1rQPD5HU/C+btFxJ/fi5D0OjyJDLIDTFsK75NG+EhipXbjJO
	Vx9GAvE30sdsinGgT4QKFxoeUwBHQ3BuiDUoY7wIbtvc+5rrQx3ElufHPgTb2NKF9gj25It2ITLO4
	39WSeqXH12xjVHcQKUmB9PbBSYAw5gPQ+PpXFqiZpTibnrKkDQbPtZQ+pET00OURexb9fsTKb7KuZ
	+bD9Jm9cm2ZaZzg/2wKFabQBnIZIrv6j/mv5Y+67BOV9UnYGIinEx0IAqbPojCji5H3ilsfaVEY/t
	VDbmRgDiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCPl-0003CK-BL; Tue, 12 Jan 2021 05:40:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCPi-0003Am-OU
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610430018; x=1641966018;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=eDshTqezMtQy+1QA92DApLH0iCWLWaOIPA5OJV2m/1E=;
 b=XtP6KNyxV+VY4A09A/eBrbhUBUcYSLBqaeyqxQ87i5epdAkCI+7HxfHS
 28Nef4vL/kybgAfJiC9WG1fKFTaEsYdqKqZ7oTkiATCz+Zi1Ot+ds3erm
 k6+f+E9Dp+dbSMHHv1oEY/lcqjlvfg04dP5ONr08VqH3b1SMZ/lmcOdn1
 4u+BDxtXrQe6WwhFMcd0JmSH2C7voHnjA9w+vG8QhtedTUQo7KsnRqs2P
 Er8cFTNYavPRafDRS/ysf3ZfT6WRNx6je73Y/QAD80jFghwM2u5WGNErt
 Zdn0sJ/C7yI435TbEGS7BoIDD/ku3K0op6eD06aY3NPOFEysPDSIasZr6 Q==;
IronPort-SDR: 0pnTBNJ1v3gkwo/EaAbiPNQamsqnp9xBd2TZkOb3+X+yQibEJugqprG8WJBtwzXDXjtI5k8uzF
 Hn86oebK9EyoSdPa7rQK1W9fJ/YSx1iMPTPzJ0FCeZNnuCkh56kNFeqFg+Ixq0hHatHlaIYrwz
 L3aiNY35oEl2/MCIf5NDwkLFdPWBx/zVinkEsq31izid2Vv6gM+UutJr3FPSkL5tc3HIoPN/7M
 57Q2P/8+cZEQCgZxd4AcdSJU1WkNoWLN5Yhtum92Pfqm6a3vkrcVakGMR7GBaKwXXPioHhNvdG
 WDA=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="161652624"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:40:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnJlz6bmx1ntq7ZzcQ6bg/pxGq0ctq+E4J30QTahSECKj2wzQzaO71Qaxj9E/pJq99YEHLBZkYoKhDCDMnDgEQhzAghqRW8MxmbIEC7nZnP7fEyLSVxPWe+HXy2j63aV/M1ORPsR2gerg2p/bO0gHXNw+JYP19CnMzFehy0ae2V2pU4wIqWkROs1ozDaiaC2ZEMU1BRrVDYkzjq9v3J8Nzn8RHdfSu3qojUR9qcRHDWviX5kM127CiCBVIG4p/XFeMmeINS0N+37a3ZrbRsgEBuB/1LxbIYEu1ZpSOSwWeYgR7YXdw3PWbbJu2lwlHBWIH86FlT5Lw6+RKpoXr914A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjEK+Hrezm1wDN/3zxacgJskEfthwGItR/F6pLwv0Ig=;
 b=mVuvV9dfydH7BHT2qLQkKVjQhKE/mtX8HjV7O9D4dCI2dlOUg1nKYsAGUCrFZ8kXWu9RLqFshkydqpu7btLFzoAZG//3KQyxCufObI9wsLl4VhOuGzxvPPXHn1aWF2d1ZxxckrQoK4HWedOIqYwl1NpHKmywmi2R5hN5wrgFYuSzgDkjmANc0D27E/aeAsnaat+Ix10hyaVV80yzVc9jkFGQ/Qa+x+eR3ozaJUqzjcrCMmnn+ZXA/YjT3nX2TA+oKa9gwjr69g43SQA8zPISgbcP+iys1KtuPTHet3LRI3s0A6szyrMSKfBKapuWkzaps+WfexQsQ6xDfkiDSa8HHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjEK+Hrezm1wDN/3zxacgJskEfthwGItR/F6pLwv0Ig=;
 b=e5R8ah1kaptc3tm26y/NCsZnqP90DFfMBg72mk2Xr7Krs+spfS8RZPHVkkKq+Cbvpwc/ZcodLj33UsHSlsQY73OFnk526XAapqhSJfOmTc/j9lgPnOAKexD8WDxKJ15HmQkdlI7qeVbTV9P/dBbFbWDG4vwh9T93jMcCfmTnRCk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:40:13 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:40:13 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Topic: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Index: AQHW6Js+G6K9b/hMdEO916YVEIcZCA==
Date: Tue, 12 Jan 2021 05:40:13 +0000
Message-ID: <BL0PR04MB6514DF0B740BE6F4AB3141AEE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad36fc5d-b9db-469a-af24-08d8b6bc88db
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446BEB8C6714F926834AB2CE7AA0@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+mNqCuCR1or7zMqvmZJ1a4zm9X5TBHWP6frqIH49Vsr6Z+dkixwjbuKjnyMWltSFTOK/imVRNgIhRflhz8jOesPT6ujDf7Mlwd54IC25EFVacWBXytm1M3EGX19C83grNen95/+afay2nxnlbrCoNq7h/nO3kz14q3lp8tc8/pjNcMqQ6NA+693/5rmcxUq/dByXKlZnsFpL5vxw7f7/BvU42Kep6JE937fBRiCAPLhGcKC+VevSrDalq3K32HTg89c8lQBjVc/mf0Xb60Pr6bRVTUZ4oKrbA+ek79rzNpPEmlLhL27k+OxVBlS7hTduW6jjOyaNqZkVyZtQIM1JyZ+5sQB1cha77eo0b0idPFgb/fmyuca0fKZelwkxSVV96zVlM2/3fq6YwLgAVP8zQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(71200400001)(6506007)(4326008)(9686003)(7696005)(316002)(53546011)(5660300002)(2906002)(186003)(33656002)(66446008)(478600001)(54906003)(83380400001)(110136005)(8676002)(91956017)(66476007)(76116006)(8936002)(66556008)(64756008)(52536014)(86362001)(66946007)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vMz6nOSLOKQhG+YPM5c/OfHu0kBv83nANIptCz4Y0/Be4awW7Lv7bIC3XnmL?=
 =?us-ascii?Q?9jlRV79U8R5jxmpzYC7B+VbOH6gzaRHH3aKXONl3oZ4macj0h4nSWK4F4Fik?=
 =?us-ascii?Q?DXpujwzMlJm42aTL0Aznj/mkCTSINwoe92OZSn/17iSks1Agz0Kot574iYqB?=
 =?us-ascii?Q?iruLU14eEvLm8nmRweukM2+L4y34I/d6I92ZxvHKnrs8NhJz4tv14t6SFbHl?=
 =?us-ascii?Q?jdxO3p9CqVArgnYQSKNSuKaphWnZEFCKBfvMGYL8KvLBqzkkE2pF4k3cRMkS?=
 =?us-ascii?Q?ojKzG1HxsesDRTjMGCKARlxiQSIDlae6o7zjGKVsh6VwUnSh9raUhrKEM+ut?=
 =?us-ascii?Q?Je8BfbcCrmJYny99X0YOtfGryHUCemNrEOYSyAjUAJSQfBre1Hmw8fGyLuMj?=
 =?us-ascii?Q?9u3sfHPwbmMQl0806nVbtlgDFGPzUmL2ydG3QrBMRN6vVVw9/g+P7zNkoTkr?=
 =?us-ascii?Q?AA7nJaZx3ZkiVw0YR3paDGXXqpotViAEx4sTbwogDec20rIBAs+DhQcP8ItC?=
 =?us-ascii?Q?ckRpuDpk9zSYnNjE5IbW+wtYvMyRZJWElDh0LsDDWjFCpX6C1YnEpmHfR2Jr?=
 =?us-ascii?Q?N8UOj2Bd8vpKAVEOz+dS6O+sVkXXsa4JJt2oN7yH8r5uyQofClDD9I3dOkXZ?=
 =?us-ascii?Q?jI6QzoynnD/cr1Lker/QxlcFHJwBsbj8JHR+xSfjIW6Ea2sC+jSbeYQxVbOZ?=
 =?us-ascii?Q?kJz0lUdKokY9qpIfZxfTCoeanhJLt/AB6xw4uvg1W1kFp5ApWOQk8UaiUxAT?=
 =?us-ascii?Q?6rKghTGGS7NG3fhMmUzvubrNBC6eATGK/D5HOiynRGw//cKLIAbTRun5OLmW?=
 =?us-ascii?Q?dKfYiIBSMoqdfHJb1VCo/A96ZJfglvKHs+zM5wI1Llxih/6tKCA9V3RTvpEo?=
 =?us-ascii?Q?AmgunD8jA7VSwAcuQBWFt4lYDNr44JXNJngpaP+o8uk/QuCuZi2WFYFUSLW+?=
 =?us-ascii?Q?XGGZInq1bhPtjG0IghiCwnLjPWOkBGSiK1hPcUMxw9eS3rtnsCXHPX5gJAHH?=
 =?us-ascii?Q?XClDSUBhCeO6iRoIkGDpvRCcV+CBxTLDO5BZlMT321zWu9TtLb5EvOgLtOR9?=
 =?us-ascii?Q?Tig6QaTZ?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36fc5d-b9db-469a-af24-08d8b6bc88db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:40:13.7896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWIYVr3KKkZIomXWMWcnOWM+/xt1WNjbg9ACWdfg4+bkRbwewPc0W9dHzglmADWiExuOivorUnrAfP01wOso+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_004018_955363_B7EC5411 
X-CRM114-Status: GOOD (  20.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/12 13:27, Chaitanya Kulkarni wrote:
> With the addition of the zns backend now we have two different backends
> with the same bio initialization code. That leads to having duplicate
> code in two backends: generic bdev and generic zns.
> 
> Add a helper function to reduce the duplicate code such that helper
> function initializes the various bio initialization parameters such as
> bio block device, op flags, sector, end io callback, and private member,
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c |  6 +-----
>  drivers/nvme/target/nvmet.h       | 11 +++++++++++
>  drivers/nvme/target/zns.c         |  6 +++---
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 72746e29cb0d..b1fb0bb1f39f 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -267,11 +267,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>  
>  	bio = nvmet_req_bio_get(req, NULL);
> -	bio_set_dev(bio, req->ns->bdev);
> -	bio->bi_iter.bi_sector = sector;
> -	bio->bi_private = req;
> -	bio->bi_end_io = nvmet_bio_done;
> -	bio->bi_opf = op;
> +	nvmet_bio_init(bio, req->ns->bdev, op, sector, req, nvmet_bio_done);
>  
>  	blk_start_plug(&plug);
>  	if (req->metadata_len)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 3fc84f79cce1..1ec9e1b35c67 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -668,4 +668,15 @@ static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
>  	return bio;
>  }
>  
> +static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
> +				  unsigned int op, sector_t sect, void *private,
> +				  bio_end_io_t *bi_end_io)
> +{
> +	bio_set_dev(bio, bdev);
> +	bio->bi_opf = op;
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_private = private;
> +	bio->bi_end_io = bi_end_io;
> +}
> +
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c32e93a3c7e1..92213bed0006 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -281,6 +281,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>  {
>  	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>  	struct request_queue *q = req->ns->bdev->bd_disk->queue;
> +	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>  	unsigned int max_sects = queue_max_zone_append_sectors(q);
>  	u16 status = NVME_SC_SUCCESS;
>  	unsigned int total_len = 0;
> @@ -297,9 +298,8 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>  	}
>  
>  	bio = nvmet_req_bio_get(req, NULL);
> -	bio_set_dev(bio, req->ns->bdev);
> -	bio->bi_iter.bi_sector = sect;
> -	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);

op is used only here I think. So is that variable really necessary ?

> +
>  	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>  		bio->bi_opf |= REQ_FUA;
>  
> 

Apart from the nit above, looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
