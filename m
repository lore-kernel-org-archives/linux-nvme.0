Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F60C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 06:30:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2784264F76
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 06:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2784264F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BXo1qQZfAILO6U8y6I2JcqGgYnSVwDtIOG5G2IYTEY0=; b=iWUiNxxFpkNFEW1P8NDrmf5Zq
	/U9nHH9AJEPpxWYNYKZEcwjy9cVRO9pyBJ6vVpjhSJdfVl6RFL7egnCkHM/VDeYVvUDQ9/zEMSvp7
	F4w0R7mBWzq8FyjRkxF6Uc+tG3Rn2Ccr48YV6q5NK6l/l9Ycp9GxNQ9h5LbHJT4Ass3W4I1hEYhfO
	6Cg+oRRnJaCuzndsrVlaVrR95dLBI7R30IsOL04qdyBo90LPFP1JG0HLfkck3fPI1uEtti8KuXywS
	JRbu5/oai9AyU0wMdziPFvZZSNupD5pX3OJADeLjw3O+gfopOZahGquuAlgJjAgxtTcFoSxorAgCE
	Y86VaI7NA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKbJH-00Aikn-OE; Fri, 12 Mar 2021 06:30:07 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKbJ9-00Aigk-3H
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 06:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615530599; x=1647066599;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=I9e/YPxoU7G8lAP5mRhbobneVj0HQ9yXK3bBxKZskGo=;
 b=CL+pBiFowEsvMpA1b74PzanzipzbvYWQ4MKDr0AOBXNuzLbeufZFvUpG
 rkbZZUE/cDj2hnos6iwdFTBO2Y4h6pStwK/n1Fd1CsAAJheBpdy4Bx8+0
 jDsYwriOw86U4JKcz0ZRfkOdsJaQs1pAqkxGMKQ5j0dKR0Z/s5nsU9VDN
 oKKqxosVmusDMEGK54uLKZPF+PvYSryxlti/oR4jCfze3xFHEPTS8XGem
 Kp8NQxf+Ol+nGYfROqVx4jyiw83zlanxevwDBusMRiXbuLktXTujcBiL3
 4w4e6E0QBbRTCt2bzj0jdfsBK694D5XpPqzTnXpVId7u7yby6hae/BfUR Q==;
IronPort-SDR: baVJ9NhoyJjCFO0028Q+32V8aPl9F/Sk0RLTJns5rQo21iUnm9WoH9XFTnNeV0m0l4FmOsWEri
 IqExDN1anBq9NQaok7hzoI5SxC/NhkW3i0n8fNdumXSpFgom5s+GMYKFwuHCfA86JjYYLGZWjz
 i/wp9qpoM+qRTJU+Umifo2856iXm3AsleCRsy+qOCbfy+nTMFVCjR0bmWzzJKgMS5I6lQjAypB
 986TdM1JkrPesl4wvAD27CBig9shg1fspsZB0exErtxVAUmH3hd9iSj0dq8UF5t78Swr0sF154
 iLs=
X-IronPort-AV: E=Sophos;i="5.81,242,1610380800"; d="scan'208";a="163140631"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 14:29:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4IJrAttT+1prV81a+eRv7/rHrB7wP500ja6bSt1nTinLxvHbVtNDSv6Yf+KzTwXYNEfTgtQ85XEQgdh7AkQpUJ4dAC/FaVzj11Lu2RGzZ0n56x4gkd+Jyhnfxt0/gBQejBgKwwSEsKh26FRwKnDme+9Uk+epQu8d2xZ+WJP3AI10IsF5FkWSo4COlwb2TdhoAEUYFr7gif2qeQW67U3nbDtYPFF2JsyUuBqm5T9H9cyANwQpcl/KjvYhickTMqe0yxMC3Nf5gbMeKPLza55fRoQas+HCdRCivCIM4qBS4+lEby/i58Kniem4eKn8ah+l2Drz50F9e3LAci+gxnoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u7x4R49FnqyamVq7MuExLi9SrFC7kj2u4xFOth6RPk=;
 b=ZtJ1qWIv1/pcDKc4c2YpzoKs5t9VTep5FyuRRXa9pos7QqAT2h0Wlzeizq0AnI+50qyOOvk506IRgB8BBvPBhx1FnUtt2RiN943s+qlEpiUyOCAIDlZkyjG2EHldGJ1cdqDJ9BgsJCTWNZbWO4EOpl3uCqDzP9h2Ve1M+Io7AchOLOjfb7qtFDtYr43E1/Y6nLGhpPUIrhz35vf4LE8vGVpYeriZT+7RfkSy+2Ap9apKio8mA6lRESOnhpJK1kocyTSzC7aQSilskpNpZgX9X7IWiLh3d9uCBHQ1Cug08/TI+i0j9XzI0QHqFiNpiiXxvZg5GN+sVFVSztyCZuKaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u7x4R49FnqyamVq7MuExLi9SrFC7kj2u4xFOth6RPk=;
 b=xGU7wbxRbKOjC0gxz9DliZEO/FaYWdFZO3/BfQaWOXgSVjB2sJqJyHm1HdwG4P39Gmb1zjxsEXLbiFO6nqgGbIGEsPBoMYCbKpNqSN2csZfm6470zjiAYliHeDgMqKtTo/vDJCVSJkxeQiPJzExXcCL1zFEONYUxkgg51/q1q30=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 12 Mar
 2021 06:29:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.042; Fri, 12 Mar 2021
 06:29:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtzlyRTj6MdkG4iVwqsOEFzw==
