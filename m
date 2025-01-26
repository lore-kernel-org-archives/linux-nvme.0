Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD41C0218D
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 23:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vvf3xS+5A710RQGOz9tHdQW4D2PjUQhoxsVpVbT2EsY=; b=LYyBMYtq07kCpUKcB0zoJi4Jha
	ypZeuAe/GiNmJJoZkH8OArJy/+ajl18k8yx0XlcFqK/9rwerCXaov+GkRQ8HiMPosYFkdOXHKM/ZV
	m51ZUeGSKGfoweMHq15d/KJgjgafVT3mLl2Mz9jePj9bIk2AWBSbJ8v+celMlqaa3t/3EfuLImszb
	3Xs16T2Ig58JNY5VyPoQ1RY3mwpmRBo0kO3vPyAKu7wjzwSlQzHBJ1fCPTmwvG/5Kp6vJhc81uxXR
	yUf40u7NMFcsAdsnWtedkNEyO8ucjnGmtXWu7nG3QauwPA2sI+/O+UHjHawZ5uGrjFMurGoKEDjUF
	qjM1/0OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcC0d-00000001Dql-0C5k;
	Sun, 26 Jan 2025 23:25:43 +0000
Received: from mail-bn8nam12on20618.outbound.protection.outlook.com ([2a01:111:f403:2418::618] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcC0Z-00000001DqO-2SeA
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 23:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E81P7m/F8w75muIr58zvFQ3Rxe5uKhwjdn9Z4OEPqmJaQXuMPzN0lWG9qAEQVMalgyij/WsIC/icHjBWT8K7IjUQ38PurmtGx0HM6JmJt3yCPq6W0311i+vUKDc7SEUH4PCMRHYKrm0DLfrgU2QeM/989JnASRJaBgKAUAbGWnL7qZ8sVQTISC0vfRNwDJlZiSUOEAhsRh6cUh+WRxZvBY07RgPESG8zrqve56jzrefm40sN6zpgF3ufUHpUdzx9PjYAkYq1FVHOS7WdAmcaptkHdC3P1oqbbT4oMMAfNGCx86YdtF6J7X27JvmRQKbIhQDI6kLD+49BKtrJuWR/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvf3xS+5A710RQGOz9tHdQW4D2PjUQhoxsVpVbT2EsY=;
 b=ACdSb+UN3IQr7cZFWSDeqvRYVkVWwp8nT5gMV55FEK24V6iodzEMVSQbWSLgO+i0ft0rNtyfTN/wVa1c9jusJ1lkpK0N7GT8pbXmul6z4cBOq7+r1lhij8RkVrxqHNm9jHV3VgQAliEila2z7GgFqyOg33MJVPHC4lUP/i9+7RClmDyAjw0CQr+LLvio9Trnr9f1WXFJ2PvEpGgufh/Ai4oFUgRt9f9Rp/xmwsmPDPV+caOqKCKX3hUT0/WyyhneSbI0itZNW2ITN7pg52+sIYOdZzcM//1RDGrYcVASHInH3TeXaeS7ULJDFT/fxx9NDoOXp7oSPvX8MnxyA1N+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvf3xS+5A710RQGOz9tHdQW4D2PjUQhoxsVpVbT2EsY=;
 b=JXBCgzPlcJS5IpoCWhNUXtY/J9uF2PM302StJKcdHLhD1kB3oP/4MHbVDdZnUF9mFtBjYfk3VRVX+oMlWRgWhowIcxvfxAd/IFjKMNnBBmXQTZHLHCZboy7TvZ563vnyurODdwQt3HfFKC4fdQ+GZ6J0NZLrVArS/DSiDvP18/uMwxdfwUufhOckLS3T2UdAUFwr+21IrVezcHe8jOPSQfqf4PP08vkZaT6cJdGpY0Z5ah8my3FH12DmMGhZL/6Ku9MDQ1Jin/EIjCvV8tCNjQUjGQW9Q8jPt6ViYqZUnJfZq9/fiYAA6JtX2AgHIYZZ4mBNqwZQ7F3PT8MKqgrANQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Sun, 26 Jan
 2025 23:25:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 23:25:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"hare@suse.de" <hare@suse.de>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv2 blktests] nvme/058: detach loop device after test finish
Thread-Topic: [PATCHv2 blktests] nvme/058: detach loop device after test
 finish
