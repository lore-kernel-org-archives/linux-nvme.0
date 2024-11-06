Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209FD3E788
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CliHQRFl6NnT98RE5qQwM10G25CqbAYZqsw1k7HA5qI=; b=XW0vPqu2aaVQ4OS0FWpEh8aKKq
	uMkkgsFOXZ6H8pSfDmVU3jsJMBzZHNVmNYXoerrVYtryjhe0nOSxRks63RZdIMTAi4p8fohbyIpYi
	VfuaTy4rXq8Sjcv9xxMVRkkcCQXb0zAZGrhXqfP/yGtHUsz/lf+0gE6gv92TJvN0o3vo8GUfJJ6xt
	+vFqARKRtwGQerAvKs5LIQuT7SYt5HNdQS3w0L+j+x6UeArBrzkLBjSmqzL0725TGSeCtkXZEZyse
	j1jdfvjUM2Mk8/01vATUMOaBIm/V3hcXp7ZVoLowFaaEmkOa7eTEjbRFAffvMtCaIbrm0mqVryaPg
	6jYEWHVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YSb-00000001qdW-3hsu;
	Wed, 06 Nov 2024 05:20:05 +0000
Received: from mail-mw2nam10on2061e.outbound.protection.outlook.com ([2a01:111:f403:2412::61e] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YSZ-00000001qcy-1RWs
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDtxxWrHNnAmgHDZYwFkIdgwZbDH8Ip3fiBh9r6UZ8Fai+XI8ogjFaH94mx+SubDPpIiRMoLSNEN6N8jTQC1u1o+IAkdX1wIyIbLEJ3OXGHn7JmHkNO4PMudszQ8aQFts8uzcxcTVc/pm06V8XsjEm5kloWLj9kBPlD0DD6Hi+hGY4gxx6jL8/BrQR1q07k/zfrOxCQ2d1gkMWnrK7HMsb8LoKg4+AO5ScAFvIRV4b3BzYkxyqDEE9zgYNs6ZpUr2rCuHWK2zMwFPabOCD5sTBZ4xO1/lMeJtLvKgG5sS7+yDXCgfhdgU4pJDFXuXDNRJH8O2Pq85pqLG9kle1k9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CliHQRFl6NnT98RE5qQwM10G25CqbAYZqsw1k7HA5qI=;
 b=dto+wRFPKlOMhD2rUlbFRCv8jRfgqC+Octah8Tq01UQqf5eM3kdc+W7LhrwRHyPqPhe9/jEmRmkyZ3sOHiHyBdLE90WJSQGycyzaeMSvsQtOycXiVncfOLml2zxY0qikINvM5NXXs0v0RBmcU2DQVxKkYr7vt/zMAykoUU78/FmGR9u8SYg6WWXWg9URzDLaftmNnBkGthJX0TFchG5lQgJB1TC+wAJHTEmaRTvCUJ3t7vo8FPmwDyF7Q90dWUN1hfPFMaCFjumk2vSxCFwIWNxrimSbQcrDFyMKsdJoAQ7S2hMNqpgYacUO3LMGOYDrIPaWQ3XmF7eCSIDXNVC1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CliHQRFl6NnT98RE5qQwM10G25CqbAYZqsw1k7HA5qI=;
 b=lvD5XmkrPmu/UADNuF+8Rkm3S5mj+Je+Wk6bdgJKgXWivlNGWD0BZAcKHzNOBUxiMeszq+Js0dxasn67NT3mGEwfw737zgBxsQMq4yZkAYQczLlF4CdoYYFT5Xk643odvXB0JgvG+eY0oT8V8vvkB5P82l65UHLy9Pz5XPdRiZB08MclUzHQir8I3HSR+94iKRlvstIo0CKa+ZNXZpEmlf4H4kM4syvXphcY8eyeZakuthk+ANNK7CljJi4r99I4jaO7BR4YjtnBl26NOtnStYqZNa2XQcvEwagw2cV2gplj5WeN6noQK3nGULssheLxPS0hou99MP2QGkEteJewkg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:19:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:19:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 04/11] nvmet: implement supported features log
