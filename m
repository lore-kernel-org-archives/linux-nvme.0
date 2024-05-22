Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C1C25B74
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 00:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YWFHW3mhkKaiWmohiSIi2r5uoMNVI0fDqCjHJYLvrs=; b=m838pPV4lJdxYrghmVZtxRcaTl
	7gcLciJu+q75U16jLp7JPvVN/OKt0kxGndtMd2kvYJ+R7B+YoAjyxoHwn4MTo8j/BZPipm6uxVrKL
	dMJw1nhHnuRH0pRImnIT1V0W0kHzPn/jAdcLzjxPFoDcDTrP2dOvnqWwJIAKM1Q6EzS/8s4xE0N7f
	YFGn7PodJzzt0PxQburlVlCsrb6LvoIqEqFt0NM2YjDTjsECIwnAzdxTm0QMv3UWsfvJ7Lbqqq+ed
	z4h+ENzb6J0ukhDEahJodIaduddNRpVZZ4IH54visklAsbA0hE6MPB02QIa/8XMs7kaqGVJHOss54
	vb3qxJBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9aGm-00000001SfD-1oax;
	Wed, 22 May 2024 00:55:52 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9aGj-00000001SeM-2Mxd
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 00:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCtUT9yCMgpivUFOScE8E1+e/SvVrxcx0ef/V5JfQiIyqNThhPL8PvUI61lvkjShAevVtP+9wLNIlcGapHukV96ZTIN60O89I1idzbx5H5/1ZRJKibR1YuI6SxQuFL8akU0ze1SN9q56bjRsNKRykHDcEyQsqCJpT0SzTa78o6VgsLoM1dvlIy+enpUDv5r7UbzE8tW1NL38Zw0yjtY5scF4SOvHeo20kmHmLAbmsIbXg8rTa9Hqm+bdqJZOWz7nfLUGUiVjFd5ZvYecLbUfJBCRHKUTmi81/xpKuCv6HU5PBUGsFvb6cnv0y1K4wYR2ePXflnIYD545wUgpzlLyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YWFHW3mhkKaiWmohiSIi2r5uoMNVI0fDqCjHJYLvrs=;
 b=Cgl90hGHfIF5y8bp+BHm3aLcECNuDz9hxFukTNSdmWARb9foz1ZXxKYvtDZ5+uS1EllkKw/5OooOxtCQf18iup1ROljCQTtGC/N1wK940F98T09/rr8Z79N4KtuSG3jaXoTQkpvNnEKXxem3AAtaBnsDW2Tj3cpXloBgjqxeWtBxdZbI/+FwLJoHCGawHMJz7r3/QwK3ild4N/hnLz3adxm1/80VUbkvhG04HxkX87eeSM+150m6jqV+3b2CRa5zRpFmHWFgqD942H61TkRk/rIHXgqRpS1+/2cWQYmj0PqM/m0lksGfklgGqACAZHrRvNdPF64rqGP87RRTUbntWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YWFHW3mhkKaiWmohiSIi2r5uoMNVI0fDqCjHJYLvrs=;
 b=eqIEQ+SezJA04OK2RYSn+ukFjVytFN8DLQcr85XHDtJauZTjI27kn4iyCpm9t/MHqnkYLTils5At6tA5K0Zbw9ctIwIV617lezjoedK+6qSJWp5qqcZqcwPVZ1CfN9if8Kd50IIxDJ7Q21a5VbN9LaqPnlZZU7+1r238Ts70KvA6NAKlzk7a2V53d8i7V1jp0r2/M/A8TR9XEW64xSPWRN2QLFWZ8PbEDMdBvMN3YbVEwhaxAN5ogIXoAklQvpPVAupXmCk++6QQn1XlwKjhjWJc4O/HX362EcWeehbN4Wgk2872P3nh31jzatdY0aEqI3mWwOGwz6Mlo8V8ftDYyg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Wed, 22 May
 2024 00:55:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 00:55:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix multipath batched completion accounting
