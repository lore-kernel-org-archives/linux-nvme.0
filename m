Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26BEC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5t1WtdLnvRpG9K2sTjpANRBpKQXHJLsCWc0FA/BH/OQ=; b=pIrDn+f3h50ythbULWjSCyyq2z
	V6bNM1vYca9yhJEWHb0+Jl6KT+dVV5zxTu/YEX0oNsdIW0txL0M2vi6zzrBLXc+LKNDYw9EyEgLYN
	nrNYW0/tyMtP4+3OxDxW4Z2F6JhvribPpJKpLc5+w/SpBo6QKA7fUxLYIunyiKcbgqs02dbsUc9W9
	EAd6BUeUJOBQ+GN4mP1VP1CG4beGWyvD0RZwhDB3SWCxVPl7ZgFMQh0kO3Vrn9vfEY8htF3zjn56P
	JCIRQoIXSqk54//Lcu341/alLHNrtfrMY6Awh8NAVBdTC4AgDuQbvK3jgde5Nft5kK01pbsTunfx3
	KnpjoewQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8cHA-00F96R-7f; Tue, 05 Jul 2022 06:43:12 +0000
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8cH7-00F94A-1e
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 06:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a90qGSDja23nOn+i/ymYkNR7HndwyRhpRM/sVgQ5pccAakQAoH08S+LZ+mfOBaXxjYDM4iXQXfMjAqJu4TlEkgnvzGZl+PZdc1l58tLSgSel83DIk+VugVRVDtuWhcbBiTw8Ju/TTwsSdMxvAdi06UY0S5pize66zb56zcK9UvlShQewZ1qAgNeyy7LkiDarCMMJ/GvRlsfqr0W7tG7V1z7M/eZsoayARQ/DjLTEXlmDgMsyrN9RFTH7OKkCPE0ger8Y4YVlkOkl28/hNAqp/cOrIbGUFTS4L+UEUXmFqMsPrRp2nf8QbtzpFHB6M46veppXYnazy3W2QUfFU/8pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t1WtdLnvRpG9K2sTjpANRBpKQXHJLsCWc0FA/BH/OQ=;
 b=C9M4XkqS0i0FQX/HAnXpj0rxOE07EoVDtTXkQigFrMvM19W93wD5XSlOBKoLgW3qA22RZuTQnRcxQf4bJjLIxGosT214879+CZ9fH2ZuY+JN8cqWHpP4EP07ly2V6V5dACdvzvONW/ksfxEWJoQMccfPaTdrbRh0v8d9uZqM5sUfyKrY5DiMsJS/InMTvLyjDR3BZ0IXpbRgPsOJNRHYrCYoJLQeUksn0Bd20MMfbVR++M4KIO7lew0NkaqkPLq3dPa+Jbu1XMYIbzxqxKy+s/gWppRbOjWpp40nGuaDz7hcpGwg8JNHqod1RlYNOI0/6zrfgCB4HXO6J0RQlXB5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t1WtdLnvRpG9K2sTjpANRBpKQXHJLsCWc0FA/BH/OQ=;
 b=E5FjejdbTToiEJRYCFVuIuL8E40b++VwIhPWRahyJuEOguHNAB2wZsKxN1fxwnKb0SG+V2Qpt3tKn6PyfjEJnC+1lYdmuebDgBl6Pa41HXVbw7PseSBufgry9s/YHhZcQjE9UTbhMpWPJjpVvH4alJgYRnyaHCjis4RxAMUcOd7z40cZwaNUqRzIsIqipAnSFMrROOdl2NI6CPbbtjtiKV2UDSd2rNrNKyJ8/Mwh0sxnGVo6l1LYij2ua5W2Q1D9tgwEhNYoDC6Cm0Va7iwHSQa5RTqIamlPV2Yp11vf7sSRxS/e4Ns6KdhFKsVukFsJkoapTcPKnkY6mfYcZbkHvA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4837.namprd12.prod.outlook.com (2603:10b6:610:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 06:43:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:43:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Damien Le
 Moal <damien.lemoal@opensource.wdc.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 14/17] block: use bdev based helpers in blkdev_zone_mgmt /
 blkdev_zone_mgmt_all
Thread-Topic: [PATCH 14/17] block: use bdev based helpers in blkdev_zone_mgmt
 / blkdev_zone_mgmt_all
