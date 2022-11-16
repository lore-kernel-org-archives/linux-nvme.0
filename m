Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CABC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 03:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHWJnolahT583u7IIjjEQhe8vR6QSE3YyGtecAqDfFU=; b=bbnI6Yw0AauY22oD7ji+jXG4O/
	tGYl1S5LnpQ7HdmKqpjQibQDMrqnn8hUezzDTd4u2N+vOWgw+rxIv5u53l8oOs3Oozdwe1LT6ZgzX
	lpHhxC4oo8o6N8ZQzcXmV8uJuSjCzFLMWT9MyEwHRMhQnfTqkKipVK94tvoYvD03sj/pXgi32xwHW
	67D6qVTnjzb5Tkmx/nklKSYNLY+q6pHzt4TFc5533dFXNuIuNCfFj3dla9x9+h/XMB/GQuoKMch4i
	0Pghv7PWg3riB/ylqdaaDK42UBLhQXBcLK0DV3bZadtOxw0RUEcKw41OxNWfdI3CuOw3LDb+NuQz7
	BrCXLPzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov9K3-00GoST-4w; Wed, 16 Nov 2022 03:42:47 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eaa::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov9K0-00GoOC-F0
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 03:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h27JcBL4fiXKCdvExPv0JHvlQZKtMUsqhwNckaC6DEgrPWBmJ78ihnFtk0eYBJmm4f8UfOwuMIMIP3ooCV5Ep0Snu6yWTROINZxy2ewYFXSHQOX+alev/kcXl2d7XJAnk0WDepSVhg9Vu4aoJoZkU17QxQpD7Hrq54G9M4N8I+Y6pFX2t2urDY8UFybMT+/M8ipSWCBLuEGGKYgKBQkleKPD7wGxYViu7wxS7/iAVWjDqRJHu++5ztZhUg7oGnOI9yc8hJlTyaCVW1szYaNY3b0zpyKfp8apXyimAqN/zbjLfiTwEW046DySYIf7WAsOf78zQ6A5PXJobgdwbwGwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHWJnolahT583u7IIjjEQhe8vR6QSE3YyGtecAqDfFU=;
 b=K5AHIiP8nvuRUu0FnY+4p+Gm1Pr/FFFTm6k7KIKyt9eu9OLzUjVxHX+fOZylH297MHF/tJQYUyA+eD1mKs2MZB50DbT9Bs73TAk1A9XWhhx/FKknC/vpecM+6LVugbRW95hHevtB5ig96RahLywhAttYQp/RC+wGz3qhnDEKtMDj688ByiEkcRTfJy/H4pwgWCwquyI8mXpyEU5rdZ0Q8DRfcaTya/OPIkujnu2X3xvJQ9SSbMZUX3OeirSSr1NGT6wJLO2fNIonKbmJW/ni43PMJ1R9FYi6m6E2a54bnuH0DViOESJNdnAAXqfbzd0DvnRTXHfN9F3a/lgbKH7pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHWJnolahT583u7IIjjEQhe8vR6QSE3YyGtecAqDfFU=;
 b=AHyh3K/XyR0CQCXDVo1m3AMNAM/XIkFv4+s+EmTbhSz0VTPUn+v830tiOLABvNileBqNyLCYhXp7rCSU/Ix/5fROGf1mWN9QMWC/OScHoBRdxoqKzuBmryKxKDjcqWgALr9PT7tyGYSzJcpVOyBihXy78/KgPsDOvEsC9e0LWHnPhHdnk/VGJDzBHuF14nOhGeCyl4HxsVThsRFFIBhH9o7+qSvTijEjAVLv8adT7MHaknMd0dqPvqwAsjARI+U6rDgRcsyNy3JMNG6E+/BATfxoYByj44OrHAbWMO5oBmV0QkfveV9r3qiIIFP8gl15qlKwiqx8cfFyIsQDVZVATw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 03:26:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:26:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Tiago Dias Ferreira <tiagodfer@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] Add quirk for Netac NV7000 NVMe SSD.
