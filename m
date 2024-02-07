Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E2C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnNMsgT6KLzO0+ZC121Sq9U7AMCjK0qfBPPmSfmghao=; b=AWL3S4nMHZsBJa9krOqeSnKkel
	hsnjiHqOQ3rzhxRXTrfDegMAi3ZuyfjJqzT1fEJWmVqP11Y8fq5LQF7oDXBPqSdRu1vn04D5gUM8D
	ARhlCjuA1QRYoV8bHc23TqlObi+Ef0dWMEitjxXgzdIvcT29xxy39jriOlMK7GySlA4iRvADvaAs3
	M3bE78laaBTdCa240dlNtTUdatpjgOthtkEKHgrzvs7l+6Qhhgll2/ZQRU28XzyN4ng7AQ1RRmVxk
	0YPrgmCX17XFRNepYbWCrhcOUv6vVcYKbfsMY7kwVSTOJhEJokS6LKS7D6tEQJR795H2HFaskT2vB
	CHdwVx8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXZ9Q-00000009bv9-2zGG;
	Wed, 07 Feb 2024 04:03:08 +0000
Received: from mail-dm6nam11on2060a.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60a] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXZ9O-00000009bua-2Mhj
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 04:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG8LM/5Pq0B1HBbzM/Ln2XjYb4BG/ooWsasuvEf2H2Hk74pEbOs48gJMnlGTu/PgqGxnMJDlg5HCM/l6/9/RUtL1it/0hyi2LI4JeNJRupYdhIf22XbxsOZ7Y/F0rqgWIYOLkMOFkl68712uNUBzRxflugDzXgWE0lAnx57Bx1AMDGloEY2YzNJMOUfFNyTHx8dIWopDdiCBuklrGIREa15PcehGsVQVMFsO+gauGXMzK1dTL5sgTNdN3yVawxEIcsGc0pAn/FsZ/941dEb1I2yYdYLxINkYwpljVHtLDVdDbDRVJOXhhrAz//+1t0ListFG39HVZtUlO+7Y/mQbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnNMsgT6KLzO0+ZC121Sq9U7AMCjK0qfBPPmSfmghao=;
 b=HZC65Tab9VMrbTaEgOh+mdHZtfSa94xdbvtxlQ5khcXQXA9235K1QnJgFKuh/yRMaa7hhlIEyGsQ77guZs1KWug8Wyym9t5epTrmxgeIb/CMRtx4zH00irIedbTkyRJyEwh/gKqJzyhR+h9cR6c2F+K3VALKuLYwDboOPmul/rU4wKgNAGibWT8rPOfhex9PhocU26dp3ZVuV+vSxpsY3jJO0iAVoIiybjgfRbaCC+FcUqiuGnwJiPx2cVsrwKGL++GgbH0yDtMPXWUhKVeGrLFfoxoJFe3hap0F60kw07I0V6O7areM5D7KtZ6BVFa/7XvSMuBSrji0N8pGoXGSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnNMsgT6KLzO0+ZC121Sq9U7AMCjK0qfBPPmSfmghao=;
 b=Tw45eDpf4AJzX6pdAaQgb1qTU5GlQrKIekUMqq7YSf90kTC5G/1ygT9OsVBTc7Fn3iJ0NA97nCXH6gOOAW+HLCca0M3UmfVNmDTqwSftKpaGNVwJ501ZnqvUbecUJWgWjgmkPisMYe68w4pgwu/tpqL7o9s9ZbPl/xbwHCGa+zV2osQ3V4YxKUqXqxgIrIv7mpjx19lfdc4v6Vb8ho41HT42jHdLHRudzH1cst/OUX8gIbwnLnC3puiyfPk11dvNCIW6lBKQFVMWkbJ/LtOfVlyUNBz+6l+nnavs222R7SwoEHpzaUxLabEry9sYnxyhTlONdD4HaFK/UHnac+7dXA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 04:02:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 04:02:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Thread-Topic: [PATCH] nvme: move passthrough logging attribute to head
