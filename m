Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36564C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZtTc9SVZOa6KJSe9WDeMCQtnlh2ZT2DEZ8geK1oEO7c=; b=XQ5lfCoA0vq5ujiMGphNds8jVO
	k0UK09fAYMFGEwPRTo8sqf9TrjJDm2Rwk29xauoqpRwZXANssHsXzzuJkUZyzkRZmz05u6ZE9xBAy
	0r2WCl1cbSlxdxwRU2tXGf8nUhXGQ42ujgGe2zqtO4RGbwPTqH0YN0/VNPW/T9T5O3IbwHHMLjqz4
	DYgWVUufV2K5qRBLLPdxVISTn97jW7K9g9wQoktaUWSCWZl5zfpOi0fBWY7vS7lt17lr8JALn2LC/
	fVhg5Qqto62VMvmOOlhZWsHVeb96c5O6b9udTPuO4ZiKr5q1nocVHDU7L/+6Bs+4UzedFTYHJ4c/R
	HG/vig6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal3N-007BpD-Om; Tue, 20 Sep 2022 21:45:17 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal3K-007Bm8-Nz
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfvHNHIjUoh+FYSp6Swdc01jKJFXW71Qm8MygfAJqL/8GvGa8lSRqEIHD0Yu26Hm7jwMPC/DR3dCo7tZnHyERY8TzAkIAC8YODcS+c0XkoQaYJXh4xUdM++l3H8hMFpmr5d+WHCzuqYr8Zzk83y7sI26FNTVtyJ1oNPsW7WAGvJAmzcJDix0b+rOT9EtYyE7PgNC7K/2mkPFK46ESn392vWEh/dvd17ol8WQ5MIelMDz6XUDIqk8YqBWDg4AuP7cJIfEBUapPI1PFS7DT3+bzc3ZhzTxWoRXhTYkjRCh+pVDqSNPPc8rx7u8sXVPsycNbUWUrvxo7dOxkK+aASaQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtTc9SVZOa6KJSe9WDeMCQtnlh2ZT2DEZ8geK1oEO7c=;
 b=iMMviSSmyTwZm4Z0qr3Tt6eXFnrAqeLG0nxn1NVzqAmZK+ckyhCuRzWM5CDKPGJSMBxllLWOcYbPWeB2ZqZi26XUSNtqUgDCFo85Kkzsa3I35QmRWN4wqm76bTv0hzQkxwtSUwPRSpcdkhTGNF1WlyZaPAMsmD/tqXJnbos5rMzdOeCR34xp95evtgPlIKz0OsdLufZu44wZJEoJWJyi0VoXPt+sIyKncGt8meoHN57+41T/EFePjJawFpwueII+lR5GjWh8W8cYaLCKwEcaWSo2OUlZkytd7Iv91MojdY8IKsarPNelaND9jxJT0taUmBHq1qcB6/1wecOWsTEqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtTc9SVZOa6KJSe9WDeMCQtnlh2ZT2DEZ8geK1oEO7c=;
 b=MWeDAlS2nhZWi0uzHYpSNa5inTrpf3oscnlRuPOMZQVhRsH7Bti1Xo9Os2JdDIwf0a0QV9uDE3nry3C0QsR62DRiRMZtLQ7s6K9k8pwRX4aeKMJjvwgbQCQyD87cjwL0o+9DzmKWHCYf5I7NqYCMgLzVbMNHp8V1xNA82FwcuQrW3maGlmN18teZuZysV1ZTheuab1+rRYD2Wg75wALYd+wQk+yuch4Pyd12mNq77K49cdtzhpentX0IDm+pZ5Ski9xcZUXrx6EERBSBBTEV7AOx9cyYxmvx5xuEl5m5lu8XFwxT9Kn9J5Nkq9HRMIuMBTD9CA1Tb3fXPt+w8GW7kA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:45:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:45:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 06/13] nvme-rdma: use the tagset alloc/free helpers
