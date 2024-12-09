Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A65E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JidR5mFFvJY+Ouqx3RxmApRk/BqMq3AiuyDQlUsLsUs=; b=yi0zE5l/sDv0DwUxMe0u5qSKFX
	w0vijn8gWUCzbIpg12dB3/1zxuZg0eIVGNRVRKFb0K6+tX/zfitmHQCLOuoHoYeiOzb4XL8PCNs/c
	Imuu7WKjcdSpdYnVKUvcBiXesyOJpsGlobzmiLvViRVBD+OEkEnWB17ezvxYeSZNUFhyZ9JZoAjMS
	iiH56jOMj3M0E/qunKPWUY+L8QR5WoCoDH7YO00l7OOZ1ER0+qkGIHiErTF5jewsdJ1ouTBq1wdRl
	m3e458JzOksuXxFZ2rZiT9O/6ez5d+Ub/K7pcr/hcRMGfp83fwgylGrvsDY1pwO4FGfYLP0pACo/j
	jogCC0Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY4P-00000006hWc-1glz;
	Mon, 09 Dec 2024 07:20:41 +0000
Received: from mail-mw2nam10on20631.outbound.protection.outlook.com ([2a01:111:f403:2412::631] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY3q-00000006hEd-3ioY
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq8wVIQ7jN91kFLSQsToz7pL1xKgovOY7yYpl0C5gtuMF/SW1OF+Oqi4RsMqFmicvQZfwjwbuni+L0WITF4fB5yDkEPSsDeIhRFyQlt+Of4ovz9Bsse+TMPohErrYqAX3i7pE/SGfmdnFc2kmZbMOAUpJYIBm4lkY6JqS2JRmrbrwZLYnYE9ni0B8TDC9xZH2SsV1uVUDVqJBaIK5FWWT8G2fY2m9fgjhA7Cf7MV52qkInG13K5nWrve31bzwtTHBD2kNq3jwcIol0ptGzyUSaGvvdSaywsy/Gu8TZkeYkuMtBgngv4zP/RC+7qKzJbLOU/KA91lygYvRJIpc30yKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JidR5mFFvJY+Ouqx3RxmApRk/BqMq3AiuyDQlUsLsUs=;
 b=CrRjSagn0QGTxm0KQ1pfZ/Wrn4Ni7kIRkvikCiiE6ZIinA+MdFl8soIEV65t8MtIuJybW0iDMaeJyVZTEriKTM8EZg52RkfadNS5tpzVir0vx3Nexq6XMlyKJZMVzs3zf/Esi/Gq7WIfmSjbS8PEfQURCvtM2wevaTYsCUicSfr/07WptrFWW3aCxTjk510MCBdZAzSY5GjXOxXjqlDVDrwIpua0d9PlybgJA1H2oviYSQ5q7GHs+QTCNZzWCLdr/QuXniAd71iEGjevllmq2mbUjPAgJDswZD+IB4h0jHfoeckVQorlRrMwekVAAfYGlMBUJNogMrt+waZiSSVeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JidR5mFFvJY+Ouqx3RxmApRk/BqMq3AiuyDQlUsLsUs=;
 b=G4hE2EDHbZlOfsYaDur6Yw6FmXyVxz0VKOt7YtOaxjHDTxT2MefVThMw3JTp1eHCY/4czF4Z4bdpappcnowOJ974jRWIzRU29j/HGWmm/fo1Itp7TIjKAix6NuMZVRk/1g8kfVAeBxGya3Mj2AVlJ8IgXdpQ/33Qlzgh6ecszvzkxcDQNmRl+iwCGVuyodBWjnn5lW+rVd78NYuUyRREg746mHRM7NhSTEFGwm8LN4s4S04LuuJfowIdeOx4MVjasWuapwX/aAqJ+9JzQCfT0TrZ9Q0e+lpH5Cqt8W1NKkEEFWXRrF1o0y3Y2sBQk0qyXBR46zdy/9qOGxXjNHVDBw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:20:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:20:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 3/5] nvme/030: only run against kernel soft
 target
Thread-Topic: [PATCH blktests v5 3/5] nvme/030: only run against kernel soft
 target
