Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE0BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e1TF13ro95pgYijxUkl62iHNmkBXntlrzvVI+hpTzns=; b=Hgl4N1bqjTSFQm9fV6bbsqS8WS
	LTf9Z2KARFD3SaO+MzKG+jjOmTJXX4fP+Ovbzo7X/86cZfyh2xTanRH87FAwE4ODr3CtMvs/0vlnQ
	oFQvY4JkvqhHQxBHuBfTL3TZce84TMnUzlrQj3LMmabgWL1PM7CyG6jzr4iOcNrbkeZqJFRiygCER
	872RC/Fzh0RI1aR14VzsgN/coMMhf+7qRrp7IuH0eLylBPGC1JpCzEmAEtBn2BxAlFxlF9kHptWam
	3GgbC4kAn4EDNr0k2ca8CgbM4zJhPETr9Oq38lgVqL5XPygiSC847ffcWqtuem1XzzHw0OWA9NOOT
	T8YvlmGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWo6-001Fxv-R4; Wed, 13 Jul 2022 07:29:14 +0000
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWo3-001FwQ-W7
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 07:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwYW3Sld+5HGJTJzVgpFFXREjhpree8ABYWA1sxR8bxxgb3HlgbPKH58HWYfKpwjzT0DUN5ixnv92asrM0jMsrla/4hwhl8M9jya9mtKb6u7EZo9vCsu9mSyv7H2N5JT7vfLCYfNTaUlJz3DTuLLJZuMEHAK2j0JaOeVtwgjUKLZ+byLBlKBrpktN2bFPwCI6rxpHYng+X8ZEl7+qfszYYMyXcg5GoHo8YZPmcHi4EU0ipNz0T6EMDjZPJk5UwW5z4NOm6LGSFRGCYWfZPydilcCQZOIF8xR0xxVaLH0Zf0r49SzqIjnJdFCjgayj4yUqHYL6nyLS1YbUv1APGVyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1TF13ro95pgYijxUkl62iHNmkBXntlrzvVI+hpTzns=;
 b=egd542W1hyrR4H87SJHzHyItw9XH0Ym6JcNyVlxqXr2UtsH6xyYlUjVkehL6VgSaZfazJxQvL6cLGDVw3aEpDPm2tzJAhxDBiOk/yJWJqFNs5Iqk7UD1CGtPfT6wY9DKBedorEuIS8FFnIau3ynM11FVNc4FWvCfvvlF0ZuSUhgOxGNPuNnXGBsY22+RtaZSHQoxHB0FlQzoEGCT+HB0zgU28dDizkXu0t2ypFH5p7snEOePgsi4UgkZmX/xT4Gx/Ei0ctIfSBBIxzjfk+rLGS+MAH/hv41HHDQbWstGsNWHwlSNhe1m5reGcQCUt+kdfBWEPHqJPtcMEyfWO47YkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1TF13ro95pgYijxUkl62iHNmkBXntlrzvVI+hpTzns=;
 b=P8a8r3U5gwUW9bqtJ3aMBn7J1gkHzx3EZZ1pK5GR1MmDQwVDqhHgMxM/gUji1ioDWmslH4YO1GCr2AgsY/zNIMS6Xo23v7zNCk3+gPpsNyRjaa4Zps8DzthOf/+q+FeqKULcNqQBvUS/cLGclmqFjsZmo+P6ZCDBk3PdJzxlbICIsliD9KuFze7JS9zbEnV6KkyWqGAF2Hlhv3cJupgxowAwtdyu4ZBhMY2q+WFb0mMMtysmj9WqB5yK+9WhzQaqc9N1f6txZF5TNb7NPhiWOlJ3Exo5c2LSTOxd/1KXmeKufmqsiTpI73tO758QbO99sSHzLD70JCF4YTwckLACIQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 07:29:08 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:29:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "joshi.k@samsung.com" <joshi.k@samsung.com>, Joel Granados
	<j.granados@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "k.jensen@samsung.com" <k.jensen@samsung.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>
Subject: Re: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to
 nvme_scan_ns
Thread-Topic: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to
 nvme_scan_ns
