Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EA5D7497D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqCN3wOE2rRPMfWMY1yHeZSW+9jAznHUNL9hlRygV4E=; b=EYLsnHD4DWJL+5m7o9wV7BexkJ
	H0dCRfPv92y9F09dgBRXYx4CbK7AhVhib87/MacHMPxW9gF2SRMdEe2bmrXY0EXRP59t5cp/dX8vW
	QICnnCFztahIltkp+Te45HhstgXm/LjxNfN0w0jEoRHE7KdeAyZ36uPLAz7SRByKwNr7O8J0/as5z
	vnoJsIzuBoUEBvMaikHJagci9sz/Woh8blT5297mt3XIO0RKOWj7N2RKh7lVGiZk8QS7IYuf5Pfjf
	6hRanzY6m3KwaMMDSqOJS+UEtAiQgHzebDVEtPrXFu8OaXIStV8Sg+ZeP0hcUUbJhYnIJBr7VWvHC
	1FKxf2zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63LF-0000000HAvk-1CPh;
	Wed, 30 Oct 2024 07:42:09 +0000
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com ([2a01:111:f403:2009::613] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63Hk-0000000HAQA-1tKl
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt75OkM+V4xRnoMCElkumkjZWUzYnHUMi/XLurzNqVcrdNV0c+1DNFK4+UySRbADWSyKjWGAiW6jn74v9ygG/NiPDw6Bn/vQ2UyGThd7sA9Ts1rDmGVFIL7QlGnhn7m0nBWHkKCHXmHIRN0xBa2LFw/SQNQCDdAWDxTzRDoYB/Dfhr9q49t4xpD5wTBYo7EhKfycbQY2B5xJ2inRv2Yic5vwvW9ySmG+fMCHOl75ApC4/n5s/llbUBsD/+KvMS6k88G8KHQ96bIVL3XIvhhGCedCK8FZ3fPlZBmhfbN65JhUoX7PIluzvwYfNIgHa0viXwTZDtGckY6pfYeuC2IMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqCN3wOE2rRPMfWMY1yHeZSW+9jAznHUNL9hlRygV4E=;
 b=IjMj3g9863/MLAPkpLZTOuGaOFkK+H17GpW/13qIOMbK0nObEPgf0npW79aPXKcnn7roa6TrF6XBkUOmLjMGburisyKIdTnfx/pCykCbiPEUYkV58R7vU5Ob0uIM0z25zHlmAVFOEsuLCxKDeqGWMrZD0A49N+j2NuLVPcyaapE/wNQkejr9jWLmPGur9forEdYbgLjBh5c4/sxYhbfHRgwucWr1dKCZEqW8kCv2XxnY6OFMSy0clJdw+pz87lhNDWmFBPsxbbNc2ZF+2v6jz6Cn3KQqAMfoSpDYNxTv2uFQpA6d1YzACeQWAR6BD+h4qeVDHjVV7hibU6soot5mJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqCN3wOE2rRPMfWMY1yHeZSW+9jAznHUNL9hlRygV4E=;
 b=Vtyj+uNzc0KpvOVXnLjqJCM9I2yuOdDD1Ey2NveOAr3wEAAvqFI7PKSDgCTvIg60jmLDk9767E+eJpcKwQXzkK06ECkX3UPRHPc0jzGg3Ov6bNTW+rpFgbEkabu4x15T+8LcJWzjGNlrhjixdmrrIpNrgy8XP9PqeapzFMN7CQ/lw/8B/XRIx9vv1PVyJ+L689JKlFX3aJyuHtBY4kHPN+dht4T89mZ7mSni/PItjUEXyQRN9pX8NctqMs0n83CQtV3P8C6C6p9VDzh3kUy3FlouhRu+FQEvrSViWL2MJu/PlPMb/e/FVq16bapaRNNrdX16eL2LUBVHTRYtZSeIUw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:38:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:38:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, Guixin Liu <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Topic: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Index: AQHbKbFmcQBQk+oLTUeB+jDaD5L3qbKe6AgAgAAB+oA=
Date: Wed, 30 Oct 2024 07:38:23 +0000
Message-ID: <3b41fb79-78b7-4ddb-a7cc-08000fe8df7d@nvidia.com>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
 <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
In-Reply-To: <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5948:EE_
x-ms-office365-filtering-correlation-id: 028871ce-2889-4085-1ba2-08dcf8b5d5a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjZlZzV3YUsrY0VVUFdERlpHOHJkZGYwQUFHekdvSE9Pbm00UlZQS2pEZVBU?=
 =?utf-8?B?Nms1cmcxY25ES25qQTZmWHhTN0ZpSHFBdWYwVnFyN20ydkt4aUh0WHZTNnVO?=
 =?utf-8?B?b1FmK3c0aTlTS3c4a2IraHI4eDFZcE1vTHRPTHEyS2k2ZE1maVhhQUtXZFNK?=
 =?utf-8?B?SFVFVi84bDc5WmpYb1VjZkxZdXdXWTgxTFlLN0dJYnltdjVXZjBPbWVic2ZO?=
 =?utf-8?B?WHV1Z2hoaFRZUVJQZHlZRkI0cjhqRTVJYWdHdFArZE9yUHVUY3UvaG1NYzJy?=
 =?utf-8?B?am5lZ3FiS3c4cUpmbVR0bkdBOW03VGZPWlc4RTlQK21WdUVIaHR1QU43NVZk?=
 =?utf-8?B?bHE3M3V1NGdpa09UTHBaNC9hamVUSTNqeUxISmpyTHErelo3c1VqTjI4QzJq?=
 =?utf-8?B?MHdxbFVSUStCelZzeEdLSksxeTAzSzhHb0wzWnU3N3MyWi9qSVR1NS93MnVU?=
 =?utf-8?B?b1ZnRWUreE12aW1qT2JLR0x1MFY4bjBEa1hyeFh2STU2OGtmcG56RGZ0UnpN?=
 =?utf-8?B?dzlKQytLbi9MSldNVWVyZFpFODVnSkJ0OGs5VHVZLytxdmNGZnFsOGFHdVRl?=
 =?utf-8?B?TFRtblQxVkMrYlNySTZnL1Q0UUJEYThpWUNWZ3c5SkNkU2VpN0p5QSsxU2JR?=
 =?utf-8?B?MnRTc1ZGOEoyZ0N4T1VRd0w4NWxZckJCV1J2cU1NeWluYng1aksrN3Y3bldo?=
 =?utf-8?B?R2hnSUxXMjFVZjZ2TWVjZVNnbWZLK0JOTmlSLzM2TjhZaVFKZnprT3ZBdzVl?=
 =?utf-8?B?eVUzcHVrb3lrdTNCQ2tiVmZPQ3JtR2NTN2VQV2M4SjlxbnpTMzY0TWRHU2E4?=
 =?utf-8?B?UTl2eFFKbjBXblR0azIxRWYydlFTa0F3RWZWc1RSajg5YVpMeVRaTmsrdHA1?=
 =?utf-8?B?NytOODc5VHo2MVVndmw5SENhZnhpUFVudFhFVkVjMlg2Y1UrVUEwUFZTanJD?=
 =?utf-8?B?aWJTV3cwZUthOXFZUDh2N2tURkFFcjFTTlRpWE11MWVwcmpsd3JlSUlGanBC?=
 =?utf-8?B?WkV6bjJWUnUrVmpjQUFudUVieUpiNkdGM1p6VVBlSjZudDhZQnhHKzlSSkk0?=
 =?utf-8?B?WnpPaWlFNkxwdUFvRXFWSVJEZ0lQR21HQnNVSmhmNVJEc21DdU44M0hBL25o?=
 =?utf-8?B?SG1Jckg0cE81emJqWnRrbTN6RkFkUnZYTDAzTkdIbHBIREw1UTYvUCtmVldm?=
 =?utf-8?B?Umt5RjQ0K29FMDVFdXkwZlNNa3FkSXVKclRwL21IcVBSdzdWNWNVa0taVms1?=
 =?utf-8?B?TklONHpoTndOOTRwWWk3NHI5TkYwSEdacXNPVUY0dFREUnI4T0FMUmtpblRT?=
 =?utf-8?B?VVA3ajFwRWQxYUp5UmZSVmxpN2ZDczlZM3dENE9vT0hMeU1MT1NvUDkvT0hn?=
 =?utf-8?B?UEQzYlBRWXdrbnBvR1U3dlZwK25WNmtzb3hXejVaejRVR2s0Rkgwc1VjcHhQ?=
 =?utf-8?B?aUhVVnFXRG9ERUVDY1VhdGdJazA0cDNqSExkRWVzc0ZhTEJIWEtyajFIeXZM?=
 =?utf-8?B?RDN5R3RPZDMwbUNaMTl2RHdOd1NOanVmcXdIUVcwWVluZlNjUHhvS3FmcHBp?=
 =?utf-8?B?ZWFXUlFwaXFuM2MxUGJhbFNXZWRwdHhKTWhoQk9XNkxsc1R0TEE0bmFnV3Ey?=
 =?utf-8?B?US80bEpSV1VGYWVadmc5S1crSXNBRTZQU0gwVVIvOG81N084MTU5NGxieEFa?=
 =?utf-8?B?QjN4anA2aEZaU3diVjd1Q25rcExlSUtRaGFpVGJnOGFHTXA4QkNkRU9jSUll?=
 =?utf-8?B?RStldWVsOFNNbUwydDFjcEpyT2M0b0xwYmREaDVIL1lxejVId2ZTb2M1cExn?=
 =?utf-8?Q?1LeoQJyPTnY3Ep7JSHd3m6OdaahNpkeXI8jYs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTJlVEdFN0ZPV1VCWUY4RksrVmJ2cG03K1d0dktZYjdMSFQwTGJrR05NVW5n?=
 =?utf-8?B?TmkzZEptRzNlZFJ2UzVSd01QQzRIMExIT2Y0SlB1OFBoVDFtaEZTa2kyeG5L?=
 =?utf-8?B?Ry9odlR1QmhoLy9nelpKTjhVOS95alVZOUNqR1Q4RXM0WFNncTZmQWxqOW1u?=
 =?utf-8?B?R1VTdERLdFprY1M4amcrTkdHTzBFcjBhSHJKYkx1ZnRVNHpraFlSaUdvM0hu?=
 =?utf-8?B?Y250ajFFa3JvVDlYYzJuQ1BkbUpRRElWbXduZE5KNTdia3pEOGJ3R0FaTnQr?=
 =?utf-8?B?ZmlnUGRERWRCemFFZnc5bTNibDM0Z1A2aUd4MWQzVkk2QnlwYzFKbmVoUDVm?=
 =?utf-8?B?MDdjRXhPayt6Wi9Zd2VCbHVzVDlyMlVHa2cwbGkvVEpRMUVDK3FheTU3andB?=
 =?utf-8?B?MnNjY3F2K29OVWYxYzhacWlJTWlmaEY5cU9SQmgranFrRVFQYWlQQ0FRNkxB?=
 =?utf-8?B?Z2VZWUtPNEtFcTBrTm9pUXNwUGVZZFJMRkxaMjV3MW5TL1ZORnRsZTJQUnEw?=
 =?utf-8?B?OGtmNzFwdGc3VXdVYkRhZmlGRW5zWm54a2ZqWEZ1SlBMbjg5N2pxTi8vOHlW?=
 =?utf-8?B?M2tRcWNOblJlb3lKUG5kR2xITFVBN1l0YlJXRGhYVnZFNHZSUXY4TVhMYlpR?=
 =?utf-8?B?eWc5eFFoUlB3Q090VnZRWEJKWmIzNWE1aFIwbGx5ZHpTRWRLZHREbXh6ZUNE?=
 =?utf-8?B?S2FPZkZVK21Xa0kwRmVVN3RnSloxcFgwaXVYN1V1UEVFUnQwZGhuTkxtYzNG?=
 =?utf-8?B?dnRKSzNzY0VxZlczdXdKMEZuVTBzbG51NmJ3QWNnc2NET0lpQUdrcHc0bHRB?=
 =?utf-8?B?dGpVSExNWGczNmNuSjZ5bmw1dUp3czUzZnBWd0oyd2hXbW1ZaWhWVTJGdUdZ?=
 =?utf-8?B?MVNQTUV2Yy9UdUtDZlhPQTFSM2lxdktmcktKMDh0WHBQdG1Vdkt2VDZkOVBT?=
 =?utf-8?B?a2M0K0NOeHYwVWUyQVJJRGhBM0lhUGhyNUpvOTQzd1hNc3BCNEFpKzg5ZUNR?=
 =?utf-8?B?Y1djVi9CWTlCbmNrdXN5Qjlqajd3RVhuOFBwNGxOSGJ6eVVqcGQ4MkxWdXQ5?=
 =?utf-8?B?M2J3QXd4SHk0ZElNZ0tnL2t3Q2hMVU9sZXRxcmEzbmd6MUUvK2x4VGlQcTVu?=
 =?utf-8?B?bVowRGRFRUxHdTNQTS9NT1dBMTV6blBEcDlBbHl4ZmZLK0hIVGdHem4rNUQ2?=
 =?utf-8?B?OXQvak56eFprTFJ0Z3ZncDY4dW11bFRadkZFRHpnR0tDaDNpc1lmZitxQ2px?=
 =?utf-8?B?YnhjQWY4dnRHMmRQTHFUL3c0Y1NrR2dFS09DUmNjRkQ4S0U1UzdVNkwxd0Uy?=
 =?utf-8?B?R0tsOStNbGNETUV0NjdGWWQzVXpGU3VlNnpwcGpBa0dJb0wzTm81U2xzVisz?=
 =?utf-8?B?VTJJZFhvRDRwMEVPTzBnYnp4RTNKQTlNeTk2V3BEaUxMcW9kRThiWHBoNGpk?=
 =?utf-8?B?bGd3L3h3T1hoeXZIeUtqMjcyNndtbDVWak8zRVBMb09qdXlKYUVPV0JCeHZH?=
 =?utf-8?B?eWtkczJhb1c2MWpLUG83QUhmNEhReE5BWGxrdjNNekJiZHNzV2U2RHR6WDh2?=
 =?utf-8?B?TU05d040Wk9YY3FFWHNnQWhwVEtvdlVLQUJaRUFvYjU1VmNSK0l2Q0RXZWMr?=
 =?utf-8?B?U1lsK2lXZTl4UWZBd0dlMWNXVVQra0M3aTlsOG5kT1pMaEIzNnc1L051Q2Fw?=
 =?utf-8?B?NEc4cWJka3JRZU5oN0tnOWNsZkFDRjY3OVRYRUlocUVJZVpVL2c4VGwvdGNw?=
 =?utf-8?B?RFo3UWUxNElsYk5HNTVkQ2h4aE9IR0VMVnBBbTVRMGhJalRBMWhLeURnYUc1?=
 =?utf-8?B?UWRyUklURkpwc05zV1dCMllmZW9lTjF0RmNvcVY5OUVCSURvUUp5bHBuTnV4?=
 =?utf-8?B?NVBqajBLeGMrc2pWekw5UVZNN0xQN0dkL3VxSWxPdGI2WWZEVklOVWVHZ3BW?=
 =?utf-8?B?TEU2NDRvV1RBWnJqY2RvYnRKa29ZTCt0b2ZKUXowL1BaMmtpRWVSaHIvaTY2?=
 =?utf-8?B?T2I3S2hvc3N4aXdOUlNDdVE5bDl3cy9BdURzZllHSk5GTU9Ub2NtZTBLdHpM?=
 =?utf-8?B?M3hsamVqdGVlN1h2cStxODBhM1R4R1FKTnROWHYxSUdvM0dpMzY3SlNjL05F?=
 =?utf-8?Q?c7aCa3i7uZGIhrmBlvm2SoNQL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB616D4C431EA04B8D237EC15513B748@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028871ce-2889-4085-1ba2-08dcf8b5d5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:38:23.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIdNqh/xewQGsQBEcJqIy5QFgFfrISYzr0g953V3mADc2jLNki9YAZyjdqaLTjkxr+BjJ2yAcsdmi2/vhaOExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_003832_515781_4C4E47EB 
X-CRM114-Status: GOOD (  10.79  )
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

T24gMTAvMzAvMjQgMDA6MzEsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9uIE9jdCAy
OSwgMjAyNCAvIDExOjE5LCBHdWl4aW4gTGl1IHdyb3RlOg0KPj4gVXNlIGRlZl9uc2lkIGluc3Rl
YWQgb2YgaGFyZCBjb2RlLCB0aGUgZGVmYXVsdCBvZiBkZWZfbnNpZCBpcyAxLg0KPiBIaSBHdWl4
aW4sIHRobmFrcyBmb3IgdGhlIHBhdGNoLg0KPg0KPiBNYXkgSSBrbm93IHRoZSBtb3RpdmF0aW9u
IHRvIGludHJvZHVjZSBkZWZfbnNpZD8gRG9lcyBpdCBhaW0gdG8gaW1wcm92ZSBjb2RlDQo+IHJl
YWRhYmlsaXR5PyBPciBkb2VzIGl0IGFpbSB0byBhbGxvdyB0ZXN0aW5nIHZhcmlvdXMgZGVmX25z
aWQgdmFsdWVzPw0KPg0KDQpJIGZvdW5kIGl0IHVzZWZ1bCB3aGVyZSB3ZSBkb24ndCBoYXZlIHRv
IGhhcmQgY29kZSB0aGUgdmFsdWVzIGFsc28NCml0J3MgZWFzaWVyIHRvIHNlYXJjaCBmb3IgdGhl
IGRlZmF1bHQgbmFtZXNwYWNlIGlkIHRoYW4gaW5kaXZpZHVhbGx5DQpsb29raW5nIGZvciBpdCB3
aGVuIGl0J3MgcmVxdWlyZSBhcyBudW1iZXIgb2YgdGVzdGNhc2VzIGFyZSBncm93aW5nLg0KDQpU
aGFua3MgZm9yIHN1Z2dlc3RpbmcgZml4ZXMgb24gb3RoZXIgdGVzdGNhc2VzLg0KDQotY2sNCg0K
DQo=

