Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07AFC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJuHujUbIDDk7tyygz5kiD5ckBQ8SeObH5c/y7Rwo5A=; b=nqcOi6JfRt1lFmIMnkaapzyqaY
	eUO76dxsHhTDlGWuoaj76I7Ce0Ga7razDhHb2FJxGeYF9IqogHLnvrku+VZMHMXFrkdhs6aBbZRJp
	/EP7zSMKvN82Eo6FAwYV4ri4VySVJ1HfJER5aJjda7gEpoypbtnvZCyyJwpSJipMysBqDDKhCblme
	2Y5MxKVOqi9S4Y+LYIaAW6rHMTipoAiXnJpPqXr8iSZK8q1gLXwEy1AiZej2ioOzOJirD7sUaclHk
	kXhE+4thRpmS+zQgjEH74ZVrVUaFlR+GaFOhqixBpy58Vfee76zfKnh5vfZSgZ7305iC/bHkNM7s7
	/nVEYJYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nThTv-004pnY-Gg; Mon, 14 Mar 2022 09:59:15 +0000
Received: from mail-he1eur04on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::706]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nThTr-004pmp-Nn
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 09:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+V2kQkKFrY/JXb+nEai5DMg0DPcZ3lhMzj2PepKPyQlEelknbJVtwQZHjl/ywrwgIc42lvyM3WyG45OxkwzW58G1RuyTZ49pkEnNURNWUC8jj7z2hmZ0kDyOSsZRYKkjOuAcninXoLDsyl1dAIn2PCYhGitfZ05To++ekscsT9HAD8WBAffrVMkndDu+I6wd2McYVksugOjlABrMyBBZM4WDoolYsSaRnggaS8tmG3WpyMnelMFlqAA3mjW1CnagHa9od8o4901aIW96292TKzT2ZZC7NiCmAALsytMSJMJ0T4mq4o5PEuJgvboExtPNiD/OFTDNWAY/0QVe23NMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJuHujUbIDDk7tyygz5kiD5ckBQ8SeObH5c/y7Rwo5A=;
 b=Q1VE1PpAskWtfNnRNHPRzfpzrmkPeK8dYXkYZT538fx+FecYb5LC26Ib3Ms4HsWcAMxZio5agrUSIyYOjhFE8N+AAkfdpA8xWGDXJOBy3mka5pybb4GIBUjyuQJYz1xhqJVV9fTF0ZFloXLZHDetPj+4pTmM1gPLQZKIMSYeRONLLIuqbsjw0p6jgx0emzSAtdP6u39ZjyqhjBWafmQp+ATEPrIcFQK4UsaaxHnA/nqdHD1I/qqswjrqkwxa6OqY1SphV223BePY8K+TLFqxeOFsTxSI6QN0xMwVoDrN2654ryzL31lB0hEFL0YBRH53z006t4Dj9OAfP13/jwm5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJuHujUbIDDk7tyygz5kiD5ckBQ8SeObH5c/y7Rwo5A=;
 b=vGkYnXpqLC0GKgTKEZ6BJlKFv1nXwbrliWmFGDinwVnMmI9Kke7ZPiAPQuRwWZ0vk2etQqHWz0Hip8PVEgwCUKI8ooKzyI+rrw4+gjOHD8w/KMDG1KUS8eaDSWAGhBtjim9Ya5n/bwjH5rsDJN59HvAinSocuczYcaPfqbi/1vY=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AS8PR03MB7480.eurprd03.prod.outlook.com (2603:10a6:20b:2e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 09:59:06 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::2103:dc1c:7340:99c0]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::2103:dc1c:7340:99c0%4]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 09:59:06 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Nvmet discovery implementation. Questions and a patch / proposal.
Thread-Topic: Nvmet discovery implementation. Questions and a patch / proposal.
Thread-Index: AQHYLMHAwgvLeF+Fd0CKKBhqcX4jT6yqG/oAgBPMUgCAAKBpAIAAQtEA
Date: Mon, 14 Mar 2022 09:59:05 +0000
Message-ID: <0F02C2B2-B1F6-4034-8AF5-467C116969F9@primelogic.nl>
References: <1B761FBE-58C8-4A52-9747-42ED84A6D383@primelogic.nl>
 <5109f07b-b99d-5e3b-f5b3-410fbbbdfcd4@suse.de>
 <2cc90ad6-6422-0ef0-005e-a1ec09caf894@grimberg.me>
 <7e294198-b8ef-2d4f-944c-353792cc27d9@suse.de>
