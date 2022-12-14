Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 04:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6apMCzfXABzXpmvYQThtsKCmXrTMVUnQi9HXgVeNMXM=; b=dLWNgRmXlAmpAE98+Q0bSDO9oA
	pLRkHVfDV6cl/sIs7byb+JXBC+rVlxrK1v1S90tZY96/rPfJZY/HGrRMZQ/1IF1Ujtrudw3o1PKmt
	Y5IOtpe7+i9VY90mW/i8w+Bz7UKfZihI5ZnH78EsD8LgEIUB+h4wlSwZMcIsoqvR1wucYt/0c3e4x
	nA+7V0yR8iSPSRmgoHzIREJc3i3JJzP0WrkTsQagCRUSn+r0D7XHRHCWlKAVSh61Bn0BuNTz2LAW1
	RUk1Se+HpzZwfvsRkDbPX7Y6d427LDJk/yMglVJj8mnbQOfSS24O/5RMixaUqZ5MRIMh0p7Okznnv
	vRCpNgUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Jfv-00CCup-9X; Wed, 14 Dec 2022 04:47:23 +0000
Received: from mail-dm3nam02on2085.outbound.protection.outlook.com ([40.107.95.85] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Jfs-00CCnn-KQ
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 04:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br3fBUxitZBFxmp/mmEusN9SzQnhkL5Cb2JGFX7RgJ3qgCIqHpomedhyxggxbmLc3FQ9z2TpuszfduKoyROGKoqtqM7JtUqnD+Ul7pue3YAQZx2dMu3Cw5W9y6TvCljsQ4w+A2gAuyAog9IvYT1mdCPi0krvWc6oYMdDXi8BQV8wPS7NC//WnJYQDg4ZtDwDAMmDwvsRi1gV6VISgif1ADMFEsqWLVHBpV252M5mZprOW0pKYHOQM4DpG3/wkfOcb9/j+jNP+HQNJCU5DnLC0JKaLu9IiUhV/ro30VHlZESc0MDsfHm/NhrMq2ulglwxVKVTZld2UlWG6YeM6WiIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6apMCzfXABzXpmvYQThtsKCmXrTMVUnQi9HXgVeNMXM=;
 b=CsyqD+Mwz2RN9EGVq3ZS0t/4FyHX6kmAw1QRie2AT+Ge/1EMgNq+olMMIGzndIBhOCN9YXRhmdRa58bE0pJdIQP4+fLpOvl1RaHiJN13DpDx3flqehZ6vxvmr000Gn13K0jDe9z7rKDNZldHrrP8k4sHyE7kjbKEfhuQd7Cztgsnwa8T8P8gDK2XrZx0bePuyJKTebTxx8kcbgmAuBKayzmLdf6oSNbO8hg/mGEhWKD/nBtAihV+cQq5kYSftRDwHuUCzz+8mS1elgiu13HCFotaKbJ2uHTPXO/NC3t9EuX4gk8sb1ToxsInNy0ok65uwJKW3neLmy9fM8Sqz57D/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6apMCzfXABzXpmvYQThtsKCmXrTMVUnQi9HXgVeNMXM=;
 b=D0154b4Wn89EanelclaQwNKT16mEf8Jtn6i5g+nnJltvi2tt4vO0nd+QiiLcWCx7nuEafi7EJs0l1GdOC1a0T2qUx4pf2i2Vxo6ESaZI9awXqM80c9CuLxNCi0O4JIC7YW+hc8d/KQ2d2oYDaEaKgSauHaRfcEd1Dd4CuZRJJLfulUs7xFiU7WEZ/tCIDbZvYm2aVY1bLerMpfgHPbl7DNWpS+et65EMZqV7sXslWiQUrc1ZwwhzhkklJWWaK/OrSsChhIQjw3EHGf+vyg29LsA+E9Pe4L621v6EeVRFSTuvrVanW/Jt4orAUqc4Z7vDDOzG0jDjLPwb5M+WHocuZA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:47:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.018; Wed, 14 Dec 2022
 04:47:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/7] nvmet: set the LBCC bit for commands that modify data
Thread-Topic: [PATCH 2/7] nvmet: set the LBCC bit for commands that modify
 data