Thread-Index: AQHaWSUbGZrjeJffXkG4Np40lAbIMLD+QrQA
Date: Wed, 7 Feb 2024 04:02:42 +0000
Message-ID: <cb287226-8b73-421a-9fa0-ee1b110912dd@nvidia.com>
References: <20240206175040.553999-1-kbusch@meta.com>
In-Reply-To: <20240206175040.553999-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5063:EE_
x-ms-office365-filtering-correlation-id: 20df0a4d-55cc-4f8c-ccbe-08dc2791a235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uz0dzWNhdYA5HlHOF2UwDGONvikQZ9OUgGAosNtReufboUGq1bdkn1Z8dcYFIw2cnTDF2WdFhMnHJmCQHWLxtmf65v4DwrL9bglVyp5YkFkUzFLXP/vc4sYwDRS2OxrFm5/X0Co7t1dLvenimOKAS0Zt5KClkpMsFtdBWiAkk3vTTp9BBK3DTmi94xj/tPhN5EWWhxljC7uPHmIq1VPLAZe5u3XQQDCe3rEDkjelEP3hKVwZ76drw25/6g5dsS6MfvJGN4AaqLaIN2tScODzQ6+odvLYv/jVj+ycGSvfrL0g1952q0n9m5YLDUpg6edNssf/XBMlkbNpb0ExbcFti6vwo8mEBdymxi/x+swYk/e3wBwuVFZySgf6wvNd64Ncu7AQzbwe0gWOjPzGIOFRE+NGeTuU1nTplYLr4qe8IqM3tw+qUY9hUxaPjuu2qEFqE2EBDr/UY1LuoiRyJKeDznqhO3kYyUGC1mVQt9odIdj6VGiBK8s7TLsznC7q5I91O5IqYbIsPF71EWPcQpCCSzhVWUuSsSKGPdZe9InW7W977i6V0ISDKYzgRD5MHr8sbgTJOkaizHeivmo3RHlOVYVmD2YeQaqcSr47dL0ngQMi0PPIB4Zu4NF4o2dBIcfaUAtq66KG9RdN63KZD+vQM/KZaJEYATV5P7wViaLWlcCjHJ3XTd9E3ibXdsT1f6v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(66476007)(38100700002)(122000001)(31686004)(2906002)(66946007)(41300700001)(64756008)(76116006)(66556008)(91956017)(31696002)(6486002)(316002)(71200400001)(2616005)(478600001)(8676002)(6512007)(4326008)(54906003)(6916009)(6506007)(86362001)(5660300002)(66446008)(4744005)(53546011)(36756003)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THFjcUd1N0o4QVJGcWhjV3JYN3dzaS8xaHZncWpTSXBPUEwyai9OaTdvb0RS?=
 =?utf-8?B?em50Rmo0ZEJYcW5GcXArUjdIbDk0MXh6SG84NjVsQ296RmZ6WWJkVkVLY2hs?=
 =?utf-8?B?NnRLWTRVRStvWjlQWXpUdFNVdjdGU3IvWXJSNUhZR3lSVmF2eENpZE1RWXcx?=
 =?utf-8?B?VFpWUWoxWmo1Q3NUNFA5emFtdjdGcWdXSnIvSkJDZ0NZK1g5STc3dWp0bUhL?=
 =?utf-8?B?Vk9Gbzd6Zk53TXArMW9TNTNUc1Flb0UzdkluY0t5ZVNTbVIwWUxzNGxRbjEr?=
 =?utf-8?B?SVowUHl5R25uOFhqOXdsMWtoaS9FUzBNelBtK0FjQ0ZtcnVUTUZFRlRhVHlH?=
 =?utf-8?B?dEwwRnRYSGdpQ0pucjRpUzFlWk5rcVhOYTAydE96bm1NazVWQ1hpSDFacDlX?=
 =?utf-8?B?RHZBNDRkdnFqcWNDbnlaSDFPcmpZREp5eW1yVEtEdUFxZmVlRWZWZk5lRjZJ?=
 =?utf-8?B?VHVEMGZZdHJ0a0FVT1dGOXIxdEtxdk43VWhzVlJNdUdWbENyZHcyclJjcVkz?=
 =?utf-8?B?VnVSWWU4VjlLMnlVSlZnRzFKdkFjRVhMUlhwMXU0K1hRQ3R6MUlXVUNBcVhy?=
 =?utf-8?B?Z2xPRUc1MS9DY1FNZWNPMEwxN3h0bDR1aG45OW9DODFFSDNaT2wvQ2RGeWpW?=
 =?utf-8?B?NHY2Yi9HMWJXUzhNaVhyTWZPeC80MTFNbXNvSkRnMGNNaFRzNEY5a1YyQU8x?=
 =?utf-8?B?a25zQWRzdjltMC9zT1JvODhHK0N3NVFTZWVaSmtuWjRPb2ZSWVRWaGwzK1Br?=
 =?utf-8?B?bG15UEpDVWs3WEw0VGcxMXlBaGtTR0tJL25ERndoYjI5RnM0eEN0R3dKdHZ6?=
 =?utf-8?B?TWhxTkRFdEt5QWxLSXBLeTI3Nno1ZFJmQ3FpR1hYVFp4eEhjYlU4UUxLdXpP?=
 =?utf-8?B?c2JGTW44OHBoYVd5bWxVcHE5eUUxTVp3Vy9QTEJhT2NER0duK29KOWlscUV1?=
 =?utf-8?B?Z2Q3VVFudUlIYnNDaktBb0NrOEZmcjlSUUJVUWtjekdoZEkwZ0UxQm8xU095?=
 =?utf-8?B?YmNjaWlNaWlWZ0ZEU3BObXlJd3lZcmZWdDd2L3A4M3lpK2J5djJNOGNFVkFN?=
 =?utf-8?B?MmM1OWxXWnBKT1RUZmNBQnl2a3NYL29DUjVPeXJnUktBRGc3SVFRYXBnSFRV?=
 =?utf-8?B?NFVDd2tFSTdZL0FrM1pabllzNFpDSWdURmUvdnZlRWJwZk5pV1FBVmVWeVNF?=
 =?utf-8?B?UVNwQnRCZXNab3JiQUsxaHAzNjEzendjNE1GbXRxQmhZRjEzN0tuM28vSDJ6?=
 =?utf-8?B?TlBRQ2pnVHM5TTR2eDRraDdWSmxTdERoR2ZJTitBVmNFaUFTL1NYeHJ5MGFV?=
 =?utf-8?B?SW14cStVV0lWRmJ6UzJZdlNZQ0V2VDVyWHJmNE41SW91TU8rcXp1TkN1UFFs?=
 =?utf-8?B?bG1VYkZKdkdhSmp1WitoVjJ1OG9NSlRCL0J0N0VrZG1zZytDU2pydi9hY1pJ?=
 =?utf-8?B?cmZSMkVxVWJKL0JZUnQrbHNsaU9SalhXbnJZNDc2N1Z0eW9yY04zL0t4ZExv?=
 =?utf-8?B?aXRPU3FTQW5zdmRWYzBWc29rYm4vS0N3VDZYdXpTKzg2WnBHR3A3N3lMRmsx?=
 =?utf-8?B?NHY1TURnNUMvLzhnckthVy9KaHhkYm1xT25xdDNHbHJJbnEyMDd4ZUMrbkg0?=
 =?utf-8?B?eEFUWjBueHRRN1d3UzBvUVpsVFdTeHd6WGJQZnpmckZHdGh5a2I4NjlyTnZ4?=
 =?utf-8?B?dGgyY1V2MUdCLzdVQVhROWV5Y1VZai95VURLOFdxV01ISHltWWl3Q0J6MHIw?=
 =?utf-8?B?V0k0R1Erd1k1bW15NWFFbUdkaWl4cXkxTGE5VzVET3g3T0hzcDl3SDJBTHRT?=
 =?utf-8?B?cW1DaUM1amtaSFVrejFMTzZlRDRveENDNW95a0pDVHFMTkRlV2gvQ3FZeFor?=
 =?utf-8?B?YjVIVitrT0d2ME9IVy9idzZzQUQ1QTlkL3FyTzh3dVR5MFZtYitzcEdnb2NF?=
 =?utf-8?B?bENPR2VxbnlnL2t3UnF5OHNNMlpPckpYRnZoaXk5L2Q5WUlkTy9OclU3MU1p?=
 =?utf-8?B?UDhxY2ZzT0JRUlN3dFpaNUdzUHZFaXBORTBnMjhXRHNaYzZmQUNSU2c0MHA5?=
 =?utf-8?B?TWo4KzFoSEpyelc3aFJqcENGeW1sOGtJT2dwd2J1NlZPL1RZY2s2dmUrSU0v?=
 =?utf-8?B?NzJYb3l6OFlyTzd0S0N1Z01EUitSRXExMnVzRThXNCtLaXFMdyt2OERhNlhD?=
 =?utf-8?Q?TQCmEsC6ZqhFK+onwiGK2x6G11hl1UjOSEHcG+v/+4Oe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAC00129FAAA8C4F9CC546C70C80E15F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df0a4d-55cc-4f8c-ccbe-08dc2791a235
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 04:02:42.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrL+8nIZR7qPIC8olZjN/OP9aacqWknSojgsvuVHB+H780bJCDekBKTH/fbjwAfzew5Oizund7H6c9SnSfVBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_200306_642128_1E0F85AC 
X-CRM114-Status: UNSURE (   9.85  )
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