In-Reply-To: <7e294198-b8ef-2d4f-944c-353792cc27d9@suse.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef12ae3-fad1-4b32-53e6-08da05a146d4
x-ms-traffictypediagnostic: AS8PR03MB7480:EE_
x-microsoft-antispam-prvs: <AS8PR03MB7480872D584CFD08D2482FC2D10F9@AS8PR03MB7480.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POFIJzBJ9tCOURuggMybXLwbRHu12pI7ZedyIZrdr1RMxepEX3ewYdZBInXRwRYpkT3TjD974cnzXrevQ4yLxZ4RDJ0UAAHFyu0A+8LBkUo54NfYK9r/xVVbdY5zvGW2fRwewLzBaHQEyHbMEdkroIychFcLoLMWn5CarFZ3FCBom4z+5fYaa2PZ9dVLphtYwCVCHYxo3NnCWuZ/hj58j4A4D1fhhVdwEbe21e3SmMrVz8KYlepUFA20dHbGT+36l80gBFJF7bhPVxiS+TsFhr1t/flTaXw6OyNa9UNLkbITrClnzffeRpJvFKXDFmFbJGp4tx7+kmfBM0Lq1dpI4hPKlO11n60z0ByXqntWBoQb5pqkIJGT/lZkJcZs2B0WlvbEtoNqZDTc3bsHZkV4fyJeBoAf+jTlWsyK2WtY4a2uMEbIL81JkDQpcIKRc08kzrL4yZdADjXTyIkIhKqwBDC6VqqZ5V9wh4jP+B8IikRNxg3WcVwS0VNgF9SHkbTgH7aRFEHDp6y4XmWtn38QsNEr0GhrF8dTxH72FPnMui4eCvsRKQyW7Ioq/Z8OllLCdZpAy3koaCr51Mu+gtas/tUPjsZZ9Zmk8Bef5kvj7WkAZ0tksctJsUHZN6fMWnP0mN2TkQRH7FyFi81l54RNsPi436hnjI2KH9u+y5EOympBmY9R2J3aM8bQCMhFFf233W7AAbXYjb8SZbkE7Vduo1VZ1FATAdWtBvmmDvPjYoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(39830400003)(376002)(346002)(396003)(366004)(136003)(86362001)(2616005)(33656002)(122000001)(8936002)(6486002)(110136005)(38070700005)(5660300002)(83380400001)(6512007)(6506007)(316002)(66574015)(36756003)(186003)(26005)(76116006)(508600001)(66946007)(53546011)(2906002)(91956017)(8676002)(71200400001)(64756008)(66556008)(38100700002)(66446008)(66476007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZQVXAyNFQyZkQ4Sk03VlZQSFpCQ3FPQkRTNFVMaGFvMEU5bTBRS0VIYUNx?=
 =?utf-8?B?cUVGQkc1a3E1NklNSGhtdmpiR3JFek1QcTE5czVGVC9vTm1hd2x4R0p5QXd0?=
 =?utf-8?B?elg3cDhkTFdFQkh6U1FTNVdTR3RUMnVkSy9lcHl5V21DZ1c4cWU2bk9DOERP?=
 =?utf-8?B?N0l2cFlPemFRaFVJQkp4RmVoNWt5Q0kxZnRpNHBRcGxHNWMyTkZyRkNpdXRS?=
 =?utf-8?B?eUVmR2wzVCtGaFVkTXpWZkxCSDU4Y2dzNW16NWRuZG54L0dYNEN6M3ZDMUZs?=
 =?utf-8?B?TFlGcGMyS1JNeUQ4RHZrRkNCZmNzbDZVa2o1RS82bnYrakNZRGtnVUhMT0Vq?=
 =?utf-8?B?cEdITTlnVmZJdHhzRzB0VXlFQlFYUXFtdXFXMExwWk4zbHBxb1ZxUmdkL2t4?=
 =?utf-8?B?SDVIaVJKdDJPR1VqVjYxUmlVNisvMVcyRHB3ZU40eHFPeVN4VzhaY2RFZnRp?=
 =?utf-8?B?M0JQSmErVHdpdjRLRHV0TlVFd1YraU01WFB3MjJzcmx3cWJSa0hwRnFwMTli?=
 =?utf-8?B?SW9paDRzWjdRSzVGbFlObUhqNG1RZm9YZ29KS1JwR1BBaCtPcGZxalBuWktB?=
 =?utf-8?B?WHFreUZRTjJrQzkvckl2Ui9JNUlsRzZZaDVEd3RtUFhPVTFDM3R1SFo1RVNv?=
 =?utf-8?B?NlJGU2lWSWtZb21UNFBjMzJ1QitpTnRMSWxMY2pTY0U5dkNuWGg4RDFUendB?=
 =?utf-8?B?bDc0cGQzR3hYQ1AzN0MzbWlVWmxWbFBlSGtuRTdZSGRlNFdBTlErbjBwTThi?=
 =?utf-8?B?cG1lMjA5WlpYU29ZbmpSS3ZSUEVRN2JNeHVoblozemdFTHJ2N0N6aWNCdHFn?=
 =?utf-8?B?N1BheHp6ZE5qOWFGMHJJbzNDVURHV0c0a1VpSHFrMjc5NWUxbnNnNlBuZDRK?=
 =?utf-8?B?SkEwMGVKR1RyWXJlU3ZNMVRLYTBFWUVyUUR4Um5odzRUZi9lbU5FanpFbkcy?=
 =?utf-8?B?ekJjNmkrQUY0Zko3djZDeEY4cnFhS0lnM055aGh2VnlYM0hZMm1CMWZycCtI?=
 =?utf-8?B?YW1MYUVhR1dNZm1jOXZFdmp5MnhSYS9NNW1NeHhCZXVJaUhWQnA0SXd5R2Q0?=
 =?utf-8?B?RXR5QVVQRmFqaFl0dUlIbWhKdnFyNlhOMHplckhvRU5kTjBIeFdlalArdFZ4?=
 =?utf-8?B?TTlhY1F0dnIva0JlQ2lzditPaWo2bGF6VDg5eWNSY1dnWVNGS2ZzWHphZDBQ?=
 =?utf-8?B?Y1pXU3VWZkVOZnZoSlQyRHdYcWdlTy80RHMwcER6d1B5QWpGUWtEMktZZkN5?=
 =?utf-8?B?SFl1MDkrR0RkRDlJVjRsZzl1Qi9MbmV2d1UvakFDOTc1K0JPRnJzYVpXZXN4?=
 =?utf-8?B?RmtjblYvZ3JUZVhRM0tTUzcyM2JFSHZsa0QzQ0ROVFlWcWl3ZjNNM284bzQ0?=
 =?utf-8?B?aFRhQ0hkcWNiOGNxT3J1SmduOTVya1V1VUFzRXNlbUFVQlBNU3hlVmZTR2Nh?=
 =?utf-8?B?aWxxS0dPaVpob2t2cTFHbGl4WkM1RzhEVHZSZ0VHNzdZb0xTVC9WSmdCTmYr?=
 =?utf-8?B?ck93SXY3L1RUN3NmaTNKZTBNUjRtNnpDSHdSak1BQzYvcjdpMHY0WVY5aGlY?=
 =?utf-8?B?Nk1WTjVvOEl5RlRIMEMydzhVRXo2c0ozOE8vSGNtRTBrYkJPZXA3QlBuWTdq?=
 =?utf-8?B?TEhIdGdBcEZCWksrOFVrMlo1TXJtWFVqa09DY29qNzYxOE44SUVXRTJSVFdO?=
 =?utf-8?B?Tmp6TGxzU2VFVUhDanM4Y1hIZENIcnNiZzhKSVphU0Vyem9qVWZFK1JCM2dl?=
 =?utf-8?B?RGFCM0dHVTk2Q3R4TTNiYkxKSXEwOXFPOTR4RW5YdlR3M2pSa1NUM2dYRU1i?=
 =?utf-8?B?QkNxSTNtMEs4TjNxN1pOUDBYU241ZmRYVnFhK1dRZ1E4U2hBNHlGVDJ5Mk9Y?=
 =?utf-8?B?cHNTNnNaVDlYSUEwZkRabmNDcHk4UTQ2RFhnalFub29ScEhSWWtocVZSQXlr?=
 =?utf-8?B?OFNwNjUwZXhqSW5VRWxsbE1LRlJZcHRoK2JVbkt0RmxpZk8wN2ROcG1nWGlF?=
 =?utf-8?B?Vmc5UmpDbUt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1354447EEE11E0449B6EDC3EE3859FD1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef12ae3-fad1-4b32-53e6-08da05a146d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 09:59:06.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86XYkLaEnC2/yugKmH1FpJydYh3Hwc/1waDioHgFrGsv8T6uGxP8US9rblfyBMewJMLtaXVp+kQY6lv+xRedhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7480
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_025912_049105_9E63EC04 
X-CRM114-Status: GOOD (  29.48  )
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

ICANCj4gICAgQWN0dWFsbHksIHdlIGNhbiBqdXN0IGxlYXZlIHRoZSBleGlzdGluZyBtZWNoYW5p
c20gYXMtaXM7IHBvcnRzIHdvdWxkIA0KPiAgIG5lZWQgdG8gYmUgbGlua2VkIGV4cGxpY2l0bHkg
dG8gdGhlIGRpc2NvdmVyeSBzdWJzeXN0ZW0uDQo+ICAgIFJlYXNvbmluZzogTm90IGV2ZXJ5IHBv
cnQgbmVlZHMgdG8gcHJlc2VudCBhIGRpc2NvdmVyeSBzdWJzeXN0ZW0sIGFuZCB3ZSANCiA+ICAg
bWlnaHQgd2FudCB0byBoYXZlIHBvcnRzIHdoaWNoIHdpbGwgX29ubHlfIHByZXNlbnQgdGhlIGRp
c2NvdmVyeSBzdWJzeXN0ZW0uDQoNClRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUgc2luY2UgaXQncyBh
IGZsZXhpYmxlIHNvbHV0aW9uLg0KDQpNYXliZSBzbGlnaHRseSBvZmYtdG9waWMgYnV0IHNvbWV3
aGF0IHJlbGF0ZWQ6DQpMZXQncyBhc3N1bWUgdGhhdCBhIHVzZXIgd2FudHMgdG8gdGVtcG9yYXJp
bHkgZGlzYWJsZSBpbml0aWF0b3JzIHRvIHVzZSBhIGNlcnRhaW4gdGFyZ2V0Lg0KRm9yIGV4YW1w
bGUsIHdoZW4gd29ya2luZyBvbiBhIHN3aXRjaCBvciBjYWJsaW5nLg0KIA0KVGhlIG9sZGVyIChJ
RVQvU0NTVCBhbmQgc28gb24pIFNDU0kgdGFyZ2V0cyBhbGxvdyB0byBlbmFibGUvZGlzYWJsZSBh
IHRhcmdldCBwb3J0IHVzaW5nIGEgc2luZ2xlIGF0dHJpYnV0ZS4NCkZvciBleGFtcGxlOg0KL3N5
cy9rZXJuZWwvc2NzdF90Z3QvdGFyZ2V0cy9xbGEyeDAwdC8yMTowMDowMDowZToxZToyOTphMDo3
MCAjIGNhdCBlbmFibGVkIA0KMQ0KDQpUaGUgY3VycmVudCBudm1ldCB0YXJnZXQgaW1wbGVtZW50
YXRpb24gcmVxdWlyZXMgdG8gdW5saW5rIGFsbCB0aGUgc3Vic3lzdGVtcyB3aGVuIHlvdSBtZXJl
bHkgd2FudCB0byBkaXNhYmxlIGEgcG9ydCB0ZW1wb3JhcmlseS4NCldvdWxkbid0IGl0IGJlIG11
Y2ggZWFzaWVyIGlmIGVuYWJsaW5nIC8gZGlzYWJsaW5nIGEgcG9ydCBpcyBhbHNvIHBvc3NpYmxl
IHdpdGhvdXQgdW5saW5raW5nIHRoZSBzdWJzeXN0ZW1zPw0KVGhlIHNlY29uZCBwYXRjaCBJIHBy
b3ZpZGVkIGFsbG93cyB0aGlzIHdpdGhvdXQgYnJlYWtpbmcgZW5hYmxpbmcgdGhlIHBvcnQgd2hl
biB0aGUgZmlyc3Qgc3Vic3lzdGVtIGlzIGxpbmtlZC4NCg0KVGhhbmtzLA0KDQpNYXJrDQoNCu+7
v09uIDE0LzAzLzIwMjIsIDA4OjAwLCAiSGFubmVzIFJlaW5lY2tlIiA8aGFyZUBzdXNlLmRlPiB3
cm90ZToNCg0KICAgIE9uIDMvMTMvMjIgMjI6MjUsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQogICAg
PiANCiAgICA+IA0KICAgID4gT24gMy8xLzIyIDA5OjA1LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQogICAgPj4gT24gMi8yOC8yMiAxNzozOSwgTWFyayBSdWlqdGVyIHdyb3RlOg0KICAgID4+Pg0K
ICAgID4+PiBUaGUgY3VycmVudCBkaXNjb3ZlcnkgaW1wbGVtZW50YXRpb24gb25seSB3b3JrcyBh
ZnRlciBhIHN1YnN5c3RlbSBoYXMgDQogICAgPj4+IGJlZW4gY3JlYXRlZCBhbmQgaGFzIGJlZW4g
bGlua2VkIHRvIGEgcG9ydC4NCiAgICA+Pj4gQXMgYSByZXN1bHQsICdudm1lIGRpc2NvdmVyJyBm
cm9tIGFuIGluaXRpYXRvciB3aWxsIG9ubHkgc2hvdyBhIA0KICAgID4+PiBkaXNjb3ZlcnkgZGV2
aWNlIGFmdGVyIHRoZSBmaXJzdCBzdWJzeXN0ZW0gaGFzDQogICAgPj4+IGJlZW4gZXhwb3J0ZWQu
DQogICAgPj4+DQogICAgPj4+IFRoZSBwYXRjaCB0aGF0IEkgcHJvcG9zZSBhZGRzIHRoZXNlIGZl
YXR1cmVzOg0KICAgID4+PiBBLiBNYWtlIGRpc2NvdmVyeSB3b3JrIGltbWVkaWF0ZWx5IGFmdGVy
IHRoZSB0YXJnZXQgcG9ydCBoYXMgYmVlbiANCiAgICA+Pj4gY29uZmlndXJlZCwgd2l0aG91dCBu
ZWVkaW5nIHRvIGNvbmZpZ3VyZQ0KICAgID4+PiAgICBzdWJzeXN0ZW1zIGZpcnN0Lg0KICAgID4+
PiBCLiBNb3ZlIHRoZSBkaXNjb3ZlcnlfbnFuIGNvbmZpZ3VyYXRpb24gb3B0aW9uIHRvIHRoZSBw
b3J0IGluc3RlYWQgb2YgDQogICAgPj4+IGhhdmluZyB0aGUgc2FtZSBjb25maWd1cmF0aW9uIG9w
dGlvbg0KICAgID4+PiAgICBkdXBsaWNhdGVkIGluIGV2ZXJ5IHN1YnN5c3RlbS4NCiAgICA+Pj4g
Qy4gQWxsb3cgdG8gZW5hYmxlIGFuZCBkaXNhYmxlIGEgdGFyZ2V0IHBvcnQgd2l0aG91dCBuZWVk
aW5nIHRvIA0KICAgID4+PiB1bmxpbmsgdGFyZ2V0IHN1YnN5c3RlbXMuDQogICAgPj4+DQogICAg
Pj4gVGhlIGN1cnJlbnQgbnZtZXQgZGlzY292ZXJ5IGltcGxlbWVudGF0aW9uIHdhcyBkZXNpZ25l
ZCB0byB0aGUgDQogICAgPj4gb3JpZ2luYWwgTlZNZSBzcGVjLCB3aGVyZSBhIGRpc2NvdmVyeSBj
b250cm9sbGVyIGNvdWxkIG9ubHkgcmV0dXJuIA0KICAgID4+IGluZm9ybWF0aW9ucyBhYm91dCB0
aGUgYXR0YWNoZWQgc3Vic3lzdGVtcy4NCiAgICA+PiBCdXQgd2l0aCB0aGUgcmVjZW50IGNoYW5n
ZXMgdG8gdGhlIHNwZWMgYSBkaXNjb3ZlcnkgY29udHJvbGxlciBjYW4gbm93IA0KICAgID4+IHJl
dHVybiBpbmZvcm1hdGlvbiBhYm91dCBpdHNlbGYgKGllIHdoaWNoIHBvcnQgaXQncyBydW5uaW5n
IG9uKSwgYW5kIHNvDQogICAgPj4gaXQgZG9lcyBtYWtlcyBzZW5zZSB0byBoYXZlIGl0IGVuYWJs
ZWQgZXZlbiB3aXRoIG5vIHN1YnN5c3RlbXMgYXR0YWNoZWQuDQogICAgPj4NCiAgICA+PiBCdXQ6
IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9ubHkgaGFzIGEgX3NpbmdsZV8gZGlzY292ZXJ5
IA0KICAgID4+IHN1YnN5c3RlbSAobnZtZXRfZGlzY19zdWJzeXMpLCB3aGljaCBpcyBzaGFyZWQg
YWNyb3NzIGFsbCBjb25maWd1cmVkIA0KICAgID4+IHN1YnN5c3RlbXMuDQogICAgPj4gQW5kIHRo
ZXJlJ3MgYSBmaWx0ZXIgd2hlbiBnZW5lcmF0aW5nIHRoZSBkaXNjb3ZlcnkgbG9nIHBhZ2Ugc3Vj
aCB0aGF0IA0KICAgID4+IG9ubHkgdGhlIGluZm9ybWF0aW9uIGZvciB0aGUgY3VycmVudCBzdWJz
eXN0ZW0gaXMgcmV0dXJuZWQgKGNmIA0KICAgID4+IG52bWV0X2V4ZWN1dGVfZGlzY19nZXRfbG9n
X3BhZ2UoKSkuDQogICAgPj4gU28gaW4gZWZmZWN0IGVhY2ggc3Vic3lzdGVtIGhhcyBpdHMgb3du
IGRpc2NvdmVyeSBzdWJzeXN0ZW0uDQogICAgPj4NCiAgICA+PiBNb3ZpbmcgdGhlIGRpc2NvdmVy
eSBucW4gdG8gdGhlIHBvcnQgd2lsbCBvbmx5IGNvbmZ1c2UgbWF0dGVycywgYXMgDQogICAgPj4g
dGhlbiBpdCdzIHF1aXRlIHVuY2xlYXIgd2hhdCB3aWxsIGhhcHBlbiBpZiB5b3UgY2hhbmdlIHRo
ZSBkaXNjb3ZlcnkgDQogICAgPj4gc3Vic3lzdGVtIG5xbiBvbiBhIHBlci1wb3J0IGJhc2lzOyB3
aXRoIHRoZSBjdXJyZW50IGRlc2lnbiB5b3Ugd291bGQNCiAgICA+PiBjaGFuZ2UgaXQgZm9yIF9h
bGxfIGRpc2NvdmVyeSBzdWJzeXN0ZW0gLi4uDQogICAgPj4NCiAgICA+PiBTbyBpZiB5b3Ugd2Fu
dCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGlzLCB5b3UnZCBuZWVkIHRvIGNoYW5nZSB0aGUgDQog
ICAgPj4gaW1wbGVtZW50YXRpb24gdG8gaGF2ZSBhIGRpc2NvdmVyeSBzdWJzeXN0ZW0gcGVyIHBv
cnQsIGFuZCBhbHNvIGNoYW5nZSANCiAgICA+PiB0aGUgbG9naWMgaW4gZHJpdmVycy9udm1lL3Rh
cmdldC9kaXNjb3ZlcnkuYyBzdWNoIHRoYXQgdGhlIGRpc2NvdmVyeQ0KICAgID4+IHN1YnN5c3Rl
bXMgd2lsbCByZXR1cm4gaW5mb3JtYXRpb25zIGZvciBfYWxsXyBjb25maWd1cmVkIHN1YnN5c3Rl
bXMuDQogICAgPj4NCiAgICA+PiBJdCdzIGFjdHVhbGx5IHNvbWV0aGluZyBJIHdhbnRlZCB0byBk
bywgdG9vLCBhcyBJIGRpZG4ndCBsaWtlIHRoZSANCiAgICA+PiBjdXJyZW50IGltcGxlbWVudGF0
aW9uIDotKQ0KICAgID4gDQogICAgPiBXaHkgYXJlbid0IHdlIGp1c3QgY3JlYXRpbmcgdGhlIGRp
c2NvdmVyeSBzdWJzeXN0ZW0gYXMgYSBzdGF0aWMgY29uZmlnZnMNCiAgICA+IHN1YnN5c3RlbXMg
YW5kIGp1c3QgbGluayBpdCB0byBkaWZmZXJlbnQgcG9ydHM/DQogICAgPiANCiAgICBXZSBjb3Vs
ZCBiZSBkb2luZyB0aGF0LCBidXQgdGhhdCB3b3VsZCBpbXBseSBhIGNoYW5nZSBpbiBiZWhhdmlv
dXIuDQogICAgQ3VycmVudGx5IHdlIGhhdmUgb25lIGRpc3RpbmN0IGRpc2NvdmVyeSBjb250cm9s
bGVyIHBlciBzdWJzeXN0ZW0uDQogICAgU3dpdGNoaW5nIHRvIGEgc3RhdGljIGNvbmZpZ2ZzIGRp
c2NvdmVyeSBzdWJzeXN0ZW0gd291bGQgaW5ldml0YWJseSANCiAgICByZXN1bHQgaW4gYSBfc2lu
Z2xlXyBkaXNjb3Zlcnkgc3Vic3lzdGVtIGZvciBhbGwgY29uZmlndXJlZCBzdWJzeXN0ZW1zLg0K
ICAgIE5vdCB0aGF0IEknbSBhZ2FpbnN0IGl0IChxdWl0ZSB0aGUgY29udHJhcnkpLCBidXQgaXQg
c2hvdWxkIGJlIG1lbnRpb25lZC4NCg0KICAgID4gVGhlIHBvcnQgbGlzdGVuZXIgb24gZmlyc3Qg
bGlua2FnZSBpcyBhIGRpZmZlcmVudCBtYXR0ZXIgYWZhaWN0LCBkb24ndA0KICAgID4gc2VlIGEg
c3Ryb25nIGFyZ3VtZW50IHRvIG1ha2UgdGhlIHBvcnQgbGlzdGVuZXIgd2l0aG91dCBhbnkgc3Vi
c3lzdGVtcw0KICAgID4gZXhwb3J0ZWQgYW55d2F5cy4uLiBtYXliZSBpZiBkaXNjb3ZlcnkgbG9n
IGNoYW5nZSBldmVudCBpcyBiZWluZyB1c2VkLi4uDQoNCiAgICBBY3R1YWxseSwgd2UgY2FuIGp1
c3QgbGVhdmUgdGhlIGV4aXN0aW5nIG1lY2hhbmlzbSBhcy1pczsgcG9ydHMgd291bGQgDQogICAg
bmVlZCB0byBiZSBsaW5rZWQgZXhwbGljaXRseSB0byB0aGUgZGlzY292ZXJ5IHN1YnN5c3RlbS4N
CiAgICBSZWFzb25pbmc6IE5vdCBldmVyeSBwb3J0IG5lZWRzIHRvIHByZXNlbnQgYSBkaXNjb3Zl
cnkgc3Vic3lzdGVtLCBhbmQgd2UgDQogICAgbWlnaHQgd2FudCB0byBoYXZlIHBvcnRzIHdoaWNo
IHdpbGwgX29ubHlfIHByZXNlbnQgdGhlIGRpc2NvdmVyeSBzdWJzeXN0ZW0uDQoNCiAgICBIbW0u
IFNob3VsZCBiZSBwcmV0dHkgZWFzeSB0byBjb2RlIC4uLg0KDQogICAgQ2hlZXJzLA0KDQogICAg
SGFubmVzDQogICAgLS0gDQogICAgRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QNCiAgICBoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OA0KICAgIFNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZw0KICAgIEhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcg0KDQo=

