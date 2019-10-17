Return-Path: <SRS0=aIMh=YK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C701FA372B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 07:03:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F35B20640
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lV0NL7pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F35B20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TDPlkZxzUVEqgYmoF3HMM0keneu//azrj6vN6lIaO4M=; b=lV0NL7pAYKXqg/wCw1JENudw7U
	5l41wWZOseKYkceR6qsB46+6vOu+wZh5FVBiTfVmls37pP/pU4TcukcxIhewsZoKN7IsaBC90HnEB
	p9FhflFM/RE6ZLTBJINgVmMXQ+EZ7hewja1KyJUn0kfW8WcTSAp5cn8FO6lMQlKgD5nqBLIqpdBSs
	GX8WDb8Bex3i1kTdqbvEUCJiF8Q5No5TWlS9hmtNrDy5WR7qq+9WT15zgCOvlkCAluOXY61O5XJTA
	OTnu5m3JigXnZAQmpF1De2umjLgAb2JW5ItrQd7OxTSMe0tgP1a4kBtvPqIZDTnjq4CXwJQgvin3a
	O7nAp54Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iKzog-0005f0-SX; Thu, 17 Oct 2019 07:03:22 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKzod-0005eP-Mf
 for linux-nvme@lists.infradead.org; Thu, 17 Oct 2019 07:03:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 460DAB161;
 Thu, 17 Oct 2019 07:03:16 +0000 (UTC)
Subject: Re: [PATCH] nvme-multipath: fix possible io hang after ctrl reconnect
To: Anton Eidelman <anton@lightbitslabs.com>, linux-nvme@lists.infradead.org, 
 hch@lst.de, keith.busch@intel.com, sagi@grimberg.me
