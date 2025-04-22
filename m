Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FFBC369D8
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fLt5y7Q2TauyY3rMtSVsSoKqJ50zKhTI9P4mHElDlJI=; b=icy0ZGO7MsKO9KcEH39tgEtxlH
	v2xWAKuOVHJ75tKYpkRYkNNZ4FTC7/nccizfcnHLZVDjVwxn6JhY4ftuJrtWNqVNw12rpmNBVFMgl
	mIkOHMFHswrGkQp4eOal/8zprynCmivLAt/NexfvJjeH6plIrPhKZsDdW7Sv39ymXWX2CaaeZjs4M
	kPNscGochN+8tDMMmmIp4t3DNM63Nmg0WXMCQWNA7tSAwgDH3b8bkprqaLCwACs0tFiEIPfwzQ9PG
	hI4u/szScU0QUOFsaRo8M0XZQaPxeBZI2Pta+ydqUvY+lerPgAy1A75weWAJnyipdCCZgq5GNXyUF
	jKxZggKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77AN-00000005xxR-2jG0;
	Tue, 22 Apr 2025 06:31:35 +0000
Received: from mail-dm6nam12on20602.outbound.protection.outlook.com ([2a01:111:f403:2417::602] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u776Z-00000005x7e-2wLU
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpGw+GYPb6ut3Nr10T6G7FGiI1Z2jSzUM/HerQ8V4mlZfeww4HDc2as0UgYh4irXVLdkIUF/267EvniNEp5FWwmsjSnaxtIk5pXoIvOi46Wi5LthgetaayiAGpb/qM9jXgjLO3V73aampNWAc9K5SI4qeY+OWb6gbEUjujweSsrStPYRZrtwhTdJdckO91lKcDLbFjQfsuBwC1mboaybkupldKA/CL6zePtI54HGPiCUQIkgjioPtMWi6FJuc5ReRH8j1FQxR8x62KtMm92SndXVOskV3rgs7Dg6OVqJAudXs2XKT1xSHnXu63WLLjil6lnP3Ayw47iA9beWODPmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLt5y7Q2TauyY3rMtSVsSoKqJ50zKhTI9P4mHElDlJI=;
 b=ZgW7jVc6Xpy/dDTflvIckoijJUaSQZOELYZvVLFJH4hrAssYEx3ec6zyVmDp/pmIA/R3A9TOHltdl2AEfqq95FX/KuGAUgodsoEmbZ2BPgG7gDbRgmqyhng3j6jixZQB7obFjGzcLDQ+S1cNnSgT7ja4FXkT9mWJe9xIHQjWMjKx4ZVM07zs4rZVfGUhrxMo9Maike1CjCAfD/narWK/ihHKZZOT7Dz4scIUVbBXXyl1yufAeuAzieipz58IE4NkpDuaHqavCHPSi6lXKjzcs9qgU8ZqKQpfRJg4TbWVLwFPUsPL02IveolsynBqwpMQBAjjY28bVvhEJiOC5sOWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLt5y7Q2TauyY3rMtSVsSoKqJ50zKhTI9P4mHElDlJI=;
 b=WAxscA7P7pxKsyfP/hBNRYU8CjBiMyzhNcKjFJk6KpIQMcxv79Blyh5BICxpHIGvIusXbdvFv9knUv9ZMly5s4lDULOrGoOY8nTVy4GUwqJ+lONb3854udsjQzDDHmM4gmpS3q1lBMTzly/BUHcCtaooFlFZA2wDHo62Dipuv0b3WdsVj61AhSPDIdByg4mcrDSn3U5fF+QgfDkUx+DNOv8PB9DANpT1lN54sWHuQqrg9HuALYmPD/P9xoCnfa9L+hUZifvpxtr9CBY3GDDuO3wIi8OiFtZ45HkAh3ZYSX1Upn2G9zAXhcHC+JU+/2zNjthBCif8UY5e6PE5Ieo5WQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Tue, 22 Apr
 2025 06:27:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:27:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Richard Weinberger <richard@nod.at>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "leitao@debian.org"
	<leitao@debian.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"upstream+nvme@sigma-star.at" <upstream+nvme@sigma-star.at>
Subject: Re: [PATCH 1/2] configfs: Add CONFIGFS_ATTR_PERM helper
Thread-Topic: [PATCH 1/2] configfs: Add CONFIGFS_ATTR_PERM helper
Thread-Index: AQHbseGwl1W1guWf40yI5cvTVB/v4rOvO34A
Date: Tue, 22 Apr 2025 06:27:33 +0000
Message-ID: <8743c546-5407-4fb0-92ce-6337dda9fc42@nvidia.com>
References: <20250420104726.2963750-1-richard@nod.at>
In-Reply-To: <20250420104726.2963750-1-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6170:EE_
x-ms-office365-filtering-correlation-id: 175e60be-aefc-40cd-2b76-08dd8166c40e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y3BGcWkxeGgveDdMS2haMWpTQm5Dd2VncGRMcGMwNHBxakxNY2JEZnFTc3Nr?=
 =?utf-8?B?aEVFcmxUQjlvN01SMEpuVEd0MjQ2NFJWSE85T08xOVRseWY1eTJqWkVtaUlN?=
 =?utf-8?B?bkhGcmNPRHl0WEdUMzhtcjZNcGMyaURmTnMwRDgyemlMNFQvM1FXTWVwKzlR?=
 =?utf-8?B?YzFKNmRlWTZWNGlUNW5aSk1iMlorU2NzNUxFY3E2K05SS2VDOUQwNHpaOVFi?=
 =?utf-8?B?RVNUQnFiblg2RXVWTTdDZzk2Ym11QVZWbWJzeFNpaFRuK0VtMXpLVFppalJP?=
 =?utf-8?B?eWpkVThsSkoxa0Y0Z0Z1ZTB5a0NMSXRlenROWXhDMlhFK3psTWY4RzJhNmha?=
 =?utf-8?B?REQwVDNuNUZzK1BBL2tHeXRPU0VqSnM0cjJ4b3MrWGdtZm1yK3JScFUrNG4z?=
 =?utf-8?B?SFhOYm1qTFk0cHgxR2ozdEsxVFpob2lNa0daSlc2cnNnbFU0VDdYWUhzVHc4?=
 =?utf-8?B?YkorWGdwOTgxODFYNlgxR05pV04xaGU1U0x4MWIyeEF2QlJOSE1iMU1WNWNW?=
 =?utf-8?B?ZGQ2V05QSHBLOTF6aHQ0T2dlcXJHM2RISnBOT3lSL1lDV21yMGppbTFZQzMw?=
 =?utf-8?B?T3VSSXZodmI2ckY4TUNrM2Q3UFRBSHFZa2lJNVNJK2JPdjBoNEY2dTV1SWVS?=
 =?utf-8?B?VHhKdTArK2lpWHVRVWY0WUtCSlVRQzNNN3NsejR4QjdXL0RRQURubHg0QlZF?=
 =?utf-8?B?QXZTNVV5K2tMdTk4cmNCd3pLWFNMS09FRWRtL25HV1QyMUtndGpyZ2dIWnVz?=
 =?utf-8?B?dDV0VmFKbFZmd3g5TWFKOG0wRHlNbDkwY29QYlkvelV3NmlDbjZuRGRUV3Bs?=
 =?utf-8?B?THo1TmVCT1dkWnI4ZmE0V2Z2eWVJY1haOEo0aEhpbkM1OWg1WGZYbS9jSkEy?=
 =?utf-8?B?MWhVTWN0b1ZiK1d6T3pBajY0NkdCaGYzaUQ1eUhiblhnVzBTRk1KdjNPdVJH?=
 =?utf-8?B?UU9DQkpPRE5WQXBRY1hVQ2EwZUJVRVBtdzBCOWpCN3NEUkd1cFhNdFNSVzhT?=
 =?utf-8?B?N1JlakJPaTFBcDBrMUU5eVA1dGJzTVhmWWp6d2FEYWhuL1MxUVpEWmx6Qmt1?=
 =?utf-8?B?czIrbGJRbEhrUk11SHVBd1V3NW0yalVNQ1k0T0k2dG10U2p6dVhLSUhQbTdJ?=
 =?utf-8?B?K253cTZoWktSNDlsWGUyaU5QZ2szcGRkLzRyNnVpbVJTT3JuR05kZDhVN1Nj?=
 =?utf-8?B?Qm8va29ISldUUUdHZXJPcG5Ud2picFJXYmNyVE5PTUUzM3dRVXNqeUZVU29I?=
 =?utf-8?B?NWJzYmhmK09OQTg4M0dlYngycU84YUY1TU5KTHRra05PVHROeUdoT0R6VG4r?=
 =?utf-8?B?WHFqZjI2OGxrL1d3THR1ZEJhMVQrMHZOcFpiVll0ZjNsdVo2Vi9YMWQxOHFn?=
 =?utf-8?B?MFpNeWs2MHdSZUNVcE8zSUNYNUFFUU51MnRUSEtLMnRYbUM0WGpaVUV6VE9m?=
 =?utf-8?B?OHdhZnFFUjF5V2xidmRUSmJuRk0zQUwzcXNCRnRlT2JRMFMyVWd6M2dtZ1FZ?=
 =?utf-8?B?RTJLRXZSZDlkdjlMVjRPWSt5MENNbm9xcktBcVZyK3NqR2FWZks4V09OZDhU?=
 =?utf-8?B?cGhuM2R4dDE4THltcVdsWlNjeTRtRnpRbUR2T2M1aEhQNllGVnFsdVRtdndT?=
 =?utf-8?B?OVc0M3p1SlpJTVFJVm5mU1VMVGRGNERXM1FtcUJOYmpzWUZrNUhjYURxcDc2?=
 =?utf-8?B?MG9MVEZ3UjZOZXAxZFhBMnBxN2MwVWtJcUwvVHlRM2J4MVNmVGRtZVNWaktQ?=
 =?utf-8?B?L1pNRU1PWEUya1ltQ0FFakpKenBwK2kwQklTN20wcDJiOEJnNnhzMndEZmJB?=
 =?utf-8?B?QWNRVW9EQ2ZEN3BPaXVtbkJmT0x5b1kzNTBvREJzd0VYR0d3dVdCSXZ5T0JC?=
 =?utf-8?B?UW9INUZoTkxmaU9VaFc2eU0vMXprY3BHekVxQVpjZTR1RFhXS09VVzlkckM2?=
 =?utf-8?B?bEdGT1NqMUNUcllvM1liK0dmUzZQV1BhbGErb0hEVTVXbFh0NVpUcDZwVUY0?=
 =?utf-8?Q?0KtmwolWa+ViAIYyhME2TOvbcHldh8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0FuTnFrMUZDdWdidSs3RkpJc1ZDb2NpMC9LUVFMS01LaGJFVzJMZCtuWktT?=
 =?utf-8?B?UkprcS9KMVZ0MjFvSGticWs4eFY2RThKUkVYM203ZjFJVUdrT3RRUC9YWWJS?=
 =?utf-8?B?dFhvZUtOeFIvR1BtTTN1bFdaenZ0eXA5cHpQQXpJbE5QQTU5WXg5SmtnaDZo?=
 =?utf-8?B?djVyWWNldGFLTDdqTEJCQXFNQ2VlcTFPRitsSnBlK3ZkR2lzT2NEdFRKcWp6?=
 =?utf-8?B?aTdmTGpjSGlHamhsQnZuOHZRbXM5SUVIVDh4NGFFNlpESVdLZmVpUlVQZXox?=
 =?utf-8?B?SHN0ZVAxTmIwVmFlZkxEQm14TE9LcTRmSndmRVZtVTF5RDVjOWQzVVVVK3Rk?=
 =?utf-8?B?aDFVc2t3NU1SWnV3ZG9EU0lDeDhkSFUxSHNMdXkzNkMwZWJxRURJOTFqcGN1?=
 =?utf-8?B?azV6Y1lrQkQxSitPZ1pFYm1Ja3dieFlzbUdSLzYyRnZZVDZNZmpzMEpDQmxr?=
 =?utf-8?B?RFJXdW1CalFjYjIwNlRZK2EzVTZCQU52NWIxZUhzeXYyamVxai9STUR4YnZY?=
 =?utf-8?B?KzdwTUVMMGpVKzJlVDF4OElDaDFJcHo3ZmdQM0xTeUZRNndRRVBMNHo5eWM5?=
 =?utf-8?B?U2FEWm1wVnVTRldZbGZ4RS9oWjZ3M2Rlc3gvSTMzV0ozTFNIQmd4cGhRVlJW?=
 =?utf-8?B?bENSQWF0YlZhNWVEU3BmNUhRZ1VRRk00SGhEdDR2Rk1CbTJDVlpZQlhjNzl0?=
 =?utf-8?B?eG1YTFBLYkx5YzZNUUJ6aWZNam9Fd29RNVZLZ3IrUkpsRmRGeTZUVjRBMThT?=
 =?utf-8?B?blNwZ2tucld3QlgyVENRM08xQnhTRUVBR3VQUEMrcFV1S05lSTd5L09Sbm1i?=
 =?utf-8?B?SDFKMTRxdnArcGVGSkF4dzhkd2hVZGxHYXhWTm1tU0pWeHFEUno1SFk5MDlH?=
 =?utf-8?B?NkcyS1NMZllNN0c0a0dvekZjSXdQTDZWc255Y2pKa21nbnFJaFM3RUx2N2Fn?=
 =?utf-8?B?WStZR3Z4WWwxOExySU1BUFIyTHdlcFMwZDJnaHdVeWV1RXovWEEyQ2lXWWtu?=
 =?utf-8?B?TEwxblZVQk5OWjFvaUErNE9uUmxLNUN5UVlzTkppZE9MUy81WnU1eFZ3cXRr?=
 =?utf-8?B?K1lzMUh2clBlOVVrUDFwSHg3QXdWMHRVY2Y5aU44Z1BMangrNWl3cXowbGlW?=
 =?utf-8?B?RU93ZnpzVytic3JNL3R1czZydzlDYzlRUytqWGVvdFBja2tvVVhyRXRVQWRy?=
 =?utf-8?B?alpld29qSTVTZUJQMTFGYUF1bzVWN3pUK0Ryb0dWUHBWTW9WdGdsVDRlZDc3?=
 =?utf-8?B?QzNuVGQ2ZU1uSVFhOHdVQnptVFFrclhJa2MxOUN5NU9sTTQvMTlsRHlzZ0dy?=
 =?utf-8?B?Vm1ESGlvVjhyTmNSUWVlc2c2WHVBNlhQVXdvZ0NpQ3hDdnUxK1JvNEZ2NTFI?=
 =?utf-8?B?UWNkUXZJR2F0YXJUR3dOY0psY3Npam9MQWZyZmZBQ0dVK2JTNUppc1AwVmY5?=
 =?utf-8?B?bWU5ZjdKeUQ2L1hJNktiNlZLYjVJTHJzSCttZFYyRDVEb2NYMmwxTFVyc0ox?=
 =?utf-8?B?eFhNR0lKdHB1cGJIa1NVUWZnRGxkRjFjMFZXUHlDQ0JJRWhFZjFZUnRUUkxi?=
 =?utf-8?B?MVBVd05lUmJ6eUd2bzN0bHdGZnJHc2ZPR0dBZ0VWUTdOVjgvUGZGWTJQaDJa?=
 =?utf-8?B?Y1o1RlE3NURCbzBjVGMwdTYxTUsyWEQ2bzcvU0pVS0VLMWFvU2N1N2dwTzFT?=
 =?utf-8?B?WlFHcVRCTURJVzdrMERvanR2T0VLWnM2eFFZU01BWEY3T0pZR2tVNmlyUVd6?=
 =?utf-8?B?Z1lxWGxmYzdpSndPbGhiWUg0RzlnWG1CcjA1Z2M4RkxrRVpYSVdWcjlFaWJa?=
 =?utf-8?B?RG5oemlqZDgrMFJDWkxKUlgwblA1eXM4YlNXdDRSVXBHQTNYb3dPaHA2Mnpy?=
 =?utf-8?B?anZYclFUTXgydXBHSC9oQ3lWL0tFaFIwSUdpRWtFR1dKMUliek0zWkp0NDJa?=
 =?utf-8?B?bUdTdWtTMlp5b1pkYjVyazhnY2ttcy96bG1FK3lvdnpoWWQ2RFA0TFBzMWZz?=
 =?utf-8?B?VXNsM3dEakVjdlZ2ZWVoNHpiMjR0aHA4OG45alBsMmVhT1M3Y0p0VUNWdWln?=
 =?utf-8?B?QUhUakh3aHptZ0cweVVxRHBOUzhEbUcxK3gwczRML1BEU2xhTFNiNlByLzl1?=
 =?utf-8?B?NUFVR0Vlc0tuTXJDYWRFcjZkTVY1ZUR4N3oyREd5emg2cXZ4ZDl6V3pTWndB?=
 =?utf-8?Q?p6IDE/fEwG0hkKmVylXNCoHTIoeFpxXEk5V8iiYxwJkh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47D39A03747FA249ADE791C43C36B799@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175e60be-aefc-40cd-2b76-08dd8166c40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:27:33.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTbdRtFvzEhVBn6Fh1X4xCOyuHPegQDNNU5TR7I1GtXnDPlgxH73hS3KRcq2NQh/WWD2b8KQAU9Bg6X4G+/XiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232739_737004_E6A3B08E 
X-CRM114-Status: UNSURE (   8.11  )
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

T24gNC8yMC8yNSAwMzo0NywgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiBUaGlzIG5ldyBo
ZWxwZXIgYWxsb3dzIGNyZWF0aW5nIHJ3IGZpbGVzIHdpdGggY3VzdG9tDQo+IHBlcm1pc3Npb25z
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXI8cmljaGFyZEBub2QuYXQ+
DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

