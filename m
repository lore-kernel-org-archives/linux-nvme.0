Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40059D3E788
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ykez+vVDBHXIAWcfLmA5zlz8n4z90nGSOTfWCsN4yCY=; b=4THNgIyrzu2U5t6CfAAz2ASfQ0
	tHPApZu0Z1uxscCCP6fKTdHo25YGelok5Rae7kXWvvVe/gtgc+W4o+UuF3ZjKgDDhpKC4k5ST3p4Z
	71B5FTTozuXNllE94KmunjHaNRXJwtTnHbh9rGijtFPGvGTumIqdQGAt+zTjU3gBi75SgTh36Bkkn
	8ZAowNIxsVOdZHVmQ66tjXuPQk1kH/PsNniC08Yw+1LUR3hfuSfxtD3dLA5kweiAmLRQr+njuiILr
	Kuldm0IyvyFM/6DHsZOyxWg1pTZvCtxBiMdv8eNJJrHe1J6cUb7jYyv6GZpeb9FDOLIM8e+yLD4VW
	0RnWiltw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YRF-00000001qPz-1CjU;
	Wed, 06 Nov 2024 05:18:41 +0000
Received: from mail-bn7nam10on20608.outbound.protection.outlook.com ([2a01:111:f403:2009::608] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YRC-00000001qPU-07cc
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1zmN1KSkb1hZwNYu9QEHG3AFNxZ+CoiXWKkQZmEvh19t4rAewN88R8RB2hUIBzy3nz/jkWl37TA+YVa3sxoXkGoeywUiFfKctp+DMHqM8qa0Ymo+NoYE3jnBYCw9Lkzjp2r7HQECFWy4t6HTXVdF7EdxBlIY/fqz21TtYy9NkgnQtGbp+j3iCzou7fK+HFFEP4R1NAyibRc9yCybagAvBaEm1+yzK3a9NUO2mFLK9MD1+NfkwFuJFXb/rhf22fhzFOU5U+se6RYZ4+E99v2qrkqRz4O8gN+4dn8ZdNmBNXA8iaimWY7hV71EovXTo1FLSwmaZBEetiQV+yHdctLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykez+vVDBHXIAWcfLmA5zlz8n4z90nGSOTfWCsN4yCY=;
 b=GtkN2a3q/StZUUJtu3EOcHsjhD1xS8FiTsbPA/UAdiBWE4ri17gAk8vXvuX2S+CUVpnfPaVH19ouz+13mxjMjbnoQRdulOz04/N9uMgMA9nmoa7p5GFI/ign97FC0Qtt8EJ3VN3avWmGYb867H9JOfNsQrsihJxGpTSfpPQVuUC0AlGsv8q2ZZ3XaMeRcxggZWejiA/UA+Ni4iD+1WYYUXb3wSC58mrtJ/YFekc+Ij8y0GWGSpTURoLD6M5VqPzkBk89RLkXJ+0t7eWENU9HUaC5Q+FFMc5woVWiQWON7/ntah9FpUJ4Daxubp0C7WOheeHjZoL/GhBTwz++NvXs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykez+vVDBHXIAWcfLmA5zlz8n4z90nGSOTfWCsN4yCY=;
 b=Me6YNMKw0ujuakz/rE/NapG6wOzsokOIP+1unZM6btyHXGmBRIZchBZZgtzB7qqg7OnXcs7LUSPCZXDZoBsgHcEXf1MdmQGvjuwnI5+C3v2TZokQlqQNDsG8n3IU5BM7gxo6vZ66wHMRGPF4UGSCNrl6CTYd+QMY5wEeyedD4de/qA9H3Zo89zXlrPzYWIWaLhvp4llNPQByhO+3doPEwINGU+r5nJXwYi9pWt0KMns94jnDgKq72p+y+lS3Kx7ZE9m9OcxQpKh/VfxvUPMvBjhoshPz5flWEkNe5ievwhIXdocvCQ+fb9S8m1FQaGpps0b7wzKJrwBrvWu3vAq9+Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:18:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:18:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 03/11] nvmet: implement supported log pages
Thread-Topic: [PATCHv3 03/11] nvmet: implement supported log pages
Thread-Index: AQHbL6sZ1SBqpRLhG0y4T4PGHKpJlbKptpsAgAAAsAA=
Date: Wed, 6 Nov 2024 05:18:30 +0000
Message-ID: <1c6cc8eb-fcba-4043-90e4-19b9cecbc9e9@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-4-kbusch@meta.com>
 <004782ff-6ffc-4d28-9554-7d40266b2ec9@nvidia.com>
