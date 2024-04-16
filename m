Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E423C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CC/xVHJzDbIBAj+eMsAbzWol0FX3ttTUkZqGdEPBb6A=; b=LHo1TpJsMFZzeqtjlIF8XWk/CN
	lnkv62JJGFito8L2lkc9AAmC9Bl/39jrRnKCs82DSroPIyHhejw5HOKfFmzMKsrdSO+2HQTWgh2d3
	YkaGh/SCyGc0tj/BZQzEFvApr314Pm7GuOCge7DgV3XlVXB6N+K3oGiNqsYoMp1eqP6Ujqv8v7aP4
	vBr+j5J2wUktYGxHsaY6hknZ7FcmGtG110rfGGt28+bdhSbrTSWrRLZEx8A/qpo+0b9MsYENhqKfD
	GYyqIVdTU0QY+tTwJtIp0AalrgZ0HAoEmjamsNBkEhkAQ+svSRIrtYA1gdaZEZw0kWv2PLi+pQS8e
	Wk+dd+qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwemh-0000000BYES-2mJb;
	Tue, 16 Apr 2024 09:07:23 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwema-0000000BYDK-1glK
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 09:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDUjprWnfvASvwBvvRAIGMZcdSGx9XhT31yoqvOgpdbIXCbhJWBmHwTaJGxbovHOUSU3BLEeoxwtNm7gWI3jiH4vCsXGkpsD35cWd5s0b3uxpuc7aDrSjCGvAIIQ1BJoM+eOlVo8tzhXT0ji/inkyecizAsQ1LMjBp1rz2x3f3QPo5YmnqLRwT71fI3MPS75DKqY5nNtkx67wHfIAxGRvrUo2BhB861V7HaarZ7ovCPkB6djYAZiWv6XBwky8/oXG3h36mSfsRfejYVlDZuSvfoNh1+YsqpAS4Dgn+2SGq8PbNYHR2FeZ33PwlrOdqUYNGwe2kD3yEbpe+lLztP2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC/xVHJzDbIBAj+eMsAbzWol0FX3ttTUkZqGdEPBb6A=;
 b=YcLFoxGNe86zTv+9IPhZBgLW+R0qisM18EnUEDTnHz4lZvUa3gZCKIEqYSXi9JUho8RRykMYIUHPC8vV1w3r01nsWmxjd8nhLZnhnovMpUOMVoswHCmB8kBFe2ySJukJ22RSX8Wb7bSEUQIVLYwqkIIe+mu0WgBBw19WzNnG45vWpdSq1j02UYRVNgMYA9NZCb77JmUzEbgNz6DnNFT6iCr4NNE53D1xEFEQi4M9Fl/vSgwOjN5kA2B3qgLdjk24duTh+IfgfZD9/qNFNZShLmbMYxh/QRQcpjmA781EhBmXlvWmGppH4zcNrd21euOfTizlzRC8FPmGgvWu99GJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC/xVHJzDbIBAj+eMsAbzWol0FX3ttTUkZqGdEPBb6A=;
 b=q5U7JDuAxZgTOrtThrGtVuSNdsO4VyBV2Trt4Ft3uBGTVK66ae3Jl9LnB3mL01MPg1bLtziiT+mVzFdCFaPs/zIlDKynTLqGINa48x2SYFogeP2443bvZa+qMJAm3CJsPasb1ORVmfkUkdz9RZWncnj377uwZrSV8A99kV3OasYowYCZG2czbYCSwWekOm45RkUgGld9AMh4QW8jFGobQDrMUwb2SL8UeWJ3wWHJMJYdYVtY71R1MgwlxRktfvkEqeFA5UQRncu7e3W/J96rZp3OXogcuFsXH7iDZE9q279k7TW3zrbsulMIC33+E4yHvUbYrBwMijMJ38yRztBdoA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:07:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 09:07:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCHv3] nvme: find numa distance only if controller has valid
 numa id
