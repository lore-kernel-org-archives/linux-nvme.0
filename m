Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B58C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CD7206BE
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6okOmMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CD7206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OS+tcs3kydFJMTUtX/pthAz9ErjelE37NBPJfazHLNM=; b=g6okOmMraiNPFXXLbjHinhAvB
	WfuhXooIe+NAuM5F9HBZGqdsLAYKIX1raYHeElItqb2Eot2GD7G1si/H67osuLL/TQCpgrSGeMS3v
	QWrtWy9ZUL9JBdAWuvdAkJILpoWfMOh3nBrfyTeSRfBpXBnvYjwQ0KphF1AszL4mgzn0/sHss9Yky
	X44Szu9uTIRkpqBBLr6UUNmcAeDRQn6rzb7U5N/qy18RjLdzg7mf/7p4mzQgoVz10vmCiW/7fa1gj
	RFlyrG5AAUgqZW7OIZSFXMe9HoSXmp0bXuHVHHYJuGf8+GsPP4ZCfDxHC5jq6pqGX9rN2rew4fXsy
	RPNXVDSbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwJXb-0006w0-PQ; Fri, 17 Jul 2020 06:08:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwJXZ-0006vN-To
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 06:08:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 65926AC12;
 Fri, 17 Jul 2020 06:08:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix logic for
 non-optimized paths
To: mwilck@suse.com, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20200716195929.28399-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a401f816-e91c-b4e6-8caf-e9a40cba741a@suse.de>
Date: Fri, 17 Jul 2020 08:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716195929.28399-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200717_020814_088492_FF46DC84 
X-CRM114-Status: GOOD (  28.02  )
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
Cc: marting@netapp.com, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8xNi8yMCA5OjU5IFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gSGFuZGxlIHRoZSBzcGVjaWFsIGNhc2Ugd2hl
cmUgd2UgaGF2ZSBleGFjdGx5IG9uZSBvcHRpbWl6ZWQgcGF0aCwKPiB3aGljaCB3ZSBzaG91bGQg
a2VlcCB1c2luZyBpbiB0aGlzIGNhc2UuIEFsc28sIHVzZSB0aGUgbmV4dAo+IG5vbi1vcHRpbWl6
ZWQgcGF0aCwgbm90IHRoZSBsYXN0IG9uZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2ls
Y2sgPG13aWxja0BzdXNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0
aC5jIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBpbmRl
eCA3NGJhZDRlM2QzNzcuLjJjNTc1Yjc4M2QzZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4g
QEAgLTIyNCwxMyArMjI0LDggQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpudm1lX25leHRfbnMo
c3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCwKPiAgIHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqbnZt
ZV9yb3VuZF9yb2Jpbl9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsCj4gICAJCWludCBu
b2RlLCBzdHJ1Y3QgbnZtZV9ucyAqb2xkKQo+ICAgewo+IC0Jc3RydWN0IG52bWVfbnMgKm5zLCAq
Zm91bmQsICpmYWxsYmFjayA9IE5VTEw7Cj4gKwlzdHJ1Y3QgbnZtZV9ucyAqbnMsICpmb3VuZCA9
IE5VTEw7Cj4gICAKPiAtCWlmIChsaXN0X2lzX3Npbmd1bGFyKCZoZWFkLT5saXN0KSkgewo+IC0J
CWlmIChudm1lX3BhdGhfaXNfZGlzYWJsZWQob2xkKSkKPiAtCQkJcmV0dXJuIE5VTEw7Cj4gLQkJ
cmV0dXJuIG9sZDsKPiAtCX0KPiAgIAo+ICAgCWZvciAobnMgPSBudm1lX25leHRfbnMoaGVhZCwg
b2xkKTsKPiAgIAkgICAgIG5zICE9IG9sZDsKCldoeSBkbyB5b3UgcmVtb3ZlIHRoaXM/ClRoaXMg
aXMgYW4gb3B0aW1pc2F0aW9uIGZvciBzaW5nbGUgcGF0aHMsIGFuZCBzaG91bGQgc3RheS4KCj4g
QEAgLTI0MiwxMyArMjM3LDE5IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9yb3VuZF9y
b2Jpbl9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsCj4gICAJCQlmb3VuZCA9IG5zOwo+
ICAgCQkJZ290byBvdXQ7Cj4gICAJCX0KPiAtCQlpZiAobnMtPmFuYV9zdGF0ZSA9PSBOVk1FX0FO
QV9OT05PUFRJTUlaRUQpCj4gLQkJCWZhbGxiYWNrID0gbnM7Cj4gKwkJaWYgKCFmb3VuZCAmJiBu
cy0+YW5hX3N0YXRlID09IE5WTUVfQU5BX05PTk9QVElNSVpFRCkKPiArCQkJZm91bmQgPSBuczsK
PiAgIAl9Cj4gICAKPiAtCWlmICghZmFsbGJhY2spCj4gKwkvKiBGYWxsIGJhY2sgdG8gb2xkIGlm
IGl0J3MgYmV0dGVyIHRoYW4gdGhlIG90aGVycyAqLwo+ICsJaWYgKCFudm1lX3BhdGhfaXNfZGlz
YWJsZWQob2xkKSAmJgo+ICsJICAgIChvbGQtPmFuYV9zdGF0ZSA9PSBOVk1FX0FOQV9PUFRJTUla
RUQgfHwKPiArCSAgICAgKCFmb3VuZCAmJiBvbGQtPmFuYV9zdGF0ZSA9PSBOVk1FX0FOQV9OT05P
UFRJTUlaRUQpKSkKPiArCQlmb3VuZCA9IG9sZDsKPiArCj4gKwlpZiAoIWZvdW5kKQo+ICAgCQly
ZXR1cm4gTlVMTDsKPiAtCWZvdW5kID0gZmFsbGJhY2s7Cj4gKwo+ICAgb3V0Ogo+ICAgCXJjdV9h
c3NpZ25fcG9pbnRlcihoZWFkLT5jdXJyZW50X3BhdGhbbm9kZV0sIGZvdW5kKTsKPiAgIAlyZXR1
cm4gZm91bmQ7Cj4gClRoZSBwcm9ibGVtIGlzIHRoYXQgd2Ugc2hvdWxkIGhhdmUgdGVzdGVkIGFs
bCBwYXRocyBmcm9tIChvbGQgKyAxKQp1cCB0byBhbmQgaW5jbHVkaW5nIChvbGQpOyBjdXJyZW50
bHkgd2UncmUgb25seSB0ZXN0aW5nIHBhdGhzIGZyb20KKG9sZCArIDEpIHVwIHRvLCBidXQgZXhj
bHVkaW5nLCAob2xkKS4KCkkgd291bGQgcmF0aGVyIHVzZSB0aGlzIGV4cGxhbmF0aW9uIGluc3Rl
YWQgb2YgcmVmZXJyaW5nIHRvICdiZXR0ZXInIApwYXRoczsgYXQgdGhlIHZlcnkgbGVhc3QgcGxl
YXNlIG5hbWUgaXQgJ29wdGltYWwnLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNl
LmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
