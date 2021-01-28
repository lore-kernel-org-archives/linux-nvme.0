Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCEFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 05:26:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F7C64DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 05:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F7C64DCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VFdZ8YbrSnN8L8ogRuxHws61OJAVZDAlCrCVMenxpt4=; b=gN5/f1TnC0yvdeMUpu2I45MM+
	IVvYJoxqXNzrBhT8uNELEpm1DvwXs6Pj42uKojP/sHzLeW+s8pKSTlvC/XY+yVzA+5F410uK3ZcEI
	jGWz9iAK5a68xividekPho479NoGNtQRud9+dNgNVXm0dNZLF9MVJ8Yhla4fCuTj3Iwmlg8dPyPJS
	dkr38p5IqaMQqFKhR6dhXy2RYXX0WwaCpFPYdsdC/BWdYzjO9KEfX6561if0xMAFA7BQ7Rn5pv8b7
	XbRuLOi6uESoTP4oHX3IuF66eaqJgYannCWeWkriW6qhA2fIvwFw/VGu+MTuiXvocBvhPTfwy79q2
	p+Yk64SjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zov-0006SS-3B; Thu, 28 Jan 2021 05:26:17 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zor-0006Rr-Oy
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 05:26:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611811573; x=1643347573;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=H6zp0agPc0nMTkB+YVG5ZDKA894T+5ElMB4yzFvsI30=;
 b=NmjFS8HKHNAxCmWDG6dG1VEDBJC7GgyHSnUPSuVYF4eh2yLgF3A2EZES
 4OXz1hf0uJOy3qSw7AZn5qRbYuh8McqzX/RWBp2qeUvRn9Rc787mYGX7k
 2sYhNPUZ9Eh0OiVTl/o/i0YlPu+k0mpzvU3TnvMIJOiLbfXqEnBdk25EP
 OrIhFSJodrTNW60HZioW+5HCX0VACBBuu6Q9T0ZzCj6UsRRNRBlGauS+v
 qsjG2N3+wx9OHPizEKn6EV9uwk+98/aT2lPKBogVC8iD4flmPRUxzPbyv
 lfrEftV0IGA4dA6ys8LYWJu+QENStPHRHyF8ZbaxlZgSdMWiMPqh/AZLo w==;
IronPort-SDR: IflXg25q467Bs1FMKAviTUa0vJIMsx5c6cLuLzlSlFtvxF2q2M3Z+871X3EZQYN7rwiYMMSpA3
 lh9UrOBi7TjOQo7Lw7gztxXfCrc7aG2J2XbNPiFJi1DXt/EEmqluYIcb3P4IN0w7nnLz0QLpTH
 ycz9fkoaxOO91wzGZzzmyfjYqcBjS3c+U1cquOpQvq1FN/60vo2Be5aaQcJl8TvMfHdicFIklb
 ji0yZRbD7l5CUpCEzmHi3ukczHkmyIwReF7L8luv8uSOd9NSRgg/opTLUWZAJOGey4vg2auyvI
 Qkk=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="162957535"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 13:26:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6XzehiK3BLGDzoCDig16/btcHw29nsFAhP1aTbgIvlZSpvE3Cq0YnW86s5jnDRcR2nAp409/x7xSsNPuGD9geqlTHpSKbP2hAAju48uFgpy8AvNGEFGzWhyV1HIgm3S8GTFUK3dJfaMz9G7RwjhY4AsXT+0tefold2TtklEkTbG6iS/dIiyghIHVXNkLJZHHaJh6a5JwvICGQV2DHcldEeC8NRHl8EvwGx4GtPfFnUydNREpScxr1OsZ6qmkxqEVfGmuhuF1RJ93CiAUHjQsd6uu9gwjm2e+wtHTWUNWnx5/7bMkQDaGBUwmRcbiLkmpGUD1Gt4rwVFnMS0+ky+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6zp0agPc0nMTkB+YVG5ZDKA894T+5ElMB4yzFvsI30=;
 b=LxwIjDGu+dXjHzEqDG7vbc7ptSEHZ29o+KI02q/mIQBcqEF4X573GxD45eYvo7atGYxHPyFo5hLn4QEAH2c+03OBPZDdpFVLKKl/JTiLPeqWovPZCFy7zDQx0yrUavcsmlonRd0Y13ISndqsinoCl9nUsGbDxev7XiCiCKsORGA2ec1yCkajBVP7CS7K07vG1ANwFa1DKRj9F+5OziE6ahh1Hcy/7oaRbthH/j91feoXdqlJakD9/IoQh3FHkPm0milZajkalp1u6eN7XVnJyQAvDKBFXJqOEkrecmLyDDIYmuZ+2y2xAQg6VH49e1ilPVGUjlyfsZG6XtAzpyv4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6zp0agPc0nMTkB+YVG5ZDKA894T+5ElMB4yzFvsI30=;
 b=TjKpG9DZ5H4Z3utP8jhUYKJwOJ6anaX0Y17fDZaBRa+0WjCDyv3SW1J8/Xf9uJ+8k2x5cA1+YDbPqV2t2bIoEfleybuYZ9su6hWONdqcycOXc0S40aec7oCYJILkGf+5QThi4WsowjO1IqlyGSuEMsCrIn3F5zipWC2giGusGsM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 05:26:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Thu, 28 Jan 2021
 05:26:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 7/8] block: introduce blk_queue_clear_zone_settings()
