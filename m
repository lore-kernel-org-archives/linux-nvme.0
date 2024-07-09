Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E39C3DA41
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2j0kuNYft/1iPH05eoiuzNCvxUi177YcG0Vi2b/QCJY=; b=M44O14kQukZUf8a2e0X6jYU68a
	WJ6S1Z5sE8pmfFjzqcW7Gz+Bz1owiNyh1pMVeWQuFMzQLJleYmdor/a4CzZr2FPswWyuYSHrwEWlG
	7PNhYWihWOb1cyVFH5JhU7Uv9/CYhNRWPIqgpzVZstB9NChkU6aCYYJOtWoHLlJksaGAWxcxx6lzO
	VHzB5mZiBJUdZoiXe6eQK+1BF/kSAmjmIZxp1zgR433cPxuRWbl/1moja9ll4XUTsx+kOUUIxVkDq
	+TaqQ695A0sy/TNTkmwPsoI/8T3e4g9M6dEYCQD1pYC7JhKo8NmDIPxGK8qjpiBFV3/+2H42JNUev
	a1BXGcuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4ce-000000068BF-3NkA;
	Tue, 09 Jul 2024 06:46:44 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4cR-0000000687J-2XR3
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 06:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6lPkt85SfvkdXrBgSeSHCwnI8L+vxwSTixaH43naLVHIkQOd7JOnSBChtNJekyhXPWn1A03KtK4jpYfJc5SoO6nzZKhCbG5hFa2fOfRSqYd+jO4vFmLoaFWJM3A4U9SMvQD0mM/2MTtRi0IgKrRmAoyJ3Vp/dRaxExn25wxSwrApdpTQirrCgeZFMYWfSFQoLuHLqHjEt5Vu7vGVXpyXhNSlW2LEiEFTmlQLSpGM08RcvdqiKVVCDwdYK0Ol5GZF+xeR97yBbyRrjZ11k+uLT8OcQQM5Yhntqsmmbk9XQraAf/lzNPkTsWWsKysvh8klsTWuALBRmr+FNZdCwC2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j0kuNYft/1iPH05eoiuzNCvxUi177YcG0Vi2b/QCJY=;
 b=CO5n3yp84j2HM7S0TO8G1E/5H1PgNRln6tXU8kR0fKu973mqcutNblwTkL/DScOr615XQNoR47mGYo5VjRWEVDtAp6+GV7LBGogmFV/4COPNv/4eBzYfCNiRlStflsFW2t3O6zR4+1OkPHrXJjj8VQz4KmZrFBc+7Bp+mQDUeS+buGc5jk7fyuwRIg9MQkl+K8UAOJoOOwcpsaETW3e17vrwRotF6ss/Ng8g/5+8p3MnzLeNyPg6aMEn2ACNShmjxnYORcEln5uKO1bmfVTDHpL9ylZWpVj4wxx7PihaLOgbtM6ofyxDvKSpGwb8EaEypDWBJNJPFrUjItzP+IEKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j0kuNYft/1iPH05eoiuzNCvxUi177YcG0Vi2b/QCJY=;
 b=eR4df0gACN/P+CyCp1Wk5nJnldWHDvipq1MALG9PcpBFyNuJNiMN50dmDi+YIoc8mGAtBOrIP5COzqmnvuhw9CviMfA8SwzIhh44chiemCO5RSshaKfsrzfFWkxhGd4blS5oKjo66EO9xTJfOPQ36JLnom4pXZZ1FbvsX0ASgQZfZ8WdjQFMAwjqqOaux0F53v1N8P7awvdQdyI79Mj2NO3VH9eRfcX+ZCpDE7bxjSRlG1XJUxaxn6+UwGRjGuZLU8v5I7C//8iyPorPr1BlHnLEZPyFR/7MRvmvFjkGLCfzS9igXmkqjOkvJpNksx7UhXBZ6Gas8NXgusbIUCRVEQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 06:46:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:46:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Artur Piechocki <artur.piechocki@open-e.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] NVMe hotplug bug in kernel 5.15 with
 CONFIG_INTEL_IOMMU disabled