Date: Fri, 12 Mar 2021 06:29:49 +0000
Message-ID: <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8b6ebff-95ed-4f56-7374-08d8e5203cff
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB395835E12C2AF838BE8BDF43866F9@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DVDuHYJHYXkOACAekAZL9zEGDVT70Lacs7Zv5x3Hmx6nYbhKYTxdAzrcwEje8VFWZkngP2FQuioYGyAG5dJDP894CsTgGBsb639wh6TJumWpR36bMGEUYAUL2i4kRCI4hzRZNaVPbVvYuIuoCzJ908JEAvj/zEoMemfwI2pAmYrc149RhawHTFygfe3YHoxybm8DQtyzR6tnHeRqN3tAx27NHJ9ArUFJ2xMnc7cqLPD4WRD5QtiIwDuQigO6vhe7Vv92hcNuZ9hkmdjpYsBCPK0KCmrn5u/obaCydKyofe4wLwUevazdwjwQwsOYO4jozojNgOM9vBfwwGLwfkmJUwFEEi1nk0QqnGPIkjVpmSrCGetvn6AOv2wLEW65mKZCB0ZOzyzUHpw96loLGg3d0Cfwa4llEYsnvjVyP8Frx39w1UcGdlFdjNSqZA9Qos41PlFyOmkuzS/8wYMoU8XAGkZPy5alVhT8BSkVt2ExBgk0rqbYJAER8c6krbYJs9OqrFg8VbccIUo9FPya2bEvcKebwuLaDdDO5VkFcJkq0xZfQv0OP27a1OoLThUq3jY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(7696005)(6506007)(52536014)(2906002)(8936002)(8676002)(478600001)(9686003)(33656002)(66446008)(64756008)(30864003)(54906003)(83380400001)(110136005)(66556008)(71200400001)(76116006)(66476007)(55016002)(4326008)(5660300002)(86362001)(66946007)(186003)(26005)(316002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u4qZ9hEj2XaGZNtxOnQeVaTT+5H5ZyDkKewiuQM0IdRR9BIM15U+X+tzjJP8?=
 =?us-ascii?Q?NvSZoc5FcDAUQHnysgWYr9YbNYBuBd9ARMq8FiXY7ET001Php9d3v6TbOlVz?=
 =?us-ascii?Q?Ds/Y0dXJKRkYwVo1fXhU3ELoXhuh3EVDQ9FG8NtK7cWmb2epbJC6QlK6ugFi?=
 =?us-ascii?Q?Clvk/9toYH0GyvHYHpugb3n3ZTnw9d9xr2C9IerfhPGIoqRSycDkUXxISWg6?=
 =?us-ascii?Q?ItkGMnT9nVUcgAnd/h8Rh81ezVfAQGfKCI7iCr+TJNRrDMSBdndg84QiBD5E?=
 =?us-ascii?Q?UYc0ucd8MWAPOzVrbfxwuB9bhgh+1M6lkS75xNzKLVcm7nKcMYVWUnr7kkK+?=
 =?us-ascii?Q?4ytZWlZPfi9Q79GJ+fr4N2QZ64KJGOTbjCTRDJYhAU6AnCb3DnqLPFFsLUZU?=
 =?us-ascii?Q?xAI/CCK/I43bOOw1hUrKbphmmrXFaScHILw32NWTFhtISzjuwTT3VckzfgEr?=
 =?us-ascii?Q?TT8gx8BkJq5D5ePP5ZW+TNHY+aC3rHaNtv8wAj6vQd7y2HiYCogZynKamrEi?=
 =?us-ascii?Q?oXszDnecw4o0DBwfKjZ7cHjJ2GNZ7IVv86WEdX9co4pXNxr4jorVyc++huVW?=
 =?us-ascii?Q?LODxWB6fE9PjNHimf+A+UNYFTmJCduoe+VmGyHzxOBOLFSEjbiQxI0ybKigd?=
 =?us-ascii?Q?27FGOEMKuL+B7zdlEYs6QzC38UcUBi+sSUWXkzvKCbLEft2508N4zVPanqAG?=
 =?us-ascii?Q?qeOC1vUR5cMixXKQfFOAfd6LOoZ3QNub+5PXgNaZ1XAyq5VGw6RJzBrvNGwP?=
 =?us-ascii?Q?1yygRbxB2pCQ8sgF6qpTp6N5xMsInj9nFrNOkg/xzC9E4pG/dqB9Zhknx34L?=
 =?us-ascii?Q?yEPKnHqPejbLbt49KNbHD2A4W3feGDGYrf2EcOCuPiFmJnLEBXOUV0172HAZ?=
 =?us-ascii?Q?8IXt4xU/tPaN0cKKGTVOwst9mrLTyl/ToJKzp70BTuYZj1oarNpdxavJyrMC?=
 =?us-ascii?Q?vkrzx31SCco2m7Tmls7FUJdZiHaaHr49YsIEuiDOHCdLn9pBdV7nmQHhE95G?=
 =?us-ascii?Q?ybPhMFncZY0IBAi5x/TEpsUVnDAh7oBWCxQOiD/uKRq5SXycO1dFSZIla0Z8?=
 =?us-ascii?Q?mtnxVaQlCBnSb1jiwM71JtmiOSDnLFpx8X5kpcnERPy+RXlGL87MOaVSudBu?=
 =?us-ascii?Q?JOMUqhE3bDHM9lEJTU793723yg1yYu12orOBoQ7KFbVDWMFXWjp3upHQC9BT?=
 =?us-ascii?Q?QwhlG+re1iLBErY1MVa2XizuUa4Wy3CcC+V9H0xAPwS/RdOUDYOO4tKENS+R?=
 =?us-ascii?Q?ZiaE1guing8tUMGMGGsh0YXD3T4EQXm/EyV9HQkOwxO6Gq2ovW/GJuORno2N?=
 =?us-ascii?Q?xNsjQDZD45jth5SSffQHcSP0?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b6ebff-95ed-4f56-7374-08d8e5203cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 06:29:49.7194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKoYHq/V1cw5f6VxfZvNaAO1EYrjR5Ae/pcYYc5XqM9uY4OdrgS8nklKdOud74xJD83L5/TxowSEpNhk1r4w/nQ+6Ba0jKWDXtK23w3m4yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_063000_110206_03A495D4 
X-CRM114-Status: GOOD (  27.10  )
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

>> -
>> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>> -{
>> -	if (ns->bdev) {
>> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>> -		ns->bdev = NULL;
>> +	/* bdev_is_zoned() is stubbed out of CONFIG_BLK_DEV_ZONED */
> I do not really understand this comment and I do not think it is useful.
> bdev_is_zoned() is always defined, regardless of CONFIG_BLK_DEV_ZONED. If
> CONFIG_BLK_DEV_ZONED is not set, you will always get false.

Okay, will remove the comment.

>> +
>>  static inline struct nvme_ctrl *
>>  nvmet_req_passthru_ctrl(struct nvmet_req *req)
>>  {
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> new file mode 100644
>> index 000000000000..e12629b02320
>> --- /dev/null
>> +++ b/drivers/nvme/target/zns.c
>> @@ -0,0 +1,332 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe ZNS-ZBD command implementation.
> s/ZBD/zoned block device
>
> "ZBD" is not necessarilly an obvious acronym to everybody.
>
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
> This should be:
>
> * Copyright (C) 2021 Western Digital Corporation or its affiliates.

Will fix the header.

>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
>> +{
>> +	/*
>> +	 * Zone Append Size Limit is the value experessed in the units
>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
>> +	 */
>> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
> s/9/SECTOR_SHIFT
>
> And you could rewrite this as:
>
> return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - SECTOR_SHIFT));

SECTOR_SHIFT patches are nacked, reason being it doesn't make code
clear, how about following ?

return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - 9));

>
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>> +{
>> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
>> +		return false;
>> +
>> +	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>> +
>> +	if (!nvmet_zns_update_zasl(ns))
>> +		return false;
>> +
>> +	return !(get_capacity(ns->bdev->bd_disk) &
>> +			(bdev_zone_sectors(ns->bdev) - 1));
> It may be good to add a comment above this one as it is not necessarilly
> obvious. Something like:
>
> /*
>  * Generic zoned block devices may have a smaller last zone which is
>  * not supported by ZNS. Excludes zoned drives that have such smaller
>  * last zone.
>  */

Will add above comment.

>
>> +}
>> +
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>> +{
>> +	u8 zasl = req->sq->ctrl->subsys->zasl;
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvme_id_ctrl_zns *id;
>> +	u16 status;
>> +
>> +	if (req->cmd->identify.csi != NVME_CSI_ZNS) {
>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
>> +	if (!id) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	if (ctrl->ops->get_mdts)
>> +		id->zasl = min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
>> +	else
>> +		id->zasl = zasl;
>> +
>> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>> +
>> +	kfree(id);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>> +{
>> +	struct nvme_id_ns_zns *id_zns;
>> +	u64 zsze;
>> +	u16 status;
>> +
>> +	if (req->cmd->identify.csi != NVME_CSI_ZNS) {
>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>> +	if (!id_zns) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	status = nvmet_req_find_ns(req);
>> +	if (status) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto done;
>> +	}
>> +
>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto done;
>> +	}
>> +
>> +	nvmet_ns_revalidate(req->ns);
>> +	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
>> +					req->ns->blksize_shift;
> s/9/SECTOR_SHIFT

See my earlier reply to the same comment.

>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>> +	unsigned int nr_zones;
>> +	int reported_zones;
>> +	u16 status;
>> +
>> +	status = nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>> +	if (!data.rz) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>> +			sizeof(struct nvme_zone_descriptor);
>> +	if (!nr_zones) {
>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +		goto out_free_report_zones;
>> +	}
>> +
>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>> +					     nvmet_bdev_report_zone_cb, &data);
>> +	if (reported_zones < 0) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out_free_report_zones;
>> +	}
> There is a problem here: the code as is ignores the request reporting option
> field which can lead to an invalid zone report being returned. I think you need
> to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
> passed by the initiator and filter the zone report since blkdev_report_zones()
> does not handle that argument.

The reporting options are set by the host statistically in
nvme_ns_report_zones()
arefrom:-  nvme_ns_report_zones()
         c.zmr.zra = NVME_ZRA_ZONE_REPORT;
         c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
         c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;

All the above values are validated in the nvmet_bdev_zns_checks() helper
called from nvmet_bdev_execute_zone_mgmt_recv() before we allocate the
report zone buffer.

1. c.zmr.zra indicates the action which Reports zone descriptor entries
   through the Report Zones data structure.

   We validate this value is been set to NVME_ZRA_ZONE_REPORT in the
   nvmet_bdev_zns_chceks(). We are calling report zone after checking
   zone receive action it NVME_ZRA_ZONE_REPORT so not filtering is needed
   in the nvmet_bdev_report_zone_cb().

2. c.zmr.zrasf indicates the action specific field which is set to
   NVME_ZRASF_ZONE_REPORT_ALL.

   We validate this value is been set to NVME_ZRASF_ZONE_REPORT_ALL in the
   nvmet_bdev_zns_chceks(). Since host wants all the zones we don't need to
   filter any zone states in the nvmet_bdev_report_zone_cb().

3. c.zmr.pr is set to NVME_REPORT_ZONE_PARTIAL which value = 1 i.e value in
   the Report Zone data structure Number of Zones field indicates the
number of
   fully transferred zone descriptors in the data buffer, which we set from
   return value of the blkdev_report_zones() :-
  

   reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
					     nvmet_bdev_report_zone_cb, &data);
