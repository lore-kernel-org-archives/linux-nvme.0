Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C004FE93808
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Apr 2026 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArOisoaqFj7fJXeXTRktO0NLHODPorpOWWJ8+P2uaTo=; b=z28oCRLqRnkoxBWIcLl7Xj2aiZ
	pMQA728uCS1Rr8fkTx8+9fB2X2+Pxxd/jV0N/Uemqj4HVjnc7P4ZnxIH0erP4YJQwDCkQ/VIQ7bcZ
	TMvigwFgwZ3I6WtXDwXgXAAZRuHuf2UHCsFKSqmb5wnAVX4tilXgHc8RsXvMHj2GlP6hMtHXA3MJz
	URTG2pmoZ5JhQj46pR8p1ADw78bmfwOIkQkui4ByRGKK4Wge11HcwEqApbZXpYua2mKWJgNyZfks/
	lCul1WNNMtLWONnJ1etdb/VZLCu+K0g82aP53AxIa31VuX2VlhUzXAObp7uquG8FTW7W/WMuoGuoO
	z4t9iXGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC4RW-0000000Emlh-1Jm1;
	Sun, 12 Apr 2026 23:42:18 +0000
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC4RT-0000000EmlF-2Vn4
	for linux-nvme@lists.infradead.org;
	Sun, 12 Apr 2026 23:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTOLKc5imqxcOrDGR/Eb2nWBex5bicUQ423VwfYvgsqcMag7DY0tLIBQ5mfeaAaFlKg1qlXvid2lPCX8iY/brUbQaPd1fiUFq7Rxvj0bimrucv87NnpUODdpS5tYwDGeT8+2gYhAbM2XlWxVtQsKrD+2y9fPYqvaMwZobRRlj+wj5wSWb0YyClZuIOpOHNCjUXhUfX7vS1ODzWFMU7GevUZLdkO7cwYXEHqrM4Bm8Ua/rK8yUfrjHtKypRdR76x1xV9Xd7LyPF0Y6Lc1+D/HVF9Fb5eNOAmz1ACJsPqBnqtw5AZHstsWHpvkhMPGGVUKWIWZtdQjkOV+3dm40Thomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArOisoaqFj7fJXeXTRktO0NLHODPorpOWWJ8+P2uaTo=;
 b=LTNtTK6etR0F5LXXLsfkP4Q1kH2ifWPQmow5f0FogWQx2m0iTtiHGCQmwcYqM8pGjlc7EB6xO1day1Cd0hs2Mrc4W/cnrkSCV52I0Z+MQWmL8XhvSgvJnK/gaFQU40LstMf2GwANQ1vJ9wMp1cL9KXzSr7DDocS4ifs7N2pnssJ42tVRyE65iP9hWct9z7UnP6Kd9uRUW/J8OnJqjyiRJYCii7myROXvMp5A9PZPIWYiBhmAIfTniBrzXFwATYRqeY9Kd4HkRkeoXWkp71IGPoivhf7ic6PzgOZx+7/ACorHtzcBk4I2O05HzusI/F1QO4XRBW6ck4u7ivaoOXuxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArOisoaqFj7fJXeXTRktO0NLHODPorpOWWJ8+P2uaTo=;
 b=J9s5k1TONG2Q5emaMlN2oNryGmtWrYklewR68JINGsRqkecj6MEvNS5RjqqpU0yQrhQeM+Qr7SZuGQ84dEhmf2xSQM7W3jQZ9KzXN+rGqFo/Et0F9YLAzeohtARDJuZuNue4Wq7rSonFcwlA+NpgyiWZk4ng1b5z5y3OHJqKLCtyQV0DJJnP7Imob0nuwFKItHEbmf4Rn0U95pC3/yJ/7Jtq7snwDVw9d4pOoUfdoSFQ28bdaT7Rb/2zs/Ivzv3Gwh+JrPkiAZnPrnO859Ox0AbVohkGPjb1FhFE7QdkgwC18Qpd1JEliRDg0vegwPULGHy8P1T3mjIDhVM4oeATog==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 23:42:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 23:42:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Paul Moses <p@1g4.org>, Greg KH <gregkh@linuxfoundation.org>, Hannes
 Reinecke <hare@suse.de>
