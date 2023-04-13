Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3617C77B6C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=th0gFFQXOebFBYdndhzYKjDtljIHrRTeru124x8qUEE=; b=QpRyGJdKE3KC3kZAuVTxEqdtjc
	fwJ/EIehzhcsO/iBBE4cm0r+99e9aPUrNXVHK1ro8UQdLg6sUokkBUDPETF5zUbmIMyN5hCsCrh+Y
	YQDyfE1FV0l96XbOBUUppQqO+KSkerVLwU9/qIbHtztliHDj/g69wAf9CbwinkPH5wuLdpeVpZ7la
	FgVlPTicpAuWNBe9JG2CRcfwSO2vtwf7vPM4t/xDU2E4b4bkRj5CpQ2GMACcdfjZYavrh3H4S0gWD
	9h/coeGZIJ1/4QtgFFfjZIiqvq9Oli1PAOaH1Nax21v1Uuo/983VPdNosk21hTETV52SNyrrCS3x+
	4RHWFfVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmmZa-004o8i-2G;
	Thu, 13 Apr 2023 02:20:30 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmmZX-004o8B-3B
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 02:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjzdffFHmT4EoW2+HgLIZAePecH2ifU63TPQjMoJthD46rN+vXTHylDk0UvcLTvcOGCIcRnFHg/X6dECwc6lcJHGrUFdQfYFaFs7V2ckv+4wYCV7B7AnOGL4AyTQ4lcQMHd7kujKl7AnPX1CmjkMv7Kb3oEaPg83ub0VCFlY8RR+o604pVI3LnDajMLeQSa+yql21yl5TV9wGhBKLRy6am43+iTZuX7X+f76oMid0WtMkuXlnhLE+7gfTAXXFdzBoJwg36jRXLLdm8Wa0G64CsivFi434sIp/xu99bQXw5DxQoCYvVri9Kw230rpUzD+0Ln894Ts7isY1yBD3eNJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th0gFFQXOebFBYdndhzYKjDtljIHrRTeru124x8qUEE=;
 b=cuKNj55UCg9K0gO6NQUezdDOD/jo3Xeyw4o9A6VSNIcI6nlVyLTD6O4ix4JstwXsvKC8VO2vuZ4LeKAWgw0hwIcLI61KNnpJ4ofYaKNu3IosmL4bt+PDScPkW6sUvF3+HA2lPqRQceKiUJ4+fFBK+eRhMHcJGw42EeitUvCjIip75i3HIsafTPS1z3TxDDScnM/lQpl3/+y7IztbHixnTar2DTmATlxVSXFg72QypH7fNJzBISIHaLNNTZkhcRvkjbIARpWWY0YszSvCuV20oNKTmd1azNeR0OPvJx5hFy5iecb3Rkq25/HmaROZ4L9Ccvd/RrTfeubCT+fmPJjCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th0gFFQXOebFBYdndhzYKjDtljIHrRTeru124x8qUEE=;
 b=D7ZaqmCIFciyFMHMR3EgVbaFmouVOXmqrkAo3kZVdR6xBD7XwQ0RaPEcNIqwq+uFMsd+imH7tUqOkgTWG6wGOJkURffjrbg1HhECv31eQFdcXcbjcUpXcK6K27+xcL5wMJpxlqy9SvNmfeAwe2SsF94dmmO8fZlHxysHwKuH1iiADSs9JidpzFDpSaFfl1FwWijsw8SCfOm98/jFpByL6UWhAKkzx6OMsiANapTraeoASEKCiguMZw4jac5K+3g90bE0Fukf62q7MVPM3Y16glFlJEzSEhF3nFnk5X1UwJbDwjn6emZKQhLzohQgdXvB2nMEwN1sk+MEqBRZ5DqfdQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 02:20:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 02:20:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZaynj0FvmtPMRR0m2hZrgt4zZb68nZtmAgAEfz4A=
Date: Thu, 13 Apr 2023 02:20:19 +0000
Message-ID: <f63a76e3-2de0-c6f4-3ac9-c32246d12370@nvidia.com>
References: <20230409212538.18647-1-kch@nvidia.com>
 <CGME20230412091843eucas1p22a4c7c34297c4f260ccc54cff9d67a52@eucas1p2.samsung.com>
 <20230412091013.5eckb4if2jiy6ms5@blixen>