Thread-Topic: [bug report] NVMe hotplug bug in kernel 5.15 with
 CONFIG_INTEL_IOMMU disabled
Thread-Index: AQHa0RCcbPkwtTzIbkuk86Y34jwf+LHt9UmA
Date: Tue, 9 Jul 2024 06:46:22 +0000
Message-ID: <2c71f9e8-6342-443d-b753-d26fb969ffc7@nvidia.com>
References: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
In-Reply-To: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4033:EE_
x-ms-office365-filtering-correlation-id: 03e406b9-d3c3-4a16-efe9-08dc9fe2d858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?enI3LzRxTytIVVNKNTBSL0NSdTAyakN5U0lzTzdseWJvamY2UlRuYU5Wckpy?=
 =?utf-8?B?TGxHQVREc2Qybkh3NWdIa08wSmRJdjlRQUZMZHdDTklFTWx6WGRQYXJJUDVE?=
 =?utf-8?B?Rkg2Z29lYnlMN2JueEpRSkU5a2tNdm5vcDBoZGxzS3NTMWk0b2JUUG5rbFNL?=
 =?utf-8?B?dUlnbTlVYnBvb21vMlN5SFNsa05IRjFMcGQ2R3B5UkF0Sk5BeGhmT29TNE5R?=
 =?utf-8?B?bE5HaGZzeUkwOWRYKzhtOG1oSEV5cVZkOVJjR2ppNGNUMUFxSmlpcjhkVUhr?=
 =?utf-8?B?T1JOUS9FYlBvUjlHVXVkNWVSeStIc1BEWms4dEFtbUhyUDBCTU0rSXRJQVVo?=
 =?utf-8?B?ZUdna3NrTHJRRG8xR1gyOFNDNHd1SVRJdHlLYklWaHpGbUNoejRzVTV3eFR1?=
 =?utf-8?B?STM4cVNGMGtZWkFacjF6WEtSd2lIRkZKVlpiVkxERVVBeWdoL1l6K0lnSDI4?=
 =?utf-8?B?Z0ZpUHBPZWNGWDFJQmorTnRabEJ6amRIU1Vsc2RjdHlENVNsMWNvMnc2TkMw?=
 =?utf-8?B?RGZsYW1ZSnU3dDYrUC9Fejk2bXd6ZlRyNnR0UVNRK3lzeTlna09KMjZLTmdM?=
 =?utf-8?B?SDM2cW9DUy8xNngrckYvQjBVdTdzSVpDQ3dWZUZMbjgrREFLdlRYV29QTVlr?=
 =?utf-8?B?RmQ5U3FURjZYSmVxdWZHQWQ0SGdhSGdaWkJLazVBeWg1czNpbFNldCt3cVlH?=
 =?utf-8?B?ZnNadFdWTU9KcWpJZllYbXpIM1hGekw0alQ5UlNFN1NMU0IyQmhXTk5CQXdw?=
 =?utf-8?B?SUZQUVNIWjZ2Sk14NUVRK2VvWjA0Ti9UNVprTVRCZUZxTEk5Z0VQckJObFJY?=
 =?utf-8?B?MXhGUG1wQmhockoranpiS2ZLamVnZ2pwUXNqdENJRUJaS1RENVNYbGNuOFRa?=
 =?utf-8?B?WTI5VXFYTnl0amFWNXNUTFlDSTIwSVRDWmtDa3BRY0psNFVjVzhHd2NWVE5W?=
 =?utf-8?B?ZXZ3QmY3L3kwazBNZW9YWnN0ZG9FTm5Xa29kQmdLZWphaTRYOFZuTy9XcUY0?=
 =?utf-8?B?anZuRlVMWU0vdHprc0NmZi96c3k3T0Qvd0pqLzd6NFRvcWlyNitSL1lwRnVZ?=
 =?utf-8?B?YisvQXpMYUhCdW5pd1ZmQkc3M2s2OFpIQ29ZcG9CTm1RWlZQaHdNL1docWJG?=
 =?utf-8?B?QXQ4Znd4RGtzWWFwcUJGdWZzRzlMTkl0dWNuK0ZGN2FZakJSQlhjVncxRnJG?=
 =?utf-8?B?VTFyKzlRODVVRWdtTzZCaktFK1U2QmRia0pNYzdtajRZSm9pdXdORWsyMlMw?=
 =?utf-8?B?aUhkV3cvRWhOaENwMFZKMG9QQnJBYkFVaXJFUlFHckt3V1UwdDRzVCtkcUtU?=
 =?utf-8?B?elVxa1ZZaUtIbDFJSUkwa1E1NXBlZW04TjJpM3JWWDh1cGltb0NHRzA5NG1M?=
 =?utf-8?B?Q1gzT0JnN3FiWnVGNmtneTBqdnowT3NwUmxqTDA2bzV0TGdzZ1ptaVpyQk5x?=
 =?utf-8?B?aSszZ29IdDNmUVRUcUhVaTNYY1B2WlZ6MWZRbUxyd1g5bXRoVmVvL1J6OHdY?=
 =?utf-8?B?b3pLOTFiTDF4TGZjaklWL050OG01ZVY1REpwTzhUdlZtS2dHcVRNbmJiR003?=
 =?utf-8?B?ZVFtWUR2WTd2Z0wySVhWMVd6SUJ3anIwM3N6NkxjczUxUUFqSUE2K1NRQmNJ?=
 =?utf-8?B?OVpUbi84d2VaWGh0eVpUYm5TUUE4N1FKZ251V3VGak95SXRkT3dKQi8wMHc0?=
 =?utf-8?B?VHA3S0JXM0FxNkliQUR2MTArWVNMRGpmS29heXduSnJMMURPNitUS0E0MHRm?=
 =?utf-8?B?bGZ4eHBSUG5Fd0Fpb3UvdFduMk9FOG5IN2xUdzlsdno0SDlaaHI3NGJCMk9J?=
 =?utf-8?B?RW9OVGtXc0JKWFFVZGxGdk9mRjg4Tm92UXdGdHdBNWh4UnJSWFFHTWpBWHRK?=
 =?utf-8?B?TDlGd2MyWUxCb0hvRTZTWWNaNzd6bnV3U2U4clpMVHhpd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0N5VUp2NWVkSU1Pb084OUNDdW9UWWIwM0s5d1kxeDJZRUxMZkMyb3VNVlVi?=
 =?utf-8?B?aUE5NjJjU05UQmxRMXJwQUdmdFJBQkNoUmpNUndVQlhoUjNqVHEyS1l2U1Vm?=
 =?utf-8?B?STBRT2NyN1E2b0doNVM1STZJMWloempaY3BKWGJ0d3EzNmNnanpIUFlINExk?=
 =?utf-8?B?d21idVh6T09nUXFoc2lQcFp1TktBSlRSNGxOZzl3LzkxNG82czJHY3FUNGJz?=
 =?utf-8?B?RjcxY0dJYW9EQ3V0T1VvRkk0N0NlcHJKeVlvU0RZWDliZERpQkhuaEw4a0t1?=
 =?utf-8?B?MkdJRnZYeU1UUEMyM1IzM25xemowOXNGc1NVR1pUVVVsTWszNEdvNnptMllO?=
 =?utf-8?B?MXJEM1hKcStWUzFMa3U3WDlGUXFwWE9VSE5PQk5RaXpOd3ROUWJaNVh0anA5?=
 =?utf-8?B?dDI2aEQwazNvQS9mVUhqaS8yVnd3ZUovL05IYkF0TVpLOWJ1M3FmR0F6bDdH?=
 =?utf-8?B?MVVHV0pMdVhHcjB0bHAza1c0SGJUSnJOUG9uSDhCblBZL0ZhNXNOZ2duKysr?=
 =?utf-8?B?RGx1cjArRDk4Q1ZhTG9sY2EzUlQxdXlNeERQQ3VFSDhsVEc1Nmd0d0phN1FL?=
 =?utf-8?B?VW9ScU40dzJJTC9EaEc2YWdad3dOOElINGl1ejB2OVE3TkhRL2NBWjJKOERN?=
 =?utf-8?B?a09HVXBFTGNMRFVtVkNRRkowZ2RXeFFGRitGNUlHcU42bnNvV3RUaUhoNkE1?=
 =?utf-8?B?ejNOczVnTFpvaGN4aEh0NVRkempjTHNIVW56QVhnTENhaWhQQnJjSWd4bzRs?=
 =?utf-8?B?SWhzZmpCY1lySVVEZzRVVUhXWmlFTVpQaHU5R2NEeEJ6ZHZsNzI4R05yeUFy?=
 =?utf-8?B?VmRYU1VXNUd1bG5ZK0JILzdaTzB1b3VhZEMzdWI3cDVLQnk1dE9kVU5ERXRj?=
 =?utf-8?B?Rm5oeVNQSlM3QjEraU12ZE13azhGcW1jbkxFdUUvYWl1ZGlRbVJBUXYyM1VG?=
 =?utf-8?B?ZGFsK25NN1BudTJJcUpqQUJFTlM4Qkl4LytWVjM1MWY3SEF3K1ZxdTNkOEJm?=
 =?utf-8?B?TFZwUTZ0em1lRzQ5NGtJUnpCL2EvVHhxa3grVzhHSmVGeVFrbHlzVW1Ud1Va?=
 =?utf-8?B?RzVpRjNLK2hLTHI4OUVuV1ZDQ1BHVTdaZDFNZ0FrTThJSW00VFkwODBPVVF1?=
 =?utf-8?B?K1VVemJ6SkQwWmFaeFVvVWZOcFd0U2RIaXFRbHE2RTc5N1BnaC9zV1JpaEc1?=
 =?utf-8?B?Z1hMYUVnRXhvcWN5SWhUK3doOW14RUszenRzbXJyZkVzVktiVnVzT1hlOStD?=
 =?utf-8?B?QmwvTVJtK3UxZGJMZnEyMy9DdkxjOCtzMFdmUnRWeWtCTXRzYTk2WFRnaC9m?=
 =?utf-8?B?aDBaZ0I2b0NXbnBKdHV0b3ZNNXF6TGpEWkpMbVEwMjB5YlBKTFpkL0RUejhm?=
 =?utf-8?B?T2Q1R0FITkVGVUNjRjE2S2lpVkdzb25lVEFINUpwV01HMENEM3RYZTgzYXA2?=
 =?utf-8?B?aGlZSXVyQkx6OWdmbk9neFJSdW1wa1YySy9Ya2VWaG5NckVPdHpMck9EV0JK?=
 =?utf-8?B?MDNYSVhVOTNMRnVXdnNjdW9neXJQaUpCc1pIUmtTQ2xVSkJGR2xTWmJsTzlm?=
 =?utf-8?B?MEpLcHYwRjRVZnFWNVZJUUI1RGUzV2h5b3lKWHJGekd4clZpWmIyL2YzZERv?=
 =?utf-8?B?NjZTTDhjQW95aytwbzAya0pQY0dtL0FlM2ZqKy91N2ZuRUFFOGdoRTFORmtL?=
 =?utf-8?B?S0MxM2E4c09hTUMwRjJ5WThLMFdtOXVuTHEyL2xXSDN4UEg3aTZYOU5lMFFC?=
 =?utf-8?B?eTZrRTJVNjN0L3pnUmFqNmdlNEhnd1YxanVYeVp1UGtuNWo1NHF5RU5jRytw?=
 =?utf-8?B?dHhSa29DcHowQVFKUlE2UTZnclp6ODdyUGJvNGxFSHNaRE1oYjN0Z29nN3VB?=
 =?utf-8?B?UmlFaTRqWWlldjhOS2pzaERPYmErbzJ5VEx1ejg5U0FHclkxcTMxQzF5K0xJ?=
 =?utf-8?B?MjZRYS9CSXF2ajF4UXJaOHlYT2daeElYbVRndTArU2tXY0x5THFDdDZzUEZE?=
 =?utf-8?B?cHkxN3U0emJPaHFaUHc1amNacVpwZWo3S0NBRG1lU3A1cVBxbThSbG1lM2t4?=
 =?utf-8?B?cEord3UyNUpqS1dFa1VZVFVBQ0I2NEY4TFloV0orbnhNYkx1anNsVnBrSjBW?=
 =?utf-8?B?UHViRHg4Yksvczh6VWkwdFBydUlSSjY1TnFnWDVRZnNXLytHcUNFMk8weVdT?=
 =?utf-8?Q?b7LOcN86aJMlrE0Jf4A1S2eOdmRpfELxCqYTUaF/rm+I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F36B6363004834F8EA8B732512C71A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e406b9-d3c3-4a16-efe9-08dc9fe2d858
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:46:22.0770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3nJ4952kyTOSlBpBi2ZLfdvdSAlEQE85cV5WUS7Staj+vWwa+EY4AFj8uH98es3FsuQ2+U3J8PrOVppxAyoZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_234631_692499_50CB7FC1 
X-CRM114-Status: GOOD (  10.52  )
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