Thread-Topic: [PATCHv3] nvme: find numa distance only if controller has valid
 numa id
Thread-Index: AQHaj9c1oAVy/K6EnkC4YVgJEIscgrFqmz+A
Date: Tue, 16 Apr 2024 09:07:10 +0000
Message-ID: <c0dd0177-20d2-4d7b-aa44-ee29b2117c30@nvidia.com>
References: <20240416082102.914152-1-nilay@linux.ibm.com>
In-Reply-To: <20240416082102.914152-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8467:EE_
x-ms-office365-filtering-correlation-id: aae82c04-6d1d-4f19-3624-08dc5df49983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndPQDwRNJfaY5MBowzbMOWGlrMrfeEc9c9pyF+oBU97eh+buQKaj0glyOpG85V8jUUbDLY05vSUByvLDJ5YcJrK45tEvzrKZfJcdof7cDMao2v8w0EXZzOj+n1NPxg9IYNQYngXvH52e/SfzpB5mlHVSJAqOeeK8a61gs0W24HfBSeAc/jLzRJdU3uLEutB+DPjSnFOMyuW0+2xdxgTYHt0NAcCzHN+4HRhim8Kq0m1gc4KPgdBqBXLZUV3o0hG1/i41tC+m8n7Vb16Cu5gFQ3OYNrs7P9y/wEcy/14yd4vjTC1WXuNJYKb/D6Q879ZM1yOiWjbv3mbgEs7VB6R6bJVXM2SBDfaNrg1QV4IU/EEr3XchWqcn+y37khizSDbcFEsgbgfXif2XhFFJ7obG3Y/0SFjQgCRX1yMyHhMwDqYZG82UywoLjy3CX2+iI1wKe5KmybSO9KogP2bz6/WdssnJ8xPfE5jb8gl2veGau/gj004vtjCFC36hFBvKRmJdXOVEEzCGo9YuuFONg2ymtSZ7aNIeA0yuYOscYC6giDY2SOcJjm2JnLbNAAoky27LTNNi6nerE8zbERdWgMkvUrgVSqr1W4WkylkOUZ63azuENPMH6WXEHP80JG3kwzxhVjvbYvxg4XMywI6izbp/kmZZmta4xig4/SgbCbRP+fhd5dt1PYT1ISu81MZanCcE6bQEJHuupRymWFUGM9TyyQBBB/kPjrx3v5CP2w2t+7o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azA4Wkl0SVRKSXNNZEJvZlgrK2UyeldXTEdTcS9ibjFvbCt4QXhLVUxBNEJH?=
 =?utf-8?B?N2QxTnJnZzFJSDlMLzIyQmt6NEtsQzJiSUQ3bFgwc0VGTG9zVVpTSnJRYTE4?=
 =?utf-8?B?RGFpQU1ucWRaT05rVTI4U1ZtdjlORElvZlhFaU0xeWRqbjNjS0hVU0tPblFW?=
 =?utf-8?B?OHRqdFNqdTNHNnZIam52eTNvMjBqSzNiNEZiZ0g1SE5EYVpCUllXTDNTZTh5?=
 =?utf-8?B?VmRSYnlaeU9SMEZEMmdmdUVZeUxxWitteHM4clJqVlBINHU3MVJDc3pkR1lU?=
 =?utf-8?B?VVNzTVRvWGFWcFdDQzBqT1VWMTdtME9SeTZCOTNsS1lnKzZzcnk1SjBqZmZv?=
 =?utf-8?B?disyVko5ZmZURGw1bC9qU1BnMTdkYXpsMXNJeUxRbGF0OVI3dHVwZlBCNUhG?=
 =?utf-8?B?MzhZSTJMUUZ2ei9ac25PU2FXQkdKMzBTYXBiL21IRkFVSXpVbkduc3lxSm1I?=
 =?utf-8?B?R2F6YXNrckMxS3lPQWtsWDYzUm9QdUt5NkNxYStKd05UNTU3NG9HamxuYk9G?=
 =?utf-8?B?LytQWXovL3h6WWVJYlJxNTBUMTlKdjJOc09QZXpXWUdyTE11V0FncTB3K2Vs?=
 =?utf-8?B?Wm9hMVYzVmJmWCtFT3EzaWFYYlZCaWlQUjdkRDFnaGFsNXpNQkJaTGY4cFcv?=
 =?utf-8?B?dFFwSlNqZEdja3BPa2drVDRCRm9Vemw4MjgvaGorMWkxZ25PSm5zc1VWMUE5?=
 =?utf-8?B?NDFvblJXRHd0MkpEdmg0NUVSTWF2UkZyNEpIdzV0UjVDaUY4UUxVSDExTjNl?=
 =?utf-8?B?bzNyaWFEbDdHQXlvRDFjSDQwNlI0Z2Y2RGVBWnlUdWFXRzQxZm43RnpYMVli?=
 =?utf-8?B?emIvS25wc2JMTjZwTG1kNitlZ1grZXQvQTNnUWZlNWN4ZEVuVWNYdGNYdXVy?=
 =?utf-8?B?NWNUOElzYmNDVi9uZytYTlRWWHR3NjJHTnIxenlRK1R4bkpiWmtZcjZUZytx?=
 =?utf-8?B?RUFBMVJVclo4UlE5Q0Vmd1YvaUNQaFpiSFc4Zk5uUGkvdzNIdVJJQTlHaG1V?=
 =?utf-8?B?SEN4d08yL1VoS1Jua1o3UWRLTVBORDM2eVhCaEp3TnE0QzNGSlhUSTZ4RERi?=
 =?utf-8?B?aGNvbGZaYk55WXpselByelp5TUErS3pra1JUNHlIS01UeTRJcHhQU0RWU0VS?=
 =?utf-8?B?S3hPaWk2c3hNQlgzeVpOOEVhempQK2xkd2VaRGdFWURzcC9YY2pZcnQvby9n?=
 =?utf-8?B?ZTZLQmhRRURCUXVNaWFTQmdGWm5tamR2OVpPRnFPQStIUXBXSVFZRmJuYnk1?=
 =?utf-8?B?RURML29MWm9rWGlXN2l6RXJITzRwOXJqWlc1VVQvRC9GejJ1VVBpMTdJK0h2?=
 =?utf-8?B?SXd3b1UzRElkalI3RXQ2QUY0OGZDWSt6MEt4Z1FrelJnSEdGYjdyNW8xRFFv?=
 =?utf-8?B?VUlXMVBNUndLQytVbmpreTdGS0dROWgwMUtwWno1NkVVOUhySC9JNFVmZXJv?=
 =?utf-8?B?bkRrcE8zU3hCWUloK2ZNMFhtdVF6NEpOWHBXd21qczJveDkzNm1hS3pOVEkx?=
 =?utf-8?B?V2J2ZnNkdWJpUzFDRkp2cUUzY2svcHBjeTVxNi9FR0szVU9RcW9DYm04ZGM4?=
 =?utf-8?B?SmFFRkROZmo1UjZiaUZ2djJDRjZLdkRLTy92dnVaY3N6ZDNxYzdQNnJ6Um55?=
 =?utf-8?B?WkZXSnpLZ2RkcnQycEVLM2t2TEZrbFZjTytLMHFGS1REbDk1d1JVWjA1cVVX?=
 =?utf-8?B?c3REaUpWK3FvN0lNYnU1OWhUS1UxdG5rQU94RTNRRXVyZHA3UkpQWkxLcHVi?=
 =?utf-8?B?RmxWYVVPNzdLMm02YlBKd3Jjb0J2ZmpJdXh3RU5kNy9RRWlVNmhMaStIYU5j?=
 =?utf-8?B?RXpLNFNIeUZ2RHJ3eDJMdUlNV2JEVUprbGpjcW4vT1VMTkRUVGdIOWVzVCti?=
 =?utf-8?B?MDBWU1ZZQml4VHRiM2ZURUVyNG1ld1NYcE8yM1RQM09ZVk96TThiamREdE1L?=
 =?utf-8?B?QlVHN2Voc0RGdW95NlE3Tit1K1FqRWYvVGthNkxvRlFYcVMybEhTd0ZvTHBr?=
 =?utf-8?B?THN0SXhMK2l1V3RBNi84UE5iUkdia3Azc05NVWdISFFYcnlmTGlFLzBWazZ2?=
 =?utf-8?B?M2ZVQ3p1S1pTeGNSR1dybTdhZU0vSzV0OHVIMUVQOWw0NkpBZXE1b3FQS2JG?=
 =?utf-8?B?V0QzWExtL0crWndzNXBvb2FHeGJpTFJSbHV6dmNvNU9UcWlIeHdKVXdGTm5j?=
 =?utf-8?Q?GWau9HMrjmQqEg7i0R6jHuk21hQYOKnQRHmx9LvqHZ2b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AECD98908F703A4C85B609D99094EDA2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae82c04-6d1d-4f19-3624-08dc5df49983
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 09:07:10.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziDI0+Y2Gn6wgzxzCXFT54wvQJt38qE95COPKGHcvNocUEOZ5ZtzkBfjwpY1pvE3miM8FSWtpoRytslZuqF18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_020716_499897_2BB35146 
X-CRM114-Status: UNSURE (   8.87  )
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

