Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D49AF34C78
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ng/SFI2fjNQU0gz1Xb8wc5fZqC+6WHXpMZ5LcXGCX3E=; b=3hQFfkhPcJmY7EhwHeUV/lZVie
	UYMftuWKsT2st1Zr/0FkPQIsOva+oqdgHwwrutHxwffbz/x8EXGoc/W6Ok+Ys3jkqBP7F3LPlAlt6
	p7Qhdb9da6L64Cj9HPx8JzmnBKORsibO5sXuzJEX/zqV9Nv12m4eDwsBLD7zfzeQxrFTzUJusFILB
	67eWlDKLdYfC62oaczatEhB2L6sDWKuy8Y5ZQjda6VmU/NvFz/pJD+uV9ACSGoJjZm32waWtNpihp
	KPeG6GphQ1JDt//5oYJBfubQJ44+2ipTG5nOhxUrsXEbUnYJGVH5ox/EZqrbykxWUiz8dz+FPZ2nC
	3MisJJeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKwh-0000000G7fY-1dDo;
	Mon, 13 Apr 2026 17:19:35 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKwf-0000000G7f1-1QDv
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 17:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytRBFpyTjsPMQzVbDewRCUWDVxsh49VnY41F4gfMwHgQeBQesWsfjjArfB7QqfSDXgkKSqUQvO+FltBWIV0RgOI9x03eM1F4Fdz80qvOlTMQlny7tjqtT3UEelJtThTWlHvDE1cTXVHvFHURznkJh/iNOlM/1OJlBu3wLwb+Eujmn9xNFEcJOO0UMA+0JJmFNCD7N3LOmIVpdOmmho/TouKZ+vEOk8uST/SB1541LUynoA++riWiB58mYa6zyVdv7eZoiC5tRwWTPTByFJFVRLU9xvtnI5hXFhujYjwuKDeWNtFkLR+xkJL25Cic3U9xaVAq2B2BK+09A0pz8pfqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng/SFI2fjNQU0gz1Xb8wc5fZqC+6WHXpMZ5LcXGCX3E=;
 b=U1KfORSk8iIICyffEA6oDCAiE9LF6IiRjinL2+3l6/BpE/XWRagA2HvQHPefLuEFE+LsnW6MHJhSD+X2ZX7IUc4e6ECGqrnqcBnUROhb1v0BN1djo5KgOhHOk33t2GV2Op9yqpr8qMVQhb+P2R6+0NqPY5RcH+u96b7sWKV7k3pNIBOLhCxH8Ryozit5JrFeY/ZdM1zTKi2add0HNrL9NacO80bOCp5hEu7WAH460Xa+Bx7yLmhS0Mve8ZizbSASI4w6HM6g1PWjDe3sms88KuGiK3YnPAtpuXvSC1eQKMVt/72QO7gSGEgtalqtLbpOReS0laRh3HEoPtNFvcZH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng/SFI2fjNQU0gz1Xb8wc5fZqC+6WHXpMZ5LcXGCX3E=;
 b=GvfnG/lUOtKlRKWuzeS8a160yRxqnMC1XAigSWw8LYGX6NA78eXVq4UAHskbCxbqNI/aR+UBQwW0MCt6aw0oWL13s82Q8l2r6nJRzPwUvpYN2I//NFKcRecMQM07bcVMm324MwAs5B0iBkyu7+m/KpQQT6q3k/AtRAW+jcBpI0n5LEXOvyUFhEXPQWWV+Tb+0VcfUz/vuwPVnIxw+elTnokUZIy2HchwLaKXblmCVAfYSr3BA0V5kz2bVoqB//vJC4JiWVkBbSJLc4NewRKh0YvK/tB/VGVfSvs06cTU1IMQ+ZKZjSq+zkzWMNIKqbNoybJY3Ftfcr7T8CZmv/1tzw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 17:19:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 17:19:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V4] nvme-tcp: teardown circular lockng fixes
