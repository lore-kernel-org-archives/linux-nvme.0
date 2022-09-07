Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885F8ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ed4GfPXhBuVZiumdH7dEVJo7SnWEki3vdv8C9fy9jwQ=; b=Yp7dZNbE4FAOwCiw384jvMDI/6
	vwVYb1afAajK/ygIB3Owsi6+RCUSf8Ay3TJIPDefIZFyUEoA+J9ZE6dEGbdPqlt7zc3n/tpyiYn/P
	wFkxLXxHvm68sfJkH29s801BUX0u9Fs6qJnIBUXyCrxBiPbJOyl/QwjkX8kIFw+/J2BZBlMZUU8Y3
	JD4QW7TlPuRnPilpSyjRYdSc46Z9CX6CTn6cxENTXz2rdSE8WL1PT9XOpkNMtfY29Kr0VvXTZuJIb
	67UOcwLRTie1I3rpZoWKsXkryi0k1W9XrrcXTvqvWYXF5AhZbmspFJ6NKwx0aO0EFgGqJRAFRUZ3/
	XtfvjfCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVrqJ-0058mX-FY; Wed, 07 Sep 2022 09:59:35 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVrpx-0058bT-CZ
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 09:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1662544753; x=1694080753;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=Ed4GfPXhBuVZiumdH7dEVJo7SnWEki3vdv8C9fy9jwQ=;
  b=cOTsUcRszjnm34MM64h1QHpYpahDEMfujF/91hrWn3YfD1HLHQQkktIj
   KcxOnshvr58TgNbfbue3hJxJCeFaJU3pZc9tuTNEQqi50IS304X/Ei6Tr
   IczkfUhG0y6+3DIRsUj/L83VZEq8sy+2cMDRpdkfu7ywcjcQV1SXclA3H
   0=;
X-IronPort-AV: E=Sophos;i="5.93,296,1654560000"; 
   d="scan'208";a="223984069"
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Thread-Topic: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:58:56 +0000
Received: from EX13D02EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 15083E00B4;
	Wed,  7 Sep 2022 09:58:55 +0000 (UTC)
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 09:58:54 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1497.040;
 Wed, 7 Sep 2022 09:58:54 +0000
From: "Sironi, Filippo" <sironi@amazon.de>
To: Christoph Hellwig <hch@lst.de>, Jaroslav Pulchart
	<jaroslav.pulchart@gooddata.com>, "Greenberg, Aviv" <aggreenb@amazon.com>,
	"Dutta, Soumyaroop" <duttaso@amazon.com>, "Priescu, Valentin"
	<priescuv@amazon.de>, "Machulsky, Zorik" <zorik@amazon.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
Thread-Index: AQHYwoNPj8Tyb1j+Nk+7wft2AMLbIa3T0K8AgAAMsIA=
Date: Wed, 7 Sep 2022 09:58:54 +0000
Message-ID: <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
 <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
In-Reply-To: <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.249]
Content-Type: text/plain; charset="utf-8"
Content-ID: <96F971517EE21349B736CC8EE55D53DE@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_025913_553553_532E59B0 
X-CRM114-Status: GOOD (  17.99  )
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

