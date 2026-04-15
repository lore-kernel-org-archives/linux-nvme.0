Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95162F41995
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fq0ju2+fcZG0YT7s9KqYcErIJ7aZLRQOYLHfOP0yiJQ=; b=bIjly8gd9RAYO+BDBbuoBr/J2N
	TFrn67HpcL4YgQPiarFUV1A59NN9EPsb9SoTNXPMSIQqOsisuaYJHEFtlA6R3UnHtRQDimVO8lsMd
	iY29pMQWNYt4u1SOMuCu51YCBjjqAQ4dw00dr8TMM3YxxGIKsLXkFGFbf5cRL59txqc+/scH89bCF
	MdCvq7+wkKIQExNYbRCv47Hs9F47bMboSv5WU0tH+ldWiF1m5l1pSDWw9IyCIs4mbgXbnLaKm6JvS
	Uh3fe52tCu0M44pxB3EOx2wWAHjwJKWcdK/oFW+FRmf2ps8EhfCbARaO6sqFgvl1Qex9bO0FD5ZkE
	z5hbN1QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD4Ql-00000001TaD-3rWZ;
	Wed, 15 Apr 2026 17:53:39 +0000
Received: from mail-westus2azon11010042.outbound.protection.outlook.com ([52.101.46.42] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD4Qj-00000001TZJ-1Z2p
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 17:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOmNvVoMV43IclA4oUAvSZHuQVOTXUwmGNCq7A3xW1uNRz+Ox+ZENfSKmp5vJz8y+5q8sdQBefnELSa4Pjw4gFKqMISocjtlvkhKdtNLcGOUZxQmfFgbtk5+9MMHdLJMjp33SAlssTogQ6rsVtuuFnO7k386vxHtZfOCrTEHjSJa94HxREtClSCWEsuVnKOF1377dExKQIGD7+n1QIE8s3/7ftk8x7B7f+0Su62c53557gX1SrjsLx4IcFmCWzWWmQCjMiEyLZvGElM0eeyFzpAQ0OXw3DMZtfGx9n5FnoB9268NzWD6S/eb6+C2CJTZMUNnMW6cap3XZsg+pZDk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq0ju2+fcZG0YT7s9KqYcErIJ7aZLRQOYLHfOP0yiJQ=;
 b=G2lkMdgRSPxNyBJ7vQ4xTaVBlKjkq2UsdMRImjPe2hDTlwBCZxMwkKPwYiJVC5ThfB9K+JyFi1bWkFaXhvxKtvDJs59/Ua5FsRWHADSZXYADGeT5XGNRIvUITor+1bjj7UuwfuC28ZGGYM9V5ALiNE6rvf2dgZp68wKzkCQ2lu5eWlj420enSuGrZRYSHU/htVBunjSuHEa6d0nfajGgMWqSKemB3m4gqbYqMMhUd2coSU/2yvXxc6v5W6TR55EwVny0wRVZRWyvPYCaoAlUIBCNLSHINQl/Cc9+EMQujr/ruaEIHCMhRkb/EhQbpuiEcyJ/9a2qwrzGgZ9JA7jkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq0ju2+fcZG0YT7s9KqYcErIJ7aZLRQOYLHfOP0yiJQ=;
 b=iX7fNx7hfCnT9RjS5HQh8NHmGGOSD8Z8adilVgoIrVkpkRth+WXO8Joft0xuwxvIWQ08z7PP+9i4sTgAys5NonrUOvcPIzZw2n5YVT8nGnBaqkfmg7e8lwpCmWjbgaRjIy/928Eep58x2lRZae83fx6jPZOq9aCHRlw7liCJZThC1rnbPt//WFxjEMcjnCHXYvzIBVuqprptEPaxK7z3k77dSESzE8OX+kmO0KjhLb4YVo9ZsyefIgu/h6hMOsRNqh48tXB01/et9DXEX7lQ0bX/TxARfXK7nnbSDsgt+hyiEKBpLLt0JwbT2UJ5YhMzA3EzlpAHMXOQGf9++xDUOg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 17:53:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 17:53:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)
Thread-Topic: [PATCH] nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)
Thread-Index: AQHczP2lLzQ79pxjY0iiHgMF7Z6VS7XgZ4iA
Date: Wed, 15 Apr 2026 17:53:25 +0000
Message-ID: <ba517732-9f79-4db5-ad34-c648a49481ee@nvidia.com>
References: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
In-Reply-To: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6312:EE_
x-ms-office365-filtering-correlation-id: c367d73e-be50-4fe2-8b72-08de9b17e48f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: uMZeI80CzAI7DOMux6oRON0kBE7UP7Iluo0E53wFjQJZfIigknZ+ZvnVJ+FhBgurUDukHzmFtF9t21JGz4ZqxVgEtoOQMg4xbKXcuwemzf1yk4My6wcnK+I9xoOnNz/7lnaB9QhMc3feIFCC5a5S2tJ5oTCsR8sd9UVxARvX/U1tuWIbU6MiqMwD362avOwozpccj8L9sFWsnY1I12Gn5wMiXZPyvpsgGc8FAaRSaeLIZB0Qwsvkn4nm4Bf5WFkn0j7qNQqqt30GwWGO8twGWtvAjL+dPdVRI9F+8v8CJa6h83++9q/ITrFS8WswTuyWCi8MqtjRVp4u+d8e+s7vCt6JVfgN7XphbnUV+5BOmBWQXT6SPsnwfXu23FcHCPyYfFRbjXBF5qYp0DvGRRx07l1cNGjzhWSSDBfder87JGit62WOhTfgOUC9x6CmMO3+Y5z1hdw6c5sKDGaw7rwtUS3A5vdKtli7VJiP+0NT7tamfqBnKhzEubxYoC+R6gSKfmwTrioxtjJNzf7DNdReKSgJuNxkaf23tYH11hwNbcmvnaCVFu3f6ok3qZ5FcbUT5IHgA8pqkO0DR/pqBwm/K9EjYRFg2IuHwvMRotmcMtq/uvI9yFF1Z2t2WFz8lN9/ZhqZO9P8vrTtrqRnKgyw2moi9F5ghe4OhGyT/Kaee/JrViR5Zcx6pTuBXZMtJCEezl6JbfpfdEWAv4cb2JKatuXQNTOYS6bhylcu4IehdWmWURqJ6CiEodBsc0nknzRJpTY8qqAtzrKCI935vhhnr9pyTvb/aE4hk80E6Tkw/LU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDVnd2RSSnF3TmZoOWNxY2pYS1dJMWhSV3R2emlGNFZaKzYwaFJDT1B5MTV6?=
 =?utf-8?B?WTd1OFN1VVBad0k2OURRU2h4M0wzT0RjS1dSZ3l4NzZ1c0VSS2xlV0pGN1JT?=
 =?utf-8?B?LzZiUGhhUDJ3QzNBM0Q4Wnk3MmZQRXptbDFKN1JNRCtNYytvZDFzL005VFB3?=
 =?utf-8?B?cFpqT3ZhMzFUeTVsVHd1aHB0NzB4MmdsbGoxM1VPRWdreUM5aTFlSVIydjZD?=
 =?utf-8?B?ZHZaUGhTdnVNQkJBNWo3Q09QYWFEREtNVWJWN2krbDhPaFZPNWQ3OU4wV24r?=
 =?utf-8?B?aFk1ZmFTME5QY05FbGY3aXZlODRxNkJLT1lrdHZZd1d5WElzMHgwUWhJU0hO?=
 =?utf-8?B?eUV4Qk5oOVJxNW14dTBRN1N1WUZoa09wV2xCSUJSWTRadmV0TXh4d0t0WDNQ?=
 =?utf-8?B?SjR6bXlETFJIL25QNUxvdlVCcjdGcFZSVEw5MWRKQXV6aXUvUFdubnJoSi9K?=
 =?utf-8?B?VXkwWUJGQXdxQSs2N1RPT2FLZFpQMjI5QWM2UlFHcWVTN3R1Zi9JQ0N4NEJP?=
 =?utf-8?B?eFQ2WHZFbytEWTRjVVI1V2pxQlpQRXcyUGswcEIrNHo3TFVqQUZIL2k3d0N1?=
 =?utf-8?B?SXlWUm5kWFZhV1BvWnFrbVBobHFQdnZVZG1hZlJvM3F6a1UwdWFkRnU2MlRB?=
 =?utf-8?B?aVpWVXhodFcreWZLOGZEcDhnc29ucEZRNVpkeXVwekQzaTIrd0swdW9IVnRG?=
 =?utf-8?B?QUZoWHVud2NlaDFWcFAvOCtsbVAvVFpMMkZXTFRyaGI5UGc1VmgxZlJCaU4v?=
 =?utf-8?B?VnNWS3BKbnN6dS9yeVVUZnlnZ253dFRNcTVvdWhsNnNLNVBsR1RRRElNRVpI?=
 =?utf-8?B?R28wM0d5bzRTNWt3VHFnVGR4MDVsVkF6RkJ0YTNJazZuWjlneDJHVWdSSkdL?=
 =?utf-8?B?UjA4bUh6QVhFYkx6Z0ZZa25KUGxpVmlBeHhaaWNCL2k4UlBNQTdBMytncmxi?=
 =?utf-8?B?SmdiNzRWUVdWSUhFQ2R1S05BNGpyb3BWWmZoQUl2bzJIR250ZlFFaXRYUGFu?=
 =?utf-8?B?d2QvUzZDSDJkeFF1c21FR1hpTGtDNmQ1SDZ6Unh4bnVhTVBrcXlNTG5NNTF1?=
 =?utf-8?B?Q3FacFZ0UjBjTFFNbzFHL09WK2NCK1hGbnZJZVBieThRSTFkV3RjWC8zNHpl?=
 =?utf-8?B?TXN1V3Mxd1VKcmROTWdQY2dQdHVhbldta2tMaERMam51Rkg2emhyaXk1bG9Y?=
 =?utf-8?B?S3U0d0RYVFFseXJ4NkhLWDd0MklCeHdYdTFuNnpVbXovU3lhY3pVbmdDRzJJ?=
 =?utf-8?B?a2Y2SjdkUGdFOVNKVFppVGNXdTJDelNzQ3RvUVY1TTM2VFNhSnBwRHZZakNr?=
 =?utf-8?B?Z1pjM2hMcXFRc2I2UU1ScEt1akFvdG9ualRzTWtNVzloVThjd1BWVUZCUHVH?=
 =?utf-8?B?eHIzZEpKdm5uc1k5aGJXM1RqZ1ZXNldSaXVMeUtuWkYxKzNkdlNSOFZMT01m?=
 =?utf-8?B?ZUZDenRQUmpiK240aTNTenc5ZlR3VGs1UzlDMzY5Y3pmRkdoTUpzajIwWjNE?=
 =?utf-8?B?eHlZZmRRdkorTnJvb1QzSXZNWSs1ZGdNTFhsTGM0SjZjZ1FsRDZ2eE9ZZGQv?=
 =?utf-8?B?ZnpVZE1JMU1jNW9TZDVucllFR0w2dlN6ZEx2TitRN1dEUnQ3T0pHTFV1Uy9l?=
 =?utf-8?B?TzAvQytjUUVEcWY5U004WVZ5T1NIeHlpSWhGaXlndHhsTzRkR09ZbVB6RGV3?=
 =?utf-8?B?bE9xVHR6QjBPQmw3aDBGWDBkSmp3Z3NvRndBVTVZSkNZS0lxbnlTa0F4RkM2?=
 =?utf-8?B?OWNCUmhrSm0vU0dHV3JWREJPQUoxc0ladjR1NUdGRGMveXFWS1JZY01JS09F?=
 =?utf-8?B?LzJNZUlRWFpCMTZrWXFJbXQvK2tEMzlIL0E2RVJOVjR0cCtaM3BFb3hJS1Yz?=
 =?utf-8?B?T21DMENCVW9XUXhqS1h4YnpkcTZHVGI4M25Mb29JdGlVMDJyWGZUem8zbWRH?=
 =?utf-8?B?cUcwUm1OV2c0R1BvS0t0RllCcHNsNWtyUHRhekdZa3lzU0RTZXhCSVBDZ2c5?=
 =?utf-8?B?VmNUZDFMZ0tqSExQT3lMYTVORGEzdHZla1NIRnlqUkR3TFY5dCt6REMwbklH?=
 =?utf-8?B?TkpSc1F0S09YSm9xMisyT1A4cU1PLzljdVdHUlpSRUVFUVVWMWtDY1VBN3h4?=
 =?utf-8?B?dlNXeXprQk9DdEpTK01admlNcTMrblk0b0VEUTlKL2IwWGROUzRnRlR2bytX?=
 =?utf-8?B?a0hnZ3F4VGJ4MFNDdUJ1Vjk5RHpzUk5GUUwwOXZGWFdjU0U3NWVjemdPUFdk?=
 =?utf-8?B?OTA0ZXMzMTdwelVYbjVIbGhwdDhEQmI4SVZUY0RET0JSUGRlT2pnczlkejVp?=
 =?utf-8?B?bXpNOVVkV3lZR3M0aTdKekR6cW16TUxURVh4WTZOWHpkS1BvRU54WElGWmJs?=
 =?utf-8?Q?qAPShyRfBU+vBvkTPHU6mNh9301Klv6eOcqGb7Zzij2eW?=
