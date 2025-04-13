Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DED3C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AS40XgnoRrzjLUv++I8DyeitJeJjvFBq8IGb5NXUz1Y=; b=kAUWw4kP2rG2Wnu0v0GjGU8xG2
	EajsQynIbEbhfBl7Pes4R1IYX1Tbj+Z3gw7uMT37prtkzlusSJ7UMDQFHiyKyePqY/7BhGSEy9QhY
	AIy8GTnRE9/BurWOH5Znlm990ZK+xavt+jvH/jxGF5G9jI1auNgzJJwmUPxH8UEjg7eRiXwQAMuz1
	LXVS96hHLz9xvVg7E60/0jI+W8jQv6c/IjZjNnBMXtYXrZUd8prGsYiyb/0eJIAsro9itQ6dBjXbr
	0pETsE17CCgmPTBZfqB8dAxPxYFvNgozsjL1kXfP+c7q85xy039vrv/BhA4/xl/kaM/kEqHXkdkEY
	qC8PX3qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u43Hp-000000003K5-4Bus;
	Sun, 13 Apr 2025 19:46:38 +0000
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com ([2a01:111:f403:2415::617] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u43Hi-000000003JW-2yWN
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 19:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9QKOfBEhkRiBlRuXM5wUXRjBqhsawKGTvrn3elXyRwpvl7bbkPwz1/M+odi/fAHBHhEB4yHBSu5CJXOIcp1udDvmNVYmhqR31K8az1p/MX2KBSM0C154XpjZvQ+RjUVcVZIzoz1IHimVnsXwH/oXeWHTzTORjgFcIQUcdzk++d79hgrEs39V90r5X35MfX+RoP8x9cOJCflCn22nYamZvRaTt0a9CHSq8fXpRW/CSilGccaESL3XPT7WLfoUy6wlxlZXQRwwBX6r9rn6321h1fDeWm6zmBpNadRgYFiWk25y7YUcqpXz8bHH4EEWxJIX2WhsReSbsN2UQY1su0oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS40XgnoRrzjLUv++I8DyeitJeJjvFBq8IGb5NXUz1Y=;
 b=Ip7Wz/KjV/b2Qr4eZ11dfyJVTbYCeiRLPOQTx/Be3FHWjZtODX2+MPA0lKwlT0ekzjpUjlzr5bMjPOHoGI5D6tQcYuWNwFVOhSbwp5iZJXiURPSPiaCaABTeFQvEg37p+Amy4N15d6qdsk87BmGLJS5dHcki3/AcdxM7iRYEE+jEbcoayur/ZXxmDH/xZZkBLR1K42bSGpefWhd2tz5eI/kIkz5GENsOLJgcS/I4OP3GwPpKZLTtJ5878nRRBdj9WveWX6olGsp0ZmBZmLBbfRP3/n1mmWSMrCi6hiZaEriNQQ5qIo7CxQp0vqd6rPaXrXJLMrbUe4NPzixhRo03aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS40XgnoRrzjLUv++I8DyeitJeJjvFBq8IGb5NXUz1Y=;
 b=MMdgExQcHOYsrKIYLHtfLL1Mkhb7P2KtKtlH/w1NsA9HwTyp637dJ8lU7Rl4bshCtwaNQyCKYkvCDjNwuCuwSEo2Vj0jv+byxXiNcCWBQGTbU+kZ1qcuntC8JbjMQmUKsC1QmRRklCILxfUEYbsebGfyu5HjY/48w7VMx3kzboz1eTW+tG6NbgjUFQeitXAb38CdoW5dej1AtiJ0hi/EwiwJiA5sX/bR4X6KU8lSrKPiWyaMpwrmpjf/jtTapHx5hMsii3oZHEj7FMVpaiTlLjX2QBjos8fUqWncAJ1cX3eEbLzRSxpA39ZR8Nh/4gJ5QenmKHw6yRqC5oo7dsPI0g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sun, 13 Apr
 2025 19:46:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Sun, 13 Apr 2025
 19:46:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH] nvmet: auth: Avoid sparse warning in nvmet_auth_sq_free()
Thread-Topic: [PATCH] nvmet: auth: Avoid sparse warning in
 nvmet_auth_sq_free()