Thread-Index: AQHYj6QIAfI6Iq3OEEOykZ9+r9Gqw61vVa2A
Date: Tue, 5 Jul 2022 06:43:04 +0000
Message-ID: <d2e677f9-6e36-f963-b58f-7477a47f774f@nvidia.com>
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-15-hch@lst.de>
In-Reply-To: <20220704124500.155247-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15863d64-207c-4e58-c4b3-08da5e519cf3
x-ms-traffictypediagnostic: CH2PR12MB4837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  29G0MNeSfK+UENckNR9EAKZjPwgXj1CEHDNeq0oN2e+FfrmWNnJ8LxOlFAofW4xFDpXFmL8MoWv9AhPDGasCicVOivYFa6UahZa4iwq05xU1TgQrg44XTd+I3gK0thAQEXyA7jwn4mMmPBW3bs/vNehajcuUzV0zWoGnccXOhqlRvzrmepZj0zadxmXD/ceXP4zILb1+zXWENOin2TVYBJWk9GfTGG+33ZKhfzaFoQ36S7YVvsH2i5dytoeqan8AbcjsH3gDhzdgxuXJtkx3UHhyRpC0/7oH39j0hoATT98cT6CR4Fn2WrlR7bqssT1jkcbMNyD7knAPNHAJXRU3Sf7bN7RDj7hISUs/Q33NcZcBJLwAQcVC3T7eJjGpEXvoE1cuya8lGGg5dhE00y6l3Uh/+DNY0DQALzxgFmYQXHNIALa3rY1SjD6yt3wLjTm6eu8qmFkgZ+ctYB9ZAGzMbghsWGip0yMhXQSqnOCdGgORFvzmmaz8BD1IQX8ujD8alDGVyU9wk4dQGCUzQkgebkUT3orEWB9JvO85cT3PCBEY7cpKcwrW5Kj28evXKhrWN1mlLhE6dONBDgjxffO0vwpVAiX9zu2OiFkd+7eZxJBOuO2HrAqzqFMLPoGAF8/mnOz3Gf4tJS1pV88jipFPSxlYh2tiNMMvqpIOWaFrvJbdI2za5eoluDojGideak5LRe8eglPH4T0FXnvc8OBGNnv9uws8dm4r3dFTQd10gIO0bSXKevX4p+7iQvQBdiGBoKU+2ToRO/bKkP8WeQvTiU38s0Dp2hb+izGcTizbyfkcd4SpTZFHAXlV023ljMSlRLFaZTQVvgToemfmuXXduyFDJ/+rcU9VhvgvgRdsz3NdRGBsZXZ+3fHVB9JkYXo3
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8936002)(31696002)(86362001)(478600001)(6486002)(5660300002)(558084003)(2616005)(36756003)(186003)(31686004)(316002)(54906003)(110136005)(38070700005)(2906002)(6506007)(6512007)(38100700002)(122000001)(41300700001)(91956017)(53546011)(76116006)(66946007)(8676002)(4326008)(66446008)(66556008)(66476007)(64756008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MXBielkrS09PU2k3TElyMWc4TlEzTVJ3WDFiaVptZFVNL01uYjZpWExwWkZR?=
 =?utf-8?B?VUxaNVRvY3dERW85Q2NnTWlHYjdiMnNya2oybGhKaWFGOHVvRyt0UWowRy9r?=
 =?utf-8?B?Z0JMQmQ5WTU4S2l6NktGaDFFYUFlQ084bEY5WHVWQ2xPUzNvVlBqSzI4VUxz?=
 =?utf-8?B?aGlPa0pacG9DVXA0NVBPaXBTZjBmSllnMTQvMVlxalAycUh6bVo4elZqTnNQ?=
 =?utf-8?B?eEZoSUtsM0h1Tm5USDJlYllJeHE0cTVRd3B1Y3FJMFIvVWt0dWF0MlBRRW9z?=
 =?utf-8?B?WFBFMlI3cTFENWMxSWw2VnFsMU04NjhML3d6ZkUxMUo4VkFaUTVUcENNZUxr?=
 =?utf-8?B?a3VTckpWY2JOQXRac0lmcTFuTzNCZGhsOGFsUGtydHFQZDlKTkc3SnhSOWZi?=
 =?utf-8?B?ajN3VDg1cWhKOGJpOFlYa0hNVklja1gwejZ5Qm1FVkZUY3BnRFI2eHUzWXpT?=
 =?utf-8?B?VVZxWDRKZC9US2JaajZBMWVCdXdjZUhkbDMyOFBSd2RPbURodWloYVRXTDAz?=
 =?utf-8?B?K1RScTJJVTRDamN6WmRTdUw2VGhTbUVZMnRLWXBZM2NVMWFRRy9oSVlwLzIx?=
 =?utf-8?B?TnJzMjJRYUw5dnEyQWYrQnFHMWlKb0t5TUcvd25vVkZFZDZCYitkdGhMTy9n?=
 =?utf-8?B?OVVrSDFBeHEwdkhXWUJaZTFudC92MDlyazRLdm13Y3VmMUdKeG12RjVJeWM4?=
 =?utf-8?B?OGpDNFROWDFuNnhFQVVDeEMrY2krYzllSjFLbjhWOFczdUwrMXo5dnEyUUIz?=
 =?utf-8?B?SXB2NmoxWWI4WkdwbitJZmdPWE9NSnNwbVFXNzdrTVUraVN3V29LSWVOMGVQ?=
 =?utf-8?B?UG1BTm12OWFUS0pIeWlsRVkzTTE3TzFlUm04cDhtUVNTRVBzK3pjS1Vnc0g0?=
 =?utf-8?B?REJyMGdmS204WjN0VTdUclhsU3JJYzRFdlk5azFzUTdJSWRRcStZbHhtMkdK?=
 =?utf-8?B?d0l0bE5pVklBNnd4eEMrdzJhOU9DQkgrTGpER3JBcFZ1cDgxWGgzd1AxU2Fi?=
 =?utf-8?B?alRWY0pCRFpYeUpLdWF0YUY3dENkd0pJdjF3VDk2MkZpN0dpVXBGOGtLc0tt?=
 =?utf-8?B?QWZwY0NRMGFsaERyNml5a25FR240N01OYzE4b2hwWk5VMTZ2SDlSZkVrK3RX?=
 =?utf-8?B?aHhaNzQwOXo3QkRnaVppUmhmU1RPcnNTOVBoNDZudW8vS3IwL1N5amxTcW5B?=
 =?utf-8?B?Um9KSTdHNm93SlZ2VlJHNWZSZVhYYVAvb2xWVjdiOGIvb2FSdmx0QjJ0RHRn?=
 =?utf-8?B?UUhTTHhlb0hBemswaDVvNmhHdVpDMitwaWdJQ3U4M3pkcW9NRUEvVE1jQU5G?=
 =?utf-8?B?SFgvak5wc0hTN09HS1V1Tnhyd085R1pLWjl4OXFuRUV1a1liMDl3SURTOTZp?=
 =?utf-8?B?aTE1WVJsTFkzYUVNaWtyblQyZE1tQUxBa0xRUUh3UmRsOFMwNTVoNXpDWi81?=
 =?utf-8?B?WVM1VUlxWW9YeE9vbkRMWlIxY09tbnU0R09YZm11bW1aYXVOK3BrV3g0WWJM?=
 =?utf-8?B?YXBRNkF5cmRMSitMTnJ5ME9USEJlbVFLME00M3ZrRzNFTTZadEZSUXVLTktV?=
 =?utf-8?B?cGpmYW4zblBFZWdrK2NudVVyK1lSS0pYMFdkNEdwVVRiUWF0SVNQNC83UHln?=
 =?utf-8?B?SGN0bFljTEtrZ0piQXZEMFl2UFRYM3NZcC8wZDBDSUZ4TFl0bGcvVTkrUlpL?=
 =?utf-8?B?OVZ0ZWJkY1ZxQ1ZydXY1cVNwZUR1TlFqWlZJTzFLcEV6b0dtOE9kKzVhMURO?=
 =?utf-8?B?cUR4VE4vNWtpYkYvZXhtZkREYnNGa2xTTmUwbEV1MEViQ3FYdytMSUJlZWtu?=
 =?utf-8?B?cU5FWlJ4UlR6QVdvNzVRaDFNV0tEUzR3amZZeFFvUEd5R1Y0N3libkJnT1lu?=
 =?utf-8?B?ais1cGcyaGZZOHB2R1k0U0hEOENsK1JGc0laMWRPZU0xNE1BYVZNZ0tBMzlt?=
 =?utf-8?B?WEdPQndONG5keEptbEV2VG1lWFV5ZnlxWTFOWkt6SGJLSDZCdHNMbTVEdW5W?=
 =?utf-8?B?ZFBwN21WS0lKaHRnTHVXVGdLMVMrNGFkU2pRbjZNSE1lcGQxMEl0QTgybjhj?=
 =?utf-8?B?RkplcU5SUXhIVmlCNEZVZ2lwaDlKVjNHR2NFcUMzT0h4aWw5eWFGb0kvS1hh?=
 =?utf-8?B?T05WMnlRQm1kRmFaeVd6UHdRS0JZb3ZYdVBDdGZQZ0dmTUNYMXl5ekIwVWZ1?=
 =?utf-8?Q?FfUG+Ky7s0BSOctkhry/yVxSisdtWDcSrVwfPlkMeVB1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD47E84BDA41E845BB99711858B02D37@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15863d64-207c-4e58-c4b3-08da5e519cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:43:04.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/g8frVEBJdLwZksnNdEbevuaG/+y/pNXgvv4GSMADU+Fe2JhfLQW1PBUAvw3VgiW5qvYKyoZoN0L2qZmUQ7Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_234309_112001_0BC5F6C3 
X-CRM114-Status: UNSURE (   9.33  )
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

T24gNy80LzIwMjIgNTo0NCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUg
YmRldiBiYXNlZCBoZWxwZXJzIGluc3RlYWQgb2YgdGhlIHF1ZXVlIGJhc2VkIG9uZXMgdG8gY2xl
YW4gdXANCj4gdGhlIGNvZGUgYSBiaXQgYW5kIHByZXBhcmUgZm9yIHN0b3JpbmcgYWxsIHpvbmUg
cmVsYXRlZCBmaWVsZHMgaW4NCj4gc3RydWN0IGdlbmRpc2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNClJldmlld2VkLWJ5IDog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

