Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EADC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 23:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2h0hzQLygRKFU9EAHjv2FJMXHPi5TvPoq1zY9rmxDe8=; b=nPJ0bsWK+RvxEyKrNjaoTDI7VK
	1Q4ozkkYr2Uft5bFs3ALdOOUGocp7R1JShvjgFl/hBSj2mkKLmRf3M2H7PdAJ8fEftVzL/ml41Yt/
	AXGJTEdFQYpkyN09ARG7GPIohF00RIVRx3qc1QpsQW8AXPCy1W/1kDDpACbl4YGMbRuU1TKk6R2pk
	CRRheO5lRF67GvcsJ5ETReY6+2UgoB2gjh61Hwgsj/B2G0U5TxP5ryjxdBrdnpNxr92nCSCboAjcV
	HDj1qOF2cxE49tEM5nOyVtq3mzd2IFuSLfWEAXlCEFIlkBLiPgtzEuZlDJmgPEHsXTJ0o+r3rmNAq
	vvDfDqSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpE17-000000098GN-3scP;
	Wed, 29 Jul 2026 23:48:53 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpE15-000000098Fu-0TSK
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 23:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r06HzI25FrS/fOpwKQ8AxQ9dpJgms6RFPViNnwpLrFz3fWncbEGRK3nH+k3xhOuEHAJMWQePdqrlsPrBosx+uI9S4Usn2CmiJ1mpQ1ogRlr6m7L/TapON9ALUA/nSP7nu4o22Xe/j6M7Q5Blg0gb2P15Td3NcCGIYep9xg/QhP1pqEoE5JZRG5vyqVp8h3kjLKkhcmIbq1Vy9o1jecf4isM+QelMhFM15T3wnAv3gZdww864KnK04tvQO6QWDNEwAq0qmyV1ceNUgPa3ficXhOhshBW4kuXOmztORGZWBdgHhS3TZkseIas8svKa5hwZ48yli/VTP1Mp80bC5V8AWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h0hzQLygRKFU9EAHjv2FJMXHPi5TvPoq1zY9rmxDe8=;
 b=kLAmXHgVkCjxQ/ZACkRvmKTHhDe1xplmzQFFVwwYvERpmF9RbdZRfIQt7llHv3ZD/OPHLut92QIBvtntoxwIcLQ23ZoJEmA8Jw4A98NDyMEN7yGg3WVv88RV9B59waKXrFdAOlTaBhxXkE6T9fp8AELKAW6xovbXkCwg8pX5osV0q/vYWLHauWwhr7ZPOBGcNo0oxCoE/DGK9PfGg+3xLJpTWZrS7oqJJmDtEtKhr63wC4VRSVyvdksGvCxssRPF6TTjamK/kXvPnepnctfNit68nTF8mYCGF/cEuvxkZv/20Alf24qhyfzX5STM/1XVLACR0X3BUKD8OVt/PgaSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h0hzQLygRKFU9EAHjv2FJMXHPi5TvPoq1zY9rmxDe8=;
 b=I3CrOCWogSFyb574H2O35yNCnvBlcOFEyZHORnbFVDoRswo8OdD5KKgA4rLSONDuRfKplDGe6T+982KArLJTpOtV+GS1dKKjEI53jbse/2Z8cbwoJO1J9aMr+wYQqLxv5kyA7cCcFGys0LHu1X0TRPvYpkz1gOc/V6ZO0scCxrL4LDWndQNiJEwObTbJG6GC8oLotkIC9tnY5LxK4q7JB381UhJHLpH7wQJKNBo6qZNzD9wajYsi93QeAQrzCmBIeDY3+30e4qnghyuamOXxDs9Wtb+mnGb9Qih4OIDa5A1f5qkMiYrP2k5BYIvxaFx2a1/R72dlNt8ZKfY4BM8xqA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 23:48:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 23:48:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <joel.granados@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 00/14] nvme: Controller Data Queue (CDQ) support
