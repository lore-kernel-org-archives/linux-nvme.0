Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53B6C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udCsXhRL5byayg74PgR1U4/TFasXDoU82Yzxz5M8zuI=; b=mM7WmWhBEBFpUuKT2UGsji6sN+
	uewQfqXPAD24+51KMqaTy8k/kYtSlrOZV7XNFLG37uHUt+83sHW8em8yLBytwDQ/lQCanbpyuZncK
	9SDwoSCrol9D6hBa4rLW1Ag/yp11uLX9RycSIG3XtRsqN15OCFW8aFsvwLX0veKhzcSA9WahLiins
	A4O/9ohllmGmxNSj83H6B04liWAoxFD0Qe5+gNhVvSKLRfqCwgRwatLAibYdFQHrDmaKxwm3r0Hqo
	+tEg05s+1scRBrlNlOukmXnu1DPhlbIzkG//74BGZ33iIrUHQdDLHExOE2/13XKegmjMQ4FPwx683
	WFvU3B2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal2M-007Ap4-A4; Tue, 20 Sep 2022 21:44:14 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal2J-007AmC-Qu
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKfZx9y6zxJGa/kjp/TFZvVRft/DoS9Ejac7yV2ehlj0CJtl5Yi8fzf/UhJXVVaj+20RrPY5m7Fe3UNgrdC8nY8wzZvOomZOWet7Osp1nMkWxT3MHwCjNcmM1hbZn6I7K1k2CUpB97PWtccKiMZf/tGF1gY4cvqStloWlPCBZwEsPqzZEc/KvDTOW11oSktuLZRb4pHr7hb5g5T1B/nBhT56cJN/qU8UyD26jRceHPq+mHOpd1I/8SUa0C7oyO06c45wVx7u4+gxRd0QWnE5C1CkvbZ3GZxgM6gn9JX9y0tAZyZ0s38r/Z4k0WUL4ZmQY/7uyeTjM0kkpy3EahKC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udCsXhRL5byayg74PgR1U4/TFasXDoU82Yzxz5M8zuI=;
 b=hRzFh7hrQY18/niG7MZgAxBnQBMQx9ttuEESCpB0sUE177P3TNSkc0kULbpGdrke0RINphHpawg6HRJU6uqEWpn9iWzNu6tjaa1D0aeDMxMmy637hfz4bw4eDKlPcQv0hG73GtfJDfwro19jAbSIZYv58uMn7g/n4ZSGFnzJQao/rrPQws8mXRCMKzWiGp1en4rZGYxX/2r7bRPFYbC0/990wsNXqO/VOKRx7oRmtfJ79Kxpt34tL0bTDEjCgvhLzPBK+mb4WPdQ4TEtQWXqjM5v4TenMuFkEI7IUrp/eiEe9O6CkV86FVWyhskYnMTh0IYd4G1x/QaO9O21uTmYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udCsXhRL5byayg74PgR1U4/TFasXDoU82Yzxz5M8zuI=;
 b=llZlT8jxYRGy3tVw+mXzXcEGE9PEdO1EtfL9EeqfK9HuMdPz1Qk1uc3hO+CejQP0gGu48teoInpa7hq27gGK2q43HhLSkvElrO8/5tqmERQsGYjS+UWcWzuoOgM3C9i64TdUagkWY3+RiBWkYOGZ6dEdV2C8c9D9xw1Umuy4q55Cs2dFndwysY54Oq9rvmuL3Fw9t51bQGA+3AEpAH7iYN7Tbki03Kk+iBv5gL5tW5MmnU4jVyeL59VxFuCM73hE/4sBQQ8igmPkzob7+7219HgIQiSgVYPdqUfHhVBYCI5OtxdgGF3H/fsUKcJCyErvPNA3YCnZ94GTeYn8Tg16/g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 21:44:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:44:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 04/13] nvme-tcp: use the tagset alloc/free helpers