Thread-Topic: [PATCH] nvme: fix multipath batched completion accounting
Thread-Index: AQHaq6E90eLqF4MAPE+ftb6NfcXu1bGibkaA
Date: Wed, 22 May 2024 00:55:41 +0000
Message-ID: <07104aea-e149-48b0-860c-cfb871a7db41@nvidia.com>
References: <20240521170537.2029233-1-kbusch@meta.com>
In-Reply-To: <20240521170537.2029233-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7222:EE_
x-ms-office365-filtering-correlation-id: 5200a9a8-93c8-434d-e414-08dc79f9e782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bVhNNUNmK3VxVEZoaG11NWJESjR4RE1KMDQ3ckwvZ2hXSnExc0FIQnB5VUZH?=
 =?utf-8?B?dFpDbXkxb2s4eDk4bXVDQTlsU1ZxLyszNU1WNkF0ZFpYOTJGSTVzTWYwcXFh?=
 =?utf-8?B?Rk0rNGtORVpsRzJDeU5RVGtveGZwZk9IUVh6SnRmbWdtVDlHV2dJcGVhNnR0?=
 =?utf-8?B?TlNZUTB6MEduSTFQTHkyK3g1bDdHQ1BHUW9QUGlQaDZObUV0WkRMVENTOSth?=
 =?utf-8?B?VVIxTzR4TFBWdDNLUGtHZThzVkY5TDZmUFVEeHhWanNHVTQ4cDJvTUFLQ2Rh?=
 =?utf-8?B?S0JRREtHaXpnM1JwdlViVy9mVlFpVENTODVTNWw1a1ByTCt1UGIvWDIxdm5T?=
 =?utf-8?B?UVFra2UydnlYZG9kTlZlODJrVFNoamo5ZDJ0WEc4bVFhNTh6eUVMYURTRkRD?=
 =?utf-8?B?RDFrbUpPMlJoZnY3Z3ppOXh5M1ZEOFVZZXh2R2lQR0xXdGtsL3prMk9rNXJZ?=
 =?utf-8?B?aXA0S1V5dUR5STJ5T3JLa25TTTZiVHNHbm93alEyaFhuNFVHNjFrUTdJRWRZ?=
 =?utf-8?B?bHVzZGxsTHVrUzA5a3NFZ0t3MDdPbWEwZWVwWWQ1U1ZhM2RqY2RKc3hlckFR?=
 =?utf-8?B?Y0plVzdlUVVmZHg5VGlqeGFnNmovNm9USlBrV3dGVGRQbUVzYzhNWUVQYzJS?=
 =?utf-8?B?dnJydkk3MnRFL1JXa0g2N0FETE9DL0dxbnoveXZDQkg5QnZNSHZVcytxc1R1?=
 =?utf-8?B?WDRxdC82dk1ma2xkZ2VYNTNObms0SU1mYkNxK3VOWkxWT0p4d0dBT05vZnpN?=
 =?utf-8?B?MkVHZmFYeWhBdHpBR1loeUJ1aTZRWXhOT0VZQkRXL3puVmdFd2l5eGN5dnNB?=
 =?utf-8?B?ZjliNzAwelArUVpKcWg0a1pwWXJmQXVQM3FhWkJKYjk2bC9jMWMxRkxBYUE3?=
 =?utf-8?B?dXNranR4dlZCN2ZCSDRDeHFlcHl2bTA4WE5zUEk0MUQ0N1Zua1BDbU50am9w?=
 =?utf-8?B?VHQ2V1k2djhEV3ZTOW80T05EMVF6bm4zTW9PMVFVVWw4TWJ5eEFKVEFuTzZs?=
 =?utf-8?B?VEt4RUhCWUk0RnE5eVgyeGpXZFEwWjJUNjUydlJSaldWWWppcVZzcHo5WTV5?=
 =?utf-8?B?SkFlQnZMQmhzbGNaTkRwdXMycUZJdThjYVZ0Lzk2a09vWHlDNXZLVThIeTdJ?=
 =?utf-8?B?RXFNMEdMTmtGRGZLNm9RTE9VUnRySFlJSU9wczEvN01Pa01tQ29Hc2YwNzNw?=
 =?utf-8?B?NUZYVDJHaVFhZ2FUSGRRT2k4TUhNb0dUV2lYWkk3aThoUHV0RVlvU2VUc2ZZ?=
 =?utf-8?B?WHB4dTd0b3dWZGJjN29CeWdMZ3pzN0NweHg3T0gyOElBT1Y1cXlPU3FiR3or?=
 =?utf-8?B?VWhPalZLZmdra1FMamZwVnVCaDU1cmkwYWdqOFRMTUVyNnlyVmh3QUlVMndj?=
 =?utf-8?B?b1FrbjYwazlRV1Nldmx2THYzbWNTZkhFakkrWjlQVUdyUU14dS9WY3FNWUdQ?=
 =?utf-8?B?YndBN2E3dFdUbmVCTHAzWktpRjhtR0x6YlhnUWYxRlFrWEFONmNGWUFwNmlF?=
 =?utf-8?B?M05qM2JoNGxtMEN1M3U1ZVdhYmJ5eVBlcGNiSWllTjhxa3VQYTFnYkVFL0U3?=
 =?utf-8?B?dnMxQjJCbVlKRXVFTEtZUlZkMnZMdU9QTG5Ua09LN09HZk0wUGUvNkc0VnhT?=
 =?utf-8?B?VFEwNGVjQkc1NFRtV2ttWGZldStSc1hQRFUycEtUT01BLy9JNHhKTDM2UW1K?=
 =?utf-8?B?Vk1oZExOSFpQZFNyNmhuRllWS25KaFNJbUwzV0xnQVdiMURhdjMzc1k3SnJq?=
 =?utf-8?B?V2Q3TU5WbXdoT0lBaGwyT2pyd3Z0UGg2MG15Sjh2OUc5eEhlY3VXNGQ1eUF5?=
 =?utf-8?B?RVQzS3RoYTJmbVFKb1lQQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5zeUNDSkRMNWRwSHdkSVZZc2dkWDlYT0ZhSmRUU05IRlBCMFMxSC8xNTQ5?=
 =?utf-8?B?WDRhQmF2RDdTNjdMRDI2d0FwL0lNVjY3YThGMTZzZkNVN1F6YzhIVytVMVli?=
 =?utf-8?B?MGs2MEc3bHVaT0hZUGZMRUxEdDhINEhTRjE4MnkvU2VLYk9uSklzQTZBWEdP?=
 =?utf-8?B?TTNzTkZ5NW5vTjVhaVlsTnF6aDFsYlJXMjNtQzRJN1VFZktoT1NOVUdqbGds?=
 =?utf-8?B?ZGF4cFFNVEZtQlE1R0FGb0dtWCtUUG5NNTNPL2lWd3IrcW9sRktvVXpjejRu?=
 =?utf-8?B?MHl4MWxWSWI0SWVEcTZiTnY1bzZGZmM0RzRHWlJsVTlUWWRUVjdnTHFrSXpK?=
 =?utf-8?B?cEpOYThkYjhSUGt6VTlDd1JkSlljUzBMczBPUnRiS0pXK3NMNlIzZXVmNjVE?=
 =?utf-8?B?S0w0SXFIUnhEdzAvNU1KM3FGQ00zdEx6OXROeURZSUpkU0tqRS8wRDZVOTlC?=
 =?utf-8?B?M2lSblJGWUt5UnZ4UFNVYk15NzgvRWxpWU4zVEpCK2NWZHhyU2lSdzI4cGJB?=
 =?utf-8?B?RnV6MG9kQ3dLMDgzQ3ZybkIrcFhkN29kYVpHOGN1RlhQc3h3eThrZTlSeHI4?=
 =?utf-8?B?NGJmT1BHTFhOKzdwd0g5WEU0cmpnUWh2Y1ZFRjFBL0k0anhzREYycVZocWVJ?=
 =?utf-8?B?bkZkL2h3MFlIQVFuWUR0UFl3Q3B1bzdFQzQ5MlUyNmZCME1xdUJWeHg2OGls?=
 =?utf-8?B?b0hKYlZoNVVzcVRXRHdnN2pvOUE2OGM5U3RCem5TUk5MRlVyUERMMTZXcTh3?=
 =?utf-8?B?N0xvK2JpOXQyZ2UyZHFEazM2dnNFcEZzQm9XajNLQzNQVG1EZjVjMGFRcmdP?=
 =?utf-8?B?c3p5a3daNk5yUm9aKy9YeTZlODFUK3VFWXZIenltdUQzZVZmTXdnNEhsUjE1?=
 =?utf-8?B?a0o5STA1OWo0NkF3cTU3bVNOTTNiQUQ4WFFUUERNL3dxaGNqZ0lFeHhrOFo4?=
 =?utf-8?B?YUkvUmNvWmpRWXF2ZDlLODJDcThwaDBMR09GS0FqVUJOL2dmNlBPbk5KUGJX?=
 =?utf-8?B?d0cyZW5vVDdaNjNybkthUkFhZnpCdWY5RWtOOU01cmpuU3JzUDUvc1YyL3Bm?=
 =?utf-8?B?WWI5ZnBpZnl6SHJCenQwdWpidHlLNlEwcURJOGExSnRXYTFjS0VPQ085dlR0?=
 =?utf-8?B?Y2JjUVdjdlBkRGVYVU14Y2ZOS3dPY2l2RGZXVUE2SnRwZnRCODJrWUlFdXh4?=
 =?utf-8?B?dmJQcjJUUWtJQWhFOFR2a21wME5ORUUxQVdFcktGQ2ROcjJrTC9GRDN1TUxm?=
 =?utf-8?B?YnptcVpUTUZ2RThKcytPeWZldHNFRExEU09MbGMzSDZjcTd1QUNlSjlEUG5W?=
 =?utf-8?B?cG83VDZVR2VLQkxyVmZMUnJhUjRYWHU3L3Q0SC9CdWlDbzliM0xJTUFsZHRL?=
 =?utf-8?B?bTBNa2VmL3lNbnduZHh5SFhHaThobDdFbDFHUjh3OFBrNTJIeDRUeHkxTzBE?=
 =?utf-8?B?V2EzNldmbWhSZ2xoSkFZQzYvRTBidHhQN0RZUEk1dDdZVVJDMDFWUWM4QWdL?=
 =?utf-8?B?bU5kajhKSlg1d1BhWlBEdHpQVEpPNTd6RG5TTElGVVRIdWdWQUlxYTNKNmFw?=
 =?utf-8?B?VkhHall4STZhelZDcUJnSlZXRkQ1R0o5MlJhRXZ6emhBaWp1bXNIWXpuZy96?=
 =?utf-8?B?SUFGVFJkclQydy92czc1Rk1XeVV3UElwOVFzRDVWcW1pRm9LbzRzYWNiL09E?=
 =?utf-8?B?eVJBNFBBRittUW9hTjFFdnNVcU5PTlZGMHR6WHpHWTkwS3FTVDEvU2xsN2VY?=
 =?utf-8?B?TERZWXg2L2hOaTZJWUxHcXAxWnVPaXRpeVZSWHBjRWx1eE5UVklOSEcyUllt?=
 =?utf-8?B?cGJZQ2x2Tk5TM0tWWU5IL0hySzJ2ZG1ndmN1c1VpTDE4eXU3N1VFRGhPb1hV?=
 =?utf-8?B?OUNpek9kU0Fhb09rZXFFSHhraEpMTE5oQjluVE1iNEJ3YTEvVEdIOFE5QnVO?=
 =?utf-8?B?NkJWRHU3VHo5L3Y0YjA3eE5ZOTlvelYxc1RMUXRsbzl4SHo3bFBZMHFCTWZS?=
 =?utf-8?B?Qjh0YXVTbnpWMmJyNE9BT2o2eFZyQkpNZHhtM0RONnRnRERESkpuU3NFaWpO?=
 =?utf-8?B?azVVOUQ2MW5hcnpaT3J0eExYcWg5QmxIYjhHZ2dVMjNjSzFlN0Y1em5kVWli?=
 =?utf-8?B?SXpHNG4zNUFoYVdqaE96aHNUejlxUGp1Z0xoSWZQcW1Yd1RwclhWdGJiTFRu?=
 =?utf-8?Q?O3fi59jvRy0rzYlYHxzSZdDcNXswVjNGJjf5xvjhMRw8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5894B22810C8A94C97ACB8ACBA901BB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5200a9a8-93c8-434d-e414-08dc79f9e782
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 00:55:41.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBsi0tV0HyhvL3zRVRyPea/A2JLvk6QcfJidHlv23HKJsAABJeWP6JxR4+aWrK+TKSVOYBL3yMv4OiSbUiBIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_175549_767344_788787D2 
X-CRM114-Status: UNSURE (   9.53  )
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

T24gNS8yMS8yNCAxMDowNSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gQmF0Y2hlZCBjb21wbGV0aW9ucyB3ZXJlIG1pc3Np
bmcgdGhlIGlvIHN0YXRzIGFjY291bnRpbmcgYW5kIGJpbyB0cmFjZQ0KPiBldmVudHMuIE1vdmUg
dGhlIGNvbW1vbiBjb2RlIHRvIGEgaGVscGVyIGFuZCBjYWxsIGl0IGZyb20gdGhlIGJhdGNoZWQN
Cj4gYW5kIG5vbi1iYXRjaGVkIGZ1bmN0aW9ucy4NCj4NCj4gRml4ZXM6IGQ0ZDk1N2I1M2Q5MWVl
ICgibnZtZS1tdWx0aXBhdGg6IHN1cHBvcnQgaW8gc3RhdHMgb24gdGhlIG1wYXRoIGRldmljZSIp
DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==

