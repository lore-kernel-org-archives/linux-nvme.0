Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA20C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 10:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BD1608FC
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 10:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BD1608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UXgqw3ssLoH93wTu3Vn1zONYU8waDQtOQLM29nIRVsM=; b=kFZhhEjNCUPszU
	KMxwVAyTGf3WeQhsWo/FjiyFs4UjZHvnPdH7AkqcTuzae6OO3AjOzKkgoJUJcW032zXwrqH53SaKE
	Jomz7E8yxh3bJP4X6INSgkiHK6R+lbxwaUoBAWw4Lpov26PqGbf1g5J2Yuchtk/NdBADy5+orv/WC
	8NYxqY5hkTtAiEw9HN73h94AeqU/N/vB+Amy2+t6Xb4R+pqcUJsER12cgh6vO7mgOJuihYX3ezRL8
	NDB2uByAdhtZxzt95RF7MKFqkgyrMK4WN0kTSzvoF3YvYLPibyGdsQPoyW0HF1/tPpM30/ps54XEs
	gc0fffUVCBeKE2KzljKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4KhI-0041DT-1z; Fri, 16 Jul 2021 10:03:56 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4KhE-0041BM-JP
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 10:03:54 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 68993B379D9;
 Fri, 16 Jul 2021 12:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626429825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAjMBxEFbTM9QnXfWtqziwaXlTYwnx8l4JQwX90X8Hw=;
 b=VQ6/tmdQ6sgW7HAYv1Owa2kDon3HEiJ1nm7z6EL/2e561VoTHJrk79XinzisfYBhJyfV1u
 h6F0kw2lNu57bU+fc2O2Ur3su2ZamVj7zKizdOVMkwgt72Nbk0AUwX2QlYJfjuzcPfLdsb
 DXped+S2mMkDz8G6Hkn7LM3EsxRXWuc=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Fri, 16 Jul 2021 12:03:43 +0200
