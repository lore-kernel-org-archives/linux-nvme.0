Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF145C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlH0Ua5k1BaRuBi5B9EMi3kSPegq0qjCoDytexE2ixY=; b=TafBgn6Y7dt/CvR7vqwZz6+c7s
	k/i+QCdB5OfAMj+DVKWXyjyl0Y4jAqjiS5NzAQC7ZbrGGhJtrGldOBSbv5iKiPr9KIGlw57Ay2TBJ
	q5zhfxOCYTkaTwJa+QaK7wBInK+Q2OhO+4CYWCbAvkpYhavSKFRFPN8CSG0qo1GC8lAKayAOYafVr
	kpGPP024LymLnbFHRxlWraHaU3i/qgqugyyjbX46+fkbd11AJdN/+Hrx0aPs7SAmwmr5yDe6tqVHz
	v/qbAdOdHnxB8ej9TDv4n4duDkGmwKqPBG0mlfRDqa1wyRtdQzYiUDETR6L8oM+4E8K45oXv2RI9Q
	15giarhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun3t-007Kv0-G7; Tue, 15 Nov 2022 03:56:37 +0000
Received: from mail-mw2nam04on2061c.outbound.protection.outlook.com ([2a01:111:f400:7e8c::61c] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun3r-007KrN-9J
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKN4zq7ALC8m63DlaZueIb0uWqrJZHH/0BBkgUScZ71aVZSSFsaQJ4SlD1o6N5d/Ty9zBogp9rZrXiCOozifQAvKQs5Bj9F654+Fbrba/cgZhJteXrQ/2zVHFYe/I2QrSLEMVSFSKjz6tCzn8aDZWnbVTVnRaIZ3LJHlrDLKpLpZsNWX56/lGyUFc5tI9E+GoRawsnf7x7F+UVayVTDWFB6A4RMR18XoxafodOt1Nj4anNriGezDLPIcZ+gN3/fM6Hgp0pZhiQnhLjVPwTBqcyAvRdM6zFHY/7cYUHnNdzrKagbgxP+p3K2kUTCr4GNM9b1LV5ng19L5QHKYOPLgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlH0Ua5k1BaRuBi5B9EMi3kSPegq0qjCoDytexE2ixY=;
 b=lN4Koy9rA2rOSyC7Yb9O2Bh34VJL+6BZz/eorvdYfgw7q8IDblrTySMWX9A5etKTCV6p7PM7hUOKnLmxbq0unUWhUEO/BvbG4QPJqKND3+bMmXPIlnlupCitqxexLcmRhNGCXyfTVZJvs0FQsKcw7am9V0cWzSisXxupwHahI2tXV/A9rNw6OtCYrl9UOae0Q8j+UrIfIRP2N+eNKoH2leZQsTlmze/xHFVCTYcVRP0gXITt+MyF0xbvSFnmnih5mZwB3wAcW75QHTPy2QPXjfSwkSrrcnw1q3z64GeMJ5TRxaHH8uLO+nrZuqIzcPtPqmSfY6OQzVC8edhPisb7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlH0Ua5k1BaRuBi5B9EMi3kSPegq0qjCoDytexE2ixY=;
 b=oJdpXcHFdmQMUhGQr3arDnY5sqSVpWXIoekyPovT9M5fv491fhORPNm26tNwq9P/jRdrTnDI47h5zI2zB53mQgD6XPWDRX9Cvr1PAjQi+UzxAndAuyjZUDZgTTgHmSUXJPML3l6s87w01aEpDjcQgcgMoWaAccdSi9CTPoy/403RnuqvJaiHU0vs0g4S5VvwPBj90KiVusAc/pIF7CYSH8pD28NCCIILZjvts5qGSE2+7n8KevCZ/Hw4pMHx4j/b8MNsl/NFJE3a1bi14rMDHdMJP9xTfst2LBGmney3Ica+Ik807gPlYS+CHwY6EMAktHIjHfvloBLcDRmkQM8kTQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 03:56:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:56:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 06/20] nvme-auth: don't ignore key generation failures
 when initializing ctrl keys
Thread-Topic: [PATCH v2 06/20] nvme-auth: don't ignore key generation failures
 when initializing ctrl keys