Thread-Topic: [PATCH v4 7/8] block: introduce blk_queue_clear_zone_settings()
Thread-Index: AQHW9TC+z+KJV1CxiU6HvWRe60peXw==
Date: Thu, 28 Jan 2021 05:26:09 +0000
Message-ID: <BYAPR04MB496527AB027FB7BF084FEF9186BA9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-8-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b569713d-b25c-4b63-3fd0-08d8c34d3837
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7550A9D21C1F70744849284386BA9@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORRGCYey6iMKXLHKda/LXZTgF3kwfYvx04o024I3ARaQO1Dpwp3Hi31L6IIfMw5IyxvDDBt3iJKpzpdLjhEFz21sRZ3IM5+exmBVPy1Lge1yZFDMIiuDPlESye1buPUlM9lWIBRbPqJXB280aWTu0awZmZkMUhkZzXedofF3zgXmeY3ZoNXj54syFae4Q4p3wWoOb2XS3X3K88vcq1mGnM7hBnR7rgSjoVWxnGpYN279cRDRSGIiTIkDm3b7lJCu6f68PHIn2uWG06ydaCOj1CC4wvUNoVA73GbOEg2Iw4AvE0SYdBAgmb6sYDQ7ApU7Ru1lVtsBbtsjh6bVdREYgmn+hqXO5gWIU9D0epIH2YTh+kzvt+ZJTmrqFtf1wI7oy5Zsro2v/ctddvOtz1Pg/b8llO6MXRTZFlEii8Ub2JGGidyb7z9mmueIu8vT5IRnOEFNA0o1q+LovrI2p9t/23W/Q1SOCo3rSt9qZtcMTBnY4poSjjQ13ZknLR0B6bH/+m01Mxk/84icSXVYmvRTwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(66946007)(9686003)(186003)(478600001)(76116006)(26005)(54906003)(6506007)(71200400001)(64756008)(53546011)(4744005)(5660300002)(66446008)(52536014)(110136005)(7696005)(316002)(55016002)(66476007)(8936002)(8676002)(83380400001)(4326008)(86362001)(33656002)(66556008)(2906002)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?02I2W4tEwC8PU7CNMb7oogPgOGxdvxR+8Mc5rvXvCYLztN/HNp8x3QbaqfZv?=
 =?us-ascii?Q?ryEowLO2rwIOuCbMYN7dnAn66aWaYx14V/k3iTARfQHVerhmD56aWK1jknOh?=
 =?us-ascii?Q?aFZ1PRoTIKMjjFuOoTZi1PSI0yEQbhkw79nEgd3Wvmn65J9oEK9oiVOK6YIv?=
 =?us-ascii?Q?G+2bNJvD9jWHPF2fFvPQG3ToPhoWprrroll6k9IjSTk9F7JMOrEf4hvRLOcO?=
 =?us-ascii?Q?iDIhZQ2z4Qylv3O4obrgGuyMXzFg/WjCl18Zufq+gD1qBPOdGV7DiD0HLyKT?=
 =?us-ascii?Q?1MMQ6so9f6WHlTBZDmuMUEZNJs7bMgGW7bnolmqXrVKXt54QaGw/TKNwR5EI?=
 =?us-ascii?Q?xU2B/EdI1D3dgSNLZqNu0+n15tXrUPJwN3a63NFJ+UCs+zzvk0Iw2sFSQ1c+?=
 =?us-ascii?Q?+g2LGawl6hSPHud0PeNLtmuvJ5lxdI4t2m1PFtUJE/aMl15IlIjt/CHH0KqN?=
 =?us-ascii?Q?SgIivMGk/gAz1qRTrHYXZmD5/kQfnqmYjC+URKj3bvCy46sTcgOzIyjBfARU?=
 =?us-ascii?Q?0n/y4z2Xc3l5HT+IR68DQZqUnJ0moJ/KjWQMw23H8m2edXyr5erajSx+QL00?=
 =?us-ascii?Q?x+UrxgLmZA+n85H1Yahv8PvFIgc8uJYfo9oPFEhMMS0KVAWtCGzNJUOfO281?=
 =?us-ascii?Q?XwL2dFby0bgBnN5YZJHTzDdMXZjojyzdfomhaCl5XNcJf6HaEl4le+AvjFRp?=
 =?us-ascii?Q?GV5APyCuqx8OZa2DPBt4QVyCsgBDo6Bg/kwxKHoIO1XFVA24aALZP3QYwEqj?=
 =?us-ascii?Q?W0hp5Jqr4c6dFUrh8Ed5Ij/SxIB4zkTxsNIFHRPmkzHG3j+OBjAY/uGx6h4v?=
 =?us-ascii?Q?CHMSTHPhFOtNd5bla40SH70KVifW+5oRwga/I8wzhfIUlq3HR3Iz2S7U3l08?=
 =?us-ascii?Q?56qXzHlrwWAevkAojfabBks+aII4MFQ1uiQxzpI0qAjjBx5NHcN7YF+T5IF3?=
 =?us-ascii?Q?rP78k8NATYixdpaHx240lpCH3sOmyLrfYT0F2qqtuNx3I1GSg8LB963cZsrC?=
 =?us-ascii?Q?wBnZV4KSS/XOYNHuhvPv2pNTbVQQS0px8VxMkQvV8RrPBt3oLm7pbatEDEXt?=
 =?us-ascii?Q?lR84yWwq+dGrMmHYwTJ5l8LqKA8Nfg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b569713d-b25c-4b63-3fd0-08d8c34d3837
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 05:26:09.4818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+KFpkcy+fJe/jCl6H8S/o+4i2PvTIcO6ZrfLUyZJqQAX7w2zQ3eUhdF/Z/ys6cUEltzlBq6my1MtRYQQC8o6Fo7Objhis5/DZ4Tv6g9lU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_002613_970750_D50EB259 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/27/21 20:47, Damien Le Moal wrote:
> Introduce the internal function blk_queue_clear_zone_settings() to
> cleanup all limits and resources related to zoned block devices. This
> new function is called from blk_queue_set_zoned() when a disk zoned
> model is set to BLK_ZONED_NONE. This particular case can happens when a
> partition is created on a host-aware scsi disk.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
nit:- can be done at the time of applying the patch.
In the last line of the commit log :-

1. s/happens/happen/.
2. article 'a' on the same line with the noun 'partition'.

see it make sense otherwise ignore :-

Introduce the internal function blk_queue_clear_zone_settings() to
cleanup all limits and resources related to zoned block devices. This
new function is called from blk_queue_set_zoned() when a disk zoned
model is set to BLK_ZONED_NONE. This particular case can happen when
apartition is created on a host-aware scsi disk.

Either case LGTM,

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