Message-ID: <2455133.St5lIfLNcX@natalenko.name>
In-Reply-To: <YPFSUfG+fMITAH01@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <81322754.HEIg0oD171@natalenko.name> <YPFSUfG+fMITAH01@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_030352_851760_B8AA628E 
X-CRM114-Status: GOOD (  19.98  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8uCgpPbiBww6F0ZWsgMTYuIMSNZXJ2ZW5jZSAyMDIxIDExOjMzOjA1IENFU1QgTWluZyBM
ZWkgd3JvdGU6Cj4gQ2FuIHlvdSB0ZXN0IHRoZSBmb2xsb3dpbmcgcGF0Y2g/CgpTdXJlLCBidWls
ZGluZyBpdCBhdCB0aGUgbW9tZW50LCBhbmQgd2lsbCBnaXZlIGl0IGEgdHJ5LiBBbHNvIHBsZWFz
ZSBzZWUgbXkgCmNvbW1lbnRzIGFuZCBxdWVzdGlvbnMgYmVsb3cuCgo+IAo+IGRpZmYgLS1naXQg
YS9ibG9jay9iZnEtaW9zY2hlZC5jIGIvYmxvY2svYmZxLWlvc2NoZWQuYwo+IGluZGV4IDcyNzk1
NTkxODU2My4uNjczYTYzNGVhZGQ5IDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMK
PiArKysgYi9ibG9jay9iZnEtaW9zY2hlZC5jCj4gQEAgLTIzNjEsNiArMjM2MSw5IEBAIHN0YXRp
YyBpbnQgYmZxX3JlcXVlc3RfbWVyZ2Uoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCj4gc3RydWN0
IHJlcXVlc3QgKipyZXEsIF9fcnEgPSBiZnFfZmluZF9ycV9mbWVyZ2UoYmZxZCwgYmlvLCBxKTsK
PiAgCWlmIChfX3JxICYmIGVsdl9iaW9fbWVyZ2Vfb2soX19ycSwgYmlvKSkgewo+ICAJCSpyZXEg
PSBfX3JxOwo+ICsKPiArCQlpZiAoYmxrX2Rpc2NhcmRfbWVyZ2FibGUoX19ycSkpCj4gKwkJCXJl
dHVybiBFTEVWQVRPUl9ESVNDQVJEX01FUkdFOwo+ICAJCXJldHVybiBFTEVWQVRPUl9GUk9OVF9N
RVJHRTsKPiAgCX0KPiAKPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1lcmdlLmMgYi9ibG9jay9i
bGstbWVyZ2UuYwo+IGluZGV4IGExMWIzYjUzNzE3ZS4uZjg3MDdmZjdlMmZjIDEwMDY0NAo+IC0t
LSBhL2Jsb2NrL2Jsay1tZXJnZS5jCj4gKysrIGIvYmxvY2svYmxrLW1lcmdlLmMKPiBAQCAtNzA1
LDIyICs3MDUsNiBAQCBzdGF0aWMgdm9pZCBibGtfYWNjb3VudF9pb19tZXJnZV9yZXF1ZXN0KHN0
cnVjdCByZXF1ZXN0Cj4gKnJlcSkgfQo+ICB9Cj4gCj4gLS8qCj4gLSAqIFR3byBjYXNlcyBvZiBo
YW5kbGluZyBESVNDQVJEIG1lcmdlOgo+IC0gKiBJZiBtYXhfZGlzY2FyZF9zZWdtZW50cyA+IDEs
IHRoZSBkcml2ZXIgdGFrZXMgZXZlcnkgYmlvCj4gLSAqIGFzIGEgcmFuZ2UgYW5kIHNlbmQgdGhl
bSB0byBjb250cm9sbGVyIHRvZ2V0aGVyLiBUaGUgcmFuZ2VzCj4gLSAqIG5lZWRuJ3QgdG8gYmUg
Y29udGlndW91cy4KPiAtICogT3RoZXJ3aXNlLCB0aGUgYmlvcy9yZXF1ZXN0cyB3aWxsIGJlIGhh
bmRsZWQgYXMgc2FtZSBhcwo+IC0gKiBvdGhlcnMgd2hpY2ggc2hvdWxkIGJlIGNvbnRpZ3VvdXMu
Cj4gLSAqLwo+IC1zdGF0aWMgaW5saW5lIGJvb2wgYmxrX2Rpc2NhcmRfbWVyZ2FibGUoc3RydWN0
IHJlcXVlc3QgKnJlcSkKPiAtewo+IC0JaWYgKHJlcV9vcChyZXEpID09IFJFUV9PUF9ESVNDQVJE
ICYmCj4gLQkgICAgcXVldWVfbWF4X2Rpc2NhcmRfc2VnbWVudHMocmVxLT5xKSA+IDEpCj4gLQkJ
cmV0dXJuIHRydWU7Cj4gLQlyZXR1cm4gZmFsc2U7Cj4gLX0KPiAtCj4gIHN0YXRpYyBlbnVtIGVs
dl9tZXJnZSBibGtfdHJ5X3JlcV9tZXJnZShzdHJ1Y3QgcmVxdWVzdCAqcmVxLAo+ICAJCQkJCXN0
cnVjdCByZXF1ZXN0ICpuZXh0KQo+ICB7Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2VsZXZhdG9yLmMg
Yi9ibG9jay9lbGV2YXRvci5jCj4gaW5kZXggNTJhZGExNGNmZTQ1Li5hNWZlMjYxNWVjMGYgMTAw
NjQ0Cj4gLS0tIGEvYmxvY2svZWxldmF0b3IuYwo+ICsrKyBiL2Jsb2NrL2VsZXZhdG9yLmMKPiBA
QCAtMzM2LDYgKzMzNiw5IEBAIGVudW0gZWx2X21lcmdlIGVsdl9tZXJnZShzdHJ1Y3QgcmVxdWVz
dF9xdWV1ZSAqcSwgc3RydWN0Cj4gcmVxdWVzdCAqKnJlcSwgX19ycSA9IGVsdl9ycWhhc2hfZmlu
ZChxLCBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yKTsKPiAgCWlmIChfX3JxICYmIGVsdl9iaW9fbWVy
Z2Vfb2soX19ycSwgYmlvKSkgewo+ICAJCSpyZXEgPSBfX3JxOwo+ICsKPiArCQlpZiAoYmxrX2Rp
c2NhcmRfbWVyZ2FibGUoX19ycSkpCj4gKwkJCXJldHVybiBFTEVWQVRPUl9ESVNDQVJEX01FUkdF
Owo+ICAJCXJldHVybiBFTEVWQVRPUl9CQUNLX01FUkdFOwo+ICAJfQo+IAo+IGRpZmYgLS1naXQg
YS9ibG9jay9tcS1kZWFkbGluZS1tYWluLmMgYi9ibG9jay9tcS1kZWFkbGluZS1tYWluLmMKPiBp
bmRleCA2ZjYxMmU2ZGM4MmIuLjI5NGJlMGMwZGI2NSAxMDA2NDQKPiAtLS0gYS9ibG9jay9tcS1k
ZWFkbGluZS1tYWluLmMKPiArKysgYi9ibG9jay9tcS1kZWFkbGluZS1tYWluLmMKCkkgaGFkIHRv
IGFkanVzdCB0aGlzIGFnYWluc3QgdjUuMTMgYmVjYXVzZSB0aGVyZSdzIG5vIG1xLWRlYWRsaW5l
LW1haW4uYywgb25seSAKbXEtZGVhZGxpbmUuYyAoZHVlIHRvIEJhcnQgc2VyaWVzLCBJIGFzc3Vt
ZSkuIEkgaG9wZSB0aGlzIGlzIGZpbmUgYXMgdGhlIHBhdGNoIAphcHBsaWVzIGNsZWFubHkuCgo+
IEBAIC02NzcsNiArNjc3LDggQEAgc3RhdGljIGludCBkZF9yZXF1ZXN0X21lcmdlKHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxLAo+IHN0cnVjdCByZXF1ZXN0ICoqcnEsCj4gCj4gIAkJaWYgKGVsdl9i
aW9fbWVyZ2Vfb2soX19ycSwgYmlvKSkgewo+ICAJCQkqcnEgPSBfX3JxOwo+ICsJCQlpZiAoYmxr
X2Rpc2NhcmRfbWVyZ2FibGUoX19ycSkpCj4gKwkJCQlyZXR1cm4gRUxFVkFUT1JfRElTQ0FSRF9N
RVJHRTsKPiAgCQkJcmV0dXJuIEVMRVZBVE9SX0ZST05UX01FUkdFOwo+ICAJCX0KPiAgCX0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2
LmgKPiBpbmRleCAzMTc3MTgxYzQzMjYuLjg3ZjAwMjkyZmQ3YSAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2Jsa2Rldi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+IEBAIC0x
NTIxLDYgKzE1MjEsMjIgQEAgc3RhdGljIGlubGluZSBpbnQKPiBxdWV1ZV9saW1pdF9kaXNjYXJk
X2FsaWdubWVudChzdHJ1Y3QgcXVldWVfbGltaXRzICpsaW0sIHNlY3RvciByZXR1cm4KPiBvZmZz
ZXQgPDwgU0VDVE9SX1NISUZUOwo+ICB9Cj4gCj4gKy8qCj4gKyAqIFR3byBjYXNlcyBvZiBoYW5k
bGluZyBESVNDQVJEIG1lcmdlOgo+ICsgKiBJZiBtYXhfZGlzY2FyZF9zZWdtZW50cyA+IDEsIHRo
ZSBkcml2ZXIgdGFrZXMgZXZlcnkgYmlvCj4gKyAqIGFzIGEgcmFuZ2UgYW5kIHNlbmQgdGhlbSB0
byBjb250cm9sbGVyIHRvZ2V0aGVyLiBUaGUgcmFuZ2VzCj4gKyAqIG5lZWRuJ3QgdG8gYmUgY29u
dGlndW91cy4KPiArICogT3RoZXJ3aXNlLCB0aGUgYmlvcy9yZXF1ZXN0cyB3aWxsIGJlIGhhbmRs
ZWQgYXMgc2FtZSBhcwo+ICsgKiBvdGhlcnMgd2hpY2ggc2hvdWxkIGJlIGNvbnRpZ3VvdXMuCj4g
KyAqLwo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYmxrX2Rpc2NhcmRfbWVyZ2FibGUoc3RydWN0IHJl
cXVlc3QgKnJlcSkKPiArewo+ICsJaWYgKHJlcV9vcChyZXEpID09IFJFUV9PUF9ESVNDQVJEICYm
Cj4gKwkgICAgcXVldWVfbWF4X2Rpc2NhcmRfc2VnbWVudHMocmVxLT5xKSA+IDEpCj4gKwkJcmV0
dXJuIHRydWU7Cj4gKwlyZXR1cm4gZmFsc2U7Cj4gK30KPiArCj4gIHN0YXRpYyBpbmxpbmUgaW50
IGJkZXZfZGlzY2FyZF9hbGlnbm1lbnQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikKPiAgewo+
ICAJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBiZGV2X2dldF9xdWV1ZShiZGV2KTsKCkRvIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB0aGlzIHdpbGwgYmUgc29tZXRoaW5nIGxpa2U6CgpG
aXhlczogMjcwNWRmYjIwOSAoImJsb2NrOiBmaXggZGlzY2FyZCByZXF1ZXN0IG1lcmdlIikKCj8K
CkJlY2F1c2UgYXMgdGhlIGJpc2VjdGlvbiBwcm9ncmVzc2VzLCBJJ3ZlIGJ1bXBlZCBpbnRvIHRo
aXMgY29tbWl0IG9ubHkuIApXaXRob3V0IGl0IHRoZSBpc3N1ZSBpcyBub3QgcmVwcm9kdWNpYmxl
LCBhdCBsZWFzdCBzbyBmYXIuCgpUaGFua3MhCgotLSAKT2xla3NhbmRyIE5hdGFsZW5rbyAocG9z
dC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