Thread-Index: AQHY91K34rUzk0F38Uido8HRbE7Od64/XdiA
Date: Tue, 15 Nov 2022 03:56:31 +0000
Message-ID: <4f30e1e5-c904-0e15-1be7-c30d7b7d0907@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-7-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-7-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5423:EE_
x-ms-office365-filtering-correlation-id: 17b5ef71-6db8-49a7-1486-08dac6bd61c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  A+hKAMsMNbrnuTcptjXpKuLLVs2sVOA5ya8rN/HMXKLB6trdbfFETdSjxtJHcFbSqjEhCWST/1x7qjVUBCi1Mldo4gkeYEe5qpnlzEw04nC3DD0ncureAvYWl1v3P3v2TF1WQSBZj6hsB0Lm09ncfZ0ANAL3SfnqOeJ8rpCQGF+1R0sJx3NRDmxia1LcFQzWYV22ubyPPeMlJtqy8hmcHUVHBaXHi8l9d07wgitrdbjyRvzAKXGbVJb7t95ESkZP8Mp9D7EOgA3tPBEwjkAV/RWftFdTNnGY5SEnK2bUPVMEwoIYJa6jmWXk2M6dt0XCmRgoNtPlwYPgrfRv/ExMxgcs7ErgZ8WWGE1IJgOIg14zBVSbMsGQJ7yvjl3+MzfEEga0+Nk3FTN3exe6gpymv7/yIgWe0K98aM57DSuABW9ablXKaYBfdceckY2exzj5l0WsAfHJZT8q/zk/33hkXsQ0Ce+fEXaDmFiBOVu76nAbCrIq2W2WvlAhidB8Thht4sYhyr5s6NcB+UKJRmo1ugLMluFanQmnET66w5ogjmABGNezzZXRqL1OzFQjTMaOVdHk+8KZ7CWyLA8My8JOh1pCvOEyvkmvYLWGms4OfbThPrnBElkkE5ldaS5Nt2629XHX9eeK8gZit1iG/yGzP75gEmUhJWHAjh9o5W7egT9QoHMUAX2q2LjuKPuyNkBTj8wm/aaIdMWJ/Cl1wF5abiDWxFXsootYHtGxdgwOEBObc9UMRJE9WyAkYHf/mUvhyK/C4nwF+hL+NaKkQ8Xck2/Hfho6vOi0sZQFCtXDHUuNfE5cllMRFy3NiY01Ayoje7vTTqSYLRz/h92pCEJ3ZA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(71200400001)(66946007)(6486002)(66446008)(66476007)(36756003)(66556008)(76116006)(8676002)(91956017)(558084003)(54906003)(64756008)(110136005)(316002)(4326008)(38070700005)(122000001)(38100700002)(6506007)(6512007)(86362001)(186003)(107886003)(53546011)(2616005)(31696002)(8936002)(31686004)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V0F2OVpvaGdTdXNYNENuY2Z6dzR5ZGVUYVBFelpzNEZEbzlhc1Nha0ZjaWla?=
 =?utf-8?B?aVNTV3FGNXBmdXZSalNiMDE4Y2N1YmlMTkxFaFpydDNod2hKb29GNXJ0OGxw?=
 =?utf-8?B?M3Fvd2hna3BxcTI5U1ExMmhvSmczTjFNQXNBYThGRlExbEk5NURoaHlXY1Bl?=
 =?utf-8?B?aTFsajNoemdWMVl4alFiend2WDhacWRzVDV5QlRHOWh6ZXB4aWtBTTN0bGlV?=
 =?utf-8?B?ZGVvYk4rYVpTUGlsNERHRlFHaCt2QUtubTdHYVRHVGkvVFNhZXBmZjFNMGhX?=
 =?utf-8?B?dEI3aWZEaXIxNkFPMVNac080c3RzOThnb1RtSVQ0L05zN0lVdnlBTmVrWnBK?=
 =?utf-8?B?T0h4eFZmZGhHcGYwb05VYlpLeG8vRHlzVmpkQUttT05heGl2K0svaEJDZWlm?=
 =?utf-8?B?M3FGWkJKcGZnSUFxUzk4QU85VDIrZU1aWE5zclFjWjFZcGdqMWoxNWNUTlZn?=
 =?utf-8?B?Y1pkNGNucXFOeVVyWjhNa250ZWRYY3ViMjhCLzBhOWxwOTZrdDhkSlZXcTRY?=
 =?utf-8?B?K2FsK1ArS2krTzYxbFU4UU1RNnR5OGhRekdDanE4ZERZbkllaFJ0WW1BdFFx?=
 =?utf-8?B?UFc0aHBIY1hvQXRXZFgrR2FOQWJVYXQvZ3VNU1NnYllJVklSd053Ri9Jd3lr?=
 =?utf-8?B?UU5mc01OQmxhaXhvVWFxWmtwV1pOS0xybWttcGtWOE9TbmFqT09kVWhtWDZR?=
 =?utf-8?B?SjhxN2VjR29qWnl6VHVwTWNvMy9RRC9Yalp6R0dtc0crdG82ZnJBTmFtMHlu?=
 =?utf-8?B?SzA3TUZWUEFaMWpwalF6U2FlMHV6Y0d0eTNsU2EwTnc2eFVQY1pPU3V1V3JG?=
 =?utf-8?B?a0dYUWNjNFN3LzFqSjhqOC9pN21UL1dQWU8zb0RMWlhtK3lUejNNZXIrc3RT?=
 =?utf-8?B?ZWM4UUh4MzJjcHBkZ3JpRk9qbTIzdC84cXkvdk1CMStiYlJ0UVh3V3hkajRU?=
 =?utf-8?B?NWtjTzFZWG91SzcyNndXNDBBYkI5amhxMXpiWWFoMllFa3YxSmprYmI1a0pE?=
 =?utf-8?B?cEdSRUpCamV5MlptVzVrbXM1OXF5ZldCZmwrR1lRdnpCSE8wTERKRGdPenRR?=
 =?utf-8?B?UDJrak5WVWhCeFNBYk5CNTdWbTFXV0RwMzNIVFFGa040YXlKM25zV3hNc1kx?=
 =?utf-8?B?aHcxZE0zSVBRaGxaMElIcVlPZ1ZJeFA4cjV4UEM0NzJtdG95Wk5ibzF5U3Nn?=
 =?utf-8?B?c1RhVHZKQWNrdTdhRVl5UGExZXpyWUtrOXVhaXhqakIzeXRGOW9FQ25POVR0?=
 =?utf-8?B?UmQxd0NXTjZHRHdXbkhuVllURjVLdUpkYTRLaHNXOTArdDhnYnBtdWcyN0Jl?=
 =?utf-8?B?UWhOanJPSHJacFBZTDVDUFUvVklVb1VoYm5JNk9nUzFzVTZFT3M2cU54aG56?=
 =?utf-8?B?UitvWlQ2ZFhKdm5pODVTcjdWSW9kNkJ6UXZvZmJnYkdHdG1LWlhKSjZyN0Ja?=
 =?utf-8?B?aXFoVGppcFIxTXJZV1dTQjBxd2ZCaFUxQUFNS0NKT0xhS2RKVjlSOWhNclFw?=
 =?utf-8?B?UjlGYnRNemRCQ2x6RTJ4dCtBUlRkY01mNkhOc2VtaUtQTVg5Yk5pczFUOTJs?=
 =?utf-8?B?YjhQdGVvR3hoR200N1pDb3lkSGVMSXZjZ0lQYTZuVzZHV2t3cmNqeVlYYmF2?=
 =?utf-8?B?MExuaXUrUnVTakE5WDZuV2RnWmVYWk85bHhRYXA2TE5iU1RQOTB3ZWJiUG5M?=
 =?utf-8?B?WHlrNGlzNTByYUxnbkFqdzBoZ0d2UlI1S1A2QzcxZlMwWDRQZDJyWVF4ZEI1?=
 =?utf-8?B?M1g0d0dxK3pEV0RlTytsSHRXMURDNUlXaFBPL0x0VW5hSzNYM1gvVFpwKzVi?=
 =?utf-8?B?b1htLzVLRTVwWUVwVEFxKzlSSVR2UW5ZQUNUWTBBSVdGL1ovNkxPZG1SazBl?=
 =?utf-8?B?d0Q4UDEvMythSG52TVJSWkdWejA1SmR1bWZpaXJRcHBiYlRDRmJaaFFmQ0wy?=
 =?utf-8?B?SEhkeWxUU1crYWdlcGNwK2g1enlEbWVGcHF5U1VNSWJ3b3l1dFhlN0ErWUhK?=
 =?utf-8?B?ODVYRy9nSDhZcE41Z3phQ2lYTjdSaERma3VmVFJubSt2Vk04cG0rS2lqNzJW?=
 =?utf-8?B?MytiNmpSc3Rud1ZWMzNBRVZIV0pWeTY4YldGd3pUVXZnZk9OUWtxZlhvTzhj?=
 =?utf-8?B?eHpWMDZtUnZjak5NYzhDVzdSZlZ5aitMMjB2QlFtK3NyampoYjVia0tKYU5S?=
 =?utf-8?Q?rhje1SPDw+QXICxEQexIWrjvLwmII+ZGs8nzv1Qr3TkK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55C260DA40589F4190B1796DEF5C13F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b5ef71-6db8-49a7-1486-08dac6bd61c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:56:31.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCDfmtJM+MDyXiTHVeUCIfUppewZAGj1hE8VU45Fz4lDMZyaRKf3JcI+bbYf9FQVOKWl3dfOTD/qrH634CQERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195635_348450_94182924 
X-CRM114-Status: UNSURE (   9.77  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IG52bWVfYXV0aF9nZW5l
cmF0ZV9rZXkgY2FuIGZhaWwsIGRvbid0IGlnbm9yZSBpdCB1cG9uIGluaXRpYWxpemF0aW9uLg0K
PiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpUaGFua3MgZm9y
IGZpeGluZyB0aGlzIGRpZG4ndCBrbm93IHdlIHdlcmUgaWdub3JpbmcgdGhpcw0KYXQgY3RybCBp
bml0IHRpbWUuLi4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