Thread-Topic: [PATCH V4] nvme-tcp: teardown circular lockng fixes
Thread-Index: AQHcy2lYHvHTSt0IMUeLinhlzzOA5rXdPICA
Date: Mon, 13 Apr 2026 17:19:19 +0000
Message-ID: <c351eabc-c7bb-4755-872b-3330b235f0c3@nvidia.com>
References: <20260413171628.6204-1-kch@nvidia.com>
In-Reply-To: <20260413171628.6204-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6548:EE_
x-ms-office365-filtering-correlation-id: bcbb0c62-ed8b-494f-72b3-08de9980cc7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: agCv2UeRh6N1pkgQkJZwXC5YiAYVjhLpclMRou/UWbI1WQSN5gOTUKotKfuL4RZK2jBAQ+KVHBv+hQDzoRK+GKjD58mKHe9quoPfB+hONNsun9p1JaZRDGO6ZqyxmoD+hWX3P81gvmg2XNTkeTI1NVvAxzH/B2YPLYJvAu0rGUgYKLcFpgLNAJzogavH++ErMU3Ao1P3YYBc8U+QH2OLMq9PTC2ySIQS1p6kacXJBJw3znCrnsHVbvwlzN/+F8CUsg4Tl9svNa87EUqevoRC33PEugOlhGILC1Y6RZHGY1i9qn4z4OyLJ5jnRl0F54E+L0UHmsl7k7c7r3zDDNF4s/8Z28L8NW5M3jX9J+3hXU34rJyFJ1FzKtiBFoaegScGzzkVuo9QV5Bsn00k28jqd7PbVjtXfDmvMneVBJRnKgNkfAK8CCHG7894XPncDMrUl1Dw6FX52JX+5XPU4He6wevxaC31LZMSU8HVWJBt8QErRkrQgwYfXVGue1Mqfe9KXga6T1aDSxjYHY34O1ybaRRjsWiswaWEsU7tJv83ALR9gCULDsbH+mMs/n8ep5q0mNUmrkLVsndNcNG4owQzTthc48y3Y6HHj/s2fxI8ou/SZkbiKx1Hz79KoXKQkTWUKus2ejk2+oQ+1B1YzEs8cy/m1oM6itKjzo0qGeng0RtEBK5wMsXzT//ifUqjX2xwbxzVsepi0eS6BezIB4y1po9G3TQlSFmR9Cowf36AjTyuKUo2b5bbIx+OKosQnu3vJYGOXf2H8r4WqLR2TfB9C/hMLPJhrxqn9g7PTqw24DA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTVSeVllQ05oQWRKaGlyL2w0M25CeDE3UEpFUUEwaUxoREY2TVo3YmhiRE1D?=
 =?utf-8?B?cU5BRU80Z0NIY1cxSVp4UnV6b3M3eTVZUWFTMGZpeGpsMUFySC91VGVKWllU?=
 =?utf-8?B?RkxXOGNhUk1jQlJoNmI5b2JpM1JpMHFJZ1VEME5yZjVGSVY3bnJoUmlnUml0?=
 =?utf-8?B?bDB1NnhMTTBqQjF6dTgrcFQ1Y1NjakJxYzhoZnIrcU1vR0RWakRuU2NPSTFC?=
 =?utf-8?B?ZGV0L1pWd0JhQU16SDFwMVg4WXN2bXdjR1BYRlBSQmRoVkFPTVdpTkJLMTVp?=
 =?utf-8?B?SndSRlhsaTBxS3NQdlZnWGpvTnM3bG53ejBwRkFwMXpZWjVvNS9ZVkJkaGQw?=
 =?utf-8?B?bUJVOEdFREtrVVdERXNSdXFxQko4dUZjTFlNTTNFWVFqc1RYTzloY0dLcmsr?=
 =?utf-8?B?NGJxVktuZXI4aDNFQ1Jza1huVWplQ3JMYm81TERvR2VrTEFOMTlnWjQyaGRt?=
 =?utf-8?B?MVdFb2xPTVp2RFhYb0xSWEh6RmVtVXkxN0NCU0JuSkd4MHlRQUtDY0YrZ1RQ?=
 =?utf-8?B?VDFMWkFJR1dVeDEwdkdpbW42cVVVZ3hBQWxXN3p2WTlKWHE4cU1RZlc0c1dF?=
 =?utf-8?B?ZVVUcjN3TTFVV0Z6MEp2eklMb2xoSm94eG90TFUrbVJBU1ZhL1lpLzAwWTFt?=
 =?utf-8?B?dXVtbmVYT3E3VFZaeUQvRXh6Y0h5SmdlakRGMFNzTnlwYTNMZlUyaiszV3B6?=
 =?utf-8?B?ZWl1dTBoZU5sd282Nm9DVkN5blVHNFkzUjZMMGVtaDlBbUxuNU1lMnE5WmRi?=
 =?utf-8?B?Zk1rSk5KazBFVVJVQzlIT0g1dFVyVE1TRGhnWEY2Q2NVK2d1enQwVDR5MStl?=
 =?utf-8?B?bGdlc3ZsWmFmWFREOHVQVUZGVURWRE82K1FVTTM1QnpJcnlHK25TVERwdEF2?=
 =?utf-8?B?NnI0bGlJalkyS01oNytJQmd3WGtxQTFzeERwUGRMVDFOSGZqUEFtL3dYcHRl?=
 =?utf-8?B?WU9JeDQ3VFBsMGZYZjgvb2tjNHhsZENoQXJ5NDllNkJHVGRpWkNDWWJtRUJs?=
 =?utf-8?B?M01SbzU2M3lqcTNJb3dkRVkvUFplVWZHSTE2dnBtMHZlbnlIeEpLR2M1eG1z?=
 =?utf-8?B?clpTcWZ2UjBicElFVFNMRzF2eks5ZDU5akpkU0l3LzRwN1ptOGRTMDZwQmU4?=
 =?utf-8?B?bDV3OWpjSWJudTdhOW9RUEVrZkJKTjhrcWlDQ3QzbmRib2ZqeDRtdDJYSFRj?=
 =?utf-8?B?T081UXZBeEdOUVJmaWwzZTRSVWpYemFvb0NRaWk4KzBZa0xGNDhna3BYRFhn?=
 =?utf-8?B?cGtYM3NDOGxLOTJ6T2lLbWJrOVFXMWJLN3NnU1ladmRYc05Ua2MwQitYYTNr?=
 =?utf-8?B?SzBidHFYTVFCUWpjQXlPZlRwMk4vcTVEZXllTFBpUUdOU2dabVkxMC8rTzNh?=
 =?utf-8?B?TFhYUWNCSFlXUk1PdHpLa2tZcDlrblhHUUhoNlRhMERZYUdCSXpycFJCbThC?=
 =?utf-8?B?TFpQVzduUWlHYVZzYXJFSzZBcC9TR29VS0lMMURPZk91M2xRRHBxckx6WHNT?=
 =?utf-8?B?N1hFUll5cEZ1TmIzcGlDY0ZQMjBKWGxNUXVTYnJiSjgyam1LMmVjN2lkaEZ0?=
 =?utf-8?B?ZDdWOFpySjFDeWpiNGxrN2NmUWVqNTl4MGg4RVJEZTJaZ0x3dVcxOGIwbDZa?=
 =?utf-8?B?bG9mV2JsL0JtdzR0aExpMjl2ak0rTDB3WFJCb1ZmeW5wOGtkK3I1VFlNSERy?=
 =?utf-8?B?TTQvRC9LalVITmxvOWtKM0QvZEExYUdFVElMejFUNEIreTlIVGdUUWpNWFp1?=
 =?utf-8?B?cFErSnV6UVRidlM3U2Y3MERiOWg4NURkU0M2YXhONno2R2ZSNDVwNm1PeDhh?=
 =?utf-8?B?SlQ1Q0pENmZtTFQ2V04vQkVTVmZveHZtT2ovYWp6Mys0K2pXY1FUbDRLNDBR?=
 =?utf-8?B?dHJhcnVpU2tHSEVwcnd6RVJ5dUMzbzBPdVlQdjVDRmJONlllbzN6SjNhZi9t?=
 =?utf-8?B?L05HOFBBV1htcjBjbUg4Z2dvVWo3Z2krZ3gvRVRQOUp4dEhhSmZlOUd6MjJ3?=
 =?utf-8?B?Z3N4aEZRUERYQlZzOW81SW1nbVIwSDlKSDJnUVJhUHBybmJhU2tQbzZ6UGlD?=
 =?utf-8?B?Y0NreTY3VjJ6aTZlOElab1RIdlNLVzhNODhOMDJQTVZrNTdmaXk0SmY0Yk83?=
 =?utf-8?B?VUM3emFwaWhUR01qYWpyeWRxOE00ZlZyMXZLQW0wWHBZK0VNOWR5OGcvZVhp?=
 =?utf-8?B?NHMwb0hqa3JDa1JQNVAwTndUdG5SNXBYUlNOdmJubjhiK0huZHg0VUFVZEtn?=
 =?utf-8?B?L3p3RjltUmhsNkY2dTcwN2pGc0ovUm1EMG5SdWd3aUpHSFRRTlJJYjhzSDhW?=
 =?utf-8?B?OTJmOUt6aXhqR3g4VGcyc1dZYURvaUo5RUxlcUZYRlVkSXovNk1Najl3T2hM?=
 =?utf-8?Q?BZOhCjEMTfThyPZKEHUZxfVEM2ekY2SS0F0XDpDoXdTeO?=