QWRkaW5nIG1vcmUgZm9sa3MgKFNvdW15YXJvb3AsIFZhbGVudGluLCBhbmQgWm9yaWspIGludm9s
dmVkIGluIHRoZSBpbnZlc3RpZ2F0aW9uLCB3aGljaCBpcyBieSBub3cgY29uY2x1ZGVkLg0KDQrv
u79PbiAwNy4wOS4yMiwgMTE6MTMsICJTaXJvbmksIEZpbGlwcG8iIDxzaXJvbmlAYW1hem9uLmRl
PiB3cm90ZToNCg0KICAgIEknbSBhd2FyZSBvZiBhIGN1c3RvbWVyIGNvbnRhY3QgcmVnYXJkaW5n
IHRoaXMgaXNzdWUgYW5kIEkga25vdyB0aGF0IHRoZSB0ZWFtIHJlc3BvbnNpYmxlIGZvciB0aGUg
TlZNZSBpbXBsZW1lbnRhdGlvbiBpcyBpbnZlc3RpZ2F0aW5nLg0KICAgIEFkZGluZyBBdml2IHNp
bmNlIGhlJ3MgY2xvc2VyIHRvIHRoaXMgc3BhY2UgdGhhbiBJIGFtIGFuZCBtYXkgaGF2ZSBtb3Jl
IGluc2lnaHRzIGludG8gaG93IHRoZSBpbnZlc3RpZ2F0aW9uIGlzIHByb2dyZXNzaW5nLiANCg0K
ICAgIE9uIDA3LjA5LjIyLCAwODozMCwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5kZT4g
d3JvdGU6DQoNCiAgICAgICAgQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZS4NCg0KDQoNCiAgICAgICAgRmlsaXBwbywNCg0KICAgICAgICBjYW4geW91
IGhlbHAgZmlndXJpbmcgb3V0IHdoYXQgaXMgZ29pbmcgb24gd2l0aCB0aGlzIEFtYXpvbiBjb250
cm9sbGVyPw0KDQogICAgICAgIE9uIFdlZCwgU2VwIDA3LCAyMDIyIGF0IDA4OjA1OjA1QU0gKzAy
MDAsIEphcm9zbGF2IFB1bGNoYXJ0IHdyb3RlOg0KICAgICAgICA+IEhlbGxvLA0KICAgICAgICA+
DQogICAgICAgID4gSSB3b3VsZCBsaWtlIHRvIHJlcG9ydCBhIHJlZ3Jlc3Npb24gaXNzdWUgaW4g
NS4xOS55IGluIE5WTWUgZHJpdmVyLg0KICAgICAgICA+DQogICAgICAgID4gVGhlIGlzc3VlIGlz
IHJlcHJvZHVjaWJsZSBhdCBBV1MgRUMyIGluc3RhbmNlcyB3aXRoIGxvY2FsIE5WTWUgc3RvcmFn
ZQ0KICAgICAgICA+IGxpa2UgInI1ZC4qIi4gS2VybmVsIHJlcG9ydCAiSU8gcXVldWVzIG5vdCBj
cmVhdGVkIjoNCiAgICAgICAgPiBbICAgIDIuOTM2NjQxXSBudm1lIG52bWUwOiAyLzAvMCBkZWZh
dWx0L3JlYWQvcG9sbCBxdWV1ZXMgIDwtIEVCUyB2b2x1bWUNCiAgICAgICAgPiBbICAgIDIuOTM5
NDkzXSBudm1lIG52bWUxOiAyLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMgIDwtIEVCUyB2
b2x1bWUNCiAgICAgICAgPiBbICAgIDIuOTQwNzk3XSBudm1lIG52bWUyOiBJTyBxdWV1ZXMgbm90
IGNyZWF0ZWQgICAgICAgICAgICAgIDwtIExvY2FsIHZvbHVtZQ0KICAgICAgICA+IHdpdGggNS4x
OS55IChrZXJuZWwgNS4xOSkgYW5kIHRoZSBudm1lIHN0b3JhZ2UgY2Fubm90IGJlIHVzZWQuDQog
ICAgICAgID4NCiAgICAgICAgPiBJIGJpc2VjdGVkIHRoZSBpc3N1ZSB0byBjb21taXQNCiAgICAg
ICAgPiAiYWE0MWQyZmU2MGVlMmU0NDUyYjBmOWNhOWYwZjZkODBhNGZmOWY5ZCIgKG52bWU6IHNl
dCBjb250cm9sbGVyDQogICAgICAgID4gZW5hYmxlIGJpdCBpbiBhIHNlcGFyYXRlIHdyaXRlKS4g
UmV2ZXJ0aW5nIGl0IG1ha2VzIHRoZSBudm1lIGRldmljZQ0KICAgICAgICA+IHdvcmtpbmcgYWdh
aW46DQogICAgICAgID4gWyAgICAzLjAyNTU5OV0gbnZtZSBudm1lMDogMi8wLzAgZGVmYXVsdC9y
ZWFkL3BvbGwgcXVldWVzDQogICAgICAgID4gWyAgICAzLjAzMjQ2N10gbnZtZSBudm1lMjogOC8w
LzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzDQogICAgICAgID4gWyAgICAzLjA0MDA0MF0gbnZt
ZSBudm1lMTogMi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzDQogICAgICAgID4NCiAgICAg
ICAgPiBCZXN0LA0KICAgICAgICA+IC0tDQogICAgICAgID4gSmFyb3NsYXYgUHVsY2hhcnQNCiAg
ICAgICAgPiBTci4gUHJpbmNpcGFsIFNXIEVuZ2luZWVyDQogICAgICAgID4gR29vZERhdGENCiAg
ICAgICAgLS0tZW5kIHF1b3RlZCB0ZXh0LS0tDQoNCg0KCgoKQW1hem9uIERldmVsb3BtZW50IENl
bnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJl
cmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