Thread-Topic: [PATCH] Add quirk for Netac NV7000 NVMe SSD.
Thread-Index: AQHY+Wosmy2MSQ/Fp0a09Cn64cMzhq5A47cA
Date: Wed, 16 Nov 2022 03:26:54 +0000
Message-ID: <2ab41889-3811-55a4-6533-9a8fa6696738@nvidia.com>
References: <20221116031756.4987-1-tiagodfer@gmail.com>
In-Reply-To: <20221116031756.4987-1-tiagodfer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4156:EE_
x-ms-office365-filtering-correlation-id: 62c0f322-79cd-4974-1c11-08dac782691a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  CAsZNjK4soj/X0RXr+taMEj8TW4B2EjufGdWrDeO8yfRKI3vzuCRDTHRYKyLVGvSR9MoEoiIG2102+NumvZDHy/bnbNc4nInQaSmfKIrwwY/zKfqpRMeFPfrUTIS9/06BS4KDNbPd85dcqGo/11LBvNRFnQD5FRECCY8BeJMiiVlrnItjx7mnBZr66qWDe7cDgy3+NDqvr1fIxokRBL7SnhT6yNowxHKTV2z2PQloOanFQTIDWjhrsDnkAAUe50iChZ3fa1WR0eYYX46w9SCJEHpgmYa+zYNLrYiATbDliYytCV4Pu1jdzpMCyVFUgMIGw7W1bFPOW+JIEaHznY4iR1pprcCCHWxLkwm0S52hCd1+yQJQrCc4OyKVzWvSpQ8qt8PShyHWEr2wm3Pr5fNOOZuBMVIcnHnAbzFNXSBxL7vDEc/U+CDXn1wzyvLe1yBQh09ai782ZUX8NEB4tFg5CuEanygoUa2dG8BknFoAHDTlV9k84ttUHUoeGGtZoGzofdkyuR/bWLFy1zrCisoZIn19HtRMWvoN1Hg6yCugUjL4+FgxVPPm9odwQpiz2EsRMV6vlJtaijCWT254uxHT41EMH69g19br59VxybD5n5h/uFBVrqlJa/xRks9pyMH+NHB12n1mR2unun7KR+kHZTvQzhq0JZYZgRK6D5Ktz0qUhH3GEPfNiOQW/QSyv62fnL4MxBy8Rh2eL1YzKS95OYvrlnWpqMQOH3Pwbg3Jy+FtoUdPMN47XeEDtiT7LycWtp4ZV8iAxgU22YJ/9Ud6thjq/Yvl0YpwpEyc8bE8rF9oDCt4vViGwdc+KPuAVAZCHmZaNRWiT5dfzgfVXnFxg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(36756003)(31686004)(558084003)(86362001)(31696002)(38070700005)(38100700002)(122000001)(186003)(2616005)(110136005)(2906002)(6512007)(53546011)(5660300002)(8936002)(478600001)(6486002)(6506007)(76116006)(66946007)(41300700001)(71200400001)(66476007)(64756008)(66446008)(66556008)(316002)(4326008)(91956017)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?L0dWZVFBZ3BCaDZ3dGZyUmNLaUNMTXF2MU9jUUNIZURYNVdlRjhKRmJyNXBM?=
 =?utf-8?B?K1pRQVlkcUdkMzI2aG52cG9qcU55VXJ1bHFmazVIakUwbnFWQnlnU1lvZTA1?=
 =?utf-8?B?aVBubHBZTUNFVHZFT1dWMC9hY1QrcDZWWE5STTBBK3BZOThZekZzdzFnMzJU?=
 =?utf-8?B?QkhYSWwvRkxGRzNnTDBSREdoeWQzOTNUQVpyN2pWN0pQZUlYdExnSGFobmFw?=
 =?utf-8?B?NkVxSjdwTlZ5VExPVEtNeUdrY21xYXlaS3dGa3dHSDFUaDNaWlpRWWpnWXNC?=
 =?utf-8?B?NGZJeXRQbS9qa25yOXdYR2J5aDR2SGtBckl5clN0U1BLc1ZRNWhUV3lvRkNz?=
 =?utf-8?B?N2cwRHJJUXIxNGdvMDlpU3dOSkV1a3B3ZzJRRTVzZjlTdWlUWHlsemNKYStL?=
 =?utf-8?B?VGhMc1V2UWx2WWE1akZ4bDh2WkZ4QVg1eE9MQXBwMHZBL0FRUTh5ZThJMlNy?=
 =?utf-8?B?emNLakkxcXluMk1TM0hHS2JzUVhJWVA4NmZOZ0YvTnRnNjU0OXpHblRtcHdX?=
 =?utf-8?B?WDlKaGRFZlFGQkhWMm1tVTBnNUtBY3AyT253QUUxUTJId0xTUGpjM0Y5N2lz?=
 =?utf-8?B?N0RCaVV6dXpiMCswbzlrTEROcGlzRW5JV3cvLy9IM0lmWndWdFBpTG9IcEM0?=
 =?utf-8?B?NFBSSjhhYjVHL0ZBd1QvQnpmMDcxakcycWhNMWN3SXdMUEFKNm9ra1VocDIw?=
 =?utf-8?B?YXR5dit3em83V0pBaFB2OWRDQ0hRQjYxOG9hTXMxZnF0TkhPSHI4Y1hYay94?=
 =?utf-8?B?L0ZWS3ZhdjlJNjRyN2pWcCt3MHFwdlhiZnJiUWo5OVhpTGJWVWVTazdzc1h0?=
 =?utf-8?B?L2I5aXl6SWhOQ3FZOFQ4YzVWcWdyZldJQW9EOWlML0VvZjcxSm5JbWZUVUJS?=
 =?utf-8?B?RnhkN2tIaGprUmNpdkxvcGtwOE5sc2NNVkxqaTBlV2YrZjlFNXdoRkovODRX?=
 =?utf-8?B?VkliaWMwQlRieDVsT05CZnp2QnJDclYxMjkxeWlSQVcvZjJEM1ZGS25UazF6?=
 =?utf-8?B?azlnVnAxK3o3ekMwL05vUjRJZnBqaHJzMFVtN3pheTcvajhmcVJxY1RqNlRI?=
 =?utf-8?B?VmkvOHdUK1g2Q2N6M0xsbTU5S3VzNUh0SkEyZnJyeUY3MXh1WmJFZVBGNk1z?=
 =?utf-8?B?TmwwcHpDVnJHQW5IMkZaZjc0eXREQkQyR2hBcm03T09vTkNMUkRadzJXeHAy?=
 =?utf-8?B?eXhZeElTbDdNOEs1SEtpNWRwOWQrY2ZPSW9EWFYvY280WTFBN3lyRk1VbDlm?=
 =?utf-8?B?UlNqWlppS0R4c0lmM2ZVMDlpT2FOZ09SbEJJM2pXWVM3cVNKU1BBQVVQcTZy?=
 =?utf-8?B?L3ErMVRzWjR0S2N1V2E4Mkp1SVl3TkwyazlXdHpRZVRXbjV1anhPajl1eEVw?=
 =?utf-8?B?c3ZXYVZjYWZtVXRWYUJ1YmwxYVVHSklIcmdKVVBPQUZjWi9FOXFCdW40dzdV?=
 =?utf-8?B?Mm9nMG52UzgySmxZQkZVNzZDam9aZS9FOTgwN3dxMnlQMTJKY0NBQzVTU2lG?=
 =?utf-8?B?bEI1SFJ4WlBNQWd4U2t3VGdWWkIxQnQwWXNjQVNoVU1CZkdTay9kUnRxUlg5?=
 =?utf-8?B?bmVUWUE2U1gyOHNmc3I0bXBkWUJSd1dvOTdUSm1icjVBZTlYMHQ3c1VRSG5i?=
 =?utf-8?B?MUVSeUZ0V2FhMkJGMW4wRVhmc1dTQkhCTGxBTXlEVWlJUVNKdjNkMTZnQ0Rp?=
 =?utf-8?B?cHg1MXFtNmVTUmw0L0tUYklMSiswMit0bEtsbW1VWDBkMzV6RmFQU1lVTmhT?=
 =?utf-8?B?RExySkxJcTJnMnpsWkRkWHkwSXgrRHZ1QUgxdFcwb1ZYM2l6S1BsSEI4Z01v?=
 =?utf-8?B?Z0NvYjNjQUI2NXk5cFYwdE5MMXBvVnFEemNVR3hFdXBjWmtCSDIzZWszdnov?=
 =?utf-8?B?UmlIMFJlQStHWHBNZXE1L3p0SG1OWm5zVnZBMUJGNkltek5Nb1JPR3NOUjFp?=
 =?utf-8?B?TlFHa29PdG1xb1FrSVBOaFcwS1hydTV4QVNGRHA0S09XOGlnTEFmZUdoUTNQ?=
 =?utf-8?B?YTRnY2l0czRjZ0tFNTNFMXhVYTVrd3FubUZUSlo0YS93T3pYUy8vTFU4UE5K?=
 =?utf-8?B?eU5JcnlYeFRhak5FV1BTcng4NVZsUi96QWMzUFVlcWZQU3IxQng2Sk1qNDhp?=
 =?utf-8?B?TW12NThqWHFrV3lFbU55ZGVrNkJrQm1Ea3JJSjFoWkREb0Q1SXlhbk5xbTBT?=
 =?utf-8?Q?iPnizpg4LXtuRfAAKmncWdkIOx/DtVzfIgDTQBgTLvQH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43F7C07FF0E54D4A8B90BC4B7AFAA0FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c0f322-79cd-4974-1c11-08dac782691a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:26:54.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbbkGEYBXy8EcDbptLEjCSv8B30HZ7NLWxzFIiTujNwmQKVA9INPtXnAlUWCBPhyR8sb9RMCkr8XeTZnCu8o6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_194244_512467_504703D6 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMTUvMjIgMTk6MTcsIFRpYWdvIERpYXMgRmVycmVpcmEgd3JvdGU6DQo+IFNpZ25lZC1v
ZmYtYnk6IFRpYWdvIERpYXMgRmVycmVpcmEgPHRpYWdvZGZlckBnbWFpbC5jb20+DQo+IC0tLQ0K
DQoNClBlcmhhcHMgYSBsaXR0bGUgcGF0Y2ggZGVzY3JpcHRpb24gd291bGQgYmUgbmljZSBmb3Ig
dGhlIHNha2Ugb2YNCmNvbXBsZXRlbmVzcy4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

