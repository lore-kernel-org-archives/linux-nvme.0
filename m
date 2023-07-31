Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E65DC001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2BRBiDUnEwTyFP08pIK9dz9OxTN/j2R7VLYvg7Q3cM=; b=nsgmmHi/n61NdlyEYLWvx4e2TC
	4NQEgTHRknUoQ39VIlPzvxfnxIZlYoxS7KDaOlAzyyFu8PxEycDLnmwcWxSm8fZXipo549bYrHoGE
	Vi5BvQikSf4aw2Z3xSn8jdtr+iCtTYes+70/D9z+P/1awWtY6/Cej3bWHUaRLLe1dDrbPGCsUYwQh
	l4JumB3bFHtiCT5+WA3w85c87nnbac/lbLExGVGHlVU9x9keTApR/0FgYERycBwhk/4LVEJUIJVE9
	kHEtCx6fDv9Gt6rsPHRNrvU4AhCBJEV1X3VdXS+Kpdwd1MvUnJWoP/jdO/JEiYpnQAiuttqOm3fsr
	kuCM2z4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXfL-00Gzbz-1V;
	Mon, 31 Jul 2023 18:30:47 +0000
Received: from mail-bn8nam04on20705.outbound.protection.outlook.com ([2a01:111:f400:7e8d::705] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXfI-00GzaX-1P
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 18:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8a0sjOOEZFPXyzcvZpcwlODe7GNig7pY8U9c2rPipWGWZ5z0W6Vef8C2oy31oUj9En+I6XYcoOhjAaZahV6Ec6Rzn0NXnjBNj8La8POfLeq7x/2LS2QW2K7mbzW15ovQif8l8Dwoya1C+oZN2rxbRPfYnxaN46ewYbyIGzsWTuJqEVsCsymv6NoH2NEQZF1SBa6esK8d8cBA2EI3Lh56Jp6dUjwT8xJNBktAU2kXMGT8PKbGFcBzZkZ/BlZGqxPzi0h2paJdFHHhBfRg3JQjISwPo1MQC1NbY/e8Yx+EQemr1g5fltFjaAyzlT6bcpAxUyNVDF7MCLBt+J+lAELTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2BRBiDUnEwTyFP08pIK9dz9OxTN/j2R7VLYvg7Q3cM=;
 b=YoZHBFlEWJd2fxen0GjTigxHhmYTaZNUlIUgn7LrDVAEP/x0xbrR4kpbSYDcJSy4fsr5fWbdGbJ7UxSAaUKU0ghxzWC8LYbtmyDrOZ9SreFfMcdR73OcGXMeVL11G1bf488FKMqrjhsvGVREpIKcqwKztLJQERB71qXuiHXpYo9TX8WDn1c4i9676UCkD4FYhGqd+FQt+V5DCzb0j3314iakOkfAlN8WukAA++hog/ZAEyMA3qWLR1/QKyFu44rPiiQzN0piMcfUrHfQD28Ei5lF9bS3/pRMG+2sZ4JUlkQM9bXxjgBgxV7gAMp/R7xKK2SAZKAwwsr/jj4OG1XgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2BRBiDUnEwTyFP08pIK9dz9OxTN/j2R7VLYvg7Q3cM=;
 b=nVtDr59a0ENoBkbjhisyER+ljC4RWcFbwpxKDHgWrFyLLtJITycu0aD3VnwJl/T6P2+C+7f014CaL/RAgugLrtnDSc5mMDFmh405uFkN8ssxzhNDCYWUscqZGWNXkXzTLusXEvbzbwE3F38QyL82cL1L2rIp43i2UPruqSUz16Y=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:30:34 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 18:30:34 +0000
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: RE: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Thread-Topic: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Thread-Index: AQHZwJhCaUPaX1SiKkqSz+IgYqGKIa/T6CKAgABPpUA=
Date: Mon, 31 Jul 2023 18:30:33 +0000
Message-ID: <BN9PR12MB532469A81B5D3F6C297F91C9BC05A@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230727150550.5851-1-varun@chelsio.com>
 <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me>
In-Reply-To: <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|MN2PR12MB4126:EE_
x-ms-office365-filtering-correlation-id: 6d9ec15d-f977-49b1-5d64-08db91f43a50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4swXK9241TbYQcbIbrGWFfe0ngWr22R1YSgHqb2cN2Ew3kcuCYlIkegYyR+89vXekogccfaQlAPEYnulVRPTjPdYN6fgaMgPYKsinJWW1hH+0LyugAMnMEYylaUvSf6o919l0sM+lZ0/n5Z/HhaPC3xrYVbKB9xWQFErNAKvNPvhS317a2VVGHzOOdnRoInetK5ph46o9+DX9Z5/cDLXYD9Eozy0Q1xlpB8l0PmPqCRreZ6tqTKY7LLeroDeEByIubWyURBIuZaryLymhfH+GTZCeA6Yk4CQIb6nqyUiprWFh/ct8Gz60286QgvzAv8F5QRgUKPWJhdlP7MbrovomKjOnpggs8N3DcsF7DndCAjWGdvBURWdCAFWo89Kkm0KPqg7AsrZvdFrYH17ZUOfQfYM7wjcwZ23pVMcOduf7V1FKjRAv2c+Q2hCum81Aw5OJYAHiIHgtySSJJYOgn3RClBiKaG1omRT/Dcxu5LK7VXB8VkxfkJitiBn4c2pzkjk7bjPNyCESYBOfJ0UJQTMef6HTrhCoJ1fjsDPp57s26rrqu8viDbyXs15C74Q5IK7RwIupQbTAdLPRdpwbUsKlWjVuy8fQ2dNZOvUg/To06LN3mtogC/H6NOsSS3HzGQ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39840400004)(366004)(376002)(451199021)(38100700002)(55016003)(122000001)(86362001)(33656002)(38070700005)(9686003)(71200400001)(7696005)(186003)(26005)(8936002)(8676002)(6506007)(107886003)(64756008)(5660300002)(52536014)(76116006)(4326008)(66446008)(66556008)(66946007)(66476007)(2906002)(110136005)(54906003)(41300700001)(316002)(4744005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1M1RksxVUJoZUR1Wmg3Zm5oeE5mYlpwUytPV2w3VEFFcGpFZzF2dk9FVytL?=
 =?utf-8?B?MXIrTmFWWkg3bzBWK1hCZlEwUnpkZ0hPUTJ1WjlseDRvaHNCVy9OdGszYUZx?=
 =?utf-8?B?R0l5eUZ0UTNlVWQyRHJZUUUrWWd3WGZwSldrZlA0WDh4WU9zZ0krZWpvV0Jp?=
 =?utf-8?B?RlZXZlFBSXoxc2lESldvOU5sa0RpQm5ubEpQTFpLRVRuQ2d0Yy94eUZvaWlB?=
 =?utf-8?B?N3FWdHd0aUt0bU5DUGZMTHg5Qk9LQVdiT1FBN05wMVI4Y1JtdDdFY08zNFNS?=
 =?utf-8?B?WUFIZkQ5QzRsNXhDZVZTT1NYYy9ITmxxd3lUYTJRTjk0cTM5T09YUEkyQ25h?=
 =?utf-8?B?cEE5RSsxS3hOVVNHRjgwSG9zSTJxdExuZmxOYk9DekU5V0x3V2F1b1MzaWRW?=
 =?utf-8?B?aDJNT0lObjZhRFJTbnNWSXVEc3FBVFhJVnlycmx0dlNxNktRdFZDSnpWT2Fr?=
 =?utf-8?B?Nmg3T3UzWGZCTlR6dit5V0lUTitXeU9WWEJLOVN0cFhiTTVESWwxRS9Na3lM?=
 =?utf-8?B?djZsTHNGL2syNlpOUFJ0YWJENytiQ0Z6cXRjRWNaOVJjcDZoUXZTNzkzUndx?=
 =?utf-8?B?clRzT2NsVlB1SU1jVXpBWHM5MHh4N0hPd3FKTXBRTDVZalR1L0tYb04wY1A2?=
 =?utf-8?B?b2dObEJnaTQ2MDZoeElCU2F3YWZ3bzJXT25iWDFpbmwwblBjcTdOUDh6UDhN?=
 =?utf-8?B?QzQ5SkpXYlo0cW9BQng1MHJTanFPeUtJWG1ZM1dzd2x6ZHJBQnpvQlNZbnE5?=
 =?utf-8?B?Ymx1Mzk1UlNPZVVwVUM4RHVMWHFUQytRUGhCZnFaRUYxSGFQRWxkSk1ZWHJH?=
 =?utf-8?B?dDFWYzNrWnpKU3QrVzEvVEJEaGRrTDlZYnU5ck5KNHZlMHJRVXhmNzBMb01l?=
 =?utf-8?B?c2x3bkRSdndsbU5NZkY0bEFxNXdyZnhNdzlsNkpvMENyUWw0WWEvNTcrRmxK?=
 =?utf-8?B?ZzBjM1dNTGZpSDlyWmJrcENCRlAyS2ordUQyZ21jaUVCbGFwM0o3em1FOG1U?=
 =?utf-8?B?VmlHOXJYa3gzbFNWQzlCOWEwbEp6Mnc5OEJMcUlVd2tmcElhdG11WDIxQVJS?=
 =?utf-8?B?TDc0d1d0RzBISW16aEsxT1R6UHlHZ3ZjOEtWckR2Wm0rZUk1WC92TTlMcHQr?=
 =?utf-8?B?ckRLc2RQNkxOWGNsTnlKckNWcytZMEJmSHF2MkJRM3VuNmEwNDR0c0xXQkJk?=
 =?utf-8?B?ZDJLS0cxS25RMVRJeUNBa0EzdkFrWVdYaEduK0lXTE1vc3JGa1l6c0syR3RC?=
 =?utf-8?B?NWxXV2J1dkZMeUtLVGpLaDBFaEVzMmg3UGcwczJ4R1E0YVZQb2JTUGQ5RWEr?=
 =?utf-8?B?ZEhnc2ErTlYwOXBhbVNjOGpEUm12Wko4b2sxYWs3RDlVNjg3Q0hqbDNvRVF5?=
 =?utf-8?B?UXMwMHVML0FwUHIwZC9xQ0VldmIrbWFqL1NKT2xSdGdUWlJFSmVMdVptUXoz?=
 =?utf-8?B?N1Y1WTZVOXlDdkZ1aXk4S3B5V045dC9EQ2RnaU43N3d5eUF2dTl4WUlyUnVv?=
 =?utf-8?B?VTlUQ1JlNVc5SnVwMEZ0S0NwR2dBc1MyYXAzTENPbWZMak9Qc0J2QU4xQVZU?=
 =?utf-8?B?VGNtdXpVTUxBQVlUN1J3MmY0MkZuci9vWlRIQ0VqcUk1cjRrZzluWkZDTDA5?=
 =?utf-8?B?THRIZXJPYTdzMTZBTWlUdnlOZUx5aEFYU1p5KzZXM1Q2a2FyeWtKczJRb0tS?=
 =?utf-8?B?SncrZStxU3RPNmh2VGFqRkgrRnZPWisxcUNtYkwrVG1GeVQ1MXE2d0RuamVm?=
 =?utf-8?B?MWlaNm1SYmVoaWZ1aTZXQ0VXc1Q2TFdLakZrSVo2UTFXUkpMaEFtbThaSWps?=
 =?utf-8?B?SlRNbUdNTVFWRnQrL2pQdXE0M1dWcVNrYnFRSUdZNEY5R0dzUjhhVnNvREFN?=
 =?utf-8?B?aU1YZS9VOE9OSkN6V0ZGcjR4YWorT0d3R29ROWZUdzdDK3JUZUF1SjhyOGFD?=
 =?utf-8?B?QWFVSG1zTnIzTXVKdEVXWEFPaFBEY3VUaDIwOUhwRDVKOGJBc3piQVhnTEQx?=
 =?utf-8?B?TGYxTDBzSlV0STNPVnV0cWJoWms3RG5iNWl5cjV4TzNYSkx5WUpSdmZBLzVy?=
 =?utf-8?B?N2N1N3d6TlRRY3FiVzkzQys3TzAzNDhtQjJBMnR6cG02QTUrZitqdVl1ZCtz?=
 =?utf-8?Q?cgr2wxmLN64XIPySo5nGoSMLp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9ec15d-f977-49b1-5d64-08db91f43a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 18:30:33.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL0F8bbRFtqxkuWosvj5gQkiz+dU3tqCQlBPfj6USiGGulFbGsRuICeA9M4kYe4y3vqx/RFQ/SNuQ9Wti1xiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_113044_672826_5672DA06 
X-CRM114-Status: UNSURE (   7.46  )
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

DQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIGIvZHJpdmVy
cy9udm1lL3RhcmdldC90Y3AuYyANCj4+IGluZGV4IDg2OGFhNGRlMmU0Yy4uMDUxNjM3NTFmMmU1
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYw0KPj4gKysrIGIvZHJp
dmVycy9udm1lL3RhcmdldC90Y3AuYw0KPj4gQEAgLTM0OCw4ICszNDgsOCBAQCBzdGF0aWMgdm9p
ZCBudm1ldF90Y3BfYnVpbGRfcGR1X2lvdmVjKHN0cnVjdCBudm1ldF90Y3BfY21kICpjbWQpDQo+
PiAgIAl3aGlsZSAobGVuZ3RoKSB7DQo+PiAgIAkJdTMyIGlvdl9sZW4gPSBtaW5fdCh1MzIsIGxl
bmd0aCwgc2ctPmxlbmd0aCAtIHNnX29mZnNldCk7DQo+PiAgIA0KPj4gLQkJYnZlY19zZXRfcGFn
ZShpb3YsIHNnX3BhZ2Uoc2cpLCBzZy0+bGVuZ3RoLA0KPj4gLQkJCQlzZy0+b2Zmc2V0ICsgc2df
b2Zmc2V0KTsNCj4+ICsJCWJ2ZWNfc2V0X3BhZ2UoaW92LCBzZ19wYWdlKHNnKSwgaW92X2xlbiwN
Cj4+ICsJCQkgICAgICBzZy0+b2Zmc2V0ICsgc2dfb2Zmc2V0KTsNCj4NCj5UaGUgc2Vjb25kIGxp
bmUgYWxpZ25tZW50IG1vZGlmaWNhdGlvbiBpcyB1bm5lZWRlZC4NCg0KY2hlY2twYXRjaC5wbCB3
YXMgcmVwb3J0aW5nIGZvbGxvd2luZyBDSEVDSyB3YXJuaW5nIHNvIEkgZml4ZWQgdGhlIGFsaWdu
bWVudC4NCg0KQ0hFQ0s6IEFsaWdubWVudCBzaG91bGQgbWF0Y2ggb3BlbiBwYXJlbnRoZXNpcw0K
IzI3OiBGSUxFOiBkcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jOjM1MjoNCisgICAgICAgICAgICAg
ICBidmVjX3NldF9wYWdlKGlvdiwgc2dfcGFnZShzZyksIGlvdl9sZW4sDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNnLT5vZmZzZXQgKyBzZ19vZmZzZXQpOw0KDQo=