In-Reply-To: <004782ff-6ffc-4d28-9554-7d40266b2ec9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 69e8cbec-6020-4df9-f4e5-08dcfe2273d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Sll0WmIwaFZ2TmV6aUM0TVdVdUg1YzNSbG5hZ3hkQnkxak1DaGRlYm5neWZT?=
 =?utf-8?B?YXVYRUkwRmx4WFpMd1ZKNG1iU1BYTSt3TkdabXptUlE4QXJYWUVCWDZFUmxp?=
 =?utf-8?B?ei9VZVE4WXBhY1R6UWkvQ1AraXE4Q3IwWjFYWFM0YVVlQlRibmxyem5iQ2hK?=
 =?utf-8?B?OVRHazNxQ3d5TlM4MGd1bmRXcHJTT3hIUklpTnlqNzhPSlVLS3E2cGJ4U2pi?=
 =?utf-8?B?bW9hNXQvOTgybUVBdkUrSGdDSzVDSHlMcjVSVGxGd2pUZStzYWtNd2Z3WitR?=
 =?utf-8?B?SXBHM2JBNXVvSE9sYXp0dEF3VkFlODZ5dWI2Yy9CNUY4d2ZseUJMUk5SQXVu?=
 =?utf-8?B?Z2VNbzdidGlMUDJzTEthSytXNXJzRzBkdkxWRTYwRU9Hemk1Q1NwSG1yWkhr?=
 =?utf-8?B?YmNiZVZwTG1BNTFJL05OeG03cXU3ME9LSjl2bzB6dTFRcEtLYXlpc3lsa2d6?=
 =?utf-8?B?c2M4S2VvSjFSTThmNnhPTmxuTUNTa085SGU5Vm1vZFN4WlJYSE9PUzdBcW9J?=
 =?utf-8?B?YU1DNmhYa2NBazNMSk8zZHJoMmlvVmJxMjZQTUdoYWYxdTRSSm80U1pRL09l?=
 =?utf-8?B?a2Q1MFgrNWhPTW5oVGpVZG1oR1RvcVZ4eFh2QmZQbGpBUWVBM0VtNy82eEg2?=
 =?utf-8?B?QkZjVW0vZDhsUGNZR2pJVzhEeEJsK1JNRmVyK01DY3VmYlBJMVJMMkVZRnBo?=
 =?utf-8?B?d0FCeWo2VUlwR3g5S0x0L2lEVmxqSzlaa3Foc3JxL3c0OEJzcDJERG9GSWlO?=
 =?utf-8?B?V0wwMzVibkpYdnpsWkFMV0E2cUZKbWlBcnlScEpmdEdNY2tRZEM4NEsxN2E1?=
 =?utf-8?B?Q0duZldXNndlU3gxcmpaSUgvRHpNNjBZQkU3by9rZExGci9VL1ZqeFJObVYr?=
 =?utf-8?B?R0tMbi9KNm5GUXBQUzh4TUwvQTNZcDBrWWlHcmhNdnYwT0xiNmFsWGVSaGZl?=
 =?utf-8?B?OXExb1pwdmJXWUc3SDZsQWFsU1J2aldQeWhtQnc4bkR2aitHMDRRcHlJaUV1?=
 =?utf-8?B?Y0xQSFR2eVV5V21rNDRYU2E4bEY1MUNTTnQvM3VWNTQ2UWQxZWRWc1hvdkx0?=
 =?utf-8?B?VE56b3hhdW1GMWpQZ0Y0LzI3N1Q5cWJIWWR1a3ZJMENjZHdLaFRCU0xCT0cy?=
 =?utf-8?B?dTJubE5LT2Ezd095V21Rbk4wUFkwM1NQazZIeDN5Z0RsTW8yRUNkVDRHSzk4?=
 =?utf-8?B?Z3EwRHpZVXJxSEZnOW41QnRIRWtSMFM5L3ZRTXR0VkVrNzE4V0diZW9RY2oy?=
 =?utf-8?B?Rjlqd0MwOGZub0tkY0dGajlaM0dIVC90YmEwRHFFYS9SZXRNaEVLUWd3NkpZ?=
 =?utf-8?B?M3B6MWNuNTVRK25jZWlJWFQzcjlCa2FuZGQ5NVZHcmpEUjRIaFdsdXV6S3lr?=
 =?utf-8?B?Q2p3a3pPV3hGOExvSm84UzFacCtINVhzVTc1RGJ0NlQwTndTUXJQU2RVSGZq?=
 =?utf-8?B?bkJjbjIvYlpYMmttc0Z4VlArdnZFTDUzRWxSRXpnVEVVcjhnWnNZN0N3UHlV?=
 =?utf-8?B?RWNnc1pLaFVmZTE1N1JwamYzSkQzZERIUEpBcHJoSkZrNzZQSlBBbnVZT1F6?=
 =?utf-8?B?YkNCWG1PWUJINitubHIwZHdkOVBHTC9yNHpaSEhIR1laMTJUY0ZOeFFnRld0?=
 =?utf-8?B?V2N5ekRVNmU3SDJvTkVZbnlWV1RERmRlR29MT0l5amlsRUVSK2xvc00ydFpz?=
 =?utf-8?B?aWp1ekVlWVd6Q3JmUTBqMFpEYUM5RThXOEZoMjdCTFMvQXFzM2t2VG9ReFF5?=
 =?utf-8?B?engxeUZ0WElvOHRUWjkrMWhJTkdoeXRqeHhDSlI5UC9YMUQxSEZVS0xJOVNN?=
 =?utf-8?Q?VcGD/Ia+2KgUmvYpq1YToASyOJnFM5tn4yJQQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdQbnl1TERzQ3VSS1ZtQkpnTmcySDBic0xsNU1OQytGOEdCbHN3NVFaM1JN?=
 =?utf-8?B?ekxzWEJ1eWg4bVdBYjhXWGQzcUtvMVRJeWoyVkpLRXZpZEQ2ZlRrbkhLUHNZ?=
 =?utf-8?B?dFpZNkgxakN3djRFZlJwbDZWK09hckVYOFNlU2RDNHg2TDErOE9JdnowLzJL?=
 =?utf-8?B?TkJnTzlzL1FydlhicklTNG55NTZGWXp2eVNhVmUzcnNDRHZzd3hlMVFoNzQv?=
 =?utf-8?B?d2hZS0xMLzBBcms0NXN2dUIzYW11QmZ3aFJNeTA2WXE0bVBGVDZMejdYaEdS?=
 =?utf-8?B?d3NJY3FpenNaS1MvZGh2dlMxc0RWTDlYTzQ5TEk3Ym16TVJPUU85MFlIK0VQ?=
 =?utf-8?B?RkdsWGV3cDNGNkFLWWVwKzBkY3l6R0s1bCtXdFB5RnFlZHZSb2FRSllla0ZT?=
 =?utf-8?B?c1llNktTM3l0dHdtYWV2Zng2V096UTRTclIrbDJDcE50ek9EdEhZVFFRSTMv?=
 =?utf-8?B?QmM4UmNEY3UwSC9RSWRpenlZVWt0cEtmRlNnTlc1OVIrRFNLaXpCQkEzaGNI?=
 =?utf-8?B?VjhkNXdOYVR3ODJjZlVMSXVkQTJ3MkRhM1lUUno3andoay9LWXB2UFhjZnVn?=
 =?utf-8?B?Sms2K3BkVVcxUmoxejJVc3BlTW1GSzFEZFp0alFwTmdTSStBN1Nvd3ZuSUpp?=
 =?utf-8?B?RXN6TFNKTU5MVFNaUkJ2QVQ5dEpOQ2VZeTh6Mk5UMkRtTGwwalBVVUxPMFpw?=
 =?utf-8?B?MGk2QU8xT254WTgzUUdNVUg5ako4dVdlRDFkWGhQL3VrU2hFMzlYZ2Fqb0o2?=
 =?utf-8?B?Y3FwcTZTM3o1YzZIU0kxc3E5QXBIUWloMzR3YjkzQld3a2xaVjZWaFBMS0s2?=
 =?utf-8?B?Ni9LUE5McUZGcEdmM2Zwd1pkNTJCMWVnZm1MNEx1RCtkMkZZRUZ0TGNwM3Nw?=
 =?utf-8?B?YVJLdmdBUm1uTzhheHB6ZlY5UWt4ak5PTXNQOGI5RmlOQzVNdThyUTVZdzdZ?=
 =?utf-8?B?L3NpR0tRMjIra3hER0FKTHZtQnVJZ1Qrdk4yTm5UcUJMZ3Y4QTFmSGxjeHdB?=
 =?utf-8?B?MUs5RWttS1RHdzhSRzNBMVlrVkFENHo2eU1JZkJ0bzlDMjhPTG5yQ1hqblFY?=
 =?utf-8?B?eDhZVGxTQThvcmtiNVYrenh6OThuZSs3aWpFS2RiZXdwTnpnRHdkR0FMOGYv?=
 =?utf-8?B?RVRSYVVxRFQ2aWNzbDROY3RBTmJIUzN1WVlObFR1U3p5SWJ0dGVwSUhwdHNa?=
 =?utf-8?B?dVdTVkFoVzA1Rk9sVDJtbXFYM1RBaHEzMU9QOE1WRTFtVWZZNi9hS2hQOFEr?=
 =?utf-8?B?UlFmQUFpV0dzRWlzaE52djd0L0M5VWlmZVdEQnJha2wyNjJnRXNwaUhmRGJP?=
 =?utf-8?B?eWQyQ1B0SERLbkdtTy9EV0xzanQxTnE2SFZGRXpTWFMxMmt3Z0ZEeGF0cXMx?=
 =?utf-8?B?TFJ2UTRYcVFWZWVIY1lOSTZUeEJZQzF1Qy9tQ3JqUFFJNnNDOGFPT1d5aU4v?=
 =?utf-8?B?NzRldEZlcHk5cGwrb2pQRWFrc2tQcVNJa3BMVTFnVmZEbDFKcklET25MRmZU?=
 =?utf-8?B?ckdQVGdHQVNKUlZCWVZNZ0xZSktRNHZiNzRmYnNQc3E4OE5SVVNRR0NnMTU5?=
 =?utf-8?B?czlmNWIrYnEzMDVnNEZZNHJ6b00wMlJGTFcxVEErK3dlU3R1NEhEYTBHdXdO?=
 =?utf-8?B?ejlQb1RQTG1XZURJNDhuZm1GVGZ4SWlFRXRBaXZzZzNGMTNjYk15M3ZxcnJn?=
 =?utf-8?B?U0JMNTE3TndGVURHVmJqekhoK054dHY1L0sra0lyYk5DMVA2eUxKR1NDYjRz?=
 =?utf-8?B?TmZGUGZkUFN6TnRzYzhPbndHd0xVOEQ3VEFpeDZ0VlhpTmp2SStibDJobnJi?=
 =?utf-8?B?Z0JxSGpRcmI0SXVZZ0J1aDdTbXgxQWYrVWhOT2VpdmtPMG4xbGw5Uk0zVTFB?=
 =?utf-8?B?ZWVaOE40akQzVDg3NjRTYks5ZFA0SDBXWHBnS3JqMjJaYy9EUHU3bUNHTjR1?=
 =?utf-8?B?amZPYjMzQnR3R0JpZURKZWN6UXBMZTA5OHN5TFIxNjR1ZHBZV3lIWTdKTmJy?=
 =?utf-8?B?a1RjOHRyMFRiOE0xZC96STQ2N3p3ZlU3VmZXcmgyZEZjUDhneC9FQnUvZFFD?=
 =?utf-8?B?amlYbUkrUEdXRGdnRE0zVDRBelhtUVRya1RhM2hTb0ZmUk00NGwxdEp2bU1l?=
 =?utf-8?B?aFhLUkZtV1BrcWR0TWJJc1BVSE9wTmRDV2FtUXZwK2g5M0huNkNvQTJVYWdR?=
 =?utf-8?Q?4jYWtdtssJP4uMhzmmodSj09TR9g2bKGWXo/JDNrDHCK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B9D4306B1897F418F4CCF76072E7248@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8cbec-6020-4df9-f4e5-08dcfe2273d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:18:30.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2l7VNILxEy/G23JiuAuN4KyN+RclK3o5tag3tk/G2OM4GLqy9Kr8y33OKKixb3IAIM7M27O1+TcVQzu9R1yag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_211838_115573_9C57430A 