In-Reply-To: <20230412091013.5eckb4if2jiy6ms5@blixen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6536:EE_
x-ms-office365-filtering-correlation-id: e4ce29d4-5297-464f-3530-08db3bc5a0e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8VB6Q8rdOEFUulDcy+ZeDoY4o6gAkQLH6QHMj5BrlB7qazHXs/6eKAmeQaXMEDnxpeI3yC1dnU4fLFhjEoscXOwfy208oauZ5elbksYIkc5EPGAesBsRem1GWhyyJOwhftxyoynyUp/gYwk/SxDj7a/gznrlaZU2CsqdIh2zahOYFlNfFSl84I53f+sgrBMxFxpYZ8c2fXNZCC1+3MP1prpfAUgu7RGgiP9+9LB9SRFxGGNbxGnyZ6fpq+xQWdhh39HTDwcfNl7rpuJ+tPHaScplJkNGI6DaSG/rZC7QaZ8gZDjxCwTio8UXbAwVF39SR741G9CE+lNvXzRih0EGN7VlhhYEsiGoVd1gjgUO6gYlaRU0qTulsH0JPaiJBttMd8vUtsFX3DJtrjSxePX3QWxEkf2GP3xCJqKsiplzZ3Y573iFDBli4qjwsGFtEL3HBaJCbK5Y3FqfcjGy0Ji5Qb3+J/JgQNBynPWnGGoH3R+OBegzN7ICOtdIm2MgrW1a28zYdvaT/a34QckiDB9tkMC77LNcqctC3Qjm+mk6iBbmIfUPviQZXlHwaJA5SEm1kyepPx47gxBZ9TNXv1WUJC66ng75+RbdWuVUFqoufEBYL5CkhTsNWIH4YcGioBjkeEf45pQvU2QeM4yg3MgVLpvVkKBsOWmsWcdmVvN9jl2a7wA5VFvVnSoAbtNUEocM
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(31686004)(31696002)(36756003)(38100700002)(5660300002)(2906002)(38070700005)(86362001)(316002)(8936002)(8676002)(4326008)(122000001)(64756008)(66556008)(66446008)(66946007)(66476007)(41300700001)(53546011)(91956017)(83380400001)(76116006)(2616005)(186003)(6512007)(110136005)(6506007)(6486002)(478600001)(54906003)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VVBvTWNEaVppRVNLRjlVWG9lZ2ZjcE02V29tbmNUb2lxZ2IxcWZGY1FhaU4v?=
 =?utf-8?B?MFBGQndST0p6NVNERnJreWpHVGRXWWxSZlFDWVZCQ2htb0tINnNyZ3kvaGVh?=
 =?utf-8?B?ZkpzTlE2UWpRd241VFhMVmtERzFYWFdldXYrTzRkTzFCWEhNWWlBN3RZRkly?=
 =?utf-8?B?cXN6c3d0T3p3Z2VGVVRsMElmZktRWXVmbTBuNk9iNXlvUm5SWGYvbjhWMHpp?=
 =?utf-8?B?T3BGY0dlVlNwcUd0dWtOZFU0M1l6QUU4RC9yS09nMlZMamozTWtlWEFGcFBt?=
 =?utf-8?B?ZTZoUnNFY3JVR0Z4aTdLS2p0Tm5XRlFKdDBWQ3FpRVZ6UlByQjMwU3BsZWRS?=
 =?utf-8?B?bUQ2Y00vUG0yMSt2UERIRTdRYzI1c05TVUc1MmdWaXd6MktjVlZEeEkrWGNp?=
 =?utf-8?B?R3V0ZTdtU1NmTVhDSHJKMjZBZ0xaSmw4Vy9kK0dhNFFCOXd2SHJkemRGeXFE?=
 =?utf-8?B?REh5QU5WdmFmakpoNWxWdGkrdkRCREFucjBVdWNiUm51akxSU2IwRllEZkxM?=
 =?utf-8?B?Y09DeFVndENWcEVtSkRtZU9hYjhncUIrOWM5WTJWcERaR01FeHo0Y0phbE40?=
 =?utf-8?B?U2YzZWg3VmtPdm02SVZVd0NhSG1iWTFiaWU1MCtjQUlyN2hmamVXbm1jdGZD?=
 =?utf-8?B?SFEyRXI2UjRrUk5QL2xncWJJckphWFY5b0s3WThVY25TRHd6YktVRDM1VTJG?=
 =?utf-8?B?SHR2Q1dHbkdZLzZmZFdmSlIwVU14RThNbDBaQUF3ZEMveHR3VXlVSStEd3hw?=
 =?utf-8?B?R2Exa0lqcWNVSlRmcWUwckIvNG5KeFMwWkpWWVF3S2ZJM2NTYUNicC9Jd0JN?=
 =?utf-8?B?bklITTdYL3lFTU44REZuY1JlcUVvbFdzdjkyemVlcW1wbVd2SjFJVThNcW1p?=
 =?utf-8?B?U0s5Y2tqY1hhRUJhN0g0c1pCQW5WT2lXSk40eW5OKzRsOGZDTHlLLzBUdlhx?=
 =?utf-8?B?SnZSTXNYN2JXMnFCNkhNbk9kNlhGR01WOVkzNCt5elF5QWhteTdaMHI0MWEr?=
 =?utf-8?B?SjdKSHJPSmo2TnVPTUtBSCticzhBYmlxTDVBcmRFNEZXZUVvZ3kzbm5uUyty?=
 =?utf-8?B?MnNaeExqWTBtakpQdzJFeTZWM0hFcC9GRUpJK0IzeG9OMWVyNHI4M29Pd3Ew?=
 =?utf-8?B?S1YyYi9VWmNyQW5aY2dUcjIrd3ozd0VLMkVzbXZGWVMvVVN2WjVkcDVJOHZ4?=
 =?utf-8?B?a3pLNDNuZWpCaGdONEtQQVEyT04zWFVBSmtWazFXSDlmNXFxNE5HRS9UaWJD?=
 =?utf-8?B?MExNbDgxT0lYakt1TnV4UFdDRm9nVEZnL0EvQ0VhY2ErZllFQ1lMaUNnWGQ0?=
 =?utf-8?B?Ync0VmJ4UmxzeFUyYWdha2xHVHA4NU5aSzkvODAwZnUyWEgreUhRckh2VXBW?=
 =?utf-8?B?RVBuSk5NR2p0ZkZ2WUFUOHpHamE3VnEvZTFibXRMN2lLV0ZHY01BbURjS0Fs?=
 =?utf-8?B?eDJTL0p4SzBJZnlwNEpCYXhOVk1HQ2d0WHNQNytNOVdkaUtPQW1hZk1zUnZB?=
 =?utf-8?B?ZjJXT2x0czh5UmZIN3VaeTZPWXB1R3pZYVdFbWdGUmJYcmJqemQzNUhpSGNZ?=
 =?utf-8?B?dGhSbnNXQnl1ejREQXhhUTl3a2xYaUNvOE9HeDcvWGthOUpWWFZhWkt4cmVC?=
 =?utf-8?B?ZW1IRnVML3lMbEp3Nm4rUmJ0R3NnT2kwWk9RVTZlcGljUnhxYTN5RUZPb25r?=
 =?utf-8?B?R2hZSnVRYlJzaVBTMlVPbEFlMUNFK1I3MUU2dkJYeDAwMUxGenlYUmpBeFBD?=
 =?utf-8?B?M3k5dlFBS2QxWUszdnJEcEQwWmNpbFE1eHdxbHljbGY5NkN3Z25SYzFIVGZM?=
 =?utf-8?B?QnQzcUxaY3RJNlQwdWRJNWxRbCtaNE1TR2N5MnlKYVRGMUlVa215ZDhnYWYv?=
 =?utf-8?B?Z0VOWWxFc0d3bmVZTjZUcW1EaHRsaWxNbGRaTy9tRGJMRXRiMWdmWW5rTjRU?=
 =?utf-8?B?YUNwZUZreGZha2xkM2N5Sm92N3psS3VKSm5OSEFzQ0R2djZ1ZVdKTUY3cEI4?=
 =?utf-8?B?TlFvN25VU0VNbzBDaXRCWUswaXVmakR6dnovSWp0eDQ4NVhwbVN6YmdMWDls?=
 =?utf-8?B?cXNqWEV0WnlYdkx3TEFtekZJYmdOeUUySHIwVmUzYVgvQ2xHQmszZkFUS2Jo?=
 =?utf-8?B?ME1xRWpCSVNWaG94ckZDQjRUTVhuWTZBNDU4U2ExakFQd1BIM0pWYXJuTTQz?=
 =?utf-8?Q?ztc6sMah4CR/9HRxcAlZ1gSdpTf/zBbApkzRs9EIDwrJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7A70E5657E17247978781B6A80F3881@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce29d4-5297-464f-3530-08db3bc5a0e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 02:20:19.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMaGBbtT7xWKo7p6zvv51xlU7oyy+9HYHb+7goB00DLX9LYO5Sfl/Si/hM0vNerKOFHg9vDw2bWZu9ekX3Fj4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_192028_354223_383053B8 
