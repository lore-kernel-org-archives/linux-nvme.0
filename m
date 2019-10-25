Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B3CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5692070B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhM2vCTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5692070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onestopsystems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3uBJpQWcupoxBtJxRe3ckbojCO4ykHJeLxyyIM0g//Q=; b=LhM2vCTkr3mFhz
	+dywvnrP1Cww8BE57u7pevPVi+Yik9NQqz09cysIJuzrtoY7Z8zM54tEYSZbSYwdO3EwRbJeU1zdU
	0v4o1jWQrBda057mSZJHn509hqg+151+9qrrap2gJzjziUGZla4CkdGsjpWNItnayC6Q5cdRHYu0A
	fDvdLubwoIYtogMwF9rnNQWlyTLdRsloEIfq2qL0qgcqNCfJWEPk1U/Yh4UoHyKnDHX4648cNJT2z
	TOxC9XGn6UJcf7gLls8r8eaa5gjgle97USn0DdRnebrV00uN08lRpc3zawCeGMfqr0BU3GLsCPa4F
	4rOmRWkI0IIc4lhry7zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNvCg-0004s7-JD; Fri, 25 Oct 2019 08:44:14 +0000
Received: from cox.onestopsystems.com ([98.187.250.34]
 helo=osserver.onestopsystems.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNvCd-0004rT-RV
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 08:44:13 +0000
Received: from OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203]) by
 OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203%10]) with mapi id
 14.03.0468.000; Fri, 25 Oct 2019 01:44:00 -0700
