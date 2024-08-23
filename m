Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DF9C5320E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26RYsyhIoBaphAOU+Frkjm1L9z5LlQ9h4oEzn9gwu2A=; b=uGIfRQT0IAQ1Rr4seuN1XJvhQG
	83KhtA3RMDefAOsoDrp3qJH4NiCT0vsgZjBvTrkPFzDe2ASlfmnxQPWkct4xLGSBu7HCTXQeI2vEr
	zyxYid0WklvFFrtTdXxhxjmV2ln9aU+hmbtWTjSARoNwGQX8nGsJc12HPXOIdeqnuMWRhsK0VTBbW
	Pr2Yn3rC/GhsVnCWTwF1MiPhhCu8cwArVKi4rmIXzkfwAJiD5UK5+zixdE2BlO5vDGyLVVWTOEAUm
	qYERDRh0ruGo2rrWMucpsnA+LxCPlHwOvIWulgmNAhxo2Nd1wMQgzumrPURV73xt1rK1qZewsvvJM
	7OBP5yJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shJv6-0000000EuP2-2h75;
	Fri, 23 Aug 2024 02:20:56 +0000
Received: from mail-centralusazolkn190100000.outbound.protection.outlook.com ([2a01:111:f403:d107::] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shJv3-0000000EuO1-3ZGK
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 02:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfo220OtxDJpUG/0ss7bZxmeAYE3Z3kz46zKLcCNq0SWCied+JCxuOLxoEeefVOKt62CDFEQjOa/+Oq1DoNETWpPFqlu/0sewWKJv5fHEXZJGSQRwYhG7VjdsNbTVpOr7tJrS0Ra6tp1UflMn9euSHj+Ady68mmdcDuZHs+bZISbYULukym/4QKCZ7fJpmGsW+y6UbG1Ga/Du1P0BqE9M2J6gz1WZ2pZvc4wlhq/WMd+oXjI3dreG7OnX0PTrocRXkroELOD3F+K8uGQC/SRvmEvCKVegh9yaGPSY5ZPDOoRsWaehxSvBGRIPRg2RwyPJV3T/1XUdK+MI3clJxjx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26RYsyhIoBaphAOU+Frkjm1L9z5LlQ9h4oEzn9gwu2A=;
 b=vaFPxbhNevvQ2ZBW6Pva6606Hy+SK5I+wRWnEXXzm2xG3UnYB2PuY1A1gDdlb8MsMqBD0nQL+mTqvvokyq7DFDf3zRmzZ3OmovdCMQv6V9pPz7ZqLAbOuPKChdshnI4d+0daLBJlvhxBSGVg5hUeF6jBpf5nin95G+wfqVzMuwtfMFu9bhXJn+O1qp9gFT+CweMb6bv4tsECQrpvEIAys4dq78I2InIE6r20ZdSfNfmJCbyyalEeuvAuYbQJRr8OMFk6WbkZcdW1a9iYj+A4jf44UNjGKv8tNf6jlw7qxIQIqF6t48CnfCYJtYK6/ekXwH9Hep/qhEmxDq+BDuglTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26RYsyhIoBaphAOU+Frkjm1L9z5LlQ9h4oEzn9gwu2A=;
 b=EcJpKIvmTVRHcO6IDUzC1dNPHRQNGh+v4NYJO0BQlFIMSm9p979MFv5zFjtlS/WegNFjKSPa4XlhWGj4LhVCE9LUFKM5EvR14JU4ZFLzRYWSFr2ggyA0EUNrN/gCyZVhPn4q3/ttDS44/aqZbzVfs3iEWRsjs7qn0RqvtR7y/nSP0nNDex86rlsuk5R55uPdLvxWwxk/feh6z81zi2sgjzT1FdPCrzmHwWtphxFQEFVJABSbji9yJhVE1zCXfh+G1ZiV52YSaAQW74WHCJGorRKt77tlUb70GXCBvuUirasFp5ez4SdChyrWLTeTlQizzBKrhJT44uxy61Y3CLMDDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9030.namprd02.prod.outlook.com (2603:10b6:8:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 02:20:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 02:20:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "petr@tesarici.cz"
	<petr@tesarici.cz>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 0/7] Introduce swiotlb throttling
Thread-Topic: [RFC 0/7] Introduce swiotlb throttling
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALIzqaeAgABtSvA=
Date: Fri, 23 Aug 2024 02:20:41 +0000
Message-ID: <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
 <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
In-Reply-To: <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn: [wJ6hfREF22uRzLSej8jy8OZHs16awmvl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9030:EE_
x-ms-office365-filtering-correlation-id: 2eee0415-ba7d-43c0-cb05-08dcc31a2f82
x-microsoft-antispam: BCL:0;ARA:14566002|8060799006|461199028|15080799003|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: 4Vy+RemmgDSFBlVjFgAiz2CsPQtLgR0eiUivnXzEhtohcX0v8OlqBVeh1WQRqYN9pVItFFH3LkfFokvlH8C0Am9Uv51cb1k6wCYpDp4qHJQegudBC573rlfE0kcNyZMNQtkmGrotaHA8B3pTRfZA8yqVxjIuuvJxRNxrQpQ+vKC9ySvS3ILi66TkkYjwxs6QaawA1upsBwtaPSqss/xfnp8fsUSDW0cL/C7HF+mmCYEOhOY51lUQW48Inuj0gv/znMaD0U7ZkzI8QYr9AVHuslwKAZ2mmHB0o6TnJKUQ5KzOsF2OE+JiSZ2P7+5VJdRFeVOAJZLpFuWaQiYAoBYb56iORB5KonmcUGdPR5Xiol2QdFtAt3mntkn5ZK3QDvNaSRJvdTrxAUJqeWsPM/YA44eKVDhdwnVHDmZ49klOXcCMrj+L40l4/H0bVLkFrR/mMprWw5Y17aLA1yZpjNIpRzW31exahfViSgYorb2GZjYF8xozBWl19iR2QXIx/a0vNI9YU9OeKsJmfRzbB4wBl7fLliwYMOfXPgmGxThFHOenVKjJ9pEsZszbhUmtAi53ICFImMxzNYS+an3SklRg02sJqurBqehzIq4e66do/5hJ0vSqQFhv4tvNedxv3RftePppM854l7eDq0rh9t9HzBc75pc7ArZL4X/OPte77c70KjLti2cCciQcYVDca5z4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5GTTNxOEplbkJFaFMvdElrUlZDOXNtWkMraWN2KzhaakJrOXowd0FmQ1lG?=
 =?utf-8?B?akErWGpnL3orcTRDOVJiN0pvT1BObUs3eGhRMVhuK0d1d1ZDZWhXOFg5Ui9a?=
 =?utf-8?B?cm9OcFQyanZFZEpBTFFpYmRsU3IyVVZOMitKaythc1o4bEJFWWtCTFVSMFMz?=
 =?utf-8?B?MTdjTzFnYnJxK1FWZm1xV2FGcC9xUnpIQ0tBR083WXhrbkphZEIvZklRRGlt?=
 =?utf-8?B?M2ZCeXJOZGtsZWhqRlVaU0J1T2tLb05aZ2pRSFpuQ2pPcGxXWC93Q3BlK210?=
 =?utf-8?B?c2xlMVJSeXdCTVlCTEM4Y2oxZzZyVHQ1NlJQSjJxU2w5T3N5eXdxdlpzRFFt?=
 =?utf-8?B?SE1Ja2hMS3ErYW9JQ2VUNGNMeGQyT1l2N2w3TkJTWXoybHk2akhvTmY2eSs5?=
 =?utf-8?B?NUhaR1F2S1cvYmthV2RTUG9jMjFBR1pzdENqNGwyWVh6bUVQYSt0S3p2VVdD?=
 =?utf-8?B?TDg0ZjlCM0FSUUdpMGlOdGlBUG9JTkVBbVVhMGV6VUJiejVFeHkxWW1qdGk2?=
 =?utf-8?B?VWs1UDluekwyR1NZQ2JtL2h3RElOWDY1NXVaZzVYWEZFKzl0U1ZLZlFUVlE2?=
 =?utf-8?B?TGpPQWVZRFMzaXRWcm9lejJObWRUOXJidUpESzBrVzd1VmhuYVpUQWo1S1dw?=
 =?utf-8?B?dENXSVZXRzA4cUZCS0JzL2NHRXlXLzlFOTFiYXl2cVQxWE1GejJVQnRlNlFP?=
 =?utf-8?B?NERlN01PS0w0elprT091SHBWaHNoMUdqQnpDb2p5UkQrWE81Z2hRUGlYK0dR?=
 =?utf-8?B?Ukk3QklCNmljTkxaYmhYWkEwYzM4QnlEaUlwM2VuWkJlYUxBNmdWMGs5L25N?=
 =?utf-8?B?cGt2NVlsWUVTd0tPNmp2UHRvV0NoYWQrcG5uYUV2ZHRlLzZnK0w2cVc1SXNm?=
 =?utf-8?B?NW5Hd0NWVUVBYkdxK1lFcEZmVXNyOGJqanZKN2pxQmtCZm1pblNPZEgvM2gv?=
 =?utf-8?B?NEs1SWQrUVUxMU9oSzkrU2VrV0Vja2h1bGVYQXU4cm1RZ2Y0RHFqaUxFaFIx?=
 =?utf-8?B?UWtkczh1YkVudGVuR05VaFQ0NFY2WDVLVkFPRU5BR0hyVzg5VEU4Q1pOQk0y?=
 =?utf-8?B?dStoM2o3eHlDZTg5NDRLN3NiRk56T3pvRTF3WTZGNE1XRUdocEFuN0o5aHZr?=
 =?utf-8?B?cnI4VjVvL0o1bEFWNW9JTUNJdVR2VTBYSnRRQkNSNjJpMlFuTGFoRys5cDBV?=
 =?utf-8?B?RTlTL0pyQ0I3YUlqcWhkN3ZJS09ZVDhyMG9WamtCalc5bnZLcG81cWxLdjRt?=
 =?utf-8?B?L1dvcmJkTkJIRFdmbENIMkdYVUpsa3JsSnBFS1pxa055TCtvcUxCdzVLL0Vt?=
 =?utf-8?B?V0NPN1p5bGhPQWlZZ0YrVGlhOWdVdmdFRWRxOFUwbm1GSHdWbUo3eStMZ2FV?=
 =?utf-8?B?amZaNURGVll1cU5LQ29BTysxdXJxZmVldmMwM2tYNEhyNzIrenNDUGczSXV3?=
 =?utf-8?B?ODRhaGxTTm9LSkFlQStoc0NUTTlzbWNwQWVwNklLQ3NuSFYyVzBXK2tyWGtk?=
 =?utf-8?B?cW9XL0NTVmR6bVkyQ1JyVExQMDdlTVNhaE1HSXRiYllOR0VDUS9mbFpOTUlC?=
 =?utf-8?B?b3dvTjZTOXRNZldlRmY0b1JFVm9iMGMvK1JYVXZIck92N3JvMUNqWm1jdEZW?=
 =?utf-8?Q?ftPW7vyhDmT+/+LUIWCJuAtFyAn3G3ci+bAIFAuqRHeI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eee0415-ba7d-43c0-cb05-08dcc31a2f82
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 02:20:41.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_192053_935236_42FDC309 
X-CRM114-Status: GOOD (  11.94  )
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

RnJvbTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMjIsIDIwMjQgMTI6MjkgUE0NCj4gDQo+IE9uIDgvMjIvMjQgMTE6MzcgQU0sIG1o
a2VsbGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IExpbnV4IGRldmljZSBkcml2ZXJzIG1heSBt
YWtlIERNQSBtYXAvdW5tYXAgY2FsbHMgaW4gY29udGV4dHMgdGhhdA0KPiA+IGNhbm5vdCBibG9j
aywgc3VjaCBhcyBpbiBhbiBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gDQo+IEFsdGhvdWdoIEkgcmVh
bGx5IGFwcHJlY2lhdGUgeW91ciB3b3JrLCB3aGF0IGFsdGVybmF0aXZlcyBoYXZlIGJlZW4NCj4g
Y29uc2lkZXJlZD8gSG93IG1hbnkgZHJpdmVycyBwZXJmb3JtIERNQSBtYXBwaW5nIGZyb20gYXRv
bWljIGNvbnRleHQ/DQo+IFdvdWxkIGl0IGJlIGZlYXNpYmxlIHRvIG1vZGlmeSB0aGVzZSBkcml2
ZXJzIHN1Y2ggdGhhdCBETUEgbWFwcGluZw0KPiBhbHdheXMgaGFwcGVucyBpbiBhIGNvbnRleHQg
aW4gd2hpY2ggc2xlZXBpbmcgaXMgYWxsb3dlZD8NCj4gDQoNCkkgaGFkIGFzc3VtZWQgdGhhdCBh
bGxvd2luZyBETUEgbWFwcGluZyBmcm9tIGludGVycnVwdCBjb250ZXh0IGlzIGENCmxvbmctdGlt
ZSBmdW5kYW1lbnRhbCByZXF1aXJlbWVudCB0aGF0IGNhbid0IGJlIGNoYW5nZWQuICBJdCdzIGJl
ZW4NCmFsbG93ZWQgYXQgbGVhc3QgZm9yIHRoZSBwYXN0IDIwIHllYXJzLCBhcyBMaW51cyBhZGRl
ZCB0aGlzIHN0YXRlbWVudCB0bw0Ka2VybmVsIGRvY3VtZW50YXRpb24gaW4gMjAwNToNCg0KICAg
VGhlIHN0cmVhbWluZyBETUEgbWFwcGluZyByb3V0aW5lcyBjYW4gYmUgY2FsbGVkIGZyb20gaW50
ZXJydXB0IGNvbnRleHQuDQoNCkJ1dCBJIGRvbid0IGhhdmUgYW55IGlkZWEgaG93IG1hbnkgZHJp
dmVycyBhY3R1YWxseSBkbyB0aGF0LiBUaGVyZSBhcmUNCnJvdWdobHkgMTcwMCBjYWxsIHNpdGVz
IGluIGtlcm5lbCBjb2RlL2RyaXZlcnMgdGhhdCBjYWxsIG9uZSBvZiB0aGUNCmRtYV9tYXBfKigp
IHZhcmlhbnRzLCBzbyBsb29raW5nIHRocm91Z2ggdGhlbSBhbGwgZG9lc24ndCBzZWVtDQpmZWFz
aWJsZS4gRnJvbSB0aGUgbGltaXRlZCBzYW1wbGVzIEkgbG9va2VkIGF0LCBibG9jayBkZXZpY2Ug
ZHJpdmVycw0KdHlwaWNhbGx5IGRvIG5vdCBjYWxsIGRtYV9tYXBfKigpIGZyb20gaW50ZXJydXB0
IGNvbnRleHQsIHRob3VnaCB0aGV5DQpkbyBjYWxsIGRtYV91bm1hcF8qKCkuIE5ldHdvcmsgZHJp
dmVycyBfZG9fIGNhbGwgZG1hX21hcF8qKCkNCmZyb20gaW50ZXJydXB0IGNvbnRleHQsIGFuZCB0
aGF0IHNlZW1zIGxpa2VseSB0byBiZSBhbiBhcnRpZmFjdCBvZiB0aGUNCmdlbmVyaWMgbmV0d29y
a2luZyBmcmFtZXdvcmsgdGhhdCB0aGUgZHJpdmVycyBmaXQgaW50by4gSSBoYXZlbid0IGxvb2tl
ZA0KYXQgYW55IG90aGVyIGRldmljZSB0eXBlcy4gDQoNCkNocmlzdG9waCBIZWxsd2lnLCBvciBh
bnlvbmUgZWxzZSB3aG8ga25vd3MgdGhlIGhpc3RvcnkgYW5kIGN1cnJlbnQNCnJlYWxpdHkgYmV0
dGVyIHRoYW4gSSBkbywgcGxlYXNlIGp1bXAgaW4uIDotKQ0KDQpNaWNoYWVsDQo=

