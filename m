Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B201C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:19:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC3320659
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aY7UX8v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC3320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onestopsystems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fGB35nRjPntWFyv8BciQYZbJUHZagXq8zDXjSkh+2Ro=; b=aY7UX8v55fgoRO
	tGGu/MMRjWojsAjePgXuYkyj6r1cwkLOQ2H+EY6ql5/dSnrbA/hdvX1DUfrAZPC0dj6/nFmuZRXN2
	gwPy5NtXL9+WKOG5ZfJH0Q9DbbIX3uj5fns+Nu2Nj6Z0NA4GRJlg+mIBByVxVS3qDqA5Vpj9odO36
	g0spiG6RsLuuD/h4j1OAE+2ZZBIqBqT9nuGWSSuSbev+0uiMEtAffMYavAiXEiAS1rBXnjFRCay6G
	wEID6rueJig9Ey3fOjq0ns3R59bTSQXIYRjqfglaBJM0RKl6j+FE2JIVnf50RKZPlEDV3yc1Z7r2d
	q0CJIEHLBoo0k4avNlIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUdZe-0007qA-Ph; Tue, 12 Nov 2019 21:19:42 +0000
Received: from cox.onestopsystems.com ([98.187.250.34]
 helo=osserver.onestopsystems.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUdZd-0007pX-1e
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 21:19:42 +0000
Received: from OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203]) by
 OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203%10]) with mapi id
 14.03.0468.000; Tue, 12 Nov 2019 13:19:36 -0800
