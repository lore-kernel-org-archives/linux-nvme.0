Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2FFC48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHoDT33Hu54ypdLUGvC2l9k7aKdhCRizguZk8P7MMls=; b=YGZDaJiaovWY4Z0VZG3M1DGtw4
	ZNt5rTPXm0lR/O8twIh73dmoEi8zp0F0lqj7f07dl13EtfGuRAY/ILPTdD6fjfAB9bsA2GWCpnvwR
	W4DLlMlATScnszwfrqV1WQkQM5b8MmAEsJyEEWb+dGA6DQ2G3GLLjjrc3vrnewmWDCz5H1br8mdfq
	y7rlyFEATq7ROmB7aRd3MZq0i8wtnMr2aH6/OfPsV6/4loxb3/NQbbvfchhHMEuubhvzWtQvjC4+F
	oPxeSZOTwQwL4MxMppDS7BTfJSSilWXGnc69doM1af88lPTCYD26Yt/ANbgMRX8hkyxde9hwtXyQI
	+oDNuNGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnhP-00000001Ilw-2vIX;
	Wed, 21 Feb 2024 14:35:51 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnhM-00000001Ik7-3fD7
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 14:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkcqrMLxx4xwgGhe7TrsSDodOGB4jBvssBRDht0o1eUI+jgzp7WjXKEaE7wAXGkTMFHh/BLYUW7NgNsI5+BpiFkLBvjjEmMFeoeY3xaM1TZ33aDEUdeSQJFbvrpTbCuK328NYdmhV5cnDq+3uDJOOsdqAx3mHttlL0JtCP33lNFYHrmf6fTBMb9x0I5lO7yLGJN+AINfjWpk/6tO8VXw/+/XWPG3mEtHERreoC4/rNVWBJbdSTAYyJZa1r7aIt6oxnmv9H61N61Kde36hSdmF7oJZBnRbIloiLbjdnXurXGa5JU620M67mjdrfLw8tjdd+IAFMUchL4bIhdbDBEK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHoDT33Hu54ypdLUGvC2l9k7aKdhCRizguZk8P7MMls=;
 b=TDseZWm0Ilz5PRYdnI1bt0BSCQa7T7EwSy9+24v0EsTYWMOmhWAK9fHMnFOlTwwSoNXpKZenVkU7nJMwR3UAkyrdo1ssczLMOvxZznag+lDDWLqes6Dav+XNB6VroyZf4UvD+iEKznj91MvVqt3lekS1GB7tqoIdbEP1V2ebM2rOw66hpqVKlXawVxCxD0D7sjqQkmow1xuSmQB0ZZLuy8AV9LuL+86w+F1n7vyIkH6pnjGK8d+sr5FVbVeOowZzVipy7WWa0sGwwuqyWpXsOvWy+imQ005GlALFcllHx7I3M659vQBixORnj12ufBTrbrFJI/zJBmYskEyx3LGoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHoDT33Hu54ypdLUGvC2l9k7aKdhCRizguZk8P7MMls=;
 b=b4Xh/kXWfNsRIrBAP/L7B9GFd2MYp3i68wv36dkO3Lp3hOc8BTJHnw6iqEX3AD4nfV3iD5b5pY3FEz3aoNkXv4w61MhnyVejcD8ccfLaYnlNFEvei36ZcXyv+h4aCtvEsWBCL/Csl/99N6J1B9U/BWAvgy3FIVWkNadMU/Kd7K0OtxaD8OcoRLLj6nMsswqpFtW8G0gdEPAEP2Q+J3n/cG+t7wgjxZK3fFEAvFyJW3U00VRkNUOsd1VhEPec8eudvoktPgPc0mr6MCcngC9Uss2FTIou3NSUiwojc/kWImCNrU0pnzbR9E0hGZPryUsrhPtzJzz/L1YCv6wdjEnH/g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 14:35:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 14:35:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@kernel.org" <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-fabrics: typo in nvmf_parse_key()