x-ms-exchange-antispam-messagedata-1: Fpkl3gJJAeDsWw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFBE533235376E4BB7E796C996C6568E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbb0c62-ed8b-494f-72b3-08de9980cc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 17:19:19.8228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybVPHig3whRzVA7Vh61m6zGzKjo0ZX6fsVbptJcpjiH94/dxa6VPqU44H7ThO3INikHYQKopH+42MPDE/phzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_101933_376878_EC1FD623 
X-CRM114-Status: GOOD (  14.45  )
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

T24gNC8xMy8yNiAxMDoxNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBXaGVuIGEgY29u
dHJvbGxlciByZXNldCBpcyB0cmlnZ2VyZWQgdmlhIHN5c2ZzIChieSB3cml0aW5nIHRvDQo+IC9z
eXMvY2xhc3MvbnZtZS88bnZtZWRldj4vcmVzZXRfY29udHJvbGxlciksIHRoZSByZXNldCB3b3Jr
IHRlYXJzIGRvd24NCj4gYW5kIHJlLWVzdGFibGlzaGVzIGFsbCBxdWV1ZXMuIFRoZSBzb2NrZXQg
cmVsZWFzZSB1c2luZyBmcHV0KCkgZGVmZXJzDQo+IHRoZSBhY3R1YWwgY2xlYW51cCB0byB0YXNr
X3dvcmsgZGVsYXllZF9mcHV0IHdvcmtxdWV1ZS4gVGhpcyBkZWZlcnJlZA0KPiBjbGVhbnVwIGNh
biByYWNlIHdpdGggdGhlIHN1YnNlcXVlbnQgcXVldWUgcmUtYWxsb2NhdGlvbiBkdXJpbmcgcmVz
ZXQsDQo+IHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gdXNlLWFmdGVyLWZyZWUgb3IgcmVzb3VyY2Ug
Y29uZmxpY3RzLg0KPg0KPiBSZXBsYWNlIGZwdXQoKSB3aXRoIF9fZnB1dF9zeW5jKCkgdG8gZW5z
dXJlIHN5bmNocm9ub3VzIHNvY2tldCByZWxlYXNlLA0KPiBndWFyYW50ZWVpbmcgdGhhdCBhbGwg
c29ja2V0IHJlc291cmNlcyBhcmUgZnVsbHkgY2xlYW5lZCB1cCBiZWZvcmUgdGhlDQo+IGZ1bmN0
aW9uIHJldHVybnMuIFRoaXMgcHJldmVudHMgcmFjZXMgZHVyaW5nIGNvbnRyb2xsZXIgcmVzZXQg
d2hlcmUNCj4gbmV3IHF1ZXVlIHNldHVwIG1heSBiZWdpbiBiZWZvcmUgdGhlIG9sZCBzb2NrZXQg
aXMgZnVsbHkgcmVsZWFzZWQuDQo+DQo+ICogQ2FsbCBjaGFpbiBkdXJpbmcgcmVzZXQ6DQo+ICAg
IG52bWVfcmVzZXRfY3RybF93b3JrKCkNCj4gICAgICAtPiBudm1lX3RjcF90ZWFyZG93bl9jdHJs
KCkNCj4gICAgICAgIC0+IG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVlcygpDQo+ICAgICAgICAg
IC0+IG52bWVfdGNwX2ZyZWVfaW9fcXVldWVzKCkNCj4gICAgICAgICAgICAtPiBudm1lX3RjcF9m
cmVlX3F1ZXVlKCkgICAgICAgPC0tIGZwdXQoKSAtPiBfX2ZwdXRfc3luYygpDQo+ICAgICAgICAt
PiBudm1lX3RjcF90ZWFyZG93bl9hZG1pbl9xdWV1ZSgpDQo+ICAgICAgICAgIC0+IG52bWVfdGNw
X2ZyZWVfYWRtaW5fcXVldWUoKQ0KPiAgICAgICAgICAgIC0+IG52bWVfdGNwX2ZyZWVfcXVldWUo
KSAgICAgICA8LS0gZnB1dCgpIC0+IF9fZnB1dF9zeW5jKCkNCj4gICAgICAtPiBudm1lX3RjcF9z
ZXR1cF9jdHJsKCkgICAgICAgICAgICAgPC0tIHJhY2Ugd2l0aCBkZWZlcnJlZCBmcHV0DQo+DQo+
IG1lbWFsbG9jX25vcmVjbGFpbV9zYXZlKCkgc2V0cyBQRl9NRU1BTExPQyB3aGljaCBpcyBpbnRl
bmRlZCBmb3IgdGFza3MNCj4gcGVyZm9ybWluZyBtZW1vcnkgcmVjbGFpbSB3b3JrIHRoYXQgbmVl
ZCByZXNlcnZlIGFjY2Vzcy4gV2hpbGUgUEZfTUVNQUxMT0MNCj4gcHJldmVudHMgdGhlIHRhc2sg
ZnJvbSBlbnRlcmluZyBkaXJlY3QgcmVjbGFpbSAoY2F1c2luZyBfX25lZWRfcmVjbGFpbSgpIHRv
DQo+IHJldHVybiBmYWxzZSksIGl0IGRvZXMgbm90IHN0cmlwIF9fR0ZQX0lPIGZyb20gZ2ZwIGZs
YWdzLiBUaGUgYWxsb2NhdG9yIGNhbg0KPiB0aGVyZWZvcmUgc3RpbGwgdHJpZ2dlciB3cml0ZWJh
Y2sgSS9PIHdoZW4gX19HRlBfSU8gcmVtYWlucyBzZXQsIHdoaWNoIGlzDQo+IHVuc2FmZSB3aGVu
IHRoZSBjYWxsZXIgaG9sZHMgYmxvY2sgbGF5ZXIgbG9ja3MuDQo+DQo+IFN3aXRjaCB0byBtZW1h
bGxvY19ub2lvX3NhdmUoKSB3aGljaCBzZXRzIFBGX01FTUFMTE9DX05PSU8uIFRoaXMgY2F1c2Vz
DQo+IGN1cnJlbnRfZ2ZwX2NvbnRleHQoKSB0byBzdHJpcCBfX0dGUF9JT3xfX0dGUF9GUyBmcm9t
IGV2ZXJ5IGFsbG9jYXRpb24gaW4NCj4gdGhlIHNjb3BlLCBtYWtpbmcgaXQgc2FmZSB0byBhbGxv
Y2F0ZSBtZW1vcnkgd2hpbGUgaG9sZGluZyBlbGV2YXRvcl9sb2NrIGFuZA0KPiBzZXQtPnNyY3Uu
DQoNCklmIHRoaXMgaXMgYWxyZWFkeSBtZXJnZWQgaW4gdGhlIHJlcG8gcGxlYXNlIGlnbm9yZSBJ
IGRpZG4ndCBmaW5kIGl0DQppbiBteSBsaW51eC1udm1lIHJlcG8uDQoNCi1jaw0KDQoNCg==