From: Mark Ruijter <MRuijter@onestopsystems.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
Thread-Topic: [PATCH] nvmet: make ctrl-id configurable
Thread-Index: AQHVknKB085Gn2d/PkqsHei3HhUGjqd7R8OAgAAkHQCAACb2gIAAOzMAgAHmsQCAATE7AIADK4IAgAZnCICAACZ5gA==
Date: Tue, 12 Nov 2019 21:19:35 +0000
Message-ID: <81646D07-6C44-427C-B959-F87F7F1B57AC@onestopsystems.com>
References: <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
In-Reply-To: <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-ID: <8D816E236F17CB43B5FED266337CEE8C@onestopsystems.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_131941_114099_0E2BC73B 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+PiBJIHRoaW5rIHdlIG5lZWQgYSBjbnRsaWRfbWF4Lg0KDQpJIGluaXRpYWxseSB0aG91Z2h0
IGFib3V0IHRoYXQgYW5kIGRlY2lkZWQgaXQgd2FzIG5vdCB3b3J0aCBpdC4gV2hlbiBhIHVzZXIg
c2VsZWN0cyB0aGUgbWluaW11bSBpdCBpcyBoaWdobHkgdW5saWtlbHkgdGhhdCBhIGNvbGxpc2lv
biB3aWxsIG9jY3VyLg0KDQpXaXRoIGEgc3ltbWV0cmljYWwgY29uZmlndXJhdGlvbiBldmVuIGFu
IG9mZnNldCBvZiAxIHdvdWxkIGJlIGVub3VnaCB0byBwcmV2ZW50IHRoYXQ/DQoNCkkgZG9u4oCZ
dCBtaW5kIGFkZGluZyBpdCBpZiB0aGUgY29uc2Vuc3VzIGlzIHRoYXQgaXTigJlzIHdvcnRoIHRo
ZSBlZmZvcnQuDQoNCk1hcmsNCg0KDQo+IE9wIDEyIG5vdi4gMjAxOSBvbSAyMDowMiBoZWVmdCBT
YWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiBoZXQgdm9sZ2VuZGUgZ2VzY2hyZXZlbjoN
Cj4gDQo+IO+7vw0KPiANCj4+IE9uIDExLzgvMTkgODoxNSBBTSwgTWFyayBSdWlqdGVyIHdyb3Rl
Og0KPj4gSSBoYXZlIHNldHVwIGEgY2x1c3RlciB1c2luZyB0d28gbm9kZXMgd2l0aCBhIGR1YWwg
cG9ydGVkIG52bWUgZHJpdmUgYW5kIHRlc3RlZCBleHBvcnRpbmcgdGhlIGRyaXZlIGZyb20gYm90
aCBub2Rlcy4NCj4+IFRoZSBjb25maWd1cmF0aW9uIG9uIGJvdGggbm9kZXMsIHdpdGggdGhlIGV4
Y2VwdGlvbiBvZiB0aGUgaXAgYWRkcmVzcywgbG9va3MgbGlrZSB0aGlzOg0KPj4gICAgIHsNCj4+
ICAgICAgICJhZGRyIjogew0KPj4gICAgICAgICAiYWRyZmFtIjogImlwdjQiLA0KPj4gICAgICAg
ICAidHJhZGRyIjogIjE5Mi4xNjguMS4xMSIsDQo+PiAgICAgICAgICJ0cmVxIjogIm5vdCBzcGVj
aWZpZWQiLA0KPj4gICAgICAgICAidHJzdmNpZCI6ICI0NDIwIiwNCj4+ICAgICAgICAgInRydHlw
ZSI6ICJ0Y3AiDQo+PiAgICAgICB9LA0KPj4gICAgICAgInBvcnRpZCI6IDMyMiwNCj4+ICAgICAg
ICJyZWZlcnJhbHMiOiBbXSwNCj4+ICAgICAgICJzdWJzeXN0ZW1zIjogWw0KPj4gICAgICAgICAi
Y2x2b2wiDQo+PiAgICAgICBdDQo+PiAgICAgfSwNCj4+ICAgInN1YnN5c3RlbXMiOiBbDQo+PiAg
ICAgew0KPj4gICAgICAgImFsbG93ZWRfaG9zdHMiOiBbXSwNCj4+ICAgICAgICJhdHRyIjogew0K
Pj4gICAgICAgICAiYWxsb3dfYW55X2hvc3QiOiAiMSIsDQo+PiAgICAgICAgICJtb2RlbCI6ICJj
bHBvb2wvY2x2b2wiLA0KPj4gICAgICAgICAic2VyaWFsIjogImU5NDQzMDkyMGY2MTAzYWYiLA0K
Pj4gICAgICAgICAidmVyc2lvbiI6ICIxLjMiDQo+PiAgICAgICB9LA0KPj4gICAgICAgIm5hbWVz
cGFjZXMiOiBbDQo+PiAgICAgICAgIHsNCj4+ICAgICAgICAgICAiZGV2aWNlIjogew0KPj4gICAg
ICAgICAgICAgIm5ndWlkIjogIjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMCIs
DQo+PiAgICAgICAgICAgICAicGF0aCI6ICIvZGV2L2NscG9vbC9jbHZvbCIsDQo+PiAgICAgICAg
ICAgICAidXVpZCI6ICI5OTQ1MTU5Ni05Njc1LTQzODItYmZmOC1iNzhlZTM0ZGU1NjciDQo+PiAg
ICAgICAgICAgfSwNCj4+ICAgICAgICAgICAiZW5hYmxlIjogMSwNCj4+ICAgICAgICAgICAibnNp
ZCI6IDENCj4+ICAgICAgICAgfQ0KPj4gICAgICAgXSwNCj4+ICAgICAgICJucW4iOiAiY2x2b2wi
DQo+PiAgICAgfSwNCj4+IFdoZW4gSSBub3cgY29ubmVjdCB0aGUgaW5pdGlhdG9yIHRvIHRoZSB0
d28gY2x1c3RlciBub2RlcyB3aXRob3V0IHRoZSBwYXRjaCB0aGUgcmVzdWx0IHdpbGwgYmUgYSBj
b250cm9sbGVyIGlkIGNvbGxpc2lvbi4NCj4+IEFuZCB0aGUgaW5pdGlhdG9yIHJlZnVzZXMgdG8g
Y29ubmVjdCB0byB0aGUgc2Vjb25kIG5vZGUgdGhhdCB5b3UgdHJ5IHRvIGNvbm5lY3QuDQo+PiAt
LQ0KPj4gWyA3ODk1LjA1MjMwMl0gbnZtZSBudm1lMDogbmV3IGN0cmw6IE5RTiAiY2x2b2wiLCBh
ZGRyIDE5Mi4xNjguOC4xMDo0NDIwDQo+PiBbIDc4OTUuMDUzMjk3XSBudm1lMG4xOiBkZXRlY3Rl
ZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDEwNzM3NDE4MjQwMA0KPj4gWyA3ODk4LjE4ODMy
MV0gbnZtZSBudm1lMTogRHVwbGljYXRlIGNudGxpZCAxIHdpdGggbnZtZTAsIHJlamVjdGluZw0K
Pj4gLS0NCj4+IFdpdGggdGhlIGF0dGFjaGVkIHBhdGNoIEkgYW0gYWJsZSB0byBmb3JjZSB0aGUg
c2Vjb25kIG5vZGUgdG8gdXNlIGEgaGlnaGVyIG9mZnNldCB3aGVuIGVudW1lcmF0aW5nIGNvbnRy
b2xsZXIgaWRzOg0KPj4gbm9kZWE6DQo+PiAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvc3Vic3lz
dGVtcy9jbHZvbCAjIGNhdCBjbnRsaWRfbWluDQo+PiAxDQo+PiBub2RlYjovc3lzL2tlcm5lbC9j
b25maWcvbnZtZXQvc3Vic3lzdGVtcy9jbHZvbCAjIGNhdCBjbnRsaWRfbWluDQo+PiAzMg0KPj4g
SW4gcmVhbCBsaWZlIHRoZSBudW1iZXIgdXNlZCBmb3IgdGhlIG9mZnNldHMgY291bGQgYmUgZGVy
aXZlZCBmcm9tIHNvbWV0aGluZyBsaWtlIHRoZSBQYWNlbWFrZXIgbm9kZSBudW1iZXIuDQo+PiBB
bmQgdGhlIFBhY2VtYWtlciArIERMTSBjb3VsZCBiZSB1c2VkIGZvciBudm1lIHBlcnNpc3RlbnQg
cmVzZXJ2YXRpb25zLg0KPj4gVGhlIGNvbnRyb2xsZXIgaWQgY29sbGlzaW9uIG5vdyBubyBsb25n
ZXIgb2NjdXJzLg0KPj4gQW5kIHRoZSBpbml0aWF0b3IgY2FuIGNvbm5lY3QsIGFuZCB0d28gcGF0
aHMgd2lsbCBiZSBzaG93bjoNCj4+IHJvb3RAcjExaTE6fiMgbnZtZSBsaXN0LXN1YnN5cw0KPj4g
bnZtZS1zdWJzeXMwIC0gTlFOPWNsdm9sDQo+PiBcDQo+PiAgKy0gbnZtZTAgdGNwIHRyYWRkcj0x
OTIuMTY4LjEuMTAgdHJzdmNpZD00NDIwDQo+PiAgKy0gbnZtZTEgdGNwIHRyYWRkcj0xOTIuMTY4
LjEuMTEgdHJzdmNpZD00NDIwDQo+PiBEb2VzIHRoaXMgYWxsIG1ha2Ugc2Vuc2U/DQo+IA0KPiBJ
IHRoaW5rIHdlIG5lZWQgYSBjbnRsaWRfbWF4IHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBoYXZlIGNv
bGxpc2lvbnMuLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
