Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C8E6C600
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 05:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVlAs5cqDwbiTBWhHEiM/pSM77+IHzuGsX3g5H+IloM=; b=JOuCy7DFmtZfm7rDSxNvh+Mgep
	k6bkxCyO7xRmjtnGVsoVXXsnY/DpEKGwg8i8tk47rhV6s38Zkwfvc7bQM6p1jnDyLAP+iJfUXq+k1
	UlOA4GuOHPudDpFiVDEGjXr9TwATS3zupBU0wqtgwJ9QOQZWri9C2KbGYkQA5omxph1GK81NYodnu
	f3rHZHXlAcwyKZwUQvKBYL3zHUjij7mZw3l1db3nfqAC7MN+ERaw1Q3JbEUf7syoxWzfETrY97XFq
	P+k+sE1CA1qdSBz6IyzhzV5AckwbKewZteVorPPqzt9KF8S2rEHypBNfUwgAYdFfGhjTWeZG9NlAz
	dad53udg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIL1V-00000008Ggx-2kk8;
	Tue, 03 Dec 2024 05:00:33 +0000
Received: from mail-dm6nam10on2062c.outbound.protection.outlook.com ([2a01:111:f403:2413::62c] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIL1S-00000008Gg4-29zu
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 05:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+LEnh8dIvhMLe3vBozR0J5Cbzej3qOyraEUZMI1w0jG5xrH0ea+hc5HcCBYL8FrNib416q/2HE2oTC25oLEl1+pyJYycXkXmoMtJI24T6CJZNOPhoG7wRB4M2YE18SFqm83IX3c7VgBlKhPaWq0qAXU7s2FdrdAz/4YM9oF2Nemel1C/A1JdHJUsqRETTJAnSTwoAQtBjHcM/A2E+9cxPzmaMT6DLYvblTRZM8hbQGM+bH/oUOXtE1MNRZU4fR3dXixKU3iXc8SjG6IXkSQQsUN2ChCfojhs4ZdK8qEDDNQ0j5HmnHGMxEOsHjdDV3gpIaUpvBlu9fhtqTuvW53Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVlAs5cqDwbiTBWhHEiM/pSM77+IHzuGsX3g5H+IloM=;
 b=yHnDLT7gNBewJQqPeBwczb+8xIUf2+DeSYzVRtxYx+uXMLm4F5QSZJwvNUCqMF7xMRqP/LhGRFaY4zJi4nc+HohZmoHsk+B8QRh+LnYDnwNWtWDKGPPV07bccQvZypr0apqpX5Bg8JXmhBJMbhDM5gyn9Cx/Pepl1MgzXzk1CPiW8cKCHCxYqOql126vAg3EUhR5VLSJhj9zWxLUVE2UgCLU/18S9pTbc3bFjHGdKBwHoNzGOg0oTzXqHcDBGEV3J1dG234U7UrRqShrTQNmg6c614VLsJ2YR8CcXPd33GuoNI+TDy9onJhSkv+LY02qn5Y9i1SFKMNw8S6TSNJOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVlAs5cqDwbiTBWhHEiM/pSM77+IHzuGsX3g5H+IloM=;
 b=MacHUmS7fqt1G+rgiGhuqDwjGWpp0toZUsFMx+IRYDDi3u69Stay4gDy3fRGrH72HszTbbjQ7PzrHf1tguDRaucycwfoZCAEZkilAC1Tj/9Vo5ZQoSdBCUESTD5y13/Rra17BH3QhRwNVnRnzCqQxR8fXrxnsOPNKErTI+AC+u8CmdalVzoUgwpk0AK1U0EURJQppGgw75l6IAbxj1nvOmyZ/XFX7Bcx9uTTKywl8KluuvuTYUmv0nXT1QTU0Ov6m3B7NYlKwibN0VfLumrtzYQ11hZUWyTyfYuB3aT6lSIuzrxyorcPiHYfCeIs9PRA9McloPADUFyPcEwa8Gem5Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 05:00:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 05:00:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 7/7] test/nvme: add test for rapid namespace
 remapping
Thread-Topic: [PATCH blktests 7/7] test/nvme: add test for rapid namespace
 remapping
