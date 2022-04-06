Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70A0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 22:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5meDHQ2TNk1zBH737siBC5Hzyd7E9pyxkIexlz6mFY=; b=V9+GY8ivGsjEOfqAILQ+fXO/0U
	b8bzNwaD31F4qbZ8rY5FW3jBkd8CM5hudRMuy0yrEIXLhhlyaujG1/u+0/gAipZ/CGy4/ZUkBWYJd
	2+4E2GsRXAwnh1kVgX7XFQ5CoIbVYI2w0ajaYNcUU36zbAch38y2uGRQng2vblym1Kor7yX8v52Tk
	yuUlVgp6y+3xzi25CXHWo5z9kiDI16JHa8jHZAwbIUT+aEpXioSm2pfKHDvKc26ylVYwu6BsO4U4Z
	fBXU53dfb6EpWDsPIMvk/IshkiDuqePiGb/QqIMZb/+nbs+e/VCXLSoOI8ecaWjLdCg3PwXsxI4mu
	lNj3I0Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncDxK-0086mN-Rk; Wed, 06 Apr 2022 22:16:50 +0000
Received: from mail-bn8nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::630]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncDxF-0086kp-IW
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 22:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WguMYL2kNgEO63dBpDLIbdNzEfraiJK00XNXhtByOflyffzLYJLD35mlyyFE4Km1Ys1WimJKONz1OJgE/SxRbRqcsA8WzXjKf5QwyNrh9S6tbrtwLtmptxHxmUuO2m5WZeA2Cl5/66x3Jv8zjsVV/0HjAcpAh/xnp/aZG1hyx2EbVRF8a3wNcGlK4VeRDfQ0xGYGhV3bzQthbvZYl43ei9Ld6yyd9eDsPvaeHJ/O+jQP4bAPWCgKSzGA+JdaURQvZAf1xpz55VRQWu2vxowdvSpIR223hP61lMcWjsK8X8FWvKDerhMHvvDK7h/K77fZA191P4G5Wr16i9HoJ+N7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5meDHQ2TNk1zBH737siBC5Hzyd7E9pyxkIexlz6mFY=;
 b=JsrNCISK+e97/PXb2MaYw6pSDjPJvbhQg1qpY/unE+lK0INqjzeOaKiXDAVgIkMKo0Y0wOdNPTsEcFZLeW8DYXZ5NRjjhkQWovWg3zXvD5CAMazvV5sCTp0d4SSi/yYxUVhxwZX3QA3SU7SCPIINBFZbApmg4SbXX7WT0PozmqmXddBzmQZRUO5oopCVJh31hElgBV9y9+ztrbd/T8fT+xlHtHP4BabysQVy6cQlwnKZ6nJ1PmiL46x1NgNMX0VTkAeJhl0HD3q2c+sOIc64l65+EazVZZU8j0WntPxwf6+DryLf+rWx9fkroJLC7UjsxabcTxE7ERBvOSq/NHn+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5meDHQ2TNk1zBH737siBC5Hzyd7E9pyxkIexlz6mFY=;
 b=avOvZATJbG09ANlfViKEslIvzyz/n1flb5wDA56CBIoRxSqXUYwqVzzjNc5RdBveV+n+Q8aNpu90lMA53ZQyzCSE5KysMrnKzXV1pCVUeXvecQXUbvlvKO2FXsFb/cMr3Pu7ttttYc6AALSWGxPzcZEgMn8UpoC8El1Hu/KLevw3DeyC6ZhCmvz7ndW11ylldqF5FTBh1RopMBcXKx2XCTB2HHHkHysO6HhxcLcSizDMOXFMFMZjA0QhOyniZ6mLqhllZlRCNncIYZPteRIXsG3xJ4UhVm1wcC6v/xUaisa7PHNG4j712evn119Vkp7vs/LkmHmk0ZgkfOihxYlFsQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 22:16:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 22:16:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg
 <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAAC9AA=