CC: "security@kernel.org" <security@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: fix handling of tls alerts
Thread-Topic: nvme: fix handling of tls alerts
Thread-Index: AQHcyi3extsV+4jqlkyQUkOs3Z13v7Xa4YkAgAAWcYCAAR+bAA==
Date: Sun, 12 Apr 2026 23:42:06 +0000
Message-ID: <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org>
 <2026041239-engross-edition-66eb@gregkh>
 <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org>
In-Reply-To: <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6478:EE_
x-ms-office365-filtering-correlation-id: 13555dc3-5631-4475-9ea2-08de98ed1b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: QXZo4VO8mHA9NgleS3+rPOFe962m2/1O4gqlmXl+BXFjb3cKYi7vQ6BtuFkBSIdsKKUnOzylIsC0uBHpIlDnSJdLPYQFtpauMRrkj4CoDSyLT1gFw/iDpQyFlIJg6uS7zPVGh/jWWksHFYcEQXApS8JBEW9fcMA9dyCm2yvorcYuzauEGniIFkjgiHI1bpgQ8V1tVziPDUr9+61iZxGQUIyqGGxr6I0ja88qjE+pv8aTMSZnlR3fJZU+Uux+xkHOSOpxvIs80wf48uFltBBk9HT6nxdWRJLiBT9lHZfmBwq4aSLXPGfv5ShMWIgj694+qzpt7PVZWzsRBYHBYYG6ekzk+t9NAJpLhsLtXsrildbVPTjNR3VLq2ZgZisxdJ9yIlpvmJmOtllzs0ugDWuK7/P4ednhqi+q9snakglNAG/0AyLKyLcP/p4H9ie5wu5kHCqIKMt5/Vd4xDekpciw6hYXa1lm55z5Xqcv3MIeYY0vA0gC1USnQvUzb8u7/wLBarFYINZRO+PmYb0pfkUuL222KyuW+jNhLsnFVw1+FsMRv0N7TnxMrhG7AtY9AJzYBUz9uKj6bcIItpimxbGD2t2p9Yu0S7aeGb9Ob8Ht9CvKV8G3KMKyafk5Cs3566OBTNn5xKmHnmh2VWK+BqsgORxjCvNq7hWUR8uIU8Oxn04GJskdRawRQ7ff/hx2fxaxnSE1dy+p7adu5gwVp4sX18P0vn0ZMKgS2oW2LaO52+67+Q56h4yn+P56++fTCxrAl5Z0+BTqEhIiF93ulf33blWJ5loOwUNLD5ZwCd3fMk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QldIWXA5eStRdzZobkRsSWJNaXN5YTM3Ykhyd3N1eFVTWmY2cE05RlQ5WDJO?=
 =?utf-8?B?ZlJqUXZaUEhWSnQ2L0Y3OXpCbjhwL2dKOGpNTmp1ZlVhdDBmSHhYaWQwM3dB?=
 =?utf-8?B?VmNhMGc4OTNxZUpMdE5oaFJEcjNIeVR2WC9BUXpFNzhMOFNEa2NRbEY3cHQv?=
 =?utf-8?B?VFlxcmN5YWdyZElBOHVHRHFHYStadUZnemxjMUxrT1E0SkhPdDEzMlRkRDVo?=
 =?utf-8?B?Vm5COGFGSFhodk9RQnJSc1VpZFVIOEp1OWE4eXdiWFU4SjNmZ2toSXVuOElU?=
 =?utf-8?B?OWcxcGEzemRUNVRZczYzT0wrTWxZeDRaSm5ablVBbkNlR0RlRlBzNUlUWU1r?=
 =?utf-8?B?UEhFOXdXN3lpNGxibHM2a0I4bGpuVjlvN0l1dHdLd2ZSa1V3WDdiNjRKMDlL?=
 =?utf-8?B?SC9BbVR5UmttMElsTGptb2x3QnoyNFJlbXMvbW4wUytQRWR4L0V6cHlaOEV5?=
 =?utf-8?B?Zm9MWm4xV0ZPY2JTbGdpeVBkc3RncURYOFlHNkFvak1xUjVJL0VWbC9xV3BU?=
 =?utf-8?B?a1VITnNDd0g1b0d4RUp1UE16bFRYUzJZYmVUdlFPRkFOUzBKbDVrOTgxSUpK?=
 =?utf-8?B?bGVFYnFRLzFMWGY4aVhiaGxHcWJzSE9FVk1EeTZyVkdITTBrWVZZcWtxSTJ1?=
 =?utf-8?B?ZS9aS0NQdk52Skh1TThuVXEzT2Y1WDZxdDZseEJyWUpPWlNSNDBHeFZPcVV2?=
 =?utf-8?B?RVo3UFJMYTliSXB4Yk0wUGdTNDNyelRmVWR6T1BEbnNYWWFPaUFYaWtFUFVK?=
 =?utf-8?B?THJRdVIwZWtoNzc4ZDNYcWtVREZSVlJIUXJxZkFpa2dkMTI3SGkvcFlEM2Jt?=
 =?utf-8?B?OUFYbG1Bdm00TjY5NFJTVTJIcUg3VUwyU0R2ZUFrRklrN0FtNlRCN0hQb3d6?=
 =?utf-8?B?V0Z3Y1JyY2RlWkZKRm42VVJScEY4NWhUYkY5QmNZbldMbytwd1FqeVRQYnF2?=
 =?utf-8?B?aDhRUC9DUkdRcDAzcWJpdThYZWpFdXNEaEIvc1VkZU9EaU80SUdvYlY0U2Ev?=
 =?utf-8?B?ZnVEOWlZaStwU1dvYXVwRWQ0MVVCbVlnNHVpWXplRGUrMkxoclliWkhqV0Uv?=
 =?utf-8?B?SkpZM2Y3S3pxcXpOdG1MWUdYTGtHZWFTUzVPa0VBR1dYMFY0Z2h0MGZhOHY0?=
 =?utf-8?B?RFh4WWVGaXhXQ1l3QmVUb1BPU3ExMFBEYkVmMUZ6VWlIN3h1a3cvSUExSXpZ?=
 =?utf-8?B?ems4QlBxNXdCTi9zRUloTUZCdXpOMlZrWGNCWWhueUVQNzFycTRLZHljV3lB?=
 =?utf-8?B?dUhSMzFWK1NydC9JTE80TnVTck5lWktGcEJBRmlnSWZQUGZrU2pQV0l2dWJt?=
 =?utf-8?B?TlZxVGVCNmlBbHFtK2o3d2c4WmdqeGJUdmduQ2lRUitHalUrZE9uLzRnQ3Vk?=
 =?utf-8?B?Y2trT2RtTStNT0l4OVorSkRMcjJXOHV6RGxJbmQ4blA1NWtRM0JSc2UycU5V?=
 =?utf-8?B?YWhNcVBmeTVsNlZRN0xDSU1rZnRjNVJLZWdHS0ZHbis1K1ZxSk13L0xUSEUy?=
 =?utf-8?B?Vnh2emJhdXFqZHpxamhzczZTKzhtVG1kNVlpUVFub2FIUDlJK21ncmlYVk5K?=
 =?utf-8?B?amJkcUVmQnNsR282akpHL1M5cVptWFd4S211ZVA1eVQzRnlLVWxqZGxGK2Y4?=
 =?utf-8?B?bkpQSzc3M3Btendac0h6SEZWNUFMV2o2MllSbVJabTJYeTlXL1VMZDdsaFhu?=
 =?utf-8?B?YVBuRGNRYi9TbHBXUkk4UnJVOFVGMTcxVnZobVorRTFpcDJKV0IzL3hkeHFk?=
 =?utf-8?B?R0IvNGxmT1BGaEhNdnlqZlVWVWUzZFBwdSt1VFhzaWVhb0RFdW9DdUhSeHNZ?=
 =?utf-8?B?RzNySGxGdEVIZnZvZ0MvaEVnRmVuamtodklpMGhjaHN2NGRoZytQbWluOWNx?=
 =?utf-8?B?QnVQNDJuOFd0T1ZKRFFYTnFJMndndGRPc1hQWGNXN3FMY1pvbEptZlJPRkJG?=
 =?utf-8?B?Nnp2dG1TYTZsRmhiWno2NFd2NXlPNnczcG5NNDY1aW01REsvK3dqYVFpRWM2?=
 =?utf-8?B?Z0VxN2hJL3k1QTdmMUw2NHlzek5mb24wcVZVdGxleXpkT3pCZElEYVBHU2FD?=
 =?utf-8?B?OENnRlllb0J2dkdhQk44V0RhVkhkK1JJREt6SFNnR3ZCOWM1alBtSm1PcGIy?=
 =?utf-8?B?Mis2UEI0RjVQZzhkNG9uUDlXdjM5bmNGa0x0SUkveHBFOVRBdEdTaUlzMktX?=
 =?utf-8?B?OXNjcHhLaCtKajJKOUFXVVNKMVlNUWJGUTFqWmF0eG5lNHdtMk5wMm1sZnZD?=
 =?utf-8?B?WFVFSFVSNWZTVVdJTUI2Y1g5eXRvMlJGUEFhM1c0cTNLNEtremoyTXZJdHBa?=
 =?utf-8?B?bTZiRG14bll4Y1p1MXZwUXhndVJ6NWNmOUU3Tmx0eXhQMWNvMGowU0swR0lk?=
 =?utf-8?Q?m6srgsyzgA2R2qeW4JLcwdzA+vJiI4STpvWLvGu70GvQH?=