T24gNC8xNi8yMDI0IDE6MTkgQU0sIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gT24gc3lzdGVtIHdo
ZXJlIG5hdGl2ZSBudm1lIG11bHRpcGF0aCBpcyBjb25maWd1cmVkIGFuZCBpb3BvbGljeQ0KPiBp
cyBzZXQgdG8gbnVtYSBidXQgdGhlIG52bWUgY29udHJvbGxlciBudW1hIG5vZGUgaWQgaXMgdW5k
ZWZpbmVkDQo+IG9yIC0xIChOVU1BX05PX05PREUpIHRoZW4gYXZvaWQgY2FsY3VsYXRpbmcgbm9k
ZSBkaXN0YW5jZSBmb3INCj4gZmluZGluZyBvcHRpbWFsIGlvIHBhdGguIEluIHN1Y2ggY2FzZSB3
ZSBtYXkgYWNjZXNzIG51bWEgZGlzdGFuY2UNCj4gdGFibGUgd2l0aCBpbnZhbGlkIGluZGV4IGFu
ZCB0aGF0IG1heSBwb3RlbnRpYWxseSByZWZlciB0byBpbmNvcnJlY3QNCj4gbWVtb3J5LiBTbyB0
aGlzIHBhdGNoIGVuc3VyZXMgdGhhdCBpZiB0aGUgbnZtZSBjb250cm9sbGVyIG51bWEgbm9kZQ0K
PiBpZCBpcyAtMSB0aGVuIGluc3RlYWQgb2YgY2FsY3VsYXRpbmcgbm9kZSBkaXN0YW5jZSBmb3Ig
ZmluZGluZyBvcHRpbWFsDQo+IGlvIHBhdGgsIHdlIHNldCB0aGUgbnVtYSBub2RlIGRpc3RhbmNl
IG9mIHN1Y2ggY29udHJvbGxlciB0byBkZWZhdWx0IDEwDQo+IChMT0NBTF9ESVNUQU5DRSkuDQo+
IA0KPiBMaW5rOmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDQxMzA5MDYxNC42Nzgz
NTMtMS1uaWxheUBsaW51eC5pYm0uY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBOaWxheSBTaHJvZmY8
bmlsYXlAbGludXguaWJtLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