<snip>   data.rz->nr_zones = cpu_to_le64(reported_zones);

   So no filtering is needed in nvmet_bdev_report_zone_cb() for c.zmr.pr.

Can you please explain what filtering is missing in the current code ?

Maybe I'm looking into an old spec.

>> +
>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>> +
>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>> +
>> +out_free_report_zones:
>> +	kvfree(data.rz);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>> +	sector_t nr_sect = bdev_zone_sectors(req->ns->bdev);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	u8 zsa = req->cmd->zms.zsa;
>> +	enum req_opf op;
>> +	int ret;
>> +	const unsigned int zsa_to_op[] = {
>> +		[NVME_ZONE_OPEN]	= REQ_OP_ZONE_OPEN,
>> +		[NVME_ZONE_CLOSE]	= REQ_OP_ZONE_CLOSE,
>> +		[NVME_ZONE_FINISH]	= REQ_OP_ZONE_FINISH,
>> +		[NVME_ZONE_RESET]	= REQ_OP_ZONE_RESET,
>> +	};
>> +
>> +	if (zsa > ARRAY_SIZE(zsa_to_op) || !zsa_to_op[zsa]) {
> What is the point of the "!zsa_to_op[zsa]" here ? All the REQ_OP_ZONE_XXX are
> non 0, always...

Well this is just making sure that we receive the right action since sparse
array will return 0 for any other values than listed above having
!zsa_to_op[zsa] check we can return an error.

See nvme_sysfs_show_state() if you want.

>> +		status = NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	op = zsa_to_op[zsa];
>> +
>> +	if (req->cmd->zms.select_all)
>> +		nr_sect = get_capacity(req->ns->bdev->bd_disk);
> If select_all is set, sect must be ignored, so you need to have something like this:
>
> 	if (req->cmd->zms.select_all) {
> 		sect = 0;
> 		nr_sect = get_capacity(req->ns->bdev->bd_disk);
> 	} else {
> 		sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
> 		nr_sect = bdev_zone_sectors(req->ns->bdev);
> 	}
>
> Easier to read. Also may be rename nr_sect to nr_sects (plural).

Okay, will make this change.

>> +
>> +	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
>> +	if (ret)
>> +		status = NVME_SC_INTERNAL;
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	unsigned int total_len = 0;
>> +	struct scatterlist *sg;
>> +	int ret = 0, sg_cnt;
>> +	struct bio *bio;
>> +
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +		return;
> No nvmet_req_complete() call ? Is that done in nvmet_check_transfer_len() ?

Yes it does, you had the same comment on earlier version, it can be
confusing
that is why I proposed a helper for check transfer len and !req->sg_cnt
check,
but we don't want that helper.

>> +
>> +	if (!req->sg_cnt) {
>> +		nvmet_req_complete(req, 0);
>> +		return;
>> +	}
>> +
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->b.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +	} else {
>> +		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
>> +	}
>> +
>> +	bio_set_dev(bio, req->ns->bdev);
>> +	bio->bi_iter.bi_sector = sect;
>> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>> +		bio->bi_opf |= REQ_FUA;
>> +
>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
>> +		struct page *p = sg_page(sg);
>> +		unsigned int l = sg->length;
>> +		unsigned int o = sg->offset;
>> +
>> +		ret = bio_add_zone_append_page(bio, p, l, o);
>> +		if (ret != sg->length) {
>> +			status = NVME_SC_INTERNAL;
>> +			goto out_bio_put;
>> +		}
>> +
>> +		total_len += sg->length;
>> +	}
>> +
>> +	if (total_len != nvmet_rw_data_len(req)) {
>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>> +		goto out_bio_put;
>> +	}
>> +
>> +	ret = submit_bio_wait(bio);
> submit_bio_wait() ? Why blocking here ? That would be bad for performance. Is it
> mandatory to block here ? The result handling could be done in the bio_end
> callback no ?

I did initially, but zonefs uses sync I/O, I'm not sure about the btrfs,
if it does
please let me know I'll make it async.

If there is no async caller in the kernel for REQ_OP_ZONE_APPEND
shouldwe make this
async ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