Thread-Index: AQHbR+YBhCe872aRqke6J+BPkMzNw7LdhbiA
Date: Mon, 9 Dec 2024 07:20:01 +0000
Message-ID: <ccaf6447-605d-46de-8d42-42f9d53ff468@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-4-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-4-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: f25e685c-9a89-425e-8e02-08dd1821e57e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXdyeGt1anZSV3ZnUVJBM2V0RXN1amtDbjlYTEJsWGx1ZTY0TExHbnlDRXQ5?=
 =?utf-8?B?Q09pblU1NjdHa3FqVjBmbmNMazVqWHZlSXpUc1lWWmhUclU4WEp1WDlFMkFP?=
 =?utf-8?B?TmFhdmZuYmszYW1tdTlmMUZLdXRERDU1SWJqdHVIenU0Wk5JbmdRNkRPYkMz?=
 =?utf-8?B?OXFOTmFpY3B0c3gra2pXdXNBS2NIZVVHbDdDeVMrbXpIZmNPMjNVdHU5TUJC?=
 =?utf-8?B?RlZsTnQ4Yk5la1RiSW1xYm9NVmkvTFczOUhUdjJ2UHNOR0lIZHdFbjAwbFds?=
 =?utf-8?B?NUdrc0FQU1NYZWprVUovN3NvN0JaZmQ5SHpOV1F5WjJvckZiWU05SWcrdDJL?=
 =?utf-8?B?UXhNN25ZaE5VQkJhOXVtenJ6aloybzJ1alZkajFwcFdBUENpdk41TVJCYUJN?=
 =?utf-8?B?ZnFTV3k3L0FubTcrVmhLcHpMSDhQVzlaY1NvTWR6dml6Z1VPM3J5U2s0RDVO?=
 =?utf-8?B?UnlpMkhnZFV4Vkc0bFpLcEVpYzlHZmo0NU5wYXExbXVaME9WQU93L0dQcm9n?=
 =?utf-8?B?MFJRNE9mUTU1cXVXWmp0UjZjUTFQSkM2WUg5RzlOMExiem5SaHJYNzU0Qm9J?=
 =?utf-8?B?MFcybVZFVDNyNUVPbHVxejBUeWUwSHVqc0E4VWhXUlNXUjNIdlZvbDZMd2FB?=
 =?utf-8?B?c0JmT3hqbHRMdHpBUTA2dHF1WEk2enZxK3I1SUlFV0JQTG4xSTBQS1J6NVM2?=
 =?utf-8?B?WHJjRGg0RWZGOWpwL2lIeW1DU05hWlhSYkllSVNTWGh3YkVicmgzUnJ1eXRE?=
 =?utf-8?B?Z1lLOGtpRmJlYXoxNkhRTkgzNWFiRXI4d0NJeFlKS3V0eDJpVjhxSnpkdi9X?=
 =?utf-8?B?dDIrNWJqT2E3QXE2amRxeFpMRFplNi9LemxtY20ySmZEeURIMFVsL3Frczhi?=
 =?utf-8?B?eEFvaGV6Z2c4RXkvL29Ld3FMdVp2UGhOTkduTWRHYUxRNThBY1h4TUVjNU0z?=
 =?utf-8?B?clZvZnRoSlBJQW5nZW9FdVh3d2hvM0xjTmVNSUNpUDlJb0IwRlJ1aUNNQkJt?=
 =?utf-8?B?MEEzNUJzcGQ3Q3l4MUMvY2RnenJvOFFOeU5uVkdjZmE5Mk5KWnEyOUNUSlBl?=
 =?utf-8?B?RWptS3QxbWV1ZkJpMEJvYjRlWWVCeGxqL3R2STZoR1RXQUFORy9EOFhiQ0xW?=
 =?utf-8?B?ZnpIT3JrMm5KaVcrdHlKaGpSN2U5QzUrWThnZEJsWDdMNm80RVRFeDBUZ2lL?=
 =?utf-8?B?azhucFZBeXdBMTlHUWdoWUVVVGZTZ2duUnBvODJ2emxHcHZPRnhPUzNCVVh3?=
 =?utf-8?B?YWk2NTVLbUNGRVpqRXRBRHkrMUZXR0hpMlNGU3ArN2hFSVNCeEhsT2FTcWIy?=
 =?utf-8?B?NWw5cnd4eUk0dUEreGlqVjJKOE1nNCs4SVE3WWc5NXhZQ3YyMm5wRlNkb0dE?=
 =?utf-8?B?QTc3MG5SUmpjN0VyZ1hhQmJLcmhoQldYR3BmR3M3cG9XMFFnR0tJYzM2ZnFO?=
 =?utf-8?B?MVlYMVUwNE1uU0dmWVVEZFZBc2hId2JQQlZjS1E2RnBHSEpJOTlUOVlWQ205?=
 =?utf-8?B?U0JURmhJcHlwUEg4TUU3N1g1YVFpQ2lsalBaSHpjc2tyMTBleG41Um9PTXNQ?=
 =?utf-8?B?eVBIQUM2SGZHTWxudUdyTFJSeVJFVlNvcEdYREVZVmRoRjQ1K2Z1U2RjcmRW?=
 =?utf-8?B?TnpsZENoWXpjMktZblJBMWovUGk0ekVMVVlkYTZNZXNEVjlIV05qSStlWEVY?=
 =?utf-8?B?bmNOQnJLVmZBWjFZM0NXT1l6SkdVZnliRHFYR0psR25lYkwvcGhJcTlmdjRT?=
 =?utf-8?B?UE4yNERqV3ovYnlrWGt1eW9raWZGRUNOdGR4cXdEK2xnWFRvVjFOY1htdGQy?=
 =?utf-8?B?SHZHYi9FeDZ5NkkzTnMvMDFSak5VQ3psQ3FNc2JZNyszQkswbC9xTmRBNW5a?=
 =?utf-8?B?VldDQ1FCbmV4UjFqQW84N0hTa01BVnhORnFTb2I2bnl6Ymc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBZZDV1UVM0V1BxZ2UwTWRHWU9vNk9oNnNZODJPa3ZlQVh1WEZQcUpMS0tG?=
 =?utf-8?B?S1VWdzF0WkdNbERqVUt1bENpNzdWR1ltcjAvN0VWRStvNnRHN3JYVExhQkxM?=
 =?utf-8?B?YUxwVXJpcXlZTG9HWWt4aFZGK2tyTm1TZmExQmVLNFZ3NFBuNWFGRGR1NGk3?=
 =?utf-8?B?dk84dGFYOG1JZm1kcDdTbmh0UnN0c000cDMwMHhNa2R3WEJDd1daek1WaEZ0?=
 =?utf-8?B?L1ovZENxamh2SDNyTkhSNDh2SE1yNHVuS0FqM1hRSU05eUJtekJqNG9nRk0w?=
 =?utf-8?B?U09uK2ZZZlYzb2dvQ0pwS0lWUnEycWNybXJwb29taTAxb3hGYXhEbzFwTERR?=
 =?utf-8?B?VTBSbUJhZjg5VmZ6SXlKYkdQd1FPSGpKSHNXTXl4akx5WDR5Nk9WWkQwNXJL?=
 =?utf-8?B?RWlGb3VoZDhxQXhzSmo1NytobVVkOUF1eTk1RlZCN3FLWXhYaEI1SEZPanUv?=
 =?utf-8?B?Qk1pSDFDV3FkeW1aZXNmamh3ZVZTVjJ3SEN4Y2Y2a1B5L3phdVdpWGJBRVB0?=
 =?utf-8?B?M2FhU1VHMGFZaFFKOWI5Ukx1NlR0S2prWGZRbjFzWTZvd3dXc2dNOUNmL0tx?=
 =?utf-8?B?VUJLWGQzRENmWFoyalBDVlNVMURvMHVaVExCbUh5RFdwZnZwbWNQY2R6aGdz?=
 =?utf-8?B?TzlrSG1wTTdkaUxuSGttWVd0TTRqWDFzQkhyRHR2RG5Jd2VaNHp6UXMyMS9D?=
 =?utf-8?B?azExN2MzalduV2hzZjNXekNJalRIUmVsNW1lVUk3Z3lyckJHdEloYzZVT0FT?=
 =?utf-8?B?Tzl0RFBPTFlqKzJyVFZNMFVHcXhZMGdkbkVET0FUcjVqMkVMK08wTkRCOE1i?=
 =?utf-8?B?bk5PZXQ5Q3dibGl2WGZrcHFtcjRBTUhaV3FvQ3lLUGJMclZOdWlJR2Jlb0xC?=
 =?utf-8?B?Y0k1OGFMcDMvc1ZnNWdGSUU1aG1oT0Q3L0t4NkN6NzQ0d0RsWjhyL2grQTJD?=
 =?utf-8?B?emhVbnZ0dmFoNjVQbGY3c0Y5NGpMM2lNbHc2azRyTmRkMGFsOFdzWDRKd2tH?=
 =?utf-8?B?amJBR21zMFhYNWpPUGhTRmlQZDVKc3YrR01jM3hOVWNUNFVjOFlCMXAxM0xW?=
 =?utf-8?B?OVdmc2lVdUpjMkVuNXcvenZlL3liNlV4UDNJWkN0UnVkeGU2M2FFU0MwOWRn?=
 =?utf-8?B?QkhJUmJhcmE3MnNZRWFsYXZjd2xVbTdacnFDUjhiazJvWFRZRVh2QzZwUDgr?=
 =?utf-8?B?NERWWDVDd2xmejZ1TEZEL24rZlVJOGlyQnEwSDdIOTBsL0RyL0RneFc0KzRQ?=
 =?utf-8?B?d1RRd0tKSGN5Z2laMEYva0ZIOG9TZTZiZ09HT2Y0ZzhvR0JuNkpwUU9OdVJ2?=
 =?utf-8?B?UU9JOUhYa29TUkdiMHlIYW9CVTlyVjdPRFljNUJXekRmekpKbVhrajVGY1pP?=
 =?utf-8?B?VVNsTHN2K2J2STlqdGJOWUY1Z1pnZXpFSFlESTU2ZEZaTVM1OFkxNXNqVzFm?=
 =?utf-8?B?ZCs1OWdrSkh5Nzl4ZCs3Rm1yMHJzVWhNOUh6SmVtOVMxZndyL09icFplcmhr?=
 =?utf-8?B?elFMeUltZENwVW13WVlISGtnL0NISlJsTWZDcWxNQUtGU0hyQis2S0pmdHNh?=
 =?utf-8?B?S000ZGkzc2s1WHJQR0ErYUZnUVRCLy9uYy91WkJsNGRvTnBBeVBUSWpaQzFx?=
 =?utf-8?B?YWNRdEw1TTlzRm5XOGpxTWpqd3pXU0hVajNSWDZVb3lRWTlhblhiWjc4YU9i?=
 =?utf-8?B?cmc0NytKaGl6Z29IZWpJYkY3RlVYV1pUMEFYNkZhVFNLcExtMC9QMDBtK2hL?=
 =?utf-8?B?OWtGWHBXWHBFeXJPU3Iwcm5iWVE5NVhUOGcwdEJ2czgvdWo2THE0S3lFeTNF?=
 =?utf-8?B?ZFdOMVhQSXluN0VlQW1udFVGc2oyQzE5Snh2czVFTTdvVkIwdDNzVVZtakZD?=
 =?utf-8?B?SzdWWUpLcFFEaVRGKzBhV29ackZmWnFEckJ4bzkxQmdVZGt2cFF6MUE0OTR0?=
 =?utf-8?B?cHJFdnRFOE9PS2xiTjZJVzgwQ1RCaWNudFR4UGlka1BTOGxyUzh1YjZFcWYz?=
 =?utf-8?B?UVY5TDlrcmw5L0FDZ0VSYlhPcDhVby83YWdQbW5EM2ZUSjdtM3Z6QTBwTzhB?=
 =?utf-8?B?TnlsYkdrU0loemdUeHd2NXlKM1VGSjJ1Mytna1JWSGdqaFg0SnhSemQ1SzFO?=
 =?utf-8?B?b2VLaHVYdHBHTUNBelV1aEZhS09Ub2N0ZjcwVTNzd2hoNXpROVNnbnVlNVFH?=
 =?utf-8?Q?sAsxm9mEFl2c+vhWOwXJqB/tKlbDcx1fpl6xIYc2lCq/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCF15977CEB3BA4C89FDC500057DBF71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e685c-9a89-425e-8e02-08dd1821e57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:20:01.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PM5nyV9o7Aa76u3ROf/6hpup2CRRQMLMl6llIjmnptMx/9Zn5BZwiMjOAVDcA8FZ2enWk+a5w9W3ZMxYoOTI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_232006_926080_1EFE7B39 
