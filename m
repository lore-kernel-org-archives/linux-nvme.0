Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0904D2ED08
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3pHDaPBL65X8k5cWeOXAd4CsNY/bPzfuv8RgMdh+Yk=; b=K1LOSHIgIBoBYBLj2tovMcoTI9
	IpatdGWGYG3Y74ejHjQn6oDQ83C7auAM+L5yuopK11L6S2znraScw+Fl7o30S+sqH6tHsFOEdFLd3
	/I0+xRwpzzewvhKLzjCCtVwC9kEbn6dZVsMGlY0p5KctxQX5y2FQtPxOYc+s6uC7nXzUX8sTW8xrf
	GdkCibqMQ0PlV1f2L+uIXfYRVAzStvtrVAy8Yb+UIjHaRFm65kr1eoFWybUXBORnEWto0AuVCmNLV
	ZjaWOXPv6x32IoESVu57LmhWVn99MsM1i45IGWeeVatcyygOUgVZtnvuqtGSv5srHeX7RO4SSwGWy
	xsT7WV9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vie-0000000FK25-05dB;
	Wed, 01 Apr 2026 13:34:52 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vib-0000000FK1E-23TU
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 13:34:50 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631C6tie1384364;
	Wed, 1 Apr 2026 09:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=H
	3pHDaPBL65X8k5cWeOXAd4CsNY/bPzfuv8RgMdh+Yk=; b=dtNZ1OwG0QB6Ku+mY
	1MfSIn7lbHqJ2BLK41Q6ezSkE1S6C6hDRm73+SP/Dwp5caEofVQPsdLsXwhsL/y3
	ecF0bzlCHJD2n5yykqcNtNQzv8mupnP8y0tN99xHoIoLfSwR3Vullp52kkXlqkaP
	qaNT3MnxwoIvjPL6c1XlJehqrMEBBbXAEt+PXy0+iy6UXtlsRA+pOqUzi6vmduJ5
	N+brV5D2Eu4+fu2NSoIRpbx/psOBw+Wzfk1986xQ4sumNttPg1eZPUtqCpwXb8Pa
	anyVpXatEWOuOawifIKtkPp9HUOeIVisJurxQ1i1rQNPkImr+FxAkSm4ylm55NBl
	u5XLQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4d6a21k0x3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 09:34:26 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631COnwn2461741;
	Wed, 1 Apr 2026 09:34:25 -0400
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4d8xr0d1xu-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 09:34:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7o2PHXj4CNvlGn92Z2J+TEh73V6CzG78t4snI8umSGgyVbaKhQJsf52v6yRbKSA/sMjazWiT4Y6Na8v/LN38X6eDqdtTQf0ztHrasLLwyml0hTJsg5gtceXHpWQ/VwFp2wuTNZ3LD+gSJyPCsZ+4+nCUIDRDUhSONOAEen18hCb16JKlMZABVZlUEn7ngIkYNaiIlRIMOka77EZslaD/ZWtsalILwcW8J4DMxN5bjvMJtTNUlD4qTdfEpTVhr44R/pMjAJlgP1QzLdkQHXuh1V63Tix2C4lv8ht5+2dD2AUorCXoD4o+XnfNYB/T4oIw2p7kmoeCyDQTDwwNv8z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3pHDaPBL65X8k5cWeOXAd4CsNY/bPzfuv8RgMdh+Yk=;
 b=MM8sl8wEPhtsBWQgcikDFjTQjakedbyWt/dPbeuwE654Ixej5BxnPE7CTXSDDnDddX5Lr1G6nCajoAlehciBHKseIhiiqPoTTD0Id8bo0FTNWBdS0S+z39rAoMnr70gNZhMNIByafmJ1RYAbrekljd1ix24MB6OEFoEd+7tUV2NAkururRFhFswhFSzX9jRmQLJvaBueby2nlNpvA6RFGHw+Grx7z6YCf/k90uPSYVmlJTgu6pWX8AH1aiwCdB+pKvZ5/81vyiQBpVBjvAdo7z4C6Aks/AprpiJbc1HhbwHRVDyfNDU9zEuRrIXdiL3ppL3mjKHvpe7E+LY0W0w8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW5PR19MB5484.namprd19.prod.outlook.com (2603:10b6:303:191::16)
 by SA1PR19MB7086.namprd19.prod.outlook.com (2603:10b6:806:2b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:33:50 +0000
Received: from MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff]) by MW5PR19MB5484.namprd19.prod.outlook.com
 ([fe80::88b9:ee8a:d884:49ff%4]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:33:50 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Justin Tee
	<justin.tee@broadcom.com>,
        Naresh Gottumukkala
	<nareshgottumukkala83@gmail.com>,
        Paul Ely <paul.ely@broadcom.com>, Chaitanya
 Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>,
        James Smart <jsmart833426@gmail.com>, Hannes Reinecke
	<hare@suse.de>
CC: Aaron Dailey <adailey@purestorage.com>,
        Randy Jennings
	<randyj@purestorage.com>,
        Dhaval Giani <dgiani@purestorage.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/21] TP8028 Rapid Path Failure Recovery
