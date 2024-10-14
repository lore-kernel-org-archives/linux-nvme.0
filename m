Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5492CF259D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/FnByiCyu+4sq1b7ekh34ijjlByEdO2+XArz6y6zK0=; b=onVPr/uGJzthvm3fAIxIa/Trse
	H2sJOfIM6PEtUwTo0VSiLRLuRRIkz625yi1CDaOUIj7KMa1vrUQmWHHBpP8VO/1h/2AbLvXTKG8/a
	8U9/sRnVDBRJhu9upXJr/iGnLJeS1ecGXmP0UQIn6u8UK2SGKZOvJQKDbJcOa5LWI9d/FQmVdTQYN
	0xELkE/VXK26875aZnPRRrVbL5nWEDFPRWuNID8DQ+ap0m0sPAfGDGHorDOtE571tnAXQa5BEkgSf
	J3rvinpdx9OTLtQZfMxk17h8ORIWLn2CRrlt0tOhuQC2NVJOYXI9To1LJCXucWEIZufdplKH/cfEK
	t+jeVRNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EVe-00000003shJ-1t5g;
	Mon, 14 Oct 2024 06:24:50 +0000
Received: from mail-mw2nam10on20620.outbound.protection.outlook.com ([2a01:111:f403:2412::620] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ESQ-00000003sDK-0lg5
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiGZwm8z7GfmXi0BfrwrG4ePelqLpFEYOtUFTFU2z30JJXmMj9J+dE60BchQ977ExQBjB2pu7MMH8h5cRkd5xpFCHDy1lbYOd8l2HBjVRC/yaiZ/PJE0ce5Zi0wcQVwxMlneiKYjW2MlVcM5JsB89OV+et5d3TPFxMMc0tlYLriyHkGAoM089x9LIxqmhfkcOkUmlA8LS2OsvN7nlpR9l/zb0G4+UY34mwgeAWtbzYTGkuHWyIY/gT++fqI4zsemhgwTULlVFj/jRRWlGQ5FwlJpObGfaaawYJR3rr/N0x23FlQKSpYc4AlajvfqjAnGRXREGEd+gStlWzwBND/G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/FnByiCyu+4sq1b7ekh34ijjlByEdO2+XArz6y6zK0=;
 b=vow4wr23AVmJXrqfev6+geVG5qwbkFRbIHYkwZQxW7NlT5iMhe/tKLVEEmD7v8JKwvhMmML8JhGoJTvMF97/RDihJp/iJR13WKCKc2i7yh+FD5jcJLXcizr1toak+dhAkianlQZGwYJMGERwYoGJ9K95D7VRSPVCkjkTWzEVCREQFt1gaovYHDMvYEfbWnxP+DljNeEOuUAiyR3uTOZaIli+dhVJBRCDEjlT4WgftSrdAhTzWu0J3IKGGumvXUBgf9qauZ6S6G+9a557VI4ref5FWilO+PCBQFjE3fsPd3ZMMmyZNIgo1T3Ifi3ny8A3MJ4yplu+F81gS2O1OIeMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/FnByiCyu+4sq1b7ekh34ijjlByEdO2+XArz6y6zK0=;
 b=qmRfNoSWD0QTf2GpRYvyEFFRhLfIMdvH2Mj3aVe9I7W+gSZPQrrKElR2XHDYdI4wws4P30hzqS6uYhjMN5G5/KwnKlMarvFqPpFUUIjW+nI8L/2kT7eeiEpi6NikYvJc8+0zi6dRTCJ0T0U/pe+xDcS+SyHtQUadT6BNsMtdb28LRkxmEUKa3sfCu2XwY5yVUKXUlptUUB9ug0AXigipCSGtUzfyB6GF5tRaXGe546SOvFbwPA83gTsO3hakkp2qgd8ISo8jI+TzJNliW66O43yc/jmOPPihKSdNm2i3ckZQOSjLz2Le0eMYvpD1BcKcS+7Y48BDPyPVQdMZkLXn2g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 06:21:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:21:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v15 0/2] Implement the NVMe reservation feature
