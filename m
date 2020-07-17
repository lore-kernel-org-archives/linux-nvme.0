Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13ADC433E4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9275206BE
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jfj5Qdzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9275206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q3fUelsETlWv3h454pBmTzcxPc6zQMuN4DlSb/5/dkc=; b=jfj5QdzxFgrvMUAkUvXxph7SW
	kJ4Ty4QRAzbQ09a7jhnVxYrIohVz3+jAPCY3yASdhnW2u7HYQRx9UEbkhbkk2SqGqVgIsmadN6qrN
	UHxNjYkJjCKToMz1EKA+/J82Nxo3DvZywqLSVruvtTk4MHTksyGeRU8JMDsnKunh6V3A7fcLMtI1t
	W+ZE3LtsreTazHEeAF0aMks9vvKBGryJCp70LAc0YN6IufnknwFTMRjBLRVwfz5snlbaaZMH100S2
	rzub2Fm6A0a3qDA3tyZRSjJhRFXgiuvo52TbRtd0pJ2rhluD/a3F2hJvkryi/nQyGnmj9/3GdpZ+W
	HHhGNXw7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwJZy-00074i-BE; Fri, 17 Jul 2020 06:10:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwJZv-00074K-Uf
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 06:10:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 50202AC12;
 Fri, 17 Jul 2020 06:10:43 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: multipath: round-robin: don't fall back to numa
To: mwilck@suse.com, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20200716195929.28399-1-mwilck@suse.com>
 <20200716195929.28399-2-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e093b456-b854-c10a-2bdf-ecc8cac54e5b@suse.de>
