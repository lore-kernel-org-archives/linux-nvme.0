Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C1CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:59:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9B961501
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A9B961501
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3qhw0PBklGYaxk6+TzNyfUwRGNwaXW6kmQJAooidSk=; b=11q9FdzVKdqnK+dsqFpTkylWbv
	EZl0YvHhaa3RBBdSdvaqLRnlV1rdNYYrocdZR0WUe/flOJuGU9z6+A/n983CsXtWVFJ19IZapZj6O
	cRpDhwTuzNWTmCZT4J7Ct47PXrvggcz2/AaPifOmZAwAd26OiLwyh4TMY3/ghUN50f6wrMTOTtP0s
	zIonXGm+sKOnrx5V4yi2/3tMAbXuG6j96jxYymmouBtuoRQkGyuyqnJJJdGMgNdSD3YxDqWM0eIFj
	DEOw3fMoP9/6JJafZR3PGgPsl4j1ARO4I9+fXedWs2u3oLBnogZVWWVv37hlcLpPLdvDG8wWRLQEo
	ammEBlrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWiC-006idd-OW; Thu, 18 Nov 2021 01:59:40 +0000
Received: from mail-sn1anam02on2071.outbound.protection.outlook.com
 ([40.107.96.71] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWi9-006icl-NB
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmkaKXjI7MnKpCn25d4Trq2r7R55oeJALnThmsTLWM0gHdz/BnuE3f4OX2K+TnlYiKQQfPZy3wsJjyAFgR535rKmjDdg96X8avjcNmu2KKQrn+7YHgTICi2amEYmZrUdXtMcNe+FNzERWEz1fRCW/gCMcBmnfYySJCzxhjWQH6Nqoop6NQv+i2WcbEfEvE/KgbHbr45d8oYKpbBmVxE9gc4oF4S4apQfX7pmJ/r8BJcJVCO3u4c6AnCHWHBstZtj2ft/oxTyXaReV3Vwi4vonne+PScWP0fFPS0E8/69sQn31YetABfwv0rP6suGZr4hBHriAPkplVcOGVGqC8NZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3qhw0PBklGYaxk6+TzNyfUwRGNwaXW6kmQJAooidSk=;
 b=ib//no0UgLEM7ZyoIoYGTQigOLnph2GdflPRcd0D2DeVoWHcFo/xPimMlcJ8vj65vRUFbRZdLuccyyOKQ8FLiSCC3iOu3oNWq7feVfgGoGyoIynCVn8mjUncLrixSEPHYgRg9FmyiUNCWW/v6coeiThrvOSnTEM7Qw+fPZevQjGirUy6IO3sch51XwJwvUA7GcK6ThW3ESyk4lcuNSxWZF+SyFaPm4Ljs+4S5tff4Ql9xxaIryXEjk1e76XOVutKvk/PJVzX6dL2GA1nnEXFmoeDCrKQuLQQt2fYciQ9L5O6trEoTzy4vzrkiajh9sg1h/XTHKRwSFCgiGsgMwQcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3qhw0PBklGYaxk6+TzNyfUwRGNwaXW6kmQJAooidSk=;
 b=BlgNEDoUNlk/0NWeDqY4KYKNFNsBB/X/p9AI6WXjnwLLd7bWBcXci0D/qMSWITuSZ23CbNk070D8yXfOgXz3g3QMlznYshoGPygaDtDRpzukrzTHW6TsHTOpUtkY6iH4H9pW8BjyBdRiX/wHD2+BYXrOG99UnzS2GcUmfvE2pSQQJrYlnFOLOfYa+EXXfX7KQR8kjP1sftxNNm0Whm1Iin8/0I0y1NNmA94aTLHm512rcACLXwfpWX7HNeyRUP3+CuwA2/amDWJTUBEGuV+nxcLnpDO2yNm+9QCoEQ61l/P3N12XleKwptokvd2YemJbTttxSYbH++sX+e4dl/MaWQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:59:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:59:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Topic: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Index: AQHX28dMLa7pEe33C0eG5lxvCwWZk6wIiEmA
Date: Thu, 18 Nov 2021 01:59:29 +0000
Message-ID: <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
References: <20211117152454.122014-1-mlombard@redhat.com>
In-Reply-To: <20211117152454.122014-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc014171-046f-4b6f-ec44-08d9aa370ece
x-ms-traffictypediagnostic: MWHPR12MB1390:
x-microsoft-antispam-prvs: <MWHPR12MB13909304DC7F3D3620B41525A39B9@MWHPR12MB1390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4HLSbrA+PLMPq1J2XaE8OPIJSAVBFzNo7qCi1sDX0w6hm/QywBk3kXNlf5SmakkKI9wHghXrhIOqVCWlz9KQv5T05otjM/C47l12ClmFEX/v1CpHes5tLFCL6TE5Pu/GGE5YJj2OWIccC0oNcQMM3dnZa9+YeY0++TJoHkFzH3aIdr3Ew5fp74c5FHjTycGrOskqqAzEHilsAPMrn5xYctDYUBFCQ9Rh0yighe79ddVTAHA6tUR738Tqx91kW0crhbcE008SmFUvAsn84gahgJkcD0Ig2J3O/RKJRDngvL+lkbPNGLFIFwM5zF/Sa1QD6WXDR46e2Hnbei+xeUqYot0OYV2tl9OCPwXaS5r6MNevL0ngIbsGEBRLdSFhV6KmQSXAOVOSNiHugKAqtD7DPPueM5ns3TYFof4cPhW0VZEZPPwpCHWwni8u9Zpva/di5B9ercL2QbdpswGZQ7m74Hc0JgarLh/wYUqsAZOKofbBXb3Z0CcujCfHZMr6eOZbNVSeT2EpcCGDV4lSab6PPB9E3CGCuifwKJjeNX/TnlNYuV6idrxCW6dFgzr4Ys0VaseqIoVrMkW0kJF9Od4qrERt6ZWyci2fb/Mtq/WFbbCy4hOia8hVSdSj4WXXVL87OoMIdsn/Wf4KdDMzQ7D0g4Ur4i8FSgZjjT8u1WcYPZglOHQhsBToAQiacE9FCTwke06ahPxw8S7VOMVHLNO2pfcda2y61CDQz3M3ZKWxBtEflgc+b0+4Tsq9OxHtv9r52w8xXzEedfBRirLiKT77Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66476007)(66556008)(83380400001)(64756008)(38070700005)(66946007)(91956017)(8936002)(6486002)(8676002)(6512007)(71200400001)(31696002)(86362001)(122000001)(5660300002)(38100700002)(316002)(54906003)(186003)(508600001)(26005)(31686004)(110136005)(53546011)(2906002)(6506007)(2616005)(76116006)(4326008)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1VZQ1BuQXFId1JrZHFVcWhPVkZrQW9TZHZhbzV4Ni9NejZmaGdSM3BjNndO?=
 =?utf-8?B?Z296Rlh0T09ySkxGS01WbnNsK3I0SEQ0OUVKZ3hYWlhwWWNQMmxWRVZ6amZX?=
 =?utf-8?B?T01pem8rQjBjZTZkM3NWSEUvdVpsQTVNaHBJTHc4VFdFNjZ6Mi9xL21HSUU2?=
 =?utf-8?B?MzU4cmJHMUk2M0UzSEk3c0s2VWlLWEdsWXNMRFczY2c1eHZ6QVpEUDdOSklV?=
 =?utf-8?B?TU5RNStYcmlFamEyTXZIUVQvSXNJV29FNENJSCtteitOQnlkb2xnWkJuTzMv?=
 =?utf-8?B?bC9wNU1jY0ZnTm9vNVpFNTc3VFJFMkpCLys3SFFxR0lxVUt0NTV2UEorTm1h?=
 =?utf-8?B?cVhZcDMxdE0yNytGKytYMjR0dzNlS0Vyb1pEakVZN1pIZmxFaEVrNURpTFR2?=
 =?utf-8?B?Z29mcDZneE16bnJsQk94b0dhRWNIQlhNcFlFdU1CcDFBSGlEU3pkWmFNaFJJ?=
 =?utf-8?B?ajJEbkRkRU1KZysvb3hjZ0ZhK3NuazJIM1gvR2VHMjdCd2x6aW1UZm8vY0Nu?=
 =?utf-8?B?SDlCVXVzT1JaUDd3SUZDZlB0cHZjYXZlQVFSSXQ3VFNlT29OWVFxbkVwMnZv?=
 =?utf-8?B?YXlQT0Q2eFJqbkNzMWtqRFQ2MmhieW14TDhNS08xT01HRzlldldTUVl4Vkxi?=
 =?utf-8?B?UGFZQm9tRTl2UnB2c3hEVy9na1JjNlV3OCtoQXdlcGtsWDJBWnUxLzNERks0?=
 =?utf-8?B?VksyQkdJU2ttc2k0YTRoT2dyRnNsRWgwZWNBS3doMzFMcUhCY21DeGZUdHRW?=
 =?utf-8?B?VVU4OHZpZkZ4Q0FqbThqQWMySzd2MDI4K2x6UTBhYXB5bU5VTm4xYTB3My9y?=
 =?utf-8?B?cHNnWlBENm85Rk1CS2Vnd242cHp1NXB4SHZXbER1a1FlOU9xdys4Z3RlRFVo?=
 =?utf-8?B?L1V3NFF0a3dJalBFMmppV3dDd2RXSXZvTmJJRjEvVnFya1dYem9ieGJMSzhG?=
 =?utf-8?B?ejBBelhLUnNBaUFYQVlTcC81WUdxNTlvb2gzL09lMjc4ei9WNEdPd3N2RjJN?=
 =?utf-8?B?dVN5TUFMYzg0QzZQTXVHeHc5dHdaTm1RMWVFdUdsRGIvcVgrOFN5T2thNXRK?=
 =?utf-8?B?azJZY0MyMDNydmRQSGZzaEp3MFNubzVqbWxPaXJTODVBdEdsa0ttdFQzVlhI?=
 =?utf-8?B?eGhDUW5oMnJvb0E2S1ZxbEZxdXZzTXdjS0FxdnlWOHBRZysxQUVvSnNtR0Rj?=
 =?utf-8?B?cXZvMDVQdkVtSW5DVE1BQXVCd05Gd1R3ZFhKZjJTZ1I3elBFL1NJNVV2OXR1?=
 =?utf-8?B?dzhUcmE0UE82NnVWYTlUdTlPenBNaXNEVHo4Njl3LzB0WFVPaEhraW0relJM?=
 =?utf-8?B?NWw0ckZaZE1zQ2lGU3pQRVU1d1JNaVM5RG5qV01VS3JONlNsVEY5ZUNTNHQ1?=
 =?utf-8?B?N0M4eHd4WkQrZXR3S0NVRlBDSVlhUVFJUzBFMWN4U3BXZUhUWGdyZVRLak1N?=
 =?utf-8?B?WUswdEJvalFUTmJhUGJqcHM0emFNTUZLR2tTQ0h5bWM2ZTJQZG83TThsZHda?=
 =?utf-8?B?YU5rSXdaMisxR0Q5SnpNVmRnQXVNdVFEcXlZWVZ0VDFaT2d6S0pWY2dRY1lB?=
 =?utf-8?B?NlMxYy9FNmJVUDJMaXhMN0N6M0toT2M0aFQvZWF6bHhtODh6UlpuNXVoR0pQ?=
 =?utf-8?B?Mlc2dDlDZkJxMVFPT0VwaGxMME0yUk9oU0c2b2hjTlBwZEFYdFgzeXFhR2pP?=
 =?utf-8?B?WmZuNHovajZ3dmpTV01CTU55WXJ3R0lja21BSXJWNk1PSlA2c0tKUEZZQ1BP?=
 =?utf-8?B?RDd6VUhSeFNodWFrKzZ2U1ZyQjdub0VpQTNOcXJORVkrOTQ4V3VQc0trUi9h?=
 =?utf-8?B?b0FDcEYydjFEWlR3bzFHcEdEamVDN1hMUk9QNGZKUFBMR3JCMGhRd2hwTWdt?=
 =?utf-8?B?L0Y4Zm54WFRnUWxhaXU5RU9LTktIS0xrVStzUmVVT3owaGVIU2hUZ0dydE5k?=
 =?utf-8?B?c09tdVJoc0NKU1c5bmU3UEp4bld1OVVUWm0yUEh5bzZqMXRZam1hTFh5T2g5?=
 =?utf-8?B?UmhEYVpaaGNSUWtOZzBCV2Z5S0tCQzlCNjNaWFVOdUpZS21nZHpQTzdoSUQy?=
 =?utf-8?B?NDRXQmdFRUJqblIvc3VFNGg1bTBjRVZSQ1E3TWQyMHJ2ZThtSWVRUHF6c0hm?=
 =?utf-8?B?NHZtZjhCSFhlYldERG9mQmlncDlsUm9vdkRackR5MTBjb1EyLzBPK0ZtblA5?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3130D280B905E47BA769F1569569873@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc014171-046f-4b6f-ec44-08d9aa370ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:59:29.6231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWMdRS5vlSZMvBOKK4LZirlH3Za9qcqbKFWWMMm3GMTu5osh0YnizLmLkiO88+SefweVkyiB2j32irwTVVgK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_175937_793254_325E0074 