Thread-Index: AQHYlnxidbdbjzPWn0+jlckFiLW6vq1754EA
Date: Wed, 13 Jul 2022 07:29:08 +0000
Message-ID: <641a8446-6b9f-81f8-4b40-b987cb034a38@nvidia.com>
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-2-hch@lst.de>
In-Reply-To: <20220713054914.1888305-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf32bff5-afe7-4091-70c3-08da64a15fdf
x-ms-traffictypediagnostic: DM6PR12MB5567:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pPhOrPnXjSR1fgyPX+fVh+YS1C2DdmDApDcEzt6cThCu5XtB3FWqXKSKAjt1hoIDqoSM9vDepvLvM1RYB0IFSO/3eEpEW68VNO4d6t0+9/vqZ8mjF2j7OA2XkDUi7jWHitK2akV+i3ojQDOv3jJ6TqzCIjN6QlJgDDbpKxYN1i1i7JnLMIcJdmHu9nvPiyx7ShRilFiopH/jq2r/1JdCGO7bzqh6r+gic3hr5i/Zyu9pM7VNpuIF6sCEY8fHujHZMA41KSsYdsSNIIJijhReJ+eSKt6YIYE9dxDf2vbjkdmTPbKFp9J8PMULXKeKmyawHOpaXTmK5ffUVmTpbHX+RzsYFaHzIVxueSy8ek4APSXBc+RgGAGmb2ibpGTXO30oQASEtTKOrAenCst9E2wBPehs7vLcuU5QyTI3JzyK9Z45+9DLXVhFF1OngVRsJ2jiHG/VCliPqpTPN1W82TsfjY3aw94hwKRA3BKnflonEpKYus5LId9FSl/4rp4DKVjzKO98KRRDTWSJWSvnPIW39gfdUobHCvv5QoiVKOLnnTMq5XJzDmlpVB52t8oIYEmf6gqZssL5V31QmVYiq8T2o37VxmcEzA1CCAtqpWUKU81dgmcKa0b4Vzvt+bNbIuHkbYtbQkutXOO2c7ytqqfHERknImp/4owxp+Qdly+j/KH39950qUL6nWSdAx/0NQlpR08EC0RmWk6jpej/kXxJDtwuk94iO5q8d8ZbmWfceLMuc1XGCHtxAOt4ODnbiF4pR0skKBVZmaybrPtNJayo8v4UodtMbUIq+NV6hvffHGclj9WZqlbP/RXNCReXmJaTL8oUxNq/ikXzpK1fm1Ys1CU7dLiO/dsO+hhUqw0M5hf2RKEGNZz3hzq5+PUWuYBU
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(53546011)(478600001)(6486002)(6512007)(6506007)(71200400001)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(91956017)(31696002)(86362001)(316002)(6916009)(54906003)(4326008)(122000001)(38100700002)(2616005)(38070700005)(186003)(558084003)(36756003)(8936002)(5660300002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bUVGL2l0czJVL25ka1AvbnNoZWkyY2FKWlppcWJmdzBBaXNGUmdRN21naFp0?=
 =?utf-8?B?cEtGSmR1SjNYWTc2TVoxN2tBd3orWmdBYjlUaktubGlJL25VNm11ZEQwNlBZ?=
 =?utf-8?B?TFVDNVhGajdOcm9JM3hQS2dwNi9FRkI1WUx4V1l3ZitjaFBtZlFXU1QyTlFR?=
 =?utf-8?B?ZVV3YWFPQzZVQUVaajZOSjVEYk9scC8xV0E3T0RlVm5kd0dzcGsydFhUMnpl?=
 =?utf-8?B?bmtSWGxPd2JUMVhEYWQzRmxZWEZPaW5vRFdWdzhuS0pkSUlHNGR6VmUwWlN0?=
 =?utf-8?B?aUpqL0dVMDcxcVNiOEpMZ3d2a004UzlrV2haRk9jM05lZG9MbVJMQlY1MUdt?=
 =?utf-8?B?MG00L1d0NE9xeFFrZzh6bkxEUnh3MFgySVBXbE1Mb2Zra3piS3NGa0pYVEc1?=
 =?utf-8?B?MXNEZkw1NUEvQ1FRbkRmVS9IMWhraFh0N21Yb2JwczN0Ym1yekJGTFRSQU1P?=
 =?utf-8?B?OEpEbE92NkRxTm56WXp3M1hKY1RkcS9BV2J2dkQ3cUNTSHBVTFVCN0ZSbGZ1?=
 =?utf-8?B?aHlIeUJDNk5tNHEva1l5UjB4aHhPVVBrdzcxSFRzc3BhdlNFT0ZHMkM1MUJh?=
 =?utf-8?B?dGRaQUgvSW1hOWJTbGFmWmlvM2RtVXkwSFZscFFpZWVSOU5yRitLem9aZTJm?=
 =?utf-8?B?WTJEdGxTQUovVndqMlp4MDRFN21TQm1sTldpL1ZJaG1JcjhNQmt1bE51djk3?=
 =?utf-8?B?MmRFSnhmblRZZ1lwYXRqZFNtMUtzaUwreUdkVTB6RlZkM2VzMUlsaWNlNXFV?=
 =?utf-8?B?VHE2aU9JME1zUFJ6ays4K2FybndGV2k3S0lGTktCZ2VSVy9iRzJwSWw1RkFa?=
 =?utf-8?B?Vmptc2xFWis0Q2RwdldqbG5pYVNMMGNOMlBac252TVhkaWV1b1ZRaGVFQTgx?=
 =?utf-8?B?V3NKOGxQSXMyTmp1UFBubmpqZ255VlI1R3ZYaEVhZC9BZVMrT25taXZMVHpD?=
 =?utf-8?B?RHZ5N0srTDFWaUh5MlVzOElIS0dkUVVvWmtBdWtHdDFCU1BpYVdPS0p3a1Qy?=
 =?utf-8?B?SjVGQlp0dTNnVjRmN3ZMeUFQVnBtbnJPRHlJVGxmOFJuSnhZcE5LbUYzUzd1?=
 =?utf-8?B?VGs2VUVvVmdaSlIyWDdTK3B5a21lc0ozenFIL1VnTGowWWg3Ni94NjZBVjZY?=
 =?utf-8?B?d0h1VkRKVXhtdXR6RTRUZ1dEV2IwZGpFRVhwZnp6N1c1ZlZ3UkE1MnEzSTN0?=
 =?utf-8?B?MzgxdmRaUUtLVlpKcENLSk55VXZhYUVjMUpDTjArUDVEMlFtSlZYbGkzbXBW?=
 =?utf-8?B?N1Jnc2drS3NRRkR1RXNlSFVkSU1sdjRTeUhlbmg3cEF5QitLTGFJYmZQaFdk?=
 =?utf-8?B?N2FUcDhLWWM2NFlCbXphV1p1b0M4QVFhRVFpYlFZR1kvLzAvSjQ2TG5lTkJp?=
 =?utf-8?B?a01YVDhMaDdLalE5cDBsNVdtZjJOa2ppY0FvcDVoSDJYMllQRU52KzFWN0Q5?=
 =?utf-8?B?a1dsbkdGU0YzZlBGNWxWemZ5bTdxUGY3SG9LaG1FYUNmM2NXdnVmQXRlRzZt?=
 =?utf-8?B?VFB2Z2libDcvRXdOQUJwMEZlbHpJcjFWdTU3MjBHbjM0SVlBYU5qek16dW5U?=
 =?utf-8?B?Z3Evb2hKSHJDQmdTRmlQK0hwNTRxWkU3ZENoOUN5UFhNWTl0TEdzME9qSUQw?=
 =?utf-8?B?dmdxSkdpYzBmN1FZcTVXaXVTeS9SUkIyK0hObVZoQmlXNS9Lb0Y3bCs2aldi?=
 =?utf-8?B?a3p1OVJOelpDWlZUMDNUZDVJOVpLZ3oxSVNhVm9EeE4vOVVNV0VxaHNKYnp5?=
 =?utf-8?B?cGxoRWkyMkp1TmE1WlhDVjdXbGY2WlVzaXNEMG1IWUZoVGxuVjNXTSs0b0t1?=
 =?utf-8?B?WUFVeEUrZnl3dVVLRUpTV2d6YUpVUzJ4SkNNUWljcXlHbUo4cVBnTDNIVTN4?=
 =?utf-8?B?aldWeDVLdVc0dTFtaWtEMlByU3RlMVhuamdEdnVZdDV0S1k3Q2NRU3NZZTZn?=
 =?utf-8?B?WEhaWmlWRzd6bFMwVGxhdktuS2UrdC93bG9VeXJZWDROUk0zTXJFeU5GYkpV?=
 =?utf-8?B?RExLQ0FndnhGbzcvcFE5NVhoaitXaGcvMnR4N05rSnh4cjZvbkhwUnN3bkJU?=
 =?utf-8?B?NkpnMlpQNVVHR01TNDJVYXFEZWMrbEJkdXM2TWt4azdTczlkMU9yeSt0WXE4?=
 =?utf-8?B?V2Y5RlFWUDdpTEFscHhlV0Z1ckdrV0pvNEFOeVdjYW5mbHRoemU1cGpoQzhT?=
 =?utf-8?Q?MEWNiPWQzvjJ0jKOG53ou3vviDNHTgYlJosTed7TEH3p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F239AF31D14A747BB33BEA96E45F4B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf32bff5-afe7-4091-70c3-08da64a15fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:29:08.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSWFEfv62T7mufpFG/aOUlRXF3S0bqPeXnRolBnnsmSahfsTOjSQcS/vGI6mBdZnrriYDdeezdJ2RW4BxZ92bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_002912_052528_7EFD6A33 
X-CRM114-Status: GOOD (  10.48  )
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

T24gNy8xMi8yMiAyMjo0OSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoaXMgc2hvcnRl
ciBuYW1lIG11Y2ggYmV0dGVyIGZpdHMgd2hhdCB0aGlzIGZ1bmN0aW9uIGRvZXMgaW4NCj4gdGhl
IHNjYW5uaW5nIHByb2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkknbSBmaW5lIGVpdGhlciB3YXksIGxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=

