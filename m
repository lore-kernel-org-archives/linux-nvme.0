Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C03E6ADF9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnOFBZ244F2u0J7LP8qa+SqcfdR97tw1M0T0Gopu+qQ=; b=OkbB6a30yyepOcVdT2umBJ9MRk
	aWzL2Y46FUpBXl0XdzmchKjSHyAcviflFoBiJ2PEWZzivVQJmkMk6JWCQ/pvSYg1c2UjWLWMfTglE
	Kry3F+xDK2EbPFcGE9pkYRig8bBUt/8l3CAvHDkJ09e9yoGo0qdB1oedonj52/mvqCuCjUKl3esce
	011EbtRnkIdXxAUza5k07v2wcFgCGpQIjNu1izPpD4fPujEc5xynrgBa6I368Mjc/j6bRupCsKrxx
	okQclO38rL9bc+e1h42OGDZRkzka+31spnAfDNgXPMXBqm8gOrBBhFO8K0tXg3WLM74+3dHaS7cux
	BZKQDUeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXoBQ-0000000EDhq-22C7;
	Mon, 22 Dec 2025 22:15:16 +0000
Received: from mail-northcentralusazon11012068.outbound.protection.outlook.com ([40.107.200.68] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXoBN-0000000EDhN-2P4a
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 22:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ322bx/BdriHczJT150hHrLX9PYu/LM/9ZEj4Wwxs4977KS912Z1raqxcEQDZO7KH4ihAZkXl6yn99GRuOOyc3bgNegILqnm/6fPdAUiusDALatq4EalFUFnpzJIFfxjMWrsBoYR8kvu0yji4TrQJWW3Ao01D7y7gUhy49mHe4LNS0F8ApQFEez32y+zxKTyJSNDBhCaHl6pzKH8UJa+PQdNz0I8apPY0SWahesH3rF7AvkS/NDjsc+1x4YqUiTfNHdNovcGz/pQ/1JPSrPmce/D9x3+VphTPWqZX9PUjfyqF3waFaYhJ5SsWyKraSwObrPZQJn74A2h28Qq3AtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnOFBZ244F2u0J7LP8qa+SqcfdR97tw1M0T0Gopu+qQ=;
 b=ngIst/JiqdL3Z/stDPz43o01nhP7MmE+PYq0UARWrFqmxx31Uq0moOz2i745hdX7rcDItVW6Ox2kUYh0Gw+xJD0rEcBOpeKuIXzTRqSB85rCddEaMPr9XLVLhOfLZI+IaMkX19SJvj5hW3JCMJ51i31eegUxGnhIpAVKD9zVcTAzJcsWUDjERWGfO2BP8fxXQx0UEC0HVqpjNNIqkNqnoGmU+SGJddt6zFAgwfqxUI8EqVgQ2fn3wdsIOLCQjGWsffMqZhtPSt/kP/97VZkY5/0G3qKEWvdtoKhFY7Z63Sr5gWljg4sUGcpRugtRoV34VlGRgZd2CsGCzxyjVJNzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnOFBZ244F2u0J7LP8qa+SqcfdR97tw1M0T0Gopu+qQ=;
 b=NjTAxCIAUrLR8W9tcNQHKCKX3NNm0pGNvFt+jX+9A2yIqAC4maNkRPudS0rGM0vCFKPS3D3T9jKVbd19vmFRhg1igU2KwnChWFHHrA51w4lPQtaZafKwUGXfNV0+Gl33QAXh+ESVokNp7HHwkQrFOCjVqXgjS9Ei5DkhKXozs/gwq32UI6Njb7i4QYIATgMpQLwY1uFwZJ7X/TiLpgysUOQEtirjlpoprAxdhHTFU94oPfwqtnUG3XFwHK/UOWujE1DVJ+UApmBbWKuQUTiJnTnaPkGOYGANMV/M/wVoQNGnZ5pBSlvcIFAfp2ljPMxMFI/Q52W4Ff0lIpGEvzhStg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 22:14:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 22:14:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvmet: do not copy beyond sybsysnqn string length
Thread-Topic: [PATCH] nvmet: do not copy beyond sybsysnqn string length
Thread-Index: AQHcckynYR0eNRK8S0e2OFeRQyRiqrUuPDSA
Date: Mon, 22 Dec 2025 22:14:55 +0000
Message-ID: <16a1f6bb-61ae-4d9f-91de-fa0a91c99731@nvidia.com>
References: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6410:EE_
x-ms-office365-filtering-correlation-id: a61006a6-6dd1-48b9-d67c-08de41a78989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekhHRHJqd2N0WFd3R0ROUFNDRDdQUWtpUHlLSjVxbWZmL2VLdm1aUWdRVkpm?=
 =?utf-8?B?V1oxUzJ0RVAzVms2NTNnbTZRTVZuZWMrSUl0R1Evb3B3NnVyUmQvQUczL2tU?=
 =?utf-8?B?NmJYTU93T0RXcXFrbGRKZXlyTmxFWER2Tm8zQVpDQnF6b2JWK3UrNUVHOG81?=
 =?utf-8?B?MW0zZkFhU1FER2RIR29vcytDMnczSGtHSERzMC8vakVNMGtaK2kvMVJhR0Fs?=
 =?utf-8?B?WjFUU3RnRjZGa1dYUW9QRFhnc2tqZTgzc0gweDV0LzZFeFdjVEFMZW40M0dC?=
 =?utf-8?B?OWttZnd4WW1WNTdoNHdjTG42WlRRVVNHMGR6YmhTckhlOGtZeHFieUdYYzhP?=
 =?utf-8?B?dGlTWFppMG4zd0lHaVVUd21lTnFHRnFISllCd0kxYjJ1WHhrN0hSSStMdVJl?=
 =?utf-8?B?SlFGT0VJWnpBMnViMjFjVzM3RkN0SXRtVVpibzYxdFQxMGdWYzhyeFFYdDZX?=
 =?utf-8?B?cFdrUzh1THMxVUlRaU84S1JGUitYemRCS0dISFlQSklMMVcwOXh5S1RUbDQ1?=
 =?utf-8?B?ZllmY3dJOXYxZzNFMkJZTS8zNkVRTE5QaVlUWDBMTVp4clRkdk9CNDFlVTMr?=
 =?utf-8?B?MUpMdVMyOU9ZWmpqN0Fia2c3aHBSZFBYcExNSzFPNmg5eWFtTHZaOXV3NEdC?=
 =?utf-8?B?d296REZyVS9IWUlQUWFaZmZnUWpFblBOOWdLdDNnU1IySk1VYU5EL3k2bjdW?=
 =?utf-8?B?Wmt2dG9aYkNUbmNvLzdhQ3lVMHZDMXR1UWxydzZSSFVvczZnc0RCaVVCN1lj?=
 =?utf-8?B?NnBVVlpjbFphVWlKcFVNNmQ1SklIZHBRbUVsVnZuU1RZODF2Ny9UYWlMM2Rs?=
 =?utf-8?B?UFJLSExJQ2ZLSy9FMHBGYlhJUXJ4V1Z2N1gzUE9HZDlERHNtQVV5QUVDRUto?=
 =?utf-8?B?M0xsMFE0SkZGK1RVZ1MxMVJiYWVhVlg4M25qSDFyN01Zc2k3Z1EzS2V5cVBH?=
 =?utf-8?B?T28vdnROU2xZTzdzdnhIK2xMT0NXUE5sWm9Tak0xUGN4dXdoUDZTOUZ3TFhz?=
 =?utf-8?B?NDJVaVZic0laNDN6Q2hGM3YyVFNFcjVvTEtOK2FDZ0JEV3NIWWE4MkdVN0Zy?=
 =?utf-8?B?YmdobjU0Y0d1Wk43WktiQlVQdmdSV0tYd3V6M0lxOVdVNTlxNnphS3lzTkZh?=
 =?utf-8?B?T1lBZHJ3Q1VoWEIwSlpudFF4WVVqdkx5YkdPZEJDR2twVno3YVR2K1FUOFpF?=
 =?utf-8?B?aGdWSGRTWG5iVjB4MjcyV1RraXJpaE56aUo3YzZxTXdkdkU4SlJ1OXFPVUFy?=
 =?utf-8?B?dzRNMkg3WFZVMlpMT2xnU2lCaHhZMnN4eFY3clBnZ3lETklZeVNMbU9Fd3pi?=
 =?utf-8?B?eUNpY2NYa0hSSUhWTisrV0xIdURURTE0c3NxdTFTSXJmbldlWXd0SW9vMDlG?=
 =?utf-8?B?MmpRV2owNytocEdnZnZyNjhvMUcwVUVMYXN4OHYwaVRKakFNUjlFZUNTZk1F?=
 =?utf-8?B?UkVjSkRINllZZXRDc0VhU2tscStxZUZLdDZhM0VoZWFsTUtqdEtrN2ovdGd1?=
 =?utf-8?B?cWNRT3Z2czRGSWdRemVNYXYxZ2NYRjlKTnQzSFV0VnhEbEF6TW1TT0VrbTJy?=
 =?utf-8?B?cEhmR3NGaDRlSWFiZ09ucGRIcUk4R0ZlRm1Hazd6MHhQeDNWa1FpWUVMQzc1?=
 =?utf-8?B?OGgvcDhKeExVbmZmYUFxdjltT1F6RGh6VzBTNDU2TzlMS0lUeUdMd2ZWQ2NK?=
 =?utf-8?B?UlNEM2NRalprYWdwQmNuSVFlaGVJTFg1Y0ZDRnBGZEl3V2hPZjFSWGJJbFAr?=
 =?utf-8?B?L1UvRHlHbXRNQ0NqNWtzQXl0bXB4ZTdoenNhVmo3SkY1SXdwdWRMSDc0Nnp2?=
 =?utf-8?B?SE9WbEpGQUxxRm9nRkFUVFg2a3JBQ1FFekV2dnF5UlJITHdQeU5NMkd6UnNW?=
 =?utf-8?B?RlZzemVyMTJ0UXUrOHZoY1lkOGRObTkzQTFZZlFEK3RDdmlWT3FOVjBtNEtq?=
 =?utf-8?B?NWhxTmRFVi9EeDdaSlZIMWZ2bm4wUFpLUnc3bVdrOGVrOXkwUm9nYWR1UFhC?=
 =?utf-8?B?dElBa3hzL2tjUVg5SXFuZGlrV3VveE05WHJBTTZ3cFU2cHZLbDhja0pCYzhy?=
 =?utf-8?Q?b6jxlq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Z2eUh6WWlYc2ZUTFlQYkY5NlBhNXkvVkxSeXZNQzZzeVRsRTBFRmR2bXZ2?=
 =?utf-8?B?NmJ0N2EvaHpnRUZ1WFZhTFFoMUNFNmg1V0ZDcVgyVmdMWlIrek04TEU4eHNX?=
 =?utf-8?B?ekJidnZkcTU3aEk4SGVxNlFTMjNQR2dQSXBuK2pHNStDQzNaN2llbXBiNU5j?=
 =?utf-8?B?bnY3SU44d1RkaGltVWJjcU5WdTZJdVhIOEJjZmpaekhTbEg5eUxBTEF2dWJB?=
 =?utf-8?B?VTNVSDROL2V2aEZ5QWU1dFhxVjlMclVpeDFzT2c0SkhLbVc2S0dpVDIwQzlX?=
 =?utf-8?B?bFd6a3RMM3pkZGhCbnZxV3lJZzU2aEVOYm9wbjB2RXEzeEZ5dCttbmR6Rmli?=
 =?utf-8?B?MEZESFRoem4rM01sbEVVbzlZUWQ0djl1QjRPNGl2SzVMRG5wMEljZlQ5K05W?=
 =?utf-8?B?L1JFcmpmSE8vVUNxdlJadHU5RWpidXdjd1RlNXo1THJpSUhsWkZFQU9BTEpn?=
 =?utf-8?B?L0h2NU80UnIzc01iUVRQVlR4SVpTZ0ptVXRadm9vVms4aWxrdVlCK1hIMjZG?=
 =?utf-8?B?SUQ5T1JiZXhkQVNaZi9XME1YaVdPSnpHREZOK2lyK3VVR09uS0d1WEM3MW1q?=
 =?utf-8?B?a2FwZ296S0dZM3JycGZnWlNaYU4rRDNpdXlxcnpORjYrMktMMURveGhmYTl2?=
 =?utf-8?B?ZGRKYWNXTnVmMjhwVkF0NXoydFpVaWw2Y3FrYStlMHV4Z0hzZlk1Q2FUN1JT?=
 =?utf-8?B?M0xFUXN1L2ozQmQrS1VvdXRuQkdka05vejkxTzRpcU1xby9lM3F4R0pBalcv?=
 =?utf-8?B?YldwQ3lVQXNuMnlKMVNQYUxlZzZYdm5CZ0dLY2FiSnBmOFNiV04yVWc1dlRK?=
 =?utf-8?B?MEdSVnEvM3hFYmEvVXRwMkhqNXpoR3l5aUVWaGZsdGFwTVE3NDRScGVRbGh3?=
 =?utf-8?B?YU5EUnl3TUtDalI1bFFhS1VOL1Bkd3l6cTZBQWkzYXBNbm1nc05EVkVlK1RF?=
 =?utf-8?B?eWNmZjBZbnFTay9vVDVHdzY2d1hsTjlpdlhvcGNSbmJLeCtJdzJMWHVKNjZm?=
 =?utf-8?B?eTRyMVhmREo4M2hDWGM1a2UzdXNnbkFQQlJzSkpFTVdkMDFsYkxQYTJJK1V2?=
 =?utf-8?B?VGMvYW5aSGo4SlUvTUI1UUhCSTJER2VpSUlFMHJFV2pzM1NrbW5hTlBxamtj?=
 =?utf-8?B?UHJob3JRSkF5MEliSWVmTWpNT29RU0c4MEg5ZEs2MzZZNU1WckVHTXQvbGY4?=
 =?utf-8?B?ZFRJSlhmc1Z6WkdKaXV3L3B3Z3pvV2JIbDJWeGFJamo2dmtvVWJOS3dNR3U0?=
 =?utf-8?B?V3NLMmcvY0s5UkQ5Vjg4WW9tbTcyMG5EUTNmQ1MxeVlhSFNtNy9wQ3NuRXRF?=
 =?utf-8?B?TUxKUmRDenM3LytSU1V4Q3JRMHlhbC9wdXJnMzBvV0hHaDlFdFRhSkZlT2hK?=
 =?utf-8?B?NHRGTU1tQzM4ZStrZzRXRFpyRTMvdGMwQlRZRjYvVUJYWTlrU3M4YjRHcW5q?=
 =?utf-8?B?SXhpbHk4dU1XZ1RyVFZFZ1o2WWI1R0p5WTB1dlBmZzNjc1BsV0tuZjhwZ0Nk?=
 =?utf-8?B?U1VDekpOUXorMVNOQnpYY0c2dDlwM1Q5dU0wV01iWkNIMDZFTlIyQTdJbEdz?=
 =?utf-8?B?RmRsTzh6YURzYWR3cFRVNFNVRk9vaGFTTE9aRWx5Nk5uaG1PR05nSVY3ei9I?=
 =?utf-8?B?aGdodUdIeFZoK295cDl4NDJUNjV1NUMxc2w2MTMrVjRQU1FSUWg5K0pMYW1k?=
 =?utf-8?B?RlEra3ppZCtMem5velB4YjFnUEk1enovT2tvdU94VjBRTXRlQjVkK0FYYUhq?=
 =?utf-8?B?OHdaQTBuRUpFSkpVeGZmQllXa1JmTmdPWXZLSlZKZjRzMW1hVGVyWEFpcWJ4?=
 =?utf-8?B?ODB2blFiWTk3aXU5MGVSdXE3d1R4c3VOTlZpNS9LeXRkWnIvUm1rK2o3eW1L?=
 =?utf-8?B?b0tpMXl1eS9LN29PVXZ3QTdoV0hzb1Q5TVVHSWhEb2prUkZidHFCOGNGMUMx?=
 =?utf-8?B?cnNpdTJnV21wWkJQcGpCS1ptNExFa2VtTXlVMWJUVUltVEtUZFJsRGdzMVkx?=
 =?utf-8?B?cTZJQVdZend3dExIT0RUN1UrNTlQdzVnT1poYlcxTFY5eWsyTmowcG1VSVha?=
 =?utf-8?B?KzQ2WTU5a0tlZTZGTFF6MGZxcmFYaWcza202c3FrbjNqMi8wRDJFWjZqdDJ4?=
 =?utf-8?B?c0hvb2ZzeXJXU3JCbXN0VndYbk54dmdVVVAvcTlTREZiUTB5Y1RJODFzSWVa?=
 =?utf-8?B?Q3RKd0lBVmZ2bVgzYXlkVFNkenhHUS9GRXlMV3NTUFVOVGxlZDk2VjhtMzA2?=
 =?utf-8?B?VjJId3d3dk8xWHIyd1ZIcDZORExMQkJYZ2VLaTlaVFk5ZFQvc2RRV0VuY1M1?=
 =?utf-8?B?eXgzYVc0aUhBVEFvc1BMZkNoaWlXdytoSzJLQk54OUtuZXRKeGs5WkNzWDZH?=
 =?utf-8?Q?TFOAy+/kY1VDURIRYhgpFji74qStZFUMyKbZL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <892578508773314E8A8516976AC264CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61006a6-6dd1-48b9-d67c-08de41a78989
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 22:14:55.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4Nowj8P7wnY4l27PWHTC+/nS/HlLNp7FEic+zQomxHWjf1MKfyvNz30imVsislM6ai7j3dngej+4MBqKnIGDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_141513_626886_BD07120C 
X-CRM114-Status: GOOD (  11.48  )
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

T24gMTIvMjAvMjUgMjM6MzcsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBDb21taXQg
ZWRkMTcyMDZlMzYzICgibnZtZXQ6IHJlbW92ZSByZWR1bmRhbnQgc3Vic3lzbnFuIGZpZWxkIGZy
b20NCj4gY3RybCIpIHJlcGxhY2VkIGN0cmwtPnN1YnN5c25xbiB3aXRoIGN0cmwtPnN1YnN5cy0+
c3Vic3lzbnFuLiBUaGlzDQo+IGNoYW5nZSB3b3JrcyBhcyBleHBlY3RlZCBiZWNhdXNlIGJvdGgg
cG9pbnQgdG8gc3RyaW5ncyB3aXRoIHRoZSBzYW1lDQo+IGRhdGEuIEhvd2V2ZXIsIHRoZWlyIG1l
bW9yeSBhbGxvY2F0aW9uIGxlbmd0aHMgZGlmZmVyLiBjdHJsLT5zdWJzeXNucW4NCj4gaGFzIHRo
ZSBmaXhlZCBzaXplIGRlZmluZWQgYXMgTlZNRl9OUU5fRklMRURfTEVOLCB3aGlsZQ0KPiBjdHJs
LT5zdWJzeXMtPnN1YnN5c25xbiBoYXMgdmFyaWFibGUgbGVuZ3RoIGRldGVybWluZWQgYnkga3N0
cm5kdXAoKS4NCj4gRHVlIHRvIHRoaXMgZGlmZmVyZW5jZSwgS0FTQU4gc2xhYi1vdXQtb2YtYm91
bmRzIG9jY3VycyBhdCBtZW1jcHkoKSBpbg0KPiBudm1ldF9wYXNzdGhydV9vdmVycmlkZV9pZF9j
dHJsKCkgYWZ0ZXIgdGhlIGNvbW1pdC4gVGhlIGZhaWx1cmUgY2FuIGJlDQo+IHJlY3JlYXRlZCBi
eSBydW5uaW5nIHRoZSBibGt0ZXN0cyB0ZXN0IGNhc2UgbnZtZS8wMzMuIFRvIHByZXZlbnQgc3Vj
aA0KPiBmYWlsdXJlcywgcmVwbGFjZSBtZW1jcHkoKSB3aXRoIHN0cnNjcHkoKSwgd2hpY2ggY29w
aWVzIG9ubHkgdGhlIHN0cmluZw0KPiBsZW5ndGggYW5kIGF2b2lkcyBvdmVycnVucy4NCj4NCj4g
Rml4ZXM6IGVkZDE3MjA2ZTM2MyAoIm52bWV0OiByZW1vdmUgcmVkdW5kYW50IHN1YnN5c25xbiBm
aWVsZCBmcm9tIGN0cmwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraTxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