Thread-Index: AQHbbjRVkllqSqSVmEaT1cLurfbgzbMptsIA
Date: Sun, 26 Jan 2025 23:25:29 +0000
Message-ID: <5be1008e-2037-480e-ab7e-1937f3933ec9@nvidia.com>
References: <20250124074753.9802-1-nilay@linux.ibm.com>
In-Reply-To: <20250124074753.9802-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: 5cecc905-8773-45c4-de4b-08dd3e60b8aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTJ2d3hxMTd1MXNKZ085WWgzMXp0LyszMjhNenk5NmxiN09DdmplU2lhS1ly?=
 =?utf-8?B?TE1Wdm1wbDNQNnpFZG9BM21aYlJQd2JpS0QwMXl6akFwZEM5V1VDL25aNURv?=
 =?utf-8?B?U1RLVDgvS21OQmtnakZTTzhZajRHMlExNVZLM2oycm5lR3ZyWWt3eS9va1JX?=
 =?utf-8?B?S1dZVGx4ZXpydzJCa2g2WTlTUTNqNVhtaTFNcVBuQ2xQMmxucU9xM1QxOEFL?=
 =?utf-8?B?dVN6Z2d0SXZ3NEdWcm1qSkx0WFBXRmlHUnQ3SUtMNzVxbG0vSWdWSTBaSGs3?=
 =?utf-8?B?Z2UzL0ozbFpGYWswcW5QSmhVTUROeW5hRWkzdlJ6RnJnRkNYeFhEeHlEaEpV?=
 =?utf-8?B?cnE4ZzJEdW9vRFlzRWtJRU5xZnZkZXFtSjVZSlUyTDZ0emJVM3ZUZFFwT1dD?=
 =?utf-8?B?MGovMmNBNVV5VUlCOTlZZlY1c00yMEljem5TdEZ0K1FNdlRYOGMxa3JyV0Fl?=
 =?utf-8?B?MUptZmRjaWNGbGExMG5iQkRDcnZueC9BTHJCd2l6aExsK29kYXpYdE1uMnRF?=
 =?utf-8?B?d3lHZzRRelIwWDdjby9BUjZDQmpoK3IvREVYUTlwOU9nTVN0ZEdYb3hhUGpt?=
 =?utf-8?B?VHdGNVlXUFVEci8rY24xTitNejl5V2NDeUI1Um5rMERqWWc1aC81UzVnV1FQ?=
 =?utf-8?B?MWVrZWhmdi9BTUllWEVPejA2Y1RCSHpuL0ZyQlBrU3dkd0xMNmZZdUUwWWQy?=
 =?utf-8?B?T0xURzc4NDk3ckJ4Y3VTc2xtU1BIY2hnSFhnYi9lc3krbG04TjAyVjB3Sk1m?=
 =?utf-8?B?NzNkYWpNcStCellWL3lmSmROU2M1aTN5WjM0ZUVXOTJ0L0hOM29LUUtQMURp?=
 =?utf-8?B?OG45aVpzVHpJdGxteWl4U3dWUnhXOC9IR21iOFNOQytYMzE0Y1VFOVMvTEN5?=
 =?utf-8?B?dEozcWxwRWRVcDFzOFB5bkxqekNISkdKT3FkZEhpQTAxYllKREE1QTRwMU1L?=
 =?utf-8?B?WmFIL0Fmd1RlVkJKU3RpRml1ZWczYVB3VmlCa3ZaQVBERmw2UXVJdlZMK1VH?=
 =?utf-8?B?NzZobHRrR1BRZm5tblZUZHZIYXhaZDhNbzM4TEhyT01zV1NpWlN6dmNZZkY2?=
 =?utf-8?B?eWx2TS9HT25wMUJKS0pEZTZ0VnhQMnZ1NjNXMEhoNWZnTGY2RXlMd0NLLzZu?=
 =?utf-8?B?RWlmdVdxVmJscko0WWRGY3pXZGRGYWNyUmtNWEFZd2tWbG1tN1pocW51UGta?=
 =?utf-8?B?a2lxbWtJUWg4WWNGSHVsbkZuRDc5YVlyOWtubWx2L2N3NHRDeHVacmtqRHJr?=
 =?utf-8?B?TllodkQzenJLNU9KSzhZVHdXNHFObjNhbXAwTENmc0VrZit3NnpzdE5iZW1k?=
 =?utf-8?B?dlg1Zk4yaW5vQXB5akJHOG1RZ0NzT2FTT09oSG5mS1QvbVJJRFJ4dlRrRGgz?=
 =?utf-8?B?WVcxRjFvSG1JR0crdHBpcHpsRlpEQzNDR21SajZuN3RLakxDTUR2L1FVWHBi?=
 =?utf-8?B?QklYUWdaUys0UE9Sd2h4SW43NWlqRlppUTBENHkrMDVVQjl4Z3MwUW1FS3dN?=
 =?utf-8?B?VkpnL0VuSW5mbGwzQzRjOVd5Vlh3V1lEckVHV1VRSGEzaW0zcEMvellPa2o3?=
 =?utf-8?B?eWdjeWFMOUE0SGhWdGJTa3IwTmlUU2tQT0ZqbEpaMFJxQnYwL055N1VkMXBQ?=
 =?utf-8?B?eFNzandWdWR1WmdpSHNVbzJIVVZ3V3lJdGZSVmZ3dmQ1VDNXRTEveFRLcjZj?=
 =?utf-8?B?UUFXSFd1MlVjMXJMdEVYeHUybzNBZllYaXpoWlRNNnV3UmZIenZKUWpNTUd6?=
 =?utf-8?B?TGJ5dEltZXBIN0ZkYVNrNWZUNkZaUEh0OHNzM29zQ3I1c0VoNjY1V3VyUksx?=
 =?utf-8?B?UEMvaTh4cm9HQ1ZhL1Y1RlY1Qm92TVhOQ3VkZTlPQnRiNi9yMmh6WXVmenpu?=
 =?utf-8?B?dEhpTHRMMDQwLzgvZXl2K0FncDFILy9VZmNscW5zYzlZNm5ZVDd4RXE0NlVB?=
 =?utf-8?Q?VjzdYSgQ9z3yIQu/wA2pkYY23kYaNivK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STNOUWJ5QUNRMzMvcGRBMXozbjNnVjVjZlBDUFZ6V2xkWGdOeVBaU3RhWStk?=
 =?utf-8?B?My9hS05zMmliakFJQzBqYUZjSHFWSXVCWUlscG5lOUt4TzZXNFlWQURuUmRi?=
 =?utf-8?B?ejJzYWtoUTNJbUE0bDkvSlUrYkszWG9zVzBIZS9NWHBMRG1MZzdoczl0VFo0?=
 =?utf-8?B?RUFUQTNjeDdyOW1aL2plVi9rdFFFaWV2MHlGRFkwRlB3MUVGMWl4Q3Vqc1J2?=
 =?utf-8?B?MWVzSzZHYnlXN2RKTmp5U0Q0Z1pENkFrMzZpbEZWODZpWWcwaTRvYmpEdGZq?=
 =?utf-8?B?ZjFOWGRPVHhjSm5FYVE5eS9jQjE4SE5hb3BtTHFncmNWT1I3bzF2UitvRFBI?=
 =?utf-8?B?NFlHS3kxNitPdGV4QTV0SkgzTmpaeC8yWHdES0tFNkQxMDRGSk9xQmZWYVVV?=
 =?utf-8?B?RHRJS2crSkVocnZycnFPUzBISW9lTXhVRldTT1ZDSWhTUXl4N2dMUGJtdWdF?=
 =?utf-8?B?TDJRNmJBUHFza1MyZGE4NEJ5QlBVMDRaZkJWZXU2RTJLNVo4YjQ2YTRMa2Qy?=
 =?utf-8?B?WTN0YzNqWWlVdTF6Si82ZjBzdXBsSEswaDV4MlZ0OVg2c1NmV2J5cktIMzBq?=
 =?utf-8?B?dHB4dDEzUjRXRHJFR1lmNkFmekRhcW1CMjBoZm1mSXhBL0ZBVnNBSlZ4bVJX?=
 =?utf-8?B?SENYb2hJdmdleUE1Mno0eWZPaDhYTVRWSUVzSkJ4eXhHbmV4SjBSdklZbXFi?=
 =?utf-8?B?eElFRmxyVTZYa0cvcGIzOC9nTWRSYThJS3JaVGFJVC9xelJtRDdxVGhVNnl2?=
 =?utf-8?B?aUdHUGc1cjhuUlYvUkVBalQxclBLY2o0ZWdlM3RjNVBCcEo1UUhtK1ZEZURF?=
 =?utf-8?B?TlJMOFpKNVFUU0QvN2ptSkh5Q2dOUE5SeEJNYmw1azZCRGQ2M0s4b2tzbmZa?=
 =?utf-8?B?Z3hvdWl2WTN6dWJYZC9SOXRETUpQWlVtcWNPRjc2cDlxcjJRMHhCd3pla2V2?=
 =?utf-8?B?d042WGZNV1hzWGFJMkJZTFdOREJQcHQrTmE1cGhLV0FLT2FsdU02bU1oL25y?=
 =?utf-8?B?aXdjSGt5bzVURHF6RldXNUY2aHJNcElDdFU0U0QzUW5xbFFLUmtTZk9KR2R3?=
 =?utf-8?B?a3F3bHo2NlM1UVR0ZVM1bDJrMnBJTjluMFVOMWMwc1pCbkFjU21ERjdpWndh?=
 =?utf-8?B?UGtqSHc0bVpvWHFlMVAxTVVCREErU2V5VDJCcFY2Ump5LzVVZmI3MEZnSWtD?=
 =?utf-8?B?MWVYZTdzMzZNNDNOTmRRRm8vM284bzBnVEVzZWZTMkNqYk9DNm54cnhrSWtF?=
 =?utf-8?B?OElKYXpnQ2hRdW1udzhzSFBDRHFTa2F3dmJKWDhETjVQbk9JOVd2NUt2VFJz?=
 =?utf-8?B?QngxNXh5U1haRHc3MEVacnA3bkVEcGV6QU8wNUhhTCtuOXdIKzJVTzV1STQy?=
 =?utf-8?B?QVpDOGNnbllRQWJpVm9OTkVZNitkU0hXSytrVTZZRHBENjlRT0dzbkVaWHNh?=
 =?utf-8?B?SUtBTTRzN242R25CTHdzK3ZuZTRyMzQvU25nM3diN054Y3M5bUlrZG9OMmxJ?=
 =?utf-8?B?ZXVuMWdPRThXcmJjYTdzazVyU2l0RWU5bXI5c2d4K1JlUzhSSy9lUFlBRXZN?=
 =?utf-8?B?RmVza3VJbWRJNUc5ajlaMHFDamJyZm1TcGQ0Q1I0R3kxeGtpcDBybTVCYWM3?=
 =?utf-8?B?dUQwZG1KVDBlK1gwZzFkZjJlT29OT2E3TERocU5TQkhnaVc4SDZvcDlrUEpp?=
 =?utf-8?B?eFAwU0U1eE5nTmpQNkNoMUFoNUpmellaYTBWbW13c1YvdS9jUm9pT3VudnpE?=
 =?utf-8?B?ck1ZZEwzSEl1b05WRXZCMlBPM1gyU3luTFBxR1FqcHpoZHZra3pwQUkzZ0FZ?=
 =?utf-8?B?TkJFcWdpa3dSZmlxTU5MaG5LN2I3eWVjaFdyVDdmL1lUa1IvWmhOMisvRnFH?=
 =?utf-8?B?RVlYVkxqZXhqZmNkOTB3YXJNMzhTTmNoOEtkOS9sZjRjY1RsZUpUbHZOYWEx?=
 =?utf-8?B?a0hXZVRhN0hmV1FPL2ZicFpGVjFQOFFGOEh1QjAweGJBZTBIN2RjQitQSG03?=
 =?utf-8?B?REZpOG1FWDc0NnU2cld1UGFaTVZGSEI2ZS9kQlB5UFdBVzhNNW92R25jRnZ2?=
 =?utf-8?B?eUtaL3NtRkFsM1BuVE5lejJrVy9YRkZzSitpUkJLVkV4NjQrdStibmQ4ZG1Q?=
 =?utf-8?B?R2RMSytTa1Qvb3pSa2pmNzYrUmo0NWcyQnFRZy8yVnRsS3RVenhmR0pFQ1Fy?=
 =?utf-8?Q?WYnhvHBMgi7qgvtMG0snFw94UuX6y8u84+i6QKEgRyM3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C4955D116B524B877CB20D89875117@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cecc905-8773-45c4-de4b-08dd3e60b8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2025 23:25:29.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9grpfSEpCM4iPgQTo5EYYgsqKfDjnMWWoErIos+hvpWkJRRdLzDeiiSol8ziblXpWW3JvMzEWL8C2AeV6do7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_152539_639794_5280E812 