Thread-Topic: [PATCH v3 00/21] TP8028 Rapid Path Failure Recovery
Thread-Index: AQNlRdb/+urnBZPc6n98WcSDogIX/LK5KqXA
Date: Wed, 1 Apr 2026 13:33:50 +0000
Message-ID: <MW5PR19MB5484E4CD6AF55ED833981C19FD50A@MW5PR19MB5484.namprd19.prod.outlook.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-04-01T13:26:35.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR19MB5484:EE_|SA1PR19MB7086:EE_
x-ms-office365-filtering-correlation-id: 1c0d1ca8-af58-4df6-0e7c-08de8ff34f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|786006|56012099003|921020|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: CNnGd769LC2XzTy7SME5M1r1rJoDu7uYfBwANPYY69ZqSnzDODYfuTMdFRRdQKXOhJKNTFI6RtlVuov0bkqvcelTTVctyOrVzjwNw+b/VlxRAD6UKtiLPUmtzzkZ3gpqznw81cTMeWtrWU045TA/BBlYxdgO0K6YyXJvwDsCPuBqf3Ar+HUdPpG50JiddnH3I/8S7yZSODG2wcw5kWzM5sONQv68OU91Kc5L/WmnPRao9R1pnVzst61q9s7jLAriqQES2C3797gJ68b/PBg5eLR9eUn4YOCNR5jYS8VBebpQJpVptcO4bMY5vs4Tv7KtN2DQYjVpIkqWCSo2uiFjBDAxRPcZn6n5RTJo4yh4P00TeCv65aNBP+/b9EBQvjTGkAAjYSSENWgAKRbQm4nnr81zWRcQN0/i6D/HS8xCdRxnT8wXT848agJEFzehFHBJUWPqoLQKzRdyzScFobRvnrx/gPA1U3wbSRrtpxF8aZkT72G7eVU+TVJfI4Y9VT+11uXgyR0B+THaKE5PoNnHTtECOalLCkzBGNTcu/MiidmMuylYR6F0oavRSnPp0XdlCAhoqv5mhixJyiwGeJov/FsbqXPlv472bQQKNKy29Rsm9AYxhQznF/gR2NQQedB+99eJXaSwgUqZfqDqdnEiIV0xWAfz5coRnnApWgoZzAzUQPIiXSzrOpV5kYH1cAwb1Ejq2r3Qu6owKNc/sxCbrHVXa4cbIyeHzIBQ2/q66vonqiGV4vXBs93d4JsMFHZ2Nuv7cQR2MG8SDq5Whz/M5/wJm/kWjpuPTuNfLAQxl33NTfWjcowkO/Dx06aaqlyZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR19MB5484.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(786006)(56012099003)(921020)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xjH7jkzkWqh4csbYb+3gnLr+HSEtpy3/6G+7frXNe7/2W4zYI01Z5S0wH4B/?=
 =?us-ascii?Q?YPtnsY/uWzksB3MrJFhlfZEjcFOe+pMnaFRNofcEJj7mxCF+bXY71pihmjPa?=
 =?us-ascii?Q?c5iwhEjPUa1n5n9BKdMMBT3KjBLc2RJAw/vBOC+UDzqNQMUTQOCnRStwH6p9?=
 =?us-ascii?Q?thB3/JH5n/1eKZvVJGHaqLKPgZKJ9cYj2uRJiSz5g9CTW9R2XsxddP8nerVA?=
 =?us-ascii?Q?ttr5Pqvvp6LpbWhysbEsG+lqKtYu5Jgv7KQO+IIgdCSnbkOpv9R2MWJzrsB5?=
 =?us-ascii?Q?/SqXrzcuqEFBk99FF5pHASoiJ8eIeTRKqt4jqcjzK5hCiN2hRHU96JhlKUeA?=
 =?us-ascii?Q?1a7lUpWhzgliw9/YU/BAFsZwc2mKkBMoeThEB3Etoi6JKXlH3y3nKLF9ejeI?=
 =?us-ascii?Q?PzFyjE/8q6C2onlu6tNZC7vEIltU2bLttM6MlZ8OvnpquNrlofn3+mDJT7WO?=
 =?us-ascii?Q?3Bv9HQ6nlJTFK1gsXC6g0MbHTZyjD9wNJpoAdYrQHrVpS2Hb4XiM8dNj1t8v?=
 =?us-ascii?Q?bjS0qWtL8eAHgRkGu1m7SamjHZXe9+u/TqtpCj8axDZUvoyFeJ8/f6EOkUAQ?=
 =?us-ascii?Q?w4nBNee+XBd7Wn58lia865auZ7aNsVsrkfGG7ybKr47pPzdx+hP52YhHSxDI?=
 =?us-ascii?Q?YtJRxTd8X4Wa+tm7dniT795A0X4QA7X0QRdyFfuYIOswXYqX1Z4MUGRa6s7I?=
 =?us-ascii?Q?GhgLUfoo//3Ah+olD951cP/H9/i7Q6+yXud5jc8c2mQEGO9fXP6mruG8UkMF?=
 =?us-ascii?Q?B+d4Gf5x8aff9mPV0/hrOk4rNCf7qkjt0/C8V8L0Wf27HGgko/Dw7kh/DjzC?=
 =?us-ascii?Q?4fB3OTBydVTX4W1gJF3tCu84RCtDKqLj0nAGpeGoYKOOpQqoogtNOwY83jqN?=
 =?us-ascii?Q?Yd3Kzz/tlyWKZ6kw0uiIjDjTk7MaEcKzQByTYjJ0cdRAZzdZ2f7K33ft7C6H?=
 =?us-ascii?Q?iBuAjiVHTaApw26Ax95VNttF9giAVpVoeIiEtvZrc39edM3toaN2FDpk6QaG?=
 =?us-ascii?Q?zyuSwYKiVdci1SqA77ZlfwcRUw7s8CtpYmLLAjEcYFVh3pAx0V/zBnYORk3n?=
 =?us-ascii?Q?8TZAL5q+OMNEH3TLAglpR8uH0+D6kUeVbUTNSYlwXANJNFObdodakGcscEws?=
 =?us-ascii?Q?hJjwQYuIW9fM9tfbF4cvVnQwqEQH/U0sKNdY7A/DM1PRTn1abBkTFs1ql/Os?=
 =?us-ascii?Q?Jw+BH0JCkT5NOdDzDnH0fiDZLhuxsPIvV3k0EM3wn5/zPYbUENHzSfD+JsiT?=
 =?us-ascii?Q?rq7OFhVrXLhEdmbZ11u3dOxv/cT9+4w+EiHMkf5RiN+wcSl7jYlJ3QlS3IYH?=
 =?us-ascii?Q?LjdXUpdVWGmI1gOfTRirnJbOhfJjQUxLc1kcyFPn3MDmLZ2ao8P+UOtjmXA/?=
 =?us-ascii?Q?fdsYWib9NqTJISviMZPUnr1EmICOC8YwLQOCGRBl/QjgdXVa+nw9yTZOVsL0?=
 =?us-ascii?Q?oZaT5ukiGRAU57Ht3oqDbBdYzRb4JCk+Dqdt6OpNia88TGmGu+8il6X61RE9?=
 =?us-ascii?Q?AURWtErR2iDyFMhUsm299cNuH/MKVMuLpRR015egQLaet41uBO12L5NX1xay?=
 =?us-ascii?Q?bk7ZWaZGBcB4v8L+RgpWRQCut0v3qmvbAIfK9LMh4CHTKGJnFY3yA8KX3SXe?=
 =?us-ascii?Q?UAj6SYE8yfgvGrXYqzhJNvTfvambyObr2AJluF97EtktNsuboYj6DTfTeKqZ?=
 =?us-ascii?Q?1tGGzcVO4YJrlP9koshX8rDW77OVK1GsfqXhF41fi0Qi+FoP9cFh9QL1IHMf?=
 =?us-ascii?Q?1CmZ67vutg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pqu1MHlvltYZ5VQKdrXTQuvLpbN8keiFGTpy6N7yvYLZrdRa6DOaP2vPVoeujvRhosYJKr/ce/zGif29wQa0d5lv20rnLAYIsZoDvLvFw5AEahdwQC39lYvPU1GeWaZ7w22x8j6mctkMNNTwUR6H8S/CKx4CZLFkc3Uc4vHs16EYf//tzfIM8EsjWZXmir6p3QrsmwPPmh0/4BQXNwZH9Ba98bWg8pR0lLAo310gCJarwzuWXPZY8K5kXYqCiY7LMasokT6x+UQ6ovG3MOegJNZPkJiJMy6cf92a3ywCDRmHpMMbeJGwwR6WBCq/4JsNfwzXd+JHVQBb+/R9bjvpuw==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR19MB5484.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0d1ca8-af58-4df6-0e7c-08de8ff34f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:33:50.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSJeun3I7hgMQOqL7PVsKxJ9kEKFnevds54OzOtFkmrYE/A37uJWf5doBSTRDwxjw3Jm3RlPw2DsgTOqTAzZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyNSBTYWx0ZWRfXxd5zJryEhJWj
 WebM7cVoAkOkOpFpNZ052li6MTzFP+pK7Ht1z0C+dbZnZVxiRaU3+S6rzFBwwtD44ys1wMzt4TA
 Zm9TEMq0UWoei3MtiuFY+pgr+pYMAinLLK3KlOi3kqjTLCHWXZyLC5CixhApAbkfA5PdwF68nd6
 /PV7neXvwKyk2L1D59ucoOD14DT/Jk65WjE84TGo8YlPwaS1DJg244fRXNbMph8o42aXxrYSvyS
 zcs7G2V5vUup7a1CSXe/Wuihnvi6TI9WdvDSZNVaHZvgx/hmQVJMWssRBt+hy7au4jcag1cSvY3
 qWcgThlLFmc8symj+CEHcwBQotc1iweP+RhWpKCTR1JPET8+KP1bjvhb8uOAS9PLVDxFsRNLL/e
 QNx7wJ6MIMtqZEU8yaP1GTuC5Ga+RHp4x1iR4wbUcxy7u0MpP48RMJezXWbojLaQ0Kfy5o16WKr
 /bbOZxdYFG8sj/+QUvw==