Date: Wed, 6 Apr 2022 22:16:40 +0000
Message-ID: <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
In-Reply-To: <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958d599a-ee46-44a4-1709-08da181b2010
x-ms-traffictypediagnostic: CY4PR12MB1432:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1432DF548A38B92EB0414402A3E79@CY4PR12MB1432.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5P8QPWSEPVzcrNDltCI+dKlZ+5X/Em+B5yGv5OiExJ/T2dNvCAt0LMO06f48kGayBzKlmg5RWS1iO81bTUvCAOwNihCiVbJtE9pGAuqxbO5jFVv6362ngnHXPCO4KZBWQs5/4jHO7SJsFxK1iHE1ocAPkJQF91hRJiIXObKCgYtj1Invql/TelDChtGRgj4FQHd8WfU+kR7MVF456iHyMEZ6ubW0WeJg2qHPJuY1p+4vhMwI9IwCYObouMPn3buQcwpnWwfIq33a99EcF0C1RFCUML0FeWItBXQ+Kth+acCiIORPJ9y5QeqAjW8HiJHboTtmZbp5mUGNUJNKPw8d5ip30uWdU5zFQdSc1bemo+qqRRgeCsvpIjBVvJb1DwLT607uOuw6Pq6Y6kyjo2sxhft5bUX/YJgBO8DBgQ7rL/8aejArjcZUQ2b1rc1Vq7xWlNYIquZcXiR/7lhCb9fLVi43DL+HMew28OheVeDmBZCbnJCOREWXhYZZ82JNitULGdtmUEwBDeZHxuq2shYiaqQGiVLFjW4lNnTvboXRsp+tCylhuoCMRt0JjyQO32yiYRo/fZkKfE4AfSFMxqt3OuDOVIGWJI6yP1/IlHcrAHZKzt/Kjq9W0Rm0d0NJ40dJ1BsdQps3+G1twQXcexw7YrwYPQol8ZQyrXyzdnIHpqk/b5Y0RKRD/Du9+gk/WJI+Ag0sqQ1cKPFtf+/iidwRwdDeh9qKsjcMeEHSxijvbllqdKi2eZjceHxUOhhiakPACpjNdBxFfr6PU1uD3JWypA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(91956017)(83380400001)(66556008)(8676002)(31696002)(38070700005)(4326008)(2906002)(86362001)(8936002)(66946007)(66446008)(122000001)(76116006)(5660300002)(66476007)(38100700002)(508600001)(6506007)(2616005)(53546011)(186003)(110136005)(6512007)(54906003)(6486002)(316002)(36756003)(31686004)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BPSkxrZndMcGVkSFNCRi9rU3h5N0RaYXl2WVI0a2luL051azBQY3hGV2ZP?=
 =?utf-8?B?WnlQc29mcDQ5VVlkY0N0QzdhZzI1TVV1azY1eUdjOUZYR2lXNmZLaDJmNFdG?=
 =?utf-8?B?RTl2cjVLOWpSNVdxUUdnU0t3UThlTGsxcDZCQnRhY2xaSTlVTkhtVGhVeEN5?=
 =?utf-8?B?S2lsZFJKWm5Tck0xbmN5bURuUnRFem5mOGplYUs0aVI4d0w2Z1lWd3h6V1Fi?=
 =?utf-8?B?WkJzOUFUcUwzaGpPdDV3SzJFTWxidy82VS84L2ZIOWlXL1Y4TmVNdCs5UTNS?=
 =?utf-8?B?QWZEdm05YTdjekFkN2lCM01XRitJb1I2VTdNc1NCcU1rRExqeFplZnZmL2U5?=
 =?utf-8?B?S2c4YlU3VzRoaTkwWG5qVjIrNjRuMEREaHdOQnpXVVBZOSthbUQ4eElCZGJI?=
 =?utf-8?B?Y2FoQ2FTYU9zRURjRVB2VW1tWktiS2lZYW1PYVRtbnQxbHBCRWJpdDFoektZ?=
 =?utf-8?B?TkdoZ3FQQnh2bVBNQW1CeHlSOHViWStRTG15M2IxVmlVdUJ2alh6ZFVHT3FZ?=
 =?utf-8?B?NVVhNmQ5cG8xN29BaDFKcUJjK09lcUExTjdYQ0VDbGptMVROOEVLRUNlenZ0?=
 =?utf-8?B?dXlZelB3ZEdmcUJuNUtXVmIzL2dYSXEwU2djeUNMcC8yY3plY1lJOVF2eDBT?=
 =?utf-8?B?ck9NUVZxcGplZnlxWFZqNElaa1o1V3hIVEFDYXB3QUJBWXJoR1A5OVJpMmpm?=
 =?utf-8?B?Nk1vSWYxMWtLbkt5QUhKbUVyV0ErWDZQQkVSWllOV3NNYi9VNHFlVTJsVkl4?=
 =?utf-8?B?REZCNU92L2tZZnoxMjZoNzdWbFFCVzJpMDcrUFptbjU1YXdvdlFXUGNQOHFM?=
 =?utf-8?B?bGtaUVNTdnp3M3I0Q2xhbWx2MW1WZ0VSUER3ZzMwM2I2SzBsOUpHdnhBUG92?=
 =?utf-8?B?aThvTzlUdkRIaXRQOTRHUmw3NzdwbGVyVjdvN3ZTWm41Vkt5d2ZnZlNCdnFP?=
 =?utf-8?B?alE4VFZtNFhoSFMzUEdZVCt6NExVUDlrL1BWbmpXUmNQbUcxOU9pUWJYUElD?=
 =?utf-8?B?Y05tUnBGcG5ndmp1anVMZGNDYjM5dnlYMHpOeExveTUzam5zNlBuV29rTmxT?=
 =?utf-8?B?UWU4ZmJtRHBDRFI0cjl4b0xod3FlMWROOWVNT21WRGNwNTV5VDNlZERseXY2?=
 =?utf-8?B?ZXNQaCs0NGthZk55VjVyWmxrcnIySTIySDZVMzVCNmp1dlhGNkMyeDFXM0xK?=
 =?utf-8?B?U0cxdWxDTHJPUDMzZjZuN3BPazd4emkxbFFpRkdmamphRUJSWHhRTjBrRFkz?=
 =?utf-8?B?SCtwNVZoVHo4bU5sdGthSlgzNk8xRlJYUEh6NDY0d1lZRkc5K3BvTzRFV1Nm?=
 =?utf-8?B?bDBLcS9DSlQzTUY0SXFTMGwwWEFVNXZwcWR4WVFHR0ZnMU1mTVYzQkNWK3NX?=
 =?utf-8?B?ODdmd0Q4RjJzQUExQklPK0xVbVJRdGZRRWVuRDlwbDdsT3RBaFdrK2VjL0kw?=
 =?utf-8?B?VDc4dDZZcFZGeGd3bnJjVUlOTThIOEFlRlhrS1BWc1hTbUY3L1k2L1RVcVhj?=
 =?utf-8?B?ZnJ4UFN2QTVBTkxvanNNejcveGgxczdydFdBTkhtem5sak1ET0pUd2s4OU53?=
 =?utf-8?B?bENFM2hUOGxQTC9oNjJ2alRBRGRSNnYzN3RzOFg2WWd3OC9DZkhKRzZQOXBn?=
 =?utf-8?B?OTBNQmdNTjk0b0tra2FOOTlBMklSdjhsQVlHMWpEeTIzUHR5eElQTG4vcXJr?=
 =?utf-8?B?NWVrQy8wVk9STUlKcWptYk8wMlBmdElsY1dlY2ZhWjdaVFlONGFpZ1c2YWgz?=
 =?utf-8?B?Z0VUOUtQRlJxMno4RmtxeDE3NC85UVNLb0dwUElLQWZDeW1ia2EzZFN3dmgw?=
 =?utf-8?B?czBRd0U3Q2MrWmw0dzQ5b0gwL1A4U2FUV0RLcGNWY3Azc1QyaVU2QjR0aEhI?=
 =?utf-8?B?YmQ0SzdYODg4c2JCY2FEc21FSUVlSkh2MDk0MDBxSEJDODdhOUFUVGIxOW5C?=
 =?utf-8?B?ZmlDdGY5WVp1RFRCMDQ5NGdORmlmakNpUVdpUjZWcDBxaURQTHROYXl5UVZR?=
 =?utf-8?B?UElhVmFyRFpzb1h6Zm82a1k2OTdjdTB0WXlHUTlVdEczUE8rSzEyUkp6ZlRW?=
 =?utf-8?B?R1RhaG41dmluU01VWVg4YUU2M01hYzNKc3g3emZDd0hlaDFFRlRRWjcydkxB?=
 =?utf-8?B?KzUwREFVak4vT0FtWHBwMHo4ck5LajlMVlBIRG5RWDZKOUZ2amQyRnRUT0NG?=
 =?utf-8?B?RnFLMWx4ejI3b3dBZkR2WkdHdjduK2hQWVdKWm8wRXlCNmprMTMvUm1NN1RD?=
 =?utf-8?B?cTQ5aWZscGNleTZtbUVxYXZ5cjBVLzlPUUJ0NS9lTFh6RW1kVzFraG1icEJq?=
 =?utf-8?B?bjd2engwaE9RWVZneVp6aEF3SjVJeVRid3dpVk9va2cyUmtnemV0QkxlU0lz?=
 =?utf-8?Q?JLXcrx+lhCj/zi3qcQLJImZQ4gwgB2MkcinDF6PbRMTSp?=
