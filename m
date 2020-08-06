Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:59:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DF723136
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELBd/xoZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="EJy1CqJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF723136
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W2oyLvIlQmG+29GL0mgx6NJu9sxvuGe2ACJ8Vxj9sp4=; b=ELBd/xoZWfO8x/Lf3Hk2lMYKA
	1XM7jXGcvLH5zBF4Tscsl0Wakbp43mRVtPoolNZIXHuulFynvRnWXgS9XgFgcBzlgAPqW7skarSc5
	4Il3Sf3OBEaFj+mYtSiTgwjCp2j1bO4ISKVFBm3Y2TZBrYwzH1j9qlWJlfGmFlhoBBMbdKS/FhHa3
	oBEuM2HIxhp0GYtec8Bm4m5ds+SLeNunVWWv3Hu4iwP2/RX3t2zHezBjx1usofVmOT/yKf8gDpxFh
	HY0+HgrRfKT83iYtPf9diBJyxDs1XxgsvzutwgPPijupA2t+eRpcpykJ2bjc6TjXkdcvhwxBgI1eh
	Cpo/TrrJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3iJ1-00041d-1T; Thu, 06 Aug 2020 15:59:47 +0000
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com
 ([40.107.244.51] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3iIy-00040y-Oh
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 15:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp1SL14UaQMl5IvcnSh0zdh2BOSpezsYnUY930qjqOBN+8j16T4GWsmTkfoLbLBZdaKUlc19JSpAMODyMmWTwDyDzlliHvgK9KzIgp8i/1pDdl6uDk4g3tdOBVbcwZf4MOmmDBk+tQ+8uWm5mSKq7Eu4Neb8uqnLjTjOLh6moN82GJrcSlxzh7ejTagOEAC+URVpgt0J+GDV94uA0ugCcLqPFS7Y+/EbphyzCSGlr6rOACAoJH3bEQpeVkHcny5Mhn4FQqQDSiNLivHzufnTZ8QP/Z/aYleSKF4f0legGQbOH0EqJhe4tcQHQnPVzDZOw2W2QKGQ8PqTjlziSD9mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIV5/SMgEj00yqiOmuKwJrlD7stZwbZXB0hLbpFINPY=;
 b=b0HqU3ofsLTYwY918KcqxDXdelgM8CBxAiitAdyEckWYoWbNgQRM0aB3E7sXkV0DAdmxM3ipVxR3YOIBE3CUfB9IxjVb57KV8T8qfMsoUYogsZ3KP7+OvWpvxDfwTKHDHC12RXp6OCbFnLSed2oxi1iUxj2cSm87laLUoa9O44JmlCVKcG6hUIRdCbRSasHrJY7U0yKPqJ+Ftn7w5dxcAtXyJ2sHTGRQnnYMh7LyKgiV4ENbWZdBMJHNNs1FgczbLuTgrqDs4eIKE6zeSFoQ4SgmGx+uCdFQz9O6ofSdkkQxX5snNxRGq/XZax4zaE9KwaZE3Q+GVAaaqUiHO8TIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIV5/SMgEj00yqiOmuKwJrlD7stZwbZXB0hLbpFINPY=;
 b=EJy1CqJnbu84e1F+/zOZyeyXtoNSp4piZoIU8S3BSUEtvLUS/f0xChWcAkSQUjyoKxSYl2L/bu0NqT9GUzk8wQbanJIIFdXuYdTGszWCyV/lYKC0gpDF2dpj4DHZIfYZMGkWGciqLk5bkxy4jP4ORulrKl9yS6mzYAwKV6KoIvc=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN6PR06MB3538.namprd06.prod.outlook.com (2603:10b6:404:110::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 15:59:41 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 15:59:41 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Thread-Topic: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Thread-Index: AQHWY9sika+Y39+nU0e0JHeDBPsDKakc2lUAgAEFHICAADORgIABTLEAgAm/SwCAAJOagIAA8UoAgACPiID//9cAAA==
Date: Thu, 6 Aug 2020 15:59:41 +0000
Message-ID: <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac7092d-b22c-4913-8ab5-08d83a21bab9
x-ms-traffictypediagnostic: BN6PR06MB3538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR06MB35389FAD6EFE74A86EA16E6BE4480@BN6PR06MB3538.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8ApO3azXBI9ZqgYqjUixZNxBAaOSZM6ynJWpvzHRt6mDPyfXFj25kXNPX28o7ADrn2OFhTUpGraOSasZ0G9Ka1oQH1xEtQ108W4VmSura5Sll6utC5/2nVLwBr0iTNOdiiisyZJb4F3YWc2DxZO3dAvS3J1beqKJ7xisGb8lwUEumx1k7tB3QrhXErEWqsi7BegP9bjbUt34gjOcHDeEVis1aE81bUBDViFSjOIECw6GwmpQgxmD7bfspSSmGDX90R9GGJ8W3vGzrwWSSIcXeRYvCeI3Qgz++lLjZC3PEjTgGO0hGizRYOpuNW1jDBdJ6OxZKpmJ6jpwFacXfcmi5B0qVXOWldrOB076iXfyqvCESkU9P/Q4TIhPSOdbVzNQOGMqHbWBUWK3nET54kdDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(4326008)(83380400001)(5660300002)(8676002)(8936002)(53546011)(26005)(478600001)(6506007)(6512007)(316002)(54906003)(110136005)(2906002)(6486002)(33656002)(66446008)(64756008)(66556008)(66476007)(86362001)(2616005)(91956017)(76116006)(71200400001)(36756003)(66946007)(966005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BEpc6l3rK0II09nQEi5WcCNiq85Z8KQErBE15EGGti8avOq0gftXIY8dtS/o9Ziz6eW2eoZsce/9mp+N+cKW3NY9YdTkEM0tWTN3zg0ktEjz1dR/HCQ47H4rSBAGz7wN4adsh3ncCWs3w/9HEG1qvyLtR+Pjaw51O09Pg1vmczPpyyzzlbDJ7QcuqQoFnQVewkbBzTeIRGzRRL3xyAKOip5kdAVSLQvj61y2SIc/m6KkoM+d7/fo2mAXDbOpFFTVWJCH2hkTfXAUeHhFKtcNxucLJkJEQNytIPXZUhBKBHgwcgq4rQM8w8VII62Pcbm0A8xgO9rEA7PYl1WBmAbNEUjKA895sLCIhHxFMzgjTTlO348iRGyRduo1ZwSOspCsmRE8aaE/Ot8WTsKMh6pWjazA4jG5uDoZ4tceuqkjZQcaMoNheVP0Ab2eS766nlFNHgvQESsY3TnSwBfw99g+ICEgJVGss9gzeY6gJS80nKnByvCsyfljj/bKQaKzVSogwLYlkq75cESqkKna5RWHOttji7YmhJ4xfg6Isy+UEbCBoKqWie4vtSV06CnBTq3TCLHkoWAwypTKiggiQoK3j6PA0eCaYpeToXSWwmcjplRBqmHpyqMTQLEfkcsA99W48oE4tu4+/LYhRQ1miWTraw==
Content-ID: <6CEA140CF53FB44F88A2AA9986CAB348@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac7092d-b22c-4913-8ab5-08d83a21bab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 15:59:41.1730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fJseWNIhMu+6UuNIsj/dChn2AK3ffVQFOrBCVyeXNkGdazXXxJDEqiGebjsoVRlWmWQHVebA4V4EamCT9bi2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_115944_937682_002223F8 
X-CRM114-Status: GOOD (  19.47  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Ewan Milne <emilne@redhat.com>,
 Hannes de <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhbmtzIGZvciBjYydpbmcgbWUgb24gdGhpcyB0aHJlYWQuICAgVGhlIGVtYWlsIGZyb20gdGhp
cyBETCB1c3VhbGx5IGdvZXMgaW50byBhIGZvbGRlcg0Kc28gSSBkb24ndCB3YXRjaCBpdCB0b28g
Y2xvc2VseS4gIENjIG1lIGRpcmVjdGx5IGlmIHlvdSBuZWVkIG15IGF0dGVudGlvbi4gVGhhdCB3
YXkgdGhlDQplbWFpbCBzaG93cyB1cCBhdCB0aGUgdG9wIG9mIG15IGluYm94Lg0KIA0KPj4gT24g
OC81LzIwLCAyOjQwIEFNLCAiQ2hhbyBMZW5nIiA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4gd3JvdGU6
DQoNCj4+IEpvaG4sIFdhdCBkbyB5b3UgdGhpbmsgYWJvdXQgaWYgZGVsZXRlIHRyYW5zbGF0ZSBO
Vk1FX1NDX0NNRF9JTlRFUlJVUFRFRA0KPj4gdG8gQkxLX1NUU19UQVJHRVQ/IFRoYW5rIHlvdS4N
Cg0KSSB0aGluayByZXR1cm5pbmcgdG8gQkxLX1NUU19UQVJHRVQgZm9yIE5WTUVfU0NfQ01EX0lO
VEVSUlVQVEVEIGFuZCBOVk1FX1NDX05TX05PVF9SRUFEWQ0Kd2FzIGEgcG90ZW50aWFsbHkgbm9u
LWJhY2t3YXJkcyBjb21wYXRpYmxlIGNoYW5nZSB0aGF0IEtlaXRoIG1hZGUgaW4gcmVzcG9uc2Ug
dG8gYSBwcm9ibGVtIHRoYXQNCkkgcmVwb3J0ZWQgaW4gcGF0Y2ggMzUwMzhiZmZhODdkYS4NCg0K
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC9jb21taXQvP2lkPTM1MDM4YmZmYTg3ZGENCg0KSSBkb27igJl0IHRoaW5rIGl0IHdv
dWxkIGJlIGEgbWlzdGFrZSB0byBiYWNrIG91dCB0aGlzIGNoYW5nZS4gIFdlJ3ZlIGhhZCBhIG51
bWJlciBvZiBwcm9ibGVtcw0KaW4gdGhlIGRpc3RyaWJ1dGlvbnMgd2l0aCBkbS1tcCBhbmQgb3Ro
ZXIgbGVnYWN5IGNvZGUgZ2V0dGluZyBjb25mdXNlZCBieSB0aGlzIGNoYW5nZS4NCg0KPj4gQkxL
X1NUU19UQVJHRVQgbWVhbnMgdGFyZ2V0IGhhcyBjcml0aWNhbCBlcnJvci4gTlZNRV9TQ19DTURf
SU5URVJSVVBURUQNCj4+IGp1c3QgbWVhbnMgdGFyZ2V0IG5lZWQgcmV0cnkgaW8uIEl0IGlzIG5v
dCBzdWl0YWJsZSB0byB0cmFuc2xhdGUNCj4+IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIHRvIEJM
S19TVFNfVEFSR0VULiBNYXliZSB0cmFuc2xhdGUgdG8NCj4+IEJMS19TVFNfSU9FUlIgaXMgYWxz
byBub3Qgc3VpdGFibGUsIHdlIHNob3VsZCB0cmFuc2xhdGUNCj4+IE5WTUVfU0NfQ01EX0lOVEVS
UlVQVEVEIHRvIEJMS19TVFNfQUdBSU4uDQo+PiBXZSBjYW4gZG8gbGlrZSB0aGlzOg0KPg0KPiBC
TEtfU1RTX0FHQUlOIGlzIGEgYmFkIGNob2ljZSBhcyB3ZSB1c2UgaXQgZm9yIGNhbGxzIHRoYXQg
YmxvY2sgd2hlbg0KPiB0aGUgY2FsbGVycyBhc2tlZCBmb3Igbm9uLWJsb2NraW5nIHN1Ym1pc3Np
b24uICBJJ20gcmVhbGx5IG5vdCBzdXJlDQo+IHdlIHdhbnQgdG8gY2hhbmdlIGFueXRoaW5nIGhl
cmUgLSB0aGUgZXJyb3IgZGVmaW5pdGlvbiBjbGVhcmx5IHN0YXRlcw0KPiBpdCBpcyBub3QgYSBm
YWlsdXJlIGJ1dCBhIHJlcXVlc3QgdG8gcmV0cnkgbGF0ZXIuDQoNCkFncmVlZC4gVGhlIGhpc3Rv
cmljYWwgYmVoYXZpb3IgaW4gbnZtZS1jb3JlIGhhcyBiZWVuIHRvIHJldHVybiBCTEtfU1RTX0lP
RVJSIHN0YXR1cyBmb3IgYWxsIG5ldw0Kb3IgdW5rbm93biBOVk1lIGVycm9ycy4gDQoNCu+7vy4g
ICBPbiA4LzYvMjAsIDEwOjI2IEFNLCAiS2VpdGggQnVzY2giIDxrYnVzY2hAa2VybmVsLm9yZz4g
d3JvdGU6DQoNCiAgICA+IE9uIFRodSwgQXVnIDA2LCAyMDIwIGF0IDAxOjUyOjQyUE0gKzA4MDAs
IENoYW8gTGVuZyB3cm90ZToNCiAgICA+IE5WTUVfU0NfTEJBX1JBTkdFIHNob3VsZCBmYWlsZmFz
dCwgYmVjYXVzZSByZXRyeSBjYW4gbm90IHN1Y2Nlc3MuDQoNCiAgICBUaGUgRE5SIGJpdCBpcyBo
b3cgTlZNZSBjb252ZXlzIHN1Y2ggdGhpbmdzLg0KDQpJIHRoaW5rIHRoYXQgTlZNRV9TQ19MQkFf
UkFOR0UgaGFzIGhpc3RvcmljYWxseSByZXR1cm5lZCBCTEtfU1RTX1RBUkdFVCBzbyB0aGF0DQpz
aG91bGRuJ3QgYmUgY2hhbmdlZC4gIEkgYWdyZWUgdGhhdCBETlIgLSBhbmQgbm93IHRoZSBuZXcg
QUNSRSBtZWNoYW5pc20gLSBpcyB3aGF0DQpzaG91bGQgY29udHJvbCB0aGUgY29tbWFuZCByZXRy
eSBiZWhhdmlvciBpbiBOVk1lLiAgDQoNCiAgICA+IE5WTUVfU0NfTlNfTk9UX1JFQURZIG1heSBy
ZXRyeSBzdWNjZXNzLCBidXQgdGhlIHByb2JhbGl0eSBpcyB2ZXJ5IGxvdy4NCiAgICA+IE5WTUVf
U0NfQ01EX0lOVEVSUlVQVEVEIG5lZWQgcmV0cnksIGFjY29yZGluZyB0byBwcm90b2NvbCBkZWZp
bmUsIHJldHJ5IHdpbGwgc3VjY2Vzcy4NCg0KICAgIElmIHRoZSB1cHBlciBsYXllcnMgc2V0IGEg
cmVxdWVzdCBzdWNoIHRoYXQgIm5vcmV0cnkiIGlzIHRydWUsIHRoYXQncw0KICAgIHRoZSBiZWhh
dmlvciB5b3UncmUgZ29pbmcgdG8gZ2V0LiBTcHJpbmtsaW5nIHNwZWNpYWwgZXhjZXB0aW9ucyBh
cm91bmQNCiAgICBpcyBub3QgYSBnb29kIGlkZWEuDQoNCkkgYWdyZWUuIEkgdGhpbmsgdGhlIHBy
b2JsZW0gaGVyZSBpcyB0aGF0IHRoZSBjdXJyZW50IEJMS19TVFMgYW5kIEZBU1RfRkFJTCBtZWNo
YW5pc21zDQp3ZXJlIGRlc2lnbmVkIHN1cHBvcnQgbGVnYWN5IHByb3RvY29scyBsaWtlIFNDU0ku
ICBUaGV5IGFzc3VtZSB0aGF0IGFsbCByZXRyeSBiZWhhdmlvciBpcw0KY29udHJvbGxlZCBieSBv
dGhlciBjb21wb25lbnRzIGluIHRoZSBzdGFjay4gIE5WTWUgaXMgcHJlc2VudGluZyBuZXcgcHJv
dG9jb2wgZmVhdHVyZXMNCmFuZCBzZW1hbnRpY3Mgd2hpY2ggcHJvYmFibHkgY2FuJ3QgYmUgZWZm
ZWN0aXZlbHkgc3VwcG9ydGVkIGJ5IHRob3NlIGxlZ2FjeSBCTEtfU1RTDQphbmQgRkFTVF9GQUlM
IG1lY2hhbmlzbXMgd2l0aG91dCBwYXNzaW5nIG1vcmUgaW5mb3JtYXRpb24gdXAgdGhlIHN0YWNr
Lg0KDQpTbyBJIHRoaW5rIHRoZSBiZXN0IGFwcHJvYWNoIGlzIHRvIG1haW50YWluIGJhY2t3YXJk
cyBjb21wYXRpYmlsaXR5IHdpdGgNCnRoZSBleGlzdGluZyBCTEtfU1RTIGNvZGVzIGFuZCBzZW1h
bnRpY3Mgb3IgY3JlYXRlIG5ldyBlcnJvcnMgYW5kIG1lY2hhbmlzbXMNCndoaWNoIHdpbGwgcmVx
dWlyZSBuZXcgc29mdHdhcmUgdG8gaGFuZGxlIHRob3NlIG5ldyBlcnJvciBjb2RlcyBhbGwgdGhl
IHdheQ0KdXAgdGhlIHN0YWNrLiAgIEJ1dCBkb24ndCBvdmVybG9hZCB0aGluZ3MuDQoNCkpvaG4g
TWVuZWdoaW5pDQpPTlRBUCBTQU4gVGFyZ2V0IEFyY2hpdGVjdA0Kam9obm1AbmV0YXBwLmNvbSAN
CiANCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