X-CRM114-Status: GOOD (  11.39  )
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

T24gMTIvNi8yNCAwNTo1MSwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IEZyb206IERhbmllbCBX
YWduZXI8ZHdhZ25lckBzdXNlLmRlPg0KPg0KPiBUaGlzIHRlc3RzIGlzIGV4ZXJjaXNpbmcgdGhl
IHRhcmdldCBjb2RlIGFuZCBub3Qgc28gbXVjaCB0aGUgaG9zdCBzaWRlLg0KPiBUaGUgcHJvYmxl
bSB3aXRoIG52bWUvMDMwIGlzIHRoYXQgaXQgZGVwZW5kcyBvbiBpbnRlcmZhY2UgdG8gaW50ZXJh
Y3QNCj4gd2l0aCB0aGUgdGFyZ2V0IHdoaWNoIGlzIG5vdCBjb3ZlcmVkIGJ5IHRoZSBzdGFuZGFy
ZC4gVGh1cyB3ZSBjYW4ndA0KPiBydW4gaXQgYWdhaW5zdCBhbiBhcmJpdHJhcnkgdGFyZ2V0LiBK
dXN0IHNraXAgaXQgd2hlbiB3ZSBydW4gYWdhaW5zdCBhDQo+IGFyYml0cmFyeSB0YXJnZXQuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXI8ZHdhZ25lckBzdXNlLmRlPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg==

