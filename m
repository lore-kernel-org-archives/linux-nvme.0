Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2DBC4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE33123772
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sb5ojkSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE33123772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QQc/FSnSaLqXGI4icc3nHKZGxSE1Kv4ZwQzDkqAMNW8=; b=Sb5ojkSk8J9beqGB0XsEGv4lh
	FSZpD9pL+TnZfK9qiMQckCVYpGww3dBdNiey3L6y/lV/NgmsSoGON/Xg6Z7RDtYrpUz5nVnxukGE7
	NAfoglbILEZ1aY0oDRSzGHFWRz3j2NbN622QFhX1XLMNgjFoR2kJm5EotkAzXPu9jqI06a3ieIWAE
	KnHmeDjdFjt3gq1xEkwI/fyYvUMiWGKfm0LQnehfohgYn5VkDKqGiZx37lB5EhAvoLHIaufL5Ypge
	E9+c6H9GJRqkBMRjAsN4wk+8EnUV258Ndv6+q+3pWQtxLKLWDig7hrB7gsDhFdudY3cAF6NplLEy1
	kAOrm5tEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLMyX-00074T-CD; Thu, 24 Sep 2020 08:51:37 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLMyU-00073Q-OJ
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 08:51:36 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=1; SR=0; TI=SMTPD_---0U9xJKXZ_1600937490; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0U9xJKXZ_1600937490) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Sep 2020 16:51:30 +0800
Subject: Re: [RFC] nvme/pci: allocate separate interrupt for reserved
 non-polled IO queue
To: linux-nvme@lists.infradead.org
References: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
 <20200924070457.GA10717@lst.de>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <60acafdc-b3ba-e1ec-a0d6-736cf5ce8588@linux.alibaba.com>
