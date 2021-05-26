Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D019C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:15:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C0261408
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C0261408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iw6r/ICx7UE9ED5RZL01buGGFY+IOoV28+UdyouDMLQ=; b=h5uDMkmLwsma3sGYfszSSxCkZB
	Wfz/VWi6fxQXTajx7skaLr2VTd3RRv/RaRkIwYP+IwTHvDVFNmNmC8yAnPpBZLiIhDkfBJqAfB5ZE
	kt++EyEjL6c1Rqxswd8Fs8RYg9XDxg92pJE0ZBiINDRdXTfT50umWuk9h99YaDE0Gxdg3C3TDh2qg
	yMYRPl10Vlj2yir3MXnDfRmYZTHO0R5/qEM0s336y0dLXcPEyOkOkOWmTcY2GhJrCoD0YJsMCk2rJ
	xRTHCj3tmgV6tdShq9PC66m2QB9iyU9L1LrwIlqv+VBtwB2sfjgmQLXmpqzocYcNsw10Hv0rlCJjZ
	SgDmeXgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpdJ-00Cmud-Oo; Wed, 26 May 2021 09:15:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpOD-00CgXd-4w
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:59:46 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by smtp-out2.suse.de (Postfix) with ESMTP id C65221FD2A;
 Wed, 26 May 2021 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622019583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LV/qf6X+b2uyuBP98xumkS/OghdpFdImMExbqqNiOw=;
 b=j7/TWkTV99riQdTPaG56G3z/sjxBmph5Onw/yCkRP52UHTn+iY076Cn9VJA048MNyKRcBu
 G7rdUJJ/yBCpPxR2S9RV6EvsGhANd+Ua1cl8TRKKx10L2nNbhoDQ+r+wqY8MbIeaY815WK
 FwrWg1xipPILttYnBQ92nVJCB+7XCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622019583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LV/qf6X+b2uyuBP98xumkS/OghdpFdImMExbqqNiOw=;
 b=KVytemzxy9UJ7kojxYdIJeiLnxOXa1AvF6FwBsr9F6Llq670Vn0/xhYnTmLLoNMyNMiXQK
 KjvRGGIjCs7i6rAQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id AD46B11A98;
 Wed, 26 May 2021 08:59:43 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <3a0dc0b2-bca0-98a9-68ea-62377555294c@suse.de>
Date: Wed, 26 May 2021 10:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519174340.1144806-5-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_015945_389415_C8117256 
X-CRM114-Status: GOOD (  26.93  )
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

