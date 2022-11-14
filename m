Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281DAC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 04:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9c8jvrREEz7zrFPqpk9XlfwGGZ6rqROLE8iIhb8Z0PA=; b=utE0Q5RxhwldUammdaaoQMTcrE
	a3Nzq1VJbJCTdC1dWFdbdeVl+S4QA3/61P+m2uI34kBTQePtZ+VBDjdB9l+3Pyy4aUmwWtdcs4Nq5
	//3b0owVx29hB80aOttzUXgj/0DwMleBNnK+JKN002Vzavzdj/aXcSSr7Dbsi/7BoUxvLDV2zBKUa
	FH+1XITeIqcyGs80CqTashROjVlxWaGq82Gzbyo2UMseWRpiTOU9UePSgIfoRJhTvJ7Cj5rK6WSsy
	R1+fvf0VgEZF+jgyDBgesthIP47xn5pp+BOMFabR/aOdFRgRj+SEuw3tVdKO13JsHVl6pfrCzgJj4
	LtlwU58A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouQeD-00Fsbg-1g; Mon, 14 Nov 2022 04:00:37 +0000
Received: from mail-bn8nam04on2074.outbound.protection.outlook.com ([40.107.100.74] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouQe9-00Fsab-P0
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 04:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz2iNex/NIgRzjAF9/+Mn5OAdlAazVQyONsJZastA6cg/8H0RlhjgrrIR2uZPJMg4rv/IEXlg1QRvZNdFZFnPqktDNkUP0h1rP85CZoYGQNuWF+/nqadQYIaVYCVcUKvYQUYmmcfJUGsSzIZux974spPaEuQW6WgI3cMA+15BHSixFhRAP0MGGSuoLZjdL3R1GgrsoWgwtUep4zzikvRw882ngxw3OfgGAG72+uEFk6ah64nZoldgnZwL/UG7TPYypauZ//g63PjywdYOAf3nzpqyFC86cxkauY+4AdY6J8wcE4fMuUFI6HXpw3ISmhM8/tJ+6KQ2sA07cYaHaAXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c8jvrREEz7zrFPqpk9XlfwGGZ6rqROLE8iIhb8Z0PA=;
 b=K8mIOX8IEam97KXN9yS7BLqVooMgmhiATvSwAiZE9b654U7PTM7Is83YLsMwBf0b+KQmp+1pP1Pw4Pfgyp8ZYw6ZpedZUp/ngdUFzaxvO+6WHEiN0KAkHKleUp5krPoEZ/2/StZ2PTEMHVb2ZilzaS882+uqL2CFFrKWQzZwaZqqOF+7NZii1cjw58iTDEhvc8KO/QhGHG7xg68RazhL0bBLcT3fePH0UFnrKI+5NLsrz10f0GxO3p2Ri7tLkMWWh7c9hkYA3aGxikhmssWRP8tMHz4PpofTp+5DfeUHRmI4ABIj4mvTSdaQK6Mr0G+t7Cp7EoYjCHoFiAK0FS1h4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c8jvrREEz7zrFPqpk9XlfwGGZ6rqROLE8iIhb8Z0PA=;
 b=NZLljEKQ87+AHUUe4ozqustOk8bVfBjzeeVfeg35hXFg2sJJDS4W2/2bXR6xCYCJrnVz7vhGOZNgWbYtdCNDw0y3qr+r1f6mm4obTPV4ymbEyjmyOj0JIoQMsy2pE7+aWWdnC7Z91FyDIJIgMF/1vaoFJd2x5ehfxsT4f0UT4ikv7S9mFnKr8FlNk7Yanqu5YvKT6ZLViitx/VN0/wxQPd959Rm9Zj3iVWzvyYlGG+ov7B0DXO2jkCydB4Ci7U1mtM71v+EkT37vUpHU+X2LHumpmi1zLyK4B4zqV0Om2VB51B3Xi8zpwO1ad1gNMjzNl1Rqo967fksqiVL4rb+IVQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 04:00:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.016; Mon, 14 Nov 2022
 04:00:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-pci: split the probe and reset handlers v2
Thread-Topic: nvme-pci: split the probe and reset handlers v2
Thread-Index: AQHY93qkQSEkvap0ikS5wtn5qvTJGK49zEqz
Date: Mon, 14 Nov 2022 04:00:25 +0000
Message-ID: <5EBC3214-C881-41CC-B369-A0FD481CC25C@nvidia.com>
References: <20221113161138.883195-1-hch@lst.de>
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6182:EE_
x-ms-office365-filtering-correlation-id: 0b9689f5-3a8d-44b1-ab7f-08dac5f4c278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  n/1L7FbPQcMf+1AtzjsRo+oBSLMDxPtA2sQijGvM8HBExQFq8OWCQYPFit1kpghBTZ4fWSDnDGR1o2duQiWB9G1OhZnxd1FlPl455xIu2ykhRj+KIYWBAhyD8kq0UhAuQ4rlfc0yxrpgUFDNxbp9y9GwnA0ol3JD1qar+DfHoMHGg28KzEvojL11RMcoSMeaaWdmwPKbSX9GMg0ikgJ9Ngqj66+thMIMoFAoMqH6xjaAQyUs8Io+deufBs6241ks7UFb/uJqBwCZHGenQmGwIkRBEVgr3cf/AvmVbkF5916lg5roWtTiHkRbdTCr/udJBcbLzw9gJ7CLW++1favfgYEUPl8Zl9dmyn75xvwNkn0qHTX5zbfyS8vGJOIPQoB0OF8SCGFUSx2tcmp52Ob+fZN4g6gf0UckXoI/AzeuUI8gL/ngKqwi8hqvXRkvk4DwNGQKeLnDZGvUY/WKfQH8W2wTVbXmX1pBCx/k5c5YiX1/bsz6/y8+rR/Rx0Lcfm9mdSggTRb0weDWEJHMuguGkHojvrX59/Hj8yjukfA333XYqJmqvTzI5gUkgb1bn8yRQ6GXWyKY/3jDSDvubcE8kOAK7jRgak6Dpzu2h/0K2tC/mugNq7K5oqjhVCNDD2mHVDmMPOTI1j9XVhvL+cnbiJxXh+ycuEQX/B/+7Jzos/wImlHLZ0Cvw3upWMSgAmwchDAKs6te5iawGAGP/zqeeQRriN/CzyOwW2bfL+pA1zN6b9JpdjOI7q4kv7TJWGE58hlLflRtVqbzkCb3tEpUUBobTTtEkz1Nl6Jf8Yx/9q0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(5660300002)(66476007)(4326008)(76116006)(66446008)(64756008)(66946007)(66556008)(41300700001)(8676002)(91956017)(38100700002)(36756003)(122000001)(6486002)(6506007)(6512007)(71200400001)(53546011)(478600001)(2616005)(54906003)(316002)(6916009)(186003)(86362001)(33656002)(8936002)(38070700005)(2906002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M2Q3bk1JTFNkb3Y4NUI2SUpKRVJVekN4bHJnM2d1TjB3RGdVb0FQeHFoZUZN?=
 =?utf-8?B?RlM3S1AwQ004ZEdaT1NEbEp5VXYzZG9jWFpHZFNRYXJIWitFUHE5Yzd4NGJq?=
 =?utf-8?B?dTE5bVNNMHVpeTBXZUhmNTJaMS93bzk4WG84TVJtcmhnUGNIUW1JWnRRTFBr?=
 =?utf-8?B?V3IyR2Z6YU9xd2paVWV6RG5ZSjMxYTF6S3JVd2xVQWZGd29oblNDcTE5ZCtz?=
 =?utf-8?B?aE5id01wVkliQUk3cW5Sa3RNMG5zUXhVZUJCbjFwTjVZR0lmL3lZMm90M21y?=
 =?utf-8?B?WWxLYjNHZms4eVdLV3FSZ3B6SmdDZnZBYUZCekNKVzhxdk5YcDdTWFRnemF1?=
 =?utf-8?B?VG5Xc1g3KzRjSU9oc2N2RW5QbDJQaFlQNU42UWdRMWFhVEtPeHNwOHRVWFU0?=
 =?utf-8?B?cHh6OFJlSzJyeGZsT2JaV0d3blRaUXE1QkFYSmN3TS9kbnFFRlE2a1NBRzBZ?=
 =?utf-8?B?UkthaEdGRjVYNUV4OGdPMHBVOWprZlo2QWtqcXowaldKM01kQXp6cmlPMEVu?=
 =?utf-8?B?VE9aS3h1ZkNQMGxtN1o5eEJOdDhROUVUcXc1QldsZW1YVnV5eHF4MEVaZUlL?=
 =?utf-8?B?VUxZL1ZiNzBWSHgzdythMFZucTZVWUVhNnpKc3dFZGRvQjZVbGZQUmx4Z3Mz?=
 =?utf-8?B?TVU3Y1dkMzAvSGFWNTQ5T01zR2Q0V1pSaGRoVlFBVndHakxJbXZoN2JrOVVU?=
 =?utf-8?B?Qk8rNzFqclFyZW4zOXNHYlZWY1E4MG12NUJaS0FQT1pPeStsN2lwR1RiOEVp?=
 =?utf-8?B?Z0plMllqbFdjTFJOQVFyeGdHRlNEcFk0bnNpNTFpM292cm5XSGVMalRubmxV?=
 =?utf-8?B?eEFmcDNIMXk5M1ZBRUZ4RDVOM2tuNHpjaEVCVmYyVHZEVldFWHNjTEZGaW5P?=
 =?utf-8?B?clpjRHc0SktiRjZXcTFxellwQ0RLUVpYMjdOR3VUcEE3ZWphSU41bFh4SG9t?=
 =?utf-8?B?RmZzejVmZHMvRnd1MmdTUHRKM2tCM0NmY2JhN3NWbTRmSXZKZmtYekxKRWpq?=
 =?utf-8?B?bFB0TXE1RGttNlR5QUNJSVJKcHQ3SkJrN1lUNVpCUTY4WU1sdENWSHlpdXd0?=
 =?utf-8?B?M0JvOVpFVlNZOUpOVnR4dWlFdHNmUURsS01xWVIrTUUxemhLcEI1dU1senpx?=
 =?utf-8?B?bFN6NGYvVkkyTFBYa2puOUo5YmhiZ2szMjh6Z1pEYXh4ckNCUGVLTzNQcUQr?=
 =?utf-8?B?ajZaTDJ5Z1BQRllub2R2a29uclNOT3ZQcDFTcjlYcitKOUEwa3g2T3VYcmpS?=
 =?utf-8?B?ZmJUc1pPQmt2YzFsUGJ1NlgyUzZDRHdMWlBvR0xicnV6Q3VUS09abFVEVm05?=
 =?utf-8?B?MFM1N2p0SzZzK0VMWmt2YVhROXVoVVY4cXdTcFc4ZmVlNmcvaXBiMDdteEFY?=
 =?utf-8?B?N1hqWWUwcTBpWlhJaUlRZ0d2NmFhdFBuSURRb0Q2ZDdRb0J0aVRNU1ZzRXRj?=
 =?utf-8?B?NE5mMklPaDJKNVd0RUhzZGZuSEEwRUFZckxnRnd6b0Q5alpnTnN6eE5HcWVH?=
 =?utf-8?B?TWJHamRVSkhIV0ZQWk1QUElEc1VRNGJVbGJPUTdYK0oreEZEQjlFK2NITy9i?=
 =?utf-8?B?cVU0SW00alFiN2diSVNmeHE4L1pSVWxuTnBmbWF5NGxGVVFMVHFpZk1NQnFw?=
 =?utf-8?B?MGp4MWZuRXMxeVV4YTJHMHVYZWdiMW1SOWcrOHNNOG9JT1o1WFEzeDZNSEdS?=
 =?utf-8?B?TGdZdGRkMm9mMlY1dForSXYxdlhCSVo1OG9wM3JKdUFodFFaWVNyMERaL0hG?=
 =?utf-8?B?c2tyWHJuaGZ6akZGcVpWMEQwUXI2TTBFZ3UzcGpILzVwVkpHTnA5NXRPYkRO?=
 =?utf-8?B?MlV0UllpbVZuMVV3QUg3enEwZkEzUmJ2Z3FpREdOQ3UvV3BrNStkTWdIMzBQ?=
 =?utf-8?B?Z1ZrUXlITTV4bmdMb0NvQjdHQ25uTEdUNDZXWWdFYnFVM25UWXZINnFnaHFD?=
 =?utf-8?B?QXRPMFg4YzR4UHFSM0FnaXc1enZmTUN3M0FQTWRza3gzandjNHlLS0ZlQnc2?=
 =?utf-8?B?c1JGYi9hQ3dpdGJkYUlGTSt6WEFyV3c3UFd4V2plblhNdldhSHArSnRnZUF5?=
 =?utf-8?B?Q2JTWHRpb3I3SGRRYTkvVDg4a1VYaXpJSndnalFLeUJDSzNoQkVSMVN0eCtL?=
 =?utf-8?B?dzNuU3V0bnRON3dUQjEyYmVjY1AvejF6bEFkMHJuT1Z0KzIvUkliZEN0ZUx5?=
 =?utf-8?Q?tSX4xrYikbzwj9699yHQptDdjCTO2yKD+kdEcMpWPbYz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9689f5-3a8d-44b1-ab7f-08dac5f4c278
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 04:00:25.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJSieCGb7BVsx7amtI+J0y3/nvaZCzryJPwQ3RbolDRe1J5IzXH5YMiYRxLuoVgklTnx1Z6X4m9GUgvZle8mhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_200034_057278_A242B885 
X-CRM114-Status: GOOD (  14.90  )
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

DQoNCj4gDQo+IE9uIE5vdiAxMywgMjAyMiwgYXQgODoxMSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+IHdyb3RlOg0KPiANCj4g77u/SGkgYWxsLA0KPiANCj4gdGhpcyBzZXJpZXMg
c3BsaXQgdGhlIG52bWUtcGNpIHByb2JlIGhhbmRsZXIgdG8gYmUgc2VwYXJhdGUgZnJvbSB0aGUg
cmVzZXQNCj4gaGFuZGxlci4gIEkndmUgYmVlbiB3YW50aW5nIHRvIGRvIHRoYXQgZm9yIGEgd2hp
bGUsIGJ1dCB0aGUgYnVnIHJlcG9ydCBmcm9tDQo+IEdlcmQgdGhhdCB3YXMgY2F1c2VkIGJ5IGNv
bmZ1c2luZyBhYm91dCB0aGUgY29udHJvbGxlciBzdGF0ZSBpbiB0aGUgcmVzZXQNCj4gc3RhdGUg
cmVxdWlyZWQgaXQgdG8gYmUgZXhwZWRpdGVkLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4g
LSBzd2l0Y2ggYmFjayBmcm9tIElTX0VOQUJMRUQgZm9yIHRoZSBTRURfT1BBTCBjb2RlIHRvIHBy
ZXZlbnQgYSB3YXJuaW5nDQo+ICAgd2hlbiBpdCBpcyBkaXNhYmxlZC4NCj4gLSByZW5hbWUgbnZt
ZV9wY2lfYWxsb2NfY3RybCB0byBudm1lX3BjaV9hbGxvY19kZXYNCj4gLSBhbGxvdyBpbml0aWFs
aXphdGluZyBzaGFkb3cgZG9vcmJlbGwgYnVmZmVycyBkdXJpbmcgcmVzZXQNCj4gLSBzaW1wbGlm
eSBITUIgc2V0dXAgYSBiaXQNCj4gLSBzaHV0ZG93biB0aGUgY29udHJvbGxlciBvbiByZXNldCBm
YWlsdXJlDQo+IA0KPiBEaWZmc3RhdDoNCj4gaG9zdC9hcHBsZS5jICB8ICAgIDIgDQo+IGhvc3Qv
Y29yZS5jICAgfCAgIDM5ICsrKystDQo+IGhvc3QvZmMuYyAgICAgfCAgICAyIA0KPiBob3N0L252
bWUuaCAgIHwgICAgNyANCj4gaG9zdC9wY2kuYyAgICB8ICA0MTMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBob3N0L3JkbWEuYyAg
IHwgICAgMiANCj4gaG9zdC90Y3AuYyAgICB8ICAgIDIgDQo+IHRhcmdldC9sb29wLmMgfCAgICAy
IA0KPiA4IGZpbGVzIGNoYW5nZWQsIDI0MCBpbnNlcnRpb25zKCspLCAyMjkgZGVsZXRpb25zKC0p
DQoNClRoaXMgbG9va3MgZ29vZCB0byBtZSBtaW51cyB0aGUgYXBwbGUgYW5kIGZjIHBhcnQuLi4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==

