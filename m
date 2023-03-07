Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B777CC6FA99
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 23:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udG+gNRqfpNYX+FoUa/SvfJ5wk9fC3CMK6XmimvqKms=; b=RIyLBvZ0rzjZKViiMlYqhkOwpn
	QHhF/G2vuaGr8bZzH4pBSoYdZarU9hvEAv0WF1eW/yVhZfdNAHOQqzMZcobxeu/7BiA240Gr5osKt
	s6riRzl0v++TVmngpf/ABzoMCgLAxgO6IaE/OnYfFPe3nyH5DjTl5xEBQ0M1FwvYTFf13jkglW335
	yoxw6OZXmYFg+HO1OrK3UcuxUCSLUL7ok8YsEqFuGxDolF/BTP6+1GGhIFkILYDkFZr0KNRNBw1qb
	wOf8P+y7opalJny76UTr+X82veyaacfplvERORO97Qh/o9DQ77ePa8SMiv0u94YWgRa//Ndv9JBzP
	k7SVVWzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZh9z-002waQ-Bb; Tue, 07 Mar 2023 23:55:59 +0000
Received: from mail-co1nam11on2061d.outbound.protection.outlook.com ([2a01:111:f400:7eab::61d] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZh9w-002wa2-4y
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 23:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzYruh87ybIEPr9SOejElf9mcNyUCFRQFAO1wdgI6KKst8xWlM1LDtse57WmgGE2s7iqqMidUbFivjOLHg9k4X8cqLS+QOseEce9dRzD3Ab4Igrn/sat/Jk6a//SxBCVwnHKn/6NxEUa09UjmlG9tttp5vXSc9uygfVDTYC3PxFu5eS1x3D62SL8UcfQL8AO7O9/IOhr+qPDMJ2g5rZ2LYipBg6r2YzeikH3mh65z3xUNZDx+TCx9ksDvAtW5PqGGm7TMeM6b8mOQusdyFOCTbGRQq9F/E6ZSegB5tRml1ycDPZe/sz11NxIt245WNhfODnc62b4J1FWhX/ZXzlMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udG+gNRqfpNYX+FoUa/SvfJ5wk9fC3CMK6XmimvqKms=;
 b=Et3z2EFsUp+yTvtq9MzAF9GiWY8BfBOYXK6shbzz+RiGkd9l0iHLe9fMrtgQ77jS50CQndi75tE9D+GyPSUu/kF//1x8Xi5Cd/IC1gFUrZ6slhvp+tEdbbRjL3NZwWSj065PNL1nKzYl24bZG1WpQdo3JWi73n4K0uRC2yQNvL+SzyKT6V+4wR9tOXyHZDvsI8eLngJsJ4Qbpo89xhcND0+jI2jHwwqukKdh4YYmHiJC8koksdzbfpwfXxiuyInIH0wvElXqqInouwvjq1cIzKjYD8aoWMqXay19mPsn+4tc7GDeQjQ6sGKix3heTruUYr/GL1a/s8ixWJdA/M2afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udG+gNRqfpNYX+FoUa/SvfJ5wk9fC3CMK6XmimvqKms=;
 b=LyJCjj5JWSSbbQSA6wTGv7JhLYSzKsjn93wNFDMd49PQ1z+ak4xMeOatl2bfnjrpRzpIUq+n8NykWprRCVaDlbP4sqG5GuVXEdHOrmOtOzlJg8jMvOI2Pq1Lwdck6ZYYoMxRvewAUjWZlLn2F/fVFipsJQOyZBSIS+5RMvpbLB7E/yIJlwj80g1UCi2mX4Fj6FMwIvYb3pZ0fuZ/HbMpOmJze36KoCYpM6tHTEiUHE2XqsYfNDc7lBrjXVVyIx4ocwTYe3+I23EK95sZzoWjx4yhrBvVmjBMx87FPJx5VZizeatGlmkx4Lc224BnpBKbCF5gZ9Ud/k1avfrSLnDxVw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 23:55:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 23:55:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, James Smart <jsmart2021@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Thread-Topic: [RFC v1 0/3] Unifying fabrics drivers
Thread-Index: AQHZTBfUN4X8lnt0eUyvUQCunQlG167ps3SAgAWYs4CAALxbAA==
Date: Tue, 7 Mar 2023 23:55:52 +0000
Message-ID: <030c66e0-7d9c-7bbc-7442-b6f6f6ff5832@nvidia.com>
References: <20230301082737.10021-1-dwagner@suse.de>
 <e70f3b0c-5049-0bbe-fb13-41efc0425e0f@gmail.com>
 <20230307124143.s5ojphvt2wvdj2j7@carbon.lan>
In-Reply-To: <20230307124143.s5ojphvt2wvdj2j7@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4542:EE_
x-ms-office365-filtering-correlation-id: 72421853-1957-4bdd-0f97-08db1f677c2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xzspgLe6t/WQPpYhaGh0h0Lxe5xsRr1uPUefOpqV0P3bSey/otLuTlpuSZ4DfvCqvS4DL01Aq59te1p7TTU7mIGZ9ztLzqvmVlzSZndHsqBOTVXyoKwhGOoZ8OhJ+mWoI2oxNQDLRk/Bwtcg3Bf8mpZvFfrn/at/kqKW6CDuyQM3axUplQQeExv2+W3X4RXSe0eDYn7fTzwUWir+Qq9qM3Vsu8E2WElWCKSCERfJs1Y+NrDQ5J7pZqSdLxDvNS7MN2qHLPjBz9N9HrpVtHuyHmOXFRK4WElFc73xtf8ZGRA3wlCQ02qecN7MrnBzHJykQeH6W/msHomnpU2PU7EvlAerJMv/obku6e5kHxFNCQnnuORu/NJr0FaWAjXMlG+dDnjZu4HpeuWu4WNplh0ExwGztlENDLLtMKHDwBVuLoSOeRATRa3cIaUnPeZ+ik+d7NaEDqX5mXpgwVS2qER9mDvEicZ7QQMB+4m+McloH4WL7qkWMlMO6tB0ZMm13LlxR5CZ2/m+8jSUxQVVrYS52+IphqG5NvdqWWGjxqsqbDPQRHT7+aler87Y05wCh7R9pYpaKlCaH44LrXSlX76VQsccNgitKVSntDNty8Vb5tMUb0n68e18bM0vXKGWrCwWw7a/CcWpseU/yRb606z8Uwhc4bg3wCeH4YXaVC0W6wXQsy+HIL4rSM7JqgpvsOGYEx4MNlaanI04NL54vbxPtspDagsvuSmbWAI+5q/2blzsjoQRaRc9UgCAjpLIeMaYbkvlwgoC3bJ0GTzOpMB2qA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(86362001)(5660300002)(83380400001)(478600001)(36756003)(6486002)(2906002)(6506007)(6512007)(38070700005)(186003)(71200400001)(2616005)(38100700002)(66556008)(66446008)(64756008)(66476007)(316002)(41300700001)(31686004)(4326008)(8676002)(122000001)(91956017)(8936002)(66899018)(76116006)(110136005)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VGNGZHFPSzVXbHVsWStHNWRXVjlVM2JBMVdwcTBEbFF2T2VTc3prMm5xaUhM?=
 =?utf-8?B?TFhXNEVxemIrVk5yZEdVWlgxMHJIK1orLzIwcWRYdTFuNDRLL2VZN1dMZlFR?=
 =?utf-8?B?cmQ3SlZpUU85UTNFK0RUR2NyUiszd0RwUm1GNGxnejFhUEgwTkdzNzJCbDNo?=
 =?utf-8?B?ZXhnMlZQd1V6Y3pjQ2M0Q29PaWlkc2hsZmIvTUdEbTVjMWxrU1lOTkwyMkI0?=
 =?utf-8?B?T1lNbFlYUmptNHBRdGVWUkhmT2EvZVpYdE9SeTRMUUthazJtNVlVZmJzbDBQ?=
 =?utf-8?B?UWIrQ29COFA1c0VHNUhwcXN6LzBtWDN4ZnFXcVI1NUR2cDg2bnZKYnlVTm95?=
 =?utf-8?B?Z1VMMllZRE0ySWh1NThFM0lkRitBUzhBcjZSSzF6bmgrY2RPakFZTDMxVzAy?=
 =?utf-8?B?OUJhaUtwbzIyMVB1a0xqaHFnNzIxZUQ0Y2NHMFlwY1lHaHZVNUZjNmRpOENC?=
 =?utf-8?B?b2d0YjFXN20wcmpVUWllTnVsdzN4aysyNXJ5UVk0RUtJanBESERhaUE2R25Y?=
 =?utf-8?B?NXdUNmFBaGhJY3dkdXJtSGM0V0w1RzhyK2tONVZaSmlrb3RWSmlpcjJFUzRl?=
 =?utf-8?B?MkJIVkpMS0t5c1R2VDdlUlNxQnY1S0twWW1VdHJCV2NhZGhrV2taWW1QaHYr?=
 =?utf-8?B?Y0FhVmFwMzNweGNpNDNkTGFpdHRhVXRyWm42WFlHUXkySGs5S1BQVE1HcjV5?=
 =?utf-8?B?bHlSN3d6c2U3VExFdzV4VXRHKzEwR1lEd2JSNVMyaDZIcWl5NDJubjlIR0JB?=
 =?utf-8?B?Y0IzRWhISjhwdmVtTVptTFF3SmtRSDQxajFTSWJoTlFvK1l2ZVlFYXFIQmRp?=
 =?utf-8?B?VUp4OWd6SUNvQmJ0UUU0clp5SFZYUW9GODRIZUMvZTg2MVNzZkZLQTZBTnNi?=
 =?utf-8?B?dmprL2VVZ21KdFVFMWZudEJkWnNlZjloUnJXMjlrM1BYMlNKRUdHNjYwVWhD?=
 =?utf-8?B?Vlphc0pqYlZkdE5EZ0hBVkJrMHkvcW1aOUJWY0Qvd3E2R0VBSktaN3Rma3J5?=
 =?utf-8?B?b1h3c3U0aEh3ZGJrd21PSHhhamIzYnRHbWRiZTVuc28zb21nV09yaDdyWG1l?=
 =?utf-8?B?WXVjU05Pbi90Q1BmUEJZMnNBWDhRdU1oc0RsdGJNS0NTSTFFL2lyQkpmNzhq?=
 =?utf-8?B?c0E2eS93aVdRb0VyQVlnT0NMY1VPK1FNY3lCVWMxMXJJeGk0UmthSmxyU0dQ?=
 =?utf-8?B?bEtlTW5QcUI0eWw4bG03emp3a3V4Nnl1YTFkUVV0SGtDQW1tRHNsZlNqQ3VL?=
 =?utf-8?B?YTRFLzJ6NXNGOW8rZFlQenFIeWlXbllKZ0M5Q2ZvenhWYmt6YzNkRWtZM3Np?=
 =?utf-8?B?MEE1WkVzSnljN1M4TlRQVG5MTnVoeWVXRStIRHdiZlh5N25zSDFyK3p3M0VU?=
 =?utf-8?B?aDVndm1IUThoRTFpV1pERXRsWXRiSFljN1lWVXRXNEpCSlVCMVhSeEdlbzFT?=
 =?utf-8?B?UFpWclNSK0l6K2VWdFNqVXpzZnlUOG5qQUJiZFpnM1JGY3piZkV4a1ZCaGt1?=
 =?utf-8?B?VVVOVnFLdXNWRUd0bGNLc1RtcE53T0lQL2hQd09paU94eHRVVUVKaWtwSjQ4?=
 =?utf-8?B?MkFtZlp2djJvb2dtbWczckV0R1VGTUQ5VFRNYzduRGtuZlBsNXpYeVNCd1BV?=
 =?utf-8?B?NVdiV2dUdmhMclhwL0VvZEJEUHpEcURySHlxKzFVYmsxb2hoNUZkcmVITGt2?=
 =?utf-8?B?N2lQZW9Id1VrNDFielZQeHBzQ0pPY2M4eFV3QWVqNzk4L0VzOWt6dVY4MDEy?=
 =?utf-8?B?WDRTT1lTSlNUNlBDSkNmVlF6OFljRExnZ3BrcVFtM0tySTJpNXI3czA1ZTE1?=
 =?utf-8?B?K1hiM2dLOGROSFlEbklYcVE1eGVVV2ZTVngraDk1eGVTclliUFQ1WmtrWEJw?=
 =?utf-8?B?bkVqb3J5QWFja0d1dTF6ZDlEUHNGVG96UjZlMytsaDZ4a0xjQVdXSERXWUJs?=
 =?utf-8?B?TTlVbFNmWER2VzU2cCtGdlhUVEhVWjBVa3hWMFMwSGhIcW55WFdmaWJwZTVp?=
 =?utf-8?B?a0ZINm5acjErVkNUbmxHaW9wVGJodEJFTzVHRnh4em9jVTRwUUFvblJYeUVw?=
 =?utf-8?B?dnlJdlpSaHhwa0tBdjhCY1Q3THNranBJTkQ4dkNZTk5ZRFJja3EvNXFmQkN5?=
 =?utf-8?B?TXArQk9YVjVuMlRkMWlCOEl0YmdqNllqMXJRQUNzR3NlVzY3dGp0MmQ3K3pY?=
 =?utf-8?Q?mfGmE8fRnhnJoRec9SJQIsizBApYYan/iO0dPuB4ukFY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A32714A9F370B1469FD6D2778CC7B4D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72421853-1957-4bdd-0f97-08db1f677c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 23:55:52.8255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3f4B7ZVmQfgReAkyBPh9VJaQJ8l/MGrnk8Yldbn/LA3vxHP9tAkKfRN4pyW2Hv76zIsFq3/c2pPz18DNzm9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_155556_269943_95F6E347 
X-CRM114-Status: GOOD (  16.97  )
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

DQo+PiBzdGFydF9xdWV1ZSgpOg0KPj4gICAgY2FuJ3QgY29tbW9uIGNvZGUgZG8gdGhlIG52bWZf
Y29ubmVjdF9hZG1pbl9xdWV1ZSgpIGNhbGwgPw0KPj4gICAgICAgSWYgaXRzIHRvbyB0aWVkIHRv
IHRoZSBMSVZFIGJpdCAtIHRoZW4gcGVyaGFwcyB0aGUgcXVldWUgTElWRQ0KPj4gICAgICAgYml0
cyBzaG91bGQgYWN0dWFsbHkgYmUgZ2V0dGluZyBzZXQgYnkgdGhlIGNvbW1vbiBjb2RlIGFmdGVy
DQo+PiAgICAgICB0aGUgc3VjY2Vzc2Z1bCBzdGFydF9xdWV1ZSAtIG9yIGhhcyByb3V0aW5lcyB0
cmFuc3BvcnQgY2FuIGNhbGwNCj4+ICAgICAgIGZyb20gc3RhcnQvc3RvcCB0byBzZXQvY2xlYXIg
aXQuDQo+PiAgICBJZiBMSVZFIGJpdCBjYW4gYmUgZGVhbHQgd2l0aCAtIHRoaXMgd2hvbGUgYmxv
Y2sgaW4gcmRtYS90Y3AgbW92ZXMgdG8NCj4+ICAgIGNvbW1vbiBjb2RlLg0KPiBHb29kIHBvaW50
LCB0aGUgTElWRSBiaXQgaXMgY3VycmVudGx5IHRyYW5zcG9ydCBzcGVjaWZpYyB3aGljaCBpdCBk
b3Nlbid0IG5lZWQNCj4gdG8gYmUuDQo+DQo+IFdoYXQgd291bGQgYmUgdGhlIGJlc3Qgc3RyYXRl
Z3kgd2l0aCB0aGlzIGtpbmQgb2YgY2hhbmdlIGZvciByZXZpZXc/IFNob3VsZCBJDQo+IGFkZCBz
dHVmZiBvbnRvcCB2MiBvciBzaG91bGQgSSB0cnkgdG8gYWRkIHRoZSBjb21tb24gY29kZSBmaXJz
dCBhbmQgdGhlbiBtaWdyYXRlDQo+IHRoZSB0cmFuc3BvcnRzIG92ZXI/IFRoZSBjdXJyZW50IGFw
cHJvYWNoIHdpdGggbW92aW5nIGFuZCB1cGRhdGluZyBpbiB0aGUgc2FtZQ0KPiB0aW1lIGlzIG9i
dmlvdXNseSBhIGJpdCBoYXJkIHRvIHJldmlldyAoYW5kIGhhcyBhIGdvb2QgY2hhbmNlIHRvIGlu
dHJvZHVjZQ0KPiByZWdyZXNzaW9ucykuDQoNCnBsZWFzZSBhdm9pZCBpdCBtb3ZpbmcgYW5kIHVw
ZGF0aW5nIGF0IHRoZSBzYW1lIHRpbWUuLg0KDQpJJ2QgZmlyc3QgZG8gYSBwcmVwIHBhdGNoZXMg
YW5kIG1vdmUgdGhlIGJpdHMvY29kZSBhcm91bmQNCmFuZCBlc3RhYmxpc2ggdGhlIHN0YWJpbGl0
eSBvZiBjb2RlIHRoZW4gb25seSBJJ2QgbWFrZSB0aGUNCmFjdHVhbCBjaGFuZ2VzIGZvciB1bmlm
aWNhdGlvbi4uLg0KDQotY2sNCg0KDQo=