X-Proofpoint-GUID: QirmKaYijSg7-JwtKP50MwvbLj7i-OKq
X-Proofpoint-ORIG-GUID: QirmKaYijSg7-JwtKP50MwvbLj7i-OKq
X-Authority-Analysis: v=2.4 cv=e7wLiKp/ c=1 sm=1 tr=0 ts=69cd1ee2 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8 a=SJ2OfXpyhA-RI3pTDIgA:9
 a=CjuIK1q_8ugA:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_063449_568612_8EFC8EFE 
X-CRM114-Status: GOOD (  11.32  )
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

Hi Mohamed,

We tested this patch v3 against Dell PowerFlex as the NVMe over TCP target.
Below is a summary of our test methodology and results.

Test Environment
----------------
- Target: Dell PowerFlex with NVMe over TCP with engineering code
- Host:   Standard Linux host with the patch
- IO:     vdbench with data integrity (DI) validation

Test Scenarios and Results
--------------------------

1) Target supports CQT + CCR -- without the patch (baseline)

   vdbench DI validation FAILED. Data integrity errors observed.

2) Target supports CQT + CCR -- with the patch applied

   Keep Alive timeout triggers controller fencing. CCR is issued
   via the surviving controller and succeeds. Controller reconnects
   and vdbench DI validation PASSES with no data integrity errors.

   Kernel log:
     nvme nvme4: I/O tag 1 (b001) type 4 opcode 0x18 (Keep Alive) QID 0 tim=
