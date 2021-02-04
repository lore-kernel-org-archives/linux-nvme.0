Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0426BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:09:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFA164DC3
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFA164DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5krYGZJndRjP+vrojBg2IiPwOm7+Tspw0VssgOQvMiE=; b=VIDpEVO7bPLitafXWkZ5a2Tes
	OyciYh+lCgtS91rGEz2IJvNjdjM5hh/2czdJMYKju8FF1yysfrJ/XRO2OHWGOB6g30QFOmSVZwAfq
	g5q+0B91xB0Dl5sd2BfUu6SaMPSoFr5bsBLnxFwdir/IAloKkGN4UBL0bVTtPaTwnRGLU5tdA51EN
	NkJO8q1OaUA+KgbnTaIX4LbTwtkxJbu6EkDDmESWhBUi0gtWU41U0qDdOTw1TOJlzTZ/mjVctBGll
	XUCrrjCWmE20M37tENFF87iwKGHlk3Ik7SAaILCg/OidQNHlhV9AdZXlCWQkcfhCz2rjqV6Hk82ey
	n/aVDlG8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Yla-0004nr-91; Thu, 04 Feb 2021 07:09:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YlX-0004nJ-DR
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:09:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 48925AC97;
 Thu,  4 Feb 2021 07:09:22 +0000 (UTC)
