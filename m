Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CFBC02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmgDCvuKQwenTIvC+jwMqjAYA0/aQZwHzCtTLmsfzWQ=; b=JshfDBjCMt02nLr66ANe5K+yVE
	xmD1E/iKDtTb6aRnrwg593D6fAb3B5gF617uDq30sdsee56P1gKFyg/zBNnWQZMy3HJDhsJ7pba4t
	qNsB0dcVE4EtFJs16FOxP0vkaUzE2thJHlZHx1FApKwAoQTqBOTo3ERqdlPLZg0/T3GVHjwd5sdvZ
	UdKkTmVarJrr5YuYM6j1lFMq9a9E4SK0fKjWPBas8/dituQ6TPtAFAKdznhhHhagVircpR3pWgGfJ
	6AOfcoxvCioy2RfdU2EQfI45/diWmRQBz6cW4zD6L4EmSo+T9xbB6osO3FdNG+XeTPqGSIJY2Xw0/
	b9UW1Ixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHVD-00000008Tre-2B9D;
	Wed, 12 Feb 2025 18:30:27 +0000
Received: from mail-dm3nam02on20622.outbound.protection.outlook.com ([2a01:111:f403:2405::622] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHSu-00000008TTa-3PlU
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 18:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIA3ZvbbXwIFlll8mmq/DG3Pmqbzqj4a0D4OHBTIElE2uxWyaM3odqSfQ9lQYXt4k1dtr0evzmP+3Y/NUwojNN0L2Zmg8U/keEXIgCFmD9V0zz5zeC4LWVqT+5EzSIK3yccFXRKyW0iIOpiusJOjUTCTh4K1/0Vv1eopv2YWWXZXmMjpDOU+12o/GWLBt6Z3hR83iAbkJthCR/4a6SquGl5p7GwfKRk9VtRremPfs5HW4jRSryEmCrwz4JXoNgbfTk+VffqRIA4aGuSUfc15Mrf667nzfWiTsTT9rMStfPuow013byAv3psdBdQvyrRjSJs6MkSgdTP8gZwsF023Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmgDCvuKQwenTIvC+jwMqjAYA0/aQZwHzCtTLmsfzWQ=;
 b=tX3VsRHpDKffRjksArdI/P2RgchHEW7DjWT+O23m8puaIkLMetifzB84RyH0DT1ngHrfRqlv2aytbwY/nwfmJFFFNCAzoRJxlx9kXevmPciF7VkmIBciA/MmY9FX3jq71F/1KasE+FeIS5tzPNHkc/TphTshBm5EdQ1vpTO7H6asAc9puidR+iaODaDHyNJGN8nSvYDKTIACCRg/PUfwLzg7Gn8DkbHDGAU9GwbwnrgPeA1qO70d5O0kiz9HzuYD73sV23Zrwqe1xYSR63g/vvSuumUnvMYwuOHJq5NDiNqR5wGZKoi/xiSxT7nWiSmc2mDcBDPjd01XhOomkEx8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmgDCvuKQwenTIvC+jwMqjAYA0/aQZwHzCtTLmsfzWQ=;
 b=dawmkfTqyNp/YhFGa/E0Mbc1ZppdMDxmWMTonK8uCijRBNNpNWt2uOBEnza14zng1+7IoOUsoS3S2rdHlbktLbMQqad5r87lj6jhboBg49/uPUP8Cd1DDOQIjfUAdih27tmGvPK9OlnMrt0zXSDsz585HFr2OscOl2YokbvR+5JfylrtMgJngiF3EVR9wLYdB1x0ZaM/ZdlkvmeG81eJK8OUZrfsc8XvDqYBDwN8dy23/YrFzdQpbnXEiH3m5tL8xCWeaWgUmcBo9zMtw4I35LYFxAevJYlKJhnFHynGC8ZtuM9kM0sXj5wKHqVa1AzyrZXPOhfFWPsPp3us5uuRCQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 18:27:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 18:27:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nilay
 Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Thread-Topic: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Thread-Index: AQHbeV3YjssGYrWWGE+nZeshKk4sN7NEBOyA
Date: Wed, 12 Feb 2025 18:27:54 +0000
Message-ID: <3799d1b9-d39f-4eb2-bc83-43c89b97f303@nvidia.com>
References: <20250207124134.114622-1-hare@kernel.org>
In-Reply-To: <20250207124134.114622-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7307:EE_
x-ms-office365-filtering-correlation-id: 9c042d6a-37ee-4af9-c5b4-08dd4b92f751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0xodENlMTRJOURkY3U0cG1SL3RxL05pOFBHWDFoczFxNEVVU2x3c0o5RlJS?=
 =?utf-8?B?eC9SRm5hT3ZVOGpDZDdaUkpwcmp3cGpTT0w2bjJwbzJ6aFA3UENBTHFub2li?=
 =?utf-8?B?MVhDbGt2L04wOFY2MlVOQ3VDWW8rcEw5YWtZMWpjMVRtNHlmYTdqK05tcFVF?=
 =?utf-8?B?MlhURlBzbjhQNmdvbjEwWTg3V25rZExBczh3VHNHd0JCSXFNNGtUbGlTSjU0?=
 =?utf-8?B?TmZXSU5DbmxDZDhkVXFXWTFlQ2JoR1pPc1VMMEc1WGVUWlFCRVdFWHZJVDhW?=
 =?utf-8?B?YWViOTFtR0dieExJNjdlZjRFVEVraDByRnR2Z1Z1S2dqNE5lbEswTjNteTBy?=
 =?utf-8?B?eVdRMTROeHd5MmJXSmRZTk9YOENiRUQ1cDl4bW5hWlY1MkZpL1dSUkVxaHNl?=
 =?utf-8?B?OGRpbGdnU3dQazloUmZmRmwzNmpGQ3V0MlRJVFkxa3c4eStDWjg1cVQvZ3hE?=
 =?utf-8?B?R3lZK1QwMm5LMDBCRFcyTVg1bW1TVEtBc3VRZlRoZmxNU21xRkpwc0lHTzdC?=
 =?utf-8?B?TXpPOVVqWjhoWFBrOWtyZlZpbVNHbjhCMGtodzdsQ1VIYWdwWGZCWTlrRHhh?=
 =?utf-8?B?dm14MzBRMHhXc3prbE5EY3pVcldadlI1SGUxbnNXRDkzTDZxc0VNaHBnVyt4?=
 =?utf-8?B?aE4wVGpJV29wUis0K21VSXl5NW5MZnZFR0JBcnp6TlM3Rms3RGpTUitTN1hn?=
 =?utf-8?B?K1c3TGhhNGc3UHpDMDYwcktZV1FzQWlHU3c4a2Rxb29Welg2QVIwYzROYW1h?=
 =?utf-8?B?QWZreHhDcEZ6bHZjMGp3VUlzblVDZHRWRk9nNjBzYnorVnoxc1FlbHNzZTQ5?=
 =?utf-8?B?T0JrZmJVZm9YbHhiOXUyWUl1L2VZQjd4NDVZa2FpeDJGUWtnR3lPeHJ0TUZX?=
 =?utf-8?B?RkIveTFlOTM3V1BzaG9XcmVuWGdVcjVWdzhGcXNlNWNpNDg1K24zenpaR2lx?=
 =?utf-8?B?MXA1ZTREcGdSU0dCbUN6SmpCd2M4bnZZMFZFQVYzTUI0cXF0OXZuYW5BaUpB?=
 =?utf-8?B?bllOSkhDVmx6Z2F5Z0ZSQUlFQW9va3VVT0VCOUkrRDh1L08zeW1GdkNOYmNt?=
 =?utf-8?B?RkM0UVMybnhIUS84b2F5L3hsZlYvb2FyVHVrYjE1YzdxMnhtcXEwRGx1dkRC?=
 =?utf-8?B?MUJQak4zTW5rRUtzaGQ2RjdnZjhBU0IydnlRZjBxSXp5WllYQ21TSGN6b0cv?=
 =?utf-8?B?VnZGM0hFemhkaEUrTXFyaEw0Nm91RFQxQW5aR2t3SFhkL1pOWWVaaWc5SEkz?=
 =?utf-8?B?Tzc4MHFiUUErVHdJSDIxWmVjQkhHWjlKVHhuTXZEWkhiRHNlSldhZzZqcjE4?=
 =?utf-8?B?ZlVvUjNsYmx0Q2VJSWdiV29VT2YraVFIS3JEblNpQU5IOG1NV2NpWnVxODB5?=
 =?utf-8?B?QWxSK2tHQ3p3ZXhvZDlxdDVQc0VURVVpVk0rdXZjZDM0Ty94Sy92YXFFSU5q?=
 =?utf-8?B?UFBPTUZoUE13TDQwNUhGOVJ2VUV1RVFmbFRLMEZQdmFSSWhZNFZ3MHJFRmo3?=
 =?utf-8?B?WFhpQ2dmRFBmdWdwcXFaOW8yT0xOckx6ZEtQemRNZXJoK3ZqODBZdC9jR2h6?=
 =?utf-8?B?R1VFT1NVNGxnb0F4a0JqQ3E3d0dBT2QxNHNxa0dZK2ZNTXppd2p1SHp4akly?=
 =?utf-8?B?MEplcndWSFdRVlJ5VldVK1BQRDQzR1laMm5iQnFlYUNxZk9yZE5CbnJZcko3?=
 =?utf-8?B?K3lmUmFkNWxZTEY3VUZEUlovRitsaGowK2JsRkUyQ1I3aU5KQ09sMHBHMVpH?=
 =?utf-8?B?L0FNTGRXQU9QODc3QXo5aGtrMFhnZENUQXdEaUFqUldoKzhWQ1VPa0hLK1gv?=
 =?utf-8?B?QldhNEt4eU5KbE5JbkVsOFVPK0NZQk9IUHBtR3VvVlZKcUVMQloyNGNnbFo2?=
 =?utf-8?B?azRseU40SXFmRDRwa0ZRQXMxQ0hqdm0zYUNjajMxekczQUlHZ0tZa0NtQjE2?=
 =?utf-8?Q?kqIJj2RqFcTtoQfVe3YopepI2CYnzkjQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk4xb1JwRnNwdmRuS1BXTzZiREQrZy9lazQ1bTNJdTc2eFFqTVlyVDc5MFlq?=
 =?utf-8?B?V3Buc0RpRXdvVm5ocmhIdy9iNmpKNndNQm56TWVxMm9JQU9HUVJ6TWJjaHlY?=
 =?utf-8?B?aWVGSkxhcVo0SDFycUJKVGkyaUdqbVFOcGgwL1lWQ2ZBeVc4S1RlSzY3SlZ2?=
 =?utf-8?B?djN3UmFwcmZ4Y1JwcHBGSUhHS1FkckFUcEt5Vkx1NlYzSFVBOFViQ0F3L01a?=
 =?utf-8?B?Q2djdVUzRi9Xa0czbDJNZzVTcWRDNGgzc1krVXVEUDNJb01PZHUrL1QxY2pH?=
 =?utf-8?B?anRUTnE5K3FmaDFkTExxK1Q2MEtMRU5qSVFlMXpyRXpIV1IyUWhrSVlYMS85?=
 =?utf-8?B?bHlFVEhXaks4bElSSlFqQW1EUEN1SngyWmZsL0I0K2ZOYkk5ZVRYOGtGY3da?=
 =?utf-8?B?d2tOTVpCU3JiRXVvWVpSQ0Z6amVHand6WGROcVBIT2k5dW5tckc1djRsYlMw?=
 =?utf-8?B?MU05a0lUYlRjbnVBU1JpQjhPYkxDd2k0b2pjNzlVY2NudzVUWThuV0RjUHBl?=
 =?utf-8?B?b21wWXlwMkxRUUkyenVOV0sweXIrY3B2ZHdkSmJQa1g3YWtkeklGajZQaGgw?=
 =?utf-8?B?TEtacTlEQ0k0eml6cGZ4eEYzUnVPcmtLSkd1dTFYRHZjTElUR0Vnc1p0UlNL?=
 =?utf-8?B?YkZaZGlFSXZKRXdSVDRLRkhGeCtoNGpjRFMyeHpJNG1wRURzNGVrY3AxZlFB?=
 =?utf-8?B?aXJWb2kwbFI1L044THUrNmY3QWg5MFNrT0tqQ0NNVjNQcnhQMkZyUGtYY1Az?=
 =?utf-8?B?TmpiTGo1M3E3Q3hMeUpjN3ZSLzduNzlobmdjSkVFYjJiMWNKZWV3WmY5M3BM?=
 =?utf-8?B?dnZjb2l0Mlk4VWtCTjE0TVdlTHVEaDU1M21XbmJOc0VpL2pCMEtCVUtLdXdu?=
 =?utf-8?B?RDNwSFcwYW5rTTZsTElwd0VKWUZsWVowc2hLbWFCYkRpYXRGUzhRS09wRXA0?=
 =?utf-8?B?d3pJMzEwU2NzNU9jVkpRNVBjLzYxRE1uSjJpNDlER0ZwZm5ZNktvOUxJNlhY?=
 =?utf-8?B?THBOWWFBMnpMMWhxTVlTRzVad2tWREpCaUlIY1lhaDlqT0pZVzUvR3RybTU3?=
 =?utf-8?B?dCt4VGJSbWI0cm9jTy9tMWN4YWdmYy9nK2k1RXd4cGFtN3lDWWRBSlZqWk5u?=
 =?utf-8?B?MlJUODV3UUxpcUw4dFV1aTRQU2dia1h5MU1HNU1qZzhVd1dRRjlJYlpDWkt2?=
 =?utf-8?B?MEwyM2cwV2puMjM2dTg4YUtjQzZjems0TEo1LzZaSVFWK24zd052WWJtVGVa?=
 =?utf-8?B?Z29ZbURXWkJ3WjBoTHA0ellmbkJMc1hEOG83Vitqbmw5WWE0bTNIRXhaa1JM?=
 =?utf-8?B?eTh5SUpvNWo2am81RklBQnFQVkVRL0x0QVd0SWhabVJVOGZoTjZ3cXBNRUcy?=
 =?utf-8?B?RFpQdUJEc0d6bFpHS2lXM3J2WE0veVFHaDg2UVptbzgraVI0SlVvWVBBQlVN?=
 =?utf-8?B?UHczd2VFNXJGMm52ZmQ0UnNxQWJITVpzZG4vL0lKSlppSEVYWDh5Rm1LSTc3?=
 =?utf-8?B?cXdMa3BHWnFQR1ZFcm1XVTBSdk9UM2JvREY3ajlvMUprODdydkJuQjB0WklZ?=
 =?utf-8?B?c2hJSXhPc0hjaUtXWlZsM0R3SEprU3YwWW14QnZpSWhETGwweWxhTXJHWEtP?=
 =?utf-8?B?ZllaL1RIaXREUko0QUg4ano5QXZVMHJrdjBaNEhadllza1c4RzhJWHFzRjk2?=
 =?utf-8?B?ejNvOTNvWDFSYVlVbmlwSHFKUFF0a2V1THc3c253d2xleitSbUlsdW1RSDls?=
 =?utf-8?B?anVsWnJOQVhLandvK3ZQelBhQlhQMzYzTEVhQndpTFZrWmF4N2VWcGZSSTZW?=
 =?utf-8?B?QU1GMVJKUjhJalZQYU9KMjJ4SHJJeEVTR2pZZXZDZktiYms4OWNTc0dkWFNC?=
 =?utf-8?B?REI0ZVIwN1pJMm5xZ3c5VnNsN0lXT1pZK3RHUnRzdU9tU0N3OG42bi9iNDY4?=
 =?utf-8?B?R2RnMWkxSmVNS0hWNzA3L3lMQ0FxakR2T0Vza1c3NGxXbStIdUF5cVdQNkRz?=
 =?utf-8?B?Nzc4eWdBNkZWd3p3ZGUvZ2srR0pnYmtmTDV2U3dhRWNiWkFIN0xGN25ZOS8y?=
 =?utf-8?B?UDJiOHhNdzQyRWlIRnFnL0JxWGxmRkJKRlpQblhzNklab2dNdWV0ZjJKSnBm?=
 =?utf-8?B?ZlZ5YXk3NEpCeVllRGhSNlpvTFBTdy9Lb3dyQ3NaU0NJTCtySWdGc3krVk9C?=
 =?utf-8?Q?DoSpd/aOsKNJ3UjNQ6N6CRQOumK1lWTByrbD4AdpT8gO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18B864565949EC4D9630E2E78ACBEE72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c042d6a-37ee-4af9-c5b4-08dd4b92f751
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 18:27:54.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SBuDbvlU4SpE5FEQa8TLKvdp6GPzYkLaApegM4OPHSVBMrtuKsxePbgezlNl33aXQMHqev3mmSqJ9SapG5t/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_102804_853397_4C3128EC 
X-CRM114-Status: GOOD (  11.60  )
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

T24gMi83LzI1IDA0OjQxLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IFRoZSBuYW1lc3BhY2Ug
cGVyY3B1IGNvdW50ZXIgcHJvdGVjdHMgcGVuZGluZyBJL08sIGFuZCB3ZSBjYW4NCj4gb25seSBz
YWZlbHkgZGlhYmxlIHRoZSBuYW1lc3BhY2Ugb25jZSB0aGUgY291bnRlciBkcm9wIHRvIHplcm8u
DQo+IE90aGVyd2lzZSB3ZSBlbmQgdXAgd2l0aCBhIGNyYXNoIHdoZW4gcnVubmluZyBibGt0ZXN0
cy9udm1lLzA1OA0KPiAoZWcgZm9yIGxvb3AgdHJhbnNwb3J0KToNCj4NCj4gWyAyMzUyLjkzMDQy
Nl0gWyAgVDUzOTA5XSBPb3BzOiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZv
ciBub24tY2Fub25pY2FsIGFkZHJlc3MgMHhkZmZmZmMwMDAwMDAwMDA1OiAwMDAwIFsjMV0gUFJF
RU1QVCBTTVAgS0FTQU4gUFRJDQo+IFsgMjM1Mi45MzA0MzFdIFsgIFQ1MzkwOV0gS0FTQU46IG51
bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAwMjgtMHgwMDAwMDAwMDAwMDAw
MDJmXQ0KPiBbIDIzNTIuOTMwNDM0XSBbICBUNTM5MDldIENQVTogMyBVSUQ6IDAgUElEOiA1Mzkw
OSBDb21tOiBrd29ya2VyL3UxNjo1IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICAgNi4xMy4w
LXJjNiAjMjMyDQo+IFsgMjM1Mi45MzA0MzhdIFsgIFQ1MzkwOV0gVGFpbnRlZDogW1ddPVdBUk4N
Cj4gWyAyMzUyLjkzMDQ0MF0gWyAgVDUzOTA5XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJk
IFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE2LjMtMy5mYzQxIDA0LzAxLzIwMTQN
Cj4gWyAyMzUyLjkzMDQ0M10gWyAgVDUzOTA5XSBXb3JrcXVldWU6IG52bWV0LXdxIG52bWVfbG9v
cF9leGVjdXRlX3dvcmsgW252bWVfbG9vcF0NCj4gWyAyMzUyLjkzMDQ0OV0gWyAgVDUzOTA5XSBS
SVA6IDAwMTA6YmxrY2dfc2V0X2lvcHJpbysweDQ0LzB4MTgwDQo+DQo+IGFzIHRoZSBxdWV1ZSBp
cyBhbHJlYWR5IHRvcm4gZG93biB3aGVuIGNhbGxpbmcgc3VibWl0X2JpbygpOw0KPg0KPiBTbyB3
ZSBuZWVkIHRvIGluaXQgdGhlIHBlcmNwdSBjb3VudGVyIGluIG52bWV0X25zX2VuYWJsZSgpLCBh
bmQNCj4gd2FpdCBmb3IgaXQgdG8gZHJvcCB0byB6ZXJvIGluIG52bWV0X25zX2Rpc2FibGUoKSB0
byBhdm9pZCBoYXZpbmcNCj4gSS9PIHBlbmRpbmcgYWZ0ZXIgdGhlIG5hbWVzcGFjZSBoYXMgYmVl
biBkaXNhYmxlZC4NCj4NCj4gRml4ZXM6IDc0ZDE2OTY1ZDdhYyAoIm52bWV0LWxvb3A6IGF2b2lk
IHVzaW5nIG11dGV4IGluIElPIGhvdHBhdGgiKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMg
UmVpbmVja2U8aGFyZUBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogTmlsYXkgU2hyb2ZmPG5p
bGF5QGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