X-CRM114-Status: GOOD (  18.43  )
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

T24gNC8xMi8yMyAwMjoxMCwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4gT24gU3VuLCBBcHIgMDks
IDIwMjMgYXQgMDI6MjU6MzdQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
LWNrDQo+Pg0KPj4gQ2hhaXRhbnlhIEt1bGthcm5pICgxKToNCj4+ICAgIG52bWU6IGFsbG93IHBh
c3N0aHJ1IGNtZSBlcnJvciBsb2dnaW5nDQo+Pg0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgIGRy
aXZlcnMvbnZtZS9ob3N0L252bWUuaCB8ICAxICsNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3OSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IHY1Og0KPj4NCj4+IC0gVHJpbSBk
b3duIGNvZGUgaW4gdGhlIG52bWVfbG9nX2Vycm9yX3Bhc3N0aHJvdWdoKCkuDQo+PiAgICBVc2Ug
Zm9sbG93aW5nIHRvIGdldCB0aGUgZGlzayBuYW1lIGFzIGFuIGFyZyB0bw0KPj4gICAgIHByX2Vy
cl9yYXRlbGltaXRlZCgpIDotDQo+PiAJbnMgPyBucy0+ZGlzay0+ZGlza19uYW1lIDogZGV2X25h
bWUobnItPmN0cmwtPmRldmljZSksDQo+PiAgICBVc2UgZm9sbG93aW5nIHRvIGdldCB0aGUgYWRt
aW4gdnMgSS9PIG9wY29kZSBzdHJpbmcgYXMgYW4gYXJnIHRvDQo+PiAgICBwcl9lcnJfcmF0ZWxp
bWl0ZWQoKSA6LQ0KPj4gICAgICAgICAJbnMgPyBudm1lX2dldF9vcGNvZGVfc3RyKG5yLT5jbWQt
PmNvbW1vbi5vcGNvZGUpIDoNCj4+ICAgICAgICAgCSAgICAgbnZtZV9nZXRfYWRtaW5fb3Bjb2Rl
X3N0cihuci0+Y21kLT5jb21tb24ub3Bjb2RlKSwNCj4+IC0gUmVuYW1lIG52bWVfbG9nX2Vycm9y
X3Bhc3N0aHJvdWdoKCkgLT4gbnZtZV9sb2dfZXJyX3Bhc3N0aHJ1KCkuDQo+PiAtIFJlbW92ZSBl
bHNlIGFuZCByZXR1cm4gZGlyZWN0bHkgaW4gbnZtZV9wYXNzdGhydV9lcnJfbG9nX3Nob3coKS4N
Cj4+IC0gR2VuZXJhdGUgZXJyb3Igb24gaW52YWxpZCB2YWx1ZXMgb2YgdGhlIHBhc3N0aHJ1X2Vu
YWJsZSB2YXJpYWJsZQ0KPj4gICAgaW4gbnZtZV9wYXNzdGhydV9sb2dfc3RvcmUoKS4NCj4+IC0g
UmVuYW1lIHBhc3N0aHJvdWdoIC0+IHBhc3N0aHJ1Lg0KPj4gLSBSZW5hbWUgc3lzZnMgYXR0ciBm
cm9tIHBhc3N0aHJ1X2FkbWluX2Vycl9sb2dnaW5nIC0+IHBhc3N0aHJ1X2xvZ19lcnIuDQo+IEN1
cmlvdXMgdG8ga25vdyB3aHkgYGFkbWluYCB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBzeXNmcyBhdHRy
LiBXZSBlbmFibGUNCj4gbG9nZ2luZyBmb3IgYWRtaW4gY29tbWFuZHMgdXNpbmcgdGhpcyBhdHRy
IGJ1dCBJTyBlcnJvcnMgYXJlIGFsd2F5cyBsb2dnZWQuDQo+DQo+IEkgdHJpZWQgb3V0IHRoZSBw
YXRjaCBhbmQgSSB3YXMgc3VycHJpc2VkIHRvIHNlZSBJTyBlcnIgd2FzIGxvZ2dlZCBmb3INCj4g
cGFzc3RocnUgcmVxdWVzdHMgd2l0aG91dCBtZSBlbmFibGluZyBpdCBleHBsaWNpdGx5LiBIYXZp
bmcgdGhlIHN5c2ZzDQo+IGF0dHIgdG8gYmUgcGFzc3RocnVfbG9nX2FkbWluX2VyciB3b3VsZCBo
YXZlIGJlZW4gbW9yZSBjbGVhciBJTU8uDQoNClJpZ2h0IG5vdyB3ZSBvbmx5IHVzZSB0aGlzIGF0
dHIgdG8gbG9nIGFkbWluIGNvbW1hbmRzLCBhcyBkZWNpc2lvbiBoYXMNCmJlZW4gbWFkZSB0byBs
b2cgSS9PIGVycm9ycyBpcnJlc3BlY3RpdmUgb2YgdGhlIGF0dHIgdmFsdWUgaXMgc2V0Lg0KU2Vl
IG52bWVfaW5pX3JlcXVlc3QoKSBhZG1pbiBjb21tYW5kIHRpbWVvdXQgZWxzZSBpbiB0aGUgcGF0
Y2ggd2hlcmUNCndlIGFzc2lnbiBxdWlldCBmbGFnLg0KDQpUaGF0IGlzIG5vdCBhIHN1cnByaXNl
IGl0J3MgYnkgZGVzaWduIGFuZCBBbGFuIGhhcyBleHBsaWNpdGx5IG1hZGUgaXQNCmNsZWFyIHRv
IGhhdmUgaXQgdGhpcyB3YXkgaW4gaGlzIHJlcGx5LCBhbmQgdGhlcmUgYXJlIG5vIG9iamVjdGlv
bnMgc28NCmZhci4gVGhpcyBrZWVwcyBjdHJsIGFjY2VzcyBhd2F5IGZyb20gZmFzdCBwYXRoIGlu
IG52bWVfaW5pdF9yZXF1ZXN0KCkuDQoNCkluIGZ1dHVyZSBpZiB3ZSBkZWNpZGUgdG8gY2hhbmdl
IHRoZSBwb2xpY3kgYW5kIHN0YXJ0IEkvTyBsb2dnaW5nDQpiYXNlZCBvbiB0aGUgc3lzZnMgdmFs
dWVzICh3aGljaCBtaWdodCBoYXBwZW4pIHRoZW4gd2Ugd2lsbCBoYXZlIHRvDQoxLiBJbnRyb2R1
Y2UgYSBuZXcgYXR0ciAocG9sbHV0aW5nIHN5c2ZzIG5vdCBhIGdvb2QgaWRlYSnCoMKgwqDCoMKg
wqAgT1INCjIuIFJlbmFtZSBpdCB0byBnZW5lcmljIG5hbWUgdGhhdCBpbiB0aGUgcGF0Y2ggKG5v
dCBhY2NlcHRhYmxlKSBPUg0KMy4gT3ZlcmxvYWQgZXhpc3RpbmcgYXR0ciB0byBhY2NvbW1vZGF0
ZSBJL08gY29tbWFuZCAobm90IGFjY2VwdGFibGUpDQoNClNvIHdoeSBub3QgdXNlIGdlbmVyaWMg
dG8gc3RhcnQgd2l0aCA/DQoNCkkgY2FuIGFsd2F5cyBzZW5kIFY2IHdpdGggcGFzc3RocnVfYWRt
aW5fZXJyX2xvZyBuYW1lIGJ1dCBJJ2QNCmF2b2lkIHVzaW5nIG5vbi1nZW5lcmljIG5hbWVzIHVu
bGVzcyBzb21lb25lIGd1YXJhbnRlZXMgd2Ugd2lsbCBuZXZlcg0KZXZlciBtYWtlIHBhc3N0aHJ1
IEkvTyBjb21tYW5kcyBlcnIgbG9nZ2luZyBvcHRpb25hbC4uLg0KDQotY2sNCg0KDQo=

