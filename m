Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4849C2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 15:27:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163F620756
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 15:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCl9tAx9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="Qwzg84z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163F620756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vfT9CMSeh9I9oxll6lh3HxL78fw/rnuOh0FrOYKZFJ8=; b=CCl9tAx9cuJpCjOeMHNRMX/1L
	muHT1e6DuaaZCNxq24x8gCo2jdRIYFBc7Aa2nFZYrM41Fz4VR9dS0NVN8/BZGPQctChbeL//XvpAA
	tv68aj1CgnBXHjl07cPcq7VA1c/v1qAdIr3HZ2xhyazR4aL3cZR0jZUhR19FQW1n86A0YBiXz9dnb
	MlQeBnbivRJeMKwco+z2k2CrdHTspPNgEEsXxa9/rjiuWlh4iZ9fCR0r1O8HpF7YR0EXQ3s1tkUwM
	aBFKHDQp6d94SIUMT+ifLGniUbOVukiPE2Uphvxugvm0t7uoVXhBqFGkFTuupl4NVfxzzv2I4P3oG
	cXByIFqXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khDkn-0006xS-7i; Mon, 23 Nov 2020 15:27:45 +0000
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com
 ([40.107.223.53] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khDkj-0006wd-57
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 15:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0NFJ0Ml4Xk+grUrykpnG9J+Li/QYsPXbk0z3SxFPfrAmeq2Ib2F1NJh25hvy1HyFrQWkVjDyqlqIGIyldyCVST1LuisSqGkwksRt3q/1c262LIrHq+zkTyPQzH6vRC47WVFeJii02RxeayyM86RaxVDqThozwFQ0RnjeeI3h44cMHJI1gJSyJlBfSR9j6OoOLfVu8/IHDlGnYPuuEDeGhb6TKb6vUgkErsKDnjHjpXxO3ZaZicFjy2znARd5dgf8JAwlFNe8EnbtgAH1y0kI3RdkqaRIPG7SwS6uQmBr6s883y3g6aMkJBk+U24mPCe0W1qiGAXUH2y5ugWKOgCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEsjlMJny8HKWIxvqX6SoSE5YpTQeMGH+xslUM+LiI0=;
 b=RrQ4Oauv59R8aO563IwejqkODnCPyrQGjnImWE82V99eNq2Axr2SivvNRG87FxRDcie2yrJx7Nkdb27yZy0Fs653WS3Bxoeu7ZM48hmrQkCE6kgCGjMDQ9wkQOEMCHnMx7DGz3yL69Kol7iQwuXJQjTXDlKxHYXHJihEzkm7b9BTCDqnlhe4GwXgRQTJcgmTaFKXlvDSe5QGu/XL54hQ9L70cJ8t4Yjk2IGhTqBxk4WJyfYvSNNp8fQ6AKJiYBjjGpvQsfv48GNlclufbpkbmr2v7kuvth0SYArfYoKYFv91jAYnrs9vKX+hWOjMIjNExyc/x455zPKRBBIXSq2AaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEsjlMJny8HKWIxvqX6SoSE5YpTQeMGH+xslUM+LiI0=;
 b=Qwzg84z1Fd8dt+fUKQ5fIgvDQRrhS602aLiwL+kheRFmL+F1LDvfta+SvoWOadeQ+gNidX2lOIFgp0rPwGKkRFTtOmW3hToKiTsFVoSgACZww5LALe3cl2+SzOBD5sm4fEh8Ta3Rs88jIXwxQVa1myXJ5SSsVjW4eOFKrlRyykw=
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB5418.namprd06.prod.outlook.com (2603:10b6:5:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 23 Nov
 2020 15:27:35 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 15:27:35 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: "Meneghini, John" <John.Meneghini@netapp.com>, "hch@lst.de" <hch@lst.de>, 
 "George, Martin" <Martin.George@netapp.com>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQ
Date: Mon, 23 Nov 2020 15:27:35 +0000
Message-ID: <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
In-Reply-To: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5c06:2c77:1c87:af9a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebb3eff1-c786-4d34-3b50-08d88fc44e0d
x-ms-traffictypediagnostic: DM6PR06MB5418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB541859244A2812F6EA4AF3E4F1FC0@DM6PR06MB5418.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqrUbo1IgSR41DtX2dicON9hQ6AYDYlFEM1tM1L1WVok1ZK0C6Z22J3eSwM+7LJ6sOicI+RyIybRnZrApDpvocq9TyGjqjxVyikU6ngPZmtHR2gZQ5c375JteuSF18uyZWQrD2UgV6ATWPY4A3xxMsDlEvfooSmA/NVqS1Tk4BP4XAjCZb+EUU9N/MgbwvtvNoRhAk0vrtffQ6JsqaAyazN6s8l82StJFxN2/3HgejujVMu2Bo8psIOFPeeN7SfWUIGPyXf4OvCy9q8ZEDqgAurAfth+msAGRoiVQ6DOn9O2CEw3irnC/XuKJCkQGY/xD8SkUPzG1XVGDgujDXdBJWTR69cLDZdN6U3790H5taY0FBb6otq9tMLxE3H8O+trX8ge1Yf8JhpiNorQPTJ14g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(83380400001)(8936002)(52536014)(7696005)(316002)(9686003)(55016002)(54906003)(5660300002)(2906002)(15650500001)(110136005)(53546011)(478600001)(6506007)(64756008)(6636002)(66446008)(33656002)(86362001)(66946007)(186003)(4326008)(66556008)(71200400001)(76116006)(8676002)(966005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aE1IczArY2VpN2ZORGVLNEJZdnlxWmhUa2tuV3hzeDZmRExLRmRSRHltd0xQ?=
 =?utf-8?B?dmp4TlpQWHFjYWUvbjZCLzBTQzlUMUpKRHBjdUdxUzBjaDVCSHlTTDFrRUxG?=
 =?utf-8?B?bldwY0NrM2U5NWJBSVJHcWFrSEN6am9IemU4aU5KUXZsNXo5SDN6VG9ITVpQ?=
 =?utf-8?B?RUxsK041ZW9DS1Z6dEJNT2JGUjFmNWs3ZGQxZm1xcW1rNW0xWk9DMlQ1bVBC?=
 =?utf-8?B?QWV6cVh4WnRjTkZXTHVMKzIwRUxqYWhpWFRvTytOS3FKU1lmVHcxTENDaUJi?=
 =?utf-8?B?UWU3MHhsYUJ4WjRvRjFOR0xURGF5S0tSZlNuNHBnQXhhb0FreVErWTNMY1di?=
 =?utf-8?B?V2xOMHdVaEVZYksxQ0FPQTlHRlR2cUtLeEs2dVVUeDlzclc3a0djbCtvUDJB?=
 =?utf-8?B?Zis1ZmxyQm9QUjJZdWlzdk0wRFNFb1RpNjdlV0Iya0FBbDVuSGxUcnpOOXhE?=
 =?utf-8?B?VGN5My8rMXNWQm5sVUl6anFKZGw4M0Jtd1JSSG4zNWYvNzhZYTNCZU9IaDRq?=
 =?utf-8?B?OWljMzZ5VzN5Q21MbWhnYzhwSmRvMmhJSEJCZXRkeHFRaG9mUU1jbkNuY2c5?=
 =?utf-8?B?TXIyUjNaN2tXcGlRbllacXNrUmE5eEtTaXdQOFp3VFM4N2x1WXNtUGZWTGR2?=
 =?utf-8?B?enMydHQwaGhpK3MwODZreHBGcm1jRTRZbHZiUjVZV1lJc1VGc0NPaDNIVlZx?=
 =?utf-8?B?WXUrMkFFZUh1ckFURDhhMFdYbHVLcHlGQUdvTTdsNTc3ZXBjRnRKcGV3Wm5Q?=
 =?utf-8?B?ZXVBRmRFS0pNMlFiaktpREw0WURiTjZIaXBZZEQwNWdNcUxrbU4zVDNSc0lR?=
 =?utf-8?B?WG54Ly9scWR3VmlKTWZWWnVzTWVXT01IZncySWdZN2lRS09wZUJUWUtsc1FD?=
 =?utf-8?B?dUpwTTZCOHkvQUp1TU9KT0IzeUVCQi9DSDhFSnA2cHd0c01QN2EvdTRHREd6?=
 =?utf-8?B?TlRSMENlMEpIaDJISlptaE9SL1VqRU1iWDhIUDZQN3hxeWZtSDE0RmkzTFBO?=
 =?utf-8?B?NU5IRzNHQTZKTFZPZjk3UU5CYWM0NFBuaTZoK0p0R0FpUHNueDBsTmV3ZlBZ?=
 =?utf-8?B?eWRvVDEvcXdJNFUyRVd3QWkvZ1B4ZVhneDdIOXRhRWF6ekdOZk9FQ2RlT2dL?=
 =?utf-8?B?bDlreUpMZjJ0MEcyU3ZvVk90NEhmVnBvRjBGVi8zR2pGSGptTW45MkN6WXJr?=
 =?utf-8?B?U0FFaWN0Q1F6dnpTdUtUdGZGNWMzVE94dFErcTZGYTZpL1RHdHBibEpnZ1RN?=
 =?utf-8?B?Qnh3VVdqZzcyS3cvQmVFSWh6eENUUEJXQnozTm9EOVlPWW95OXkyVStIdE5m?=
 =?utf-8?B?QXZVNk1IeFpXWUlTNjVaSTFXWWh5RUUxdk1zWHZyOVd4T3h2YnFrcjQ1bktF?=
 =?utf-8?Q?OeshMUAKZ8pdvIhDMtY/MTO8HVC2rmos=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb3eff1-c786-4d34-3b50-08d88fc44e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 15:27:35.8037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROHrp99CmrkowpnnK/EqpBRBXfY0YVSqCAKjFnWAm0ilgS9BGFOZvv4/RhKjbxrtEQtVxevPhoX5UFbiSzJ/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5418
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_102741_221417_477F18EB 
X-CRM114-Status: GOOD (  19.59  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Hannes Reinecke <hare@suse.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVyZSBpcyB3aGF0IEkgd291bGQgZXhwZWN0IHRvOg0KQSkgY3JlYXRlIGEgbmFtZXNwYWNlIGlu
IGV4aXN0aW5nIEFOQSBncm91cDoNCgkxKSBOUyBBdHRyaWJ1dGUgQ2hhbmdlZCBBRU4gKGJlY2F1
c2UgdGhlIE5TIExpc3QgcmV0dXJuZWQgaGFzIGNoYW5nZWQpDQoJMikgSG9zdCBnZXRzIHRoZSBs
aXN0IC0gZGlzY292ZXJzIHRoZSBORVcgTlMNCgkJSW5jbHVkaW5nOiBEZXRlcm1pbmUgd2hpY2gg
QU5BR1JQSUQgdGhhdCBOUyBiZWxvbmdzIHRvIChmb3Igd2hpY2ggdGhlIGhvc3QgYWxyZWFkeSBr
bm93cyB0aGUgc3RhdGUpLg0KDQpCKSBjcmVhdGUgYSBuYW1lc3BhY2UgaW4gYSBORVcgQU5BIGdy
b3VwDQoJMSkgTlMgQXR0cmlidXRlIENoYW5nZWQgQUVOIChiZWNhdXNlIHRoZSBOUyBMaXN0IHJl
dHVybmVkIGhhcyBjaGFuZ2VkKQ0KCTIpIEhvc3QgZ2V0cyB0aGUgbGlzdCAtIGRpc2NvdmVycyB0
aGUgbmV3IE5TDQoJCUluY2x1ZGluZzogRGV0ZXJtaW5lIHRoZXJlIGlzIGEgQlJBTkQgTkVXIEFO
QUdSUElEIHRoYXQgdGhlIGhvc3Qga25vd3MgTk9USElORyBhYm91dC4NCgkJU2luY2UgdGhlIGhv
c3Qga25vd3MgTk9USElORyBhYm91dCB0aGF0IEFOQUdSUElELCBpdCBzZWVtcyB0aGUgaG9zdCBz
aG91bGQgZ28gbG9vay4NCg0KSXQgc2VlbXMgdGhhdCB0aGUgZXhpc3RpbmcgdGV4dCBzYXlzIHRo
ZXJlIGlzIE5PIEFOQSBBRU4gZm9yIGEgIm5ldyIgbmFtZXNwYWNlLiAgSm9obiBxdW90ZWQgdGhl
IHRleHQ6DQoNCkEgY29udHJvbGxlciBzaGFsbCBub3Qgc2VuZCB0aGlzIGV2ZW50IGlmOg0KYSkJ
dGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGNyZWF0aW9uIG9mIGEgbmFtZXNwYWNlIChyZWZlciB0
byBzZWN0aW9uIDUuMjApOyBvcg0KYikJdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGRlbGV0aW9u
IG9mIGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApLA0KYXMgdGhlIE5hbWVzcGFj
ZSBBdHRyaWJ1dGUgQ2hhbmdlZCBldmVudCBpcyBzZW50IGZvciB0aGVzZSBjaGFuZ2VzLg0KDQpD
aHJpc3RvcGggY2xhaW1zIHRoYXQgdGhlIEFOQSBBRU4gc2hvdWxkIGJlIHNlbmQgYmVmb3JlIHRo
ZSBOUyBBdHRyaWJ1dGUgQ2hhbmdlZCBBRU4uICBBbmQsIHRoYXQgY291bGQgYmUgdHJ1ZSBmb3Ig
YW4gQU5BR1JQSUQgdGhhdCBjaGFuZ2VkIChhbHRob3VnaCwgSSBkb24ndCBzZWUgdGV4dCBkZXNj
cmliaW5nIGFueSBwcmVjZWRlbmNlIG9yIG9yZGVyIHJlcXVpcmVtZW50cyBmb3IgZGVsaXZlcnkg
b2YgQUVOcyksIGJ1dCB0aGUgTlMgY3JlYXRpb24gY2FzZSBpcyBleHBsaWNpdGx5IGV4Y2x1ZGVk
LiAgRldJVyDigJMgQ2hyaXN0b3BoIHdhcyBvbmUgb2YgdGhlIHBlb3BsZSB0aGF0IHJlcXVlc3Rl
ZCB0aGlzIGV4Y2x1c2lvbiB0byBwcmV2ZW50IHNwYW1pbmcgdGhlIGhvc3Qgd2l0aCBtdWx0aXBs
ZSBBRU5zIGZvciB0aGUgc2FtZSBldmVudCAoYSBOUyBjcmVhdGUpLg0KDQoJRnJlZA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWVuZWdoaW5pLCBKb2huIDxKb2huLk1lbmVn
aGluaUBuZXRhcHAuY29tPiANClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjMsIDIwMjAgOTozNiBB
TQ0KVG86IGhjaEBsc3QuZGU7IEdlb3JnZSwgTWFydGluIDxNYXJ0aW4uR2VvcmdlQG5ldGFwcC5j
b20+DQpDYzoga2J1c2NoQGtlcm5lbC5vcmc7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
Zzsgc2FnaUBncmltYmVyZy5tZTsgTWVuZWdoaW5pLCBKb2huIDxKb2huLk1lbmVnaGluaUBuZXRh
cHAuY29tPjsgS25pZ2h0LCBGcmVkZXJpY2sgPEZyZWRlcmljay5LbmlnaHRAbmV0YXBwLmNvbT47
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG52
bWUtY29yZTogdXBkYXRlIE5TIEF0dHIgQ2hhbmdlZCBBRU4gaGFuZGxpbmcgZm9yIEFOQSBncm91
cA0KDQpPbiAxMS8yMC8yMCwgNDo0OSBBTSwgIkxpbnV4LW52bWUgb24gYmVoYWxmIG9mIG1haWx0
bzpoY2hAbHN0LmRlIiA8bWFpbHRvOmxpbnV4LW52bWUtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQu
b3JnIG9uIGJlaGFsZiBvZiBoY2hAbHN0LmRlPiB3cm90ZToNCg0KICAgIE9uIFdlZCwgTm92IDE4
LCAyMDIwIGF0IDA4OjA5OjQzUE0gKzAwMDAsIEdlb3JnZSwgTWFydGluIHdyb3RlOg0KICAgID4g
PiBIb3cgY2FuIHRoZSBuYW1lc3BhY2UgcmVmZXJlbmNlIGFuIEFOQSBncm91cCB0aGF0IHdlIGhh
dmVuJ3QgYmVlbg0KICAgID4gPiBub3RpZmllZCBhYm91dCB1c2luZyB0aGUgTlZNRV9BRU5fQ0ZH
X0FOQV9DSEFOR0UgQUVOIGJlZm9yZT8NCiAgICA+DQogICAgPiBXZWxsLCBJIHRoaW5rIHRoYXQg
Y291bGQgYmUgcG9zc2libGUgZm9yIGEgbmV3bHkgY3JlYXRlZCBuYW1lc3BhY2UsDQogICAgPiB3
aGljaCBoYXBwZW5zIHRvIGJlbG9uZyB0byBhIG5ldyBBTkEgZ3JvdXAuIFRvIHF1b3RlIHRoZSAx
LjQgc3BlYyBpbg0KICAgID4gY29udGV4dCBvZiBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3Mg
Q2hhbmdlIHVuZGVyIHRoZSBBc3luY2hyb25vdXMNCiAgICA+IEV2ZW50IEluZm9ybWF0aW9uIC0g
Tm90aWNlIChGaWd1cmUgMTQ3KToNCiAgICA+DQogICAgPiAiQSBjb250cm9sbGVyIHNoYWxsIG5v
dCBzZW5kIHRoaXMgZXZlbnQgaWY6DQogICAgPiBhKSB0aGUgY2hhbmdlIGlzIGR1ZSB0byB0aGUg
Y3JlYXRpb24gb2YgYSBuYW1lc3BhY2UgKHJlZmVyIHRvIHNlY3Rpb24NCiAgICA+IDUuMjApOyBv
cg0KICAgID4gYikgdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGRlbGV0aW9uIG9mIGEgbmFtZXNw
YWNlIChyZWZlciB0byBzZWN0aW9uDQogICAgPiA1LjIwKSwNCiAgICA+IGFzIHRoZSBOYW1lc3Bh
Y2UgQXR0cmlidXRlIENoYW5nZWQgZXZlbnQgaXMgc2VudCBmb3IgdGhlc2UgY2hhbmdlcy4iDQog
ICAgPg0KICAgID4gU28gaXQgbG9va3MgdGhlIE5WTUVfQUVOX0NGR19BTkFfQ0hBTkdFIEFFTiBp
cyBub3QgcmVxdWlyZWQgaGVyZSBmb3INCiAgICA+IHN1Y2ggY2FzZXMsIGJ1dCBpbnN0ZWFkIHRo
ZSBOVk1FX0FFTl9DRkdfTlNfQVRUUiBBRU4gd291bGQgZG8uDQoNCiAgICBGb3IgdGhlIG5ld2x5
IGNyZWF0ZWQgbmFtZXNwYWNlIHRvIGJlb25nIHRvIGEgbmV3bHkgY3JlYXRlZCBBTkEgZ3JvdXAN
CiAgICB0aGUgY29udHJvbGxlciBmaXJzdCBuZWVkcyB0byBzZW5kIE5WTUVfQUVOX0NGR19BTkFf
Q0hBTkdFIHRvIGFubm91bmNlDQogICAgdGhlIEFOQSBncm91cCwgaXQgdGhlbiBzZW5kIE5WTUVf
QUVOX0NGR19OU19BVFRSIHRvIGFubm91bmNlIHRoZQ0KICAgIG5ldyBuYW1lc3BhY2VzLiAgQnV0
IHRoZSBuZXcgbmFtZXNwYWNlIGNhbid0IHJlZmVyZW5jZSBhbiBBTkEgZ3JvdXANCiAgICB0aGF0
IGRpZG4ndCBleGlzdCwgdGhhdCBpcyBhIHNlcGFyYXRlIGV2ZW50Lg0KDQpJIHJlbWVtYmVyIGRp
c2N1c3NpbmcgdGhpcyBhdCBsZW5ndGggd2hlbiB3ZSB3cm90ZSB0aGlzIHRleHQgZm9yIFRQLTQw
MDQuICAgV2UgZXhwbGljaXRseSByZXN0cmljdGVkICBOVk1FX0FFTl9DRkdfQU5BX0NIQU5HRSBB
RU5zIHRvIEFOQSBzdGF0ZSBjaGFuZ2UgZXZlbnRzLCBhbmQgQU5BR1JQSUQgY2hhbmdlIGV2ZW50
cy4gIEFuZCB3ZSByZXN0cmljdGVkIE5WTUVfQUVOX0NGR19OU19BVFRSIEFFTnMgc28gdGhhdCBB
TkEgc3RhdGUvQU5BR1JQSUQgY2hhbmdlIGV2ZW50cyB3b3VsZCBub3QgZ2VuZXJhdGUgYW4gTlZN
RV9BRU5fQ0ZHX05TX0FUVFIuICBXZSBkaWQgdGhpcyBzbyBhcyB0byBhdm9pZCBkdXBsaWNhdGUg
QUVOcy4gVGhlIGRpc2NvdmVyeSBvZiBuZXcgQU5BR1JQIElEcyB3YXMgYWx3YXlzIHN1cHBvc2Vk
IHRvIHRha2UgcGxhY2UgYXMgYSBwYXJ0IG9mIG5hbWVzcGFjZSBkaXNjb3ZlcnkuICANCg0KL0pv
aG4NCg0KRmlndXJlIDQ5OiBBc3luY2hyb25vdXMgRXZlbnQgSW5mb3JtYXRpb24gLSBOb3RpY2UN
Cg0KTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkOg0KLi4uDQpBIGNvbnRyb2xsZXIgc2hhbGwg
bm90IHNlbmQgdGhpcyBldmVudCBpZjoNCiAgIGEpIE5hbWVzcGFjZSBVdGlsaXphdGlvbiAocmVm
ZXIgdG8gRmlndXJlIDExNCkgaGFzIGNoYW5nZWQsIGFzIHRoaXMgaXMgYSBmcmVxdWVudCBldmVu
dCB0aGF0IGRvZXMgbm90IHJlcXVpcmUgYWN0aW9uIGJ5IHRoZSBob3N0Ow0KICAgYikgdGhlIEFO
QUdSUElEIGZpZWxkIChyZWZlciB0byBGaWd1cmUgMTE0KSBoYXMgY2hhbmdlZDsgb3INCiAgIGMp
IGNhcGFjaXR5IGluZm9ybWF0aW9uIChpLmUuLCB0aGUgTlVTRSBmaWVsZCBhbmQgdGhlIE5WTUNB
UCBmaWVsZCkgcmV0dXJuZWQgaW4gdGhlIElkZW50aWZ5IE5hbWVzcGFjZSBEYXRhIFN0cnVjdHVy
ZSAocmVmZXIgdG8gRmlndXJlIDExNCkgY2hhbmdlZCBhcyBhIHJlc3VsdCBvZiBhbiBBTkEgc3Rh
dGUgY2hhbmdlLg0KLi4uDQoNCkFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2U6IA0K
DQpUaGUgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIGluZm9ybWF0aW9uIChyZWZlciB0byBz
ZWN0aW9uIDUuMTQuMS4xMikgcmVsYXRlZCB0byBhbiBBTkEgR3JvdXAgdGhhdCBjb250YWlucyBu
YW1lc3BhY2VzIGF0dGFjaGVkIHRvIHRoaXMgY29udHJvbGxlciBoYXMgY2hhbmdlZCAoZS5nLiwg
YW4gQU5BIHN0YXRlIGhhcyBjaGFuZ2VkLCBhbiBBTkFHUlBJRCBoYXMgY2hhbmdlZCkuIFRoZSBj
dXJyZW50IEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBpbmZvcm1hdGlvbiBmb3IgYXR0YWNo
ZWQgbmFtZXNwYWNlcyBpcyBpbmRpY2F0ZWQgaW4gdGhlIEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFj
Y2VzcyBsb2cgcGFnZSAocmVmZXIgdG8gc2VjdGlvbiA1LjE0LjEuMTIpLiBUbyBjbGVhciB0aGlz
IGV2ZW50LCB0aGUgaG9zdCBpc3N1ZXMgYSBHZXQgTG9nIFBhZ2Ugd2l0aCBSZXRhaW4gQXN5bmNo
cm9ub3VzIEV2ZW50IGNsZWFyZWQgdG8g4oCYMOKAmSBmb3IgdGhlIEFzeW1tZXRyaWMgTmFtZXNw
YWNlIEFjY2VzcyBMb2cuDQoNCkEgY29udHJvbGxlciBzaGFsbCBub3Qgc2VuZCB0aGlzIGV2ZW50
IGlmOg0KICAgYSkgdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGNyZWF0aW9uIG9mIGEgbmFtZXNw
YWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApOyBvcg0KICAgYikgdGhlIGNoYW5nZSBpcyBkdWUg
dG8gdGhlIGRlbGV0aW9uIG9mIGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApLCBh
cyB0aGUgTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkIGV2ZW50IGlzIHNlbnQgZm9yIHRoZXNl
IGNoYW5nZXMuDQoNCiAgICBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KICAgIExpbnV4LW52bWUgbWFpbGluZyBsaXN0DQogICAgbWFpbHRvOkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KICAgIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQ0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