X-CRM114-Status: GOOD (  21.07  )
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

T24gMTEvMTcvMjEgMDc6MjQsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IGNvbW1pdCA1MGE5MDlkYjM2ZjIgKCJudm1ldDogdXNlIElPQ0JfTk9XQUlUIGZvciBmaWxlLW5z
IGJ1ZmZlcmVkIEkvTyIpDQo+IG9wdGltaXplZCB0aGUgcmVhZCBjb21tYW5kIGJlaGF2aW91ciAg
d2hlbiBidWZmZXJlZCBmaWxlLW5zDQoNCnMvYmVoYXZpb3VyL2JlaGF2aW9yDQoNCj4gY29uZmln
dXJhdGlvbnMgYXJlIHVzZWQuDQo+IEl0IGlzc3VlcyB0aGUgcmVhZCBjb21tYW5kcyB3aXRoIHRo
ZSBJT0NCX05PV0FJVCBmbGFnIHNldCB0byB0cnkNCj4gdG8gYWNjZXNzIHRoZSBkYXRhIGZyb20g
dGhlIGNhY2hlLg0KPiANCj4gSG93ZXZlciwgdGhlIHBhdGNoIHdhcyBidWdneSBiZWNhdXNlIGJv
dGggcmVhZCBhbmQgd3JpdGUgY29tbWFuZHMgYXJlDQo+IGlzc3VlZCB3aXRoIElPQ0JfTk9XQUlU
LCB0aGlzIGJyb2tlIHRtcGZzLWJhc2VkIGJhY2tzdG9yZXMgYmVjYXVzZSB0bXBmcw0KPiBkb2Vz
bid0IGFjY2VwdCB3cml0ZSBjb21tYW5kcyB3aXRoIElPQ0JfTk9XQUlULg0KPiANCj4gRml4IHRo
aXMgYnVnIGJ5IHJlc3RyaWN0aW5nIElPQ0JfTk9XQUlUIHRvIHJlYWQgY29tbWFuZHMgb25seS4N
Cj4gDQo+IEZpeGVzOiA1MGE5MDlkYjM2ZjIgKCJudm1ldDogdXNlIElPQ0JfTk9XQUlUIGZvciBm
aWxlLW5zIGJ1ZmZlcmVkIEkvTyIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVyaXppbyBMb21i
YXJkaSA8bWxvbWJhcmRAcmVkaGF0LmNvbT4NCg0KV2Ugd2lsbCBuZWVkIGJsa3Rlc3RzIGZvciB0
aGlzLg0KDQpBbHNvLCBjYW4geW91IHNoYXJlIHBlcmZvcm1hbmNlIG51bWJlcnMgd2l0aCB0aGlz
IHBhdGNoIGFuZA0KdGhlIGVycm9ycyB0aGF0IHlvdSBhcmUgZ2V0dGluZyB3aXRob3V0IHRoaXMg
cGF0Y2ggPw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWZpbGUuYyB8
IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWZpbGUuYyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvaW8tY21kLWZpbGUuYw0KPiBpbmRleCA2YWEzMGYzMGI1NzIuLjFkOWI0MTE5MDU4MyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtZmlsZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWZpbGUuYw0KPiBAQCAtMjY2LDYgKzI2Niw3IEBAIHN0
YXRpYyB2b2lkIG52bWV0X2ZpbGVfZXhlY3V0ZV9ydyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+
IA0KPiAgICAgICAgICBpZiAocmVxLT5ucy0+YnVmZmVyZWRfaW8pIHsNCj4gICAgICAgICAgICAg
ICAgICBpZiAobGlrZWx5KCFyZXEtPmYubXBvb2xfYWxsb2MpICYmDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVxLT5jbWQtPnJ3Lm9wY29kZSA9PSBudm1lX2NtZF9yZWFkICYm
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52bWV0X2ZpbGVfZXhlY3V0ZV9p
byhyZXEsIElPQ0JfTk9XQUlUKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gICAgICAgICAgICAgICAgICBudm1ldF9maWxlX3N1Ym1pdF9idWZmZXJlZF9pbyhyZXEpOw0K
PiAtLQ0KPiAyLjI3LjANCj4gDQo=

