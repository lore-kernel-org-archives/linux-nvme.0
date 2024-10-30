Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A8D7497F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mH8t8QkKTB0kkMDgCSmbqNEMCVg+E4uzwNkApK3TzTI=; b=fopCRzghB3VcGyN1r1wzaoF3Wg
	e6q2rehAzvoSJVW5NthJoEOylDnZ0wBr/Six1VEm11408hDndwQwEqeQpHg+tqrmzOfGOQwx5RTyJ
	lI5QPU3n9qS7HPUG0hHSZilTc6/uvUj+KqZLi+JWxB25XRLVaw0mQ18VHTvyz/CfVKZSpiyiFS4ct
	TU2/tBhc4VzjGwyP3k+e8IJaDTiqA0bP1zvGayPj4QPs9pKLJGaFMsYTJda6fSdByIehjLSoINAGm
	KA+Rjt/7a0MfLt5HDTSiQjRlvN0uCqbwtIx3eb94fQMCVTtiBhOuALvyAwY40tYgHSJBUUWOxdrk5
	/Nqyzk3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63aQ-0000000HDXV-0rS7;
	Wed, 30 Oct 2024 07:57:50 +0000
Received: from mail-bn8nam12on2062d.outbound.protection.outlook.com ([2a01:111:f403:2418::62d] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63aM-0000000HDWM-4C45
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao8dp06xlJ6f1dk3v4T4IKDswTXwoJG7Uyd/HfNRgNiNMHraHnxQYD892LHtkq39ruVq7t7CGHmMkT5Tm5MuSM1NU/684atwCeA4EAAiMpOnqlRKHeDWUZo45OyLGjiZsQcqEGkx95VUVewW1W/6vMy1hInp8kH4KjWsUWX64FsG15JUY87EtnxglT5HyhsovdywEgzVD00K0oGWhrXMiCjc4dGWnmqcBdf/qSg1X4PRdXFzPOo1cARQJOtwcSZ6qZQ0ltiH+q84+3Ug0XzFCxGxJavuqHnk8Wvdz2pM6qcSw+hBux0ZMy3YfFhM7WH0BYDM0OdlciIPYQmaB9oSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH8t8QkKTB0kkMDgCSmbqNEMCVg+E4uzwNkApK3TzTI=;
 b=ROTQbYjpabAaLm0qqfSgPgj8WgN23oBMuuZvJgn45mEurVDSqHfs+jsVdgMyI51J0OGKlgkAvKDTycVGwPRGjiYY5eN618TpxOhMyHVWEjAfa2W6M9kYwIoMEBRv/wgsYwbJCj5WuGkMQU+JjXudB6coJPKH6Ve3JgDh9V3ez+3kN5cmW+Yw3IA7TI2oD6o+8KVE9lN9/yNVngbUyTO+PD8ERIv4YPGPwZg9JI+b0UkHACOvcVd2Q87n2OjFb8e0RMTTC5R3ycMxa0eLUtqVv4cUt6+k4Htv7P483kCJ0Uk9kizV4BMKr7TiJ8E4im/HjxnDva0F7zuOg/vDrGxGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH8t8QkKTB0kkMDgCSmbqNEMCVg+E4uzwNkApK3TzTI=;
 b=SaCVarDofhGak3pxgHXbP4ThurzxFLGiprRGUoy9tnrI+LzXiieK3duhwlGw7DiR4ZRjAWh4VrJg9gAQnHxySsg4pkr+jvfY4od044xgBG9xkys+lSmyE02ly0Rxb2Ig9x5CBHeCVtbNnMLLFmqpDrdK0a8iIoA20ZzBaUFWesnpjPFFG1quIgObezm8HFk0j3Q+W/KmqIibcgU/RKEPdN+oYkjnqpPZWAkCs26JzL6+JEGrJlIiJO4bdhmXYRZ1aKzYVIIfcaHSJ+NhhOfJn4Pw3OTYDgm+Qe4kIeSrVuBRSWJIqzHpb0NRtzzxjZDYVohO0pH+Y/UHp0NF62GDPA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:57:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:57:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 08/13] nvme: simplify _get_nvmet_ports()
