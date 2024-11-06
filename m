Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF616D1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kpVboRcEbRvnCUX2/61h+P2cfMl1YSZBPtrr4hWniTo=; b=hBHVbMdRx+3g9f+fjqQ61Jcu8K
	45LPtkmWO92OmzzgtDCbBR/e9XIn6S+t0uGlFweIoBfZIFzSDvHoh0sZq4GKV/hOF/ll1C0xskKA2
	hDPhcaBqu2T7hwr7nNYIpUs0jm292+f2uoE5CqxwYDemMaK/IJPabz5YrAi3tPQ/MBFI12Jw3NVD5
	J0A7WWCCbTvtDI23nvvjji8M468+JSja3A279mJlhXuE6P0P1usPNIwSUM/kDPnA95rQr8FiOC7ss
	tiTk39ERzKoQQXt6Y8ebiBsw9jIXRy+7I5+sqsQ3v+6MjI25TP4B9a6RznEePgdEC3dvWIkWdDI4r
	aDEVhoUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YOp-00000001qEb-34Xh;
	Wed, 06 Nov 2024 05:16:11 +0000
Received: from mail-bn7nam10on20617.outbound.protection.outlook.com ([2a01:111:f403:2009::617] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YOl-00000001qE9-2GFQ
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubg1mSW49DR/fgHSgVol3fLA4TN3nvcqP0jaMtOJvdvTpelWYAaSb5GoLFGtXtYeKVgud83Tronp0gD0ylclXREAMeBHbYPMgJuLSONdha8dDl7xwmPm5leMMojkHUyNKleBlzYU6gUaVKsbPp8Wy0X24w/fTA1Y2IHr79RmGB8aU4llzTUVayfst/A1S2FMOsvwPWqZmDfrBma5V65uNmkf6s3AfRy+jgjnOMRRBTq6QuKpKwpkisHkFQlwekK1d8olhefElNknNsh8lol7xmCRZ03bRywEKy8JujZoTxsUsOPdF5YbMF82y2QB6ymHwvlWDKjK1t7EqGJgYvO7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpVboRcEbRvnCUX2/61h+P2cfMl1YSZBPtrr4hWniTo=;
 b=vQoRkkvFh96neNgLAfx/NFH/gdvyMdWPRtaO5ogbW88WNeidH7RwhFs9Ad5q0K1hXkxs4fSxdTD/J7i0JasZQTe106yl8f7xR9ydgQIixyxXX+/2I/vDacL+nEji4olbqZPQaunhaElUmwM7/Lu2g1/oL0JYkm2XhO1z4CCCuMsy4tPAWGPjukVpaILbG6EZ8PGjgeaEYHbs47LvzQb3zXNtYZ0PMim0HzZbJtlZIyvjXDW78eiguMxgMGGXy5wGZA4KdvIYF7BjVM4aJ68oStkdevD/MotAM0OI9jsGTWr26pyqwlja6WvpwzhzKITuE+gMGJvI43XAe+HnaC/U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpVboRcEbRvnCUX2/61h+P2cfMl1YSZBPtrr4hWniTo=;
 b=HS2iGfasUTQu82WSXUpiUOY+3fx+MzmXU4fHCR52Aa8bEi6dO0o5tD0+S20kw7//A6YJ1SXy0qokv4D4GDhYDf80ClCNSIcpJepMYp5eYbPAecxR9597mtSoJ7G/+oF0jgO/fiZFCSz9wi0Pj4xGW8bXTS3YUZ0iA+9JeQXv+kUgx27OFSrqrOJW1Dql7GDMIknYbclEEr4gUg2Pzn087sB1k5VOkpPqR1DbTiK0LiGa6SkEMZQMIAMEfHDGzZgPDa1MtTzU+YMUBIfk1thseWUrH+bTRh0cB+nQeSCxQYB740PYMzvTtK34dya0vsF93cArzNrNZPmwPoHzrocDUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:16:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:16:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 03/11] nvmet: implement supported log pages
Thread-Topic: [PATCHv3 03/11] nvmet: implement supported log pages
Thread-Index: AQHbL6sZ1SBqpRLhG0y4T4PGHKpJlbKptpsA
Date: Wed, 6 Nov 2024 05:16:02 +0000
Message-ID: <004782ff-6ffc-4d28-9554-7d40266b2ec9@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-4-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-4-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 39407980-bb17-4548-043e-08dcfe221b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEM0bUVhN1RyN0JXblBUcUxVVnptc2tFNFpSS013U3RjaUxna1NCVzVORDdB?=
 =?utf-8?B?T0lLemw5Z2VMRGFYQWtVV1BORzFPTHpXSEZoRHg5SjZkSytlMVo5K1kyZk9T?=
 =?utf-8?B?MDloSzFIdEc3R2lFV0lvZmVMTGE3UHFSdDF3SzZ2c0JXY0ZPRy9HdHp1M0cv?=
 =?utf-8?B?eU05K1ZkRzQzZlBzbDZiUnlpU2tPcWxSaS9hb2djUEwrcndkSzZLcGMxeGJt?=
 =?utf-8?B?MGp3UTVwRWlxVjQzLzZEWGRTQ0pLS1ZqTVJ1MVRtNVN1N1ZJbW9rVUQ3MlZH?=
 =?utf-8?B?WnVrREJqQ25LZmVoTjVMakllU3pXdDhFYmN5S2tneXZnMHFHRFpLT2R1OWp4?=
 =?utf-8?B?Q05VOFRiOFR5ZzMzd3BVWFlKL3JkTmd0ekVZcTRhOFprSklaUE9kcis5OVVI?=
 =?utf-8?B?YTRNYUR3VTJlMHdHOEtoakdpV1NhZ012RTREdHBhaGJrd3BZOUUrbVJpeU1i?=
 =?utf-8?B?dmRyUXRsVzFJT3NJSDBtTlI0ODZPTy9mZ0diNm1YenJ1N3hmVXQyK215R3NK?=
 =?utf-8?B?ZjArZVViRHRoTzRpN1VHSllKMnNxaWdxcWFUTVh3TDNXT2NacDdwVlFERGJh?=
 =?utf-8?B?dGFaTDYyalVVcHh0eFF3UTIzQUt6cmRQR1ZWUWQ2TGthVEJYY3JXV3BhR1Nu?=
 =?utf-8?B?SndFQzNHOUxpekxXSGlFbFNJcE5QM29xRjE1djIwWlNGUEV6UmNCMkJ4Y3FK?=
 =?utf-8?B?VnFuaS9rUHhLUEFxVTh2eStEd0IxS1FVUmVwUWNXd05IcWVnazdPcW9VTllY?=
 =?utf-8?B?TC9SdWF3MTFSSkEwbFA2UTNnc2lmdzJ5SEYzWW9RcVFKZGVlSDRHMHdSNHo3?=
 =?utf-8?B?aE5NL1B2dlJXQ3ZEMUJ2RVhZd1pFSzZtN1VWV2M0aVNoUjc5UitIV1hrVkRu?=
 =?utf-8?B?dnNET1U5RGRVazQrMGcxN3JaVno3MHBhSStqT3FMaHh1aVVMbDFQKysvVlcy?=
 =?utf-8?B?K3JmYnZuYitGaHFHamVuRHp2eWx6ekFPWmQycW5RRE5SY0w5T2FVQXlTdWtR?=
 =?utf-8?B?dy9OM3Z3czBLcHkrQ21Ebnl3L2F5dzA1Nng2bUlTY2xCbjZIRnV5ZDRpa2w5?=
 =?utf-8?B?VFdGOWRtOFdmWXBxeFZ1bnFUaCtPQU0zeENweHQwOHg3aDBJVmZWcG84NTQy?=
 =?utf-8?B?VG9yenRDbnFlRTZsVWp0WHB0MUJkeEI1N1JBb2h4R1p4Ymt6ajF0ZEplY0t6?=
 =?utf-8?B?ZWprN1ZMdUxWOTlzMGNBdUc5YU51N2lPUjZEbkxMMEs2eHM3aVlBQVBGcVd4?=
 =?utf-8?B?czZNNUtyOTZDNEZlQW5RNEs0SXFXRUFXeGUwR3ZiT1dWT0JkY3FDRFVZRGZr?=
 =?utf-8?B?T05nZ0FYcUVjMkRId2QrUUtGMG5pTFYxYXMvV3ZvT041eFdUc1V3WTcraTlo?=
 =?utf-8?B?bXUrek9nejhmVmw5WERsUGFGUFFaTS9uejIzY2V6OW5DWnFpVHFzU3htVmJR?=
 =?utf-8?B?S2ZaN0s1OXcvV3FRV0JZZEVQN01DMmFoZUdmanpWeUZzbmo0Qnh0S21md1RM?=
 =?utf-8?B?TFc5U1g3OG91ZnNOWjFiU0wzazZqR3ZKRENSZFRxY1puT2Nnc1k4S3FKeGxY?=
 =?utf-8?B?NDNwOEF2SUg5NFhsUFZTWmt4SGVGQjdiaGJwZHZJaHFWdjFRaEx3K1RJeVJx?=
 =?utf-8?B?cTBzUEVIa29adjlnRmtXWkd3em01NzhJQnN2eXVKRGFUT3JhVDM4QVFVMGZQ?=
 =?utf-8?B?Y0ZxcGhGRG5mcG1YbDhJaXM4N0RyT1VYNGZlTDg3RWgyMktXS3ZwR2FaTDdn?=
 =?utf-8?B?YldUcGY3aVp2bEEybWkrZWZIdzdpMktvVzFCOXE5MTR4S1V6WDI0T2xIc0cr?=
 =?utf-8?Q?3NDkJICHbfV3cTBYn/j69zePoi7bUeGbGJnwU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FleFFzbWtkTFNqZlpoVXRjcUZMMjhaZVZKNU1CQU9aU1U5VmlRV05HWDZT?=
 =?utf-8?B?U1RIbllrMGJ4NDFKSkZaWUw4ZXBRS1F3bW1NT2wzbDBScnM1RXZMRkh3WUlw?=
 =?utf-8?B?ZmN0dDdZS2d4NjZkcnM3NnIyVXh4S1ZieEtQeW95RVFjL1FUT2lTeGhnTzBG?=
 =?utf-8?B?STNSamxEaTlQOFdTN2k4Q2FocU9iMkVpMk1lZldoV1gxK0d1RXVRZ21JZnlG?=
 =?utf-8?B?QllKTjI1K3hjSlZQeDNJcjhISVNEbWttNU9GMTlKZDN0TkNQazF5dVdaNytL?=
 =?utf-8?B?QTY0SEZPc1dQRWpnSi9tNnJBN3lBYmljV2VqOVhqa1IweXZBeXV1aEdwYXBR?=
 =?utf-8?B?MHg1VXhqQUExdW0rRUR1MEEvVndCY1BMSmNFZUZ1SHpHeTFHbUwvTUNuM1d1?=
 =?utf-8?B?ZlhvYWFlWlJPUUtmSXZROW1JSWlkR1lKMzNuakYxaElZS1FZMlJoV3R6anU3?=
 =?utf-8?B?Y3pXS2dBOEpSRC8wSVlwY3AzVHJVUDgwQ29DU0o0R2VHWGYzVnZiZEtvRUQy?=
 =?utf-8?B?Y2ZXVnpZcktUU2hhdmUrdnhVRmtIdVRBaFk5OVdOaWNBbnh5czFBUkdBam5K?=
 =?utf-8?B?TVhiaThMeHR2NUhDcHB0dkpVUlZZRTd3aWhKcnJkN0ljMEF2cnNINTBXK0Zv?=
 =?utf-8?B?KzY0cHhyei9wcnJJbFVrZ3drMHM1ZklDWUNCTzZUQzBqc2lmTHlENTl2ZjVS?=
 =?utf-8?B?MGFhc2tEVlJMbGtseVpwWGRIWFVPSWYzQ1hGdDc3YXlsZU1sV2V4OWo1WlRa?=
 =?utf-8?B?Qk9aNDJndWlkdmNxdkxaNW5odEVuUXRXMjhDUFBnclhpblA2WmNraTZyWUY4?=
 =?utf-8?B?UkRCTW9QcGxKV0ZnZ2w0WDdaUFRLZ2RjQzFueVNBQ0FvTzZiWlFPRGo2cFFt?=
 =?utf-8?B?ZVdhcTE0SWVkUFlhRyszd0lwYjhMTEpTeHp6VFRWV3REQUR1eGJGWUxCN0dW?=
 =?utf-8?B?Y2lrMklZbytOcFZRamoxNzMwSURLT2krbUJTYkx6SURTT1E0NWppaC9qakVs?=
 =?utf-8?B?V00wSE4xb0VFaFhjOXIrYWozRFM4Mlc1NkJhUjNnTFlGWTlaNndIdDJHQjhL?=
 =?utf-8?B?a0RHNDNtRFJiNEFSQ2ZsKzBCQkN5UGN5ZUhmU2VyRXJjdlJaNlZSSVJYVHoz?=
 =?utf-8?B?YkdHVjNQUW5zWGQyV2R3UGpyTE1ZdFRkSzZHRGhzcEZkYUg2cnZ5Q0ttSVps?=
 =?utf-8?B?Y1BrMGVnalU5Tm91SElObmNzTURMZzZ6bDJhV3dJTXVvN29yaGNNN21rZDBP?=
 =?utf-8?B?aXJyL3Y2QjM3WVFxTi93Qk9sdnc0bFEvN0VDRlQxUVp6ZUJBU1Q0VFdycVRK?=
 =?utf-8?B?d3NkRlU5U1JIMVZqYWV5eU9kRG9xQXpqZ1YrZW5odUtJY2NCMURwK0pCZGR5?=
 =?utf-8?B?V25WWE4wY0ZOSmVaWW5LQ2RSNVdEM2pqQkNXTWhneXJpNk52clR4ck1WdXdP?=
 =?utf-8?B?dDlFNC8xeEtmVkUvWGhWTkl2THI3bWJrZ1lQVXZ1VHpLRnJNSG5GUDNNeW12?=
 =?utf-8?B?NjRKNGFiZ05jS3JRaFJOV29yRFBLSDNtZWhtZ3FFYW9vd0ZRclhsS1FKUEJ5?=
 =?utf-8?B?cmovYUgzK3J1eXZYRTdmd0pxWHFGMEIrdGNLdkN6Q250MENyUmhSbnlGNnk0?=
 =?utf-8?B?K1ZaWm1DTElYTEtSRWYwVTQ3QThwdUIzTmJiNkxFTDNPZzg4UTNVN1JIZnhi?=
 =?utf-8?B?aEM0TVRxTjR2WHZtY29KQndVbkNkNE1SUFhmbEZOM0g4NW1yZ1FvbEZSN2dK?=
 =?utf-8?B?VnZnOUg0YTBGa0s0NEZRUDRIODBkRWE0K3BZVGlxZUhTWURFaDRmdzVqYzNx?=
 =?utf-8?B?cGw5aWJHa3kzNGp3WmNqR0hFREp2M0wrYlJFTU1qbXVUOStpdnFjWkQrZU1H?=
 =?utf-8?B?TGNuQUlRdkpQaThPeTJCSktKQkxPK3dOVzJEa25TbUY5STRtdTRLRGRER3V4?=
 =?utf-8?B?dStOUWtMRDd4TlNvZEl0WUtzQmg4ejNLOVArQ0xuZjRmQzFFREgvNk1PNG5B?=
 =?utf-8?B?bXNxTVN2SExwa1g2bDR1OGRYelYzU1VFdE9vMUY3S015a0ZYN2tiYXJGVUJ2?=
 =?utf-8?B?NEk4UDlRVUdCczdTcEo2Z01WT2Erb0JwRERybVkrYUhiTUZKdFFqNndxM3h0?=
 =?utf-8?B?dDZiZW5mdm9wVXMrMjlTR2NpUlZZNi9HZE94bDhtUW9Qbks4NmVlQWlUU05i?=
 =?utf-8?Q?NlkXJFnB8zccnaz5BwTEvUw7j7rU0afsHoao9jad38o3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <725CC1CF61E1BF4DA07276325143002E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39407980-bb17-4548-043e-08dcfe221b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:16:02.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XU18X+bTk9VlljtHZhOQfo+ng+T6YN8LWPH8TkV/xZz62cDdRiWWLCHkmCfO7KhZUV6O5RPq2ILb0bmCOTMxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_211607_626613_EC9FEC0E 
X-CRM114-Status: GOOD (  15.30  )
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
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvbGludXgvbnZtZS5oICAgICAgICAg
ICAgfCAgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYyBiL2RyaXZlcnMvbnZt
ZS90YXJnZXQvYWRtaW4tY21kLmMNCj4gaW5kZXggYTEzMjQyZTc5MWMwZi4uYjgyMjlkNmM5OTk4
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiArKysg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQo+IEBAIC03MSw2ICs3MSwzMyBAQCBz
dGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2dldF9sb2dfcGFnZV9lcnJvcihzdHJ1Y3QgbnZtZXRf
cmVxICpyZXEpDQo+ICAgCW52bWV0X3JlcV9jb21wbGV0ZShyZXEsIDApOw0KPiAgIH0NCj4gICAN
Cj4gK3N0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfZ2V0X3N1cHBvcnRlZF9sb2dfcGFnZXMoc3Ry
dWN0IG52bWV0X3JlcSAqcmVxKQ0KPiArew0KPiArCV9fbGUzMiAqbG9nczsNCj4gKwl1MTYgc3Rh
dHVzOw0KPiArDQo+ICsJbG9ncyA9IGt6YWxsb2MoMTAyNCwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYg
KCFsb2dzKSB7DQo+ICsJCXN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUw7DQo+ICsJCWdvdG8gb3V0
Ow0KPiArCX0NCj4gKw0KPiArCWxvZ3NbTlZNRV9MT0dfU1VQUE9SVEVEXSA9IGNwdV90b19sZTMy
KDEpOw0KPiArCWxvZ3NbTlZNRV9MT0dfRVJST1JdID0gY3B1X3RvX2xlMzIoMSk7DQo+ICsJbG9n
c1tOVk1FX0xPR19TTUFSVF0gPSBjcHVfdG9fbGUzMigxKTsNCj4gKwlsb2dzW05WTUVfTE9HX0ZX
X1NMT1RdID0gY3B1X3RvX2xlMzIoMSk7DQo+ICsJbG9nc1tOVk1FX0xPR19DSEFOR0VEX05TXSA9
IGNwdV90b19sZTMyKDEpOw0KPiArCWxvZ3NbTlZNRV9MT0dfQ01EX0VGRkVDVFNdID0gY3B1X3Rv
X2xlMzIoMSk7DQo+ICsJbG9nc1tOVk1FX0xPR19FTkRVUkFOQ0VfR1JPVVBdID0gY3B1X3RvX2xl
MzIoMSk7DQo+ICsJbG9nc1tOVk1FX0xPR19BTkFdID0gY3B1X3RvX2xlMzIoMSk7DQo+ICsJbG9n
c1tOVk1FX0xPR19STUldID0gY3B1X3RvX2xlMzIoMSk7DQoNCmJhc2VkIG9uIHdoYXQgd2UgaGF2
ZSBpbiBudm1ldF9nZXRfY21kX2VmZmVjdHNfbnZtKCkgaG93IGFib3V0IDotDQoNCiAgICAgICAg
IGxvZ3NbTlZNRV9MT0dfU1VQUE9SVEVEXSA9DQogICAgICAgICBsb2dzW05WTUVfTE9HX0VSUk9S
XSA9DQogICAgICAgICBsb2dzW05WTUVfTE9HX1NNQVJUXSA9DQogICAgICAgICBsb2dzW05WTUVf
TE9HX0ZXX1NMT1RdID0NCiAgICAgICAgIGxvZ3NbTlZNRV9MT0dfQ0hBTkdFRF9OU10gPQ0KICAg
ICAgICAgbG9nc1tOVk1FX0xPR19DTURfRUZGRUNUU10gPQ0KICAgICAgICAgbG9nc1tOVk1FX0xP
R19FTkRVUkFOQ0VfR1JPVVBdID0NCiAgICAgICAgIGxvZ3NbTlZNRV9MT0dfQU5BXSA9DQogICAg
ICAgICBsb2dzW05WTUVfTE9HX1JNSV0gPQ0KICAgICAgICAgICAgICAgICAgICAgICAgIAljcHVf
dG9fbGUzMigxKTsNCg0KaWYgeW91IGRvbid0IGxpa2UgcGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1l
bnQuDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg0KDQo=

