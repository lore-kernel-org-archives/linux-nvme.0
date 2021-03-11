Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF1C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:29:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A0464FBA
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A0464FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:References:
	In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XGFsjI3/61vy1H3erq3pqtlhI6MuaZbqItkEQHqZecg=; b=WFNZBQKOHrdJQwlpchBLRrjkU
	YIADwpTnCqbGJRjtuEYSzHiFvi96KR3SO/pCJ5gjU2oNCSTPjdhJYNVswyBuh7HZaX+K78DvO/VZ2
	gdez8R9Ad65mZejguCEveghdT/Mv+P998GZrPtQ2M/dBHvMhZexD4AuyPh9XWYp09vunOtbcKvX/p
	yWE08jefUZl79zDoRZ9JtIblzCvn00aIAe44wbSpI55N6CBYQHijXgQA7M4yJ//r94SRURNHKv52C
	1g++ilZ684rGzCn/8Jyxjt54zJAzcjGQN4tBnonWqjWEn3PZhrkvGq5H8C1YWIPC+y0ggE7OgUyA6
	N4iE1SZ5Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIYm-008pmT-GX; Thu, 11 Mar 2021 10:28:52 +0000
Received: from forwardcorp1p.mail.yandex.net ([2a02:6b8:0:1472:2741:0:8b6:217])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIYh-008pld-7p
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:28:50 +0000
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B7F442E12E6;
 Thu, 11 Mar 2021 13:28:41 +0300 (MSK)
Received: from mail.yandex-team.ru (mail.yandex-team.ru
 [2a02:6b8:0:408:9070:8be:747c:6edb])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with HTTP id
 XSSwT00xO0U1-SfxC3Had; Thu, 11 Mar 2021 13:28:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1615458521; bh=+zceFxQk7nfPU+KX7fq6I3PyIlzkWp+mnYkoAvCzRJU=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=iLmdU9t4oIENoprgeKOkE/s2sWuXYCAuyKqLfa5hz9ZaD0KJB+ChoIHtoV8WWa+oq
 O7TWrR3p6Hff1+ULO22ba8yY3zdijokhYY2iR3p8SA5X4VT8LjkY5MWdME3s0J51pE
 xADzxYV6MSUr3c9fdizGNXGdGWkO6s5UvZM1nSko=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000084479
X-Yandex-Avir: 1
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net [2a02:6b8:c0c:2f26:0:640:d077:482f])
 by iva4-81f2a0d63507.qloud-c.yandex.net with LMTP id BPigBz2fop-fCrbe7Rg
 for <dmtrmonakhov@yandex-team.ru>; Thu, 11 Mar 2021 13:28:30 +0300
Received: by iva8-edafde7c849c.qloud-c.yandex.net with HTTP;
 Thu, 11 Mar 2021 13:28:30 +0300
From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210310134110.GA13063@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 11 Mar 2021 13:28:40 +0300
Message-Id: <7141615457844@mail.yandex-team.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_102848_049155_A4900C7A 
X-CRM114-Status: GOOD (  22.08  )
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

