Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1BD3E788
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGRQ/CgH+TPOh6otXArR2/cfpQUKgDmJ4xg/IeBPOe4=; b=EJNchntw2SFY6+QhcDqwHM0pS1
	V4LgJivuUM0G5C0KoC05cYN0Cz32r1GRsiOgSwg1bsrWtt0Fnx7P9a+aE6WyFNDfnZNg8vB12cCru
	vRJ5BpfWySZ18hE8Q89g/3nu1mTcZ3h/PIkbVjx55i51k2CHgDW1G++cTE4popnYGOd95LgIUr7Yp
	uYm/0246f5a1xUhmzHBNPywTkvkwwvYEEDhGCwyAIGhinbCya622mu2kztlBxJGA1Ig5I39xncwo2
	PNvyIRT71MAWfDz44zxrfdU9Nc0w8+UR79ETHOR2KqW0GfbTHvXKKo6lg56Bt4XQONPpcNVkOEa/2
	xdKbZdwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YT6-00000001qhc-1fry;
	Wed, 06 Nov 2024 05:20:36 +0000
Received: from mail-mw2nam10on2061b.outbound.protection.outlook.com ([2a01:111:f403:2412::61b] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YT3-00000001qh0-2zw9
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV79qKSH0q+W6XPvI2ufFWfsc7pClVwqRxDbVwz5KqyAUhmyF4YW5H2i6VLctvmKlT+RjMZSMIHLssyDHScj7BeiBZXf2L30psTTGnHw4ZH0jlMe+8bLD7EXSktAwVCiA4fxOqA8dbFUbrKiv92WkbOExLzDinkSGKWWZFNxka6bkTJ1Rupl2BhuADyN0uZRYut5TVRKiBldSe0YoVqITa/TG+olRdiGkBqyhxdPVa2ofINOaVfUrQ8XD7hNN1PTX8FpHsOHf8iFWjhWR8N5IZ5nycLJ6J7dhTp0yh7VqTzswNElz1mdoZ20XgnH1n/lzl2vPeoADcMHR/xoASI/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGRQ/CgH+TPOh6otXArR2/cfpQUKgDmJ4xg/IeBPOe4=;
 b=XhvvKyvpnrdlysIMuThDyKPHCU9nVkjjVKF5NnesDbhN39ehKJYnGQPoXZg3bjCpruhdw9AnziHDPYmvmy/A2/i9er1Q+31l2gcSV9o3mjfCZso6Tj8Hlu/r67ks8yJreB4DEmIWt7/rr2ai0E5PC6pP5Ixcqc/TqN5avLnMq1d+kuf+rP6gHy2nUfJQ8P+jQa6UrTIJQv7jI9kITloXSsT4H9DbHBhU4Abi4mcZHZog/6wpDNKxNyb6JxmntidQenmacrFjM1VE8maA/TdXrOFAAtxvVZi4K6pug8/m2PnKbNaFtRM7Ez2V5aQjkQZnAX4Wodbz67XJNGVxtjHFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGRQ/CgH+TPOh6otXArR2/cfpQUKgDmJ4xg/IeBPOe4=;
 b=a+EWDgS3ezK+5YBSA6hIxFmxQRoS3PPakKEx3QI+pu1THwMGoDo/ZhTwvf8nSzbyrNvoPU8Taspur19T/IEEzjQn6wSJGLGiQDoRJclVeMAGfp0gv35dXNSRyV344oYEs6cSE/aBpJgBB9usZXk1a7Uj4gkMiYGZKxNkhd7Cl1mq/tzb/rQrJIQ5P+6DMuiz10hqxu+PtFujAq4kXZmd8+WTzig9to9Ldh5GCFMaKRBvgFFDB+nAZqfcl8kKsa8xYmOjM5pTwoYgsPu/ujVgWrq0Mz//X3afAAqP+tWrS1wALbeTIZEA587OfELr3DuCkn3aM+3+obSab3Jq4COUZQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:20:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:20:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Thread-Topic: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Thread-Index: AQHbL6sZi70sSe9ZGEeVa1ibZQBIJrKpt9gA
Date: Wed, 6 Nov 2024 05:20:29 +0000
Message-ID: <eee6a738-cef7-4bc2-8d69-8ece5c829711@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-7-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-7-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 6de2714f-7552-44fc-15ee-08dcfe22ba81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NEpPSHBKeUsweEtERTBOakt2cjRIdmN3cStXU0lYQ2tjTnNJbmVoeGFEbHc4?=
 =?utf-8?B?cERZS1l6cUs0Y2pabU9SRzdkVDJ4MWlSZTAwa2x1cTJQaVYyOGljUW41UlhJ?=
 =?utf-8?B?NmFoOW54VDJHMEx3SG9iV0ZHRDZmY0dJZ0p5azBrbGJVTS9iT0U0b3ZRSTRL?=
 =?utf-8?B?ckZsUUxES3hYSStyZmRSUDVwaS9HWGRpQUxRMTdkVWFmb096c1F0S1NLYUwr?=
 =?utf-8?B?K2xqVUpuUTVEYWpYREJyUnN2bUdwYVRVVmJXUVlFa2l4Tk1vOVQ1Sllpcys4?=
 =?utf-8?B?SVZPemQ3NUtmREFLaktHT1RjWWs1dWpldVpjRmlwdjF3ZnlRM0RtOGYxOEVl?=
 =?utf-8?B?WkZZQTVmVktyMTZLeXZqOGtTWnVLWmpMMmtwQnhXaDVRUGhWR0xybGVLVmJh?=
 =?utf-8?B?elQwL1VuZ25aZlpVQmY2OG1EekFKZGF5dGJOSTUzc2F0cTA5TE95azVzS3Iv?=
 =?utf-8?B?cThjeTF4NVBBMEVhOW51cFpwQ2tVbkM4VGtRejBlalN2ajQzSW84Vk5SeWEr?=
 =?utf-8?B?VEYrdEJ4dXRvU1J1cFM4MlhNTThsWUdGVExJT2hER3RzSUJZNHZ2Z3dIUStz?=
 =?utf-8?B?cm1pT2JwRVlaWFBJMkZjNHBUU2REcHdNSHdUUjczbjh6VTFLU0dqUlpvdzda?=
 =?utf-8?B?eDlmNkY3dWZ6SDI5WTBmdDFrTHR0YmVEV2NUWVB0SzFuYldTaFdqODRYQkxE?=
 =?utf-8?B?ZzVQS2plOElPK2pWT2RFaHNCc0ZjUk5OQVpCbmJNS09kQlo1ZlVjQVVZN1ZP?=
 =?utf-8?B?V0QxRWVmdnh0NDM1c2RSeGlWTEtrU2MrNytNZ2IycWh6cmRpTGh1MUM3MHBU?=
 =?utf-8?B?V1ZueDFFbzcwZkRBdk5ubEtxSEFrZmJqYTNlQ2t6NzArRGo0dEVrS3pZdUtI?=
 =?utf-8?B?Z2xrTHV4Ymd6eU1URjNjeWZJZG1Ja1dBd2Jrb1cyUGJXQW9HK3VyNFNaN0ov?=
 =?utf-8?B?dWtCTlk3TXFpMzN5NWNvMTBweWdHTXZ5LzdocDJabEJVUDdFQzJxQVBVem96?=
 =?utf-8?B?NUFodjNKRHdwVUdVek45QUFvQlhBeDJwZWpCZHBhQ0xaeEtsaWN5QnpqUk5T?=
 =?utf-8?B?SmxqcHMxU2ttemtETlJiSDU0UFFQeVFHV2taQTI4OUZNTVNtLzJNMms3UmMv?=
 =?utf-8?B?OWlWMGx1aVVLZFNMazlHaC84RzRrbkZKYmFEK2FGb3I2YkdVV2lCZFpwQ1Y3?=
 =?utf-8?B?Vm5abDJuZy82VEU4RGc3dVI0cGlhb292T3RWQVVoRVN3eVUwMWZQbmNVSXV1?=
 =?utf-8?B?OHpvOXFTTnZjcm9mbVZBL0YyYWNDb1lhUnRNaHBaSzF4N2FtcHhGcGdodjhB?=
 =?utf-8?B?ZWxrRkI4YUdQcktHZ2NkbG5UbHQ3ZGxmSUxuRkNNeHpTUldHU24yZks5a1hh?=
 =?utf-8?B?QXNLZkRQK2J1K0RMRUx6dVVGdTJ2SllrVGJVbWlibmpUVFBNc1Y5UkVSYndQ?=
 =?utf-8?B?Y0xqZldBR2g0cjhsT200THJBcnBCZVh2QWRheXZJdG1RZGlDbjJ0bHFHWW9L?=
 =?utf-8?B?UVo0YTBhQTVXM1gvREY0Q3ZORXg1T01iZG9yOGQwRkhJdlNhVGRodEpFenY4?=
 =?utf-8?B?dHhHYnVmblpIN2lmUVVoSjZzZXNxTFF5bGNUL0NOV2x6ZXlhaWhieVpaMGVl?=
 =?utf-8?B?T0RaWFcyWCtHU0VMZWJFMU1Vdzl0WEo5YmpGUkFGZ0M0dFJqc25VRjdhcmth?=
 =?utf-8?B?d2pFVGVhc3c1RzlITTRmWnRSaHVUWnpvWHUzS01pZFlMdzM3SXk1VWtWY0hq?=
 =?utf-8?B?SUFHWFliN0pyMWsrVnZyVS9zOS9zR2xGUFA4RGxxUTc1TTE1VkdheGNSMURL?=
 =?utf-8?Q?pXF6zMXQGhU5D+dBp5fqeAdqeh3JxVobxECYI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjlCWTd1bTF1Yi84R3lnMzh2Q2dna2I5SlBBY25SeGNWNjU2Q3Y5Mml0b3la?=
 =?utf-8?B?dU12TFZuNjByQ3I3ZVNudmFVTDJpYkkxbWlXV2tCb2RtVWMxMVRKQjhnVzhZ?=
 =?utf-8?B?U0h6bWhkVUQrVklTOUxXdzJRTlhJNytWVit6RGpkb0tXNnJTYzZZcGNSWWNs?=
 =?utf-8?B?cmxtL1N4dmhvU2plS2hxSm5uZmZoWTFPdlgxUHd2K1NCWmtxemgrMWZUaHNO?=
 =?utf-8?B?enUwaVNIUTMxcFhWQytxaU11Q3NTaHJmMUtnQ3M3VkZSS1VtODJFUjU2THFX?=
 =?utf-8?B?WmJ2VWVEZmdRS0krN1BIRk5LYjlrVVowYkpnN1dHYUhQRnBmUGczQXFOZkty?=
 =?utf-8?B?U2lKZCtIcmJuSThpMlRzZ2dvR2RqakFOQU5rU2k5L1lRS2FHYmFyUzUwS1JL?=
 =?utf-8?B?WUNadWtOa0ZoYm5PMjJxcVN4U1NDc2tBMWlsNnZLYmxmckZGSHFJS1pXQjVr?=
 =?utf-8?B?OXNBM3JJMERKbi9HL1VQNTlGVmovWEU2bnRNMmtuVEJ1eXJERk9uWm5iRXJw?=
 =?utf-8?B?cjJYUGdSWGQzbzhvNldwL05ScW5oUUJWYXREeEs3U3NEU1Z1ZzdmY3RBRlA3?=
 =?utf-8?B?eUt3NnhkN1pvSElvdTJ2OVlYQVAxbTBkcXhnTDkrNTJCRGpsNmdlUDdadFNB?=
 =?utf-8?B?bmZHNW1QNU1uUDlNcXV6Vkw4MnJUWkNiakloaVhuYmp2cmlYQnovbEJ2MnZO?=
 =?utf-8?B?VjlGSG9WaXFFU1ZkdGNzMnhmMDlIaC9GVkcyWDE0SVFya1BKYkZpK3RqVDUx?=
 =?utf-8?B?dDZab1cxNUZSMTJnSGFkckltYVFDdFc5UDU5M3FtZEJUV3BnSFNQc0xhODhV?=
 =?utf-8?B?WVhQR0NEVGRmakR1K2JuWmJNQ2ZsaFpoUmZIdWlBdEY5cTREN0FxSHcvZjhk?=
 =?utf-8?B?TG5TV1R5Q1hhdEd0UEZOL1F1R29uOFJEMUp2QThsd3FUSWNXdm5wZkZIMWZ3?=
 =?utf-8?B?U2Q5dE1zK05KVHJvOU5ldWpTaVRnRll3cnVmZXRZYWk0bmY2YVgxdlRQTjUw?=
 =?utf-8?B?S0xhYXpxZE9YSXBWNThJZmRMQVNwTW44aXMxb1puZVU4M0NsUERkNlpkMTha?=
 =?utf-8?B?NTlZb3Z6cnBLblpqWlJ4L1NzVVl5bTl3Y0ZIYTd5NGwwUDY2ZjV5bWZ0WGVJ?=
 =?utf-8?B?alVaVVB1RStqYzMremVQRmpzaU9FR0Fnd3ZjMHNGd0NZTXo3QU9hSkFsWGdq?=
 =?utf-8?B?cllGaGdFaS9PT2NqckI0c2d4elNEb3RzSG0zY2ZaTGdxWks3ang3OUxNWmVa?=
 =?utf-8?B?ZSs1ME5ETzF3eUI1d2pUa1Fxc1gxbkZXZ3U4UkRlZGFxK21wcWFuVmxwYnpG?=
 =?utf-8?B?YlRqWStvTUhJVzh5T2orWU1Bc1dBRGJOWk95Y0tjM2p6V05uN2dPRkk1cmJB?=
 =?utf-8?B?Wnd0WnFVanYrejZldEpLQnVaNEFxcjJub1FKZnF4Zkp1dGZwTTVHNVhBTFV6?=
 =?utf-8?B?cGZSRllJWVNDR20wNEkza0g4RjlUTzZrVUl4Q2VQSU5HU3FFTGtwSmhHVUFK?=
 =?utf-8?B?eUpRU1ZqaUNVSU9DUXBXMmRIUkxrVFNoemloQk9nZnAxV2FHQ1hkek5yZDNo?=
 =?utf-8?B?eUZDWVRHUG13ODdBWjNBSWNnR05jV0hHOEVOZ3NQT29pRmQzNzdJUEdCR0Yr?=
 =?utf-8?B?czA4NVY2dkxlemtPaEFUa2tGWWIrdUQ2K29sMitvMytmNGdLZFZOYndmR00z?=
 =?utf-8?B?WVlBcVZTOUhDL1VhaDVYSWVKWkx3NUFJNGQ1ZkNDb3N4N3U2OUxQVHREUzZE?=
 =?utf-8?B?YktVcmRPOWlwMlR5YkMyYnNLc2xmcnhRTC9TTGdxRkZJNVpRVWM0TzBHZ053?=
 =?utf-8?B?VXRNMzFzemdKaEY4dGRRcjE1QXZ4R3RiZHBJNTc0K2lBVjZyWEFQbHlMbVQr?=
 =?utf-8?B?YjMvVld5S1hXWmN1cEpCN29tT3hqTFZCNnIrdGYyVlNRbyt5d29tVEJFbmky?=
 =?utf-8?B?RkhDeG1xS3VlTmhOVU1rZmh3c3RhejhUOHY2MWtMZW0zZjMvcUJicDRuK1J1?=
 =?utf-8?B?SHJWU1BZbCtZbEhOemo0c292bFN5ZjJGV2MxQ2tlL0t2M1B3clVzd00yUXF3?=
 =?utf-8?B?eURVTFg0Q3pRVEcxMStBdE9FZWt3Y092a0dNNTFtOHBYUFRQYVFoOCs1a0cr?=
 =?utf-8?B?Q2NOWm4xMEduQXl2SDg5RHd4U3NsTXovZEd3Tmxwb1FwSjIwZisrdW4va1ZE?=
 =?utf-8?Q?pRetMGJfDbS2iI69sjpJT8L4EhfvEDMPPJEgHS/hABv1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0268BF0689D544D85AFBA262A92D599@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de2714f-7552-44fc-15ee-08dcfe22ba81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:20:29.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG5rxJbk6zVpDOXKi7GkSARmbZRPF1/LtJR8ybmA/1ew+c9S1cYoipjbps1c0BjGX9HI34EU26vGfucOcg3NSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_212033_798019_A3B2216D 
X-CRM114-Status: UNSURE (   7.63  )
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
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhlIHRhcmdldCBkcml2ZXIgaW1wbGVtZW50cyBh
bGwgdGhlIG1hbmRhdG9yeSBsb2dzLCBpZGVudGlmaWNhdGlvbnMsDQo+IGZlYXR1cmVzLCBhbmQg
cHJvcGVydGllcyB1cCB0byBudm1lIHNlcGNpZmljYXRpb24gMi4xLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

