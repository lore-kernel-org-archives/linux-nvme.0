Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2E2E6C619
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRAXOA9FnoQAcCBBtWCU/byr6Qa6oRoF0LYqzpCAUWA=; b=ZkUbzMj/MUNaDGI3wOcj7d60bM
	KUtQCwivir61Hy+BVCcWq/g1UR4f7BDHzYX8KeVPTZbn9b3tRvGsflOxYOJsMb3BQHliXdP38O5sy
	ulMk7rgDloNG2ho8JHQOTZG9BSW7lNwhVyiG1ltCP5JdPPHtJiT0k17oIwh3KwhJDw9YMRyL5lbBe
	oUh3Sn6kN8GEEfAqICNtSp2TlfcHP5RFlsmR/FmljCI6H+0egSEeMKtXFlLt0ct/+YvrvGnMzpq2Z
	LjPNhNoQ+AdoLsWihMwLm5Ooqm0inG770LSnKAZtSFqXO3VdGN6f92OLVLmg8BB27wWsUFPKpYCR9
	RLRGXWCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOXm-00000008jvE-311N;
	Tue, 03 Dec 2024 08:46:06 +0000
Received: from mail-mw2nam10on2061d.outbound.protection.outlook.com ([2a01:111:f403:2412::61d] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOXj-00000008jum-3dU4
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 08:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjUXnmg9TEA6TM9BbL8ycS4EK/xQh0RzQ8gFNpclyDqTSoqHLbFgoe19yDBIqkuNfst6cgkSCPoX1vYO0ieQa7va9O6NmvIiUF0qwXyAMaZQlQ4MoF/PUmiZawWoauGpyOmdJl9atg6HohAuyoqBp9K9DHL8Me0Lbr2STYyb10vQ6L0GAwkxOEKSlattsjCY+5Fv+zmNqkX9YfkFCY7b8l2loSjaRjO1sdNIrYTf5BGhKymJ1+F2L1YSEGFOxckb0eMwYcvk9C60ymTGYm5FFtIn5N5s0eWarnmjGs9uSf9R+6CTJiF1HqriJx8oBjUgxz/krTuNw53V3PZJZi4sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRAXOA9FnoQAcCBBtWCU/byr6Qa6oRoF0LYqzpCAUWA=;
 b=j0ygwL40eJQp1cKskL4Pr2lfi5iSoKzcEbPSFj9TcmAg1/DnqwBCqiDQaGyRConD6k+QahxRr1DVHAf4PNM3NpwBgrN90OWel9ckCIdiQWLDHrOBldyab9hqiPeC+IHF9R0ZfAao/fx9fesEJ/44N6cs+hdVs++iWJh/n4St38ypQ+pHU3z4jNbz6O3ouM8pFfxNPRrgey+F7DgB5RkRJaLvcXiVLwENecqfE76Pc12Fwpf2G8MNNoHlESh7/WHAA0zAXf9u/7TKRwowXOOj3b/y5g+eGCD8nQUZp6Aeg0i0Ay1Z7LGJvdjIz/IUHDS9j+m0WxmlbE8dfHiJTmyo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRAXOA9FnoQAcCBBtWCU/byr6Qa6oRoF0LYqzpCAUWA=;
 b=UdK+9o+CJ6g/VFxQwQgZJuo7GxaPIm4PB0m780zXuK5MjPub+qO6685df1SvIUlsmpkfZ5AX2QoPkNAA9m9jw+mNq1qI7X25wlQ8HQ7qiErlP2xI38Ej1413oPbYWBvoxcib/tGftVebtEPI6QIeTKneLkJnNGECatfOSkQ51X19uVR00lEKmjb7e9ekt9CiwK7oHGXeROqVmY0GkAJlvNEsrxnBIYND4HIjTd9lI6gDdXKMPEQyyCcytlh/EsmF5pJykuLy7MKXnloLfy18lN91rSHbm25qVMv0u8yK3mVUoJFhp4AWIp8qETvab3mRRkrMG12KLIY4rspXub/WFA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:45:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:45:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH] nvmet-loop: avoid using mutex in IO hotpath
