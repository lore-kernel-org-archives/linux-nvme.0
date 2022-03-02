Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Mar 2022 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOXdGdJfiBu/QLbSmaVQJ1/t70hj/hYTMudeTxc5uOA=; b=eImY6b+dYeu6w1REBtQiqXn+6C
	XSJ5wXNJ+U9OLjG2Z0kftKpRVQnMMI17FxZUTH1quZIqXas3niHaU0mXdQznz5hSzn/25isTZ+YS9
	Q3eWCgDY9qt1OWeyACvHPMGJIcWlFAOMSk/1XooMIO9D1kkhysL6UftIT1GAuchO1w1pXfb6W4+SB
	HOcu+kRlocEe6cG2v7abAzoPsWDEiXcmpJ2Y/jNqTN1bzjO0nrVkROWNALTTw1ziC9X+8g9qWn9dV
	KqOOzERlHE6J3ZB9+bNhPYRToiUGr9u125s8FeQ/Bvs+XstbslIYZE/iMygyFNNgfogGDbm+uhbpw
	Q8I4T2CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPE8O-0011KG-MH; Wed, 02 Mar 2022 01:50:32 +0000
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPE8L-0011JX-OU
 for linux-nvme@lists.infradead.org; Wed, 02 Mar 2022 01:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTNpaikp3skiVWZl9q44aqrucvBTKot50D38KPm8jp7v+AU3Pyi0knz2ns50OBvcKZ1u4Lei3qAjoNRLdmdtwhyhPhrTsIedIfTQhci5vvXYb5SXtlGSlIPKKk/MlDBaeBUH4WdzlkI8oV9e9dCkCQVjsFrZFn9kef0Pdl9AqlrF+RZDxIbZNlMUzUIHyU8YKHuwDgViRChotZ3kz1torlC1czQbTwW2Xc6In/KaXDO1WvzcIZneiDuSjCrzRhtsXjspvFqYqkhb3DBMU/Yt3v7N8nP/1aTINw8+cjwPeWeZLV/Iw16BaNFVpWPjjjZYmcrrwsHlAE0nWjf9z3OOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOXdGdJfiBu/QLbSmaVQJ1/t70hj/hYTMudeTxc5uOA=;
 b=WrH2YKmm5iiW30KyGzlErNQgFLmeXdRAOlAkCflpzZoWr6yQvsoDdrSvIlmn3DjJ6GLTx27ETAYForwzuldbyDuFRib+KzeENFYbvI67LWmqX4HT16jHrT7qnWrOfWS+z+FecajTLXF39hf4ev7bXuP6sXQlyjUiPjyGzggHzwlh9I2KERliuOMDazcaiDJpjMLZX19whLyxoXZWDUxdnRTvOys1yni+FBzyCNs6P440iKoT5DhMWSz+da1Z5nr414eNE7q5P4c85Uozt+b8H55eBq77ca+s8vemYrvxXV4xLCjwODoNEKPw0lUE0Fx/83kENc5YtiI2TXjaKAgk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOXdGdJfiBu/QLbSmaVQJ1/t70hj/hYTMudeTxc5uOA=;
 b=tY/rsTOuCvWWYxw3nZJc4im9gez31VJza803H1d5mMIXrsKX+0f/oLiKf1OSPREKxjWOCTFfHjrt3mrZOtv4AiTh5FpqiuY0U/+LxW6kTb9iNy/yQewXzXiEf5BF/WuoWVLKT+pw2mqRI06rHgWtzqtOKW5/ho9ckWt4q0pGUJW1n8mimwz6sFLl2VtkfZOQVTfbkEQUQ/mtkNa5ZRVjvseNDagKyUzazx4GMfXKjtRdXRrvQBxvs2lj8sbCDARztcJHPwmhs7rK9Keg1lxksAYb6/6UUcsihshiLapyY1PJB++ukqmBCIQRXNlCWKjuEugYrHOwH1DGfxxZUUUVdA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 01:50:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 01:50:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Varun Prakash <varun@chelsio.com>, Sagi Grimberg <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "Ran.Anner@dell.com" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Thread-Topic: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Thread-Index: AQHYD7GDYbUeMbY+K0iuCJGuEHEccqxwVFoAgAJaLACAKecbAIAOygeAgAAwt4A=