From: Mark Ruijter <MRuijter@onestopsystems.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7lEGozSmO4UUiQP6G5ZvB8eadpfxqAgADA2ACAAPSWAIAABfMAgABpVQA=
Date: Fri, 25 Oct 2019 08:44:00 +0000
Message-ID: <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.f.191014
x-originating-ip: [166.70.167.105]
Content-ID: <704A822CA6975E409E50E9B84D992209@onestopsystems.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_014411_923826_F654038A 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQpIaSBLZWl0aCwNCg0KSSBhbSBpbmRlZWQgbm90IHVzaW5nIGJ1ZmZlcmVkIGlvLg0KVXNpbmcg
dGhlIFZGUyBpbmNyZWFzZXMgbXkgNGsgcmFuZG9tIHdyaXRlIHBlcmZvcm1hbmNlIGZyb20gMjAw
SyB0byA2NTBLIHdoZW4gdXNpbmcgcmFpZDEuIA0KU28gdGhlIGRpZmZlcmVuY2UgaXMgaHVnZSBh
bmQgYmVjb21lcyBtb3JlIHNpZ25pZmljYW50IHdoZW4gdGhlIHVuZGVybHlpbmcgZHJpdmVzIG9y
IHJhaWQwIGNhbiBoYW5kbGUgbW9yZSBpb3BzLg0KDQpPdmVyIHRoZSBuZXh0IGZldyBkYXlzIEkg
YW0gZ29pbmcgdG8gcHJvdmlkZSBhIG51bWJlciBvZiBwYXRjaGVzLg0KDQoxLiBDdXJyZW50bHkg
YSBjb250cm9sbGVyIGlkIGNvbGxpc2lvbiBjYW4gb2NjdXIgd2hlbiB1c2luZyBhIGNsdXN0ZXJl
ZCBIQSBzZXR1cC4gU2VlIHRoaXMgbWVzc2FnZToNCj4+PiBbMTEyMjc4OS4wNTQ2NzddIG52bWUg
bnZtZTE6IER1cGxpY2F0ZSBjbnRsaWQgNCB3aXRoIG52bWUwLCByZWplY3RpbmcuDQoNClRoZSBj
b250cm9sbGVyIElEIGlzIGN1cnJlbnRseSBoYXJkIHdpcmVkLg0KDQogICAgICAgcmV0ID0gaWRh
X3NpbXBsZV9nZXQoJmNudGxpZF9pZGEsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5W
TUVfQ05UTElEX01JTiwgTlZNRV9DTlRMSURfTUFYLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBHRlBfS0VSTkVMKTsNCg0KU28gdHdvIG5vZGVzIGV4cG9ydGluZyB0aGUgZXhhY3Qgc2Ft
ZSB2b2x1bWUgdXNpbmcgdGhlIHNhbWUgcG9ydCBjb25maWd1cmF0aW9uIGNhbiBlYXNpbHkgY29t
ZSB1cCB3aXRoIHRoZSBzYW1lIGNvbnRyb2xsZXIgaWQuDQpJIHdvdWxkIGxpa2UgdG8gcHJvcG9z
ZSB0byBtYWtlIGl0IGNvbmZpZ3VyYWJsZSwgYnV0IHdpdGggdGhlIGN1cnJlbnQgbG9naWMgc2V0
dGluZyBhIGRlZmF1bHQuDQpTQ1NUIGZvciBleGFtcGxlIGFsbG93cyBtYW51YWwgdGFyZ2V0IGlk
IHNlbGVjdGlvbiBmb3IgdGhpcyByZWFzb24uDQoNCjIuIFRoZSBNb2RlbCBvZiB0aGUgZHJpdmVz
IGhhcyBiZWVuIGhhcmQgd2lyZWQgdG8gTGludXguIEFzIEkgc2VlIGl0IHRoaXMgc2hvdWxkIGJl
IGNvbmZpZ3VyYWJsZSB3aXRoICdMaW51eCcgYXMgZGVmYXVsdCB2YWx1ZS4NCkknbGwgcHJvdmlk
ZSBjb2RlIHRoYXQgbWFrZXMgdGhhdCB3b3JrLg0KDQozLiBBIE5WTUVvRiBjb25uZWN0ZWQgZGlz
ayBvbiB0aGUgaW5pdGlhdG9yIHNlZW1zIHRvIHF1ZXVlIGZvcmV2ZXIgd2hlbiB0aGUgdGFyZ2V0
IGRpZXMuDQpJdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGhhZCB0aGUgYWJpbGl0eSB0byBzZWxlY3Qg
ZWl0aGVyICdxdWV1ZSBmb3JlZXZlcicgb3IgJ2ZhaWxmYXN0Jy4NCg0KSSBob3BlIHRoaXMgbWFr
ZXMgc2Vuc2UsDQoNCk1hcmsgUnVpanRlcg0KDQrvu79PcCAyNS0xMC0xOSAwNjoyNyBoZWVmdCBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+IGdlc2NocmV2ZW46DQoNCiAgICBPbiBGcmks
IE9jdCAyNSwgMjAxOSBhdCAwMTowNTo0MFBNICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCiAg
ICA+IE9uIFRodSwgT2N0IDI0LCAyMDE5IGF0IDExOjMwOjE4QU0gKzAwMDAsIE1hcmsgUnVpanRl
ciB3cm90ZToNCiAgICA+ID4gTm90ZSB0aGF0IEkgd3JvdGUgdGhpcyBwYXRjaCB0byBwcm92ZSB0
aGF0IGEgcGVyZm9ybWFuY2UgcHJvYmxlbSBleGlzdHMgd2hlbiB1c2luZyByYWlkMS4NCiAgICA+
ID4gRWl0aGVyIHRoZSBtZCByYWlkMSBkcml2ZXIgb3IgdGhlIGlvLWNtZC1iZGV2LmMgY29kZSBo
YXMgaXNzdWVzLg0KICAgID4gPiBXaGVuIHlvdSBhZGQgYW4gYWRkaXRpb25hbCBsYXllciBsaWtl
IHRoZSBWRlMgdGhlIHBlcmZvcm1hbmNlIHNob3VsZCB0eXBpY2FsbHkgZHJvcCB3aXRoIDV+MTAl
Lg0KICAgID4gPiBIb3dldmVyIGluIHRoaXMgY2FzZSB0aGUgcGVyZm9ybWFuY2UgaW5jcmVhc2Vz
IGV2ZW4gdGhvdWdoIHRoZSBudm1lIHRhcmdldCB1c2VzIGRpcmVjdC1pbyBhbmQgdGhlIHJhbmRv
bSB3cml0ZXMgZG8gbm90IGdldCBtZXJnZWQgYnkgdGhlIFZGUy4NCiAgICA+IA0KICAgID4gQXJl
IHdlIHJlYWxseSB1c2luZyBkaXJlY3QgaW8gd2hlbiBudm1lIHRhcmdldCBpcyBnb2luZyB0aHJv
dWdoIHZmcywNCiAgICA+IHRob3VnaD8gVGhhdCBzaG91bGQgaGFwcGVuIGlmIHdlJ3ZlIHNldCBJ
T0NCX0RJUkVDVCBpbiB0aGUga2lfZmxhZ3MsDQogICAgPiBidXQgSSBkb24ndCBzZWUgdGhhdCBo
YXBwZW5pbmcsIGFuZCBpZiB0aGF0J3MgcmlnaHQsIHRoZW4gdGhlIGRpZmZlcmVuY2UNCiAgICA+
IHNvdW5kcyBsaWtlIGl0J3MgcmVsYXRlZCB0byBidWZmZXJlZCBJTy4NCiAgICANCiAgICBFcnIs
IEkgc2VlIHdlIGFjdHVhbGx5IGRlZmF1bHQgdG8gZGlyZWN0IHdoZW4gd2Ugb3BlbiB0aGUgZmls
ZS4gWW91J2QNCiAgICBoYXZlIHRvIGNoYW5nZSB0aGF0IHRocm91Z2ggY29uZmlnZnMgdG8gdXNl
IGJ1ZmZlcmVkLCB3aGljaCBJIGFzc3VtZQ0KICAgIHlvdSdyZSBub3QgZG9pbmcuIE15IG1pc3Rh
a2UuDQogICAgDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