Thread-Topic: [PATCH 04/13] nvme-tcp: use the tagset alloc/free helpers
Thread-Index: AQHYzRTaYNoNwRgyfECS7s9ZPoq4IK3o2g6A
Date: Tue, 20 Sep 2022 21:44:07 +0000
Message-ID: <2123a241-ce6e-2162-8926-4c946b9606c8@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-5-hch@lst.de>
In-Reply-To: <20220920171611.1289361-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: 564cc320-77c8-451f-f06f-08da9b513ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  iDFtw7O0m0zmRCt+V9lrUON+eJX3DEpRNLbNUToY4HwI0A39yLwmYWKkbDyl1q68IIzv6ddXZBYhQE3ZYIa7GkYdOLImsD/6ahslZAR7GvYAlyFQ+hpVUB6Mgo9Bgmm36bT2YmdtLtEkqCvZBKw597aViqZ5NCu9Q75fzpB0zK/dRQzDqowSSmKDBlqa3ABNx7G1Ieu7etideeaimgBdhjNCrCVYUVtrlVyYG++Sqd2yxC3biJu/nIOW+n0+CPnouYgT/T4sDRa9suObAO6QPzYYMDiyUWuZRJxIeP8+fpw74uzn7OFLGnHGJG/7dpmAtQEbYJZafrAPJPqe92BoGW8QmcvPRiAwSQzG3KXrFNuIYpTVE/KwZMssN1IkLNnKnLaxVStJ+1tlnTBXmwKHyeNxdvzamXI1x5m0H4l3LNEq8lvVH5wc7LbWF8B2rihWRj7XL0D+AIr90iXC/UuJYylMvt0xmSX+LtGfk8TI4GCqxHMHX1mAsFz1UCvTEc779v2KzZX7gdXegZ3uS4r56WxKlvxRx5u5H3MmwkRsbiNFaNNI/zCleyXrd4OdU9yQXE1+a/DV8U0bxj8ZXCDP2lq8LMdhJoS80fYwh6gUnaEBwspGhCC60L5/Tr5azHQKARiFckwrfimvTPi8BzJobIigUJikIwoQ2unQtSRxojATuXKhy2dRv9/OKDohorE/QSCdwUQVMlc1DTklx8/9Qj1IrRa2msBj/++P+/ToRgYUQBdZ/WzRWxojStREOjZEmAC1cwzeKXRP7s5mpVvMC/INFbSfOfaxZyoKEdyj1rAcusxXyR1GwoqYoekol0/Epcx0rINqekYN82KGN16oDg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(6512007)(6506007)(53546011)(38070700005)(316002)(54906003)(6916009)(478600001)(71200400001)(6486002)(122000001)(86362001)(2616005)(31696002)(186003)(38100700002)(31686004)(5660300002)(8936002)(4744005)(2906002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(36756003)(66946007)(41300700001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?U1ZObWlCRW14NmJpNzliVW5wTStHVFNCNURLOXRvVXMxM3dQRkhwWktaMjhh?=
 =?utf-8?B?S0hqbEV4N0s2NEsvcUxmaDRqUHkvRjRFc3k3ZXJLRlpsN3N4dU91Z0kyakVH?=
 =?utf-8?B?Mkl5WVBTaGtsZFJvd1pmd25rc2ZUNEhXcWJWSnMrOFE5SkJ3cWNzTVhBSlBN?=
 =?utf-8?B?L2dOVENOZitpaDJYYWVJZDBZa1BUdCtKd3M3MVpZMFgxcUZCZ0pjVWdpVjBx?=
 =?utf-8?B?dlVyeUpEVjhnUmVhYzlMcThxVTY4UXZQQmlZdVI4NGhmY1ZlS0lEeFVwckdT?=
 =?utf-8?B?cmFEVzZ5djFWSFgzZUNpNWkycitTWkVxNkduZkdHTmRyaWs4cEZaVFRjR3R4?=
 =?utf-8?B?VFJ1RUxwcTdYcGM3QmNBWm1jeTc3MHpjOVdnREdZZmhwZVhjSTVzQ0Z3SE8x?=
 =?utf-8?B?dVlSWExRTEFWdzhTTWFCOUowTHJrWTNlWVUvcGlLZlhyZ1dGVkdQYTJwTzdm?=
 =?utf-8?B?UnZRWUl1MkVwYzNjQUY2VHY0cUx0WGZSdFR2NEtSVU9sUVNORmZNbTZ5U29P?=
 =?utf-8?B?cVo4TGNoSDFQTS9lUkMxUXVKVTFMWEFXU3p2ZDdMbWlidW54QlRremM3V0E0?=
 =?utf-8?B?MlloU1NYM0p2TTVFc3podW95V1lXVnlTaG1VRG1IQ3BVL212VVNtQXhCcXZP?=
 =?utf-8?B?WmRxb1VMQ3dQSlUzSXFua3JiaHphaXRVUlJaRXcwcE9FdnR0OEw1WHE4Rm85?=
 =?utf-8?B?dkFwYndCSFg0ekd1bFNSUkRMaWhaWGJWdjZwYXBRNUNJRFdMS2c3MjNkSnJ4?=
 =?utf-8?B?dFN3a2h1VG1CSnlRbGJheUlGVkVSNXpsZUNsdlk5eFdvL0N0L1lDQ1VybEpU?=
 =?utf-8?B?RkF3bHBVUmx1WWdvQlBRZ1hwRGh6aFBGYmQraC9wY1RZQmhyUkNTUko3Vzlp?=
 =?utf-8?B?cVAyRCtBUUNHNzlUWjYrZE52L1Jjc3QzU3N0OGhuVHM0d2pMSnYzWVBaOFcy?=
 =?utf-8?B?QWM3SEJjU0kwQ2o5UWpvc3FaaEdBSWVVZzBLREw4cXhvTCtvaDdIUzhZZTho?=
 =?utf-8?B?cW5ybEF2Q0FObzlwQlNTT0ZuZTN5aXlXZVUvdmMxUFJuVzZSeWNkUTd5dlI0?=
 =?utf-8?B?TVZvd0tWVzRYQmNWQVJOY3huZnlGTjlCOUFINWtHV1h5N0pHNTdXM3FrUlh2?=
 =?utf-8?B?SVIyYUhEazcwODQ4UnpoMnZmUk50c2RyemNtOThBUmJvK2RVZ3hzbkhSUHUr?=
 =?utf-8?B?Mjd3bDNSOE1TYXpQUDNUM1NaN2ZrUFpYSXJZS1ArWnY2RUNrZWliMHNEUnVq?=
 =?utf-8?B?QllveEhsdVhmNngrYkNGbk54L0dVMGJxVGV3Smh3RzQraGQvL1U2d2dmK0xs?=
 =?utf-8?B?T0pkd1BTTy9Kek1MODN1YjJlRjdZeHlWa0k5Rzh3aWpqR2xsQ2Q0cll5MGF1?=
 =?utf-8?B?NlpOUXdvMzVmTjArb2tGYmJqTmhFY25QY3V5eTJXMjJLc0I5NFVmc01HV0tx?=
 =?utf-8?B?dFJid1RzdFliUU55SHRlRXBkODdCUGg0MEtMSTErVkx4UjZPbVlndXVQU2p0?=
 =?utf-8?B?UlEwUTB2TENLeTJ5aTIwaytORytKb2tpSlVwekNaOG83UXEybHZ4ZzVjek5Z?=
 =?utf-8?B?UGV3TGdUN3lmU3JuWEI0R1dYeHQ4ZmRvcitHTHM0V0twQXh4NExsRkZnOUEz?=
 =?utf-8?B?WmhwK1k4NTMxRUlTSWdpTzhxOXl4VEIrT2VjLzcwR1JKU3dHelo0cnZWbWxF?=
 =?utf-8?B?ZmRFWkN4d3ZObDQ4L2x6T09ncWNkckRHT2NTQ1BTNXgwaFFlVlVrbnBMMEhT?=
 =?utf-8?B?WlZiQU9ZUldCWi9ZSTYwWWtCK1VmMjJGdXR4M25xMjQ2M3pYTTNoR1lVb2R0?=
 =?utf-8?B?cDhsN09DWEVBY1hsa2tCdUVRYkR6bjF3ekhzQSsyUThkck1DZ2xudW0zZkls?=
 =?utf-8?B?U2IrZ2hpYjN0M0FvUFdhNmlmOXduc2R2eHV1NVdxMC9iOW9FSkdINHUzQTJt?=
 =?utf-8?B?bjVUNmRhc3NqOEY2dlVFL3JzanYzK1ljVXJKQktNNVpZZy92SzB3Q2Jac2Rs?=
 =?utf-8?B?YTZ0enVQUDFQdHV3bkNPbFlJY2g1SEpvd3UxeUI4eXZlcUszdDFRVXhtS1Zn?=
 =?utf-8?B?VzNwTTM1a0I2WEttbVFwV2V3YjlSRkswaXV2TFdnUXFqZFgrS3hwajBkTnov?=
 =?utf-8?B?VWZOYjVsYVo2QloxK3pFd011aE5WWWI5cXp5TzM4bzFPZXp3WTVlWDBZQ0dB?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C0BC0485158F044A8796D0205E0779B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564cc320-77c8-451f-f06f-08da9b513ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:44:07.5306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MBJkmcpE8BzywzwYvDBIZxty0y57AIFSVtXS4Z+1xohvmx4RAZxeah2MbO3ncaduMVeVcz9WXNiDStD0DoFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144411_892780_B140470C 
X-CRM114-Status: GOOD (  11.31  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUgY29t
bW9uIGhlbHBlcnMgdG8gYWxsb2NhdGUgYW5kIGZyZWUgdGhlIHRhZ3NldHMuICBUbyBtYWtlIHRo
aXMNCj4gd29yayB0aGUgZ2VuZXJpYyBudm1lX2N0cmwgbm93IG5lZWRzIHRvIGJlIHN0b3JlZCBp
biB0aGUgaGN0eCBwcml2YXRlDQo+IGRhdGEgaW5zdGVhZCBvZiB0aGUgbnZtZV90Y3BfY3RybC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpM
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KDQo=