Thread-Index: AQHbQmJZou77zNVE1k+JKOTKhCd7nLLT+8KA
Date: Tue, 3 Dec 2024 05:00:26 +0000
Message-ID: <016a9dda-b660-4ffe-b84f-1a9cefdb555d@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-8-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-8-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 1f819cb2-138b-44f5-24d2-08dd1357669b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWowSEtOajlKN3pEUFN0aU1MZGYwbVN4QmFJbW1NSHZ1dzdhRVZzK0g0elY1?=
 =?utf-8?B?SXNyL2U4eW14ZXFmblVHdGZoZWwycHVVb0E2a3M1R2htY2FCWXZuTmZBaEFQ?=
 =?utf-8?B?TmpNckZFUXpzUkdXMkhMUi83V212THhheHI1R3BPaFJDbEVPNFYxQ2haSnB2?=
 =?utf-8?B?NnM4bHVPTlovUFFLcU84UTNXOEVNZkZYbURNWXVVOVQzaEcwMFhnOXlDTEtr?=
 =?utf-8?B?bzB0SERLc1l1andSVGw1c1RsKzJEZk9aN014dFhNUWJMakdjYWtSN1J1MjFU?=
 =?utf-8?B?MWNiR1lraDk3NnFsNGg1ZUl1NGYwYXlkSEJMendSRGkxc2g2R2JYSWNEMUpT?=
 =?utf-8?B?RGdkNzA5UWlLMDZLMzFEUkZGNEVYVXdnd3VUdzRvQ1dBellpN09CSG9DS0V0?=
 =?utf-8?B?Z0NiZ1A3SGlnaHYwYy9INS9mWjR6Z29QRVQwS04vRmhaNWVIT3Z1WE1PbHlG?=
 =?utf-8?B?N1NKVnZmUjJ5Mjg1ajNHZ2VTRTllU09Vb1lWZWpMOFFNbzc0b3VaMlZQeFo3?=
 =?utf-8?B?UzljNkxTS0w2aUgvRldwUm5aell3OG9GZnh2WFFLaEdHVHNLYTVuTFZyRTBS?=
 =?utf-8?B?c052SUZxYk9sRkdELzlJQlNLZDN4TGFDWTBaUytrSW9acE5vTkJla3hqZGpl?=
 =?utf-8?B?cTFZYnRJUStES0Q4UFhVcWVSMjgzRDJKU1NVaE82aTN0N2l1cjdoQkN1eEEw?=
 =?utf-8?B?Mk9TbjFDWXF3T1hseTdXNVVWTjQwRlB0NUhpancyYWhHUTgzbFJSN3h0Ny9U?=
 =?utf-8?B?QkRHV0orSklEbXdpWkUwM3JXYVZKWUllZk1qRzdsNnBidzhNVHpsdFZ1eUd1?=
 =?utf-8?B?bEY3WVRHRWRlRit6d2l2MkJJZTdQQjdjRGRPaTlFZDA3TzBPMTg0SHVoTi8z?=
 =?utf-8?B?RTh4M3Y3ZmYyVHVoM3N6ZnZlOXY2czdlbmVaMW8zTHVRWWVaN3JFZXh2TFAv?=
 =?utf-8?B?SkE2ZjYrRGR3V3R5SExobnlaNTJENHhYaTRCTjRGSmhyRG9WbTc0dlFVYllq?=
 =?utf-8?B?OWlUcE9jSTRxenFOam1LUVNIdlBucEowaFFWcFhXZGwxMWZEakQyNjY3MmJ2?=
 =?utf-8?B?Wk01b3JoV3JyRW4zeVdENFNYbmNtV1lxeERYdUMybDQ4eVFyaXUrd0FSRlN1?=
 =?utf-8?B?ZGZPZytmTEpEaHZyYklYdjAyaGx2a3Z2MDdsVWpNdlI0UjZYOURFclFMOFFr?=
 =?utf-8?B?OVVGNkhORmswYmI2MDRxYldtT2duMWFjVVRyMWRTV1kwOFpKSG5IZzBpRG5Q?=
 =?utf-8?B?bjNPdGRxc0lqWENRazFCbGVpRTFoem1hZUZ6ZzIyR2hsbFFwajh5dXYxWHNy?=
 =?utf-8?B?YU5odlRlU0dvemNlNnQ5RGoxK1lPd0J4SW03YlE4c01FU3FRT1JGc2tCeFRl?=
 =?utf-8?B?QnU0QW1KekFFM0VXR0ZMb1ZEM0xrMGpKcGw2MVptcG9wWWQrbnZLL1E4c1NL?=
 =?utf-8?B?eFV0Y2E2YTEzT3lwNEFKd0RzMEI5Lys5c0c2c1V4bUdWcFBmcEM4dS92cVVK?=
 =?utf-8?B?ZENmaXRvek9QSWFuZlEwMDdzYkJvY2dBMm9IdlFEYUt2NEx1djNuWUNjU1lX?=
 =?utf-8?B?ZlVjRVpmN2puR1J2MExxN0pkM3RNVWVzbm1qNzE5WmJXK09QdzgzYjd5aTBp?=
 =?utf-8?B?ajlsMCtFQTRtWVI5bHJKeWUvVERHUnhmTUVtbGk3S3MycUlaS3BBZFBZY1pz?=
 =?utf-8?B?T09aN0tVYnZoWG40TlBsNCtKRHlCdS9GRGtkSjZubkdLa2dvYWlEVSttK0FG?=
 =?utf-8?B?eWt4MWpidUd1QnJmN3A1bkk3Qkt1Wm0zRUZncmdHQ1hyUy9pc1FVRlBzRWFs?=
 =?utf-8?B?TFJCREdFT3dnQStUTGphRytWL1JUc3hWZVBTUXd2S25rNjBLSktEcDduMWRS?=
 =?utf-8?B?UXdNSXErOVFwY3ZJK0VMZDB5cVpZNU1oTmFGZVJsM2U0a0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JZR2ZJbENSckpYS29XaEdmSTR4YlI5WEJuWlowR1lERTl3b1oxTEt1RjNa?=
 =?utf-8?B?Y3ZLV3Nxc3I2cUtONjd6aUZaU280L2l5ckFTWnVJMjg5ZWJOaW9POXcwbEQz?=
 =?utf-8?B?K09PTFczalJnTW52cWFwaEZpdDBMV1Q4WFQ1MnpKZzF3S21SL0pkR3kxeGhp?=
 =?utf-8?B?dEZBNjJDL0JnM2dCZ2tsRmtEQTVUaFZZdGg1dExmWXdmYktUc0h6d1VtN3RL?=
 =?utf-8?B?bUJRZlg5WjJHamRIcVUxTmpYSTNoNjB5MWNEY3hVYUNzdzU1SW44TUlFWXV5?=
 =?utf-8?B?QVJDSGw4YmIvVHZxOEU2VXhyY0lweVk1aWovbEp1OFZOdERPdDZLU1ZHbDBj?=
 =?utf-8?B?VGFBYXM1L29kK0RaVW8vcThnOWFnZXVXd1JVSTZ2dCtSWmtRVDFaK1ljS2wx?=
 =?utf-8?B?ekpDUmszbkNHSnZCaVpsMUFEQkdtY3FzbWVPR3lJS0pVYlRQVkdwd1pCenBV?=
 =?utf-8?B?QXdqdjlMMERzZ0JiL3lSOHh4U2pWS1YzL21CZWM2Nk1YUkpnKytDYUljamdG?=
 =?utf-8?B?aUxNdWx3SjdGM1dWQjArK0NWU0g0UFFKVExnaUNPMzhhQThpckErY1BqRmhC?=
 =?utf-8?B?RWtmR2p2dUFsWmNaelhVZHExSnBMN1o3Ky9DT0VEZ0pWQXNzcythbkppWVov?=
 =?utf-8?B?bG1uWDJET0dUY0p1UU5XNWRmTEhWZmFTdHBlOG5NYjJnMXAzbXFWTTNGZHdX?=
 =?utf-8?B?eHZoeng1bVJ3ZnFYd3pNdWdsSXVsaUFxbWQvcUpqSEFZQ05HekFaeGtpeWNC?=
 =?utf-8?B?L2Z1bjZWdFpwQUpEbkY5d3R0RmM0ZzJNMyt6WVdEdk9DVXZoS1lFdDJndjFD?=
 =?utf-8?B?ZDllOXhSajNsYXhaaDM1TXE0QXl6b2REd0RNTHQzNTNjUVNjNlJnNlJLeUx2?=
 =?utf-8?B?MFdleWtGSHN0dFZkZnh4Qm1LaDF4cU52YllsZ1FCME9QS08rODA4Q1V6dlJy?=
 =?utf-8?B?MTFUSzhHWmtDeFUyUEhsU0dIcDY1QmNWYUltS3VuSXZudXJkOW1jQTM0ditF?=
 =?utf-8?B?VmxlVzQ3QUE0cVBnOXFYVWZyRjNFSld4bks1ZFZUTW5vUVhRUE4xZ0hEdzRW?=
 =?utf-8?B?WnNrUVJEVm1qMDdCN1VuS2E5c1o5Q3AxamJYRnBxL0pZNlhmSldRWU9tVkNz?=
 =?utf-8?B?cGl0dk1SVlJJUXF4Vy9ZVnRkQXV0bVFyeWhleHEwc2xEWEtOanJLOFdZYW1K?=
 =?utf-8?B?UmE0cGVNbEJYamNnNjJranF0UnVKYTVhc0Fwb0xUeldNNlVJM0E1Y0w3TkhE?=
 =?utf-8?B?RTNRVG80Y3VMNUZBRFVqY3QzekpzUEkxa2oydU4wb2JBSFh6c28zWHEvVVc4?=
 =?utf-8?B?TFQ3TUtlSVlHZkN2bjZmTkRwVGhiYU0wQTd1NzlaUHIySFJ3Z0N4S2NES1N5?=
 =?utf-8?B?OCtkRTZpdEw3Q1Q5TFNIZDhmbnBnYVZocWVBK0Zkc2pTWk1GelVGdkl6UlhL?=
 =?utf-8?B?NHVJYVZieHhFM1FhUUpxcTRCMGJmNDhoazNWMDV5NUJROUZ5emk2YWtFMFk5?=
 =?utf-8?B?UWMyQ2EwQ29FdHh1dE9wZVV0SGRwcFVWWldFMGxDRkdmeHJoblV6N3F3OEh4?=
 =?utf-8?B?OHhuMUl2U0NuQXd3VENpNnJoZ3RYRmgwcU5tdDFUVlBmOHRUZnZYRTFPaXJF?=
 =?utf-8?B?aHVoTVpyVTBnVEJrUmp1dWdSRjlJTHlyUzd1MGE4T1lZUXo4bmcwYnB6d1Y3?=
 =?utf-8?B?a0hkL2pRM054a2ErbmtMTFdOSGEva0xUd1ZrSkx1SmpGZ0dkZDRsVXBxYUFB?=
 =?utf-8?B?YUJZZUpGVElUeDdyYnV4TlNLdVZqdzFHVkM2NWhGK3ZtV1pZRGxKd0NXckdV?=
 =?utf-8?B?NXpxOEtWVkNaMUkvZ0Zsc2h4eXRONFpWdlR0N1Nvb3RyTnA1d0RtaEk1aXd3?=
 =?utf-8?B?QVlZSkVEYXFJY0pGV0VENXpPNzJCSWszcEtMdS82SzBFZi82TTI0aS9RNDM0?=
 =?utf-8?B?R2xhZzF6SkxyKzd1YWNFUmNpbVZLbWdqQi9nL3dXWldZdGN5cmE0ZE13M09N?=
 =?utf-8?B?bzhSMjZoaks4VklUbE5iN3p3R0hnK1MrS1RCZHJab1hKcHY0VW1uSVA2WVpY?=
 =?utf-8?B?bkR4bGdnTWYzTktuUkRaaCs4aGZsdVk1TlkyOXFCblpMUjllSjIvY1RObE1w?=
 =?utf-8?B?SEM4Z1pKSzBiYXRtcU9qTEhaNTRNZEZDQlB0MFdJc3o3WERUU1N1aEdHVy9a?=
 =?utf-8?Q?o65SqHEkkV98A0J3E5YrcA1nwOO2g3mBB9i9Syrtvb0O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDF2484728184B48B65FB43B8DF07012@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f819cb2-138b-44f5-24d2-08dd1357669b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 05:00:26.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3noTAyjSPpEkgoJmgD2V1OzsVAiLm1Gxnzz8AOEbxcu9p1DeP5gQr/1iWAbFAB/exexfm5nqxH5ZfcyfJVWQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_210030_551008_4FD8BE0E 
X-CRM114-Status: UNSURE (   9.04  )
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBBZGQgYSB0ZXN0IGZvciByYXBpZCBu
YW1lc3BhY2UgcmVtYXBwaW5nIHRvIHNpbXVsYXRlIHNob3J0LWxpdmVkDQo+IG5hbWVzcGFjZXMg
YmVpbmcgY3JlYXRlZCBhbmQgZGVsZXRlZCBpbiByYXBpZCBzdWNjZXNzaW9uIHdpdGggYQ0KPiBj
bHVzdGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRl
Pg0KPiBbU2hpbidpY2hpcm86IHJlbnVtYmVyZWQgdGhlIHRlc3QgY2FzZSBmcm9tIDA1NSB0byAw
NTZdDQo+IFtTaGluJ2ljaGlybzogdXNlIGZvciBsb29wIGluc3RlYWQgb2Ygc2VxIHBlciBzdHls
ZSBndWlkZWxpbmVdDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5p
Y2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