Thread-Topic: [PATCH] nvmet-loop: avoid using mutex in IO hotpath
Thread-Index: AQHbQkxTR770MLfe/06jpK8iRhD2ybLUOvIA
Date: Tue, 3 Dec 2024 08:45:58 +0000
Message-ID: <91eaade8-7de6-4a0d-ba12-81ab5d3b3861@nvidia.com>
References: <20241129104838.3015665-1-nilay@linux.ibm.com>
In-Reply-To: <20241129104838.3015665-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7322:EE_
x-ms-office365-filtering-correlation-id: c2714ebd-c943-490e-97e1-08dd1376e8cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0pCUy9BNnZORzlkcHFGT0M4a3NqWkNFSzhGUEtKWFE5anFXS2VCZ3orUmcv?=
 =?utf-8?B?eTRyL2ZUZFp5OVNhMmxFeEc5dlIyVlhna2hwVEFxcjNZRUd1TEdNZEwxcUhu?=
 =?utf-8?B?VUp2L1hYSTM5Tm8yUUI4T0hLWSswRXd2ZnJRUFhpL2dyeUttaVFyRFhnZ0l2?=
 =?utf-8?B?bE9YVEZ3WEYxRGRidjVnL2RkaTZDU1pKeHllSG5vTmp0TmVEVHh6Tlk5cTJD?=
 =?utf-8?B?bTFZUCt5Sis5bHJZSm56cDJheUVKcjBMRWl1cVVQQll2ZEdZSDU3Sk1PamlX?=
 =?utf-8?B?ZVBzL2EzZU5EYXJ2TXV2bDFsOUN5MjlBOTJWdlB4aVRaWHNvVGp5RVVMMkVG?=
 =?utf-8?B?N3pqSWJkYTlwaUFiVTBndXJQWEdyVFRZdTVRU2plRW5LVkFXZmFmeWJnM1VV?=
 =?utf-8?B?RzMzMVpCOEtxM3JCdzIyUTd3M2JobVBNSDVXNHJ6ZFN3cHZNYUZObVp4bUxT?=
 =?utf-8?B?bzVkNmJUY0plMHZSZ29rM0hTYkQ4a0MzSEs1cnhuc1A2VFJ4Wk45M1NlbHZF?=
 =?utf-8?B?eDhqQllzM3N6cWJCNy9FM01ZQm9ubW9LYzNUV0U5TG5iN3hRU0lSRUNIK1N1?=
 =?utf-8?B?TGZqOVdFM1o3M2VRU1BzeVlqdkdBQnJ5VVBsQ3VDMzRaWnJJSkU3R3JjaFkz?=
 =?utf-8?B?VmF1ai9sTHdCYkhrbHRRWG11Z0dESC92Z1JEUlA3c2dBdW9naDRFTmNlNm1L?=
 =?utf-8?B?NVc1U2hPVGlyKzFYZjhNRWJ5di8vS1VzUklvaW8yQjBHS2tMM0pkRUd1dmdP?=
 =?utf-8?B?Tk9VbW5CaktPc2RTREUvajNjS0ZoQnNOeEpKUG8vYW8xMm4yS0hFam1BUVI2?=
 =?utf-8?B?ZEhFbmlPeEJNWXp5UXQweW1XUDBGVWJRYy9YZDJ3VU9kdnhybGhhYnBkNStB?=
 =?utf-8?B?SW95czlZVjZabXQyTEk3YmtiOUZBMzNjbFlpbW1vTnpnQ0ZsNFU5TzZlblRC?=
 =?utf-8?B?MysvQVZ1K0U5UHB1RTdaTEwxQXlEc0txUDlDakI3dy95czhVWFF1MXhDM0t1?=
 =?utf-8?B?TlZWQW1oNThGdy9nZzVDNzd4dCt1bDdkL3lwa1hCUzhMVHNSR0VyUEQ0bFpC?=
 =?utf-8?B?NlFVTUZVTzVPZCtaTjU2QnRaL2JRM0xtZjZVTGNKK09vcExPdE52bzYzd3pj?=
 =?utf-8?B?cGExTDlLMDJFUjk2bytodllQMEVSZHVnQktxSzdHb3RXOEJBYS9KdTRrVDd3?=
 =?utf-8?B?MjZqenRUWHZWelNmcGJMRVcrTklqbmxienhEbnJXOTkvcFlHOGNQQm5scyt4?=
 =?utf-8?B?dGt6cWhDMjFCYzhieERDeHBxalZFaHJKMW5tb0VUcjUyWGJ2SWRjSTVIZDAw?=
 =?utf-8?B?SnpVUEVhb3p3czJVOUd3WHBPckZRRVFDQnhEMW1jZXMvS29aQWVwN05JeHRH?=
 =?utf-8?B?SmFEMzJ5R0RTSDRoUFljUWN0R0VzdHlVbmtKTFc1b2E5NHZSOEtJajYvS2JR?=
 =?utf-8?B?NVVMMWhPVjhZNS9iN2RkUmwxU0F6RzhpRkNIQXV1MTBrWXZZKzQ4bC83R1lr?=
 =?utf-8?B?aGhiZnd5QmNEdXcya0lnd2xFQXFRSXFTak11c2YxekdmMUVaa2lRaUEyVVFo?=
 =?utf-8?B?Njd0SG5zUUg5LzlSMnlVOUl1Y3JIUUpVWDJtNm1yTHhHM0g4NnNXVVdPNTdS?=
 =?utf-8?B?S3h4VDlMcFFwckJBLzBHSFhpNHJJeTVGdEFBK3NneTJxT3B5cm1IeWdWQ0RL?=
 =?utf-8?B?VXBVN1hVZDY5cHRHc0J6Vm9yU1N2Qnk1TTMxU1NhNE5DZGwxTHltdU8xSU16?=
 =?utf-8?B?QjhHSHU5NzhqRm5KN0pYMnJibElMZ1hoVFpHQkRHWktBNyt1U3RoZ1pOTlh1?=
 =?utf-8?B?b1ZXdFdKWlNHUmdURHRnb2tXU1NJZzhHSHFQUVFwLy9wTWJweWFBYXNoUTkr?=
 =?utf-8?B?YnBGd3FKNERjK2FRczZpTzZHdm5BaWRiTjEwV0IzS3lhQkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFBqbE9tSTlEckt1OVpKcFpnYWhjdzc3RXgrdFBjK1lPWkUxa0M1THRJYVRj?=
 =?utf-8?B?Smlidk9MeDc1VlQzV3JUcnQvSGF1aVRHYnN5THg2aUNaOU9BV0gzc0JvOEZD?=
 =?utf-8?B?MDhSeFA1NFRoN0ZEMlFuMUNFL2JQL1RoeVN3MHc1Q1dMdHpsRTg1WlNoQXMw?=
 =?utf-8?B?UGQ5VkhjS0VoL093bHR6ZHdxalZEaHJWdjh2blRPOWJobDNMcE95K3grYUd0?=
 =?utf-8?B?N2Fja3JwSnpOZGxJbjVpenF6UjUzTlZmTXJBTnFrckJmRWlSSlFSQUhWc2sr?=
 =?utf-8?B?bk81Um9USXlDSlJnM081L1NYY0dEdThKMGJhaXMzN0JLZ2RyV0RxZW5icFNO?=
 =?utf-8?B?ZmxNaVMvL29ySWkyc1hKeXJLVjloYTlHOGpGR3lIZTUvcmFUQm82NEVFc1dG?=
 =?utf-8?B?cDhUZFVoN2U0SC9uZmRaMmpsa1VvNERhM2gyRG94Nlg4TkxsTE4yc3dTa3NI?=
 =?utf-8?B?UFdBWWMvMUhXZ0t0ZjlJL2tWU3ZnakUwMWdEcENEOEJ3aWZSeHJ0OFFMN0kv?=
 =?utf-8?B?U29SckJPY3hobmcyT3drTEdjQ24vUm9qNC9yZzZoUnJocHo4a1dTanV0Yjl2?=
 =?utf-8?B?SkNXc1R0SHVRbGRCU1hSdlhkc3p5aUhmbkowMlJNY283cnIrSy9hRjBFUlRv?=
 =?utf-8?B?NGdPWWd5RE0xdFFhbkx0NlliaEVDMnd6Vk1abzZ2NG5iWkVueU5SUEs1b2Iz?=
 =?utf-8?B?ckgzazVqQWg4bUJRNVFnQTd5aW9BQ1Btam0yVWhncFVrMnJNTGhYV2RZTUQw?=
 =?utf-8?B?ZEtRZE5vdWdYN0RjaXRSRStXUWhtdnVOVnpWUXRrVXZrK0V3RUl4dFlVVVQ1?=
 =?utf-8?B?THZIcXNhVjIwVEJlbStpczZ3Q0NtY0U5OU0vU2lXM0YrNlgydzJjaXpuY3hQ?=
 =?utf-8?B?ZGVZbW4xZnpvUFpCd2c2d0pwVnU4ZDFpV29JdGx6a3JqMWZ4cSsrZ09JUUxw?=
 =?utf-8?B?ZmR3Z3BMQUFzQnNqeXdndndZSDgwV3JKRFkxWU0xM0lLSStOVm16UTVrSXh6?=
 =?utf-8?B?ZzFDVlp4NnRGaWlONUlGaEdDMm1VeWhnYU1hdWZ0QjdOcHRaeFk0R2I5YXBS?=
 =?utf-8?B?NFVLYllUbnIvc1c4d1BCeHZVdVRzZVJMQ1A0Q3BRRXQxNUJLaUZzcUVWS3Aw?=
 =?utf-8?B?WEtsVVR0MXZCRkdZNHVvWlVIK2xGZC92a1hmMlYwRVVaWW1DWVh4bU4yd244?=
 =?utf-8?B?a0ZZNVBsM3lpTTI1Z3hsMmxxWGtvL3VnOUdkVHBnZldGT1FpdktiMjA1Zmx6?=
 =?utf-8?B?M2YxNW1aTHJoMnVEREJscWpwUjdPUFN0WDE4Q2JzTit6U1AydmdWVHI3NVNl?=
 =?utf-8?B?c0FLSWpPQ1BvTnhEcFNkdyswd1MzZEtZZzgxVXJLSmdlVG5BV0k5aUdmdzFK?=
 =?utf-8?B?cEo4MXBBMHg2Qy9ITFp0eHpVaCthVjVtZXR2SnFNTkkxTSs4bUZBNndZekNq?=
 =?utf-8?B?MkVhYmt0UFRCRTRrUWtxMThibEpGZTJnZWtTQjJvQUF1QkgxSms3K2hkK3lR?=
 =?utf-8?B?MXZIdHd6aTJrbW8rMmdFZzBOT0tDM3FTKzJzTkV4MHFXTy9rWVhma2oxVFRN?=
 =?utf-8?B?TjJQOTJWR1llZkNHNHRSNDd6TVNVQVJ5M1JsdVdmQmZ5T0tNeExFQ0VkcGNI?=
 =?utf-8?B?ZXF1VGFkR285Yk5ZajZRVmlQOTFRdXVkaSt5dGYzZCtZdEx4eHRyaWFYTTRR?=
 =?utf-8?B?R1lYSzFDa1A1OEVyYzNPVWwxTnEydGlXbEJzdlhEYXBScWQ1ZStmN0wxb1BU?=
 =?utf-8?B?SkRNMlphMDJ2VkRGL1JPRi9MOERhZnBXYVQyc0VBczdweDZsbW9ZQ0hncXQ2?=
 =?utf-8?B?ekNFYnpoVElTeTNscUpGakxDRXJhMU9OSG1XZkhvR09sTmRyY3BuQ0NzakdG?=
 =?utf-8?B?elNhRjNnUnRjVjRsWUloR0VueVBrVWdlc21MMzlXQlloVkFrRnpwWC9lTFc0?=
 =?utf-8?B?Qy9Ib2FnNFdKLzZsVGFXSmFoVkxMc0ZCdmg0UUlvM0RmRUthNTlCRzdFS0dK?=
 =?utf-8?B?dGJvT3ZiVzF5RURBc0FkWmo1Z2lLdFlBOW9XQmdGZVR2Z3FZS0tPbWN2Uitv?=
 =?utf-8?B?aW4xN2EwNCtCc2xDM0xkQmRsdTlnVytNaTE5a1BQdUpLcllYT0tOYW5xQXNG?=
 =?utf-8?Q?Ul3bHj9DLBz/ZXMMmHD5dMStx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF2AE47D7E9F074D8873EDE78A21CBB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2714ebd-c943-490e-97e1-08dd1376e8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 08:45:58.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8hzy9ckkRVQ3q7l0U5qoFVUuidw8KT4CyJNTuQztmo3uhwj7t7ssxZLsUyy3Ezo9Aq7Rrhs5oDBgfMYnyYYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_004603_902347_85889246 
X-CRM114-Status: UNSURE (   6.14  )
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

T24gMTEvMjkvMjQgMDI6NDgsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gVXNpbmcgbXV0ZXggbG9j
ayBpbiBJTyBob3QgcGF0aCBjYXVzZXMgdGhlIGtlcm5lbCBCVUcgc2xlZXBpbmcgd2hpbGUNCj4g
YXRvbWljLiBTaGluaWNoaXJvWzFdLCBmaXJzdCBlbmNvdW50ZXJlZCB0aGlzIGlzc3VlIHdoaWxl
IHJ1bm5pbmcgYmxrdGVzdA0KPiBudm1lLzA1MiBzaG93biBiZWxvdzoNCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==

