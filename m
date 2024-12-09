Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC2E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UlizkyotNkfnO0DwUpcxnWvFAooUjvHoAwCzzZBWxhk=; b=Pqc29uB+FgtR/k/TJZxqo4GUYA
	C1Ew6zWFwkZYzTBz96nneYTb7Fqsu/pM5/ggKpbTQM1KLwZ9F4oeT8xbePvlorAS7VhFBQKRzd3xR
	Awimb9sQHIS5e0lQihb2SzOXr3Y7dF+fzPFBn1ZLYbwCcfz2WuEFtLJHaytEQiPowK0a9jrgpuJma
	Sh57tq9avQBabLLePK6RPSmb73xO4inFdVn7E1+O5RdGs4XlaV04m1ZdX6Bl0efBd9XqSB2pqe9+B
	/VFruFO9Dw2N4guLkyQ/I5Ub+BOkovWL6xVfBF13Thr/YolAVDDb2xV7t6rl1FdY7cerdPvIIQjlZ
	KiuswyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY0Z-00000006gVa-11hf;
	Mon, 09 Dec 2024 07:16:43 +0000
Received: from mail-bn7nam10on2060f.outbound.protection.outlook.com ([2a01:111:f403:2009::60f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY0W-00000006gUo-3yuM
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvFKeuBMsdO6ZPmSxh7v0D4UZi9Z2iSxqKz6z1plonu4BU6S265AulWhY2qQEy9tYOTg6HbhqZffZoQFInww0rwjbH5j03YTLMNd64TQtr1hewV+Yj90f5ioLHCpUQb5amTwGGUIyJR5xkfNL5Jdm9HQE0s2HYK0Z28PLKneSth1Kp5BVF1JujGd6Fo3tP/ZzJi4cWZ4hjBv5ImcRw8JVGR9MdxnyoHneMvlHcUlJemAOOh294bNF+BEuuOGbyKzsAj1XAmOIGg/hXBx+42p/Rv/x2PLbLQjJys4U9h0zDpZ4TKJliUr1hg5mrpmVixrf7EQdnT3NU5x/vBklpT/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlizkyotNkfnO0DwUpcxnWvFAooUjvHoAwCzzZBWxhk=;
 b=R3teTLMQmAd6/YPhiY5BZbS10tqkuF8pSA+m4d8YRCnntdEOZ6WHIWTlJENp3iEt34YXTCYQpTfpIHvRswQK83vPxvy45MEFX0wjPyW+hJlZHFUyk4YaK2YmLy1Xdi1A/73MUcCJOVaZcyJRJYJrz/GPmAHK38qCXWtLanW9+vx8k5Ec8Ij8LOLO8/I6m9TauTujNrI7RlUh4+VNwxPjB+CNTBCSNxmru9Ip8kPhAMIImABFc2ZRHFdp3x5Ahp+2eiSXywCqEGdI+z+gd3AoIS/NUYxA2+pneCXdEqeLLj66Cx9TMvvPLSz+g3wdY2XmVyC+ei3YD2FZGocYXiJ07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlizkyotNkfnO0DwUpcxnWvFAooUjvHoAwCzzZBWxhk=;
 b=E8crIbGwhyLh/uBFSPWJyygbjz8ZrIparezzw8cEtETFoqdnKlSNHJzkQyz0y4s4CrkF/MRenmHFMK5Jl9GsmiNfGtgrrq2s6lqm/5bB6EEf4nR4IGT3/lDROeZBVJuAhHr1aV1CFW8TKKES5p04Ml8b7a1xAe97jcXUUMwdQl9vuopx/aKBXIroa4AehXcz0L+XOvl/8h7m9+A+f2DPztpb/bbmPuw3T4q8p1qnOctwtp2aiyaBYGg8Khl0If5GD65f7O0Flg1tO9BnlZ4Qp1X8GqWAGSNDye1qAMxsKhr7Dr3WyUyuJ1nVz3CJSgke11RAjffjdy8WkhdM1Gl4NA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:16:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:16:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"dwagner@suse.de" <dwagner@suse.de>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv3 0/2] add nvme test for creating sleep while atomic
 kernel BUG
Thread-Topic: [PATCHv3 0/2] add nvme test for creating sleep while atomic
 kernel BUG
Thread-Index: AQHbR9Ca9YNM5yqFM0uZR7zGMDU9vrLdhOgA
Date: Mon, 9 Dec 2024 07:16:30 +0000
Message-ID: <442a8cd8-bfb3-443b-93c5-e31f95f3f5c4@nvidia.com>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
In-Reply-To: <20241206111812.489140-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: 069f68d6-6a83-4aec-8a63-08dd1821679b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGNKZkxnWDYyTFFvQXhmOEl6LzUxdlp1NDQ0TDkzSWxyaGsrMHVIVHNQd2Nt?=
 =?utf-8?B?akFGdUZNMTBIQW4wVytVUGVVdGRIdlJnUnBneFJzWFhEdEgrcDRETDRkZVFS?=
 =?utf-8?B?TzFtUWw5ZWtxTmtaQ3dSL0F4TUxKdzBYZ1VVWDZZQ05BZ29sRlYwbDM2SW12?=
 =?utf-8?B?RmU1bGJrdGJLKzRpL1NZaXVGVUU3LzVDZDUzZ01BYzJlYkpJQThmRzhiNVdC?=
 =?utf-8?B?OXJaTUtsZzR3Sm5welpsaWh1cTBnY0ZsUmNOQ241MHlkd3Z1S2d0YW94U0x2?=
 =?utf-8?B?Vm5RbzhlZzVEaU9jN0I0MENxQzc2S2M5dFEySXJsZmYySmRvcjA2RzA2SUhT?=
 =?utf-8?B?VC9TaFBmd2pIanJaWkhxSjNGeTB4Y1hsaTAyUGFVZUNqeWRjTnlzaWtaVjJB?=
 =?utf-8?B?dnZDcnhVRk9sWU5KYURnbFE0dlpwdWNhZXg0OSs0VG9FWHpsSXk3WThoUEIr?=
 =?utf-8?B?aTVMNVBXSjkrSGhXTXlXUnFqVy91bWFHMmdzK0c2akVHV1JrUTlrRGlQZWxz?=
 =?utf-8?B?RHNJYUZwWGk1dStZYlYyYnlHWC9EbndIYnM3eW5ET0JGSUpjRUthdkdxN0NM?=
 =?utf-8?B?Ui9GMnF3RHM0Yk1RbU85TlloblZUeXpnSG1pR3llT3IxQlNIOUJhNGJMcVNh?=
 =?utf-8?B?eDh4ZmgwVGtaWXJFTG0rODBZdlpFTlRMWCsyUUg4a0VDK3VHSkgzbmNWdUJW?=
 =?utf-8?B?N1VjTWtRQWNSM2J6aS80SlRIVTVWMW5vckk3WjU1SUNLVDRxdEF2MWMySytq?=
 =?utf-8?B?ZUJ1bG5QTHIveTEvUjlVa2s0d3RkdXMxRUdlTUF2ZzhKL2VQRzIxenMrNW9B?=
 =?utf-8?B?SnF3M2d2RVZMVEl3VDVwRDZOVklWNmt2SzZIYjZXTE0vK2c5L0FnQ3UzREd4?=
 =?utf-8?B?NHMwOFU3TEYzalhJeDNJZ21GcDBJb014M1hSWUpDMWJnbHdTMTE3K2pXRGRV?=
 =?utf-8?B?QkFZMFFSdnppUVpEWFFmWW8rRVIvRXBDYmkxQWFmVkM4ck51dmhWbzRVUXpr?=
 =?utf-8?B?dTN0bjU3NUJjbm8wbG45Qm56QUhwWkNhVy8wMVZ1T1FubEZtdVB0dmlWVkdB?=
 =?utf-8?B?M250YnpXQjFHWGIwUVkrK3YvMllQVjQyMWlYKzQxNXE1WHZUbVZXV21pK294?=
 =?utf-8?B?WTQzNFBUSW13T1hsRUhVWnBBOUhvSHhaTEgvS3JtVTdKREZoY2RaOFVocVli?=
 =?utf-8?B?MFh2ZkxwcVZLM3lkV0ZBVGQxQVJWZTdybkN6eVBHeUUrRVdaUHlLdkRSUjBR?=
 =?utf-8?B?eiswaFRqTDZ3MnlTRE9BYmlGeWdQbFJEZVB1QTBxV3o1elhUSnhSL1ZBVmFS?=
 =?utf-8?B?KzQ4WDYvdWlnbGcwSnVGMDdRYURqN2dKcHFtcU45cjJTUHB2cVNyU1NPdU1U?=
 =?utf-8?B?ZU0zWkJseGphallzcmVSRlYxUlpSVXo0MEw0K01td21vSHF0ZThTR3k5Wi9P?=
 =?utf-8?B?NWRIMHVKWVN4UXZPTE5oY3pxcGlLbkl0K3ozaGw1SFFCenZDb3FpTnJUaldE?=
 =?utf-8?B?bm5VamJEMGFQbnV6MWlwemwvWEJyeS9OSHp1MUR1TGJFVnNhK2FEZnNnSGN0?=
 =?utf-8?B?K1ZYNjY3YkE3RHhWYW0rU2xXdDZXc1hGcElSVWcrM05MTFlMNUlGSkZzQnc3?=
 =?utf-8?B?Tmc0TEhTYVBPN0E0Y2Q3UVRYam4rZHhRTXZUZENPNTNkWEY5TndiTVpaSWlN?=
 =?utf-8?B?QTU0WkZWMTFZTzJ5UVN4d3VqdWVwUktVRG50VVFVdHJPZkk0RDh3eTNyU1E0?=
 =?utf-8?B?RStPRU9kTkRRcHMwK3pkbUhsZ3Vjc01ZeENnS0xweVlvMlpKbVMrdHIyOFhy?=
 =?utf-8?B?SG4xWTgzeWtQaWdaYmZ1eTQ0NUk1a0M4UUYvb3JTdDNFRkM0M1BkTnN0bWV6?=
 =?utf-8?B?RmxibVV0Y1ZQZERrallYVGlyNmZoK2l3N2VQSW9vTkx4Nnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHRoU2ppbWZQdzM5NFBsdFp3T1o1cDhmQTgzLzBMYjVNcGJjWXNNY0ZzTGZI?=
 =?utf-8?B?MXhJM2FoWDhES1NxbUhTaVFUclRHUkpjMXptOC9ubFNLZllOMmsrbUFqZVkr?=
 =?utf-8?B?SEtLNXFJeGZqNS9tSnc4YUtBVEQ0Y0FvME5hQk0vZ0tVVDhHdTRsQ1BKbDhD?=
 =?utf-8?B?Tkdwd3FXajJOblZ6ZDRkTFZsdTU5R3NtRGRCUVl5bUhoSHZKQVROZDgzK0xE?=
 =?utf-8?B?STYybzNkOGFId09BVFdhN2ZSVlVjb25HT1R3MFNScW1keWdYQVZ3RnZndFFF?=
 =?utf-8?B?Y0Z5YnVjUk96bnYxdk5NVlJXQkhWMUo4c0ZxVnRhK08xbXhHTVRrWjE2clA1?=
 =?utf-8?B?SXFoZjdqSjg2YWdIblg1ZXFuaTVGdFFKZC9tRXlCbFNBZVh5TlR3bVZKS1BD?=
 =?utf-8?B?MDVtSmE3am9lY0EvcDhNSGxOZFpCSzVVblIzUFVjdkEzNVZiVTJ3S0JSZElR?=
 =?utf-8?B?dS9WaGQ0UU5KREZ6bk1uNllOZTRKMUFGQTA0NHA4c21JNnBBSk52VGk3bnd4?=
 =?utf-8?B?MjdBUERXRGVhZ1IzVWZNMlBWQ2RZSm9kTVk2QnFNeWluUzBwOVU5Uy94Q0Jx?=
 =?utf-8?B?Z2pEbStLai9hTWxzMmcyakRpYzlKejZCYXQzQ3grN3R2UG0xRHNxcW1uNWh6?=
 =?utf-8?B?SGtYejc4ZWhkaUFyTkdhdnN6cUNEdm51WkNFaGNEQXFBeG8vWkhycVhzSHZN?=
 =?utf-8?B?d0dtK1NvSkx5Q3RzMG9YZEJ6U2U2MFl0ellva3BvQ0NacVJ4V0p6UE0reTRl?=
 =?utf-8?B?RHVkMlJMYi94K1NYeU0vRUZ3MFNSYUoraTJsaUVsckZ5U2puUWtROXlFcXdM?=
 =?utf-8?B?dElmMHVaakY3c3pTN2tyOGVaZXI4Zi93RWJDMFkzQzBMT05KbzFNN0s4TU1q?=
 =?utf-8?B?Q1VrOGwyTGo0RFdNNEo2OHBBUXhlS0Ewek9nVncyalZ2dTdBb0NOWnVhWFJG?=
 =?utf-8?B?OHFacHZCMlJrZnExZkI4c09PMVNGK1VPaDFMVHZablFtLzlHMWZNUUdQb0wv?=
 =?utf-8?B?Tml2UEpoVndqczAzNVVndkRGazA0VHVuS1ZRT0x4VDJyTGZXdlcrc2VuOU05?=
 =?utf-8?B?N2ZmWkRYTG1zcEZCOUk3MWtuRHJjYndJYnd1ZmFENDBlSU9VMVc1cmJ1K0p3?=
 =?utf-8?B?SnVTU290TDNtNXpCMjdDcCt1M24vTFlQQ0ZhbE9BWGdObThxM002NHBlSUo3?=
 =?utf-8?B?WE5abUxWVVozaDdxRk5GejFTQUVLREttLzVRc2xwUDdkNEhmQlcwRjQ4MGRK?=
 =?utf-8?B?NFRlTlFFT1FLVzFYVEp0WXAyZGREZk84S3VQUUdEMUJoRlZueHZSaEhOSEUz?=
 =?utf-8?B?M2dQckRwWmNiVWJCMTZBU2JGbEhEUmtFMlpGRUZWNnNxZFNJdDk0RW82QmNO?=
 =?utf-8?B?cU9jSHNQcDBSMGZSNTZlVGhTMEt3RFJiVkZMRDRZbVRwZGpYbzZoT1NzcVdI?=
 =?utf-8?B?MFV5MDZjOU96bDI5WkphY0ErcEV6NUx3TXBQOVBTVDV5TVFsZmRoWHhDNkNY?=
 =?utf-8?B?UDh0Zk1GRjJYQ1NHYUwxbXlYWmVnWnl1b0RBaW5PT3RRL29XM0RKbUxPcG1t?=
 =?utf-8?B?VUV6cTIyUFRUODZWc3B5Y2VRbmFvdFdyWGNIVU1LTmlCdFNPY2ZrSXgxOEVU?=
 =?utf-8?B?RTBGdDVuSDdKL2RxdmRLdGhHVVJGck1OVUc3THhDVmIyNm5XaUkxV3FxQkpO?=
 =?utf-8?B?ZGV6a05xWGJ3UW1IR3Q2RTFlOWtHeGpwVFNYK3QzU1hhelYyV1NzMXUwMVNP?=
 =?utf-8?B?SGR2UW82cTNwZVA1V3NMMzVVdnN4dG5yaE0zaVRwdWYzV044RzhKT3B2L2VR?=
 =?utf-8?B?U1VYYnRMR0FZUXV0YjRpbk16Wkp3ekdRUEpxZ25KVi9tREhqSmpvTjlGcE9K?=
 =?utf-8?B?bG1KTk54eFlPYzRsNjJ3cUdaRytxU2lBbDNnRnF3KzRJZnZIUTcwSmdmdFhs?=
 =?utf-8?B?UG4xZjVMNFVkZWw0bmJxbzQzTkpTcGF0MU1MckpnbWZaNzFpMmxTL01HM3Zv?=
 =?utf-8?B?bHZYZjlPRXRNWGF4NjZPNndqWllvV2JKWkYySUNWUmlpRXY2TU00UFJCVjhq?=
 =?utf-8?B?VHk1V2RaaGwzWTRPd3Bsa25udExhemw0bE01UERQdjhVdmtqMGl2bC9TZlpV?=
 =?utf-8?B?VU5EK0hkR0E4V0hPSHMxOUEwTDVNdmthS3ZFeVIra3RyWXY2eWpheUNIMFc3?=
 =?utf-8?Q?2VR9hsSZl8VXifPhmh29j5BSWLyln1c4Z3Y9GVHXwWpV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <453707CCA20C4F40916C8F8D005F6D65@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069f68d6-6a83-4aec-8a63-08dd1821679b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:16:30.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aA8DDmT7yduoxmWIaLaThRACYinRNviXnBBSmpTW72HOK9ww9M06ychhN0Xj8H33EfvtbFPnCPjZVb98tjX6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_231640_999035_0155D404 
X-CRM114-Status: UNSURE (   9.93  )
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

T24gMTIvNi8yNCAwMzoxOCwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBIaSwNCj4NCj4gVGhlcmUn
cmUgdHdvIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMuIFRoZSBmaXJzdCBwYXRjaCBpcyBhIHByZXBh
cmF0aW9uIHBhdGNoDQo+IGZvciByZXVzaW5nIGEgY29tbW9uIGZ1bmN0aW9uIG52bWZfd2FpdF9m
b3JfbnMgZnJvbSBtdWx0aXBsZSBudm1lIHRlc3Qgc2NyaXB0cy4NCj4gVGhlIHNlY29uZCBwYXRj
aCBhZGRzIGEgbmV3IG52bWUgcmVncmVzc2lvblsxXSB0ZXN0IGZvciBjb21taXQgNTA1MzYzOTU3
ZmFkDQo+ICgibnZtZXQ6IGZpeCBudm1lIHN0YXR1cyBjb2RlIHdoZW4gbmFtZXNwYWNlIGlzIGRp
c2FibGVkIikuDQo+DQo+IEZvciBmaXhpbmcgcmVncmVzc2lvbiwgYXMgc3VnZ2VzdGVkIGJ5IENo
cmlzdG9waFsyXSwgSSB3b3VsZCBzZW5kIGEgc2VwYXJhdGUNCj4gcGF0Y2ggdXBzdHJlYW0uDQo+
DQo+IFsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvdHFjeTNzdmVpdHk3cDU2
djd5d3A3c3N5dml3Y2IzdzQ2MjNjbnhqM2tub29iZmNhbnFAeXhndDJtamtia2FtLw0KPiBbMl1o
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjQxMDIyMDcwMjUyLkdBMTEzODlA
bHN0LmRlLw0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