x-ms-exchange-antispam-messagedata-1: SsmEhFFRYE/+8g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C15E6554FB5B944A7EAA374B5C7F086@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958d599a-ee46-44a4-1709-08da181b2010
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 22:16:40.6361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQ/oPLu5Z6bh8OEkP79s9g8d4NeMq1MirKLRLjqLZg5kAJgHAX6SCIqh1uVxYQiLROm4ufe08P5ThyHwYmPBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_151645_686640_68698357 
X-CRM114-Status: GOOD (  21.82  )
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

T24gNC82LzIyIDE1OjA2LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IA0KPiANCj4+IE9uIEFwciA2
LCAyMDIyLCBhdCAxMDoyMSBBTSwgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiB3cm90
ZToNCj4+DQo+PiBPbiBXZWQsIEFwciAwNiwgMjAyMiBhdCAwNTowMTo0NlBNICswMDAwLCBDaGFp
dGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4gT24gNC82LzIyIDA5OjUyLCBLZWl0aCBCdXNjaCB3
cm90ZToNCj4+Pj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMDk6NDE6MDlBTSAtMDcwMCwgQ2hh
aXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+Pj4gQEAgLTM3MCw3ICszNzAsOCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgbnZtZV9lbmRfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+Pj4+PiAgIHsN
Cj4+Pj4+ICAgCWJsa19zdGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vycm9yX3N0YXR1cyhudm1lX3Jl
cShyZXEpLT5zdGF0dXMpOw0KPj4+Pj4NCj4+Pj4+IC0JaWYgKHVubGlrZWx5KG52bWVfcmVxKHJl
cSktPnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MpKQ0KPj4+Pj4gKwlpZiAodW5saWtlbHkobnZt
ZV9yZXEocmVxKS0+c3RhdHVzICE9IE5WTUVfU0NfU1VDQ0VTUyAmJg0KPj4+Pj4gKwkJICAgICEo
cmVxLT5ycV9mbGFncyAmIFJRRl9RVUlFVCkpKQ0KPj4+Pj4gICAJCW52bWVfbG9nX2Vycm9yKHJl
cSk7DQo+Pj4+PiAgIAludm1lX2VuZF9yZXFfem9uZWQocmVxKTsNCj4+Pj4+ICAgCW52bWVfdHJh
Y2VfYmlvX2NvbXBsZXRlKHJlcSk7DQo+Pj4+PiBAQCAtNjUxLDYgKzY1Miw3IEBAIHZvaWQgbnZt
ZV9pbml0X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgc3RydWN0IG52bWVfY29tbWFuZCAq
Y21kKQ0KPj4+Pj4gICAJY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+
Pj4+Pg0KPj4+Pj4gICAJcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX0ZBSUxGQVNUX0RSSVZFUjsNCj4+
Pj4+ICsJcmVxLT5ycV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4+DQo+Pj4+IFRoaXMgZGVmZWF0
cyB0aGUgYWRtaW4gZXJyb3IgbG9nZ2luZyBsb2dpYyBzaW5jZSBldmVyeSBhZG1pbiBjb21tYW5k
IGNvbWVzDQo+Pj4+IHRocm91Z2ggaGVyZS4gSWYgeW91J3JlIHN1cmUgd2Ugc2hvdWxkIGRvIHRo
aXMsIHRoZW4gSSBzdXBwb3NlIHlvdSBjYW4gcmVtb3ZlDQo+Pj4+IHRoYXQgdW5yZWFjaGFibGUg
Y29kZS4NCj4+Pg0KPj4+IElmIHlvdSBwb2ludCBvdXQgdGhlIHVucmVhY2hhYmxlIGNvZGUgdGhh
dCB3aWxsIGJlIGdyZWF0LA0KPj4+IEknbGwga2VlcCBsb29raW5nIG1lYW53aGlsZS4uLg0KPj4N
Cj4+IFRoZSBzZWNvbmQgaGFsZiBvZiBudm1lX2xvZ19lcnJvcigpLCBwbHVzIG52bWVfZ2V0X2Fk
bWluX29wY29kZV9zdHIoKSBhbmQgdGhlDQo+PiBhcnJheSBpdCBkZWZpbmVzIGFyZSB1bnJlYWNo
YWJsZSBzaW5jZSBhbGwgYWRtaW4gY29tbWFuZHMgZG9uJ3QgbG9nIGVycm9ycyB3aXRoDQo+PiB0
aGlzIGNoYW5nZS4NCj4+DQo+PiBZb3UgY291bGQgc2tpcCB0aGUgUlFGX1FVSUVUIHNldHRpbmcg
YW5kIGNoZWNrIGJsa19ycV9pc19wYXNzdGhyb3VnaCgpIGluc3RlYWQuDQo+IA0KPiBVc2luZyBS
UUZfUVVJRVQgb3IgYmxrX3JxX2lzX3Bhc3NyaHJvdWdoKCkgd2lsbCBtZWFuIG5vIG52bWUgYWRt
aW4tcGFzc3RocnUgY29tbWFuZCB3aWxsIGxvZyBhbiBlcnJvci4NCj4gSSByYW4gaW50byB0aGlz
IHVzaW5nIHRoZSBibGt0ZXN0cyBJ4oCZbSBjb2RpbmcgdXAgZm9yIHZlcmJvc2UgZXJyb3JzLiAg
SXMgdGhpcyB0aGUgYmVoYXZpb3Igd2Ugd2FudD8NCj4gDQo+IEFsYW4NCj4gDQoNClNhZ2kvQ2hy
aXN0b3BoL0hhbm5lcy9LZWl0aCwNCg0KQWZ0ZXIgZGVidWdnaW5nIHRoZSBpc3N1ZSBmb2xsb3dp
bmcgcGF0Y2ggWzFdIG1ha2VzIGVycm9ycyBkaXNhcHBlYXIuDQoNCkJ1dCBJJ20gbm90IHN1cmUg
aWYgdGhpcyBiZWhhdmlvciBhbGlnbnMgd2l0aCBwcm90b2NvbCBvciBub3QuDQoNCkknbGwga2Vl
cCBkaWdnaW5nLCBtZWFud2hpbGUgaWYgYW55b25lIGhhcyBhbiBpZGVhIHBsZWFzZSBwcm92aWRl
IGEgDQpyZXZpZXcgb24gcGF0Y2ggaW4gWzFdIGlmIG1ha2Ugc2Vuc2Ugb3Igbm90Lg0KDQotY2sN
Cg0KWzFdIG1hc2sgaW52YWxpZCBOVk1FX0lEX0NOU19DU19DVFJMIGVycm9ycy4NCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgDQpiL2RyaXZlcnMvbnZtZS90
YXJnZXQvYWRtaW4tY21kLmMNCmluZGV4IDM5N2RhYWY1MWYxYi4uZTVlZWEyZjBhYzljIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KKysrIGIvZHJpdmVycy9u
dm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KQEAgLTcxOCw5ICs3MTgsMTYgQEAgc3RhdGljIHZvaWQg
bnZtZXRfZXhlY3V0ZV9pZGVudGlmeShzdHJ1Y3QgbnZtZXRfcmVxIA0KKnJlcSkNCiAgICAgICAg
ICAgICAgICAgICAgICAgICBzd2l0Y2ggKHJlcS0+Y21kLT5pZGVudGlmeS5jc2kpIHsNCiAgICAg
ICAgICAgICAgICAgICAgICAgICBjYXNlIE5WTUVfQ1NJX1pOUzoNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiANCm52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfY25zX2NzX2N0
cmwocmVxKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgTlZNRV9DU0lfTlZNOg0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbnZtZXRfZXhlY3V0ZV9pZGVudGlm
eV9jdHJsKHJlcSk7DQogICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdDoNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICAgICAgICAgICAgICAgICAg
IH0NCisgICAgICAgICAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAgICAgICAgICAgICAgc3dp
dGNoIChyZXEtPmNtZC0+aWRlbnRpZnkuY3NpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBj
YXNlIE5WTUVfQ1NJX05WTToNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfY3RybChyZXEpOw0KKyAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAg
ICAgY2FzZSBOVk1FX0lEX0NOU19OU19BQ1RJVkVfTElTVDoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2Rpc2NvdmVyeS5jIA0KYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Rpc2NvdmVy
eS5jDQppbmRleCBjMjE2MmVlZjhjZTEuLjM0YzdlZDA1NTY3NCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbnZtZS90YXJnZXQvZGlzY292ZXJ5LmMNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZGlz
Y292ZXJ5LmMNCkBAIC0yNTQsNyArMjU0LDExIEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVf
ZGlzY19pZGVudGlmeShzdHJ1Y3QgDQpudm1ldF9yZXEgKnJlcSkNCiAgICAgICAgIGlmICghbnZt
ZXRfY2hlY2tfdHJhbnNmZXJfbGVuKHJlcSwgTlZNRV9JREVOVElGWV9EQVRBX1NJWkUpKQ0KICAg
ICAgICAgICAgICAgICByZXR1cm47DQoNCi0gICAgICAgaWYgKHJlcS0+Y21kLT5pZGVudGlmeS5j
bnMgIT0gTlZNRV9JRF9DTlNfQ1RSTCkgew0KKyAgICAgICBzd2l0Y2ggKHJlcS0+Y21kLT5pZGVu
dGlmeS5jbnMpIHsNCisgICAgICAgY2FzZSBOVk1FX0lEX0NOU19DVFJMOg0KKyAgICAgICBjYXNl
IE5WTUVfSURfQ05TX0NTX0NUUkw6DQorICAgICAgICAgICAgICAgYnJlYWs7DQorICAgICAgIGRl
ZmF1bHQ6DQogICAgICAgICAgICAgICAgIHJlcS0+ZXJyb3JfbG9jID0gb2Zmc2V0b2Yoc3RydWN0
IG52bWVfaWRlbnRpZnksIGNucyk7DQogICAgICAgICAgICAgICAgIHN0YXR1cyA9IE5WTUVfU0Nf
SU5WQUxJRF9GSUVMRCB8IE5WTUVfU0NfRE5SOw0KICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cg0K