Thread-Topic: [PATCH RFC v2 00/14] nvme: Controller Data Queue (CDQ) support
Thread-Index: AQHdG10yrVOV1HjZUkmC+DsbMfdX6baFMtmA
Date: Wed, 29 Jul 2026 23:48:43 +0000
Message-ID: <64867060-4219-4188-9f9c-c38d5ea4b71c@nvidia.com>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB7486:EE_
x-ms-office365-filtering-correlation-id: db9979e9-bd9f-4ad9-67a0-08deedcbec66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|10070799003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: qgBXy3ZPxGdY5NHOrLHOA+ot1b1gecX6hLUK6qJ9o9+/kX5hCuJpXL3IEjjRW7sYGW+WZvYBk8sX5T66Uuc072Oe1qViabt9NLFcghoBZvcP65kfXKHtMrUOdCOdc8yMWIfu+X4GnCxj9RJz1DhvaZYssAUvXbfQ9piCIwgnmzScZ8/7pReuFO5T7HrrrI5kvPvi9S3SjQgbtS9FOKVYj02QReMRHjCsJ7Xjvb4PI6YwzuTneJGzgMKcKowyCayIirWrENFLuCy4PgFQyslnvViZ8Wn/mhXUMrsCBF0V9d4aMOZ/hnngh2kuzU0zxT19ZVvNyaqyQhZC77Fiem9vv+m86m46j+WlDSaU5Ppm4diQXTiIYl41c22hLWE5LF8lY0IyjXJfWHUSwwP6bR6ErpahioZ86NEbALfRQpEVJdfp/vx85XB1cQWrMZenKfJQm8FEKNAhq3aIgWR7zPrClBwn+judBQVtoP0A3NOgSuFzU5ecOD1PxNqf9THBqxEmGSwq0Z7XLLC+cNj2c8L5k3aEAWCvzPhyIbLUFBSbXH44Avnh2NUyXVFPVBvX2uWFDGPwQ1D05BDYtmlvhDaZ9AF7uEHH9QXKV4qRdRVnrk6pmb65tNyOHasSsVcp5IGvg094FQ2vzTpbBBWVyLQxWogSYxquCwsUAzg3x255lV0iS7+LIan53F97uMt3ROYikduU3kpzxGXZVvzDVPdQHJLXnRRy/hFcmHVBfJBeBvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(10070799003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXo4WFZHdUhPeStMamdIZFd1VlBucDZOL3hBRDB2WUlxTkN0UG1NdnNubG1J?=
 =?utf-8?B?TE85VlJZdnAzZkQ5UkhkT0Uvd20xNTI3Nnl0aU41d0pxY0xLTVl2d0lOL29H?=
 =?utf-8?B?cnEzeDk3R3cvcWlRWXp6czdyZk5Rc2NpdGpINjk3cXhUMmpvT1Qvd0tyYmh2?=
 =?utf-8?B?QUVXdEFzUlFqbVp4YnkrV3RFYWRNUG8ycDhHS01RbHZlUXk0T0lpNlZUbWJo?=
 =?utf-8?B?VVVyclRoZkJLT1BaNkNFVzBuZE9Ub2dxcFVNcVlud20yMFZXUmdET0pjUXNy?=
 =?utf-8?B?TjJZaFB4amV1TXE2bXd4Rk9sTDZUa2xCMmxHWHhCSXhUenFJZlE3VU5vRGMw?=
 =?utf-8?B?NFJ5MFl4ZkpBemhBY1N0N3JEOW1rK1RmbEFiais2RGlMME1xUWw0T1V2dmRE?=
 =?utf-8?B?U1BMbytFejlCVGJJLzErTmgvdGVTUTM2eWhQbEp4bFJrYS9CQVVQY3IyUklD?=
 =?utf-8?B?ZmJPczB4MDZOSlROYTN5Rm9ZMTBWbzJ3M2FVRGhFREhuK0V2TDhyNEdraE8w?=
 =?utf-8?B?dGRkNE9qL2p5NWhCR2MxK2psUzE4U0R2NVZRdzNhUWNiRm5PS2Jia2g0Z3Ew?=
 =?utf-8?B?b1kzcXhHejZ1QWpZYjlvUk5PdTY0TXFkNXR1WmxiZEd2YUdPV2xUdTNKS1hC?=
 =?utf-8?B?d2xlZG0zaDJySW4vTmt5NlFpaTFkMEJQMHhURnpKb3hkWFpxUDJBQ1NCVW9z?=
 =?utf-8?B?azlxaWtmSmtCZUFmalp4WlR3NUNpbisxTkszN0dtd1g2YlozbTF5SlNpV1Bx?=
 =?utf-8?B?Mk9ISUtFTzR4Wms4ZnhqS0VucmhMTVVqS1Q0UXp2Lzc0TytDZVJlMGhOMmtJ?=
 =?utf-8?B?dDBLNHRyTkVyZ1hnanZrdEREZ1RCT0tRbTB1anY4MWJrUGF1ZjZlUHBYYWha?=
 =?utf-8?B?VnNxSGRuT0lpT0c0eXUwUU1DUHpHV3p1SFpWblYxaERvZU03NXhwbUpqQjd4?=
 =?utf-8?B?MjQ2dHNCMmZkVUVSU3JONUo4a1FDQmQzTE01THZQYWNSeVdjZm5YWURJMmJU?=
 =?utf-8?B?T2JwV2VQWTdvQ0YyYldiczBtanpONG9KRHlFZXNCS1VPUHg0NkxxZEkxcEFx?=
 =?utf-8?B?dTdHY1VrMWxoNE01RzZoOUlFcXh0OGdDVGhxU3g0d054eVlrbVhRcGN6Zm5L?=
 =?utf-8?B?RkltU2VmMmt1QmtWMC9VM0N4aGYydWhyUnRMRm1aN2pFSjZTNEdjSU4xVm5j?=
 =?utf-8?B?b3RLQjV3S2sxVm5BYUI4UXNqTDZVbWxDY2tXeGF0ejlpV1YweXdEdjFDWnRq?=
 =?utf-8?B?Q0hwQ2k0MzYvZ1lTOU10N291SmZzZUpKVElOQ0Y2bHEyVnZMSkdpbitpcEM0?=
 =?utf-8?B?Y0IreVBPa2Q1TndzelZwSVFXNlFseGwwalVmWVBCeTFiQmRwdDNsemJSUzdj?=
 =?utf-8?B?dnJncW1vd0ZYYWQ2NGtoRXN4QUpBNTFBam52c2R6TzRXQ0tMMkppRkhTM2FK?=
 =?utf-8?B?cE9LcE1kN3BBM2VKQlE2KytjbnJXbGNYcXNCd2RWNzR2bUVZLzZWN3c2NUt3?=
 =?utf-8?B?NGhoZnhvYWhtY3Nlb1BINENMdmVKa282SWdjRjFRZUlxRmN1aUdrVlovNHgy?=
 =?utf-8?B?amNEaUYvL0FFL01UWWJSR29HQmVpUU5QRGZmNWpGdDNUK1g4TjA2aVg4UXpu?=
 =?utf-8?B?MUdVSDF6MmlTTStwbENhdklZYVVQMUY4cCthTzRYVkkzQmd0dDZyQVVBRjRr?=
 =?utf-8?B?clRsY3g0amcyK1VWaFdvM2E3M1hrNmpyVmpJVDdOYXJ2cnl4WTZvbEUyK0dH?=
 =?utf-8?B?RjJGalZqSVA0OGVheTBXbHNDQUt3bmovV1RoR0U0QitqRlZ0RE5OOFlEOFdt?=
 =?utf-8?B?YWs5SWd3UG5KbFlUYSt5dXNEaEFBb2kwb1BzTDdFZWdXSElEdmp0bEdPSmps?=
 =?utf-8?B?V1NJWkJudFVPY2hsYWdQQ3pMV3ZxRi8yaVVySGM1ZjlYeGgvcFhubUwxbEo1?=
 =?utf-8?B?cER5WUJrT2s3RmpjUWplSmp1VzJvUnhNbEFlaXJMcjMrZUxjRzNlTThqUGgv?=
 =?utf-8?B?eWtuNzJ3Y1c1VkJQVm1QTTd1Z1k0aXdtR3h1Qk1vMmJSQitMei84REF2d25z?=
 =?utf-8?B?U3RkMENuVDNpM3ZvQ3BjZ2tFU1dDMTFuVXNTWnN4cmNPYndpWHo3TlpWZ1NV?=
 =?utf-8?B?RE9Jc3NpeWlnZ3cwNis5V29JMlZiM2FxMHNIWFBheVhWMmFrbDBiV09INFNt?=
 =?utf-8?B?MGhkdlFKUmtNajlXT29zSHJSTTMzcVFhQlQwSUs3NXVWUG01ODBPN1g0UW0v?=
 =?utf-8?B?MjhIY3RXT0ZCanZiTHRJb3VnVUt6ejNGYXNUVllONllpUG8zdmM5SmtYM3pZ?=
 =?utf-8?B?MFh6L1Q4OUNORCtPd0h4TXlvdkJVeVFZNWM1eW02NlBnNDBZQ3g1S0xrVmd4?=
 =?utf-8?Q?6xcuWA8dT59bChJmEB+GO9b7eqhdMGDWBy3cvY4ylVEtO?=
x-ms-exchange-antispam-messagedata-1: uMHbkyfr56g/aQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8A53644BEB3B4BA7DD85DAF92F4379@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9979e9-bd9f-4ad9-67a0-08deedcbec66
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 23:48:43.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2Ya9XXdDj4m5NVBZIE8egzG3+tp+LGWL+KMwah0keWFjBcnZplxIrI4nFy8LtUQ/0C+zZbFmOhD+zYEsG7Z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_164851_159106_1FCB9EEA 
X-CRM114-Status: GOOD (  11.05  )
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

T24gNy8yNC8yNiA0OjEwIEFNLCBKb2VsIEdyYW5hZG9zIHdyb3RlOg0KPiBOVk1lIExNIFNXIFdH
DQo+ID09PT09PT09PT09PT0NCj4gVGhlIE5WTWUgTGl2ZSBNaWdyYXRpb24gU29mdFdhcmUgV29y
a2luZyBHcm91cCAobWVudGlvbmVkIGluIFs2XSkgd2FzDQo+IG9uZSBvZiB0aGUgbWFpbiBmZWVk
YmFjayBwb2ludHMgaW4gbXkgcHJldmlvdXMgUkZDLiBNeSBtYWluIGdvYWwgaW4gdGhpcw0KPiBy
ZXNwZWN0IGlzIHRvIGtlZXAgZXhwbG9yaW5nIGRpZmZlcmVudCBhcHByb2FjaGVzIGluIHRoZSBo
b3BlIHRoYXQgd2hlbg0KPiBpdCBtYXRlcmlhbGl6ZXMgd2UgY2FuICJoaXQgdGhlIGdyb3VuZCBy
dW5uaW5nIi4NCg0KDQpXaGF0IGRvZXMgdGhpcyBtZWFuID8gLUNoYWl0YW55YQ0KDQo=