x-ms-exchange-antispam-messagedata-1: 2dpzYXVyjMRT3Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <818F3326FEC3354C82479C5073716319@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c367d73e-be50-4fe2-8b72-08de9b17e48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:53:25.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVYupQMmaD9E2tlz4OmKFAdCCqqX6hppI+se96wq/ev7WKwfc5UGps520h+U+zO0Ro6pwgf2//OI39QNJ9gv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_105337_415375_5F646505 
X-CRM114-Status: GOOD (  12.67  )
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

T24gNC8xNS8yNiAxMDoyNywgVGFvIEppYW5nIHdyb3RlOg0KPiBUaGUgTWVtYmxhemUgUGJsYXpl
NSBOVk1lIGRldmljZSAoUENJIElEIDB4MWM1ZjoweDA1NTUpDQo+IGlzIGRldGVjdGVkIGFzIGEg
Y29udHJvbGxlciBvbiByZWNlbnQga2VybmVscyAodGVzdGVkIG9uIDUuMTUuODUNCj4gYW5kIDYu
OC40KSwgYnV0IG5vIG5hbWVzcGFjZSBpcyBleHBvc2VkLg0KPg0KPiBUb29scyBsaWtlIGxzYmxr
IGFuZCBmZGlzayBkbyBub3QgcmVwb3J0IGFueSBibG9jayBkZXZpY2UuDQo+DQo+IGRtZXNnIHNo
b3dzOg0KPiAgICBudm1lIG52bWUwOiBtaXNzaW5nIG9yIGludmFsaWQgU1VCTlFOIGZpZWxkLg0K
Pg0KPiBUaGUgZGV2aWNlIHdvcmtzIGNvcnJlY3RseSBvbiBvbGRlciBrZXJuZWxzIChlLmcuIDQu
MTkpLCBzdWdnZXN0aW5nDQo+IGEgY29tcGF0aWJpbGl0eSBpc3N1ZSB3aXRoIG5ld2VyIG5hbWVz
cGFjZSBoYW5kbGluZy4NCj4NCj4gVGhpcyBpbmRpY2F0ZXMgdGhlIGRldmljZSBkb2VzIG5vdCBw
cm9wZXJseSBzdXBwb3J0IHRoZQ0KPiBOYW1lc3BhY2UgRGVzY3JpcHRvciBMaXN0IGZlYXR1cmUu
DQo+DQo+IEFwcGx5aW5nIE5WTUVfUVVJUktfTk9fTlNfREVTQ19MSVNUIGFsbG93cyB0aGUgbmFt
ZXNwYWNlIHRvIGJlDQo+IGRpc2NvdmVyZWQgY29ycmVjdGx5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUYW8gSmlhbmc8dGFucm9hbWUua3lsZUBnbWFpbC5jb20+DQo+DQo+IC0tLQ0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg0K

