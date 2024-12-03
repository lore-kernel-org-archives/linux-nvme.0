Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26924E6C5FF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e+6yUfde0Z22qNQ8YPWdRXkFygVOEQJiGu2tCoGH7ag=; b=RhBoPHlK+XECnxZoqBqIMRwWfI
	EQgGk823KYHEVXwGvMIv6M0dciouS4n+jItshLRvBn972+ufJuJ0b3bHjU7nRVTgp71M3Q8BkfJS/
	Ti5EVPj5qUfnyCi6RlJi81E5fBlHUdvi/EGL1PtjbPMYXNshIn/7nftk9appmGXRL9u/JJQru95kx
	Q6CE73lcgy4Ep2a6ivNI/5k5MRIMQ6tU5ek10mKXszz+Rdo4Lwka85oKrjw2W4Bn2MCU9lBfxA9yX
	aJmqDpshn9o5qZ+cGvgK4i5GW11f71UVl5KJADFUJBOnTQPS2BdnezNfsCbl8bQGP1oUxdjPfFKbE
	JJYqy32Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKxa-00000008Fss-1Vlk;
	Tue, 03 Dec 2024 04:56:30 +0000
Received: from mail-dm6nam12on20615.outbound.protection.outlook.com ([2a01:111:f403:2417::615] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKxY-00000008Frg-0OhW
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUYkz8FzkE2YBDwquWlxJAyNKMq42RB3oE6/mASswrkgHDTouxeiJ+PtLCpzVi7ciMu0X8T7v4Obj/4/EQYo6P3vZn3qOm1YxZmp5v3G29ZKDb/4SpgFNSwaLianVxQXcS9Of9wmpDgBAP2jQNqFy1dZYj2bUrgEDgPh2cU6XbLuYdyXAuErGXvH2hNny9NRCNx1mrpV1QPO6tUYPpR2NX2tsZgqWSCwtezumFxhUGhviC1Ls5dia7XhgPTumSoTr70Mut0kEfL35dnBQMSDcumOUGIfrOZKTlj8DIOenbyoOoTMRGZCx+OBv10LfhH0ZrqaXdQNzkqGclgorXpXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+6yUfde0Z22qNQ8YPWdRXkFygVOEQJiGu2tCoGH7ag=;
 b=pYCe06CWEOPni8+6kuVnzkDFlJweGDozqUjkpJhkDlImshup3s+SN7Yy/rK9kMy2gF8yDBMRbmltaxDVv4xk1ZdrzowAmhaHl6jZac4JZALLpU69JCY4SgEqNIloQpCCtunw8RoKwLsT7kkVFs8CZSeZxzjNoCjsXUOamGwWuV7RrdfgHqbFXQn8hVLsXa668T4MzsaCumiSD6NcV8BwzfH0gs+lM87VP9mth+3kyoTjuj/8N5V33EkY2M7obAsttz7O/6ljgnwoJkXegGOzdvrqQ9HtXck0iFBOl02b1SeDdU7C537IMssx679PMHqvqT1xFSdTUquwpOBT3c1Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+6yUfde0Z22qNQ8YPWdRXkFygVOEQJiGu2tCoGH7ag=;
 b=f4OcGtvdxTPgCznDrvQgwWxdOP2Sl7G/sUTcbHGW+2dCXoQCtdVmVpza91UtPQ3+h/tDF1n1NcuLoLU62OQGJtRR0dUYoQJt/jpz0Ecddh3Sg1TVIADUW3p+pRGT8mPaQh0Hn2InUu4UK0xBxTDCpzW9ys7QElmCfgf8MZSFj8nMiOU4rl3gdhOrdLWY8xLqQxJZXpEjsAaDCcJfH3b0PeL9V7UP0nulewaeBoyC+hdCGVBHSF6P+bh7LamYRlXrxoHBR8Flu8cGCvcg4vBqQQO0MKOc6cP6dUNcvbg0umMI+lZudNrlT7cttMQEnXcp+18fXlhoDP3r+ZErc7F5Yg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:56:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:56:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 3/7] nvme: add _setup_nvmet_ns_ana()