CgoxMC4wMy4yMDIxLCAxNjo0MSwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5kZT46Cj4g
T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDI6MjE6NTZQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4+IMKgQ2FuIHlvdSB0cnkgdGhpcyBwYXRjaCBpbnN0ZWFkPwo+Pgo+PiDCoGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjEtRmVicnVh
cnkvMDIzMTgzLmh0bWwKPgo+IEFjdHVhbGx5LCBwbGVhc2UgdHJ5IHRoZSBwYXRjaCBiZWxvdyBp
bnN0ZWFkLCBpdCBsb29rcyBsaWtlIG91ciBleGlzdGluZwo+IGxvZ2ljIG1lc3NlcyB1cCB0aGUg
dW5pdHM6Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggZTY4YThjNGFjNWE2ZWEuLjE4NjdmZGYyMjA1YmQ3
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0xOTYzLDMwICsxOTYzLDE4IEBAIHN0YXRpYyB2b2lkIG52
bWVfY29uZmlnX2Rpc2NhcmQoc3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX25zICpu
cykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmxrX3F1ZXVlX21heF93cml0
ZV96ZXJvZXNfc2VjdG9ycyhxdWV1ZSwgVUlOVF9NQVgpOwo+IMKgfQo+Cj4gLXN0YXRpYyB2b2lk
IG52bWVfY29uZmlnX3dyaXRlX3plcm9lcyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52
bWVfbnMgKm5zKQo+ICsvKgo+ICsgKiBFdmVuIHRob3VnaCBOVk1lIHNwZWMgZXhwbGljaXRseSBz
dGF0ZXMgdGhhdCBNRFRTIGlzIG5vdCBhcHBsaWNhYmxlIHRvIHRoZQo+ICsgKiB3cml0ZS16ZXJv
ZXMsIHdlIGFyZSBjYXV0aW91cyBhbmQgbGltaXQgdGhlIHNpemUgdG8gdGhlIGNvbnRyb2xsZXJz
Cj4gKyAqIG1heF9od19zZWN0b3JzIHZhbHVlLCB3aGljaCBpcyBiYXNlZCBvbiB0aGUgTURUUyBm
aWVsZCBhbmQgcG9zc2libHkgb3RoZXIKPiArICogbGltaXRpbmcgZmFjdG9ycy4KPiArICovCj4g
K3N0YXRpYyB2b2lkIG52bWVfY29uZmlnX3dyaXRlX3plcm9lcyhzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSwKPiArIHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gwqB7Cj4gLSB1NjQgbWF4X2Jsb2Nr
czsKPiAtCj4gLSBpZiAoIShucy0+Y3RybC0+b25jcyAmIE5WTUVfQ1RSTF9PTkNTX1dSSVRFX1pF
Uk9FUykgfHwKPiAtIChucy0+Y3RybC0+cXVpcmtzICYgTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRF
X1pFUk9FUykpCj4gLSByZXR1cm47Cj4gLSAvKgo+IC0gKiBFdmVuIHRob3VnaCBOVk1lIHNwZWMg
ZXhwbGljaXRseSBzdGF0ZXMgdGhhdCBNRFRTIGlzIG5vdAo+IC0gKiBhcHBsaWNhYmxlIHRvIHRo
ZSB3cml0ZS16ZXJvZXM6LSAiVGhlIHJlc3RyaWN0aW9uIGRvZXMgbm90IGFwcGx5IHRvCj4gLSAq
IGNvbW1hbmRzIHRoYXQgZG8gbm90IHRyYW5zZmVyIGRhdGEgYmV0d2VlbiB0aGUgaG9zdCBhbmQg
dGhlCj4gLSAqIGNvbnRyb2xsZXIgKGUuZy4sIFdyaXRlIFVuY29ycmVjdGFibGUgcm8gV3JpdGUg
WmVyb2VzIGNvbW1hbmQpLiIuCj4gLSAqIEluIG9yZGVyIHRvIGJlIG1vcmUgY2F1dGlvdXMgdXNl
IGNvbnRyb2xsZXIncyBtYXhfaHdfc2VjdG9ycyB2YWx1ZQo+IC0gKiB0byBjb25maWd1cmUgdGhl
IG1heGltdW0gc2VjdG9ycyBmb3IgdGhlIHdyaXRlLXplcm9lcyB3aGljaCBpcwo+IC0gKiBjb25m
aWd1cmVkIGJhc2VkIG9uIHRoZSBjb250cm9sbGVyJ3MgTURUUyBmaWVsZCBpbiB0aGUKPiAtICog
bnZtZV9pbml0X2lkZW50aWZ5KCkgaWYgYXZhaWxhYmxlLgo+IC0gKi8KPiAtIGlmIChucy0+Y3Ry
bC0+bWF4X2h3X3NlY3RvcnMgPT0gVUlOVF9NQVgpCj4gLSBtYXhfYmxvY2tzID0gKHU2NClVU0hS
VF9NQVggKyAxOwo+IC0gZWxzZQo+IC0gbWF4X2Jsb2NrcyA9IG5zLT5jdHJsLT5tYXhfaHdfc2Vj
dG9ycyArIDE7Cj4gLQo+IC0gYmxrX3F1ZXVlX21heF93cml0ZV96ZXJvZXNfc2VjdG9ycyhkaXNr
LT5xdWV1ZSwKPiAtIG52bWVfbGJhX3RvX3NlY3QobnMsIG1heF9ibG9ja3MpKTsKPiArIGlmICgo
Y3RybC0+b25jcyAmIE5WTUVfQ1RSTF9PTkNTX1dSSVRFX1pFUk9FUykgJiYKPiArICEoY3RybC0+
cXVpcmtzICYgTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUykpCj4gKyBibGtfcXVldWVf
bWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKHEsIGN0cmwtPm1heF9od19zZWN0b3JzKTsKPiDCoH0K
Pgo+IMKgc3RhdGljIGJvb2wgbnZtZV9uc19pZHNfdmFsaWQoc3RydWN0IG52bWVfbnNfaWRzICpp
ZHMpCj4gQEAgLTIxNTgsNyArMjE0Niw3IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX2Rpc2tf
aW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywKPiDCoMKgwqDCoMKgwqDCoMKgwqBzZXRfY2FwYWNp
dHlfYW5kX25vdGlmeShkaXNrLCBjYXBhY2l0eSk7Cj4KPiDCoMKgwqDCoMKgwqDCoMKgwqBudm1l
X2NvbmZpZ19kaXNjYXJkKGRpc2ssIG5zKTsKPiAtIG52bWVfY29uZmlnX3dyaXRlX3plcm9lcyhk
aXNrLCBucyk7Cj4gKyBudm1lX2NvbmZpZ193cml0ZV96ZXJvZXMoZGlzay0+cXVldWUsIG5zLT5j
dHJsKTsKPgo+IMKgwqDCoMKgwqDCoMKgwqDCoHNldF9kaXNrX3JvKGRpc2ssIChpZC0+bnNhdHRy
ICYgTlZNRV9OU19BVFRSX1JPKSB8fAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB0ZXN0X2JpdChOVk1FX05TX0ZPUkNFX1JPLCAmbnMtPmZsYWdzKSk7CkluIG9yZGVyIHRvIGV4
Y2x1ZGUgcG9zc2libGUgaXNzdWUgd2l0aCBpbmNvcnJlY3QgcmVxdWVzdCBzaXplZCBJJ3ZlIHJ1
biB0ZXN0IHdoaWNoIGRvZXMgd3JpdGVfemVyb2VzLAp2aWEgZmlvLWZhbGxvY2F0ZSByYW5kcnRp
bSwgd2hpY2ggYWN0dWFsbHkgZG9lcyBmYWxsb2NhdGUgcHVuY2hfaG9sZStrZWVwX3NpemUgd2hp
Y2ggY29udmVydHMgdG8gYmxrZGV2X2lzc3VlX3plcm9vdXQoKQpub3RlOiBmaW8gc2hvdWxkIGJl
IHBhdGNoZWQsIHNlZTogaHR0cHM6Ly9naXRodWIuY29tL2F4Ym9lL2Zpby9wdWxsLzEyMDMKCmZp
byAtLW5hbWUgdCAtLWlvZW5naW5lPWZhbGxvYyAtLXJ3PXJhbmR0cmltIC0tYnM9NTEyIC0tc2l6
ZT0xMDBNIC0tZmlsZW5hbWU9L2Rldi9udm1lMG4xIC0tbnVtam9icz0xNgpBZnRlciBhIGNvdXBs
ZSBvZiBtaW51dGVzIGl0IHN0dWNrLCBhbmQgdGhlbiB0aW1lb3V0IG9jY291ci4KY2F0IC9zeXMv
a2VybmVsL2RlYnVnL2Jsb2NrL252bWUwbjEvaGN0eCovYnVzeSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAowMDAwMDAwMGNkMjdiNzU1IHsub3A9V1JJVEVfWkVST0VTLCAuY21kX2Zs
YWdzPVNZTkMsIC5ycV9mbGFncz1ET05UUFJFUHxJT19TVEFUfFNUQVRTLCAuc3RhdGU9aW5fZmxp
Z2h0LCAudGFnPTIwNSwgLmludGVybmFsX3RhZz0tMX0KMDAwMDAwMDA5ZDNmMmI4ZiB7Lm9wPVdS
SVRFX1pFUk9FUywgLmNtZF9mbGFncz1TWU5DLCAucnFfZmxhZ3M9RE9OVFBSRVB8SU9fU1RBVHxT
VEFUUywgLnN0YXRlPWluX2ZsaWdodCwgLnRhZz0yNDQsIC5pbnRlcm5hbF90YWc9LTF9CjAwMDAw
MDAwZWI0MTY2ZmUgey5vcD1XUklURV9aRVJPRVMsIC5jbWRfZmxhZ3M9U1lOQywgLnJxX2ZsYWdz
PURPTlRQUkVQfElPX1NUQVR8U1RBVFMsIC5zdGF0ZT1pbl9mbGlnaHQsIC50YWc9NzA5LCAuaW50
ZXJuYWxfdGFnPS0xfQowMDAwMDAwMDQ5YjQ5YzYwIHsub3A9V1JJVEVfWkVST0VTLCAuY21kX2Zs
YWdzPVNZTkMsIC5ycV9mbGFncz1ET05UUFJFUHxJT19TVEFUfFNUQVRTLCAuc3RhdGU9aW5fZmxp
Z2h0LCAudGFnPTQzMywgLmludGVybmFsX3RhZz0tMX0KMDAwMDAwMDAxOGI5M2M0MCB7Lm9wPVdS
SVRFX1pFUk9FUywgLmNtZF9mbGFncz1TWU5DLCAucnFfZmxhZ3M9RE9OVFBSRVB8SU9fU1RBVHxT
VEFUUywgLnN0YXRlPWluX2ZsaWdodCwgLnRhZz01LCAuaW50ZXJuYWxfdGFnPS0xfQowMDAwMDAw
MGFjMTVlZjczIHsub3A9V1JJVEVfWkVST0VTLCAuY21kX2ZsYWdzPVNZTkMsIC5ycV9mbGFncz1E
T05UUFJFUHxJT19TVEFUfFNUQVRTLCAuc3RhdGU9aW5fZmxpZ2h0LCAudGFnPTI2OCwgLmludGVy
bmFsX3RhZz0tMX0KClNvLCB0aGlzIGlzIGRlZmluaXRlbHkgaGFyZHdhcmUgaXNzdWUsIGFuZCB3
cml0ZV96ZXJvZXMgc2hvdWxkIGJlIGRpc2FibGVkIGZvciB0aGlzIHBhcnRpY3VsYXIgbW9kZWwu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