References: <20191015170802.16830-1-anton@lightbitslabs.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <d8899bbb-8f7a-9632-bb16-3c8bd3486827@suse.de>
Date: Thu, 17 Oct 2019 09:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191015170802.16830-1-anton@lightbitslabs.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_000320_031557_EB301688 
X-CRM114-Status: GOOD (  23.88  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMTUvMTkgNzowOCBQTSwgQW50b24gRWlkZWxtYW4gd3JvdGU6Cj4gVGhlIGZvbGxvd2lu
ZyBzY2VuYXJpbyByZXN1bHRzIGluIGFuIElPIGhhbmc6Cj4gMSkgY3RybCBjb21wbGV0ZXMgYSBy
ZXF1ZXN0IHdpdGggTlZNRV9TQ19BTkFfVFJBTlNJVElPTi4KPiAgICBOVk1FX05TX0FOQV9QRU5E
SU5HIGJpdCBpbiBucy0+ZmxhZ3MgaXMgc2V0IGFuZCBhbmFfd29yayBpcyB0cmlnZ2VyZWQuCj4g
MikgYW5hX3dvcms6IG52bWVfcmVhZF9hbmFfbG9nKCkgdHJpZXMgdG8gZ2V0IHRoZSBBTkEgbG9n
IHBhZ2UgZnJvbSB0aGUgY3RybC4KPiAgICBUaGlzIGZhaWxzIGJlY2F1c2UgY3RybCBkaXNjb25u
ZWN0cy4KPiAgICBUaGVyZWZvcmUgbnZtZV91cGRhdGVfbnNfYW5hX3N0YXRlKCkgaXMgbm90IGNh
bGxlZAo+ICAgIGFuZCBOVk1FX05TX0FOQV9QRU5ESU5HIGJpdCBpbiBucy0+ZmxhZ3MgaXMgbm90
IGNsZWFyZWQuCj4gMykgY3RybCByZWNvbm5lY3RzOiBudm1lX21wYXRoX2luaXQoY3RybCwuLi4p
IGNhbGxzCj4gICAgbnZtZV9yZWFkX2FuYV9sb2coY3RybCwgZ3JvdXBzX29ubHk9dHJ1ZSkuCj4g
ICAgSG93ZXZlciwgbnZtZV91cGRhdGVfYW5hX3N0YXRlKCkgZG9lcyBub3QgdXBkYXRlIG5hbWVz
cGFjZXMKPiAgICBiZWNhdXNlIG5yX25zaWRzID0gMCAoZHVlIHRvIGdyb3Vwc19vbmx5IG1vZGUp
Lgo+IDQpIHNjYW5fd29yayBjYWxscyBudm1lX3ZhbGlkYXRlX25zKCkgZmluZHMgdGhlIG5zIGFu
ZCByZS12YWxpZGF0ZXMgT0suCj4gCj4gUmVzdWx0Ogo+IFRoZSBjdHJsIGlzIG5vdyBsaXZlIGJ1
dCBOVk1FX05TX0FOQV9QRU5ESU5HIGJpdCBpbiBucy0+ZmxhZ3MgaXMgc3RpbGwgc2V0Lgo+IENv
bnNlcXVlbnRseSBjdHJsIHdpbGwgbmV2ZXIgYmUgY29uc2lkZXJlZCBhIHZpYWJsZSBwYXRoIGJ5
IF9fbnZtZV9maW5kX3BhdGgoKS4KPiBJTyB3aWxsIGhhbmcgaWYgY3RybCBpcyB0aGUgb25seSBv
ciB0aGUgbGFzdCBwYXRoIHRvIHRoZSBuYW1lc3BhY2UuCj4gCj4gTW9yZSBnZW5lcmFsbHksIHdo
aWxlIGN0cmwgaXMgcmVjb25uZWN0aW5nLCBpdHMgQU5BIHN0YXRlIG1heSBjaGFuZ2UuCj4gQW5k
IGJlY2F1c2UgbnZtZV9tcGF0aF9pbml0KCkgcmVxdWVzdHMgQU5BIGxvZyBpbiBncm91cHNfb25s
eSBtb2RlLAo+IHRoZXNlIGNoYW5nZXMgYXJlIG5vdCBwcm9wYWdhdGVkIHRvIHRoZSBleGlzdGlu
ZyBjdHJsIG5hbWVzcGFjZXMuCj4gVGhpcyBtYXkgcmVzdWx0IGluIGEgbWFsLWZ1bmN0aW9uIG9y
IGFuIElPIGhhbmcuCj4gCj4gU29sdXRpb246Cj4gbnZtZV9tcGF0aF9pbml0KCkgd2lsbCBudm1l
X3JlYWRfYW5hX2xvZygpIHdpdGggZ3JvdXBzX29ubHkgc2V0IHRvIGZhbHNlLgo+IFRoaXMgd2ls
bCBub3QgaGFybSB0aGUgbmV3IGN0cmwgY2FzZSAobm8gbmFtZXNwYWNlcyBwcmVzZW50KSwKPiBh
bmQgd2lsbCBtYWtlIHN1cmUgdGhlIEFOQSBzdGF0ZSBvZiBuYW1lc3BhY2VzIGdldHMgdXBkYXRl
ZCBhZnRlciByZWNvbm5lY3QuCj4gTGVhdmluZyB0aGUgZ3JvdXBzX29ubHkgY2FwYWJpbGl0eSBp
biBudm1lX3JlYWRfYW5hX2xvZygpIGluIHBsYWNlLAo+IGFsdGhvdWdoIGl0IGlzIHVudXNlZCBm
b3Igbm93IChOVk1FX0FOQV9MT0dfUkdPIGlzIGRlZmluZWQgaW4gc3BlYykuCj4gCj4gQW5vdGhl
ciBvcHRpb24gd291bGQgYmUgZm9yIG52bWVfbXBhdGhfaW5pdCgpIHRvIGludm9rZQo+IG52bWVf
cGFyc2VfYW5hX2xvZyguLi4sIG52bWVfc2V0X25zX2FuYV9zdGF0ZSkgZm9yIGVhY2ggZXhpc3Rp
bmcKPiBuYW1lc3BhY2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW50b24gRWlkZWxtYW4gPGFudG9u
QGxpZ2h0Yml0c2xhYnMuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGgu
YyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBpbmRleCAzMGRlN2VmZWYwMDMuLmQzMjA2ODRkMjVi
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gQEAgLTcxNSw3ICs3MTUsNyBAQCBpbnQgbnZt
ZV9tcGF0aF9pbml0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX2lkX2N0cmwg
KmlkKQo+ICAJCWdvdG8gb3V0Owo+ICAJfQo+ICAKPiAtCWVycm9yID0gbnZtZV9yZWFkX2FuYV9s
b2coY3RybCwgdHJ1ZSk7Cj4gKwllcnJvciA9IG52bWVfcmVhZF9hbmFfbG9nKGN0cmwsIGZhbHNl
KTsKPiAgCWlmIChlcnJvcikKPiAgCQlnb3RvIG91dF9mcmVlX2FuYV9sb2dfYnVmOwo+ICAJcmV0
dXJuIDA7Cj4gCkFjdHVhbGx5IEkgdGhpbmsgd2Ugc2hvdWxkIGRyb3AgdGhlIFJHTyBoYW5kbGlu
ZyBpbiBudm1lX3JlYWRfYW5hX2xvZygpLApzZWVpbmcgdGhlIGlzc3VlcyBpdCBoYXMgY2F1c2Vk
IGFscmVhZHkuCkJ1dCB0aGlzIGNhbiBiZSBkb25lIGluIGEgbmV3IHBhdGNoLgoKUmV2aWV3ZWQt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmNvbT4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcK
aGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDI0NzE2NSAoQUcgTcO8bmNoZW4pLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