Thread-Topic: [PATCH blktests 3/7] nvme: add _setup_nvmet_ns_ana()
Thread-Index: AQHbQmJXmIpT833vg0OiphKvdxpExrLT+qGA
Date: Tue, 3 Dec 2024 04:56:23 +0000
Message-ID: <3c02644f-3c2b-45f7-9fea-16d6bee964d0@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-4-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-4-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 8c1d680a-7697-43bd-8c0b-08dd1356d5fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjZ1Yk1XcmJkZmtxS0xXN3hIcTdCTWxOQktkTGpHOEJlbWJBM0x6aDViVkZ4?=
 =?utf-8?B?TmZNRktNNjFoNWFrbDl6ZWhFVmEwRWxiNGh5RjU1czFxSmN5YWtnMDBldmNT?=
 =?utf-8?B?aHpDcnlzQXNwMWZLMm4wdVA1OXpxUFhTS0dqUGVWNFdzVG51eUFveTdoQjFD?=
 =?utf-8?B?Qk1JVlRSYVFPUDUzK3UzMnNkWXNLWmJqWE5LLzBoMnZuWWE3OXp3STYvVmpJ?=
 =?utf-8?B?Qzd2VkhGQkxwc2gvMWZBKy9LRzVxV090eHVJcHlidWNvbTlrTXEycC9hQjZJ?=
 =?utf-8?B?NUtvbWF2Qm1VcTc0dndrbTRpRlZuckVTZ2M0R0xnRkNqaG5SNlE4enpYZlV1?=
 =?utf-8?B?TDRFcXp5bXpTQ1RZM3JUai9jWXNIanByeGczU21sbllyOU5PcXpibGNzQmVj?=
 =?utf-8?B?YXNBeEpYZUJ1aWxXUDhXMTlkbGZEajFZWXVaNEZ4a3lxa3doSVpDejJKMFBB?=
 =?utf-8?B?c0w4aU50MTdVMWdQKzdsQzU0Vk84MWk1Ni9maGhoZFBqRWtVZWt1VkI0L1pN?=
 =?utf-8?B?QUpGOEFFbnFZeGxydXpaS0tRdlpVZ0IyUUR3MWpjZEVSSktTaldYeEZTRS8x?=
 =?utf-8?B?WkhuaU14d2F3RUg3bHlKVVRqNUhLb0VrRXkzZ09kalZvRGZlVWZXN2JvdlB6?=
 =?utf-8?B?M093SEJJYmg4dlF2cVdBdU55azVZNnd4d2tKMzlNZTJXVGJJNGRaNW51eXpi?=
 =?utf-8?B?TzFNY1JnUWxlNGJQMmhnaEkydWtuYlpaM2FLVkVDUGROZ0xnR1BEOVU2NXVK?=
 =?utf-8?B?bzhad0dFblo1V0E5ZTVWdUxoMmJnZmpsU1NaRTZzZGlqMU8xeGgycE96enFT?=
 =?utf-8?B?dkRudmlRUlNKWlVIRkxnbTA5ZERLQmowMU5jRVFtRDYrTGRXaFFEYjhLbTds?=
 =?utf-8?B?MUxuLzZiVU1mMitURlhKSWVlaWZiWFBNLzhxdmFuQlhXbWljZ1kxMW5OOXRN?=
 =?utf-8?B?eFhsUkRKU0dvSUF1SWE4alNqKzNyaWdPbFdGallMc21tYzBlQjVrc1ZOOU5w?=
 =?utf-8?B?ODB4U2xrZDZYL0oxLzlxV1dqaDE5YzZHTzFSWWI2cEJRQVZzdi84SEl5L25w?=
 =?utf-8?B?NStmU0RIV29PSUFMTlRlczFOSzg5b1JudnpsMHQydlFlcXJFdFRENHhOMEJv?=
 =?utf-8?B?cnVlNU5iUGpKekRiVzRPTkpyb2RWYjVXcU5KbEZjbk8walF1MDFqenVyR3Z2?=
 =?utf-8?B?T3pDenJIL2c0MGxoM2FZL2NGNnhtTVNNbHNKT3h6YlRWeVFHd1FPbFRPcWtF?=
 =?utf-8?B?NWlzNDhRdlA1MFJmVUgvV253czVKK1RIM2hYOWZnUEpHTlNFak9XRmtaQmdZ?=
 =?utf-8?B?eEQ0T2xtUTNNdUNZbDI4RkI4cnNHbCtDYURLdnlrKyt5MGY3MURWYlZkYWpx?=
 =?utf-8?B?SmV2RGJpNWJmTVZRaTRWeGFIeDN4cXg0TmNWY1ZZUFFYa0wzVzNOSVMxZ0tN?=
 =?utf-8?B?blJxVGFWTmFiaGRZM01QczNJckE2Y1FGeVNQbno2Z2hkUkllOTRWOWIydWM2?=
 =?utf-8?B?aU1sRFg3a09md20vRHVrclJsdG95ZzBDb1JwNjVNV2YwOWxaZ0o4cnRUSTU0?=
 =?utf-8?B?U294eUQwdnFUWi9XNWhBam9BNXh6VmRjTkR5S1RDWjVnbTlxTm1ad1dtb3FR?=
 =?utf-8?B?eVpvTXAxU01kMWUvS0J2dDNQY21XQzZ3S0krZUdlMzZlamJlZUdzdk9wZjJV?=
 =?utf-8?B?eUFRMlVZOTA4TURnMU1NdjVnd2ttbDBSNmRKME94N0k5UXBtTVhXWUYzMEsw?=
 =?utf-8?B?QTBJMnI4c3J0aGxlaEsxdE80MWgzKytjaVlUNEpUNUJlZ1pWMlQwbnBDT2Ev?=
 =?utf-8?B?aHBFVDgyNUJ0cTJTU05xayt0OFBoUjZIdDBIeVlUeFY1K2pkVWJDMFRzTkha?=
 =?utf-8?B?NUNsQWZ0Nmh4UUpjVTQyc3dJYlJKS3NZbEdlMTArclMzTWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3JLbkxjbXc2cVVnNTZTV1dsYXZReXRNMTRKdE8vYWl0TkJSNm05ajFsY3FE?=
 =?utf-8?B?aVNQeExtK3lzK3JLRWtCSTZiZGN1MUtJTjVRRk1tVERCYlhrdmdNdlBoVWVa?=
 =?utf-8?B?ZVlTdzBlbm9IMGdmdzJZcThYUm81N1Y4aDB1M3FRTXNCVzJXaFJYNDhZdEVy?=
 =?utf-8?B?SHJiYW0xdUVRMUNoRitGVkJkSjlMWnhNcktzVGE2NGF4YmxGeWVVWGdsWjhN?=
 =?utf-8?B?ZTBOUjhWVHRKMlBIRmZIcW4rSzFSd1lKSlUxa1NiMkFubUtQeXU2Y0ZmQWxW?=
 =?utf-8?B?blEwWTRQWk5jTk9GVFNPM21RKytZZFlxR2Z4Ym5RTFFtZ1FuZTZGcFlFV2VK?=
 =?utf-8?B?NlN0ck9wTmUwbmNvejZOZFZJODBBNWhGNDYvb1pSNmtHeWlLV2Z5RVl6bWI1?=
 =?utf-8?B?cE5abVppWkFlUjhoZDQ3dC8zR2I2eThLL0wyQXhSMmRwYlNFdjkrd3JYWGFB?=
 =?utf-8?B?dGtGTnVXVmc5Q2FqTTl3Tkt6ZEhpZWtXQS9BYWlYK0ZYbi91QzNjUkVWbnlu?=
 =?utf-8?B?djBKbU14alQ5NElkbU5DVk10TU9Lcmd4eTlUQ3R6di9Ua0pUZWd4YnRhYkxB?=
 =?utf-8?B?aDNNV0plUTFFU1YvOVZvdVc5dXNVcXVKcm9JbVRkTy9TMThFRGV1emQ0ZHYr?=
 =?utf-8?B?eVVJYjIwWml1LzE0dzBEVThNbkpBcVQ5R2ZXWXNqdXQ0K2FhRWpzZnF3cFNV?=
 =?utf-8?B?OGV1Y0lzQmtJTHhsVm4wYmdJRW5ZcmZmNjlpaWVpNndUWmhMdTVLK3ZuQWdF?=
 =?utf-8?B?T2cva25vYVJqNksvRk5tWWtXYnAxcFlFTGJWNy9ENmhzazNXWFpzS1d6bXVi?=
 =?utf-8?B?QktaNS80QVZqNkp6VGt4emdTYnhOd0xYM2lXa3Fjcno5M05jeHdTQlZnWGkw?=
 =?utf-8?B?THVoMTdzb21sNzJZN2UwQU14cHlsanh1blZZZ0FwVERyOU5VcWxialFPa3RK?=
 =?utf-8?B?VHpWTFQzeXJIRE9rcDgzMnU4UzY2SE9ZdHFPWkhRU1A5Nk51MzJzdXo1WlhY?=
 =?utf-8?B?K3ZEQ1N5NnozMlp4WlRiVmdmTHpISVF1ZGlPK1ZvemNZRS9VdkhWUlJQM0JB?=
 =?utf-8?B?aFU1d1lsWXJtM254VEZtU2d6dVZtbVk0Mnc0NXVyRGxpREtwMThzcUZNemlo?=
 =?utf-8?B?RG1TbjVlOHZuUkRna1lNR2dZMFAxVW5QU0xGOVR4ZVFpUi9qT1dTYkZiZVRY?=
 =?utf-8?B?aXRFbjR5OERRS2Era21NMnlTdlhQR2tlUDh1ZmlOVXdwWUtORjV6OGlZYjky?=
 =?utf-8?B?a21EdEQ0enhDVE5peUwvTGhtTU42ekZXME9iVlZKcUNiaW9xejU0SUhId0p2?=
 =?utf-8?B?ZnZsaVdlRVRZSExOS2NkK05acnNYV0hHRGs1Z3J5OGVUS1JnaFZsZmE5VFNT?=
 =?utf-8?B?cS9rRVFONW1RSHM3L1FBeFcyZGpIT2huT2cyOTBaNE5XTzk4NHF1ZkNjR1Bk?=
 =?utf-8?B?Smw1T2ZUQVlGYVRObUVRUVcwK1I4cHdLWmJNTHhMangxVG5icENIaWZsZUZw?=
 =?utf-8?B?KzN6cGo0cEw4b2Rid3BPV1g1UHdWOGhwZjlnSktiL2ZaV3hQUjZJOEVlcmh4?=
 =?utf-8?B?L282ZEJjOGpQdytWbU03WmkvMW9PbU81MFdFZVMwcWFvWDlHYisxVm45a3pt?=
 =?utf-8?B?L09tMmNkOGZTQXJrdlhnMWs4L090R1ptZEVUV3JydHo4TUludzh2WnFYZWZj?=
 =?utf-8?B?QnA1OUhleXRtUlNKN3R5ZzM3RjYxOFdrQVZvdldJSDhWVmZpSFF4d0hIeE03?=
 =?utf-8?B?alRDTE9MN3kwNitVTHVkTHFXcjBBN1dkd05ZWStEcmprL04zUytHYThZdzB4?=
 =?utf-8?B?ZmJucTNKNGQrYyttdDAwV1Z0MEQxcWJjc0JFbmxUa2R6U3JPanN2MTQ0MXl4?=
 =?utf-8?B?aFFSUzR0VG9pNHRzOVhtYU1UM3huTzJmdjV4UFZBSXBXbGU4bnZqenp6b1NK?=
 =?utf-8?B?TTI1TTlZc3hqRU5kbFFnOWZmRjkvYWlWYmUwdG9zNGYzUC90UENSNzd4R1N6?=
 =?utf-8?B?b2puS1lETnordzY1UGRnc05GNEllWWl0S0Vxb0NNNEpvcEU4OWx1SENRd1gv?=
 =?utf-8?B?VTBYOGF1WlRaK1FRSzZZczI4Mkg4ZnVmYVRHZ2FnS3YzSkhJUHljQWJNdnVx?=
 =?utf-8?B?ekZZNHpxUVQ5TW53RkdkUDZNeHQ4Y0tGQ0Vkd21vV0YwdGZnbWY3R2FzYllL?=
 =?utf-8?Q?i3MlA9+Hf+18sH0T/52GXRK+nO/zLZWFGdp40LsBU3A4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD3E9E10E832AC42859274E977B581CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1d680a-7697-43bd-8c0b-08dd1356d5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:56:23.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjVKfQQFOd/qd86t0vihJ2ZwgzcO4OYItdS00UZO3DbOdgWF033ADNfKqcCQGlSZ9ahAnKCUXxX2aq1I9ngqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_205628_131279_2F0C2DEB 
X-CRM114-Status: UNSURE (   8.01  )
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBBZGQgYSBmdW5jdGlvbiB0byBzZXQg
dGhlIEFOQSBncm91cGlkIGZvciBhIG5hbWVzcGFjZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFu
bmVzIFJlaW5lY2tlPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8g
S2F3YXNha2k8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