X-CRM114-Status: UNSURE (   8.99  )
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

T24gMS8yMy8yNSAyMzo0NywgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBUaGUgbnZtZS8wNTggY3Jl
YXRlcyB0aHJlZSAodGVtcCBmaWxlIGJhY2tlZCkgbmFtZXNwYWNlcyBhbmQNCj4gYXR0YWNoIGVh
Y2ggbmFtZXNwYWNlIHRvIGEgbG9vcCBkZXZpY2Ugd2hpbGUgc3RhcnRpbmcgdGhlIHRlc3QuDQo+
IEhvd2V2ZXIgaXQgbmV2ZXIgZGV0YWNoIHRob3NlIG5hbWVzcGFjZXMgZnJvbSB0aGUgbG9vcCBk
ZXZpY2UNCj4gb25jZSB0ZXN0IGZpbmlzaGVzLiBJZGVhbGx5LCB3ZSBzaG91bGQgZGV0YWNoIGxv
b3AgZGV2aWNlIGZyb20NCj4gbmFtZXNwYWNlIHNvIHRoYXQgdGhlIGFzc29jaWF0ZWQgbG9vcCBk
ZXZpY2UgaXMgbGF0ZXIgZGVzdHJveWVkDQo+IGFuZCBpdHMgcmVzb3VyY2VzIGFyZSByZWxlYXNl
ZC4gVGhpcyBwYXRjaCBoZWxwcyBkZXRhY2ggZWFjaA0KPiBuYW1lc3BhY2UgZnJvbSBpdHMgYXNz
b2NpYXRlZCBsb29wIGRldmljZSBhZnRlciB0ZXN0IGZpbmlzaGVzLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBOaWxheSBTaHJvZmY8bmlsYXlAbGludXguaWJtLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==

