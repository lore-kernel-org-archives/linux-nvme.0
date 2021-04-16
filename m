Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604CC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:08:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E979610F7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E979610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0QKltOhPQ8Qil0CUsQopy9lJGPN6lEdsW5U25zKRGxw=; b=PTP02KqBY7lhaykCbvIq0ByK/
	D1Q8/jpx7ld75mfpXVHQ44ldXj8EOtTeVRttNYB+yp+NsHGVSAnqYqr5msCO2Pgln5/4MTYbazz9O
	jd2TXrNs5BNCxzzLwIr1qwH4WoUPfhszika9wj2H/kc/tp3E0kKhIidloa/TyiAs05FeTqW/TWYLO
	wO7QzF+z8r7rfJlT/7ww5kD30B3q2LNa85/OFX4pI2rzrQVYhixBKAK5qVI7LY8b6J+K0y9Q92OZn
	jgzE2mB0J7CdvC7ohP/1ElAaczOJT0Nlg7Seg1Sn5gPVljQNFIoU6mfaloQKa8gRWyNrUKcVGixXK
	smfyaUWoA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXP8m-002LSV-7F; Fri, 16 Apr 2021 14:08:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXP8h-002LRl-Ra
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 14:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=tALUD+wGzJBG0Jmt/57kzTwSkSbW1MPfIzuzuejQ/Bg=; b=L6dykYCwIKaOOR2cet1f8TiTHF
 3IW2X6z5P4O9y4+LEXHFHboHCqBuYk1V56yGEN2ZtkPdnBLxFRTVWCf3ioMMmt3Z6JN5gCCm2KiCM
 zD0M3zvfnPgvMrkvpliPxhzBRrSYrrk6VmEaN8z75Nau4by3hKcviodDad0nbkOaNEtSyN7G1p9vN
 lmMJvPLyVodPfiEz2shzvBigigXfj8Px49VysTMRy+C17nzqGdJPUGORyZEdgzwG1NpHUyyjVt+jq
 fJn7JPtOkwcBIfu/K3V7qKkv5e6T+wyaCGgcDVgQW7Ru6AX3zISiMg38D7s49yJe0eG6HKeffS64j
 Jwp9H9RQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXP8b-009QSY-Dp
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 14:08:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 17803AF11;
 Fri, 16 Apr 2021 14:08:00 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
Date: Fri, 16 Apr 2021 16:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-4-snitzer@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_070801_779518_32612016 
X-CRM114-Status: GOOD (  27.54  )
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

