Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB11C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bx492cCVuICYgowZFQ3SpSHpXo6yd68Vpxnw79dmbig=; b=fZvtXrFRUJDAsuhwug3QOhNdob
	JZzDoW4zbZ2TD1dRWGqH1EiuNGPusjOa8htBTKky7jh2AmmYR6d6HQDtrR7qUKtBD8mK2DkRjxWUw
	H+O31l/NfC5GSwliozR65HbOa/KuJEs2y+SmZ38qfyflouR6mkDr0ZyNZI/wPYtKX8S5UzuM+y8I6
	LyENleZIQm7dPMqLIiE53xbDwlk2HtGVgBz9VLpH26NfLUrsiGmZD6pIGbC3F2qfwdDWekNPbiSLD
	Z+hFHz2sSEpNHRqi+Jp7/JYBN2dGSDiRPVc5TIBTLqdRYWDsp+M48oPjBvT77xxnFRL2dYwwNUmyX
	hl1UN95Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYRX-00An0b-EW; Tue, 22 Feb 2022 16:55:15 +0000
Received: from mail-dm6nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::606]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYOf-00AlyC-Mj
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRI8YV44dX+6jZmOFhUqfxjeOxqOY9fbuEBnxfqtiTq9tBL1c8GXxCJTFa2cudlZvTC7UuhDrMYu1TTRG8nwQp2PgBKj2ZjJAFPMcBXoqRJh5AvBBkQidD+FzemRCnsMrhjyUNcs8N4QPVzQuuKZIbg8WOLwpRenfuBTD2DO4H0nKwfHJuraKC3LhrFWsI5gWBJ+FQM4SGHUQoKr2aBJbxBBGiqp1AYEZQLzp3/3IcxAByjY3qy69eDEhSvCTR4TqLDz/hScDm882EOvS2MtSJUBpogWN8nKTg8JToH0dKEReIxLm3UTL2dh6AhqLYHziruzEHkMm88JpEDAcxalpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx492cCVuICYgowZFQ3SpSHpXo6yd68Vpxnw79dmbig=;
 b=Ocna+BRAyTqJXRlVyqyX3Z4lbpjYHOuCm9DrCXBcmdOSNoQ9q+dBkLqsTjIoRiDzo57Lar8PGO8pX6GDzTsn9bKASbFgmIBqeR2bnlpidQT+cnrTOMxG3ODy1OB/usTWXAuB0gzsPHE1Pk0Bx7gTgb39mffxYLFCXeP16+nshDmeQmpmQhV7hMHItO1gDZTXnRQ+dWWrNpEHlNXUdM6mRnRXnDEYXoQsJFIWilrzE0eCCfzzgnlyY7ZpAAXOp0pRJ5nTqWkchDugcvY6WXvwK36KqxWmB6tJtPrSChJD0KVO9IHozdDyEFJtZqwqh4EXmBNhUqYRnP5dpRLEkSWUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx492cCVuICYgowZFQ3SpSHpXo6yd68Vpxnw79dmbig=;
 b=fHziTGqTZUYo0toeu+e7i68vVcpv9QLysrQDOE3I7Sn0Sgq604GX0+vD+cC2+rZGxSI4Fq+jpPIVuISWwOLQjlk/tU0Wkvre2+DetuGoSIXareQQ1gDm/xNLkxNLj3UFeXWKV7HPgm2QoNDqOnQw3lb/z8NV6gt+C8m11kkOBz/mgwJjrWKGlOerzsgIgi8m3cGQWdZIwe7ETTrk6YGZpi4ZIPzw+uqcQQCGAmS07vRlU/EuOYe4JLgUFpWvG3DTjFFEHDbVwrTPgaFaQP8rDALlM0XfNxJf5Mbq+Mrrvw5l+cpCKQGLGxmDnCOWMszg5cBR1F7aUyynzjCw4nLgOg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB3988.namprd12.prod.outlook.com (2603:10b6:a03:1a5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 16:52:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:52:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "colyli@suse.de"
 <colyli@suse.de>, Hannes Reinecke <hare@suse.de>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Thread-Topic: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Thread-Index: AQHYKAnQgU5B9I+BqkW9mo0Lup2aVqyfyQCA
Date: Tue, 22 Feb 2022 16:52:13 +0000
Message-ID: <af683045-7d84-b12a-6880-45969c10be50@nvidia.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-4-kbusch@kernel.org>
In-Reply-To: <20220222163144.1782447-4-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79689f4f-a48a-4044-3ed4-08d9f623acd7
x-ms-traffictypediagnostic: BY5PR12MB3988:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3988422052288432C5F9DCCEA33B9@BY5PR12MB3988.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3eBJ0GXmb39bbjyP/psdI4ntOZY+ccH97lSiEDc2b7EVcg0aTlmcrua+uznXvoXXnslA187YjUvwF0qX1/gcUb/yeWW/cbu/txB1mzyU4kagqDRoqZUzYXhtiP8MAI0MOIie0R1cJovNlERvIZAH8d7qK4Bw5DwHQ5uTPvUHh0Blw1nkLZlJFr9s9YdjiLRGG/J1RYDdlnWkM3aHioFeNCLw49aYm6e6H/muCIROAyh0jrtJ+8Lt6iz6yZIUi51N6CY0pzqZAx8B8+gzv0u8+NGwYU+RgfROoUTLyCXRfHMFgrr8PbS6UIKTX3b/oPR1guf5Qko0uSXiP42vC+UYHhW10BYqf8g5FdkMn4UYAGKWYZZYIGnX4MllgPdnvi96ugO5HsWUHLEfVnRmFUov9l67I5nUvXBXkLbCW0B3DayUN/V6srejrV/pxqfRLYug0nwCId6kAJ6vUehAKlgbJ9E23knOi3rVgNcWP20nUl4fCjkWjy2XB/QaRskUmO3ARYUldgUes3ntVdVQXEzATiSbM6se29BIhTE9m9U421QhXk/h1YtaJ9yJKCbPd6/FSGtohwQadnsAUXCeYVgDQ7mNBUIguzMCbQphKe7OkxtdIRCZ9a4VJWON4g/vp1wK0MF42ryik5QIFIrgjB1PsDqCX3jtoSVCnmPJtj4hUuUeX33JBqOuYJjmhEGD/wdQkTOlbrGHnTudUCz/ht3UAfvYfdUoj0c+KZ2K1SbVTYpk+Mj3rfZV6sN+KFhHuo3e8sOCNpMVLOKP0gvJojo2i2Bx99syKB6PopvTvfHbkRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(66476007)(64756008)(66946007)(8936002)(7416002)(66556008)(186003)(5660300002)(83380400001)(76116006)(31696002)(86362001)(4326008)(4744005)(8676002)(66446008)(122000001)(316002)(91956017)(2616005)(31686004)(38070700005)(6486002)(36756003)(71200400001)(6506007)(2906002)(38100700002)(508600001)(6512007)(53546011)(41533002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1Rzc0puQmJIL09sYnRyMHRWTU5aRFpwVk0zTXpDS1g0R3B1QWtINUFPN0s4?=
 =?utf-8?B?bzJHMndTMzlwTmFjdzVIOHpGazNyMmNLaU1lVnFDV2tPWUJ3Sm05S0lRNFY5?=
 =?utf-8?B?Y1ppREVHaTFjVFBoVFpDRExvSzlhOTEvWTZ3VS91SnU1TTA2eWFJZ0J2MVcz?=
 =?utf-8?B?bGl2Z3hwd3k5MDdMYlFvRVBKaVAreTZFWHZGMW90RW44K0ZubHlveW5UMW5k?=
 =?utf-8?B?MmVCeHFEWGJFUGFMai9YZG9BMFBpWnZ3V3FrdGNVMnRJUlZ1K0MyZHp1dHo1?=
 =?utf-8?B?alhCNjUzOUhhdm13Wm8zZjN5SzhMc3ZSNS9qVy9GQmVaczBXV2xIYkFuQmZN?=
 =?utf-8?B?cUxVd0poWktxWW5wVXpyTVR1TWN2MFd6UVdEZDBLRzBVaDdHUGo2QlN6QWlS?=
 =?utf-8?B?TUtXclZpMFNmcHFFTEtFVWNxbTR5M01IbzBZTkljYy85RXR6Rm9tUzRNMkFM?=
 =?utf-8?B?bVZnejRpTnNTSG1VVVJYZEdYMXJQV3ptRWM1NmFDMkxXdUlaODlUdDhiUDdr?=
 =?utf-8?B?aW9PUnAxbHVRS1pieEE2bUdKNVUyd2ZZT1lmYUhmaUQrU0ZGV0luZHJmNURy?=
 =?utf-8?B?d08rKzZXSnRCNGV0dWtlSHhucjBoeHNhQUc4ZnowVzdmd2VNMGxIa2pITERL?=
 =?utf-8?B?YXlINUU5S3ozdCtWaWVybnFTd3BBVFU3ODFuVGg5a0pwR0djTVJDTnVURGZC?=
 =?utf-8?B?QlJlYjhGT3lxTEdrYWhPdUlWR0IrVXYrekdRZ1hpRXJlVVBLaW5hQ1d5NDNW?=
 =?utf-8?B?c3hOOVdENHlST29mM09tYWgzL0pZWGVBcTNKNzZuODg3ZmR5WXp5OVRBR2JP?=
 =?utf-8?B?OEhtVmJmNUtScnZpYm5qSGhGVDVOY0Rrd0d1cmhGdEd1SWJzN0hjYmQ0T0NZ?=
 =?utf-8?B?RmNzWFpGbVlNblJ4OW9QT0NQMXdvMHZQeTB2UjBqM0pHN2RFMnJUekZYR2Nn?=
 =?utf-8?B?YTZtUFpGSUY1YU81ajRpQmNkUmdIN3lDa2wyTEJsclk0a2lmMXROUUR3MUZW?=
 =?utf-8?B?RUpGYkdtZzUvVXFnWHpMenRKcTRIa3hpMXVjdmFQMEJIdkp1S1kyMXhDOTFV?=
 =?utf-8?B?bGhMVlVtaWRFSnExYmVIeStvSGVpN2NvSHRNaE5Pc21jV0dqLzlBdVNTNmZK?=
 =?utf-8?B?OGNuR3FxdDR1cFZST0RUVis0dUdmQnFtT2M0ckc1a3hsRHZNTTRuN3MyTExz?=
 =?utf-8?B?aGMvRUhUa1dkRzVGdHAwWUx3SGZZU1JadVVqNHMyUGRZYm1nNXlrUUR0czlC?=
 =?utf-8?B?aGV2L3Uvd2tJRGlkRFI4dVFFb3ZvTHIydGxLbFg4ejAycE1ldHNJK1JlZmpr?=
 =?utf-8?B?Mm40UkdBNUFPM2VpQXJaaUUxcEtsUDdvVmRTL0szMFFxcnFnQVZBU3d6bkMr?=
 =?utf-8?B?cE5XakFlbDdNVVRpVXo5aHZ3R0Y3UVhWcnRwOG1vajVCb255aFNSd1FjS1Bs?=
 =?utf-8?B?SExvV2gvVm5nTnA3U2pNV000VGtEcVczN1hGUVE2em9oN2ZMbFpsSDJUWlk3?=
 =?utf-8?B?dnNvODY1VGlLSWVOektYRFhuVzVWQmp3OW91SUZmQk9kRjl1cG9OR0hjcGhE?=
 =?utf-8?B?REtJYXZId2dmNWtLLzJvb1NhSGhHV2o5UTVSSHF0alBxdWNPZGVFbHI2VHNl?=
 =?utf-8?B?ZnRjMXFyTURNbHdDODhlSWhGYTFTQ1VNdm1mS0JNRFBTdW0rcnJjU1B2SDRq?=
 =?utf-8?B?azJ6N0VqaEc5WWhDaWhZU1FOWllxbENmbEc5aCtRUnVSSERnaEdWTjV6Z1BT?=
 =?utf-8?B?MjNiMk5rcEs4V2JqMFNSU241NUV6cjlRZEpFSGF0OFdNbzN3NzdDZ2JnV21U?=
 =?utf-8?B?L0xmNkFURU5TdStKSmpxaDZwWDFaNy9lcXRqOFVGdHZSdjN0WU1mVTk4UXBH?=
 =?utf-8?B?T21kcjhFRFJRZm16ZzZHM21GNnpNWXF2UHpsZ0tRYVRTWjFKakNQN2thRGQ2?=
 =?utf-8?B?MWd2OUdodzNpT1h1NmJMbTV5aytRTy9ITit3bWNXM2J1YkNwUzQ2blpjNnVw?=
 =?utf-8?B?cTZ4WWRFTmNmQTNDSnZzajFLd1FneDNDZFZQUjJNclVUTlZveGhOUy9IdXlD?=
 =?utf-8?B?Q0NweXh6Q1RFSmxBRDVVa1ZPSEFCSlcvRnRkSzJVOSsxYXhVdUNEcENtMmVz?=
 =?utf-8?B?VW85U1dqMkhXQlJKUXNidEpmVWUyUnFMaU9vZkxYOUJtNWdTU0ZodU55alFJ?=
 =?utf-8?B?dWhjZ3gyMzFQN1lHV2tkYmFpb2hrWnlVcC9DQUd0NW5maFZ0WkxDcWREazMx?=
 =?utf-8?Q?4RA9Vo//0baz5yF8WRKk5tjV89AEfhcnaweSHbGa68=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ED8DF693327804AA9E769EF702AAEF1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79689f4f-a48a-4044-3ed4-08d9f623acd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 16:52:13.2617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sLQpgPtjTGn6nqZG1GnaKx/83AJCZVwp13JgRE9H4UiWOhN0QcIMfJ5toJKxcyXRjNhMnnIeWtrD5WDBNPPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3988
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_085217_823357_12F3CFB1 
X-CRM114-Status: UNSURE (   9.15  )
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

T24gMi8yMi8yMiAwODozMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFRoZSBOVk1lIHByb3RvY29s
IGV4dGVuZGVkIHRoZSBkYXRhIGludGVncml0eSBmaWVsZHMgd2l0aCB1bmFsaWduZWQNCj4gNDgt
Yml0IHJlZmVyZW5jZSB0YWdzLiBQcm92aWRlIHNvbWUgaGVscGVyIGFjY2Vzc29ycyBpbg0KPiBw
cmVwYXJhdGlvbiBmb3IgdGhlc2UuDQo+IA0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tl
IDxoYXJlQHN1c2UuZGU+DQo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiBBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBh
cm5kYi5kZT4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3Jn
Pg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0KDQo=