Thread-Index: AQHbqn08Xc/w9D8anE22GnUyVQfHz7OiBHmA
Date: Sun, 13 Apr 2025 19:46:20 +0000
Message-ID: <a3f01160-b5db-4b6a-87e3-1ada7d9ddce6@nvidia.com>
References: <20250411010015.1017829-1-dlemoal@kernel.org>
In-Reply-To: <20250411010015.1017829-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6222:EE_
x-ms-office365-filtering-correlation-id: 87de4b84-2c04-44f0-0b26-08dd7ac3dcfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UE5pZmZwRzdKMnhxUDB6WlRnT2dMUG1KdlRQUmQvZGtpNkZhQTRTNDlNK0Ri?=
 =?utf-8?B?ZTdESDR1bWlkNE5aek5NZ1o4OXZaY0FkdmpSQitnSEoyTFBWcEduaCtVaHk4?=
 =?utf-8?B?cWZBQW5GbktuM05Fdi81REJtWGlHc0RZOGQrYUFNZllIdFdrWnV2NHdnbFlx?=
 =?utf-8?B?bEE1b2FrRnpXSCswMHludFJhR01pUHB5RFB6eVdGWE55eXlkZXZoamFlRG1z?=
 =?utf-8?B?ZUNIVjFmMVVrVTJBN0lrOHZlNkxDZ0xuQUhYZFE4ODF3eDFTWlcvTTlaUWJh?=
 =?utf-8?B?MWtaTHBiNlFBbUs5R3hyU1VQY3VYS3d6Nnl3SXI1WXphR1NsbGpQdUk1dlVX?=
 =?utf-8?B?N2d2RnlaTjRXNmhjL2JaMUR5b0MxdTI1ZXB5MjhKNlJsQ3NFZkdsbDRJYm5J?=
 =?utf-8?B?ZU4xcGhqOHQ5N0JUVEsvZXQwSkkvYzdFTHMxeHJCK0w2cWc4OUNBTm9jOThM?=
 =?utf-8?B?aFJMK0dkS3hrTXdsMUUwY0kzMU1Zdk0wRUdRZkMxQW5jajVITG1ZV2IxSjVi?=
 =?utf-8?B?Um9ZMDBJLzdpL2JlUlltRDMrU2xrbzdOK0NnVlBNc3RacTFHLzZZa25MdTA2?=
 =?utf-8?B?bjRJTWtHUDVWZHNpaU9aSlZwUEFCcVJuTEVSYnhOcWVSOFlqaFdIYmdYVTZI?=
 =?utf-8?B?cXhreUl5RmpmYlRSazdGdCtscWpFMDl5ZXhRVkpMek44Q0RrOVlYeDQrRTd1?=
 =?utf-8?B?SVJ1SXZvU1pMNVArMXcwUjN3NjQvZmNUOVpMYUlvb0NhUjNGcU5ET0x1NWdT?=
 =?utf-8?B?Y003eFJuZFFPaWszOUVwWHBqRmp5elpoR2FiWWNzZnNBc1ROam1DWUhWZ0N3?=
 =?utf-8?B?bkdaN2R2ZG1manUxa0RVQW1UdlNiSW5BKzJJMnB2QTVlczFaSGJ5RkU2ZklL?=
 =?utf-8?B?YUlHSHc0akxOZHJCZy9JMVZNelhOdzJDRFA2blNSbEN1TGpGRjlXY0FoK3FR?=
 =?utf-8?B?MjBBVTJLTlg2eEFES1I0bEJIKy9hakhUemgvOVN0MFVHOUFNbEo3N1ZpOXhi?=
 =?utf-8?B?K29FTENRMGVZYVRzTGxScGtYODZ3dHE3a2lta1pTZm9hOU85SGcrc3RJYzlD?=
 =?utf-8?B?SWpQN3cwVHBPcHJaRnNwN1lCTWtEQ3hWZVl1YVduZHozckdENGZNZmpKNzU3?=
 =?utf-8?B?N0U0dlVyOVFRdWJYRTlJeGVsTGFrRjVROWVKOEtSQkxrTnpCQUZwZSt4Y3ZB?=
 =?utf-8?B?VkRHRFNEc1lNRDJNZ3lwUzNla3hjdjBQMDIvZjJGMndrTGhjT0RSYmxsODkw?=
 =?utf-8?B?N0JPMHYrV1lWNUFNNEttRUhzdURlUnlmL2ZMRTJkcVM2WDJsV1RqU0QzZ2FO?=
 =?utf-8?B?aTFmLzdSWTRxRWN6U1hrNWtMYWwveEFXVHNIZm1QMCt5Tkw2YWZZbm1yRnU1?=
 =?utf-8?B?dVhmRWJnZ0Y5cHhyS1ZjMEJWVGpPVzZ0NlRnc2lCMW0xcnFnNGxWSHZGVEZl?=
 =?utf-8?B?K2dub3V0QTMrRmJvemxiWk5KZXIzTlZhYUc3aU14S3R2b3ZoSnVIQnR1Tkt2?=
 =?utf-8?B?U0VvVFI2RG9OYmh4QVlVRDRLSlRZRGY0WncyZ2hRei9PdkRBVG9UR0VmT3Y0?=
 =?utf-8?B?S0FJSm5JenBIMUJRYnZFWUVnUHFEUkV2TFZVMWxVWXJIb3lNaERIdkJLSEMv?=
 =?utf-8?B?TlRtR0ZFYWJjKzMwd3VkR0ZRZzU3a2c4U3FpQXJsMlpOa0hWc1BTMC9uRlIr?=
 =?utf-8?B?NzZyMGZMZW9nd3VhSlFMZDg1YzRmY0U5SFN4MW9VZ0lCb2ZqREsrRlVEaEQ1?=
 =?utf-8?B?bFlQNk5pUjhJbjVXQ3c2SWY5clRhYlQydi9pZ0U2Qjl0NHh2L2FndUlDQXZS?=
 =?utf-8?B?R0l3Q0pXSmR0ZDA5Y3JEbHQxNHdFU2xpZWdtU0t6cGo2SG15U0diNDhVVng2?=
 =?utf-8?B?R0FQbVJwOGpwSEw2cG1VMnozTTNrby90c2pySHpWNlp2eVVNRGFyOE5VSU8z?=
 =?utf-8?B?Z1p0VldIT2MySTdpZWJsSnJoVStBbEQyVWhwK0NjRHhYQWZhRVRNcVljRElG?=
 =?utf-8?Q?QPR0jHykuu3VmQLY+FO7WRUyfPViX8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0dCMlI3ZDBMZEE3Z3VIVWpkUXRXK1BzSklMWmd3WmhiUDBCQWFBY3N2MUZR?=
 =?utf-8?B?ZnpETVMyRDNSc0pJQ1hKbG9OUGdndWo5UDI5dk5wbVAvTmJBMEpmWTRPUlV2?=
 =?utf-8?B?Uk1TYjA2aGpxMlBjQ2tTUi9iODJQQ1d6OHVxRlVTMzlkNlBrT2MrTm13MUJY?=
 =?utf-8?B?QzZpYkpMWXl3b2U2ZWc2dmVZeU1UNGtYSjJyTDQ5amRLQjlDb2dBYzJIR1Jz?=
 =?utf-8?B?K2l6OEUram5LakVlTU8ySGVIOHNLSW5HZU41dE51dVZrTHZjRm1ROHp0Q0p2?=
 =?utf-8?B?TTl2ZTJnUWNTNTZBMzNFSldDT3RpSmlDeXhoazNrd1N4Y3pSRlBXcWg2dzdX?=
 =?utf-8?B?d3FHa3hiK2swWGFuT3luUTFCV2hKZGsvazVteDAwTXhLMjlBK1hBWTBhZlVj?=
 =?utf-8?B?Nld4VExzZ3FzeldINU1jS3VjTStPbUFRTDRwd3ZBMEdzVFZMZXFCaFo1d3BC?=
 =?utf-8?B?NWRJQkxIeWNFc2llNE9GVWw2aC9NR0czZzc5OXVHUFY5cEN5REp0RVZwcWF5?=
 =?utf-8?B?elY2Zk1EajdxbjBTYlJsQk81d0FEOTlpWGtpS1NXdGcvZFdORGlQWlVtVTl2?=
 =?utf-8?B?bWZyd1hpZTA4YitzQzlKbWNyMzRuUm9uNCtta1FiTnhCUzFjWkVwQmRHWkhM?=
 =?utf-8?B?QVNSa25ETWhhb1pNSW9idENQaEFKVUFBd2JOcVlHVzgyWGhwVmVYSEJRVVYz?=
 =?utf-8?B?QVRicXFVdTU4M1JQMjlPd09nVUt6WEZLTkd1NWZDQ3d5SDNCTDJzUkQvSTlr?=
 =?utf-8?B?RXRQemN4Q1JjYnJjS3ZYSXR3d1ZQbnR6RWZpV3ZDWExxRmNCempmOWRneWUv?=
 =?utf-8?B?cEgzUVBuelVHdzRsY3R5NUxmQmNpR3UvZTBrc083ZDJkU1lvSDJvMlpnd011?=
 =?utf-8?B?ZnRMYllyNHozSWhLLzM4akdGYVFrVCtBdGw0QXVoWk1rSCtNc0hkcGxJelRp?=
 =?utf-8?B?RWltY3Z0cHFjL29HYlAxM3M1NGJWYzVodmhETGxJekxQMUJkeDdSZ3U0eXkr?=
 =?utf-8?B?VHVaY2xNRmorQ05LVWdKbXNDZXMvQ0Z4dWYxM2t4L3hTMEZ2YVlVUGcwdVpj?=
 =?utf-8?B?ejVFM29rb0xybkNjNjNjZDVHblhiRVhEQkZmakM5bVhTRlE5MjBHTlIycnNP?=
 =?utf-8?B?VHMwcW9wdHBoclRpYm42ZGZBOHFJbGxkRTljbHo1S0NoR2ZyQWo4c1duekJo?=
 =?utf-8?B?OHZvQmVzVU92a1A4YWFNYXN6TUhRV0FCZ2xzeStIeXUrcktJa0FUSWI5Vndp?=
 =?utf-8?B?dmJza1FJU29zdzlSOWs3U3M3YlN4L0duMWF0aDRlYUpCTUtmOElpTXYzOVlk?=
 =?utf-8?B?QU5PSEhSczhpVmZFakdoUisyUXNPNWNoUDQrRzkvYVczOWE2OHdLZmMyZEQz?=
 =?utf-8?B?YjZsTVl5dTdKdlVOQUdQSEZncjFHMHVVVk8wUTZOc0ZFLzkwTU5wRzJ0clU4?=
 =?utf-8?B?UXFPdnAyOTJoZWdZN2JnMEFCdVpSNzJRWFVqZHFBZW9YQnVOMUREVWVkWEcx?=
 =?utf-8?B?TGM0dkxmS2J2RzQ1T0J3MENRcEovQXVlQTNOTWpYSUJHSzZ4aVpPaFdIdjZm?=
 =?utf-8?B?MzlqbFFVN1FKR3NuM0FaZjFTYlJyWDBvVmtBV3NuN2o0Nkpnd3k3MUh2L3ZY?=
 =?utf-8?B?Sk00UTUrZjdZdGNlbHNIb0dSQnkzZkRxODMreGpnc2pNVFgrWXg3WmFudFNp?=
 =?utf-8?B?U056VDVhT2JBNThraWNqNTlpckhPWm9IdXVPME9KeDdZTS9ZVmI1NTI5bUox?=
 =?utf-8?B?akJoRlF3dlA1NGxFRlJmemNYTWd4ditIK3hXbmpwcGVYQW5BbFk3TG5aOHRU?=
 =?utf-8?B?d1ZkR1NtUEF3ZmNzeEMraDE0eEFOWjRkVnM0ZjNRWFVNSGprT3RtYVVhQ0FM?=
 =?utf-8?B?WEJRNDVaRWJqTFpvVVVOeFhwL1IyNVRVTU9IQmxKYUtrcy9IcDBWQzNTc2Q0?=
 =?utf-8?B?T1VEWGF0TVp0T3RRQVNoVmdlSXlVM25MYlFnZFZJL0FUNllPeDQ0SlhpWTlC?=
 =?utf-8?B?YUVsbWZPN0tuLzYrcnVFTXJHaWRlbnFadlpWZFJCdjBETkJHTys1MUJGU1JO?=
 =?utf-8?B?dDE5RTNjVmQ5K0JpMzJ0SFBPOTBhNmRpU1ozQWNqUlpuaG9tY09GbHA4RlAr?=
 =?utf-8?B?c2tRVmh1S2lqR2hKdFpheEZkcm1XUENCUVNaekVnU3VLVTQyMmVlK2NQWHJy?=
 =?utf-8?Q?ROW4URkCbN0bFlDATtby5MWZyiFg65XM1J1qmoEL3scx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B577B5569E2345B59BF1609178F34A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de4b84-2c04-44f0-0b26-08dd7ac3dcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 19:46:20.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhlTnKZGV15Eu/Wk+ghOlqH+RixQXfGPe+O/KqF+qv09K+sHct+X+NMNm9K+1sDUVK5Gwna9WSZDMVrVIMa2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_124630_767136_12C25BA8 
X-CRM114-Status: UNSURE (   7.88  )
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

T24gNC8xMC8yNSAxODowMCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFdoZW4gY29tcGlsaW5n
IHdpdGggQz0xLCB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nIGlzIGdlbmVyYXRlZDoNCj4N
Cj4gYXV0aC5jOjI0MzoyMzogd2FybmluZzogVXNpbmcgcGxhaW4gaW50ZWdlciBhcyBOVUxMIHBv
aW50ZXINCj4NCj4gQXZvaWQgdGhpcyB3YXJuaW5nIGJ5IHVzaW5nIE5VTEwgdG8gaW5zdGVhZCBv
ZiAwIHRvIHNldCB0aGUgc3EgdGxzX2tleQ0KPiBwb2ludGVyLg0KPg0KPiBGaXhlczogZmEyZTBm
OGJiYzY4ICgibnZtZXQtdGNwOiBzdXBwb3J0IHNlY3VyZSBjaGFubmVsIGNvbmNhdGVuYXRpb24i
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQoN
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQo=

