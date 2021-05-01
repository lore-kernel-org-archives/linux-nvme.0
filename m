Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D23C433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:25:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD8261409
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD8261409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ti/AVTLFPoMD+KYlRi6VDP3h6T41i10bUH1NM2Cfeek=; b=NEsfSYg/yvfPePn7Dc0X49wn7
	DcI55JSzyy05WHoczSD/8P/YVxsPMbbXnczciBafkzx6m9FjI67dLVcMEN8s+eBAN3OLxFFNRuCe3
	Ywh2iSDHwRJAd0xDs//Xtj1UHJeqjQd1QIkxH4VNcwLxoSh3GIlcWpzezzloLyTYpvCgsJ26UIj4c
	uTQcHtdHmT20G6xob46yxpWuis+2/KZVmRzOPLIBHRvfXVqN3UGpof+/MAK1kCqV8FA+Rgaa2JL3m
	i2HOyANKaJBoDJYoVNxAMDJ4nlCahNsPD1FN359L1b8AHT8R4juMNRcLgZg1J01wi/XGKonDq1QpJ
	aHniNjmXQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcogf-00A2Si-6n; Sat, 01 May 2021 12:25:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcogZ-00A2SI-7z
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 12:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=NkuZL1La5EOIOGuXXMUMK2Ie2ldPM5+6bC/XikJX0xY=; b=nUDA1BeSr/hD8DwJJFhw+OzVCV
 Zax3WeJbGjvkqYE9ZSukh7phHu4gBZJP4UXp5msgyb21Qu4Rh+QOHlkeUjOfd1ZtrW5ujfjJjg9WJ
 5ddnyNrOQ1x2gXEUCAsNQmISnU5lNjlHKmkeW+Thi262gmLTG76ThN2LMZK48YaGMJyJtcTO/orQ2
 cvM7z9ErNTt/D9ZGJelBRR8jqqHeJ6YXdGRCh15E2pjh/2DqznAavRkLu60g6nSb7Jaxu4MNDZdMm
 iq0Tl0Mp84Kmd6V8Ae+52EI9C2BU1kOCNHYjmI1M0QMXCE1c+Arlg9RzKn62YYPQs9vn+NmR534Xp
 rRKIVKLQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcogW-001z8K-5u
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 12:25:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C8910B172;
 Sat,  1 May 2021 12:25:22 +0000 (UTC)
