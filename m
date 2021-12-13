Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D52FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPtrNyH2H+IYZfmrLCGWVSOd/y4Ro812ZgdDF7qdZBI=; b=4zjn6Ci6LEY0IQGk0f245hdZAx
	SYX6wo2lMNuFD9N69ZlW+9wEe7slJlQSFQgcGuNwTh5alxIuwxVP5ddlaPrTqCeQwAwDNrRKjHPJX
	xNZGFDbKdoFskYe5AagdmX5APtSewct133OxzxguI8mmRDdrolDZWH4z2jO8JdwsrSkp9cpB+AaD9
	TxdW6OcnFpnJJ6G4pv6o9ByL2hMzIL8fzpuhOCjTvwHyu2SdDMi4JSsPRUq8Yt3u/KrYY/lS6NGyu
	uVf3sTSwPef13hzKAdCtM2mfNU29CRVsUCnVIBVZFN9ZgitBEJrMISVxEdhFoIV1NEsfIx9f6eir7
	Jnwyxkfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgBv-008BdJ-Dc; Mon, 13 Dec 2021 07:56:11 +0000
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com
 ([40.107.243.74] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgBr-008BcX-SM
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U14SBu8uXmbsVH3cQ6x58ROTW5PN8wTnfkHjwLSpU9mfXN4ousXrg+6xTkdIrVsH3zR2CzYdJOw4o7JVzDrfb9wTQwW//q+JeFg16C2pKlW8pnVlf+ksH+cTULJQEDX4b4CYX8bbWgFWLtBwxGyaIJ8IpYjozxzqdP3FtKOkFscbdO7YuXYlZFnbAgq6Y5ip5esDoNbnqFe/sEiDkw5wJNhWxWFykI15YyR6wY+p6cgCQc7PwsEIlVGtOerbjnKEpzK/ojZEsEXwy7LQkRtT9FxeYyRAkRCSAb4j4j61Di/tdSmQ/7U+sRAMhvTshzDF6Tns5UnErWRxyFQ17rdQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPtrNyH2H+IYZfmrLCGWVSOd/y4Ro812ZgdDF7qdZBI=;
 b=cuQ3VdxHPbEbPirux0fyUK48aKbJTc4J9DR5u4W0xf/uPqgXxyua8XhKfHZHQlJlwnH9+kCii0cR3+6Z75pU5BWSkGSb38MuXBh6IHzekWsOXUQy4F+ZZxOV1Sl5rcrGHjIwglxPHhue8McRjWZL7pHaL0iylF62szFsRhgnAhxyGfh0rpDv3irhhBWUUFLuXVMcJcigMzBljaziRIRI2eQH1QGoZf/tv+fnaF4JzfkkltAcAUyxx+ywLDGXdMOUAv5MMAIms10qA4ighRmh+oS7loEm/NAHweMDhGyvuCMfkzvvW4j6ftndpsC1VEuzw7JNEUmnynlV+bFps+zb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPtrNyH2H+IYZfmrLCGWVSOd/y4Ro812ZgdDF7qdZBI=;
 b=DiuaeqX2X+JU4/DsDHR8x//i5Vd5rAdTp7sY6VoGqQfA3aGkl/BsGwIgwDzddYFTsdE3ViW2ViqQgiVDtTtu9guVmw+O8PF6QuIUMBAHXk2kYAT6wAVT1Y7nk3PkVSNcst3dMGAeMWvMp4pHvcddiFXaoVDlGxG+grPmkihDsicTk9wtvgskmg+9TV2tuCQ9QTiHG5WpgOF7ZHleaOy2BQxeI3mZrgKjO4QHPjND318LOQcqTd5TwCFD5KTOc78E61tTWTy4b5UP97vBnBD2LvHu9OqG115R9WHiQAePWD1YJjJAdk9R8NzyuruwtrgAHHM+Vlei08cTpMCGXViq6Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 07:56:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:56:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH V2 4/5] nvme-cli: Add support set feature event in PEL
Thread-Topic: [PATCH V2 4/5] nvme-cli: Add support set feature event in PEL
Thread-Index: AQHX3KnsE/EA9SXydku3lP0xnnAVDqwwNGyA
Date: Mon, 13 Dec 2021 07:56:04 +0000
Message-ID: <a2fc5e34-3731-2898-7d7e-cd5e08e534e5@nvidia.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
 <1637254648-19500-5-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637254648-19500-5-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b01264-b12a-4269-42ef-08d9be0e0341
x-ms-traffictypediagnostic: MWHPR12MB1583:EE_
x-microsoft-antispam-prvs: <MWHPR12MB158336BCFA06CB52363EDBDCA3749@MWHPR12MB1583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:60;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkXDuIaJkovSi5DEQ+jDbLU5E+e2QSLOlYgPNVbuWLH/Pm+pFSY4yYDFjUuJqIGKMbhpGXg8Iknz5Hv/kfZd8VV50/dGQ/sKpvOk5A5ESHeLJWYnWopajLPPvDKb5RuLuz2I/H/6hzdqVoHJ5e/Gy2O/YyndERiJJ0tflEX/FXESeYfX9kDHCL7ukXxlUtA2SptQZsrvxAN5PRynSwrzOEMPxf8i1+wzhImhMq/tz6Ru45xbalO7+pIX9s5BWchBftqweB4dDnmgFWWRzPP+Q4ZMYSQAPXI+Jp67lJMByvOV0qFl6sspGCsv8clsM4Iy4QJW808xzD36i96PX5a/INF9gZQxhkfv4RawSGKWmOrMuT9quvOIqrgctq706qribeRT3r7tPyYGGNJl0hRwpWG6CqvO4m8Hd/YwFyIB0G239BGWqfcH9EbjNOE14fpplBFZ9pX0c5DjH6Y+6QMc2DpTDtn/jTSflIaP4TyEbp187rUC5CYPfeCeR0AUG9SwWmDOLbzO0C8uItsMhiH9tlXROlFQzzt0BqsO0nqdLR1zUJJdJ7F2Ufo/qXwxiHejGq+ary5vPvI68NJ9QEBE8TIMR93Eyr+FfHTkQNEmycV5v62bUfpivZlKjxEmzGDUERrDFFxQJ5bl+TZrU7PyLZkbM6daR43hi2bvd1b73RAyJJRWxJtaa//mLn205QlOIz+Mok4hzqEXqJ4GAakzOPMD09pvClntWRI9R5l6UG+QdqvPqLqa27MgpmgU3RQEoNwGgDpJfrOSwUtUa5tFXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(186003)(8676002)(66946007)(66476007)(8936002)(91956017)(86362001)(122000001)(5660300002)(31696002)(66556008)(31686004)(66446008)(4326008)(76116006)(6916009)(2906002)(54906003)(6512007)(508600001)(38100700002)(38070700005)(6486002)(6506007)(36756003)(53546011)(316002)(64756008)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3IvcWFGeWhUQ0Q5RUYzQmVwVVEya1F5OHlTTVZnVlJ2SUludGpWRlhndVFq?=
 =?utf-8?B?VGdFQ1g1OU9icjJnclRGZnpFWVkwakhMVU16NzJ0RUp3OVVuN2RtZmExZk0y?=
 =?utf-8?B?L1p2MXlhZlBkekZPeXNFVElyL0tCMkVBTWlZbTRKeC93SmMzSENhZXozc1p3?=
 =?utf-8?B?NjVZQXhuK3k1WmdQQkJMRGxCOTRZNk8wOTdoL2RiQ0R5M2djZzExVWxGUjN0?=
 =?utf-8?B?eUhMbGV0WmZKZklvL3dJTTltdk5ib0V3dVljRmZtajh6RlVHT3JsNjVDRHdX?=
 =?utf-8?B?aW5NUk84d1JjT3QvdE5yNUczczJIbDc1MEcvejhmTGUyVlBGYmJVUG53QkRp?=
 =?utf-8?B?YTdyemNrbzNKSjV5WDRLMElQZzVhRUN1cUFveE4rc28raWxZSG5IQlJ6VWtr?=
 =?utf-8?B?VzNBSXdNRkFjVDFwYUNFT1ZSY2NJNjh6NTZIaS9yYlloZW9LWVJnNjJOUTJw?=
 =?utf-8?B?YXpiaVZDR0JDU3dRWW02Y2p1ekh4SkdZdnhHYW96UEZEMWpvSVhrTUx3RDBt?=
 =?utf-8?B?VExSb0JYN201bzVVeUliclBIWitzK2NaNFhrNTNFckQwcHloUWg4cWkxTnBX?=
 =?utf-8?B?aWdCUzdyUDlXVGRxaFR0dEtoVjBQZWlDUnNVM1lQMHdKU1hyczhMK0tBekFs?=
 =?utf-8?B?amVPbFNOTEI0bFF0azB1WUkvMEExZy9xYk9hZThQLzIwemorM3BzZ05kS004?=
 =?utf-8?B?SldDaVR6cThPUVA4UldBcG9HUlNpVC9YZjFqd0RiaGd4aWZKc1c0MGFUMzA4?=
 =?utf-8?B?UFNtNTJNTlR1Q3hNV09KMEIvZ21wVkErR0oyaUtHeHJZc2lyTFlZUkFTU2Jk?=
 =?utf-8?B?WmlSbE51N2E2NVVmMGRrdjFUK0xEclRxRGs2bWQ3OFpzMmY4YnkyUDBmSU93?=
 =?utf-8?B?TVF6SkVWQ1cveHFlaUM0TWtHdy9Jc1I2RlZwOWEvZWJKdG5EVzVtMTFYZG9y?=
 =?utf-8?B?QXdCMDVpVWtrajI5ai9lbjlMOEp1U3dGNUsyRW9NQ3dFUzNlU0tLa3VmTGMy?=
 =?utf-8?B?YzBlT09sNnhVT2dVK0ZrRFQzT0xOUzZEem5wYzRvM2RpaStSeG1YdW5TWjNu?=
 =?utf-8?B?VFlYWHB3SlMyM3lZME8zQzhsdVRlaVF4WWt0NWQwYk9PU29CQ0JuVk9pZUdz?=
 =?utf-8?B?NUQ1cFBBY3VQRFRQKzR1bC9RSjdIa054M1V1bnlyOWkwSjBKWmNwTko4NjZX?=
 =?utf-8?B?eGtoNUNVSWZNand2UnAvaWxiT2hZY0R4c0Q5c0c4elArRk91bU1KUVpZZlRt?=
 =?utf-8?B?NlMyQ2RVY3BJNDhRdjBnbVBxQ3o5YnRkZTM1NEV3SXc2RTl4ZFpxS2U0UkhC?=
 =?utf-8?B?R3pVZFhWdHRBc255MGk1cklJQkUxVFFzNFFIY0ZTY0Z5d2NrQ2hVd2pxbW1E?=
 =?utf-8?B?b2xYNWpDODVHOU1WV2dUek92V09UL3NQRTNrTEM3Vnp2ZG1rSmFNa1NON3hV?=
 =?utf-8?B?RlBBUk1RdEZFQitMbjRPWlpkdnJ0aHpQcm03WXR1L1pCTFVHOXFvS3l3N1lv?=
 =?utf-8?B?ckRyMUMvSUZMYW1IREIyR2NzVGxOc3VlOXNLUUJZaHpHNkdydHk4UWlNOHNS?=
 =?utf-8?B?L1FmVzErdExQbWpEUGVRNmVDOHFSOWhtcDZTbnFFcFA1V1RTamxkZVlSMG9L?=
 =?utf-8?B?WlBxWHRCNGJ0UmNjaVc5OWRaVCtTS0tRRU9EZ3k1eEloTnU3aEtkOUw1bWV3?=
 =?utf-8?B?bmFhT3ROai9VTllRSTFSY01lVGMrNXA0SEZvQ3pCOG1lam9SeFB4a0VZYy9Z?=
 =?utf-8?B?UC9NdHdEaWN2b0tFMkp0VzJBSEdPYm04ZDdHSUlCaE1KUGxCL0d6c3J1YjlC?=
 =?utf-8?B?bHFiL21CcnFKaXFmaGpZUmJseXg2Ti9FNDdCZTdJeHllcEs3dldjNU8rRmZF?=
 =?utf-8?B?Ky9hMGY2WVNkbE9md3VtYjUyT3l3QWl6T0trNHZxUzBUak5BdXhBUTB4Njd2?=
 =?utf-8?B?a09rd0lBZUN4R29FeW1waHF0UDhWcVJQTzdEeDJQaHNPSU4rcmFBOHpxZ3JE?=
 =?utf-8?B?c010alg5SmhuUW1Jb3NyTkJUSGdvV2dsV3p0V2Q1d1hNRG9rMVFTWmFCc0RJ?=
 =?utf-8?B?N2R5WW5GcTRRNjNTZXp6bkxQQVRHK21rcm9oQWNJMXZBc29mcEFHQVBxdnl4?=
 =?utf-8?B?djZ2NUYvbWhka3FrSG5ubGdNQWxtWXJhL1ozSi9RNEVDUkJ6OGxnT0VjQjVh?=
 =?utf-8?Q?GpFTm5a1ZmdhOzHAgNM+z54QQ4b23E9+IUUofrwdzRI6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24058BC7F1098A418BD8C6548A792B47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b01264-b12a-4269-42ef-08d9be0e0341
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:56:04.2224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3bnCLLP4DDCa3qAgvWfL0HSk/ibgmNUJpX6OM8kykmoZZH7SvSM/zmi558wEVuGqf3Sll5ZOPL+1dyDtkRAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_235607_947962_80B2759F 
X-CRM114-Status: GOOD (  17.02  )
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

T24gMTEvMTgvMjEgODo1NyBBTSwgd2VueGlvbmdAbGludXguaWJtLmNvbSB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBGcm9tOiBXZW4gWGlvbmcgPHdlbnhpb25nQGxpbnV4LmlibS5jb20+DQo+IA0KPiBB
ZGQgIlNldCBGZWF0dXJlIiBldmVudCBpbiBQRUwuDQo+IA0KPiBQZXJzaXN0ZW50IEV2ZW50IEVu
dHJpZXM6DQo+IEV2ZW50IE51bWJlcjogMA0KPiBFdmVudCBUeXBlOiBTZXQgRmVhdHVyZSBFdmVu
dCgweGIpDQo+IEV2ZW50IFR5cGUgUmV2aXNpb246IDENCj4gRXZlbnQgSGVhZGVyIExlbmd0aDog
MjENCj4gQ29udHJvbGxlciBJZGVudGlmaWVyOiA2NQ0KPiBFdmVudCBUaW1lc3RhbXA6IDU2NDU4
NzIwNDE0NjE1NQ0KPiBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb24gTGVuZ3RoOiAwDQo+IEV2
ZW50IExlbmd0aDogMTYNCj4gU2V0IEZlYXR1cmUgRXZlbnQgRW50cnk6DQo+IFNldCBGZWF0dXJl
IElEICA6MHg3IChOdW1iZXIgb2YgUXVldWVzKSwgIHZhbHVlOjB4MjcwMDI3DQo+ICAgICAgICAg
IE51bWJlciBvZiBJTyBDb21wbGV0aW9uIFF1ZXVlcyBBbGxvY2F0ZWQgKE5DUUEpOiA0MA0KPiAg
ICAgICAgICBOdW1iZXIgb2YgSU8gU3VibWlzc2lvbiBRdWV1ZXMgQWxsb2NhdGVkIChOU1FBKTog
NDANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbiBYaW9uZyA8d2VueGlvbmdAdXMuaWJtLmNvbT4N
Cj4gLS0tDQo+ICAgbnZtZS1wcmludC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9udm1lLXBy
aW50LmMgYi9udm1lLXByaW50LmMNCj4gaW5kZXggZmI3Y2VjMy4uOGQ3ZWNlZSAxMDA2NDQNCj4g
LS0tIGEvbnZtZS1wcmludC5jDQo+ICsrKyBiL252bWUtcHJpbnQuYw0KPiBAQCAtMTQ3Miw2ICsx
NDcyLDggQEAgdm9pZCBudm1lX3Nob3dfcGVyc2lzdGVudF9ldmVudF9sb2codm9pZCAqcGV2ZW50
X2xvZ19pbmZvLA0KPiAgIHsNCj4gICAgICAgICAgX191MzIgb2Zmc2V0LCBwb3JfaW5mb19sZW4s
IHBvcl9pbmZvX2xpc3Q7DQo+ICAgICAgICAgIF9fdTY0ICpmd19yZXY7DQo+ICsgICAgICAgaW50
IGZpZCwgY2R3MTEsIGR3b3JkX2NudDsNCj4gKyAgICAgICB1bnNpZ25lZCBjaGFyICptZW1fYnVm
ID0gTlVMTDsNCj4gICAgICAgICAgc3RydWN0IG52bWVfc21hcnRfbG9nICpzbWFydF9ldmVudDsN
Cj4gICAgICAgICAgc3RydWN0IG52bWVfZndfY29tbWl0X2V2ZW50ICpmd19jb21taXRfZXZlbnQ7
DQo+ICAgICAgICAgIHN0cnVjdCBudm1lX3RpbWVfc3RhbXBfY2hhbmdlX2V2ZW50ICp0c19jaGFu
Z2VfZXZlbnQ7DQo+IEBAIC0xNDgyLDYgKzE0ODQsNyBAQCB2b2lkIG52bWVfc2hvd19wZXJzaXN0
ZW50X2V2ZW50X2xvZyh2b2lkICpwZXZlbnRfbG9nX2luZm8sDQo+ICAgICAgICAgIHN0cnVjdCBu
dm1lX2Zvcm1hdF9udm1fY29tcGxuX2V2ZW50ICpmb3JtYXRfY21wbG5fZXZlbnQ7DQo+ICAgICAg
ICAgIHN0cnVjdCBudm1lX3Nhbml0aXplX3N0YXJ0X2V2ZW50ICpzYW5pdGl6ZV9zdGFydF9ldmVu
dDsNCj4gICAgICAgICAgc3RydWN0IG52bWVfc2FuaXRpemVfY29tcGxuX2V2ZW50ICpzYW5pdGl6
ZV9jbXBsbl9ldmVudDsNCj4gKyAgICAgICBzdHJ1Y3QgbnZtZV9zZXRfZmVhdHVyZV9ldmVudCAq
c2V0X2ZlYXRfZXZlbnQ7DQo+ICAgICAgICAgIHN0cnVjdCBudm1lX3RoZXJtYWxfZXhjX2V2ZW50
ICp0aGVybWFsX2V4Y19ldmVudDsNCj4gICAgICAgICAgc3RydWN0IG52bWVfcGVyc2lzdGVudF9l
dmVudF9sb2cgKnBldmVudF9sb2dfaGVhZDsNCj4gICAgICAgICAgc3RydWN0IG52bWVfcGVyc2lz
dGVudF9ldmVudF9lbnRyeSAqcGV2ZW50X2VudHJ5X2hlYWQ7DQo+IEBAIC0xNjk0LDYgKzE2OTcs
MjEgQEAgdm9pZCBudm1lX3Nob3dfcGVyc2lzdGVudF9ldmVudF9sb2codm9pZCAqcGV2ZW50X2xv
Z19pbmZvLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRmKCJDb21wbGV0aW9uIElu
Zm9ybWF0aW9uOiAldVxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGUx
Nl90b19jcHUoc2FuaXRpemVfY21wbG5fZXZlbnQtPmNtcGxuX2luZm8pKTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgICAgY2FzZSBOVk1FX1BFTF9T
RVRfRkVBVFVSRV9FVkVOVDoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2V0X2ZlYXRfZXZl
bnQgPSBwZXZlbnRfbG9nX2luZm8gKyBvZmZzZXQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHByaW50ZigiU2V0IEZlYXR1cmUgRXZlbnQgRW50cnk6IFxuIik7DQoNClVzdWFsbHkgcHJpbmYo
KSBzdGF0ZW1lbnRzIGFyZSBncm91cGVkIHRvZ2V0aGVyLCBpcyB0aGVyZSBhIHJlYXNvbg0Kd2h5
IGFib3ZlIHByaW50ZiBpcyBub3QgZ3JvdXBlZCB3aXRoIGZvbGx3aW5nIHByaW50ZigpIGZvciBp
biB0aGlzDQpzd2l0Y2ggY2FzZSA/DQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZHdvcmRf
Y250ID0gIHNldF9mZWF0X2V2ZW50LT5sYXlvdXQgJiAweDAzOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBmaWQgPSBsZTMyX3RvX2NwdShzZXRfZmVhdF9ldmVudC0+Y2R3X21lbVswXSkgJiAw
eDAwMGY7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNkdzExID0gbGUzMl90b19jcHUoc2V0
X2ZlYXRfZXZlbnQtPmNkd19tZW1bMV0pOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGlmICgoKHNldF9mZWF0X2V2ZW50LT5sYXlvdXQgJiAweGZmKSA+PiAyKSAhPSAwKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbV9idWYgPSAodW5zaWduZWQgY2hhciAqKShz
ZXRfZmVhdF9ldmVudCArIDQgKyBkd29yZF9jbnQgKiA0KTsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBwcmludGYoIlNldCBGZWF0dXJlIElEICA6JSMwMnggKCVzKSwgIHZhbHVlOiUj
MDh4XG4iLCBmaWQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnZtZV9mZWF0
dXJlX3RvX3N0cmluZyhmaWQpLCBjZHcxMSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbnZtZV9mZWF0dXJlX3Nob3dfZmllbGRzKGZpZCwgY2R3MTEsIG1lbV9idWYpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgICAgICAgICBjYXNlIE5WTUVf
UEVMX1RIRVJNQUxfRVhDVVJTSU9OX0VWRU5UOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
dGhlcm1hbF9leGNfZXZlbnQgPSBwZXZlbnRfbG9nX2luZm8gKyBvZmZzZXQ7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBwcmludGYoIlRoZXJtYWwgRXhjdXJzaW9uIEV2ZW50IEVudHJ5OiBc
biIpOw0KPiAtLQ0KPiAyLjI3LjANCj4gDQoNCg==