Subject: Re: [PATCH 10/35] fabrics: export do_discover(), build_options() and
 config
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-11-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5572e869-cd25-15ca-e95b-b4304e19d83b@suse.de>
Date: Thu, 4 Feb 2021 08:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-11-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_020923_685070_333303C2 
X-CRM114-Status: GOOD (  28.70  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gVGhlc2UgZnVuY3Rpb25zIHdpbGwgYmUgY2Fs
bGVkIGJ5IHRoZSBtb25pdG9yIGNvZGUuCj4gQWxzbyBleHBvcnQgQlVGX1NJWkUgYXMgdGhlIHNp
emUgb2YgYXJnc3RyLgo+IAo+IEJlaW5nIGFibGUgdG8gYWNjZXNzIHN0cnVjdCBjb25maWcgYW5k
IHRoZSAiY2ZnIiB2YXJpYWJsZQo+IGZyb20gZmFicmljcy5jIGlzIGVzc2VudGlhbCBmb3IgdGhl
IG1vbml0b3IgdG8gbGV2ZXJhZ2UgdGhlIGV4aXN0aW5nLAo+IHdlbGwgdGVzdGVkIGNvZGUgYXMg
bXVjaCBhcyBwb3NzaWJsZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2lsY2sgPG13aWxj
a0BzdXNlLmNvbT4KPiAtLS0KPiAgIGZhYnJpY3MuYyB8IDMzICsrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+ICAgZmFicmljcy5oIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyOSBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZmFicmljcy5jIGIvZmFicmljcy5jCj4gaW5kZXgg
NTU1YjZiNC4uYzFhNGJiNSAxMDA2NDQKPiAtLS0gYS9mYWJyaWNzLmMKPiArKysgYi9mYWJyaWNz
LmMKPiBAQCAtNjksMzEgKzY5LDcgQEAgY29uc3QgY2hhciAqY29uYXJnX3RyYWRkciA9ICJ0cmFk
ZHIiOwo+ICAgY29uc3QgY2hhciAqY29uYXJnX3Ryc3ZjaWQgPSAidHJzdmNpZCI7Cj4gICBjb25z
dCBjaGFyICpjb25hcmdfaG9zdF90cmFkZHIgPSAiaG9zdF90cmFkZHIiOwo+ICAgCj4gLXN0YXRp
YyBzdHJ1Y3QgY29uZmlnIHsKPiAtCWNoYXIgKm5xbjsKPiAtCWNoYXIgKnRyYW5zcG9ydDsKPiAt
CWNoYXIgKnRyYWRkcjsKPiAtCWNoYXIgKnRyc3ZjaWQ7Cj4gLQljaGFyICpob3N0X3RyYWRkcjsK
PiAtCWNoYXIgKmhvc3RucW47Cj4gLQljaGFyICpob3N0aWQ7Cj4gLQlpbnQgIG5yX2lvX3F1ZXVl
czsKPiAtCWludCAgbnJfd3JpdGVfcXVldWVzOwo+IC0JaW50ICBucl9wb2xsX3F1ZXVlczsKPiAt
CWludCAgcXVldWVfc2l6ZTsKPiAtCWludCAga2VlcF9hbGl2ZV90bW87Cj4gLQlpbnQgIHJlY29u
bmVjdF9kZWxheTsKPiAtCWludCAgY3RybF9sb3NzX3RtbzsKPiAtCWludCAgdG9zOwo+IC0JY2hh
ciAqcmF3Owo+IC0JY2hhciAqZGV2aWNlOwo+IC0JaW50ICBkdXBsaWNhdGVfY29ubmVjdDsKPiAt
CWludCAgZGlzYWJsZV9zcWZsb3c7Cj4gLQlpbnQgIGhkcl9kaWdlc3Q7Cj4gLQlpbnQgIGRhdGFf
ZGlnZXN0Owo+IC0JYm9vbCBwZXJzaXN0ZW50Owo+IC0JYm9vbCBtYXRjaGluZ19vbmx5Owo+IC19
IGNmZyA9IHsgLmN0cmxfbG9zc190bW8gPSBOVk1GX0RFRl9DVFJMX0xPU1NfVE1PIH07Cj4gK3N0
cnVjdCBjb25maWcgY2ZnID0geyAuY3RybF9sb3NzX3RtbyA9IE5WTUZfREVGX0NUUkxfTE9TU19U
TU8gfTsKPiAgIAo+ICAgc3RydWN0IGNvbm5lY3RfYXJncyB7Cj4gICAJY2hhciAqc3Vic3lzbnFu
Owo+IEBAIC0xMDcsNyArODMsNiBAQCBzdHJ1Y3QgY29ubmVjdF9hcmdzIHsKPiAgIAo+ICAgc3Ry
dWN0IGNvbm5lY3RfYXJncyAqdHJhY2tlZF9jdHJsczsKPiAgIAo+IC0jZGVmaW5lIEJVRl9TSVpF
CQk0MDk2Cj4gICAjZGVmaW5lIFBBVEhfTlZNRV9GQUJSSUNTCSIvZGV2L252bWUtZmFicmljcyIK
PiAgICNkZWZpbmUgUEFUSF9OVk1GX0RJU0MJCSIvZXRjL252bWUvZGlzY292ZXJ5LmNvbmYiCj4g
ICAjZGVmaW5lIFBBVEhfTlZNRl9IT1NUTlFOCSIvZXRjL252bWUvaG9zdG5xbiIKPiBAQCAtMjI2
LDcgKzIwMSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjbXNfc3RyKF9fdTggY20pCj4gICAJcmV0
dXJuIGFyZ19zdHIoY21zLCBBUlJBWV9TSVpFKGNtcyksIGNtKTsKPiAgIH0KPiAgIAo+IC1zdGF0
aWMgaW50IGRvX2Rpc2NvdmVyKGNoYXIgKmFyZ3N0ciwgYm9vbCBjb25uZWN0KTsKPiAraW50IGRv
X2Rpc2NvdmVyKGNoYXIgKmFyZ3N0ciwgYm9vbCBjb25uZWN0KTsKPiAgIAo+ICAgLyoKPiAgICAq
IHBhcnNlIHN0cmluZ3Mgd2l0aCBjb25uZWN0IGFyZ3VtZW50cyB0byBmaW5kIGEgcGFydGljdWxh
ciBmaWVsZC4KPiBAQCAtODU1LDcgKzgzMCw3IEBAIGFkZF9hcmd1bWVudChjaGFyICoqYXJnc3Ry
LCBpbnQgKm1heF9sZW4sIGNoYXIgKmFyZ19zdHIsIGNoYXIgKmFyZykKPiAgIAlyZXR1cm4gMDsK
PiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50IGJ1aWxkX29wdGlvbnMoY2hhciAqYXJnc3RyLCBpbnQg
bWF4X2xlbiwgYm9vbCBkaXNjb3ZlcikKPiAraW50IGJ1aWxkX29wdGlvbnMoY2hhciAqYXJnc3Ry
LCBpbnQgbWF4X2xlbiwgYm9vbCBkaXNjb3ZlcikKPiAgIHsKPiAgIAlpbnQgbGVuOwo+ICAgCj4g
QEAgLTEyNjQsNyArMTIzOSw3IEBAIHN0YXRpYyB2b2lkIG52bWZfZ2V0X2hvc3RfaWRlbnRpZmll
cnMoaW50IGN0cmxfaW5zdGFuY2UpCj4gICAJY2ZnLmhvc3RpZCA9IG52bWVfZ2V0X2N0cmxfYXR0
cihwYXRoLCAiaG9zdGlkIik7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCBkb19kaXNjb3Zlcihj
aGFyICphcmdzdHIsIGJvb2wgY29ubmVjdCkKPiAraW50IGRvX2Rpc2NvdmVyKGNoYXIgKmFyZ3N0
ciwgYm9vbCBjb25uZWN0KQo+ICAgewo+ICAgCXN0cnVjdCBudm1mX2Rpc2NfcnNwX3BhZ2VfaGRy
ICpsb2cgPSBOVUxMOwo+ICAgCWNoYXIgKmRldl9uYW1lOwo+IGRpZmYgLS1naXQgYS9mYWJyaWNz
LmggYi9mYWJyaWNzLmgKPiBpbmRleCBmNWI4ZWFmLi5jZTk2NWEzIDEwMDY0NAo+IC0tLSBhL2Zh
YnJpY3MuaAo+ICsrKyBiL2ZhYnJpY3MuaAo+IEBAIC0xMCw0ICsxMCwzOCBAQCBleHRlcm4gaW50
IGZhYnJpY3NfY29ubmVjdChjb25zdCBjaGFyICpkZXNjLCBpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
Owo+ICAgZXh0ZXJuIGludCBmYWJyaWNzX2Rpc2Nvbm5lY3QoY29uc3QgY2hhciAqZGVzYywgaW50
IGFyZ2MsIGNoYXIgKiphcmd2KTsKPiAgIGV4dGVybiBpbnQgZmFicmljc19kaXNjb25uZWN0X2Fs
bChjb25zdCBjaGFyICpkZXNjLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpOwo+ICAgCj4gKy8qIFN5
bWJvbHMgdXNlZCBieSBtb25pdG9yLmMgKi8KPiArCj4gK3N0cnVjdCBjb25maWcgewo+ICsJY2hh
ciAqbnFuOwo+ICsJY2hhciAqdHJhbnNwb3J0Owo+ICsJY2hhciAqdHJhZGRyOwo+ICsJY2hhciAq
dHJzdmNpZDsKPiArCWNoYXIgKmhvc3RfdHJhZGRyOwo+ICsJY2hhciAqaG9zdG5xbjsKPiArCWNo
YXIgKmhvc3RpZDsKPiArCWludCAgbnJfaW9fcXVldWVzOwo+ICsJaW50ICBucl93cml0ZV9xdWV1
ZXM7Cj4gKwlpbnQgIG5yX3BvbGxfcXVldWVzOwo+ICsJaW50ICBxdWV1ZV9zaXplOwo+ICsJaW50
ICBrZWVwX2FsaXZlX3RtbzsKPiArCWludCAgcmVjb25uZWN0X2RlbGF5Owo+ICsJaW50ICBjdHJs
X2xvc3NfdG1vOwo+ICsJaW50ICB0b3M7Cj4gKwljaGFyICpyYXc7Cj4gKwljaGFyICpkZXZpY2U7
Cj4gKwlpbnQgIGR1cGxpY2F0ZV9jb25uZWN0Owo+ICsJaW50ICBkaXNhYmxlX3NxZmxvdzsKPiAr
CWludCAgaGRyX2RpZ2VzdDsKPiArCWludCAgZGF0YV9kaWdlc3Q7Cj4gKwlib29sIHBlcnNpc3Rl
bnQ7Cj4gKwlib29sIG1hdGNoaW5nX29ubHk7Cj4gK307Cj4gK2V4dGVybiBzdHJ1Y3QgY29uZmln
IGNmZzsKPiArCj4gKyNkZWZpbmUgQlVGX1NJWkUgNDA5Ngo+ICsKPiAraW50IGJ1aWxkX29wdGlv
bnMoY2hhciAqYXJnc3RyLCBpbnQgbWF4X2xlbiwgYm9vbCBkaXNjb3Zlcik7Cj4gK2ludCBkb19k
aXNjb3ZlcihjaGFyICphcmdzdHIsIGJvb2wgY29ubmVjdCk7Cj4gKwo+ICAgI2VuZGlmCj4gCgpQ
bGVhc2UgbmFtZSBpcyAnc3RydWN0IGNvbmZpZyBmYWJyaWNzX2NmZycuICdjZmcnIGlzIHVzZWQg
YXMgYSBnZW5lcmljIApuYW1lIHRocm91Z2hvdXQgdGhlIGNvZGUsIGFuZCB1c2luZyB0aGUgc2Ft
ZSBuYW1lIGluIGEgaGVhZGVyIG1pZ2h0IGxlYWQgCnRvIGFuIGFjY2lkZW50YWwgbmFtZSBjbGFz
aC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