Thread-Topic: [PATCH blktests v2 08/13] nvme: simplify _get_nvmet_ports()
Thread-Index: AQHbKphLfW1FGSRLWE2L8QQLcdlD5bKe7ZSA
Date: Wed, 30 Oct 2024 07:57:37 +0000
Message-ID: <77886bcb-9774-4727-8fc9-e8bf04c051d6@nvidia.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-9-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241030065149.2297405-9-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: db8cbdab-6df3-463f-54b4-08dcf8b88587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHpvZjVJWWlvZzV0UldLWlVTQlZpV200WS9xRFdDN2NOUGJlWDZKc0Q1OUJL?=
 =?utf-8?B?WE43cWNqT0lpY3dKUUkrdHVJaThUYmc0ejlYVmVNTVpwNkhNSzZ2S0tTdFJt?=
 =?utf-8?B?L3VCWnRmbDlkd3cyaEg2Z2ZUdHh3YjcxTERhS2FIZi9zenlmSEtvSThEZFN5?=
 =?utf-8?B?eCtZVmtWbk9OWUhUQkhZNjFhSTRieVZtRkRSM3dQZ0NnRVdlQmptdDdpZHdj?=
 =?utf-8?B?NTk2Y0pnZnhGMVEyRkVEZ01WUWNJbW1wdnJ3M0dyQ3RHUHVUTVhVZ3Y0MzJj?=
 =?utf-8?B?S1lueFpQS1BzOE5PTWdJQXdxNWhFNGdaVEM4OWVYRStmV0dsOHU4MTNOcDJI?=
 =?utf-8?B?ZVlhekdhYjZDWjlMMndzLzN1LzZRT1JBUlZHbTdJZXIya1ZpUC93Tk1TRmRl?=
 =?utf-8?B?R0RtdEtuRUR5MXJpNkVWS3kxaTdManFKMkNxcGhqdGdwQ05oUVVDeERYeVdF?=
 =?utf-8?B?ZVo0S2NGKzdjOFl0SnRsNnIvaHZ4VGZzc0hRYm1yNVFJT3djMUQ1UnQ5VE1y?=
 =?utf-8?B?LzFHZEg5QVIwSXh3SXJDTlVJejAxUGgvNUNHdWtqeDVtYkxxcHV5V1BGYURS?=
 =?utf-8?B?SEIwWE1xN2dPYUtnRytVTHl3aHRlR21LTWttWlVZVHRYdThydmg0VHJnS2du?=
 =?utf-8?B?a1BhNEJBT2pvZTR6dzBMdTRTMmpZM0FRNTF2RlNnSnF4R0Q5cWpuU0U2VHgx?=
 =?utf-8?B?THN2RitabUorbDZ0NGdqWnMzSkNpNzlCMUhqWFE5N2ZJVWcxcTdMUEZKeVhr?=
 =?utf-8?B?T1pyUWpkY2tsaFgrbEUwT29DczFsc3NMdGlERkdsUStpbEkxVlIwZGk2Uzg4?=
 =?utf-8?B?bFhTSmNoaGxxQ3JnTWF1NmU3NGpWeWdZUkR1YXh5cWJBK0p6OTdLNFhXMllN?=
 =?utf-8?B?OFFBOTR4cGpZbENUOWFMY3pxaDVDaFFsV2NDMmowT2NpMmtlQy9UUTFwVWg2?=
 =?utf-8?B?L1ZyR3BOM1ArN3BoQnhIN3pBMFZ1YU1OR3VtUE94S09ZYUFIUWlQNGptbzVM?=
 =?utf-8?B?VG1aaXBRdGU0d1YzZTh1Q3lmWndKMkUzZmNWMUxBclBDSElWWlhpM2xMZlJm?=
 =?utf-8?B?cG91ZlJwT2NraUcvN2ozSmhjQ2M1K084cXFqanBBTmdCTys4aDZpVVdPNUo3?=
 =?utf-8?B?aTJhQ2tUY0FDWUFNend4T2t3QytyZGM5VUVENFhET3dSMHQ0MG1rdDN1bkNl?=
 =?utf-8?B?MkRCWHg0MkMrdDVocGNSSm80TDUxVVFnQlBjSUdGRVl1WTROUXpDdUU5TDlX?=
 =?utf-8?B?SDBaaGd4WjRQaVNTUitLNEg3ektmcThxWTRZNHVXY2lkK1V2T3psN3NTWkdm?=
 =?utf-8?B?Y2lYVGIvVXlyY2preEJmNW9EYnpRS25pUlRDTzBrcTh5ODhmU1FyRnp1V0dZ?=
 =?utf-8?B?TWJRZERmU3FKR2RQNlJjdzJUTEk1eFg4SmFmVTBJUWRsYTlQdlRmNGduTUJM?=
 =?utf-8?B?ZkZMN2VvMENtUThyR3pvVjEvdXVtQVB4UTFyVnYxVkdKUHg0ZjIwVTN4clBO?=
 =?utf-8?B?MmN4NGNpRDhOMW1yN1I3VmVZTEhiNEl4TzFSQzRNZWZLdGd3aUo4bDhsa3Y3?=
 =?utf-8?B?YXJJRThzRlNtaThwZEVyZVdxaURBZ1hLZ083YWZIZFJlVWR6NFYzUk83YTJv?=
 =?utf-8?B?Zlk4dzFYTXkvRnkzVEM5emFCZE1RN04yK1c4NzcxM2J3d3gvNFNTUjB1V0M4?=
 =?utf-8?B?bXVGa2gzMFdLY1VzRWNoK3o4R3NNWjQ1U3FrNW9wYjVlaHFMV2JsMDA5K1Ro?=
 =?utf-8?B?S1RVVUo3Tlp1WEtJTXU1MS91NFdLL1FHbjBFZTRWbG9DN0hmckJKbEFBUmxW?=
 =?utf-8?Q?HypV8f5ziVDCU0qnuzgzpvRpZ/yDs/cg1/LeA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXRWcEpOeVV5QStsM3JWWWVqWURjcTRDQzN5Y0ZKd0NIbHkrTWtuQlFsUnBO?=
 =?utf-8?B?aUlWZk02bWpaeVgxZmwrSGpuaFlDaUMwUmxYZHhPTjFDTTNJRWpUVGlMbU5F?=
 =?utf-8?B?Mkk2K2ZSV01vNzBBdzV0UytKVklXUWgyeWxWdTNDOGVMalQxRSs2VTZYak1h?=
 =?utf-8?B?K0o1T1BlNmZ1Sm5sNWNGSmlDcXVxTEtOZnNxNFBIbGw4b3R4bXJxM3ZlTTl2?=
 =?utf-8?B?ZzMzdDFWUjU2V3haRDJiWG85NnJDRFN3S1N6SXZ5ZWZXRjRsQVRZV3pobkkr?=
 =?utf-8?B?KzdqcEdST3ZmMzh3TjlZdTJMMS9sc005a0hpUWRleWYvTjg2Zmd2Z29aSEk1?=
 =?utf-8?B?dWJZWXFvVGN6d2diL1NlaTBtZ09CenBFajhRM0FhZ2RUbkxjZWFBenAyNlBN?=
 =?utf-8?B?dlpKNWcxNW9ZdThwN1N0aWVUYUhKdm1yMmJIb0xlaEc3dms5d0FkOTgvcmxw?=
 =?utf-8?B?b1k4UTBLQW12Nms5N0dMVjRXc2MrOE1VS2JHK0lhM0NMb0FYbFR5aFpzR0kv?=
 =?utf-8?B?U3VpNVU5enlVbUdKZjB1Z2NESE5ZaCtyWmlWeGxlZGp2NEtNelo2VFBocVJN?=
 =?utf-8?B?S00zZTBpT1JEY3pQQ2s0cUtINjZycUtibkFyalB2dFFCUjNIMXh6TXJrU1Zk?=
 =?utf-8?B?LzRjZWN0VU5jcHNFNlR2V0thbU45VnN2NTNmbE5uNjRDK2Rma2VySG9zd3M2?=
 =?utf-8?B?a1V5Qm41VzNQSm9Cc1FxQWg1L3NuSTJUa0ZGbXdqdzFCYzJtZnFGTUlLZE8z?=
 =?utf-8?B?R3ZTb3c2RHk0V3MrYmh1WkZjZkVqSHA1UUNzU1RRZkV1N1hIZWpuYlpTMXNX?=
 =?utf-8?B?cU5tRHNvZE9oU3V1WnN4NnRhWHJwMWd6UjNXSnJHL3lPQ3BYWlRFQ0F4TDEx?=
 =?utf-8?B?dWg2M0RYcGFONFdXSW9nQnNieXd5NFlzMFVLbVZ5VlhlZitjZkZ3YS91QUZp?=
 =?utf-8?B?MVJyMWhjckZBQmdPWExFZm1KUXIrRkVkMmE0RDJTNEFJU2pOeDl6N3h5aEV6?=
 =?utf-8?B?anZZa2d1RjlrbUMxeHBuU1J5alozSk9kaytQY2hCZU9VSXFnSWNlQUlnUHlL?=
 =?utf-8?B?QXAzcVlzVE9OZXhIVnhpSDV3VGlpc01oL2JaM0hHSnNCOFV0SGFFWEJkVnZX?=
 =?utf-8?B?VHNScUQ1VHEvRzRnNVQ2RDVoRElUS0o5ZHNSUDdnS1VkOHcvMWcvazRCYmQw?=
 =?utf-8?B?b1FwekVFQk5kTzlYTmhYSE5zSVlJTk1kZVlTMWQ1N2dZbmc5UXZBWHJVS2FT?=
 =?utf-8?B?WC9ESHhJT1Q3SWtqNVFJd2hJM3VUanJLUUVYTGc5TXJrWkliS2hoUkw1SjhY?=
 =?utf-8?B?QzhzQ1lsUUxvcmU1dlhWYitNSDE3SUZRQ0ViMUVXd01CV0Q4aEU5T3REWXBE?=
 =?utf-8?B?M3E4NzlGMHFZd1JtdTNhSlBDZ0lHbjYwWUl0VHFSR25QemZEOGNBOTNFam9E?=
 =?utf-8?B?VVFKUi91eW1pMVhpc1NwWUhTQVE4TndLNTA4YXJncWRMS0pJKzdIQ2ZJdHJW?=
 =?utf-8?B?eGF2NzV0UnJzVm5CNFc4YlpCRHFSNFdhejk0UXhGYUxOSndaNlNGZmJzek1D?=
 =?utf-8?B?WlhoRTJOYzFxUmY0eWd1bUJBUDM0STA4SUxQWXUzZml6SFFkMGhPNnVZaGlt?=
 =?utf-8?B?QnB1R2Fxemk0ZlNBM3g1T3NVYkJuT1JHN0J3OXZTVWF5N2diWDJYdjVCNERJ?=
 =?utf-8?B?cEQ0c0lSOXBlMlh3NlhLU09qVFkvZHVqSlQwS0wvYTRNMTdLa1ZoMlpqUGpR?=
 =?utf-8?B?Rm1aTWFaNXVBSWVMaHRZMlY4dWFWNDVhWHRIOTYwaDh3RHg1MnFqbmlWaWEy?=
 =?utf-8?B?NGZjQmhvQTJxVVVBcUVHSUFhWEZFV2lWTk4wQUk0aTM1aDNwblFXc0ZhRE5R?=
 =?utf-8?B?b0k0dlJMeVNTVkJFbERjYUFoN2FDeUZlQWEwOWVpUEY5U3JvTm5PdnpPc1p6?=
 =?utf-8?B?QWZzaVBVRlZ0SHVwMjFNWTBTL1A5U0FLRlUxM1JDOGFhUUFYV0FpOFdtM1Zr?=
 =?utf-8?B?WFpNK3dPR205K1BBT0FlNTREekNYRlpraHArcHpFcDlZMGtwMTIzS1RoejZo?=
 =?utf-8?B?dGhyeEVrODVpaVh2czBUS2JtdGJsUlRhKy9TYUZsN0Q4bWlZQWZEVTZsUGpO?=
 =?utf-8?Q?j5GU0ONGChDa1/+/xJ/K9qi9H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E574F12CCB17FE4582F019298099DB3D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8cbdab-6df3-463f-54b4-08dcf8b88587
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:57:37.7401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsWxD4g9N2CYNxHuw3oR1wJ5nTmMTa7tE6DFXqngSCNdcvgDfETdH26KUtGzokb+a3PktRKrj1YiQUCao9UIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_005747_072426_B55BA85E 
X-CRM114-Status: UNSURE (   8.52  )
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

T24gMTAvMjkvMjQgMjM6NTEsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBSZXdvcmsgdGhlIGxvb3AgdG8gaXRl
cmF0ZSBvdmVyIHBvcnRzLCBhbmQgY2hlY2sgZm9yIHRoZSBjb3JyZWN0DQo+IHN1YnN5c25xbiBh
ZnRlcndhcmRzLiBXaXRoIHRoYXQgd2UgY2FuIGRyb3AgJ3NlZCcgY2FsbHMgYW5kIHNpbXBsaWZ5
DQo+IHRoZSBsb29wLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFyZUBz
dXNlLmRlLj4NCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWduZXI8ZHdhZ25lckBzdXNlLmRlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraTxzaGluaWNoaXJvLmthd2FzYWtp
QHdkYy5jb20+DQoNCm11Y2ggYmV0dGVyLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