Date: Wed, 2 Mar 2022 01:50:23 +0000
Message-ID: <71c572bf-e391-fb34-2604-e7cedd55bf98@nvidia.com>
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
 <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
 <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
 <20220301225601.GA2366101@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220301225601.GA2366101@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a3415d2-a5b6-4340-3e46-08d9fbef0448
x-ms-traffictypediagnostic: MWHPR12MB1214:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1214529DEDF4DA832CF21080A3039@MWHPR12MB1214.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48dvOXqF2FPOKUgkaKmjtNV1OWFF6hDxBoY9R6deAi/yOhT8CR0cyBy4GaX5Ul0RlX817A01aFkV+Imk8LI+RrO7IoknNyvTeHedUv1EKGuSwNgJXg7FdbqCzg61jmajMm6V0dOs4hquQ2oV+4o4NLdJLcBv8qIVrbqkt+ydINTF5fiUkDCRYoQF9T3BsNEMOKgSVAGKzunvac/dlrmCpV+nbyzXAqc7qCfSqf0D6/x0iwnysU9gTiLeWmLLINp94sDZvNUq0NfA98gQUoA+9HSQ6hxW4I/CCTTe67tqYVQ8DstKebMHJeUwS99qcbEkf0uSRzyxXtEVEjx4qwy+/ex3GezQyvS+pHk+llkM72HqV+y5uwZFKmlwRWJ65fPuvvXcE2CKqlncx5ITEPzIBpzE6d8JK7PpiPG27KZva32GXQnyadzIoE1NKWixishELgYUj6xXKCSZ3FowXZm0KYtS7nngeuBWl71xbFtJIa1tCZAF2uG8v1ytKqaCJMbUzUDVSL+qshZZtuM3iLL3sKWCCM1mK3b5aIIUulCcEx3T99FPJD4eapom9DqqNvH3x535tBU7b2Pu2s5ptXZ/37wHvLN4GcH8ggUUjiI3B290zk+mkcZFb7crtLiOMk1obTOFNQTm64kiFd1/+r6bV0PoAslMB9P6LCjJfNimNWTzY/ptxAn8tnRneF+HQmx95r50T5jQW9JlUQyderFO5Z8KP4iDke1/CPBC8DhfF8Kw7pfOAQzZSNIS/gwW2iDZpx8JWQ5Sfwm3gxiG06zWLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(91956017)(508600001)(6486002)(54906003)(6916009)(66556008)(66446008)(64756008)(8676002)(4326008)(66946007)(71200400001)(31686004)(6506007)(76116006)(66476007)(31696002)(316002)(53546011)(38070700005)(8936002)(36756003)(6512007)(83380400001)(122000001)(4744005)(38100700002)(5660300002)(2906002)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEI0NW5uYnB6ZDdwUzJOZFozV0pZbHBQQnNKaklUYkxHdllCSjdMOWdSZW9C?=
 =?utf-8?B?bzNLS09BenZZV1BvMlV3Y2Fvb29reGpveXpFTGIzWWJPQTRNTWl5UlJqM1Rx?=
 =?utf-8?B?Q3ZpMEI0ajhPV3Y3UW9qZkJwUEpOUGJ0NmxyZWU5RlF1UTRSTGpTeWhlaWJL?=
 =?utf-8?B?U0ZuMFU1OGxDalhvWElYOUQyZ29MUGRGT1lXYVNYRTN3UDdtS2FwOEdORXMz?=
 =?utf-8?B?bW5SR3lXbm1Fd3NWaXYwL29SbStORUlKTXRtV2FrRFF1UEkvVTRXdzJzZmJC?=
 =?utf-8?B?WDRKOUhyaUd4c0VPN1ZUNjYvbGVBYlc5ZHIrQ2VlMDB3dFBGdUxCU2o5dmJM?=
 =?utf-8?B?aWVVT0VHNGUzdDU5YzlYMVVibVRjcTdpRXdDYXprM0xjL3kzWkE2TlRvNE54?=
 =?utf-8?B?bncrU0JUMmszbjlXbEpRcmh2Z2JaSUhxczdndCsvSFltc285cUVrTEUyelFj?=
 =?utf-8?B?b3VWQzlaWm42UThuelhZcVlMVzVJaTN6YUUzbmhBdkdFZTZMNGRDcnRFczlz?=
 =?utf-8?B?Q3NlRng2MDcxVzRTcjdJOU5wMCt5ZE4yQnExOE1sRFA1SHliQlhzMjNUUkFy?=
 =?utf-8?B?SmoxLzlnQUtSQ3JaYVBPTEtlbXg1NFpyVmVNUjVvcjBCZDZFd1IyYjdwVmFa?=
 =?utf-8?B?U2hzTU9uK1dmMDE1ZEtWTVJnUTk2Ri9vNEtzRVBldkpJUnVRVEJ2L3hnYW1t?=
 =?utf-8?B?RHZ0YXVSNG15UEtmbHp6NVBFQzB5NEttVzU2TEVxSGVoNlBzeDVwTGRTeDJE?=
 =?utf-8?B?V1F2STA3eUVnbWNDZTU2Qk1Rc1prL0k1NWk2V01XUW5vRzdQd1lPc0ZiVkIz?=
 =?utf-8?B?YXF5R05wbVAreW1ESHFaRXdxWEhVOHNDQlFEM3dXNXluOVQ1M09oUWx0dHN5?=
 =?utf-8?B?cmZpZGlMTGYrejFaQ1VScnpNbWVsNjVkUmphRXBuR2QwMEtJdVBxeHpMdHIz?=
 =?utf-8?B?cW9ISHdnWlNoRXlHNHNzTUcyL1dERUw2bWJTYVA4N1FieW03eFFWb01LWE91?=
 =?utf-8?B?UEM2QnlEQWhETW5KM0JRbm95eVlpMU9jREprUStlOS9NVHZvcU5kOVhtZ3hH?=
 =?utf-8?B?VFVBbU00cFdqTmNHMzlXZzJEZ0JFYUdBTDMzZVVBV2VlY21kek10V09LcnJy?=
 =?utf-8?B?RlVSVFlOaFgxZkt6YjVSZk5aVmcxYWJPUFppbVFYeFozbE5lTXdraHJwc2FO?=
 =?utf-8?B?dXM4WVdqRUlaYTRRa0FyWFM1V0FzWWJRNHRsWU9TNjhpcGxNcHhhZS9LWU9F?=
 =?utf-8?B?QThVRDRZTmxzN28wNE1TN3Q1NWpCQzFNV3BEWTdZNGVIeHRJbnl0Z2Y1b2hX?=
 =?utf-8?B?ZGxCMFk2VWw5TXcrR09McEtZMStlL0dpYnRlbVl2Nytod0UvM2xRMUJsTEp6?=
 =?utf-8?B?RVB6UXROU0lNd0NsV2lZYVBvUmpMb3FGendxUUNlU29SWnAzUFdSbkJQanNj?=
 =?utf-8?B?cDFxa2hlUE5XY1BqVDJyL0JFKzRBZCszZFVwbVUrNFZHUGk2ajA3ZVZKaEl1?=
 =?utf-8?B?RW9hRVFLYkhKQzFPdjFzMzdtR1JibmNBd0lJYlVSV1RWRFZKS25kTHZBa2tK?=
 =?utf-8?B?c1oyQlJTallXUVFwN0ZjcERRTnNTdU1ZQWlRSFBFcXk0WnFFblgzVkdaTjdJ?=
 =?utf-8?B?aXc2c1VwY1UyMlZVc2pXblZaMWxFUzVFaFl0NDBnM2ZrdE1TUUdSSkFuQmJW?=
 =?utf-8?B?MnJIWjlCRzJXQmlRdmEvb3pyQjRUWC8yTFJidExnTlVuQmdYYU9zbjZVS2xP?=
 =?utf-8?B?TmNtcFZHcnBvUVY1WEFRMTd4WjBSL05ZNHBDWm11T2xJMm8vQlJVR1Jta09V?=
 =?utf-8?B?VWNCZUY0RUNMTjVOSTNWN2gxSjVrMUpPaFd1WElPeHdRQWo1bUhESENZek5L?=
 =?utf-8?B?bVBPeTBlTmZQUHJ4Q2c1ZVB5YkZLVlRua1RML2tWRGZQaWQ1d25kemVaazRI?=
 =?utf-8?B?L0NBTTI5d2x3aVFxWjFVOGxRa0U1MENVNHBQMVZJd2ZRS1Fud3U2OGwwNVZE?=
 =?utf-8?B?TDNOVWhDTWZoZjRzZjZ4RmlLenNEdnpkUmVyUDltQ2pNSk1JazUzODJuTTVK?=
 =?utf-8?B?UlJ2QXhqSzIydUhtMmtpS2ltaVh1YTFxQjNZcGw1c0UrVzVhK0ZSbnByZ0hN?=
 =?utf-8?B?dHlEaC9TVm9jMWt4SVN5d0FTY3BGckdXeUkySkFXNmhndTF1OVdDTEFJRUxs?=
 =?utf-8?Q?t0ttAuxZ4VyB8WXXRF5Fc6wachC5wq38r0SqBsCBNo3n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <874822AF6CF1DB4E823627E87D098A57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3415d2-a5b6-4340-3e46-08d9fbef0448
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 01:50:23.6141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNdSJE3KNH+g6cB9+QyzoV6jvJefN7ZO5Dw07P2L6Z2WFBC6aik9bXn6C00XZU0Ty7I1lzw7UtcQFwQrnlRU7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220301_175029_820720_10C9432F 
X-CRM114-Status: GOOD (  14.87  )
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

