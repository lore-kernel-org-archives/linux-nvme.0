Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA06C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:59:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA1D2137B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmVsuCwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA1D2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=memsyPioQnH+S1C0vA/UNJ1H364fdq7tfuFsSPoPrYg=; b=GmVsuCwkngoY9dwmUIaxRQJLO
	iIOYQv1QJ0s6tNfy/XY8lfIrkeOyJID2Z06uCGBUBeku0JgYDUHZR+WZvVfnYTwM1NGNSPbxuNIHy
	LUPyCZ05OF6yDsIu7lBCOtvUuaIIXuBxZr12fYC+gr+y8mtCn098704JvDQENCIuyoylTclugC4Iz
	M0zV/rCcoXm+iAJjea/kMPAypltrHs7TojnWUhpByT4rmYqN3CBfxM59WipxMGZIhwKMgYzJp2oul
	spIuZmFO7YtsnCVOti9vALx+S0Q2V4i5rmxppLrnAA5dCnTEb+5SSAwxYENfDgl3MVTJsXFYdr0wJ
	em6GcTu7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZQQ-0000SF-9O; Mon, 16 Nov 2020 07:59:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZNe-0007N3-S6
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:56:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 60120AC65;
 Mon, 16 Nov 2020 07:56:53 +0000 (UTC)
Subject: Re: [PATCH v4 11/19] lpfc: vmid: cleanup vmid resources
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-12-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e7c85fae-f7f5-052e-25da-68015a1cfa6e@suse.de>
Date: Mon, 16 Nov 2020 08:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-12-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_025655_181767_11AD63FE 
X-CRM114-Status: GOOD (  25.74  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGUgcGF0Y2ggY2xl
YW5zIHVwIHRoZSB2bWlkIHJlc291cmNlcyBhbmQgc3RvcHMgdGhlIHRpbWVyLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhICA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20u
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4K
PiAKPiAtLS0KPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2MjoK
PiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAgIGRy
aXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jIHwgIDQgKysrKwo+ICAgZHJpdmVycy9zY3NpL2xw
ZmMvbHBmY19zY3NpLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbHBm
Yy9scGZjX2luaXQuYyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jCj4gaW5kZXggZTMy
ZDY5NTE1NTg2Li44ODc3Nzg3NWY0YjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zY3NpL2xwZmMv
bHBmY19pbml0LmMKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2luaXQuYwo+IEBAIC0y
ODQzLDYgKzI4NDMsMTAgQEAgbHBmY19jbGVhbnVwKHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCkK
PiAgIAlpZiAocGhiYS0+bGlua19zdGF0ZSA+IExQRkNfTElOS19ET1dOKQo+ICAgCQlscGZjX3Bv
cnRfbGlua19mYWlsdXJlKHZwb3J0KTsKPiAgIAo+ICsJLyogY2xlYW51cCB2bWlkIHJlc291cmNl
cyAqLwo+ICsJaWYgKGxwZmNfaXNfdm1pZF9lbmFibGVkKHBoYmEpKQo+ICsJCWxwZmNfdm1pZF92
cG9ydF9jbGVhbnVwKHZwb3J0KTsKPiArCj4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKG5k
bHAsIG5leHRfbmRscCwgJnZwb3J0LT5mY19ub2RlcywgbmxwX2xpc3RwKSB7Cj4gICAJCWlmICgh
TkxQX0NIS19OT0RFX0FDVChuZGxwKSkgewo+ICAgCQkJbmRscCA9IGxwZmNfZW5hYmxlX25vZGUo
dnBvcnQsIG5kbHAsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2NzaS5j
IGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19zY3NpLmMKPiBpbmRleCA1ZTgwMmM4YjIyYTkuLjdi
YzFmZDY5YjcxNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX3Njc2kuYwo+
ICsrKyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2NzaS5jCj4gQEAgLTQ3MTEsNiArNDcxMSwy
NyBAQCBscGZjX3F1ZXVlY29tbWFuZChzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9zdCwgc3RydWN0IHNj
c2lfY21uZCAqY21uZCkKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICsvKgo+ICsgKiBscGZj
X3ZtaWRfdnBvcnRfY2xlYW51cCAtIGNsZWFucyB1cCB0aGUgcmVzb3VyY2VzIGFzc29jaWF0ZWQg
d2l0aCBhIHZwb3J0cwo+ICsgKiBAdnBvcnQ6IFRoZSB2aXJ0dWFsIHBvcnQgZm9yIHdoaWNoIHRo
aXMgY2FsbCBpcyBiZWluZyBleGVjdXRlZC4KPiArICovCj4gK3ZvaWQgbHBmY192bWlkX3Zwb3J0
X2NsZWFudXAoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0KQo+ICt7Cj4gKwkvKiBkZWxldGUgdGhl
IHRpbWVyICovCj4gKwlpZiAodnBvcnQtPnBvcnRfdHlwZSA9PSBMUEZDX1BIWVNJQ0FMX1BPUlQp
Cj4gKwkJZGVsX3RpbWVyX3N5bmMoJnZwb3J0LT5waGJhLT5pbmFjdGl2ZV92bWlkX3BvbGwpOwo+
ICsKPiArCS8qIGZyZWUgdGhlIHJlc291cmNlcyAqLwo+ICsJa2ZyZWUodnBvcnQtPnFmcGFfcmVz
KTsKPiArCWtmcmVlKHZwb3J0LT52bWlkX3ByaW9yaXR5LnZtaWRfcmFuZ2UpOwo+ICsJa2ZyZWUo
dnBvcnQtPnZtaWQpOwo+ICsKPiArCS8qIHJlc2V0IHZhcmlhYmxlcyAqLwo+ICsJdnBvcnQtPnFm
cGFfcmVzID0gTlVMTDsKPiArCXZwb3J0LT52bWlkX3ByaW9yaXR5LnZtaWRfcmFuZ2UgPSBOVUxM
Owo+ICsJdnBvcnQtPnZtaWQgPSBOVUxMOwo+ICsJdnBvcnQtPmN1cl92bWlkX2NudCA9IDA7Cj4g
K30KPiAgIAo+ICAgLyoqCj4gICAgKiBscGZjX2Fib3J0X2hhbmRsZXIgLSBzY3NpX2hvc3RfdGVt
cGxhdGUgZWhfYWJvcnRfaGFuZGxlciBlbnRyeSBwb2ludAo+IApQbGVhc2UgbWVyZ2Ugd2l0aCB0
aGUgcHJldmlvdXMgcGF0Y2guCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
