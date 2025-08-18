Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B302ECA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8UBFTgS/EuyMNTidctJz7Q4Lmhyr2YUe/Ywb/hg/eA=; b=WeTYa01LXBeyacMOLNSYTXB0bZ
	wo8Gat24z9GAQchkAcCseRRgTNA4/UNXZ5vC1dbALQffnmkad3fLeZF6rK3lvj5Y9EDiA0crBe1Ut
	LRp8nK18js1IO4jDFZd7U/Wt8SlaAa96vNmjDJ4TDZYiQTvwybyUO0Pe9+vAm5ZfxhCq07ESpXjIP
	9KqL6yKa7Pxn0mhDj0bLgtzpRqP/D15SCDfO4x3KByrb1e9bFd6mvfpDK9Q9mj7H9K02/Cb01nW8W
	9la+Dzn0LiY26BtcoDVC2OSb8YAZKMee0ECIusvv/+ApkSF8v/to66+wF/ExD+liXeCtzLTxPrelI
	FG5BluiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo4fr-00000008Mt4-3HtV;
	Mon, 18 Aug 2025 18:33:39 +0000
Received: from mail-mw2nam10on20623.outbound.protection.outlook.com ([2a01:111:f403:2412::623] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo2RV-0000000803d-3ign
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 16:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/1ebU6H6i94qzsdv5lIyxFIo6a1XfHi+60CJeXoX6oIo4+UusFaDVlic9U+ZH/3Hp/kStPH6Kw3/WTep3ySlJZIN8GA487Ei+e7qZk2LohQbMvq1QW7baR4m/LT6GFLa6YW0g0FD5jI5mYXYMdm5MGuHcPuU9W6D49OKIRhzVQtaE7IAPl02LGMjF/vY+DHBbymwV+WM7D8hJ3rlpJKDgPNV3FQfYFaHCk5Es2sa3sC+4gvzCoHcHILIhFkHRxbR0g8ttfs4PQN6ARQvxHXE0Yc6D12lKh78TnMCPKGPLAjG3S62y8NeCnrcarwcNN18EyM4Brs8AekOBFIVq7Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8UBFTgS/EuyMNTidctJz7Q4Lmhyr2YUe/Ywb/hg/eA=;
 b=N/NU1V7maRM+mwfDUfyvaGvFE/nXlIe2eW534IkRB3Xzq2vBHFFTWHbqfWHFn0Y8W8ATwhBbP0dePvd1rxIKLyxNuYc3clfjZ0KSN9HaYgib9XFBq4Y68NQczCJA5CrTJ7SYh/vWrwOH/t3Z4N+/m+ZiqIyvFQSyYsPVb4VtaoYWZpMf1pLP2VkXAuMRrW/xEjuyZDcid+1mbQpQw656LiGuPxptRpoykt+6MaKruc1mUdnOlhHt6XVDN2+27kl41UX7k++BEJRHA2HF+yIBSU98xfKP2/yr7ApwKopESjmyim15LRN7PZtvSgnEmGrTYFkUGe7qqFs/d+Wimc1Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8UBFTgS/EuyMNTidctJz7Q4Lmhyr2YUe/Ywb/hg/eA=;
 b=Ye7Qq0qdwpLEutj+cQwSfQNKoOFtuJyZbaSK8Lsr6/vFNBy9kVUzksH3kMRGKscSnIgH6/zSMh/MR7RekfI9acP3R83kv2wEZFF4exkYSEmqvF46o3eOAvSC4X1Fo1SIVipKhRwwh7Bm8e/eGjQfAn3r3RXOCQUGZZYVvI8YJ0mur+d63wKZAOhjkXE5RbmTCEIlfStOrG+UhlIKoOqCH/bI+rTcXd4Qu2wRpw/JPh57s0svtRu4JLSJFXRDPpyaZpZ+s4Vkjn1P2e8mFoAvDVjaxS0GZ67Qr34aRkZearMHpC46XrfPLszr6EYmbBhan9BthDQ765ZdYqqBIzm9mQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:10:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:10:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/050: repeat checking test device
 restoration
Thread-Topic: [PATCH blktests] nvme/050: repeat checking test device
 restoration
Thread-Index: AQHcEEYHXcoeIvoKfk2CvRzNZw8glrRolLGA
Date: Mon, 18 Aug 2025 16:10:31 +0000
Message-ID: <711d41db-4555-4297-b4a7-648f839958ef@nvidia.com>
References: <20250818121429.1579513-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250818121429.1579513-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS4PR12MB9794:EE_
x-ms-office365-filtering-correlation-id: 271d2a53-8fef-4644-6978-08ddde71c17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WlVoWmpOSUJOcXEvMW5LTEVhTVN6dlgzU3dKcTR3dDZ0RDh1L09hTWZqOHZT?=
 =?utf-8?B?VmZ3dHhjMUNxUHI2akRKbnlVcjBJanFjN1hyamNHbExpUXRpc0FzSVRDM1hn?=
 =?utf-8?B?clQ5SDhpSW5rdTBtODhpbnZGdW4wVUo4TFR5WE50bi9CU1cySGtMWWI2TGwx?=
 =?utf-8?B?ck9Jd3pteHd1N251Znh1eDV2dlhyNFgrS2tWeDlsVGt3VndNOHNKZncraU1i?=
 =?utf-8?B?Z0hwbHJwOVZOQ0RpMGl3RExVZkhlZjBLcXlOM2x0c0Q5ODhNQ2NOSFdEVFht?=
 =?utf-8?B?ZVc0Y2RBNzBBaTMrYWtaREJFSVhHdi9PQWs3SXdGSnVGbXVBSXhaRjRBZ3BV?=
 =?utf-8?B?Tndwa0c4bUdrRU1zNmlDeHNrUUpwUkIxQUJoTTNvRWpETlpCQlNVcHcvWFJ5?=
 =?utf-8?B?REt0WFVBdDFTQVo0WG5sZCt2aHNOSHorcFVFa1habmF1ZjBMcU1KeVY2SjhF?=
 =?utf-8?B?SDhnYUlJQlpmbEFwVmVpZEIzTno4UVVjSUxiU3N5OXpoNFM0bHlqOG02dSt1?=
 =?utf-8?B?UzVtanRFYm5CV2gxUHBHaFEwQUVvRUk4ZkcyU1JDdUdjSW9pQzlNb1Y1R0lJ?=
 =?utf-8?B?ZWZpRml1OVhrQkxaakJjSW84a1l3dkNvblJyR2x6MmpjQW4vSlRhbUNWdHZH?=
 =?utf-8?B?QlVqSUdDTzNUOU5Bd3Fzb2FHSjgwRVoyUW9RVDhnUXM2eGhEdkdOWVQ0N2NS?=
 =?utf-8?B?cE94YnZFc0NTQ1JTR0psRE82N0UyTFd6RkVXNE50SkRyaE9FMHlYNUxuNm5r?=
 =?utf-8?B?bDFuQUZGSmRURjdWVGxzbFg4NGxhOWpyUTNuQ21UYWEvcnNXaEdnSldpank2?=
 =?utf-8?B?NmxSSDAyaXYzcmVPRjh4YTgrRFJWMlN3ZCtOdkxrQlRHMnpuVlY2SFBNQUhx?=
 =?utf-8?B?bEd4NVVkRSsrMnNpdmorNkxFNUZzU2J0TENUYU03WGFlaFNBUUpRL0pZOGEx?=
 =?utf-8?B?WkF0WG1GRDduZ29Tc1pFTHdmMnIxSDMvTTQwOGZhUjRlNFBXNHdtNGNwTERH?=
 =?utf-8?B?YzJQTVRKZzdhSXkrSGdZR1RCa0UrZHd5OVZwUkZ5Vk1uT0lEcEVpWnIwbXRQ?=
 =?utf-8?B?NTNsY0JOakp2OFR5bU4zNWUvMXQyV0FWeWZlRE1CbTNFUURwUWF4c0RJVElI?=
 =?utf-8?B?b1B4ek5pOTRzQ1IrYnIwREVWbExqdUpZWHZGSFc2ajFvV0RuUklUd3prWG5x?=
 =?utf-8?B?cFd5MGxPNGYreWloLytaVEVGSExpb2U3bjk0djdFVkFHQ1YxUXZlQW8ySDNj?=
 =?utf-8?B?cFFySTdXK21yUWFNNVhCRFFhbFdVTk1FaHVQVTBjUHM4WFFyUjJLU0JQUGg1?=
 =?utf-8?B?Ri9FYjlLTmw2UzdvQVBSamFCVTR6RVV3Zzk1YjhZQi81K2dUcTFhbTRCMVpz?=
 =?utf-8?B?MG4zQ3NrYkpzS2lOL1VTV1Rjdk01TFlSM2FMUmwrMnJibTE4MDByWkFKNjJ2?=
 =?utf-8?B?MTdObkpIWE5CVStWY1AzWXJub2ljVE5POE5vYjhRckJra214RGVqOXNNNngr?=
 =?utf-8?B?NWNRd3Y1YjYvQ3hlb0lhMmgyd29nSk02SGlFWWo2VEp2bEFtU1BRRjN3TDM3?=
 =?utf-8?B?SzV5OExobTgvY1VuNHMwaWVQQmhZeXJDZkpDUnhTaDRPTTRUZlZRM3Fpc2tZ?=
 =?utf-8?B?Z2thZXVIOVVBTmVPWkVXa2RiL1FLdUtlQlZac1UwWlFaanpSMmlwWTJ4YnI5?=
 =?utf-8?B?THd5R0VwTDV4QXUrT2p4UkRHWG5seHBvYmJNNHFFQ3R1VnRTdkkwQ2JVUkxw?=
 =?utf-8?B?S1pJdlpYcWVqcmJvbmt0YU5nL2pWUTRTMlFxNWxDTnVCa0g5Y2ZxdEg3cmVE?=
 =?utf-8?B?OVVUQjl5UitNbnh2LzNGQ3QvdmtWbEZna1NNREx4dmZ3aXcrWHk2NHg1REhT?=
 =?utf-8?B?SGdMd00ySzFIaXlxN1BpcENvNzJSclAvbFdvN0xLbXFhTnQzWVVSMHh6T01r?=
 =?utf-8?B?QlNwcitFdFlDN3h6K0RnUFFtVVZIUXZsRFJ5Vm9DTnVwU1pLNWU5ZG93cW1V?=
 =?utf-8?Q?lJxWdER9+IK/h0VXucbgDmJqMD8/bo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUZkaVd1Wm0rUVlucGZ1b3FhQWNGeCtja0JTd3U1R2FGeEhSTE1ldDZmZXR4?=
 =?utf-8?B?Y0FoSUJmZTh0NEhFa2w4MnpCdEtNQXdrYVF4VmpiRm96RlVoTk1ienFxckx0?=
 =?utf-8?B?WG9aaFRnbEdYTkY0M2hKTWljRVM2bWliTlFMTXl2TFZzYStBbEV4N0g5TTFZ?=
 =?utf-8?B?WWFxamNxWGtZVjVVUG15cjkwWXdoYmgvWnkwOS9GckJLK3lENmNiYTJ4K2hM?=
 =?utf-8?B?VWcwQmF0VGt4djd4WUFhU25sM3kvNjlseVJkbi9YSVV0UkVwVk50K3RKRCtx?=
 =?utf-8?B?REVZOEhOTjJZL2hjUmFjckpxTitYRjZFZS9acEg1ZGdNN0EvR2hEUzZyM25m?=
 =?utf-8?B?N1FhSEVOZnIrMFlVNnNlSEp5MTc0dng5WC9VLzdXWUhqc0Y4RlFPSmhSa2Vk?=
 =?utf-8?B?b0I0TW96bnZrc3lLTkRQcHplSElaWWp0bS9lUUgvWUFJdWcrYysyQS9RRFFO?=
 =?utf-8?B?UkVDL0locmFYWk12YlRqYXpGY1VuVGxoUEkxcXhVMXF3MHQvZ3Q3VXFKVlZG?=
 =?utf-8?B?K1puNHFubHRxSWVuUnFQSjF5MDQzYzdOUG5DZWp5YldjUEovclZnaGRqb2M3?=
 =?utf-8?B?NDg0SzJVRGRDdU9Odmh4MEl4eUtvWWEzVVlSMzREV1FoZlkxYktBZWY0ZXNK?=
 =?utf-8?B?VDRNU1VsaHNXVHVRdldLMnhVaXpZOXhlb0lPSk4vanNZTzk2WExGWjdNY29I?=
 =?utf-8?B?WkJlNENIWTc4L2o3UHR3RXROdEJVblZEZDZNUm1oSDJPaXRybFpmR09wTHFH?=
 =?utf-8?B?dHNXTk9jVk1NZ21RQWM3c1lTNDl5UGNpcksraXdWR3dHekh6T1hCc1c0UHJw?=
 =?utf-8?B?cG5ROG9LMDFSbEo1NXlrSzd6bm9WOUh4WGRhS3ROK2gxa00yMzRMbUdmRzJw?=
 =?utf-8?B?Mk9odXN2T3VBaEtRKzIyNHZLRk44UGpIdGFaM0cwRGxvYTQ5ckY4dWVJaUZI?=
 =?utf-8?B?Z0xSUTJqT0lMVCt6bDZTUHhXMkNNYm1USlRETDU5VGpYZ3l5TVpJWkhmTVl2?=
 =?utf-8?B?b0VSV0RzckxKZDdzOWF2eW1ZVEZib0Fnei9jZy9ZSUF6MEI4SjRLMUt4VUdT?=
 =?utf-8?B?MG1oSnhtYzFyblhURnpVd1FPUDlERWVUVWNVekZyNCtBZ0lPK0phQnRnYzVS?=
 =?utf-8?B?YTVzWjlKRVJvUGduaXB5L3VKUmFvZ1QyRU5kczFEOCtKS0pYZ25Da0h1UUwv?=
 =?utf-8?B?MjFBY0xBUUV3YzBZa2NMSU5RYm1XRG1qc3JpM2FPdFNLNVphYis2RGtTbzRZ?=
 =?utf-8?B?bmNHY2FzQmxkUW53K2pjMnd2YW44SHRxRXNINjNGSHdUS3pHZDBORFp6eDIx?=
 =?utf-8?B?YVVadmE5amRGZ3NmMmFqdnppd3NRN1AzYm1SL3loeFVRQXJQMStPWkR5SHU3?=
 =?utf-8?B?Sy9Vdkp3RWlzbERHV21ka2NlSU8yYzJUOEwveUd5c09XRldnc1RNWU1TcEZx?=
 =?utf-8?B?MVpvZXdzakpLWmpraGtZVGxYT1luZk5JcW9nNUxISk5oZXZFQnZsVE55MS9z?=
 =?utf-8?B?M1FmQURqQmhlbC84cHQ1a0dEd2dBZXQwallKYnVzZlQ1QllNU0FZbFBvZnlQ?=
 =?utf-8?B?YXpCRUtXU2JCQStFVXRtcmM5UmhBdUh6OU9xc1RXVVUrRnE0ZlA2Zjh1MVlC?=
 =?utf-8?B?b010NzlWVlgvNXc1cktLZDFsYnZJSmd3Z3dvUjBTL0xOMHBTalExamFvcGhz?=
 =?utf-8?B?RUt3TDZZQWJKNWE4QzNvNU0zS251Z3ZCaGZzbm0yNnhOK3RKa1plVHF6MFRu?=
 =?utf-8?B?bjRHWndXc2gwYVhkaDJPOFpjSzV5RTZFNXJORG9zTFBxZm16RVdmK0M1VXpM?=
 =?utf-8?B?cU5Wa0huVzJwM0FiUXRBc0UxR2R2L25vbGJHelg0VUxTTnFjT1huWHJLa3hs?=
 =?utf-8?B?QkMwRmk3c3J3VUZralNZaWJPRjVPVXphcXBVeDNNaEd4MXZBaGxKdEhRMExB?=
 =?utf-8?B?Rlk1UERzWm9jNGFibVpaT2txYVE0czhNQUJzbTVmTUpUeHhqc2ozVWltb00z?=
 =?utf-8?B?TUYxVzREZmQ0eUFLZHhoaDZtVFAzK1p2QUJKYzZ0b2pPdlF5S2tUQXJYMlNy?=
 =?utf-8?B?MHVhd0d1aW1GMTRTZTFIdU9qcHhBc1RTdWkxTW5pejAzZHpQTGFTTFF4TXBs?=
 =?utf-8?B?bnFQWDNuSktzZ3hhWlorSXNDZzFEcldrZ1d1TU05Q091ZmtUMW00VGlNTTZV?=
 =?utf-8?Q?YhossJZp+9JZRx4uiUs83wuwJ541XdBqDgOrbly2zNT6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C8376B271E7DA4CABC78AEE4C9A003B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271d2a53-8fef-4644-6978-08ddde71c17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 16:10:31.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIMhixhLl+Al4VevBrjYJ1kB0H6CDPMycNRzwH9fwUSgSj6eLPEk+hJIwu9nJwSa0G722LHDBDI8bhRy79R4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_091041_926436_1D22E0C8 
X-CRM114-Status: GOOD (  17.51  )
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

T24gOC8xOC8yNSAwNToxNCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFNpbmNlIGtl
cm5lbCB2ZXJzaW9uIDYuMTctcmMxLCB0aGUgdGVzdCBjYXNlIG52bWUvMDUwIGhhcyBiZWVuIGZh
aWxpbmcNCj4gd2l0aCB0aGUgZXJyb3IgbWVzc2FnZSAiRmFpbGVkIHRvIHJlc3RvcmUgJHtURVNU
X0RFVn0iLiBUaGlzIGZhaWx1cmUNCj4gaGFwcGVucyBiZWNhdXNlIHRoZSBkZXZpY2UgcmVzdG9y
YXRpb24gY2hlY2sgaXMgZXhlY3V0ZWQgdG9vIGVhcmx5LA0KPiBzaG9ydGx5IGFmdGVyIHdyaXRp
bmcgdG8gL3N5cy9idXMvcGNpL3Jlc2Nhbi4gVG8gYXZvaWQgdGhlIGZhaWx1cmUsDQo+IGltcGxl
bWVudCByZXBlYXRlZCBjaGVja3MgZm9yIHRoZSBkZXZpY2UgcmVzdG9yYXRpb24gd2l0aCBzaG9y
dCBzbGVlcHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGlu
aWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KPiBUaGlzIGlzIHRoZSBibGt0ZXN0cyBz
aWRlIGZpeCBmb3IgdGhlIG52bWUvMDUwIGZhaWx1cmUgcmVwb3J0ZWQgZm9yIHY2LjE2LXJjMQ0K
PiBrZXJuZWwgWzFdLg0KPg0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxv
Y2svc3Voeml0aDJ1ajc1dWlwcnE0bTNjZ2x2cjdxd20zZDdnaTR0bWplb2hseGw2ZmNtdjNAenU2
enltNm5tdnVuLw0KPg0KPiAgIHRlc3RzL252bWUvMDUwIHwgOSArKysrKysrKy0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS90ZXN0cy9udm1lLzA1MCBiL3Rlc3RzL252bWUvMDUwDQo+IGluZGV4IGM3MTA4MzIuLmJh
NTVjNmUgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL252bWUvMDUwDQo+ICsrKyBiL3Rlc3RzL252bWUv
MDUwDQo+IEBAIC0yMyw2ICsyMyw3IEBAIHJlcXVpcmVzKCkgew0KPiAgIHRlc3RfZGV2aWNlKCkg
ew0KPiAgIAlsb2NhbCBudm1lX25zDQo+ICAgCWxvY2FsIHBkZXYNCj4gKwlsb2NhbCBpDQo+ICAg
DQo+ICAgCWVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KPiAgIA0KPiBAQCAtNDksNyArNTAs
MTMgQEAgdGVzdF9kZXZpY2UoKSB7DQo+ICAgCSMgUmVtb3ZlIGFuZCByZXNjYW4gdGhlIE5WTUUg
ZGV2aWNlIHRvIGVuc3VyZSB0aGF0IGl0IGhhcyBjb21lIGJhY2sNCj4gICAJZWNobyAxID4gIi9z
eXMvYnVzL3BjaS9kZXZpY2VzLyR7cGRldn0vcmVtb3ZlIg0KPiAgIAllY2hvIDEgPiAvc3lzL2J1
cy9wY2kvcmVzY2FuDQo+IC0JaWYgW1sgISAtYiAke1RFU1RfREVWfSBdXTsgdGhlbg0KPiArCWZv
ciAoKGkgPSAwOyBpIDwgMTA7IGkrKykpOyBkbw0KDQpUaGlzIGxvb2tzIGdvb2QgdG8gbWUsIGhv
d2V2ZXIgZG8gd2Ugd2FudCB0aGlzIGxvb3AgYm91bmRlZCBieSANCmhhcmQtY29kZWQgdmFsdWUN
Cm9yIHdlIGNyZWF0ZSBhIGNvbmZpZyB2YXIgdGhhdCB1c2VyIGNhbiBzZXQgb24gcmVzcGVjdGl2
ZSBzZXR1cCA/DQplaXRoZXIgd2F5IDotDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