Thread-Topic: [PATCH 06/13] nvme-rdma: use the tagset alloc/free helpers
Thread-Index: AQHYzRTpF4wBhauviEW9wcXSbum02a3o2lqA
Date: Tue, 20 Sep 2022 21:45:11 +0000
Message-ID: <2e1d586b-1fa7-492b-6e9c-206a9abb0455@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-7-hch@lst.de>
In-Reply-To: <20220920171611.1289361-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5052:EE_
x-ms-office365-filtering-correlation-id: 4e74d43b-ebfa-4101-d391-08da9b51651d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  he4pQT3qN+OQEN6yU3Zfo9cIcOVtFr4otFdIhtujVzug25id3SeiEbu6N/SrV/E9L+YJF9g7QC0xMdMPhpnTSS+8rv56j5q0/NT4Pd3jPttLE3dfHIPLQjiJekYLX4ScYzJ8u8P7w1YzTeCRnOCZWO5yHq7ZR9XBi2uKE/k0wXSqepCLtY3mfKP0OtWXzTyCwq1dGJ1WKTUc6iaG6Ge5iDnQM0Kqht6EkH3xoTl87/wAoCSMhvf8d/Uua5kDUfJAqFaS8mpyOv/r36nndDWd8wwTFN5Et8vkrn8574XFOImfrP2RsrAhIO18NZRPI5Y54DsxGl6jOaBU1eP8H+l9OVU6JsBSGPtW9HbBQYM0agbrqp9kcEZg5HTW25b3c3qvi/4B8rJ659267rFL62kUYhWVMT1/xHoZXgjf60UCaNOaBU0jIh/waXlKD9lFwHVmtJiqMZvF6woD/X8+6RNgDTvEclJW7vDkGeqS+Du9K0SYfyN68NKDOKjHjp5gr3d6mtbkvh1fjE0ARbJglBof1FWGWCFykhu4TZF8Z9cLKwpmuEQRy5sv+ME3WTwaSlHjdo8NmzU1+31x6xBI+3jQ4DZK/rziKDdKwXI3ByOwsjixohddeQGdAugTF+t8rFFK2Us3A2jYGkMKWg8UIBespjZRHuByjJsQsE4jZ2ugtxbLiMfv+iW0VQ8Zpjcv2zElK6gkOsnUuMJEJQ5lGLhx8nMIifMOsx+70y5WbDYtx3bcoMML2t6qJJU+PPItbbNmCQjCHnPqkT7M8OOcOTjfvyGjG3T3WCIMSXdHDEpe0cMcjbZivXaV7zt4PrmpzkQyNGK4dcKlmBVFoEOdU0ZLXA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(5660300002)(4744005)(31686004)(122000001)(71200400001)(54906003)(6512007)(2906002)(316002)(6916009)(478600001)(6486002)(38070700005)(38100700002)(2616005)(8936002)(186003)(86362001)(31696002)(36756003)(41300700001)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(4326008)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?T1Q1OWFCWElpOFU0dmFhcmEwbVFmVWZrYURORTJkNUlqVk93Qk1ZT1ZNcHpa?=
 =?utf-8?B?d1R0SjFlWWJaV205dHBNREZDaXBOZkJ4U1drelBMbFQzRWI4STYwcHVSZHZC?=
 =?utf-8?B?eS9vQi8zbm0xbC85SENFaVFxMmxVL21VdVJHWUlnYWJ6U084cEVhaG1LUGVy?=
 =?utf-8?B?TERRUkJuY0Rkd3NzL0k5YXZCVWpwRDlBYUtmeWlBTzhMS2Q1SzllMVJVcXBi?=
 =?utf-8?B?cmNHSUZlMjZzaVg3YlpFeTNGd0N6YStocnlEMHNFOEJTZ0NlaS8vK2RuV2Vk?=
 =?utf-8?B?UThOeUpWc3B5T2xLZU9YU2JDYzRTa1hnT1VybEVJOWRnR21kY3RUa2NoQ21D?=
 =?utf-8?B?anMwajAwemdxSWtBVXJ2N250elJOQUZwc092TG0veU9WbjdyWEdEVFdhLzFx?=
 =?utf-8?B?ZXVnZHdkcDJQWjFFcE43QUhBcjRvSUh0LzdwZVRZUDVrc3RDOEZVV1NCbXdQ?=
 =?utf-8?B?Y1NxQlZVYWdTanl2UXBtVkFuK1hDblVIU3VzTXJUaG1vUmRFTG40K1JtaHMz?=
 =?utf-8?B?blZ5S1RGbTNtUFFVVnY5RjE0YXpyRlBSVENKSmdFQWdhMXgvdExPK0M0S1hs?=
 =?utf-8?B?b3ZydWFZNzRlU3BKNldZdGhiVklPOEdVVUpneEZjc2VsN21vNDRUY2hPM2VG?=
 =?utf-8?B?NEdQeWJsbyt4bXlLUmlpWHNHRUlBaFk5NHNzUmw2akhFS080emdrbGFCZW9o?=
 =?utf-8?B?MXdkVklMUUxmY05hcE0rZGNPR2k2aFFkcTBycjA4VzRhWFh4RTNoVUN0VGNT?=
 =?utf-8?B?Ym1sQnAyWmxFalk3RXY0YU9ocVpPR2FSRy82cCtEYWtvbDNWbG8zYkFhUmxY?=
 =?utf-8?B?cnJtVEN4RjhmVW9rcFk3RFVTZFJWMlMxV0ZUaTJrRk5ScXhmcFRkcE1WQmJH?=
 =?utf-8?B?R2k2STBkYTZLTzgzZHR5NTNlUlJhWjIydUpNdFdxdDhaRm9jenVoNzdRM3hT?=
 =?utf-8?B?cFppbkg0WDlxRHhlRFh1RG1Pc0JaVE1XWmR1VWJ5eE9pRmpDa0JlR01GWEtC?=
 =?utf-8?B?dzRUWGJmU1VBaHBRVzFuczhhQjZmYmFyUjhPZjB3RjBGVFZCdTFuaGFNUkUy?=
 =?utf-8?B?YWhsZUV6QUpRSlNjOTFDSlpTbnFXSkRVc2RRUW0zSG1wOXdtMm8wTjNQZ0RK?=
 =?utf-8?B?bnROTFlTOXprVWcvUmhDWWNHbVZSYmlmY0FUYjJOcG1sdTZnVytYUnczUHho?=
 =?utf-8?B?aEFPeVd3SkRmTW5uK0hGeHNLRTBQRzZrbGZGanpSdkdoRFBBdmlQMUk1dGFu?=
 =?utf-8?B?WHlscGJoY3A4QlA3TE96dldkYjlpc0ExZlNEYXBlQ3h5ZHhWeUQyb0RraGd2?=
 =?utf-8?B?ek5BOCtmVUNmakFqYzBpQk9aUEt1YjRxLzdrUW5tRHZvRnpsMXliT25uZHpI?=
 =?utf-8?B?T0ZUNW5xSjl2RGIxdFFLSlZHaWhDWDUyS3o4a0JDYmpDbDBuUWJqbGRzWS9x?=
 =?utf-8?B?YjBEUUVVTXAxRHZaQ1EzempOTkRLMXNwTVMxTWVNR2xyL01MRjJQRVk2QmFu?=
 =?utf-8?B?ZS9XV3pqUTYyZURtcWFaY2N4TytIc3BpR3QvUEtoeDZZNkhoVFlzd0wzbXRS?=
 =?utf-8?B?eVhQaDBvRi9INUFRZzRQTTdOWHdxblFtY3V1VjQzMDFST0hqYXl6UFFjdlVW?=
 =?utf-8?B?dlJWRTdvVVJBRUhTdTY0UTlpY3dTY0FtS0tSUmpNNXQzQmtlMXJQRXlDbEFD?=
 =?utf-8?B?ZVVHcUQ1OTQzcFR0YlAybWplMTdvaVd1WmE4TDl1eER1WHF4SFJETzd5VDNn?=
 =?utf-8?B?Q2tvMmE2a3R4dDg0MjlWdzFRU051ZUdoWmdNWFNzRXVDUWdEQWVMSnN5UFhF?=
 =?utf-8?B?ZGdTRmpTZjJUMjE5MU5sNTBsdG9STEdEaGN2R0hYOEQ5M1lDTzZqRHJoR1k3?=
 =?utf-8?B?b1RkeitwU1V1ZkhiRWtYeVA4TTV0djdxS0FUd3VRUXNLVFhQVTdFQU5Rc3Bm?=
 =?utf-8?B?aEhtZi9jUzJxQkZ2cmpvUjJtM3p6Y0UrbW1qZkNyTWN3d1ZmSnBTM1FNOHZW?=
 =?utf-8?B?Y1dkMEJ5cVZSd0JRcDZ5Zk5VU0ExeVZaYlcrNVdUYzF1czZGSENNRkxHbUJJ?=
 =?utf-8?B?NDArdnFFU3k5d1lmRVZCWkhaYWpXYndIUjF2RFRISzRSNXl1OTMzak01UUxo?=
 =?utf-8?B?REdxV0VPRjFYdGUrc1ZSVnJIUjhsd2NaMHd6TzB4RCsxTjc2bzAwTFRGOW0x?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC29738D0A6F8045B25DABC6D327A2CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74d43b-ebfa-4101-d391-08da9b51651d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:45:11.7300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cf+UynvIljOCB1lxKYTL5aG+KNR3mcbFyqf2IfSof+2pY03Jx5DVlSSqbscTz1zaaWJhfPRcIe0YypGsNmQI2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144514_850446_92D78455 
X-CRM114-Status: GOOD (  11.31  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUgY29t
bW9uIGhlbHBlcnMgdG8gYWxsb2NhdGUgYW5kIGZyZWUgdGhlIHRhZ3NldHMuICBUbyBtYWtlIHRo
aXMNCj4gd29yayB0aGUgZ2VuZXJpYyBudm1lX2N0cmwgbm93IG5lZWRzIHRvIGJlIHN0b3JlZCBp
biB0aGUgaGN0eCBwcml2YXRlDQo+IGRhdGEgaW5zdGVhZCBvZiB0aGUgbnZtZV9yZG1hX2N0cmwu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCg0K