Thread-Topic: [PATCH] nvme-fabrics: typo in nvmf_parse_key()
Thread-Index: AQHaZMxN5dshpXHUZ0+dagwbrQ9d5rEU3OaA
Date: Wed, 21 Feb 2024 14:35:44 +0000
Message-ID: <1076a1a5-35fd-4794-a05c-79ccd4b42e50@nvidia.com>
References: <20240221134530.142842-1-hare@kernel.org>
In-Reply-To: <20240221134530.142842-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4388:EE_
x-ms-office365-filtering-correlation-id: 24194cd1-bf56-40c9-8102-08dc32ea62d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzbONFtO+AKAzNj8C1e0aOu7id+88hh+qvV9IdVdYRXQZs17oNl+F3n5LHfKQsZ5gGwZJQdyaB5uDfDcmmW5xttySNruvy5fU2RV04DWxNRMg0D71KuJnrAY8JULUC+FRz+krjFoIsUbe/r4WSAJvTrPnwfUKf4E38oBj67Lc7ZsOG3XPwSqXYy/gn7iqwGxTLMHxO4iQZWE+GuLffVavpb7GEG0Cy9kdXuV21Istz5/RU/kFv7wtUo5OkvxwOCI3pqq+l26PhzvzU6w1o/uw41vFyYic+Be7o/3B03LOQukWv6qWwN9UiYC0Xu/OiszoF9JKvJKmT+3/9+JCZdKqcA93X2oUrqpKfGfnGQiG9Yud1QVnYNXhL8Za/KWkPJtt6FZ7uTjcKvQV9CZtVMcaI4M3IgvyVBJM1BBu8iVz2JRZ5F9pJQVNs7BJVClzOxMfOkdXZfkznJYEkgDrFFPOfzDl84l035vd2YeJ7BlX4gek3oQ4bknHUgDkKHjBiAkxM+gRM3KFB+vKD7XZkOUIx5HqLRS5DJPj9DhO3ZXHa+uFthm4cK7r7VLYNfLX6CK/u5HLPtfuUyLuk5Lz93G8hIy6aGlf6vxr+w15XuqM0QClAIdAV5sljiiIvmH2dFT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdhR3hranlnYVJqUUhBQTM4ajlmZUhyUzUrR3cyU2wxeVN3MjdqMjcxekdK?=
 =?utf-8?B?b3NFbGdXVWhWbXNYZTQ2UWk0eFNQSEw0NnUwaXJSeU5EcXlMSEUvejNGMHhG?=
 =?utf-8?B?cndTZm4rTjBUdnJja0pVV3pyVGFHVG1ONERKRG50RzhveEl5RTB5STkyYXN1?=
 =?utf-8?B?TXhvMmg3bVgva0pta1BjUzNHcFh0S21TVjRwTG1HR0RURFFxd0lUQW1jK0VY?=
 =?utf-8?B?VjVhU2dBZVl0eXNYc1pFZFBwMDcxait4Z3BXamZOdnVwU3E0WmFiMm5YUEtV?=
 =?utf-8?B?SFVnWDV6OG4vSk00Mkl5aTBSQncrd2lYYUpVait5UURnbGxjTERxdVRabkdQ?=
 =?utf-8?B?ZzZMU1dlRm1iVVMzaWNUSU1XckdIeXh6NmdiRm55ajZxb3lRcWdMSkM1NHJi?=
 =?utf-8?B?UGM1amlMaFRPODlNSDRBZDRDcUxCZkRZQzFoTGVBUTNlMHlEeHVuVEtDM3B1?=
 =?utf-8?B?OENqUC92RkVsa2o1dCtKZ3BOWFpmM0xhZmJ6K2Z6UGNLeXlxRmVYWmxYdWYz?=
 =?utf-8?B?eGtiR0RmaXFRMldjWkFGM2JpQTRsbzhiQ1RRQ1ByWUd0U3ZDKytKdGpGd1o4?=
 =?utf-8?B?b3dha004YnVqM0x3RkVkWXl6SVRnQTJDTmFnTGo4L0RwT2QzcHVXRnJUMnpZ?=
 =?utf-8?B?SGl1RzVRTkxDbE51ZEZBdkY0VTRMdUF1N3Z2QndBS29YbmR0RU1lZ3dza3hQ?=
 =?utf-8?B?WTJWQWR2YjhoS2hIdDlXLzNBUG52WUx5OTZ6SFprVW5yMTVlU2syemVYY0Nz?=
 =?utf-8?B?WG01K0dPbDFwZGhoMm5YUVcxa1lmajRDQXFLZHRWNmJlUzFGM1VSSi91QVRr?=
 =?utf-8?B?OFRpK3JvTGo4K1lSK2kwWVdRUzZkcFM2c2FIL3ZpYjhZWGU3TGx5V0NaRjBU?=
 =?utf-8?B?eERLWGE4RGR1bGltRU9mNWgwek9yUm1DZ3VibEE3a3lxaVNVblJ0SU9lVkxY?=
 =?utf-8?B?c0dlTnBjMVExc0t3cDlJNVF5L0hicGFENFBuM29oQkFzcmNndFh2Z1k3OFNX?=
 =?utf-8?B?cWR5MXNkZE5qV0FyNmtMM3BxSnA0dnlKK1crc0lRWitCbytra09weVIzM0h2?=
 =?utf-8?B?ZDhjaGhDZlNmM0ZoR3Q0aDBYRHZBeHRyTHphMUZ4V05ieXMyZVVqZjFhd0Fl?=
 =?utf-8?B?bjgvanVENFdoU2pPaE9DV1pTb2ttOEhnRk1lY2RkV0wwK1pXUmNFd0xySWFJ?=
 =?utf-8?B?QU5Md3k1aEswMmFBODlLNndTZER1YnR1Q2VqRDBNeDZwTG00UUNWTzVpbW9M?=
 =?utf-8?B?aHJvRVU4V3RTZ09Cb1UyMDNIWlp0VnB1RzZWaVRaaW55ZWdBV2NDdGNkSXBt?=
 =?utf-8?B?T0ZMYlJFVWYyMTJIRWc5UXVhZVNLOEliVENCNmoxU0JtSzRYc0k5dkw0cGZC?=
 =?utf-8?B?ZTZzeW5scVNsZ2hEU1dWaDFlb00xM0RjQUt5VE9FbDhnZHVSdTlPaERVU1ZC?=
 =?utf-8?B?M091R2x6cFlDU01mL1dhV1VNS05ldkhuRnZJUDdneFBJcm5udGpQWWZha1ht?=
 =?utf-8?B?d1diMElRbWg5MEVDWUxaQk1GUVdzSXkyMEEvVFhWWjlhMGVUa1I3a2Q2aSsy?=
 =?utf-8?B?YTNBYStRTWc0Qk91MFRWdmVRckpUbDVOUzJWQm1aK01JTW5vcE9USkVIVnoy?=
 =?utf-8?B?T2hhTGcxZWVTeTJldEpkSjlTQ2pVZG0wazYxQm9GM0dqL1JPMlhMdkMxU0FU?=
 =?utf-8?B?VzlPemNEN2tyRTRZc0hNNHdmcFNFbVVoWFh0eGRiZHptbDJyRysrQlRRK1NZ?=
 =?utf-8?B?WlBpZ1NqUU5WUVRaMW02WXVLUmVhdWlCbkpuaWJibk9uWUtOdWFsd1Y3SjNN?=
 =?utf-8?B?anpuMTFvejJjNU1MM25LMmdNS3pCeUxad2JNV1dTb0IxbFlyUGtZa0xvWldj?=
 =?utf-8?B?ZVJOVE9ic2dtaUsyS1ppM2s3eWk2MVhpUXp3UDJMQlorak1PZlJZTUVvWGF6?=
 =?utf-8?B?aG54Q01wMFZqKzRPMjBpUkloRFcraXZYaW1ydWQxSXFBTGY5WHNJakxKM2xw?=
 =?utf-8?B?UnNaL25Vci9UNFkvY2dyRi9JM1Z4SUo2RTNQeExqNU9YWDhkdXpwQ01XV0dC?=
 =?utf-8?B?TWNaVk1UNncwL3hiWXZhL2sxQ2hrb21iL051TDVyZmdITWpzc3FSdWlTcXZv?=
 =?utf-8?B?ZjJmM2oxUVFQSGc5YlpiYk1PbkIxVVhZWEdvN2VPaXNwTk12MFpDZ2FlSXZP?=
 =?utf-8?Q?b0uaZpF1hx5J4181nOLe2hw4hYoSP6IBi1yq8b7++YiA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E4A49CDCD6CE546BD8E579AEE85BF89@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24194cd1-bf56-40c9-8102-08dc32ea62d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 14:35:44.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkfsgtyeR/aOiugLlScZ/3tKH6P5cQymz+FUDA/NjoHnQj47ddUrG46KeGfrzO7iUh9V5OMJweN5WT1nLMrsnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_063548_943789_E6735227 
X-CRM114-Status: UNSURE (   9.55  )
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

T24gMi8yMS8yNCAwNTo0NSwgaGFyZUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gT2YgY291cnNlIHdlIHNob3VsZCB1c2UgdGhl
IGtleSBpZiB0aGVyZSBpcyBubyBlcnJvciAuLi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

