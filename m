Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A19DC47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqWOlDW7KxnqAwttRJ+mB9VemBBCNONXEBacnPmvwbE=; b=XAoPBaSmYtwTtDUFakOkG0Z125
	vsIhaDIil+F/OpTLh+YlR48XcOGYETKdMcgaEN9YzVdUwDXP91kvi4u/FAjFbrYGM+te2IRVVPtGF
	SNh4kEWih68wtaq9I6Hm2M7/35osi2bxh9fnGpd1uto1DS0rSCnuctye3aT1guYIYnMH4HpX9gdww
	sppOFu5Xl3hgZCLz0xgxGUTOwIxBz8pkbl8AWC+hKWVpAGoG+d5NUX3nWo0PeIPfrqH1IKtI3sQPa
	3uAyx6uMEsJSc2vD+Su660WBAiLm7zd0MsGhzyK2ba/uT37h994IBIINoxKc8zC9qdzRHGtUiWQ87
	qOAX/FGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWnJ-00FPll-1t;
	Thu, 04 Jan 2024 23:06:33 +0000
Received: from mail-mw2nam12on2062f.outbound.protection.outlook.com ([2a01:111:f400:fe5a::62f] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWnG-00FPlE-1S
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 23:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEC60DMgKEw+SGc+oHd4HlRdppAaRnV6c7Aw8JIZ3Zd3+S5k3otGVjksnXJSlcczMCEEYMNihH52HjIzop3AInqFA0PuchmEo6oHDWbsTdTmfac73VtA75YS+K/tEeaYw8vjmD5Kb4BMzKGZoRLqn4GApewIVfYrhj4iQXwseQcT3ie2UgY+Bv83CcCHADzYHpOXVbMzol4kl9Rrx50+RHUDsWRhCChASOwHzeE55jM+25sraj0tdKEp8TMToS8ezdGCRUYR8kgEBNjh3W5QpogFRxu0+nwn9PYXKdVDRGIPI3GHWZ5o+QJfHT54oPqdSC40+t8xN8fCQVsu1k+eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqWOlDW7KxnqAwttRJ+mB9VemBBCNONXEBacnPmvwbE=;
 b=H9Rkg9tvtwfLwVH2M7iG1WPMZrZ+Ja6F08jqMNF7evtLXiKwE+uKt0zn6fig/4Rwl2yWuc41L3OUQsVfZoEUaBrs+Y4eB6hkq3ZLvF20ryVIUCB/F1ZMMXQzmWR4jXQAq4zcfUEi4VnDBGEiFTjfQmQ6toL4j4rOVD3J4J8IplKWfxsw+CSr4pwaYIN2g1LLUejJaj3W5jaPfbznUAaKp6epb5qRa4oR9Q+CPjlkSHUM/L33GXzoZ10F9vlU4HuvP/JoQa4PAnNtWJEpbSz/syH6F2SRsX3RR/XzabEmgYGOrB4sbt7cd18zifpB3yWENkqUIOquuWQyh64Fv3S69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqWOlDW7KxnqAwttRJ+mB9VemBBCNONXEBacnPmvwbE=;
 b=rbAFwMiIXAYReMD5cibf0IWGnqdkLL2Vy/53TbiRWAQm0m0lTXHzcuVLp6POT34e7PKYZL6XW//dakHj+rxCGezHayGJQjKM+huZrpj8SUTOStn1PHb4yzYpIedpbl7017Rg2jda5axj7Alnsre5gCW0YIbKhg6xMKJW2BtZkFXdhGSzUXpIrkmFSj0iaDVWLWpRk9w0u/SThfxut+PdKhdyzmMmYFPKyLsZsayz7XIsYrHh8UBOaJyxyvK4xYmQxvHe0xy/Ua2ka6Nknq6uOzRK9Z2M8sHUACd+1PhvzVOlE01Z5IN36QXc3D724PlaYwQu429+YyriVQ3McRMGzA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 23:06:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 23:06:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Topic: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Index: AQHaPyygJ0tk7b1GZk6+BJOtRok3pLDKRu6A
Date: Thu, 4 Jan 2024 23:06:22 +0000
Message-ID: <06144d0d-f20d-45a5-a7f9-e3a07e6f906a@nvidia.com>
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8966:EE_
x-ms-office365-filtering-correlation-id: 00be476c-f0c9-45a9-e21f-08dc0d79c507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePfqTNBU4FiPK6Z949qoeh6IdzVraFHXfcO1OrEssSBX4uWijRHjxbahD6L2ZXXTig7A1dfVRmXuYkJH/kq/tVe0dLMLwCHZ7kq40/2nBNYkV1qyrjZUATC4+JrzpED6QocbmmoCsQuxbrKnitTj4lX8tLI8brzjNpYr2MthwzbPuQW2oDpqlKv3ZIupd3uuLf2BEOH+Nd7SMjQ2U23FmC6oRncxShuNdSe60s+4++wKlKXf4GutHJ5UTvDC0k6CCAE1cqSOAaLaSas/IpsC3zWAiECwUpRbBzMPgFjBIE0BSTNXgzWopD6VmOMLl5RVM4X9aPhpjFWg4nbI6gQ5Z9MT5X07V5nzTDxOx2XRPpSkHGi4rHcEOy0HPpATb3j/PRMDl684KOyXSdsNb7lLqtfuuU8Ys80TqAh2WTHI9zE+1q/aFI1T6Ud1IZwu/7p9TeuDbxfmRcjB+mO81ZFTsymHEWTHxCUXAuue0oIP/dqul4ZuQu3bDuqVrSqJAOLYxsgL8IRRnZO2fxM3ellJ0jBlSP/JE/XTGjdsZEjQYczyK6J0XLYdPzIH4Bq/3w4PTj2uDjI0Qgr0SB9Eehq1J5fkMeaXji6cLAddV1dGh/W6jF/MZ0u8A8LtbO3hvxGWy1pvdjS0eHoZknxGlP7s/1PHNCcAH5Q4ONQ9ZuM631lHBxAKY/wu4pz8whibBzdx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(66556008)(66476007)(66946007)(66446008)(76116006)(64756008)(91956017)(6916009)(38070700009)(31686004)(86362001)(31696002)(38100700002)(122000001)(6486002)(83380400001)(53546011)(6512007)(6506007)(4326008)(316002)(2616005)(54906003)(8676002)(8936002)(5660300002)(2906002)(4744005)(478600001)(71200400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cndKSkdEY0g1Y1BzUDdiRXRwTjRCQURoZUh1MnBhanJKL3ZuVGRqc0U5SGJp?=
 =?utf-8?B?UGFJYzJpQjZEV3luSDUySUpYSkNRb0VuNG9uNGlLemJqOW04ZkFyQnR2dDli?=
 =?utf-8?B?cGlrZU4zcW9GZEc2c1hwVGY3dHkwdTBkWUxybVQ1TVJNczNLSldIM1RRZ0pK?=
 =?utf-8?B?UU1WTFNNMmMra0pkMlVhcjhlY1NrSE5OVnRxMGJsSFBMeEZRejFwLzlYY0xW?=
 =?utf-8?B?dFRCZ1BLamRCbUxPRE00VldCdmozUHhSS2dZMTNHcmgvNDNDUjhyaTFCOThV?=
 =?utf-8?B?YWpYVmtBZmlGdFhiclRjZXE4dmxudHpmbnRZODJWWHh5d3k3UHRiQjN3RlAv?=
 =?utf-8?B?d2xJOHVKUTFDSmRIeEFjSlJ0eVFXN0phcm5jdkIzR0s5dGhBTU0zbm1lYnBa?=
 =?utf-8?B?QWFPMEF1TW9mcmNzOFc1Kzc0NURnRGc3OG1SaVpQL2RHM0FPMUQ4WjBoMVcr?=
 =?utf-8?B?WHRxcDJSQU5YWnczTVNoMUppV0k0ek4yNUdyRGxLZDlVVVlLWFp5eXIrclFt?=
 =?utf-8?B?RmtlTHl4S1prdlpmMlhjVjNpSEwwM2UrRi8vMFpvQTYxcmoyWW5Qa3pzdy83?=
 =?utf-8?B?YUozNldkMXBUV1dCSGROTTZnMStycVdhem5vWGM1QXNvTGE4UWtBQzU0UlBO?=
 =?utf-8?B?dWpJcUFPbm5XK1V2QlVwRXorSjJnY040SlFGNjBiTWFXYjhYZ05mQVJEZnhI?=
 =?utf-8?B?VXJ0UUI3bkZudTNwU20vbU1xYVk5dFpOYnRYakU0bkFCenphZHQ1azE4Vk5l?=
 =?utf-8?B?d3hISW9rc3ZGN0dySzJyNklHYjdvakg4SnZoZjRROVJ0bVJKR2JoSkNLUEF0?=
 =?utf-8?B?ZWhsMnhNdG4rRnBERU93Ukg5OGJMVlk0ZitCejlqWEdYRDdaSHovd1lyZW1J?=
 =?utf-8?B?MURRTUtzcEtiKzlvclBQL0VadjhmV0JjV0xHWnVhb0l2dy9FT2lwcEh6MlpO?=
 =?utf-8?B?c1FUVS85eHhodWh4VnZCc2YrL0FhekZzTkJUeDVCSTc1RFNjckNXY1gwVlRF?=
 =?utf-8?B?aDY1MkRJK1I1MU0xaWdRM1A1R1dyT2l2bktZdy9oSCtpS3dsQm9WWHk0azU0?=
 =?utf-8?B?Z0RrV0w0Qk5tazd6aEhPTEEwVzhWRzh5RlRybEIwVW5CVzV2bHlNencvNHBk?=
 =?utf-8?B?MGp0aUFvNXJJbW9Td0RiQzJOMWtldHdEY1ZadGNEaUFMU05Wc0o1a1c0cGR3?=
 =?utf-8?B?alJyQmxwUTRBelM3WDdRa0VBSlFzNThoN2lidFliMDhRRm0yNEZjdVE3NWlm?=
 =?utf-8?B?ZURKVGRvVWhVanZLbGEzVHNxVlhSbk9PTTNsTGZrNHlWNXl5M0NBRy9adzVr?=
 =?utf-8?B?aDNiZVd0Rnd6ZHU0SGFkZWVYbnliQnRxQWRUUVpqakdBdnpTWUNSK1dCa3NZ?=
 =?utf-8?B?dFFqRHozN003b01zdXlrUHRmbExhYnU3d09TRmRFMWtxYk1tV2xaby9EQS9u?=
 =?utf-8?B?UlpHd2FpdjIrL1RTZkVKSEkrNTVuKzVwZjNSRkpNb0NJWEk0RVZkVnF3QUFE?=
 =?utf-8?B?eUJyYis2K1NGbTFEYnUwMEZ5OHB3TER1Qmw1a2UyVVc4TExoQlZIa3ZWRDEz?=
 =?utf-8?B?aVVsbUFrd3k4dEZEK3ZqL1hpUmg4NDdnaUlybzQraWQyMkIzNHB3UCtaRk01?=
 =?utf-8?B?TllORm9UUng3eWxyMjhBU0wrbjNoaGlHWDNFMTMveEkwZXpHOEZObUo5WGpJ?=
 =?utf-8?B?Z3NvWEdWMDR0WHNlSXFBY2FnTjNhMHZpaUtyR2J4eEtXaS9aN01YZ1lBdUZW?=
 =?utf-8?B?S2ZhL3hEWnc3WnhnTTFyRnlWWHRmdGI4ZnMva295SUlJQnhmVnh4Z0VuR255?=
 =?utf-8?B?VHVEdUJDQnlwakk2QUN6SU1GU2pZdFpkUkdQRkFlb0pNR0N5eFBjZkFLeUty?=
 =?utf-8?B?cktna3YzZnFTN0YvY05ZTGdhM2YvRnFoN3JxUHBOMi9iQVVlY3FTRitjby8x?=
 =?utf-8?B?NDdjWTlCL3BzTWFacWN1N3JYUGN3b283YmJRWTBablJDSWFXNUpVL3M4RnRI?=
 =?utf-8?B?MXlGa2dSLzJ1NVNKSUtJT0RwdDNLMVRYUlRiN3BaSmltUnBFSUpVYnpNNlkz?=
 =?utf-8?B?YUlvY2RMb1RxQm41cmZ4SjJubVBxUnV3VGhlanBhMkFDbHFWSW56WXdUejdt?=
 =?utf-8?B?WkhVN1dkT0NiQVQrS2szZnBBRlNqSkFRQjRrWkVoeEM0R0NNL3pCUkxCcThG?=
 =?utf-8?Q?Xx2v0FUpgNvHnxamg0LHXx0DudwsYElIoXi6ubgW5VwI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D92C339DB7B64A984889404A9FCA1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00be476c-f0c9-45a9-e21f-08dc0d79c507
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 23:06:22.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdOIGiDRFWrU8LDjYTk+AO/22bvHJr5dPgtTPSMS5sOL+8HFOpyPAKIp5g0/9x9wNqS1UmdJFx7Y5f3i7q9N7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_150630_518373_5744244D 
X-CRM114-Status: GOOD (  11.75  )
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

T24gMS80LzIwMjQgODozOCBBTSwgU3R1YXJ0IEhheWVzIHdyb3RlOg0KPiBDdXJyZW50bHkgTlZN
RSBuYW1lc3BhY2VzIGFyZSBzY2FubmVkIHNlcmlhbGx5LCBzbyBpdCBjYW4gdGFrZSBhIGxvbmcg
dGltZQ0KPiBmb3IgYWxsIG9mIGEgY29udHJvbGxlcidzIG5hbWVzcGFjZXMgdG8gYmVjb21lIGF2
YWlsYWJsZSwgZXNwZWNpYWxseSB3aXRoIGENCj4gc2xvd2VyIChmYWJyaWNzKSBpbnRlcmZhY2Ug
d2l0aCBsYXJnZSBudW1iZXIgKH4xMDAwKSBvZiBuYW1lc3BhY2VzLg0KPiANCj4gVXNlIGFzeW5j
IGZ1bmN0aW9uIGNhbGxzIHRvIG1ha2UgbmFtZXNwYWNlIHNjYW5uaW5nIGhhcHBlbiBpbiBwYXJh
bGxlbCwNCj4gYW5kIGFkZCBhIChib29sZWFuKSBtb2R1bGUgcGFyYW1ldGVyICJhc3luY19uc19z
Y2FuIiB0byBlbmFibGUgdGhpcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0dWFydCBIYXllcyA8
c3R1YXJ0LncuaGF5ZXNAZ21haWwuY29tPg0KPiANCg0KcGxlYXNlIHVwZGF0ZSBjb21taXQgbG9n
IHdpdGggZGV0YWlsZWQgc2V0dXAgaW5mb3JtYXRpb24gYW5kDQolIHRpbWUgc2F2ZWQgdG8gbWFr
ZSBldmVyeW9uZSBlbHNlIHJldmlldyBpdCBxdWlja2x5IC4uLg0KDQotY2sNCg0KDQo=