Thread-Index: AQHZDw9254JI3Q9HBEq9soQAqlwMD65s0CgA
Date: Wed, 14 Dec 2022 04:47:17 +0000
Message-ID: <e3813197-c860-6a8f-7cf7-8d02628447bb@nvidia.com>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-3-hch@lst.de>
In-Reply-To: <20221213162453.584965-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB6827:EE_
x-ms-office365-filtering-correlation-id: c0c8363b-f0e0-4c96-4728-08dadd8e46f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vSGE4Bo+CzkXBoN3vpnmqP7huyCyTPAL2eBsMbsPdn774rE9v4z405J+mbVkmdP7HSLGeKD9CWJ6gEksdIF+azDN2XvgGywpccKweEXTqTRPim6IgwYqTGxmdjHYYkozjv8NWZmuiUraG2LjlLc1Dzd4yIUPlb1mHOGBI2aEMmn6vj0AKPBGyaQJrGkcoym2NymBq/+3qH4sQlagOZizYuYDbsAbOe4SLMlfDhuykXN8LvnEjkHZYWnrgzmUJhW1DZHUXAKbyU9f5sKjAN9mREn329Us3E/78hwfGtfdEpjasvMMbxQqcDR7wzAftuXWc0efv0keuyylP6iKlCTgPLBr3WA55uZhPkZfpaLelMAFpO1krY0eDv/lc+uEjCoDcX7aYVVTML0380qTtAG8i6YiidiQyHj1TsPqCOVvORLywhGZIbmQ6OOe33i4EJLvqFBq7XdDUh9p/thMP8qQO4czvHLkjddDosWxEaoMRj7HkRgseTrFhIvz/73USV7pfsBojf3Y7k5ipIZIuTmNUoNZe3dzLbVyT4sojPYBQzhc8/xBOWwffqyRHR9fLhIl3kWe0fnPQa+GLfrp5zEDZ0b48i47U4jhzwNB2JqqsHFIO+VTfLR5dsqd8T/BlM54RhtB7URsZSOggXOo8dwrP9cjFbrB89vDI4pMKxj5s3r+wWeHfe2RD2zy1o74zOUjXBqtM7bwGgEnGARbjgN15Ml3Bfzga/n6YWusOE9bC3DaxHax5adZj2wj1vFnki/3PRff7zaYOJ62jaK2I6r8jw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(36756003)(8936002)(91956017)(6486002)(71200400001)(478600001)(31696002)(122000001)(38100700002)(86362001)(38070700005)(53546011)(41300700001)(31686004)(4744005)(2616005)(5660300002)(4326008)(186003)(64756008)(316002)(54906003)(76116006)(110136005)(66556008)(66446008)(66946007)(66476007)(6512007)(2906002)(8676002)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZGhJc3lOTzRsVkhUcVF2SHcrREFnYkY5TDczTmI0REpVc2pRUEx6dG5KRXlh?=
 =?utf-8?B?S3NsTW1IbUYwdE1YWmtwbElkNU04T0djUTVFZWQzVXRnS1ZoUjlrR2M5WW5H?=
 =?utf-8?B?UDdTTnZHWnZwNUpBeTlvQ3BodWZ5L1NaUEtPTHRxaC9LV3FQNyt2TER5TitV?=
 =?utf-8?B?TWZqSm8wR3d4YXZQUWhmTlAxMjlwUkRPSmNKTXEva3diQU5mNkxVNDhwdnEy?=
 =?utf-8?B?dldGUDdrR3ppZFYxSm1VSUdldVRVTkFVMDVoanhtd3JweURSZ0lYT0pJTGd0?=
 =?utf-8?B?ZWw2Y0IvTzNtMDRXNWszOTlhanV2d045R2ZDK2lPZm84U0RpLzFCZjJ0dVZQ?=
 =?utf-8?B?WkhmT1NYOElsZnVHVE95WStmc3JNZE04UTBFQkpPR0c1bDlRUU5NaDZNeWdN?=
 =?utf-8?B?QWtlb0JiWlFEeDNGNXVqNHFENC9zRkVhZzlrdjBvRERpQTFSaFFlK010U0JZ?=
 =?utf-8?B?Ukp4MFBvRVdKbk00UDBFQjlmbTNndGg0UW03R0pLMlh5Y29ROEdWN0VNN2dr?=
 =?utf-8?B?eWZuTXpwSDNVanR3VldrV0FiT3cxVzg2ckVUdHE4NHJXTVBzYmd3eW9ueGVQ?=
 =?utf-8?B?d3dXT3ZsWEc0L2RuRFZUYjhVM2g0UjVJd2RKd2lzbSsrSE9vVmZNVkJSREZW?=
 =?utf-8?B?dC9LdG5JTDRJdTNWbzcvUE5ubStSYWkzSkRodnFoWEprYjNoV0dneTh0b2hQ?=
 =?utf-8?B?ZUdZQ2JzdlJyMS85TFh1TUZLbmNlYjdDNmZrNUludjMxVnVpV3lRZDF2Wm4r?=
 =?utf-8?B?eTJGUkZiR0M0Y3l1OHM0N080c3FBRERuMk1oL2t4YXRHd25jTDUrT3hwemlU?=
 =?utf-8?B?a05ST0padFdSTDRBVzQvS0VWekVPMnI2NjBkRVZIWC83aE1uOVF3MW9Od0pj?=
 =?utf-8?B?TUw2Y2VhOE1ha01oK3ExYkNJVHBDN2lUeThsQmFOSngxRU05c01DVlBHQjA3?=
 =?utf-8?B?Y2V0K2hUQjd3aVp2SmRuQi9yQlFQekZJS2NXZm5hZDc4Q0xzQU5oU2x6OWU1?=
 =?utf-8?B?TExybC9DbWtqQzh5OE1UVGh4TEg4MGcxYU50bE9jaU84OVhnL2JzZWRLOVRy?=
 =?utf-8?B?amZ5d1o1QmhTa01pN1VYb1B6MUlNdUQ2UVk0Yzlobndqa2c4emFiUzMxQ0lp?=
 =?utf-8?B?N1BPZHk3aXJkWHptOWkyZm0rL0tONGFldW16ek9KTmFBUEE0N1NXVFhBeTRu?=
 =?utf-8?B?UmhLMElUL0VJTVdrUGFINGpobzlka3dDY25iUERMcHh3TTYyQjBpNlFmLytY?=
 =?utf-8?B?T2g4MUlBeXZrQ2h5aXcrZFZPRDB5RWlZQVFlYVlhdUwvT3dETi9KaStLQjBh?=
 =?utf-8?B?bHFRRTVPYTFvdXFzMWs5OFVSclRxSUtoS2x4dW5jcTFBWnVqbmdtdXNnaEVw?=
 =?utf-8?B?OTJnQ3l1UFFOM0pDK1JlVFhLOExhK05vaUVLaUNzTFdGYUNLSHdUSlJKNGlK?=
 =?utf-8?B?VWk4dktWVWw5Y3JIUGhJU2pndjdDclB4QTV0K2F0cFlTT3lleHlIcmxiSmZG?=
 =?utf-8?B?MGNqOWhhVEF5TkV5S0R4VzZFcTBBd0JJSzdYZ1Jyc3V2K2xpRXJhY20rUjkr?=
 =?utf-8?B?MUMwMy80Y1dPT3FwV1ZCNXh3ckw3SGwzODV6elVmSFg4Y0VFUzgwMllBTVlz?=
 =?utf-8?B?NmN3SFpUaGdNRjBLMmdBVTRnd294ck1rWGNaN0gvNDI3c0M0N1VYczhUKzZa?=
 =?utf-8?B?SnBvYzVCYnVES0pHeFQyck5ua1BwL2t3NjN0UW51Tk5iU01mQXlLTTdhUFZ5?=
 =?utf-8?B?RURSTlNQUUExampFSVBGRG4zbk54cVBiVU5waW1qVHBqY01yZkQrRXpINjM0?=
 =?utf-8?B?dy9Ta1FwZDRHbVJ5dnVMd0s2SFQxWGVqVmRiMVVvZUZMbTNBVWhueUkzZWZN?=
 =?utf-8?B?enJJWDJJNitkQm9DdXFWc24vdy9QWDd5cnpJL2krZkNtbzdQOEkzMTE3c2Qz?=
 =?utf-8?B?TTc5ei95TjNvSXRVRDNNV05XNnh0OHFoS3gyOEU3SEFweWhtMW9Ubno2aHF1?=
 =?utf-8?B?dU95UU5YdmN6SjBtQ3RKakJmZmdsWVl4NmhuU1RuWDhzd2hoQWhpYkJNeUNF?=
 =?utf-8?B?N2Q2UVhwa3QyM0kvYVZiNHpCb0hvaWx6SHJtRHhvcEdhZFF1cGRqekxNUWs0?=
 =?utf-8?B?VS9pQXFnallFMEE1dXk0bUh5RTQzbk5UYXN0ajg4enlaV1VYdEJqbE1aVVE0?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEC26B29BE9CB74EA7959EDFAC2D2B14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c8363b-f0e0-4c96-4728-08dadd8e46f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 04:47:17.1648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVpupXCmP/0CN6ENjz2b5dIvvcfOPF1+11bXzIT+zWerheYTu2bw9dQLAuu9TIcFla5s16AP/isvILSL0BCpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_204720_707510_2713A6E2 
X-CRM114-Status: GOOD (  10.27  )
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

T24gMTIvMTMvMjIgMDg6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBXcml0ZSwgV3Jp
dGUgWmVyb2VzLCBab25lIGFwcGVuZCBhbmQgYSBab25lIFJlc2V0IHRocm91Z2gNCj4gWm9uZSBN
YW5hZ2VtZW50IFNlbmQgbW9kaWZ5IHRoZSBsb2dpY2FsIGJsb2NrIGNvbnRlbnQgb2YgYSBuYW1l
c3BhY2UsDQo+IHNvIG1ha2Ugc3VyZSB0aGUgTEJDQyBiaXQgaXMgcmVwb3J0ZWQgZm9yIHRoZW0u
DQo+IA0KPiBG0ZZ4ZXM6IGI1ZDBiMzhjMDQ3NSAoIm52bWV0OiBhZGQgQ29tbWFuZCBTZXQgSWRl
bnRpZmllciBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+DQoNClRoYW5rcyBmb3IgZml4aW5nIHRoaXMsIGxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