x-ms-exchange-antispam-messagedata-1: Gd3tHB5giHtSUg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D567C3713BE04F42932E835212AC42B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13555dc3-5631-4475-9ea2-08de98ed1b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 23:42:06.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQPyBCBkD5+qrbn4Pfc0eN99zD0oLj56iv0qwVxGVRFxU2caqwo/Ktk2JQ7CZpTcGSHDBtntfJ2CRU4+zMGVxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260412_164215_675046_0B47B3E5 
X-CRM114-Status: GOOD (  20.07  )
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

IMKgKCtsaW51eC1udm1lKQ0KDQpPbiA0LzExLzI2IDIzOjMyLCBQYXVsIE1vc2VzIHdyb3RlOg0K
Pj4gU28gdGhlIHBhdGNoIGFib3ZlIGZpeGVzIHRoaXMgaXNzdWU/ICBPciBpdCBkb2VzIG5vdCBm
aXggdGhlIGlzc3VlPw0KPj4NCj4gSXQgc2VlbXMgbGlrZSBpdCBkb2VzIG1vcmUgdGhhbiBpdCBu
ZWVkcyB0byBhbmQgbmVlZGVkIG1vcmUgd29yaywgYnV0DQo+IHllcy4gTXkgZ29hbCBpcyB0byBh
dm9pZCByZXBlYXRpbmcgc2hhcGVyLmMgYW5kIGhhdmUgbWFpbnRhaW5lcg0KPiBpbnB1dCBiZWZv
cmUgdGVzdGluZyB0aGUgZml4IGV4dGVuc2l2ZWx5IGFuZCBob3BlZnVsbHkgc2F2ZSBzb21lIHRp
bWUuDQo+DQo+IEknZCBsZWFuIHRvd2FyZCBzb21ldGhpbmcgbW9yZSBsaWtlIHRoaXMgYnV0IG1h
aW50YWluZXJzIGhhdmUNCj4gY29uc2lkZXJhdGlvbnMgYmV5b25kIG15IG93bi4NCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0
L3RjcC5jDQo+IGluZGV4IGFjYzcxYTI2NzMzZi4uNjc1OTE0MjhhZDIzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQv
dGNwLmMNCj4gQEAgLTEyMCw3ICsxMjAsNiBAQCBzdHJ1Y3QgbnZtZXRfdGNwX2NtZCB7DQo+ICAg
CXUzMgkJCQlwZHVfbGVuOw0KPiAgIAl1MzIJCQkJcGR1X3JlY3Y7DQo+ICAgCWludAkJCQlzZ19p
ZHg7DQo+IC0JY2hhcgkJCQlyZWN2X2NidWZbQ01TR19MRU4oc2l6ZW9mKGNoYXIpKV07DQo+ICAg
CXN0cnVjdCBtc2doZHIJCQlyZWN2X21zZzsNCj4gICAJc3RydWN0IGJpb192ZWMJCQkqaW92Ow0K
PiAgIAl1MzIJCQkJZmxhZ3M7DQo+IEBAIC0xMTg5LDYgKzExODgsNyBAQCBzdGF0aWMgaW50IG52
bWV0X3RjcF90cnlfcmVjdl9wZHUoc3RydWN0IG52bWV0X3RjcF9xdWV1ZSAqcXVldWUpDQo+ICAg
CWlmICh1bmxpa2VseShsZW4gPCAwKSkNCj4gICAJCXJldHVybiBsZW47DQo+ICAgCWlmIChxdWV1
ZS0+dGxzX3Bza2lkKSB7DQo+ICsJCWlvdl9pdGVyX3JldmVydCgmbXNnLm1zZ19pdGVyLCBsZW4p
Ow0KPiAgIAkJcmV0ID0gbnZtZXRfdGNwX3Rsc19yZWNvcmRfb2socXVldWUsICZtc2csIGNidWYp
Ow0KPiAgIAkJaWYgKHJldCA8IDApDQo+ICAgCQkJcmV0dXJuIHJldDsNCj4gQEAgLTEyNDUsMTkg
KzEyNDUsMjIgQEAgc3RhdGljIHZvaWQgbnZtZXRfdGNwX3ByZXBfcmVjdl9kZGdzdChzdHJ1Y3Qg
bnZtZXRfdGNwX2NtZCAqY21kKQ0KPiAgIHN0YXRpYyBpbnQgbnZtZXRfdGNwX3RyeV9yZWN2X2Rh
dGEoc3RydWN0IG52bWV0X3RjcF9xdWV1ZSAqcXVldWUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbnZt
ZXRfdGNwX2NtZCAgKmNtZCA9IHF1ZXVlLT5jbWQ7DQo+IC0JaW50IGxlbiwgcmV0Ow0KPiArCWlu
dCBsZW47DQo+ICAgDQo+ICAgCXdoaWxlIChtc2dfZGF0YV9sZWZ0KCZjbWQtPnJlY3ZfbXNnKSkg
ew0KPiAgIAkJbGVuID0gc29ja19yZWN2bXNnKGNtZC0+cXVldWUtPnNvY2ssICZjbWQtPnJlY3Zf
bXNnLA0KPiAgIAkJCWNtZC0+cmVjdl9tc2cubXNnX2ZsYWdzKTsNCj4gKwkJaWYgKHF1ZXVlLT50
bHNfcHNraWQgJiYNCj4gKwkJICAgIChjbWQtPnJlY3ZfbXNnLm1zZ19mbGFncyAmIE1TR19DVFJV
TkMpKSB7DQo+ICsJCQljbWQtPnJlY3ZfbXNnLm1zZ19mbGFncyAmPSB+KE1TR19DVFJVTkMgfCBN
U0dfRU9SKTsNCj4gKwkJCWlmIChsZW4gPT0gMCB8fCBsZW4gPT0gLUVJTykgew0KPiArCQkJCXBy
X2VycigicXVldWUgJWQ6IHVuZXhwZWN0ZWQgVExTIGNvbnRyb2wgbWVzc2FnZSB3aGlsZSByZWNl
aXZpbmcgZGF0YVxuIiwNCj4gKwkJCQkgICAgICAgcXVldWUtPmlkeCk7DQo+ICsJCQkJcmV0dXJu
IC1FSU87DQo+ICsJCQl9DQo+ICsJCX0NCj4gICAJCWlmIChsZW4gPD0gMCkNCj4gICAJCQlyZXR1
cm4gbGVuOw0KPiAtCQlpZiAocXVldWUtPnRsc19wc2tpZCkgew0KPiAtCQkJcmV0ID0gbnZtZXRf
dGNwX3Rsc19yZWNvcmRfb2soY21kLT5xdWV1ZSwNCj4gLQkJCQkJJmNtZC0+cmVjdl9tc2csIGNt
ZC0+cmVjdl9jYnVmKTsNCj4gLQkJCWlmIChyZXQgPCAwKQ0KPiAtCQkJCXJldHVybiByZXQ7DQo+
IC0JCX0NCj4gICANCj4gICAJCWNtZC0+cGR1X3JlY3YgKz0gbGVuOw0KPiAgIAkJY21kLT5yYnl0
ZXNfZG9uZSArPSBsZW47DQo+IEBAIC0xMjk1LDYgKzEyOTgsNyBAQCBzdGF0aWMgaW50IG52bWV0
X3RjcF90cnlfcmVjdl9kZGdzdChzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSkNCj4gICAJ
aWYgKHVubGlrZWx5KGxlbiA8IDApKQ0KPiAgIAkJcmV0dXJuIGxlbjsNCj4gICAJaWYgKHF1ZXVl
LT50bHNfcHNraWQpIHsNCj4gKwkJaW92X2l0ZXJfcmV2ZXJ0KCZtc2cubXNnX2l0ZXIsIGxlbik7
DQo+ICAgCQlyZXQgPSBudm1ldF90Y3BfdGxzX3JlY29yZF9vayhxdWV1ZSwgJm1zZywgY2J1Zik7
DQo+ICAgCQlpZiAocmV0IDwgMCkNCj4gICAJCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMTQ4MSwxMCAr
MTQ4NSw2IEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX2FsbG9jX2NtZChzdHJ1Y3QgbnZtZXRfdGNw
X3F1ZXVlICpxdWV1ZSwNCj4gICAJaWYgKCFjLT5yMnRfcGR1KQ0KPiAgIAkJZ290byBvdXRfZnJl
ZV9kYXRhOw0KPiAgIA0KPiAtCWlmIChxdWV1ZS0+c3RhdGUgPT0gTlZNRVRfVENQX1FfVExTX0hB
TkRTSEFLRSkgew0KPiAtCQljLT5yZWN2X21zZy5tc2dfY29udHJvbCA9IGMtPnJlY3ZfY2J1ZjsN
Cj4gLQkJYy0+cmVjdl9tc2cubXNnX2NvbnRyb2xsZW4gPSBzaXplb2YoYy0+cmVjdl9jYnVmKTsN
Cj4gLQl9DQo+ICAgCWMtPnJlY3ZfbXNnLm1zZ19mbGFncyA9IE1TR19ET05UV0FJVCB8IE1TR19O
T1NJR05BTDsNCj4gICANCj4gICAJbGlzdF9hZGRfdGFpbCgmYy0+ZW50cnksICZxdWV1ZS0+ZnJl
ZV9saXN0KTsNCj4gQEAgLTE3NjQsNiArMTc2NCw3IEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX3Ry
eV9wZWVrX3BkdShzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSkNCj4gICAJCXJldHVybiBs
ZW47DQo+ICAgCX0NCj4gICANCj4gKwlpb3ZfaXRlcl9yZXZlcnQoJm1zZy5tc2dfaXRlciwgbGVu
KTsNCj4gICAJcmV0ID0gbnZtZXRfdGNwX3Rsc19yZWNvcmRfb2socXVldWUsICZtc2csIGNidWYp
Ow0KPiAgIAlpZiAocmV0IDwgMCkNCj4gICAJCXJldHVybiByZXQ7DQoNCkhhbm5lcywNCg0KY2Fu
IHlvdSBsb29rIGF0IHRoZSB0bHMgY29kZSBhbmQgcHJvdmlkZSBhbiBpbnB1dCA/DQoNCi1jaw0K
DQoNCg==