T24gNC8xNi8yMSAxOjE1IEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4gSWYgUkVRX0ZBSUxGQVNU
X1RSQU5TUE9SVCBpcyBzZXQgaXQgbWVhbnMgdGhlIGRyaXZlciBzaG91bGQgbm90IHJldHJ5Cj4g
SU8gdGhhdCBjb21wbGV0ZWQgd2l0aCB0cmFuc3BvcnQgZXJyb3JzLiBSRVFfRkFJTEZBU1RfVFJB
TlNQT1JUIGlzCj4gc2V0IGJ5IG11bHRpcGF0aGluZyBzb2Z0d2FyZSAoZS5nLiBkbS1tdWx0aXBh
dGgpIGJlZm9yZSBpdCBpc3N1ZXMgSU8uCj4gCj4gVXBkYXRlIE5WTWUgdG8gYWxsb3cgZmFpbG92
ZXIgb2YgcmVxdWVzdHMgbWFya2VkIHdpdGggZWl0aGVyCj4gUkVRX05WTUVfTVBBVEggb3IgUkVR
X0ZBSUxGQVNUX1RSQU5TUE9SVC4gVGhpcyBhbGxvd3Mgc3VjaCByZXF1ZXN0cwo+IHRvIGJlIGdp
dmVuIGEgZGlzcG9zaXRpb24gb2YgZWl0aGVyIEZBSUxPVkVSIG9yIEZBSUxVUCByZXNwZWN0aXZl
bHkuCj4gRkFJTFVQIGhhbmRsaW5nIGVuc3VyZXMgYSByZXRyeWFibGUgZXJyb3IgaXMgcmV0dXJu
ZWQgdXAgZnJvbSBOVk1lLgo+IAo+IEludHJvZHVjZSBudm1lX2ZhaWx1cF9yZXEoKSBmb3IgdXNl
IGluIG52bWVfY29tcGxldGVfcnEoKSBpZgo+IG52bWVfZGVjaWRlX2Rpc3Bvc2l0aW9uKCkgcmV0
dXJucyBGQUlMVVAuIG52bWVfZmFpbHVwX3JlcSgpIGVuc3VyZXMKPiB0aGUgcmVxdWVzdCBpcyBj
b21wbGV0ZWQgd2l0aCBhIHJldHJ5YWJsZSBJTyBlcnJvciB3aGVuIGFwcHJvcHJpYXRlLgo+IF9f
bnZtZV9lbmRfcmVxKCkgd2FzIGZhY3RvcmVkIG91dCBmb3IgdXNlIGJ5IGJvdGggbnZtZV9lbmRf
cmVxKCkgYW5kCj4gbnZtZV9mYWlsdXBfcmVxKCkuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBT
bml0emVyIDxzbml0emVyQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4
IDQxMzRjZjNjN2U0OC4uMTAzNzUxOTdkZDUzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0yOTksNiAr
Mjk5LDcgQEAgZW51bSBudm1lX2Rpc3Bvc2l0aW9uIHsKPiAgCUNPTVBMRVRFLAo+ICAJUkVUUlks
Cj4gIAlGQUlMT1ZFUiwKPiArCUZBSUxVUCwKPiAgfTsKPiAgCj4gIHN0YXRpYyBpbmxpbmUgZW51
bSBudm1lX2Rpc3Bvc2l0aW9uIG52bWVfZGVjaWRlX2Rpc3Bvc2l0aW9uKHN0cnVjdCByZXF1ZXN0
ICpyZXEpCj4gQEAgLTMxOCwxMCArMzE5LDExIEBAIHN0YXRpYyBpbmxpbmUgZW51bSBudm1lX2Rp
c3Bvc2l0aW9uIG52bWVfZGVjaWRlX2Rpc3Bvc2l0aW9uKHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4g
IAkgICAgbnZtZV9yZXEocmVxKS0+cmV0cmllcyA+PSBudm1lX21heF9yZXRyaWVzKQo+ICAJCXJl
dHVybiBDT01QTEVURTsKPiAgCj4gLQlpZiAocmVxLT5jbWRfZmxhZ3MgJiBSRVFfTlZNRV9NUEFU
SCkgewo+ICsJaWYgKHJlcS0+Y21kX2ZsYWdzICYgKFJFUV9OVk1FX01QQVRIIHwgUkVRX0ZBSUxG
QVNUX1RSQU5TUE9SVCkpIHsKPiAgCQlpZiAobnZtZV9pc19wYXRoX2Vycm9yKG52bWVfcmVxKHJl
cSktPnN0YXR1cykgfHwKPiAgCQkgICAgYmxrX3F1ZXVlX2R5aW5nKHJlcS0+cSkpCj4gLQkJCXJl
dHVybiBGQUlMT1ZFUjsKPiArCQkJcmV0dXJuIChyZXEtPmNtZF9mbGFncyAmIFJFUV9OVk1FX01Q
QVRIKSA/Cj4gKwkJCQlGQUlMT1ZFUiA6IEZBSUxVUDsKPiAgCX0gZWxzZSB7Cj4gIAkJaWYgKGJs
a19xdWV1ZV9keWluZyhyZXEtPnEpKQo+ICAJCQlyZXR1cm4gQ09NUExFVEU7Cj4gQEAgLTMzMCwx
MCArMzMyLDggQEAgc3RhdGljIGlubGluZSBlbnVtIG52bWVfZGlzcG9zaXRpb24gbnZtZV9kZWNp
ZGVfZGlzcG9zaXRpb24oc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgCXJldHVybiBSRVRSWTsKPiAg
fQo+ICAKPiAtc3RhdGljIGlubGluZSB2b2lkIG52bWVfZW5kX3JlcShzdHJ1Y3QgcmVxdWVzdCAq
cmVxKQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19udm1lX2VuZF9yZXEoc3RydWN0IHJlcXVlc3Qg
KnJlcSwgYmxrX3N0YXR1c190IHN0YXR1cykKPiAgewo+IC0JYmxrX3N0YXR1c190IHN0YXR1cyA9
IG52bWVfZXJyb3Jfc3RhdHVzKG52bWVfcmVxKHJlcSktPnN0YXR1cyk7Cj4gLQo+ICAJaWYgKElT
X0VOQUJMRUQoQ09ORklHX0JMS19ERVZfWk9ORUQpICYmCj4gIAkgICAgcmVxX29wKHJlcSkgPT0g
UkVRX09QX1pPTkVfQVBQRU5EKQo+ICAJCXJlcS0+X19zZWN0b3IgPSBudm1lX2xiYV90b19zZWN0
KHJlcS0+cS0+cXVldWVkYXRhLAo+IEBAIC0zNDMsNiArMzQzLDI0IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBudm1lX2VuZF9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgCWJsa19tcV9lbmRfcmVx
dWVzdChyZXEsIHN0YXR1cyk7Cj4gIH0KPiAgCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2Vu
ZF9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiArewo+ICsJX19udm1lX2VuZF9yZXEocmVxLCBu
dm1lX2Vycm9yX3N0YXR1cyhudm1lX3JlcShyZXEpLT5zdGF0dXMpKTsKPiArfQo+ICsKPiArc3Rh
dGljIHZvaWQgbnZtZV9mYWlsdXBfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4gK3sKPiArCWJs
a19zdGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vycm9yX3N0YXR1cyhudm1lX3JlcShyZXEpLT5zdGF0
dXMpOwo+ICsKPiArCWlmIChXQVJOX09OX09OQ0UoIWJsa19wYXRoX2Vycm9yKHN0YXR1cykpKSB7
Cj4gKwkJcHJfZGVidWcoIlJlcXVlc3QgbWVhbnQgZm9yIGZhaWxvdmVyIGJ1dCBibGtfc3RhdHVz
X3QgKGVycm5vPSVkKSB3YXMgbm90IHJldHJ5YWJsZS5cbiIsCj4gKwkJCSBibGtfc3RhdHVzX3Rv
X2Vycm5vKHN0YXR1cykpOwo+ICsJCXN0YXR1cyA9IEJMS19TVFNfSU9FUlI7Cj4gKwl9Cj4gKwo+
ICsJX19udm1lX2VuZF9yZXEocmVxLCBzdGF0dXMpOwo+ICt9Cj4gKwo+ICB2b2lkIG52bWVfY29t
cGxldGVfcnEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgewo+ICAJdHJhY2VfbnZtZV9jb21wbGV0
ZV9ycShyZXEpOwo+IEBAIC0zNjEsNiArMzc5LDkgQEAgdm9pZCBudm1lX2NvbXBsZXRlX3JxKHN0
cnVjdCByZXF1ZXN0ICpyZXEpCj4gIAljYXNlIEZBSUxPVkVSOgo+ICAJCW52bWVfZmFpbG92ZXJf
cmVxKHJlcSk7Cj4gIAkJcmV0dXJuOwo+ICsJY2FzZSBGQUlMVVA6Cj4gKwkJbnZtZV9mYWlsdXBf
cmVxKHJlcSk7Cj4gKwkJcmV0dXJuOwo+ICAJfQo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKG52
bWVfY29tcGxldGVfcnEpOwo+IAoKSG1tLiBRdWl0ZSBjb252b2x1dGVkLCBtZXRoaW5rcy4KU2hv
dWxkbid0IHRoaXMgYWNoaWV2ZSB0aGUgc2FtZSB0aGluZz8KCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZTg5ZWMy
NTIyY2E2Li44YzM2YTIxOTZiNjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTMwMyw4ICszMDMsMTAgQEAgc3Rh
dGljIGlubGluZSBlbnVtIG52bWVfZGlzcG9zaXRpb24KbnZtZV9kZWNpZGVfZGlzcG9zaXRpb24o
c3RydWN0IHJlcXVlc3QgKnJlcSkKICAgICAgICBpZiAobGlrZWx5KG52bWVfcmVxKHJlcSktPnN0
YXR1cyA9PSAwKSkKICAgICAgICAgICAgICAgIHJldHVybiBDT01QTEVURTsKCi0gICAgICAgaWYg
KGJsa19ub3JldHJ5X3JlcXVlc3QocmVxKSB8fAotICAgICAgICAgICAobnZtZV9yZXEocmVxKS0+
c3RhdHVzICYgTlZNRV9TQ19ETlIpIHx8CisgICAgICAgaWYgKGJsa19ub3JldHJ5X3JlcXVlc3Qo
cmVxKSkKKyAgICAgICAgICAgICAgIG52bWVfcmVxKHJlcSktPnN0YXR1cyB8PSBOVk1FX1NDX0RO
UjsKKworICAgICAgIGlmICgobnZtZV9yZXEocmVxKS0+c3RhdHVzICYgTlZNRV9TQ19ETlIpIHx8
CiAgICAgICAgICAgIG52bWVfcmVxKHJlcSktPnJldHJpZXMgPj0gbnZtZV9tYXhfcmV0cmllcykK
ICAgICAgICAgICAgICAgIHJldHVybiBDT01QTEVURTsKCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRy
LiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZm
ZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