T24gNy84LzI0IDAxOjI2LCBBcnR1ciBQaWVjaG9ja2kgd3JvdGU6DQo+IEhpLA0KPg0KPiBJIGFt
IGV4cGVyaWVuY2luZyBhIHJlcGVhdGFibGUgKHBvdGVudGlhbCBkZWFkbG9jaykgaXNzdWUgd2hl
bg0KPiBob3RwbHVnZ2luZyBOVk1lIGRldmljZXMgb24ga2VybmVsIDUuMTUuIFRoZSBwcm9ibGVt
IG9jY3VycyBvbiBhIFVidW50dQ0KPiAyMi4wNC40IHNlcnZlciBlbnZpcm9ubWVudCB3aGVuIElu
dGVsIElPTU1VIHN1cHBvcnQgaXMgZGlzYWJsZWQgaW4gdGhlDQo+IGtlcm5lbCBjb25maWd1cmF0
aW9uIChDT05GSUdfSU5URUxfSU9NTVUgaXMgbm90IHNldCkuIFRoaXMgaXNzdWUgaXMgYWxzbw0K
PiByZXByb2R1Y2libGUgb24gdGhlIG5hdGl2ZSBrZXJuZWwgNS4xNS4xNjEgd2l0aG91dCBhbnkg
VWJ1bnR1IHBhdGNoZXMuDQo+DQo+IFN5c3RlbSBJbmZvcm1hdGlvbjoNCj4NCj4gwqDCoMKgIERp
c3RyaWJ1dGlvbjogVWJ1bnR1IDIyLjA0LjQgc2VydmVyDQo+IMKgwqDCoCBLZXJuZWwgVmVyc2lv
bjogVWJ1bnR1IDUuMTUuMTUyIChhbHNvIHJlcGVhdGVkIG9uIG5hdGl2ZSA1LjE1LjE2MSkNCj4g
wqDCoMKgIEhhcmR3YXJlOiBOVk1FIE1pY3JvbiBTU0RQRTJLWDAyMFQ4LCBJbnRlbChSKSBYZW9u
KFIpIEdvbGQgNTIyMiANCg0KZG8geW91IHNlZSBzYW1lIGlzc3VlIG9uIGxhdGVzdCBicmFuY2gg
aW4gTlZNZSByZXBvID8NCg0KLWNrDQoNCg==