X-CRM114-Status: GOOD (  15.63  )
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

T24gMTEvNS8yNCAyMToxNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAxMS81LzI0
IDA5OjQ4LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IEZyb206IEtlaXRoIEJ1c2NoPGtidXNjaEBr
ZXJuZWwub3JnPg0KPj4NCj4+IFRoaXMgbG9nIGlzIHJlcXVpcmVkIGZvciBudm1lIDIuMS4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+IC0t
LQ0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYyB8IDI5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+PiDCoCBpbmNsdWRlL2xpbnV4L252bWUuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMg
DQo+PiBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMNCj4+IGluZGV4IGExMzI0MmU3
OTFjMGYuLmI4MjI5ZDZjOTk5OGQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0
L2FkbWluLWNtZC5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQo+
PiBAQCAtNzEsNiArNzEsMzMgQEAgc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9nZXRfbG9nX3Bh
Z2VfZXJyb3Ioc3RydWN0IA0KPj4gbnZtZXRfcmVxICpyZXEpDQo+PiDCoMKgwqDCoMKgIG52bWV0
X3JlcV9jb21wbGV0ZShyZXEsIDApOw0KPj4gwqAgfQ0KPj4gK3N0YXRpYyB2b2lkIG52bWV0X2V4
ZWN1dGVfZ2V0X3N1cHBvcnRlZF9sb2dfcGFnZXMoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPj4g
K3sNCj4+ICvCoMKgwqAgX19sZTMyICpsb2dzOw0KPj4gK8KgwqDCoCB1MTYgc3RhdHVzOw0KPj4g
Kw0KPj4gK8KgwqDCoCBsb2dzID0ga3phbGxvYygxMDI0LCBHRlBfS0VSTkVMKTsNCj4+ICvCoMKg
wqAgaWYgKCFsb2dzKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlRF
Uk5BTDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0K
Pj4gK8KgwqDCoCBsb2dzW05WTUVfTE9HX1NVUFBPUlRFRF0gPSBjcHVfdG9fbGUzMigxKTsNCj4+
ICvCoMKgwqAgbG9nc1tOVk1FX0xPR19FUlJPUl0gPSBjcHVfdG9fbGUzMigxKTsNCj4+ICvCoMKg
wqAgbG9nc1tOVk1FX0xPR19TTUFSVF0gPSBjcHVfdG9fbGUzMigxKTsNCj4+ICvCoMKgwqAgbG9n
c1tOVk1FX0xPR19GV19TTE9UXSA9IGNwdV90b19sZTMyKDEpOw0KPj4gK8KgwqDCoCBsb2dzW05W
TUVfTE9HX0NIQU5HRURfTlNdID0gY3B1X3RvX2xlMzIoMSk7DQo+PiArwqDCoMKgIGxvZ3NbTlZN
RV9MT0dfQ01EX0VGRkVDVFNdID0gY3B1X3RvX2xlMzIoMSk7DQo+PiArwqDCoMKgIGxvZ3NbTlZN
RV9MT0dfRU5EVVJBTkNFX0dST1VQXSA9IGNwdV90b19sZTMyKDEpOw0KPj4gK8KgwqDCoCBsb2dz
W05WTUVfTE9HX0FOQV0gPSBjcHVfdG9fbGUzMigxKTsNCj4+ICvCoMKgwqAgbG9nc1tOVk1FX0xP
R19STUldID0gY3B1X3RvX2xlMzIoMSk7DQo+IA0KPiBiYXNlZCBvbiB3aGF0IHdlIGhhdmUgaW4g
bnZtZXRfZ2V0X2NtZF9lZmZlY3RzX252bSgpIGhvdyBhYm91dCA6LQ0KPiANCj4gIMKgwqDCoMKg
wqDCoMKgIGxvZ3NbTlZNRV9MT0dfU1VQUE9SVEVEXSA9DQo+ICDCoMKgwqDCoMKgwqDCoCBsb2dz
W05WTUVfTE9HX0VSUk9SXSA9DQo+ICDCoMKgwqDCoMKgwqDCoCBsb2dzW05WTUVfTE9HX1NNQVJU
XSA9DQo+ICDCoMKgwqDCoMKgwqDCoCBsb2dzW05WTUVfTE9HX0ZXX1NMT1RdID0NCj4gIMKgwqDC
oMKgwqDCoMKgIGxvZ3NbTlZNRV9MT0dfQ0hBTkdFRF9OU10gPQ0KPiAgwqDCoMKgwqDCoMKgwqAg
bG9nc1tOVk1FX0xPR19DTURfRUZGRUNUU10gPQ0KPiAgwqDCoMKgwqDCoMKgwqAgbG9nc1tOVk1F
X0xPR19FTkRVUkFOQ0VfR1JPVVBdID0NCj4gIMKgwqDCoMKgwqDCoMKgIGxvZ3NbTlZNRV9MT0df
QU5BXSA9DQo+ICDCoMKgwqDCoMKgwqDCoCBsb2dzW05WTUVfTE9HX1JNSV0gPQ0KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdV90b19s
ZTMyKDEpOw0KPiANCj4gaWYgeW91IGRvbid0IGxpa2UgcGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1l
bnQuDQo+IA0KPiBMb29rcyBnb29kLg0KPiANCj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQo+IA0KPiAtY2sNCj4gDQoNCndpdGggdGhlIHN0YXR1cyBm
aXggZm9yIG52bWV0X3JlcV9jb21wZWxldGUoKSBvZmNvdXJzZSAuLi4NCg0KLWNrDQoNCg0K

