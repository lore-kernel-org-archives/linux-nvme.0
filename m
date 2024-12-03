Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD83E6C5E5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 02:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIxi9+vasfViTmM4lKQdetPdRObtgeKd+vxsk/3M73U=; b=bGChQTw+zvWYLS1a8enXL8gFF/
	aKt42yd57+ujr6c12cakwzqTwXUxDEuHlDBVRI388/uOKR972No1geo0zQWo+8XNulE9ASChkYZtJ
	YOu4ty76T0fDgE4ntIRFtcQ+hsycffGjj+SIggGQwcOla5jwlA3/e1qYnshOPFdgEl6rMQ52RyrnR
	P6znJZPOTf2BIrmLWJYZBI5bu2JKhZGnh+RXX2dKP8RUmwht26EPIfF75zcbgGHOKJDZa7V9wcxFW
	3pp4e500YEBjqkEShvACiPQ1BlXX4GweI9vEXg4uQfPXBL4Sng5oepX0ZmkG2rOXYVHHFcEHOyXXO
	ZPBjtyag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIIE0-00000007yBP-38NF;
	Tue, 03 Dec 2024 02:01:16 +0000
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com ([2a01:111:f403:2413::62f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIIDx-00000007y9H-3UWL
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 02:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOqSDNhfGRuP1b6HeA3zMq/f/iLFC5/zomQ4+OJF5mrZP08Ao6CMCHXgKI2UcEuH11CHpzXrHa0Yg9++b7UUeWjIxzWqo3z5+AMkr4HCMQ4yu/JhEG7g58pjL/xh+t9BV29Zx9o9eG1PBq7Ku5ZnBTj8QJozwshnGJD9KOubZmpmc0l574fxssKrUXuG7R30fAryAul7766rPuKjEyYJqOVx3nhM/J+PQCG67i6s8/xbHGJbKOd5im9o908zyZQpq0UcAjb4GBGHkESqtgGhf/L6bQ0WHQYeVOGG2Wz+ZaQN6BABvfTEClYQNLMtHJMvMSVykzWN/TWL11RMvnjF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIxi9+vasfViTmM4lKQdetPdRObtgeKd+vxsk/3M73U=;
 b=gtJ7IeoLewT0OHOeLmSTRCNobsgCgfeJKdZE6vwBS7fdqw3CQKFFiP7Dvt+K7Ykt99re1Xv77dElGHIeEcZwbeR79aI6YKhnju9QBM72dHt3g93Mst2cR2IB6tJkPnTIVfadPkuwdnnK31PGjbV8Vk6mOiWOE4jkVBERgotHJ/h27gbX/0Oszn+LSBSNO5A1d41loK3oryyh80EOJ0Xefq46+QzFWzvFyOHs/OBY0pB6Cy5KgvBy6FWQygQclZjGCGodSAhoc5rzsNE9vb04g0aXVKFozxZG2JndbovsC3SwQlV1tLCWgPqiXS9PXmpklJIpg/BBpNLEuWSsUUABuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIxi9+vasfViTmM4lKQdetPdRObtgeKd+vxsk/3M73U=;
 b=eGCzg2aDAzNi+G3qXgoJeQNTFdh17//Tbz3mgH+TCzmrc4wp7AyGuejre0XNya35v9eOXQq5q5AGQoyGvXSCUw22iTv8vb75KSaECJRchgAoUQL+b2po0BWnQglqbkc6rTakfcjCznyUFd8HDn+1FIyoYadhG9nhV1eoICTEyvvnip/BHrZ7BZH3kElwnm0MmCP1txwBudEZiEPlIjFb+hJCddNUlq9UD+jNr49eKHuZ0LyWvkbJyRRgtqct+lNdCvYIMTo7kbeiKWXh1LkBSX9XBHOGstv6KQ/I2GKCako4sPqKy02AbEmzUubVZ3OPgoUsG/t0oM4ruREnVhA+Xg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 02:00:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 02:00:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"visitorckw@gmail.com" <visitorckw@gmail.com>, "jserv@ccns.ncku.edu.tw"
	<jserv@ccns.ncku.edu.tw>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Thread-Topic: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Thread-Index: AQHbQ0m9XUJQPedxa0ega/MJvuFTkLLTx8qA
Date: Tue, 3 Dec 2024 02:00:54 +0000
Message-ID: <7ea0727c-468d-4e5d-8536-30a31b15f3d7@nvidia.com>
References: <20241130170258.103954-1-eleanor15x@gmail.com>
In-Reply-To: <20241130170258.103954-1-eleanor15x@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5722:EE_
x-ms-office365-filtering-correlation-id: 10f3bf9c-9aa5-4a5e-7eab-08dd133e5266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2d5V21aUVpvT2V0UFpXQ3lDMmk1M1NrMWFFUHIwNjJpd0FjSStjSE5QbGY5?=
 =?utf-8?B?MkFXeFZMQlhFb0V5THY1Qnc1amk0Y25QNmlDQ2drOFkwYWxRVEVkd1djVVpC?=
 =?utf-8?B?cU1VdU5PK0VZOVhnNEFPY05sMmx5SVR4VjdaeC82clpuRGZselBQY1pIUnMy?=
 =?utf-8?B?TUxpMXJCMU1JTGVXUU1VcWQrbjY1VitCbVVmeC91SWlSZ1JXM2I1SjlwS1lr?=
 =?utf-8?B?QXhGWnZaUkRTNlV1Z0RKZHhWZlBzajBUZFIzdmZsWHRoNGJYWXVwQ1llYTFI?=
 =?utf-8?B?Y3kyeFpTNkxsQjJjUjFHRjdKVjMvaFVBRFFMUVNza3NpTXYxcWZYZ3N3TGN3?=
 =?utf-8?B?YTVON1hZLzlwUlVLS2paVHgvYXJDYWEyQ3plTjUwT0J1NkNDTGpsWERMc1lv?=
 =?utf-8?B?NUprTndBRzcxemdKdTNxWDFJdm0vT2VxajNSa1NLT012QnN2N3JDWGVNMFQw?=
 =?utf-8?B?aHRSNk1MQkxkaitrOGFNQUZlb0daOHl0WThWeHBLaFV5MmcrU3BkdW9iZWtG?=
 =?utf-8?B?RVN6OFBpQ2hXdDdDOE5tSHRTMzBhMlZjaGlaeU96OHNCL2RjZlF2dHVRVUtq?=
 =?utf-8?B?ZlVBYjFib2puWmd4aFBFUi9ZOWtyTFpiUlpCbitobDlQcGdZNEN5Z3p3eE5O?=
 =?utf-8?B?NnIzaExxNklkSU52Y2RrZCsvNlJrY3QySVBJTVdPQU1SYTN3SUJiT05mTW5K?=
 =?utf-8?B?eEhuL1h2aU85ckdxWU5GSmxDbEcvRmVjRGFzUnFLdzh6bytxTzV2WlNsV1B1?=
 =?utf-8?B?MlZHMHFnUjB5MENlb0l5emdwZlNGOEw0QklVWHljZHJFVnk3V1Q5aS9BaVNY?=
 =?utf-8?B?M2VkT1dDV0ZIbUJxTzdreWJLM0ozUXgweWR4SnlaQTNtN0NpbHRBbGVxVXBn?=
 =?utf-8?B?dVVHRGhSTHg1eXc5clNSU0VhWlBrVWVneTZxSGt2L2liOHNRMUNqZTdkS21W?=
 =?utf-8?B?WW5hbUM2eEtSblJVM2VoNFA1MXloUFZKK3pZUGt4TmUzd2hhWkxTN3hwM1ov?=
 =?utf-8?B?aU85VmtMcGplVnlYTkRCNVlpb0FVajR6ZHNSZStpQ3JjaHdmamRDdmVUcGpu?=
 =?utf-8?B?ZnNyQS9NZzRSZTNjOWZUMlc0YWpaN2FzdnEyNUszcnMvYjhDVWtBQnJMTVIy?=
 =?utf-8?B?NVVESUQ4a2U1cDJiRWk2OFIxWGxvVlF0UzNxZ3p0Vmc1UEpmR081TVloS2s5?=
 =?utf-8?B?V0J2MXEvZWlENVZPeG9maXZpeE5vcWliS3BYUEV1cGtEQ1pvVDVxcmRSc0p3?=
 =?utf-8?B?Vy9RYzlLK1NTVk8yVWlLMWFNdGRONHVHUWxrcWdoRlRtRjRHa3ZJK1JEUCt6?=
 =?utf-8?B?WEM3R0plcGxiZ2lJU0FRVDdLbjI5bGo1ZmIzQzZ2L2czL0hWRmZFRXpSQ0Z3?=
 =?utf-8?B?THJnZFp3U2c1ZlFCOG9lUDBCM1lvRU9vcTBleThoY1dTbFBNdS8yeENidlZP?=
 =?utf-8?B?N1Jlcko3d05Jc25PeEwzUDY4NXR6d3dWbmx3dndrYXlrK1drRUdwOW1YWXZC?=
 =?utf-8?B?OFVsUTAwTDVqSFhxWDRQY3RCOVNZU2Y0OE1IbWtLeC9aVWhxVXdLQUNhNW0z?=
 =?utf-8?B?bm1DTE04UStwL3dLek5IREkrN0F3bDlRZVN6UTJHUi9TcHVEY0dMWW8xd1I1?=
 =?utf-8?B?dTNJY05laGc2cEFwdHRlQ1oxQWNNVUVZdE0wbkg3VFRkTitWd2psRU1ndjZq?=
 =?utf-8?B?aGo2WHlsbnZHT09sNFVtLzRoaTVSdlEvZVBDOWdkeGs4L3JzRUdVWlJQdzIy?=
 =?utf-8?B?RGs1THVENXp6QlZXRUNUS1NIM2F5VmZVQlF3MTVkTUczTy93MXo5ejFNZ1Mv?=
 =?utf-8?B?dmhKUDZYd0pyOFhNdGR5WGZlRERNL0ZHa1RkaEd6Z2tScEswRDk4d3FZZHNF?=
 =?utf-8?B?SU5UeGc0cUJoN0I2anVZdC90RzIxZFpnbVpvUklLQWNhMXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkkwZ2RMcW5qR005U3lPMVpJQmJWZGR1RGFJK1htYkxSS3RWUVd0eTY0OFJv?=
 =?utf-8?B?WVg0VFFlVW9kdzJYbm0ydHo5YnZuVVhQMFlJb3BUTlpOYkR3R1YreEFQeGU1?=
 =?utf-8?B?RFY4MlViK3E4Z05lekxmZ1FkTGVSaHFBMGZhS21pTTZQSlM5MmJVVW1RRFNa?=
 =?utf-8?B?YnJOQXZ5VDBDYW5wbFpMOGVFd1dGeFp2bURFOXJaN1NadVlxVkh3VkJxZ3la?=
 =?utf-8?B?d0RQblpVYXdWbG10N3RkQmE4c2h0YmNRZWF5RzRYcmNlajNtM29MQ0hNUjNK?=
 =?utf-8?B?NUVaa1hnNWtueHErVjl5WlorczRtUzZObUdHY1luNmZ0d1NYN1htUnBuamNs?=
 =?utf-8?B?VUVFSVI5S3VISkVwMTN3S1lBNTBkWmxMY2tobWtlbzBqd1NpL3k2Y1NzVDN2?=
 =?utf-8?B?cVZtdU1DRGh1SFZJT1dOMGdPelZhM3E0MHBnT3B0ZlpwajN0eUlYS1B5RElB?=
 =?utf-8?B?dVdJaUw1NHBwMkh2bzBaSHNRV3lpSm5ac3FFUHpwVmVhWVhEaFRKQzJxeTF5?=
 =?utf-8?B?ZTRSK0JqblpJTTVBVnlxajJ3b0hMemY4N3MvOXBnd2RkbFJrYlZ3bjJaMmZ4?=
 =?utf-8?B?Sklhc0hKNm90bi9hR0NqRXRkblpxNmpQYndoOFRlV3VZTERjeGEyWTRFbWc4?=
 =?utf-8?B?aDVCVXN1NUZleTljWnphNUNqNzUzV2pHZUJ6d0ptWFB2bnV4K0dERktKalBB?=
 =?utf-8?B?OU1uSVk5NUhQaTRoNG1QZ2xaNUM2SGpMbW1tTHFZQ2NZSDc0WkpGbE42aW84?=
 =?utf-8?B?MkZ5MVdLWWFpZnR0L0gvUXpudnFQWjJ5bGliekQxa1VPSnFIMUtBV1lqUnJW?=
 =?utf-8?B?K09ZUlN4T2UyR1FhdGhQSWp0RDdrQzJNS0l6WnN6cXZGTldEMmw0NURaZ2hD?=
 =?utf-8?B?VUgwR1AxL2l6aEh6NElPYyttaFU1UEFPUGV4aWFqaEw2ZFVZeGQwWktmdVBO?=
 =?utf-8?B?ZmhSY0VFSDRlb0l6cGhtZm1icitlQXBuRE1WZnJUbU40OTVBOS9XT0JQR2ho?=
 =?utf-8?B?WTkrQytUdE1wUnVMM3BWNDhVejJCdCtUVzJ2Mzh6YjN3dy9vcFVienJ2YUUz?=
 =?utf-8?B?U3gwRktScVlVM1FuTlFLRk9XN2g0ZXFaWXdWbWkrOE5hbUN4a241RnF3dDdi?=
 =?utf-8?B?RTMrZFRSWXlBeEF2U1l0V2lBT2lxY05kelEzRWpiNkFrRW1qVnVzaE5qVnhq?=
 =?utf-8?B?MDVJcURmUWp0QU04SGtSTGVCU2J2S0pOTXNGSnJ0SkkyVkxDT0x4ZUVKVDNU?=
 =?utf-8?B?NVpHeVpwelAzTUJseW5qWnRFWHRaVVBGQVVWWlpONzVpa3ZTV3VSa0xvME9k?=
 =?utf-8?B?a2hKTEM1aERyeFJldDZJZU5jRncxdklTbndoRWpkRG9tdWFaKzI1OGdVZC9o?=
 =?utf-8?B?MGdTVTVzbE5CVFNYUWFyTWwreUJ3RCs3azVPeGwzditvbHZrQ0VyUnB2Njgz?=
 =?utf-8?B?N0NyZnFaWnNkUUh0TUxiZ1QxOGJleng5U01icUl6Sms0T3pWNDZJbXZDQXV6?=
 =?utf-8?B?VlhUaXNkY014d0ErZHA2VWxaT3Z3ZUtqczkveTNDdWlRclM5cU5EbFBMVGRG?=
 =?utf-8?B?YlR4ZEtmcHQvSDlhaVVacWJ6RExoa3pMN0RRaHF4aStBV2o2WndaRWlGRXZB?=
 =?utf-8?B?c1pFMmlSK0xEMVdPZXQ4UVZLcGRDTmM5bFQrTzZodHhUd0pOcFFwbEMrUk9k?=
 =?utf-8?B?Q2dwYzdyeGtrc1VkWXppWU1Jdy9nZUdBWlNUNmVwNjBMbWhHa2l1Q3lyMkhF?=
 =?utf-8?B?K20xemg4bkR4aDlMZ2RlNERUcG54YjFTR1VZeFdqMmlTeWVIWXBBNFBuUE43?=
 =?utf-8?B?VXJRVk96NStSRW8rNEJiYXNQaG5YbXdGTXkvUjZWUnFURmpzdnZNVUlndGdh?=
 =?utf-8?B?YlFRQm4vZDVMWlJNZTd1UzJYZXl1R3FnRStVaFFYZnZjZWJxNm1ydG9yTnJx?=
 =?utf-8?B?VUlFbEJsaExSdWtCYkpJWG1TTWFabDJUc3dXZ0RsenVKOXRTVSt0MzFRM3Ar?=
 =?utf-8?B?RjNxS2U1TFBKK20wVE1YcXNWWXVacGhEcDZkei9lTWNtOSttMGNqS2NndXdT?=
 =?utf-8?B?L0Ntd3FQMzduOUg2YlhjNnlmeUc5WUFzb0dhTzF1SjluZ1ZxN2VuTTZhYjA3?=
 =?utf-8?B?eWY4d3Fyck9jeUN5cmh5ck5Td21BWUZ4WUJBb0xCNHlJTGdxejNBbVVpMENy?=
 =?utf-8?Q?KXbRGxQo7/GZ83V5nfD7rX1AzSpiPzebU8xLSqVN0Zd4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B37A382738EF19409EEA9A708527E8B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f3bf9c-9aa5-4a5e-7eab-08dd133e5266
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 02:00:54.7393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiqFKFQmd3XCLFQXV8NrLcWjySF8hz/KgOfVH10wBnFwmi25TWPrskVbkiFi4TP28m8qpPca5D3rYYfCuQ5itg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_180113_864689_C8BA648C 
X-CRM114-Status: UNSURE (   9.63  )
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

T24gMTEvMzAvMjQgMDk6MDIsIFl1LUNodW4gTGluIHdyb3RlOg0KPiBjb2NjaSB3YXJuaW5nczog
KG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KQ0KPj4+IGRyaXZlcnMvbnZtZS90YXJnZXQvcHIuYzo4
MzE6OC0xNTogV0FSTklORzoga3phbGxvYyBzaG91bGQgYmUgdXNlZCBmb3IgZGF0YSwgaW5zdGVh
ZCBvZiBrbWFsbG9jL21lbXNldA0KPiBUaGUgcGF0dGVybiBvZiB1c2luZyAna21hbGxvYycgZm9s
bG93ZWQgYnkgJ21lbXNldCcgaXMgcmVwbGFjZWQgd2l0aA0KPiAna3phbGxvYycsIHdoaWNoIGlz
IGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50IHRvICdrbWFsbG9jJyArICdtZW1zZXQnLA0KPiBidXQg
bW9yZSBlZmZpY2llbnQuICdremFsbG9jJyBhdXRvbWF0aWNhbGx5IHplcm9lcyB0aGUgYWxsb2Nh
dGVkDQo+IG1lbW9yeSwgbWFraW5nIGl0IGEgZmFzdGVyIGFuZCBtb3JlIHN0cmVhbWxpbmVkIHNv
bHV0aW9uLg0KPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Q8bGtwQGludGVsLmNv
bT4NCj4gQ2xvc2VzOmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNDEx
MzAxNDM0LkxFY2tiY1d4LWxrcEBpbnRlbC5jb20vDQo+IFJldmlld2VkLWJ5OiBLdWFuLVdlaSBD
aGl1PHZpc2l0b3Jja3dAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdS1DaHVuIExpbjxl
bGVhbm9yMTV4QGdtYWlsLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