Thread-Topic: [PATCHv3 04/11] nvmet: implement supported features log
Thread-Index: AQHbL6sbK4I2eY+R8EOPSYxY60qiyrKpt7QA
Date: Wed, 6 Nov 2024 05:19:58 +0000
Message-ID: <5e01d7e9-aa66-427e-a175-510dacbb51a6@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-5-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-5-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 8567db52-3fbc-486a-f5e6-08dcfe22a852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akRxcWozbHZhQzNVa0F1RHEvMTBFYnU4alc4VFl0dnJyWTR4cTJSRGtNbVRt?=
 =?utf-8?B?cG8rdnNJZ2xjbTBUd2RHZXlxbTRMTGp0LytHUVZmcUVodTBNNWwwMHFaTjFp?=
 =?utf-8?B?TFVVcStJUGpZbkdpUHBXaGpUNnFyZGFPOVVuMWsyL2xIaFM4UmxhL2d2Q2wz?=
 =?utf-8?B?cFBieHliN1Iyb1huU2FkRWxDV091QkUyRnFzM3lnSE95LzRGWmI0QkJ3Nit1?=
 =?utf-8?B?TVVBcWcyc1FQU3lLdHVBemVCeWthMElXdGxkOWd1eXhOa1g1VjcxVjZQaHJU?=
 =?utf-8?B?SFI3TWJFa2hNWWZHYVdQK2lWZXZCdEhWblY4bUZqVm1iNjRTUWpZZmdxTjBn?=
 =?utf-8?B?SnhnRDB1enZveFgrVVZxZ1NZN0ZuaDU2SVNJeDZCWEg4YzBPQ3UwZklzSWxy?=
 =?utf-8?B?dWxUQXlXNFo3dVJqVTM1SndrNkR6SXVISGM0bGVxQ3ZPcXVuWVFIZ3lISDNK?=
 =?utf-8?B?TnNxNVVoQkJxTVc3R0lwSU1tRm15RkQ2YzkvT2lTakxqU003YXUyTUhqeEw5?=
 =?utf-8?B?enY3VVJyNWlhdDFpck85Ri9TSllmcFlSMGh3VUdSSSs5b0JDVHNWZGVoSVhV?=
 =?utf-8?B?ckRMa3pyMEtUeVdqQkhua2trQXFLNVVMTHFKMTdXd1oyc2hpZ09QbXZCMlN3?=
 =?utf-8?B?blNSamZMTWQ0cmExOHFXbEF0S1dud2s4Z2FpRFl5b3R4QSt0Y1pvcld5WEtm?=
 =?utf-8?B?ZmVNc0RzalEvZ0daMEo1TEY3dG10c2VUS3JKbDVuK1YxMFhBRy9OM0dhcytx?=
 =?utf-8?B?bUZ6dUlvVklEcE50UnMweHVOSUw5UlZpZTlzOTBGdG1xYmxmMTVQUHMwUTJL?=
 =?utf-8?B?UWlwTVB0SG9wK2oxM0U1ZDZzSDJVL2VWT2U3SjFnQ1JBU3lJNmRNZm1TRVls?=
 =?utf-8?B?Y3puc1ZYUXNMSDYvajFDb3ZQM1EwQlJuMS9XMExnV0VJVmFpdTByaDYvQUYx?=
 =?utf-8?B?Y2Z3SnlTNmdiYmxMZmppQUlRUnlSeGpLcHlmSDdQaTdZWVNraGNhL1ZRTjlm?=
 =?utf-8?B?N2g1VUkrT1lUTlBhSk5RRTBPbEM4ZmlMeC9kQWpYUnhPVkpNUzFXdEdIUmZm?=
 =?utf-8?B?V1RIZEQzMjA4UUtGRUpEUlRiL2tsWk1EM3V2V3N4RUNDTVBRazRrNnZ2OFVo?=
 =?utf-8?B?OWlsdVRRbDA1eXJrMVNkckNsOHMzanhxMGV5SDM3b1dUekN4KzVBL1pGY29B?=
 =?utf-8?B?YU96akxYbkt0dyswakMwTVlsak5mNUN6ZEV1UW5kSE9GY1I0MGhERTdOWTdw?=
 =?utf-8?B?VGtaWHNCWE93OWNzZnVVZUt1ZVNsUmVsWE51ZUNsdmo2ZUlNZDIzajFNMmh0?=
 =?utf-8?B?akxLT3piK3pJT3piYlJ1SHdRY3JWek9OdUV4ZW5EM3FLMzlmV0lST3ZVVWtp?=
 =?utf-8?B?d3RGMkFvbG9rTHBNa1JJclBqMDhCMVdiVTF6RHdKNVVQc3RtWHR2QjNwcXFl?=
 =?utf-8?B?VzJ2Z3JFUC8xdnFNTTg1MkxGWnVFUzB4VFkva3lzUHpJRExEVld3OGJsUzgv?=
 =?utf-8?B?T0VxWVNnR0dQK0EzclhmbjRwNWZLa01qQmhxTFdUaTlqSFRMMk1zQkxGNkI0?=
 =?utf-8?B?eDI2WW9WUDRXd1MvNWo5YldQeDl6UGdlQ3BDM1ZGZktkeGkyQVkwY1N1Unhk?=
 =?utf-8?B?c3Y2T3Q3N3RoRWppdUJSQWp0L2laeGwrT1FZV2Q4aEV6aHdseC94eUJlanhO?=
 =?utf-8?B?U0FTUE5Dd1A4ZFU3ZTJsR1NLRmpFWS9ZeUNzSjlQNkl4OWxuNnlhUGRQQ2hC?=
 =?utf-8?B?TzAyVWtuWXpWaXJkRlRUeERvTkY0TjZqTkdiZVloRzQrZW9Rb01HUDdXeFJk?=
 =?utf-8?Q?aUyp3FWS2GcRDJtyssO4B2qq87lCarBPEBj/0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJJMFVka0xtcmZGQm9jamI5L3dlZG1aMkZ1Z1BKMG00a3JLM2UxWUFBSnIx?=
 =?utf-8?B?bzZqS2pzWXVNN2F2cnRGZ1BPTGkwZEJ2SDZ3d0JrMlQ5RjBTc3VPbWRmL0Jr?=
 =?utf-8?B?VEpUZVdlVU5wckFiellzQzhUNVU4anlWSUNyK1BWR0RhME52VmRlV2FIeldX?=
 =?utf-8?B?ZVJFWmJYRGVzOGdzbXBiZHBpcjNUSXBvRlBvN1U2YlIxNldXdW9JSnB0QlF5?=
 =?utf-8?B?RU5sSHNtQUhjR0I5dkdSYU8yek1WQlU5SGQ2OEFOWlo5SDYzVldScEVUcGpv?=
 =?utf-8?B?K1p2M3hydDlNLzE2eE91dllQcG41dHV0eHFoS0oyZFpIM2lWeE95Q3BHUlZj?=
 =?utf-8?B?YVh1Wis1SGJaMG82VVhCYUVuNEh2b1NkUU1LUm9HYldvTUFQaHVNaUxuRisv?=
 =?utf-8?B?L1QrdW9XVE15NWxUM3F4YVpFUTh2b3RJcDFCNnNBbCtMK3hwYklZMG5hOFlp?=
 =?utf-8?B?OTRFYnR3cndnV2xNLzJRMmRUR2ZmSjhWeXFRVDhVejRCdjdDWitYeTRPeUl0?=
 =?utf-8?B?RkZGdTJSSkFsOFExalQ2emo4MTNhZlczRGk1cUk5VVpIdGY3R05OQm54SGcw?=
 =?utf-8?B?UWFyRHJ0OE9ZMFNxczlZR2c4cFA3elVwRFIxMWFUN2dVcmpSeG1xbjQ0NW1M?=
 =?utf-8?B?UGZnVW4vWlJBc3BDSTF1bXMrTFJ3R3VJMzBib0RTdTU1cC82YXcxem92RHNo?=
 =?utf-8?B?dlhkZEJZdnd2ZzY5a2tpWlgxM2FweDhPTUs0UytUQk96alpweFRXRUFKcGV6?=
 =?utf-8?B?RXJYTTVLc29FQjFuUWJMYVFwdnh3WVVmeXRWNU9NZ29WOXU1SERsYkQ5TmIx?=
 =?utf-8?B?R3FSQXZGYnIrc1c0SFJBdzN5RDhRNlRBM2xWb1FIUVIzS3ZZWGE2bzhRbEJ6?=
 =?utf-8?B?VnFEbUxpTUMwTy9jVWM5QVZ5MkNlWWFhTmlVdG5pSkFCeTByN0dVMFVCTG5u?=
 =?utf-8?B?d29xWlF6Y1d2OEdDYWx6SEY2bnpNVVZHdTNpelJ6ajNWK2RYZWZ0VXVOdnVv?=
 =?utf-8?B?ZHNOenh1Y3ZRNkxYOUVBWWZlWExneUZqUFpoUTBOZithRFJJTUtpRGdUZk1X?=
 =?utf-8?B?UkZBS2Y3WjJzQ1I2RVAvS3FNTmlMN1d5ZDlqNGhCZFUvUlgvaitUdnhLNEo0?=
 =?utf-8?B?MmJ1dGhaVms3VjUzZklpT3NCaGVyN003U1Fid2s0Yml6OG9tYi91V0hoamxB?=
 =?utf-8?B?T3NwN0tPTW1nMXhPaHBXV0FQcllBZUx6NXpGb2U4OVVrWXhvWjdTMWN3K1gr?=
 =?utf-8?B?dVZtWVh1R08yN0lSbHlsOWplRlZvWk9uTjFTT3orVDVWMm9kTU1PemJsc0U4?=
 =?utf-8?B?cWh4Tm9OVDR3TUF2bm51K3YrVUY5R3AzRlkrYTllNXNtV1pjMTRzYkNIV09l?=
 =?utf-8?B?d2lNbHU1eDJGN3JvY3RwWmllem5PN1BmOUJJSG9uT1EySkthVExhV1NiSjZz?=
 =?utf-8?B?RTk3WG5saGh1NFE4TXJmSFlBMG53ODJwSkE5anl4d1A2bk50MHRDNzAzUU9k?=
 =?utf-8?B?ZnI2ZVdlM01RMk14VGp4bm5zWiswa0pEMVBEZlNKdnBKNTVwRlhxcU5WbTRx?=
 =?utf-8?B?V1hDcjRseTZQMjA3SXQzZFpVaktQem44L2FQZTRna3NlREh0U0NTZzZlSFdS?=
 =?utf-8?B?Z1hUNDJmbFRuemRlb1JNWEhUa3FqZ2FXdUNuZzdJcGZaSE1Ubkc1R05xMDBz?=
 =?utf-8?B?aFhuMm9sOXo3dmdZOWxTeXpFWEY1WXFLMmVlMG5TcFdXbzdNVklJOGIvU0Zr?=
 =?utf-8?B?WS9PL09acEdYc2g5amM0emVpYkpJdkpBem5QOXU3dnluVkNVTFVyWk0vN3pl?=
 =?utf-8?B?V0loZktWdSsyWnBRZXpwcmYxd041cEpiNjBpcGZUQ3FQemdMcXpUZmxCMWZX?=
 =?utf-8?B?RTQ5RDlmTWNLcjREalJXUDNKMkVJWDk2Nk5YRDJHWGxKbVRHMlVRUHBNOTJJ?=
 =?utf-8?B?eVQvVEVuM3pFZ09PV01NYnR5ckg3eXRNN2ZuaEVIMlFsOWxFVW1nK2YvZDRp?=
 =?utf-8?B?QVIycTkyR0h0aFlob2dBenhJSFdPOE8vMG9rT2ZzVDI3MTcweWJJWXVLOUQ2?=
 =?utf-8?B?ZHFsWWRBNTI3Si9pL2pEN3grQmxpRlNsMU8zRE1GbXhaeCtZa0NVL0V3MmVS?=
 =?utf-8?B?NkJUc3RZa29nbmNKMStZS0JVdDBKR1E1RU9RaFJUSzdkYWxLemEreUJCc2Ro?=
 =?utf-8?Q?gXJEpQRcx/pQWdtdWf5HGyI6F4zqSMU4IQEa9MFpfI5F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBCD1FE8DAFC234CA41F184B344D162E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8567db52-3fbc-486a-f5e6-08dcfe22a852
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:19:58.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTxxoXeEybMbWtsyyJgp5l1deYhu2VE6KohQgLVvCco3dSmJOE87GKqdPMx4QgCz33g9DSiQCJPaVXGQg1tNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_212003_432168_67B05490 
X-CRM114-Status: UNSURE (   7.25  )
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

T24gMTEvNS8yNCAwOTo0OCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhpcyBsb2cgaXMgcmVxdWlyZWQgZm9yIG52bWUg
Mi4xLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+
DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