Date: Thu, 24 Sep 2020 16:51:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924070457.GA10717@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_045135_034683_DC13AC4F 
X-CRM114-Status: GOOD (  27.64  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhbmtzIGZvciByZXBseWluZy4KCgpPbiA5LzI0LzIwIDM6MDQgUE0sIENocmlzdG9waCBIZWxs
d2lnIHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDIyLCAyMDIwIGF0IDEyOjI4OjE2UE0gKzA4MDAsIEpl
ZmZsZSBYdSB3cm90ZToKPj4gT25lIHF1ZXVlIHdpbGwgYmUgcmVzZXJ2ZWQgZm9yIG5vbi1wb2xs
ZWQgSU8gd2hlbiBudm1lLnBvbGxfcXVldWVzIGlzCj4+IGdyZWF0ZXIgb3IgZXF1YWwgdGhhbiB0
aGUgbnVtYmVyIG9mIElPIHF1ZXVlcyB0aGF0IHRoZSBudm1lIGNvbnRyb2xsZXIKPj4gY2FuIHBy
b3ZpZGUuIEN1cnJlbnRseSB0aGUgcmVzZXJ2ZWQgcXVldWUgZm9yIG5vbi1wb2xsZWQgSU8gd2ls
bCByZXVzZQo+PiB0aGUgaW50ZXJydXB0IHVzZWQgYnkgYWRtaW4gcXVldWUgaW4gdGhpcyBjYXNl
LCBlLmcsIHZlY3RvciAwLgo+Pgo+PiBUaGlzIGNhbiB3b3JrIGFuZCB0aGUgcGVyZm9ybWFuY2Ug
bWF5IG5vdCBiZSBhbiBpc3N1ZSBzaW5jZSB0aGUgYWRtaW4KPj4gcXVldWUgaXMgdXNlZCB1bmZy
ZXF1ZW50bHkuIEhvd2V2ZXIgdGhpcyBiZWhhdmlvdXIgbWF5IGJlIGluY29uc2lzdGVudAo+PiB3
aXRoIHRoYXQgd2hlbiBudm1lLnBvbGxfcXVldWVzIGlzIHNtYWxsZXIgdGhhbiB0aGUgbnVtYmVy
IG9mIElPCj4+IHF1ZXVlcyBhdmFpbGFibGUuCj4+Cj4+IFRodXMgYWxsb2NhdGUgc2VwYXJhdGUg
aW50ZXJydXB0IGZvciB0aGlzIHJlc2VydmVkIHF1ZXVlLCBhbmQgdGh1cyBtYWtlCj4+IHRoZSBi
ZWhhdmlvdXIgY29uc2lzdGVudC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmVmZmxlIFh1IDxqZWZm
bGV4dUBsaW51eC5hbGliYWJhLmNvbT4KPiBUaGlzIGNvZGUgbG9va3MgZ29vZCwgYnV0IHRoZSBm
dW5jdGlvbiBhbHJlYWR5IGlzIGEgbWVzcyB3aXRob3V0IHRoZQo+IGFkZGl0aW9uLiAgV2hhdCBk
byB5b3UgdGhpbmsgYWJvdXQgdGhpcyB2YXJpYW50PwoKTG9va3MgZ29vZCB0byBtZS4gSWYgeW91
IGRvbid0IG1pbmQsIEknZCBsaWtlIHRvIHNlbmQgYSB2MiBwYXRjaCAKY29udGFpbmluZyB5b3Vy
IHJlZmFjdG9yZWQgY29kZS4KCkFsc28gc29tZSB0cml2aWFsIGFkdmljZSBiZWxvdy4KCj4KPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L3BjaS5jCj4gaW5kZXggODk5ZDJmNGQ3YWI2MTIuLjQzMDU1MTM4ZDU5YTQ3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNp
LmMKPiBAQCAtMjAzOCwzMSArMjAzOCwyOSBAQCBzdGF0aWMgaW50IG52bWVfc2V0dXBfaXJxcyhz
dHJ1Y3QgbnZtZV9kZXYgKmRldiwgdW5zaWduZWQgaW50IG5yX2lvX3F1ZXVlcykKPiAgIAkJLmNh
bGNfc2V0cwk9IG52bWVfY2FsY19pcnFfc2V0cywKPiAgIAkJLnByaXYJCT0gZGV2LAo+ICAgCX07
Cj4gLQl1bnNpZ25lZCBpbnQgaXJxX3F1ZXVlcywgdGhpc19wX3F1ZXVlczsKPiArCXVuc2lnbmVk
IGludCBpcnFfcXVldWVzLCBwb2xsX3F1ZXVlczsKPiAgIAo+ICAgCS8qCj4gLQkgKiBQb2xsIHF1
ZXVlcyBkb24ndCBuZWVkIGludGVycnVwdHMsIGJ1dCB3ZSBuZWVkIGF0IGxlYXN0IG9uZSBJTwo+
IC0JICogcXVldWUgbGVmdCBvdmVyIGZvciBub24tcG9sbGVkIElPLgo+ICsJICogUG9sbCBxdWV1
ZXMgZG9uJ3QgbmVlZCBpbnRlcnJ1cHRzLCBidXQgd2UgbmVlZCBhdCBsZWFzdCBvbmUgSS9PIHF1
ZXVlCj4gKwkgKiBsZWZ0IG92ZXIgZm9yIG5vbi1wb2xsZWQgSS9PLgo+ICAgCSAqLwo+IC0JdGhp
c19wX3F1ZXVlcyA9IGRldi0+bnJfcG9sbF9xdWV1ZXM7Cj4gLQlpZiAodGhpc19wX3F1ZXVlcyA+
PSBucl9pb19xdWV1ZXMpIHsKPiAtCQl0aGlzX3BfcXVldWVzID0gbnJfaW9fcXVldWVzIC0gMTsK
PiAtCQlpcnFfcXVldWVzID0gMTsKPiAtCX0gZWxzZSB7Cj4gLQkJaXJxX3F1ZXVlcyA9IG5yX2lv
X3F1ZXVlcyAtIHRoaXNfcF9xdWV1ZXMgKyAxOwo+IC0JfQo+IC0JZGV2LT5pb19xdWV1ZXNbSENU
WF9UWVBFX1BPTExdID0gdGhpc19wX3F1ZXVlczsKPiArCXBvbGxfcXVldWVzID0gbWluKGRldi0+
bnJfcG9sbF9xdWV1ZXMsIG5yX2lvX3F1ZXVlcyAtIDEpOwo+ICsJZGV2LT5pb19xdWV1ZXNbSENU
WF9UWVBFX1BPTExdID0gcG9sbF9xdWV1ZXM7Cj4gICAKPiAtCS8qIEluaXRpYWxpemUgZm9yIHRo
ZSBzaW5nbGUgaW50ZXJydXB0IGNhc2UgKi8KPiArCS8qCj4gKwkgKiBJbml0aWFsaXplIGZvciB0
aGUgc2luZ2xlIGludGVycnVwdCBjYXNlLCB3aWxsIGJlIHVwZGF0ZWQgaW4KPiArCSAqIG52bWVf
Y2FsY19pcnFfc2V0cygpLgo+ICsJICovCj4gICAJZGV2LT5pb19xdWV1ZXNbSENUWF9UWVBFX0RF
RkFVTFRdID0gMTsKPiAgIAlkZXYtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVfUkVBRF0gPSAwOwo+ICAg
Cj4gICAJLyoKPiAtCSAqIFNvbWUgQXBwbGUgY29udHJvbGxlcnMgcmVxdWlyZSBhbGwgcXVldWVz
IHRvIHVzZSB0aGUKPiAtCSAqIGZpcnN0IHZlY3Rvci4KPiArCSAqIFNvbWUgQXBwbGUgY29udHJv
bGxlcnMgcmVxdWlyZSBhbGwgcXVldWVzIHRvIHVzZSB0aGUgZmlyc3QgdmVjdG9yLgo+ICAgCSAq
Lwo+ICAgCWlmIChkZXYtPmN0cmwucXVpcmtzICYgTlZNRV9RVUlSS19TSU5HTEVfVkVDVE9SKQo+
ICAgCQlpcnFfcXVldWVzID0gMTsKPiArCWVsc2UKCj4gKwkJaXJxX3F1ZXVlcyA9IDEgKyAobnJf
aW9fcXVldWVzIC0gcG9sbF9xdWV1ZXMpOwoKUGVyc29uYWxseSBpdCB3b3VsZCBiZSBiZXR0ZXIg
aWYgdGhlcmUncyBhIGNvbW1lbnQgdG8gZXhwbGljaXRseSBwb2ludCAKb3V0IHRoYXQgdGhlcmUn
cyBvbmUgaW50ZXJydXB0IGZvciBhZG1pbiBxdWV1ZS4KCkl0IHdvdWxkIGJlIG1vcmUgZnJpZW5k
bHkgdG8gdGhlIG5ld2Jvcm5zLgoKc3VjaCBhcwoKIMKgwqDCoMKgwqDCoMKgIC8qCi3CoMKgwqDC
oMKgwqDCoCAqIFNvbWUgQXBwbGUgY29udHJvbGxlcnMgcmVxdWlyZSBhbGwgcXVldWVzIHRvIHVz
ZSB0aGUKLcKgwqDCoMKgwqDCoMKgICogZmlyc3QgdmVjdG9yLgorwqDCoMKgwqDCoMKgwqAgKiBT
b21lIEFwcGxlIGNvbnRyb2xsZXJzIHJlcXVpcmUgYWxsIHF1ZXVlcyB0byB1c2UgdGhlIGZpcnN0
IAp2ZWN0b3IuCiDCoMKgwqDCoMKgwqDCoMKgICovCiDCoMKgwqDCoMKgwqDCoCBpZiAoZGV2LT5j
dHJsLnF1aXJrcyAmIE5WTUVfUVVJUktfU0lOR0xFX1ZFQ1RPUikKIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpcnFfcXVldWVzID0gMTsKCivCoMKgwqDCoMKgwqAgZWxzZSB7CivCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE9uZSBpbnRlcnJ1cHQgZm9yIGFkbWluIHF1ZXVl
LiovCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlycV9xdWV1ZXMgPSAxICsgKG5yX2lv
X3F1ZXVlcyAtIHBvbGxfcXVldWVzKTsKK8KgwqDCoMKgwqDCoCB9CgoKPiAgIAo+ICAgCXJldHVy
biBwY2lfYWxsb2NfaXJxX3ZlY3RvcnNfYWZmaW5pdHkocGRldiwgMSwgaXJxX3F1ZXVlcywKPiAg
IAkJCSAgICAgIFBDSV9JUlFfQUxMX1RZUEVTIHwgUENJX0lSUV9BRkZJTklUWSwgJmFmZmQpOwoK
Cgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBM
aW51eC1udm1lIG1haWxpbmcgbGlzdAo+IExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwo+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