Date: Fri, 17 Jul 2020 08:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716195929.28399-2-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200717_021040_192776_722757BE 
X-CRM114-Status: GOOD (  27.84  )
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
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gQ3VycmVudGx5LCBpZiB0aGUgUlIgcGF0aCBz
ZWxlY3RvciByZXR1cm5zIGEgbm9uLW9wdGltaXplZCBwYXRoLAo+IHdlIGZhbGwgYmFjayB0byBf
X252bWVfZmluZF9wYXRoKCksIHdoaWNoIHVzZXMgdGhlIGxvZ2ljIG9mIHRoZQo+IG51bWEgcGF0
aCBzZWxlY3Rvci4gRm9yIGEgZ2l2ZW4gbnVtYSBub2RlLCB0aGlzIGFsd2F5cyBjaG9vc2VzCj4g
dGhlIHNhbWUgcGF0aCwgdGh1cyBwcmV2ZW50aW5nIHJvdW5kLXJvYmluIGxvZ2ljIG9uIG5vbi1v
cHRpbWl6ZWQKPiBwYXRocy4KPiAKPiBCeSBoYW5kbGluZyB0aGUgc2l0dWF0aW9uIHdoZXJlIHRo
ZSBjdXJyZW50IG5zIGlzIE5VTEwgaW4KPiBudm1lX3JvdW5kX3JvYmluX3BhdGgoKSwgd2UgY2Fu
IGF2b2lkIGZhbGxpbmcgYmFjayBmcm9tIHJvdW5kLXJvYmluCj4gdG8gTlVNQSwgZml4aW5nIHRo
ZSBpc3N1ZS4gVGhlIGlvcG9saWN5IGNhc2UgZGlzdGluY3Rpb24gaW4KPiBfX252bWVfZmluZF9w
YXRoKCkgY2FuIGJlIHNraXBwZWQgbm93Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBXaWxj
ayA8bXdpbGNrQHN1c2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMgfCAyMyArKysrKysrKysrKysrKystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBpbmRl
eCAyYzU3NWI3ODNkM2UuLmZmOTNiYWIwZDU0OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4g
QEAgLTE4MSwxMCArMTgxLDcgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpfX252bWVfZmluZF9w
YXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsIGludCBub2RlKQo+ICAgCQlpZiAobnZtZV9w
YXRoX2lzX2Rpc2FibGVkKG5zKSkKPiAgIAkJCWNvbnRpbnVlOwo+ICAgCj4gLQkJaWYgKFJFQURf
T05DRShoZWFkLT5zdWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9MSUNZX05VTUEpCj4gLQkJ
CWRpc3RhbmNlID0gbm9kZV9kaXN0YW5jZShub2RlLCBucy0+Y3RybC0+bnVtYV9ub2RlKTsKPiAt
CQllbHNlCj4gLQkJCWRpc3RhbmNlID0gTE9DQUxfRElTVEFOQ0U7Cj4gKwkJZGlzdGFuY2UgPSBu
b2RlX2Rpc3RhbmNlKG5vZGUsIG5zLT5jdHJsLT5udW1hX25vZGUpOwo+ICAgCj4gICAJCXN3aXRj
aCAobnMtPmFuYV9zdGF0ZSkgewo+ICAgCQljYXNlIE5WTUVfQU5BX09QVElNSVpFRDoKPiBAQCAt
MjI1LDcgKzIyMiwxMyBAQCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVfcm91bmRfcm9iaW5f
cGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkLAo+ICAgCQlpbnQgbm9kZSwgc3RydWN0IG52
bWVfbnMgKm9sZCkKPiAgIHsKPiAgIAlzdHJ1Y3QgbnZtZV9ucyAqbnMsICpmb3VuZCA9IE5VTEw7
Cj4gKwlib29sIHdhc19udWxsID0gKG9sZCA9PSBOVUxMKTsKPiAgIAo+ICsJaWYgKHVubGlrZWx5
KHdhc19udWxsKSkKPiArCQlvbGQgPSBsaXN0X2ZpcnN0X29yX251bGxfcmN1KCZoZWFkLT5saXN0
LAo+ICsJCQkJCSAgICAgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsKPiArCWlmICh1bmxpa2Vs
eSghb2xkKSkKPiArCQlyZXR1cm4gTlVMTDsKPiAgIAo+ICAgCWZvciAobnMgPSBudm1lX25leHRf
bnMoaGVhZCwgb2xkKTsKPiAgIAkgICAgIG5zICE9IG9sZDsKPiBAQCAtMjQ0LDkgKzI0NywxMiBA
QCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVfcm91bmRfcm9iaW5fcGF0aChzdHJ1Y3QgbnZt
ZV9uc19oZWFkICpoZWFkLAo+ICAgCS8qIEZhbGwgYmFjayB0byBvbGQgaWYgaXQncyBiZXR0ZXIg
dGhhbiB0aGUgb3RoZXJzICovCj4gICAJaWYgKCFudm1lX3BhdGhfaXNfZGlzYWJsZWQob2xkKSAm
Jgo+ICAgCSAgICAob2xkLT5hbmFfc3RhdGUgPT0gTlZNRV9BTkFfT1BUSU1JWkVEIHx8Cj4gLQkg
ICAgICghZm91bmQgJiYgb2xkLT5hbmFfc3RhdGUgPT0gTlZNRV9BTkFfTk9OT1BUSU1JWkVEKSkp
Cj4gKwkgICAgICghZm91bmQgJiYgb2xkLT5hbmFfc3RhdGUgPT0gTlZNRV9BTkFfTk9OT1BUSU1J
WkVEKSkpIHsKPiAgIAkJZm91bmQgPSBvbGQ7Cj4gLQo+ICsJCWlmICghd2FzX251bGwpCj4gKwkJ
CS8qIE5vIG5lZWQgdG8gc3dpdGNoICovCj4gKwkJCXJldHVybiBmb3VuZDsKPiArCX0KPiAgIAlp
ZiAoIWZvdW5kKQo+ICAgCQlyZXR1cm4gTlVMTDsKPiAgIAo+IEBAIC0yNjcsOCArMjczLDkgQEAg
aW5saW5lIHN0cnVjdCBudm1lX25zICpudm1lX2ZpbmRfcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFk
ICpoZWFkKQo+ICAgCXN0cnVjdCBudm1lX25zICpuczsKPiAgIAo+ICAgCW5zID0gc3JjdV9kZXJl
ZmVyZW5jZShoZWFkLT5jdXJyZW50X3BhdGhbbm9kZV0sICZoZWFkLT5zcmN1KTsKPiAtCWlmIChS
RUFEX09OQ0UoaGVhZC0+c3Vic3lzLT5pb3BvbGljeSkgPT0gTlZNRV9JT1BPTElDWV9SUiAmJiBu
cykKPiAtCQlucyA9IG52bWVfcm91bmRfcm9iaW5fcGF0aChoZWFkLCBub2RlLCBucyk7Cj4gKwlp
ZiAoUkVBRF9PTkNFKGhlYWQtPnN1YnN5cy0+aW9wb2xpY3kpID09IE5WTUVfSU9QT0xJQ1lfUlIp
Cj4gKwkJcmV0dXJuIG52bWVfcm91bmRfcm9iaW5fcGF0aChoZWFkLCBub2RlLCBucyk7Cj4gKwo+
ICAgCWlmICh1bmxpa2VseSghbnMgfHwgIW52bWVfcGF0aF9pc19vcHRpbWl6ZWQobnMpKSkKPiAg
IAkJbnMgPSBfX252bWVfZmluZF9wYXRoKGhlYWQsIG5vZGUpOwo+ICAgCXJldHVybiBuczsKPiAK
V2h5IG5vdCBtb2RpZnkgdGhlIGxhc3QgaWYgY2xhdXNlIHRvIGp1c3QKCmlmICh1bmxpa2VseSgh
bnMpKQoKPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAg
ICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