S2VpdGgsDQoNCk9uIDMvMS8yMiAyOjU2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gU3Vu
LCBGZWIgMjAsIDIwMjIgYXQgMDM6MDU6MThQTSArMDIwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToN
Cj4+DQo+Pj4+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0K
Pj4+DQo+Pj4gTGV0J3Mgd2FpdCB3aXRoIHRoaXMgZm9yIGEgbW9tZW50Li4NCj4+Pg0KPj4+IEtl
aXRoLA0KPj4+IElzIGl0IHBvc3NpYmxlIHRoYXQgeW91IGd1eXMgdGFrZSB0aGlzIGZvciBhIHRl
c3QgcnVuPw0KPj4+IFRoaXMgaXMgdGhlIGFyZWEgdGhhdCBleHBvc2VkIGEgZmV3IGlzc3VlcyBp
biB0aGUgcGFzdA0KPj4+IHdvcmtpbmcgYWdhaW5zdCB5b3VyIHRhcmdldCBkZXZpY2UuLi4NCj4+
Pg0KPj4+IFJhbiwgbWF5YmUgeW91IGNhbiBydW4gaXQgYWdhaW5zdCB5b3VyIHRhcmdldCBhcyB3
ZWxsPw0KPj4+DQo+Pj4gV291bGQgbG92ZSB0byBnZXQgeW91ciB0ZXN0ZWQtYnkvYWNrZWQtYnkg
dGFncy4NCj4+DQo+PiBJIHRoaW5rIHdlIGNhbiBtb3ZlIGZvcndhcmQgd2l0aCB0aGlzIHBhdGNo
LiBJZiB0aGlzIHR1cm5zDQo+PiBvdXQgdG8gY2F1c2UgYW55IGlzc3VlcyB3ZSBjYW4gYWRkcmVz
cyB0aG9zZSBhcyB0aGV5IGNvbWUuLi4NCj4gDQo+IEhtbSwgaXQgbG9va3MgbGlrZSB0aGlzIHRy
aWdnZXJzIHRoZSBiZWxvdyB3YXJuaW5nIG9uIGEgZGlzY29ubmVjdCB0ZXN0Lg0KPiANCg0KSWYg
aXQgaXMgbm90IHRyaWdnZXJlZCBieSB0aGUgYmxrdGVzdHMgdGhlbiBtYXliZSBpdCBpcyB3b3J0
aCBhZGRpbmcNCmEgdGVzdGNhc2UgZm9yIHRoYXQgc2NlbmFyaW8uDQoNCi1jaw0KDQo=