eout
     nvme nvme4: starting controller fencing
     nvme nvme4: attempting CCR, timeout 15000ms
     nvme nvme4: CCR succeeded using nvme3
     nvme nvme4: failed nvme_keep_alive_end_io error=3D10
     nvme nvme4: Reconnecting in 10 seconds...
     nvme nvme4: creating 1 I/O queues.
     nvme nvme4: mapped 1/0/0 default/read/poll queues.
     nvme nvme4: Successfully reconnected (attempt 1/60)

3) Target supports CQT only (no CCR) -- with the patch applied

   CCR fails as expected, patch falls back to TP4129 time-based
   recovery. Controller reconnects after the recovery timer expires
   and vdbench DI validation PASSES with no data integrity errors.

   Kernel log:
     nvme nvme4: I/O tag 0 (9000) type 4 opcode 0x18 (Keep Alive) QID 0 tim=
eout
     nvme nvme4: starting controller fencing
     nvme nvme4: attempting CCR, timeout 15000ms
     nvme nvme4: CCR failed, switch to time-based recovery, timeout =3D 150=
00ms
     nvme nvme4: failed nvme_keep_alive_end_io error=3D5
     nvme nvme4: Time-based recovery finished
     nvme nvme4: Reconnecting in 10 seconds...
     nvme nvme4: creating 1 I/O queues.
     nvme nvme4: mapped 1/0/0 default/read/poll queues.
     nvme nvme4: Successfully reconnected (attempt 1/60)