Thread-Topic: [PATCH v15 0/2] Implement the NVMe reservation feature
Thread-Index: AQHbHf/WP5VUHG6gwUGOFPydcwr0K7KFxpeA
Date: Mon, 14 Oct 2024 06:21:25 +0000
Message-ID: <a5956794-6069-4fae-a48f-1ae17aaf05ad@nvidia.com>
References: <20241014061045.62436-1-kanie@linux.alibaba.com>
In-Reply-To: <20241014061045.62436-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 609ed9f6-3bbe-4d9f-33b4-08dcec186e67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dzRrQTRORy96RFQwMlllSWpNRDdpeGoxMGdxeW1pbmpVdWhtK0JJOFkzQ202?=
 =?utf-8?B?Rlh6eHVjcy9xWWNwb0V5ZE93RHI0T2Y3TU0yQ0xHY3BOM3NkblNmWFFSNFZL?=
 =?utf-8?B?bjZGYTZCb3ZEK0J4V2hoeEdMRUpsUlRGWVdUUjRJQXIrcFg4cDJJVFlRTjFx?=
 =?utf-8?B?VmxidEhBZlNmTFVrbG10Wlg0SHM4azJaMU9IaW1IWlN5ZDU1amxxNFg1ZlBx?=
 =?utf-8?B?cGpoUU1nYTAwU3VpcTBrTDIyZ0t3Znk4MUNpQU45Z0FsbzBGK2NwR3Q3eXpZ?=
 =?utf-8?B?Szh6RVlLRVpybFMyRTIzRENIY1dwNm85T0k3TDVsUE16bkIxTGJrcE1IeWUy?=
 =?utf-8?B?SFMzTU5qcXRMOGZIM3hrK0lZUVp1K1E4N0RDU2hFdW9kV3VRYUdzT2U3Wk14?=
 =?utf-8?B?L3lyNWtwaWtBYjJib1VwT2FUK0JMekdpcjljbFZTYXZzc2Z2NENYUmxLV3Yx?=
 =?utf-8?B?SzkzTHBPNGwzdHFyekxhL0V6N2wzby83eFZZSnNBSW0rQTU4Ryt0WVM3dGI1?=
 =?utf-8?B?bmpxeGpCckRUdjlEMkxGU3doWit6UmZORm93eFhUVXFzUzFTUktsVzRMd3Vm?=
 =?utf-8?B?cnpCZzAzWGJzalR3SVJ4ajh4K3I1T1pDTFlycXhQRlVYUDZ5Qkk0UG9ROWtC?=
 =?utf-8?B?NjBDQ2Z4bUMyaldZbjl6dkZOcTZjY0s3RS9Dekw4WUZUckdDc2pJSU0rZmV2?=
 =?utf-8?B?dXF6c1hWQW05MVBjMkFuenVneTAyYXZCcGpuYkkzQjFsKzhQdy9vSmZ4TXNu?=
 =?utf-8?B?TmNYWGZhaDJURzRUcXB5Uk9mcHQ0QmZZcXdqelRLN0I3a01DODFiVmVLQkln?=
 =?utf-8?B?NW9YOVRIYWZaV3FGWGdiN0VmNHhBY0NoSnFVSjNMeWtCeHdjL0hwMXRBcDM3?=
 =?utf-8?B?Uk5SUXQ4RDVzbEs1QTJtdGhVK2dLa1U1VHpqVmsrQk1rYnVycE5tV3NVZllp?=
 =?utf-8?B?bkJ6aEdhbzY3YWJueEpaeGV5d0VrRENjZzk5RkRoazBkeDArNjlFNTRQenlB?=
 =?utf-8?B?L01Od2lQTmxsK202ZHIrN0tOZlcvSHJBNE5hVTYwUXZxMGZCTWRWMXpkZzdD?=
 =?utf-8?B?SDJxU0liTTlJZGxMbnNoUUs5UVpRMmVZbFkwcEtwTUJYYWc0bUtmbEFBTnJW?=
 =?utf-8?B?dUlUdG82aWxvNHR1RDE1dFVoaHZKYng4ZERMSG1LeEltUXZrdG95bG5qd2hW?=
 =?utf-8?B?TWFzM29hM25jZ1VpM3hEQVlGRDdUQS9nUzJITjJjYUVHc09obGR4dGMycnFx?=
 =?utf-8?B?bjJIYy9xZVJQQUJpVG1nNmRVUnFhSzVodkhwRDFqbjA1cjl6N0lPYU5hOUwy?=
 =?utf-8?B?ZzdsWDI2VHJjRG9ENy9vRGVJWjdxZ3g5QmVlRkUxWlpraUJvczZVN2habm9R?=
 =?utf-8?B?bm1RZVhQWmRNUXEwYWlmN09udE4zZXZzUGdldW5FbjVvMzJkNFVtUnhpR0hC?=
 =?utf-8?B?cXVjMEhhbVNjUHQ4dXFsSW04aU90bkpRZW8za3R1Y08zbGp1d1NkUFJSQ2pn?=
 =?utf-8?B?bnl0V1hMT3cxbU1lOVV4ek1zaDg4YlMrTmdVY0wxMGZVNTlFZk8ydEJEb2JV?=
 =?utf-8?B?cmtlRnRsbEVYQ0YweWNUVWVOcmJTaXZmNFJsbWRJWTVmV2M2MW9QNmw4dFQw?=
 =?utf-8?B?Wlk0M1ppSTJOODFIbDhlTnpQa2UyT0FraWlCNHV4UlZnVnFadWZGdlRnYkN6?=
 =?utf-8?B?N0lzeDg0M2ZnMjRTMVBTRDNtMkVZWWs1QXU2QThIdi9QR1NmM09ZU0M3TWJU?=
 =?utf-8?B?cWwxMEJDMDVmaHRxdFdMQzE3VE5jZERlc2UrQ3hlZGxoRmJXOW52K09la3Bj?=
 =?utf-8?B?NDRNNVRQakdsQVdiUXVZUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUtzeGdVU2xJcGl6cUJvTzFvejgyOE1DZitvalJqa0w4M2tZU0NrcXUvOHFS?=
 =?utf-8?B?QTB2VVlPU20va2ZXczFpbCtrcWtKa1FURFlsUUhackF2YjdJSVVkcXU5YVdP?=
 =?utf-8?B?bW5TT1VpSjdVMFdidlBNbFRkdkkvL2JVZUpjZVFtdVFCUHIrR3ZxNjJPNS9I?=
 =?utf-8?B?TGRndDVQUk1NeFN2QUszNXVUcVJScEYvclNlS0cwSEluNnZ6N3pWUFNQeHpk?=
 =?utf-8?B?ei9sNG0waU5HYkdZbkx2RnN0bndwMVM3M2JWQVE3RXdjanAvNGVUL25rRHJj?=
 =?utf-8?B?ZHIyTTZYSjNzNWpjQWhmY0l6VFAySFFxYldGcFFLcytYVnVPMW1Eem1XWjY5?=
 =?utf-8?B?NUdDQ08yMTgzcWYzclU3aDZBYVhkS0NCZlZKYnQ3T1pCajJMRFIrZnZHODla?=
 =?utf-8?B?VkxwcG93M052cjFxY0lIZE5mWTZpMHVvM2Q4NEFJb1RsVXVsRVFVTlpwakUz?=
 =?utf-8?B?NWNPTkYxeExSdXVPcDUyYmhJalBkTm4wTXQrVmg1UmI4M0RKMkRsSldwOVdt?=
 =?utf-8?B?THpwcGxzOG9GUzJnVHEzMFhDckMrVXBnZHRhdVlqM0ZTdUUzS1ZpQ1QxTFVT?=
 =?utf-8?B?YU1XZTF6ZGFBNnh4SDEvT21ybzhCZXNPbVIrdHR0bEpObHZuNEJaSXl3dzVJ?=
 =?utf-8?B?U0NmR290WWU4WE4rbDhtUFU5TUFHalAvT3RjeGxXRFBOVU93TERhNmZiTk11?=
 =?utf-8?B?T0xad0hETC8rYWU4RTNwZmZOb2RRclQ3N013eXo2bXFtV2k2QTBXdmNNTlNF?=
 =?utf-8?B?UzBZWG4xSjJwMk9ORnlDNG5xbkphSmVrcThIMUpQOVB6NFJyV3ZMTUc1YWd4?=
 =?utf-8?B?ZFBsRzM3bVNmYzFJNU1GSUJMbjYyVXA1cGpDY3VCU2lVNTExZFdFWHpwYkN1?=
 =?utf-8?B?K3RYUmg0SEtBYmhNdWEwTG1zbUI2QTZwbHhsTVpFTTVlRW9pc2NGVVN1R3I4?=
 =?utf-8?B?OHp1RTd2QmJINHhUV2tzamRBckhGam9hZ20rRWhJVkhKNWlrUjYxVjYySlFI?=
 =?utf-8?B?alV0WE9YeUs3UVUvRWtKMlZHTXpaOHFYc1lYWUEwcEIwdHZhM0s2WkZVaWtv?=
 =?utf-8?B?b0p1UzY4dmpXSVB0NFdqQkZKRlRyNDZZcjdGVTdzei9JdzNyQU1RL01pV3RU?=
 =?utf-8?B?NGhISEZWNE01Q016Qm9vaURkTnBLOFFPTTR1OXpybWE3YVY3clpncFV0WVhx?=
 =?utf-8?B?N1UrYmlhRkh3eWpIUnVwR242eFdhcTBDY1NFUVI0Q3dLaWY0V25SakFBdHph?=
 =?utf-8?B?NHRENHJiZGlYWEZlU2xqTzNhbWRHN1BsUU5ZMUJLamtZU2pJdC82aVlqVmQv?=
 =?utf-8?B?MFhPaVhudDJWTkFLZHdER1VDcFJSSm5oL3FyRS9qdC80Qm1wdVJhS1ZKSXNi?=
 =?utf-8?B?bUNIeE1TREFCT3hFTVE1TmFWSk94dkFKdGw2QjdIb2JjTnJBTVRySldBV3ZP?=
 =?utf-8?B?UDFKbFlLZUNBTFhaQVE3NGdLbC9KVUZnYWlKeXgrQnNqT29PNkQ4SWhhREZ1?=
 =?utf-8?B?b2pMODdsKzM1Y1lhMk9WWjZ4N05mSUsyaVVNR3NyV05WN3ZwOW5vY3VXZG9L?=
 =?utf-8?B?enViMzZCYmV0R2dYUERzQ1RNNXk0cjdlSFQxcDM4RWVGUWl2ZGt3dkJGSlN2?=
 =?utf-8?B?RVRQKzk0RzRUK1Fud1hiZEd3b2RVcVpRSERXS2dVNzgzaml4TFNpTjBWV0Ns?=
 =?utf-8?B?cnVYS2VrT08zbDRCdHQ3Yk0rM1MwSmpvMlIwMWVOdzRqWFUxRUhpYXF3eHVR?=
 =?utf-8?B?aWpCVmp3anhqZ1gxRS8rblllWE14OTZEbFBaUW5Od0c5cVdVTUJKNjFJZ1c0?=
 =?utf-8?B?Rkp2elpuQTdNRzZTSDFKU2Y2SzFFa2R3Z24rQ1VIQlJUNjhuWFRldGFjVFM5?=
 =?utf-8?B?M3BZZ0lPT1hpZWhGNURRT1EyOTRNczFZZERhcjVWYnUwYVYrdFlJdU5jNXRm?=
 =?utf-8?B?dTRhamszdXo2QzlrbktBQ21DOWtaUGppdE1rR05lSnBIVGJYbDRsUDJRNDlt?=
 =?utf-8?B?LzJDanNSd0dXelhVVFNCQ08wU3VhM2lzNDdiQUNQTVlJZlRENWhwcjYxTGhv?=
 =?utf-8?B?MytQUDZualkwWjBKNnNhTE0vMHY0QTZ2dngrRnJUZ1k3N0NaWTVrMWNNTGJO?=
 =?utf-8?B?SHZKSndFblUwNGNBSXIzdlF5N29zR3NuSlJ3aFJpZGQ5a2psR0pVd1MyZDI0?=
 =?utf-8?Q?sGhobOeN9wPyubyT/tDgIyJlCdVzHjsv15HcsBP9J6nU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76F150285025A347B941AD663F81FCBC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609ed9f6-3bbe-4d9f-33b4-08dcec186e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:21:25.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXkwJccAJTrZqDX+mpETj3tD8BL+fgF3MmBEA1BcDcgewXJbJvTkGUAyekbNZVn0Ch2pj/Xd6S6pUPHiFXdRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_232130_251330_9E803CFF 
X-CRM114-Status: UNSURE (   8.91  )
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

T24gMTAvMTMvMjQgMjM6MTAsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEhpIGd1eXMsDQo+ICAgICAg
SSd2ZSBpbXBsZW1lbnRlZCB0aGUgTlZNZSByZXNlcnZhdGlvbiBmZWF0dXJlLiBQbGVhc2UgcmV2
aWV3IGl0LCBhbGwNCj4gY29tbWVudHMgYXJlIHdlbGNvbWUgYXMgdXN1YWwuDQoNCnNlZW1zIGxp
a2UgbXkgdGFncyBvbiBsYXN0IHZlcnNpb24gZGlkbid0IG1ha2UgaXQgdG8gdGhpcyB2ZXJzaW9u
LCBzbyBmb3INCnRoZSBzZXJpZXMgOi0NCg0KVGVzdGVkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNClRlc3QgcmVwb3J0IGlzIHByZXNlbnQgb24gdGhlIFYxNCBpbiBjYXNlIGFu
eWJvZHkgY2FyZXMuDQoNCi1jaw0KDQoNCg==