Subject: Re: [RFC PATCH v4 10/27] nvme-tcp-offload: Add device scan
 implementation
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-11-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <02a740cd-e765-1197-9c5d-78ce602ba7a1@suse.de>
Date: Sat, 1 May 2021 14:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-11-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_052524_538223_8556079D 
X-CRM114-Status: GOOD (  29.92  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IERlYW4gQmFsYW5k
aW4gPGRiYWxhbmRpbkBtYXJ2ZWxsLmNvbT4KPiAKPiBBcyBwYXJ0IG9mIGNyZWF0ZV9jdHJsKCks
IGl0IHNjYW5zIHRoZSByZWdpc3RlcmVkIGRldmljZXMgYW5kIGNhbGxzCj4gdGhlIGNsYWltX2Rl
diBvcCBvbiBlYWNoIG9mIHRoZW0sIHRvIGZpbmQgdGhlIGZpcnN0IGRldmljZXMgdGhhdCBtYXRj
aGVzCj4gdGhlIGNvbm5lY3Rpb24gcGFyYW1zLiBPbmNlIHRoZSBjb3JyZWN0IGRldmljZXMgaXMg
Zm91bmQgKGNsYWltX2Rldgo+IHJldHVybnMgdHJ1ZSksIHdlIHJhaXNlIHRoZSByZWZjbnQgb2Yg
dGhhdCBkZXZpY2UgYW5kIHJldHVybiB0aGF0IGRldmljZQo+IGFzIHRoZSBkZXZpY2UgdG8gYmUg
dXNlZCBmb3IgY3RybCBjdXJyZW50bHkgYmVpbmcgY3JlYXRlZC4KPiAKPiBBY2tlZC1ieTogSWdv
ciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERlYW4g
QmFsYW5kaW4gPGRiYWxhbmRpbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFr
YXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWth
ciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
bCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVs
IEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8
c21hbGluQG1hcnZlbGwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvdGNwLW9mZmxv
YWQuYyB8IDk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNo
YW5nZWQsIDk0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvdGNwLW9mZmxvYWQuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZsb2FkLmMKPiBpbmRl
eCA3MTEyMzJlYmEzMzkuLmFhN2NjMjM5YWJmMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC90Y3Atb2ZmbG9hZC5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLW9mZmxvYWQu
Ywo+IEBAIC0xMyw2ICsxMywxMSBAQAo+ICAgc3RhdGljIExJU1RfSEVBRChudm1lX3RjcF9vZmxk
X2RldmljZXMpOwo+ICAgc3RhdGljIERFQ0xBUkVfUldTRU0obnZtZV90Y3Bfb2ZsZF9kZXZpY2Vz
X3J3c2VtKTsKPiAgIAo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBudm1lX3RjcF9vZmxkX2N0cmwg
KnRvX3RjcF9vZmxkX2N0cmwoc3RydWN0IG52bWVfY3RybCAqbmN0cmwpCj4gK3sKPiArCXJldHVy
biBjb250YWluZXJfb2YobmN0cmwsIHN0cnVjdCBudm1lX3RjcF9vZmxkX2N0cmwsIG5jdHJsKTsK
PiArfQo+ICsKPiAgIC8qKgo+ICAgICogbnZtZV90Y3Bfb2ZsZF9yZWdpc3Rlcl9kZXYoKSAtIE5W
TWVUQ1AgT2ZmbG9hZCBMaWJyYXJ5IHJlZ2lzdHJhdGlvbgo+ICAgICogZnVuY3Rpb24uCj4gQEAg
LTk4LDYgKzEwMyw5NCBAQCB2b2lkIG52bWVfdGNwX29mbGRfcmVxX2RvbmUoc3RydWN0IG52bWVf
dGNwX29mbGRfcmVxICpyZXEsCj4gICAJLyogUGxhY2Vob2xkZXIgLSBjb21wbGV0ZSByZXF1ZXN0
IHdpdGgvd2l0aG91dCBlcnJvciAqLwo+ICAgfQo+ICAgCj4gK3N0cnVjdCBudm1lX3RjcF9vZmxk
X2RldiAqCj4gK252bWVfdGNwX29mbGRfbG9va3VwX2RldihzdHJ1Y3QgbnZtZV90Y3Bfb2ZsZF9j
dHJsICpjdHJsKQo+ICt7Cj4gKwlzdHJ1Y3QgbnZtZV90Y3Bfb2ZsZF9kZXYgKmRldjsKPiArCj4g
Kwlkb3duX3JlYWQoJm52bWVfdGNwX29mbGRfZGV2aWNlc19yd3NlbSk7Cj4gKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGRldiwgJm52bWVfdGNwX29mbGRfZGV2aWNlcywgZW50cnkpIHsKPiArCQlpZiAo
ZGV2LT5vcHMtPmNsYWltX2RldihkZXYsICZjdHJsLT5jb25uX3BhcmFtcykpIHsKPiArCQkJLyog
SW5jcmVhc2UgZHJpdmVyIHJlZmNudCAqLwo+ICsJCQlpZiAoIXRyeV9tb2R1bGVfZ2V0KGRldi0+
b3BzLT5tb2R1bGUpKSB7Cj4gKwkJCQlwcl9lcnIoInRyeV9tb2R1bGVfZ2V0IGZhaWxlZFxuIik7
Cj4gKwkJCQlkZXYgPSBOVUxMOwo+ICsJCQl9Cj4gKwo+ICsJCQlnb3RvIG91dDsKPiArCQl9Cj4g
Kwl9Cj4gKwo+ICsJZGV2ID0gTlVMTDsKPiArb3V0Ogo+ICsJdXBfcmVhZCgmbnZtZV90Y3Bfb2Zs
ZF9kZXZpY2VzX3J3c2VtKTsKPiArCj4gKwlyZXR1cm4gZGV2Owo+ICt9Cj4gKwo+ICtzdGF0aWMg
aW50IG52bWVfdGNwX29mbGRfc2V0dXBfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpuY3RybCwgYm9v
bCBuZXcpCj4gK3sKPiArCS8qIFBsYWNlaG9sZGVyIC0gdmFsaWRhdGVzIGlucHV0cyBhbmQgY3Jl
YXRlcyBhZG1pbiBhbmQgSU8gcXVldWVzICovCj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4g
K3N0YXRpYyBzdHJ1Y3QgbnZtZV9jdHJsICoKPiArbnZtZV90Y3Bfb2ZsZF9jcmVhdGVfY3RybChz
dHJ1Y3QgZGV2aWNlICpuZGV2LCBzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMpCj4gK3sK
PiArCXN0cnVjdCBudm1lX3RjcF9vZmxkX2N0cmwgKmN0cmw7Cj4gKwlzdHJ1Y3QgbnZtZV90Y3Bf
b2ZsZF9kZXYgKmRldjsKPiArCXN0cnVjdCBudm1lX2N0cmwgKm5jdHJsOwo+ICsJaW50IHJjID0g
MDsKPiArCj4gKwljdHJsID0ga3phbGxvYyhzaXplb2YoKmN0cmwpLCBHRlBfS0VSTkVMKTsKPiAr
CWlmICghY3RybCkKPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiArCj4gKwluY3RybCA9
ICZjdHJsLT5uY3RybDsKPiArCj4gKwkvKiBJbml0IG52bWVfdGNwX29mbGRfY3RybCBhbmQgbnZt
ZV9jdHJsIHBhcmFtcyBiYXNlZCBvbiByZWNlaXZlZCBvcHRzICovCj4gKwo+ICsJLyogRmluZCBk
ZXZpY2UgdGhhdCBjYW4gcmVhY2ggdGhlIGRlc3QgYWRkciAqLwo+ICsJZGV2ID0gbnZtZV90Y3Bf
b2ZsZF9sb29rdXBfZGV2KGN0cmwpOwo+ICsJaWYgKCFkZXYpIHsKPiArCQlwcl9pbmZvKCJubyBk
ZXZpY2UgZm91bmQgZm9yIGFkZHIgJXM6JXMuXG4iLAo+ICsJCQlvcHRzLT50cmFkZHIsIG9wdHMt
PnRyc3ZjaWQpOwo+ICsJCXJjID0gLUVJTlZBTDsKPiArCQlnb3RvIG91dF9mcmVlX2N0cmw7Cj4g
Kwl9Cj4gKwo+ICsJY3RybC0+ZGV2ID0gZGV2Owo+ICsKPiArCWlmIChjdHJsLT5kZXYtPm9wcy0+
bWF4X2h3X3NlY3RvcnMpCj4gKwkJbmN0cmwtPm1heF9od19zZWN0b3JzID0gY3RybC0+ZGV2LT5v
cHMtPm1heF9od19zZWN0b3JzOwo+ICsJaWYgKGN0cmwtPmRldi0+b3BzLT5tYXhfc2VnbWVudHMp
Cj4gKwkJbmN0cmwtPm1heF9zZWdtZW50cyA9IGN0cmwtPmRldi0+b3BzLT5tYXhfc2VnbWVudHM7
Cj4gKwo+ICsJLyogSW5pdCBxdWV1ZXMgKi8KPiArCj4gKwkvKiBDYWxsIG52bWVfaW5pdF9jdHJs
ICovCj4gKwo+ICsJcmMgPSBjdHJsLT5kZXYtPm9wcy0+c2V0dXBfY3RybChjdHJsLCB0cnVlKTsK
PiArCWlmIChyYykKPiArCQlnb3RvIG91dF9tb2R1bGVfcHV0Owo+ICsKPiArCXJjID0gbnZtZV90
Y3Bfb2ZsZF9zZXR1cF9jdHJsKG5jdHJsLCB0cnVlKTsKPiArCWlmIChyYykKPiArCQlnb3RvIG91
dF91bmluaXRfY3RybDsKPiArCj4gKwlyZXR1cm4gbmN0cmw7Cj4gKwo+ICtvdXRfdW5pbml0X2N0
cmw6Cj4gKwljdHJsLT5kZXYtPm9wcy0+cmVsZWFzZV9jdHJsKGN0cmwpOwo+ICtvdXRfbW9kdWxl
X3B1dDoKPiArCW1vZHVsZV9wdXQoZGV2LT5vcHMtPm1vZHVsZSk7Cj4gK291dF9mcmVlX2N0cmw6
Cj4gKwlrZnJlZShjdHJsKTsKPiArCj4gKwlyZXR1cm4gRVJSX1BUUihyYyk7Cj4gK30KPiArCj4g
ICBzdGF0aWMgc3RydWN0IG52bWZfdHJhbnNwb3J0X29wcyBudm1lX3RjcF9vZmxkX3RyYW5zcG9y
dCA9IHsKPiAgIAkubmFtZQkJPSAidGNwX29mZmxvYWQiLAo+ICAgCS5tb2R1bGUJCT0gVEhJU19N
T0RVTEUsCj4gQEAgLTEwNyw2ICsyMDAsNyBAQCBzdGF0aWMgc3RydWN0IG52bWZfdHJhbnNwb3J0
X29wcyBudm1lX3RjcF9vZmxkX3RyYW5zcG9ydCA9IHsKPiAgIAkJCSAgTlZNRl9PUFRfUkVDT05O
RUNUX0RFTEFZIHwgTlZNRl9PUFRfSERSX0RJR0VTVCB8Cj4gICAJCQkgIE5WTUZfT1BUX0RBVEFf
RElHRVNUIHwgTlZNRl9PUFRfTlJfUE9MTF9RVUVVRVMgfAo+ICAgCQkJICBOVk1GX09QVF9UT1Ms
Cj4gKwkuY3JlYXRlX2N0cmwJPSBudm1lX3RjcF9vZmxkX2NyZWF0ZV9jdHJsLAo+ICAgfTsKPiAg
IAo+ICAgc3RhdGljIGludCBfX2luaXQgbnZtZV90Y3Bfb2ZsZF9pbml0X21vZHVsZSh2b2lkKQo+
IApJIHdvbmRlciBpZiB3ZSBzaG91bGRuJ3QgdGFrZSB0aGUgYXBwcm9hY2ggZnJvbSBNYXJ0aW4g
QmVsYW5nZXIsIGFuZCAKaW50cm9kdWNlIGEgbmV3IG9wdGlvbiAnaG9zdF9pZmFjZScgdG8gc2Vs
ZWN0IHRoZSBpbnRlcmZhY2UgdG8gdXNlLgpUaGF0IGlzLCBfaWZfIHRoZSBudm1lLXRjcCBvZmZs
b2FkIGRyaXZlciB3b3VsZCBwcmVzZW50IGl0c2VsZiBhcyBhIApuZXR3b3JrIGludGVyZmFjZTsg
b25lIG1pZ2h0IGFyZ3VlIHRoYXQgaXQgd291bGQgcHV0IHRvbyBtdWNoIApyZXN0cmljdGlvbiBv
biB0aGUgaW1wbGVtZW50YXRpb25zLgpCdXQgaWYgaXQgZG9lcyBub3QgcHJlc2VudCBpdHNlbGYg
YXMgYSBuZXR3b3JrIGludGVyZmFjZSwgaG93IGRvIHdlIAphZGRyZXNzIGl0PyBBbmQgaWYgaXQg
ZG9lcywgd291bGRuJ3Qgd2UgYmUgYmV0dGVyIG9mZiB0byBzcGVjaWZ5IHRoZSAKaW50ZXJmYWNl
IGRpcmVjdGx5LCBhbmQgbm90IHRyeSB0byBpbXBseSB0aGUgaW50ZXJmYWNlIGZyb20gdGhlIElQ
IGFkZHJlc3M/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