4) Target supports neither CQT nor CCR -- with the patch applied

   vdbench DI validation FAILED. Data integrity errors observed.
   This is expected because without CQT the host has no safe hold
   period and inflight IO may be retried prematurely.

Additional Targeted Tests
-------------------------

All of the following passed on a PowerFlex target with CQT + CCR.

Simple CCR:
  - 2 controllers, one times out. CCR issued via surviving controller.
    CCR log page entry created and read by the host successfully.

    Kernel log:
      nvme nvme3: I/O tag 0 (2000) type 4 opcode 0x18 (Keep Alive) QID 0 ti=
meout
      nvme nvme3: starting controller fencing
      nvme nvme3: attempting CCR, timeout 15000ms
      nvme nvme3: CCR succeeded using nvme4

Multi-Controller / Scale:
  - 3+ controllers with multiple simultaneous CCRs. Controller A
    resets B and C concurrently. Both entries tracked correctly,
    completions trigger coalesced AEN.
  - Cross-CCR: Controller A resets B while B resets A simultaneously.
    Both operations proceed correctly.
  - 4 controllers, CCR Limit set to 2, 3 controllers timed out.
    2 CCRs issued, 3rd controller defaults to TP4129 time-based
    recovery as expected.

AEN (Async Event Notification):
  - AEN delivered on CCR completion with NVME_ASYNC_EVENT_CCR_CHANGED.
  - AEN re-arm verified: after reading CCR log page (clearing
    AEN_CCR_PENDING), another CCR triggers a new AEN.

Identify Controller:
  - CIU is non-zero, CIRN is populated, CCRL =3D 4.
  - CIU/CIRN values change after disconnect/reconnect (new instance).

CCR Log Page:
  - After successful CCR, log page fields verified: ICID, CIU, ACID,
    CCRS all populated correctly.

Summary
-------
The patch v3 works correctly in all tested scenarios. CCR recovery
functions as designed when the target supports it, and the TP4129
fallback path operates correctly when CCR is unavailable. Data
integrity is preserved in all supported configurations.
PowerFlex was running engineering code and not a production code.

Tested-by: Igor Achkinazi <igor.achkinazi@dell.com>


Internal Use - Confidential