T24gNS8xOS8yMSA3OjQzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IFdlIGNhbm5vdCBkZXRl
Y3QgYSAocGVyaGFwcyBidWdneSkgY29udHJvbGxlciB0aGF0IGlzIHNlbmRpbmcgdXMKPiBhIGNv
bXBsZXRpb24gZm9yIGEgcmVxdWVzdCB0aGF0IHdhcyBhbHJlYWR5IGNvbXBsZXRlZCAoZm9yIGV4
YW1wbGUKPiBzZW5kaW5nIGEgY29tcGxldGlvbiB0d2ljZSksIHRoaXMgcGhlbm9tZW5vbiB3YXMg
c2VlbiBpbiB0aGUgd2lsZAo+IGEgZmV3IHRpbWVzLgo+IAo+IFNvIHRvIHByb3RlY3QgYWdhaW5z
dCB0aGlzLCB3ZSB1c2UgdGhlIHVwcGVyIDQgbXNiaXRzIG9mIHRoZSBudm1lIHNxZQo+IGNvbW1h
bmRfaWQgdG8gdXNlIGFzIGEgNC1iaXQgZ2VuZXJhdGlvbiBjb3VudGVyIGFuZCB2ZXJpZnkgaXQg
bWF0Y2hlcwo+IHRoZSBleGlzdGluZyByZXF1ZXN0IGdlbmVyYXRpb24gdGhhdCBpcyBpbmNyZW1l
bnRpbmcgb24gZXZlcnkgZXhlY3V0aW9uLgo+IAo+IFRoZSAxNi1iaXQgY29tbWFuZF9pZCBzdHJ1
Y3R1cmUgbm93IGlzIGNvbnN0cnVjdGVkIGJ5Ogo+IHwgeHh4eCB8IHh4eHh4eHh4eHh4eCB8Cj4g
ICBnZW4gICAgcmVxdWVzdCB0YWcKPiAKPiBUaGlzIG1lYW5zIHRoYXQgd2UgYXJlIGdpdmluZyB1
cCBzb21lIHBvc3NpYmxlIHF1ZXVlIGRlcHRoIGFzIDEyIGJpdHMKPiBhbGxvdyBmb3IgYSBtYXhp
bXVtIHF1ZXVlIGRlcHRoIG9mIDQwOTUgaW5zdGVhZCBvZiA2NTUzNiwgaG93ZXZlciB3ZQo+IG5l
dmVyIGNyZWF0ZSBzdWNoIGxvbmcgcXVldWVzIGFueXdheXMgc28gbm8gcmVhbCBoYXJtIGRvbmUu
Cj4gCj4gU3VnZ2VzdGVkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+Cj4gU2ln
bmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPiAtLS0KPiAgZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jICAgfCAgMyArKy0KPiAgZHJpdmVycy9udm1lL2hvc3QvbnZt
ZS5oICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICBkcml2
ZXJzL252bWUvaG9zdC9wY2kuYyAgICB8ICAyICstCj4gIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEu
YyAgIHwgIDQgKystLQo+ICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyAgICB8IDI2ICsrKysrKysr
KystLS0tLS0tLS0tLQo+ICBkcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYyB8ICA0ICsrLS0KPiAg
NiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCj4gaW5kZXggZTY2MTI5NzFmNGViLi44MzA4ZGQxZTllM2YgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
Cj4gQEAgLTEwMDYsNyArMTAwNiw4IEBAIGJsa19zdGF0dXNfdCBudm1lX3NldHVwX2NtZChzdHJ1
Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4gIAkJcmV0dXJuIEJMS19TVFNf
SU9FUlI7Cj4gIAl9Cj4gIAo+IC0JY21kLT5jb21tb24uY29tbWFuZF9pZCA9IHJlcS0+dGFnOwo+
ICsJbnZtZV9yZXEocmVxKS0+Z2VuY3RyKys7Cj4gKwljbWQtPmNvbW1vbi5jb21tYW5kX2lkID0g
bnZtZV9jaWQocmVxKTsKPiAgCXRyYWNlX252bWVfc2V0dXBfY21kKHJlcSwgY21kKTsKPiAgCXJl
dHVybiByZXQ7Cj4gIH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIv
ZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCj4gaW5kZXggMDVmMzFhMmM2NGJiLi5lNmY3MmM4MjU4
MmQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvbnZtZS5oCj4gQEAgLTE1OCw2ICsxNTgsNyBAQCBlbnVtIG52bWVfcXVpcmtz
IHsKPiAgc3RydWN0IG52bWVfcmVxdWVzdCB7Cj4gIAlzdHJ1Y3QgbnZtZV9jb21tYW5kCSpjbWQ7
Cj4gIAl1bmlvbiBudm1lX3Jlc3VsdAlyZXN1bHQ7Cj4gKwl1OAkJCWdlbmN0cjsKPiAgCXU4CQkJ
cmV0cmllczsKPiAgCXU4CQkJZmxhZ3M7Cj4gIAl1MTYJCQlzdGF0dXM7Cj4gQEAgLTQ5Nyw2ICs0
OTgsNDkgQEAgc3RydWN0IG52bWVfY3RybF9vcHMgewo+ICAJaW50ICgqZ2V0X2FkZHJlc3MpKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwsIGNoYXIgKmJ1ZiwgaW50IHNpemUpOwo+ICB9Owo+ICAKPiAr
LyoKPiArICogbnZtZSBjb21tYW5kX2lkIGlzIGNvbnN0cnVjdGVkIGFzIHN1Y2g6Cj4gKyAqIHwg
eHh4eCB8IHh4eHh4eHh4eHh4eCB8Cj4gKyAqICAgZ2VuICAgIHJlcXVlc3QgdGFnCj4gKyAqLwo+
ICsjZGVmaW5lIG52bWVfZ2VuY3RyX21hc2soZ2VuKQkJCShnZW4gJiAweGYpCj4gKyNkZWZpbmUg
bnZtZV9jaWRfaW5zdGFsbF9nZW5jdHIoZ2VuKQkJKG52bWVfZ2VuY3RyX21hc2soZ2VuKSA8PCAx
MikKPiArI2RlZmluZSBudm1lX2dlbmN0cl9mcm9tX2NpZChjaWQpCQkoKGNpZCAmIDB4ZjAwMCkg
Pj4gMTIpCj4gKyNkZWZpbmUgbnZtZV90YWdfZnJvbV9jaWQoY2lkKQkJCShjaWQgJiAweGZmZikK
PiArCj4gK3N0YXRpYyBpbmxpbmUgdTE2IG52bWVfY2lkKHN0cnVjdCByZXF1ZXN0ICpycSkKPiAr
ewo+ICsJcmV0dXJuIG52bWVfY2lkX2luc3RhbGxfZ2VuY3RyKG52bWVfcmVxKHJxKS0+Z2VuY3Ry
KSB8IHJxLT50YWc7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHJlcXVlc3QgKm52
bWVfZmluZF9ycShzdHJ1Y3QgYmxrX21xX3RhZ3MgKnRhZ3MsCj4gKwkJdTE2IGNvbW1hbmRfaWQp
Cj4gK3sKPiArCXU4IGdlbmN0ciA9IG52bWVfZ2VuY3RyX2Zyb21fY2lkKGNvbW1hbmRfaWQpOwo+
ICsJdTE2IHRhZyA9IG52bWVfdGFnX2Zyb21fY2lkKGNvbW1hbmRfaWQpOwo+ICsJc3RydWN0IHJl
cXVlc3QgKnJxOwo+ICsKPiArCXJxID0gYmxrX21xX3RhZ190b19ycSh0YWdzLCB0YWcpOwo+ICsJ
aWYgKHVubGlrZWx5KCFycSkpIHsKPiArCQlwcl9lcnIoImNvdWxkIG5vdCBsb2NhdGUgcmVxdWVz
dCBmb3IgdGFnICUjeFxuIiwKPiArCQkJdGFnKTsKPiArCQlyZXR1cm4gTlVMTDsKPiArCX0KPiAr
CWlmICh1bmxpa2VseShudm1lX2dlbmN0cl9tYXNrKG52bWVfcmVxKHJxKS0+Z2VuY3RyKSAhPSBn
ZW5jdHIpKSB7Cj4gKwkJZGV2X2Vycihudm1lX3JlcShycSktPmN0cmwtPmRldmljZSwKPiArCQkJ
InJlcXVlc3QgJSN4IGdlbmN0ciBtaXNtYXRjaCAoZ290ICUjeCBleHBlY3RlZCAlI3gpXG4iLAo+
ICsJCQl0YWcsIGdlbmN0ciwgbnZtZV9yZXEocnEpLT5nZW5jdHIpOwo+ICsJCXJldHVybiBOVUxM
Owo+ICsJfQo+ICsJcmV0dXJuIHJxOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBy
ZXF1ZXN0ICpudm1lX2NpZF90b19ycShzdHJ1Y3QgYmxrX21xX3RhZ3MgKnRhZ3MsCj4gKyAgICAg
ICAgICAgICAgICB1MTYgY29tbWFuZF9pZCkKPiArewo+ICsJcmV0dXJuIGJsa19tcV90YWdfdG9f
cnEodGFncywgbnZtZV90YWdfZnJvbV9jaWQoY29tbWFuZF9pZCkpOwo+ICt9Cj4gKwo+ICAjaWZk
ZWYgQ09ORklHX0ZBVUxUX0lOSkVDVElPTl9ERUJVR19GUwo+ICB2b2lkIG52bWVfZmF1bHRfaW5q
ZWN0X2luaXQoc3RydWN0IG52bWVfZmF1bHRfaW5qZWN0ICpmYXVsdF9pbmosCj4gIAkJCSAgICBj
b25zdCBjaGFyICpkZXZfbmFtZSk7CgpXaGF0IGFib3V0IHJhaXNpbmcgTlZNRl9NQVhfUVVFVUVf
U0laRSB0byA0MDk2PwoKT3RoZXIgdGhhbiB0aGF0OgoKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJt
YW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