T24gMi82LzI0IDA5OjUwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGUgbmFtZXNwYWNlIGRvZXMgbm90IGhhdmUgYXR0
cmlidXRlcywgYnV0IHRoZSBoZWFkIGRvZXMuIE1vdmUgdGhlIG5ldw0KPiBhdHRyaWJ1dGUgdG8g
dGhhdCBzdHJ1Y3R1cmUgaW5zdGVhZCBvZiBkZXJlZmVybmNpbmcgdGhlIHdyb25nIHR5cGUuDQo+
DQo+IEFuZCB3aGlsZSB3ZSdyZSBoZXJlLCBmaXggdGhlIHJldmVyc2UtdHJlZSBjb2Rpbmcgc3R5
bGUuDQo+DQo+IEZpeGVzOiA5ZjA3OWRkYTE0MzM5ZSAoIm52bWU6IGFsbG93IHBhc3N0aHJ1IGNt
ZCBlcnJvciBsb2dnaW5nIikNCj4gUmVwb3J0ZWQtYnk6IFRhc21peWEgTmFsYXR3YWQgPHRhc21p
eWFAbGludXgudm5ldC5pYm0uY29tPg0KPiBDYzogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25A
b3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwu
b3JnPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCkJUVyBJJ3ZlIGFsc28gcG9zdGVkIGNvbW1lbnQg
Y29ycmVjdGlvbiBwYXRjaCB3aXRoIEFsYW4ncyByZXZpZXcgaW4gdGhpcw0KYXJlYSwgcGxlYXNl
IGhhdmUgYSBsb29rLg0KDQotY2sNCg0KDQo=

