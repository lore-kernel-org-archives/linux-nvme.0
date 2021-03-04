Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:37:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05864F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A05864F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ancrcM2ngRQNdCUxqWqVztMVF7Tk3APUVzQk/P070NI=; b=YXhAw53MKQnyI1oAUB1fkPfqf
	3XJ0yL3p9sl6nQfqtaYbef4KtxSPeg8MCw89vdmCGlp+6jTkVtgMPvsDzdMru4885v5J6FBskhdBS
	iEoidj9MPB2afzNfQloTHFq2oFWGsUJM+0KUDjN3BHoTO9yy3IwKiLnPD/W2xrJ+bdukdy7MB2k5q
	RgRhQo77pUDCjjpgGWAtcTwoYhi7GCqP8xy98ydd5lT5SyNMU04wOVIGMgkRGFeyh48pDktRw8Gdt
	Py7OSMM9UTf7BzhaqOCmpHj2Q9m6T8joLV918R/KmLNq3g7UgsRK1ohknZIlVWHg2NaKpIt1qUm5k
	3VMof2g4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnDn-008dNU-3O; Thu, 04 Mar 2021 12:36:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnAt-008cqn-SX
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4FD1AAE42;
 Thu,  4 Mar 2021 12:33:51 +0000 (UTC)
Subject: Re: [PATCH v8 07/16] lpfc: vmid: VMID params initialization
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-8-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <52e5c05c-37ad-3424-50ea-246b53c33d9b@suse.de>
Date: Thu, 4 Mar 2021 13:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-8-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW5p
dGlhbGl6ZXMgdGhlIFZNSUQgcGFyYW1ldGVycyBsaWtlIHRoZSB0eXBlIG9mIHZtaWQsIG1heAo+
IG51bWJlciBvZiB2bWlkcyBzdXBwb3J0ZWQgYW5kIHRpbWVvdXQgdmFsdWUgZm9yIHRoZSB2bWlk
IHJlZ2lzdHJhdGlvbgo+IGJhc2VkIG9uIHRoZSB1c2VyIGlucHV0Lgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IC0t
LQo+IHY4Ogo+IE5vIGNoYW5nZQo+IAo+IHY3Ogo+IE5vIGNoYW5nZQo+IAo+IHY2Ogo+IE5vIGNo
YW5nZQo+IAo+IHY1Ogo+IE5vIGNoYW5nZQo+IAo+IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYzOgo+
IE5vIGNoYW5nZQo+IAo+IHYyOgo+IFBvcnRlZCB0aGUgcGF0Y2ggb24gdG9wIG9mIDUuMTAvc2Nz
aS1xdWV1ZQo+IC0tLQo+ICAgZHJpdmVycy9zY3NpL2xwZmMvbHBmY19hdHRyLmMgfCA0NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ3IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19hdHRy
LmMgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2F0dHIuYwo+IGluZGV4IGJkZDlhMjlmNDIwMS4u
MDA1MDk5ZjJmNThiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfYXR0ci5j
Cj4gKysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19hdHRyLmMKPiBAQCAtNjE1MCw2ICs2MTUw
LDQ0IEBAIExQRkNfQVRUUl9SVyhlbmFibGVfZHBwLCAxLCAwLCAxLCAiRW5hYmxlIERpcmVjdCBQ
YWNrZXQgUHVzaCIpOwo+ICAgICovCj4gICBMUEZDX0FUVFJfUihlbmFibGVfbWksIDEsIDAsIDEs
ICJFbmFibGUgTUkiKTsKPiAgIAo+ICsvKgo+ICsgKiBscGZjX21heF92bWlkOiBNYXhpbXVtIG51
bWJlciBvZiBWTXMgdG8gYmUgdGFnZ2VkLiBUaGlzIGlzIHZhbGlkIG9ubHkgaWYKPiArICogZWl0
aGVyIHZtaWRfYXBwX2hlYWRlciBvciB2bWlkX3ByaW9yaXR5X3RhZ2dpbmcgaXMgZW5hYmxlZC4K
PiArICogICAgICAgNCAtIDI1NSAgPSB2bWlkIHN1cHBvcnQgZW5hYmxlZCBmb3IgNC0yNTUgVk1z
Cj4gKyAqICAgICAgIFZhbHVlIHJhbmdlIGlzIFs0LDI1NV0uCj4gKyAqLwo+ICtMUEZDX0FUVFJf
UlcobWF4X3ZtaWQsIExQRkNfTUlOX1ZNSUQsIExQRkNfTUlOX1ZNSUQsIExQRkNfTUFYX1ZNSUQs
Cj4gKwkgICAgICJNYXhpbXVtIG51bWJlciBvZiBWTXMgc3VwcG9ydGVkIik7Cj4gKwo+ICsvKgo+
ICsgKiBscGZjX3ZtaWRfaW5hY3Rpdml0eV90aW1lb3V0OiBJbmFjdGl2aXR5IHRpbWVvdXQgZHVy
YXRpb24gaW4gaG91cnMKPiArICogICAgICAgMCAgPSBUaW1lb3V0IGlzIGRpc2FibGVkCj4gKyAq
IFZhbHVlIHJhbmdlIGlzIFswLDI0XS4KPiArICovCj4gK0xQRkNfQVRUUl9SVyh2bWlkX2luYWN0
aXZpdHlfdGltZW91dCwgNCwgMCwgMjQsCj4gKwkgICAgICJJbmFjdGl2aXR5IHRpbWVvdXQgaW4g
aG91cnMiKTsKPiArCj4gKy8qCj4gKyAqIGxwZmNfdm1pZF9hcHBfaGVhZGVyOiBFbmFibGUgQXBw
IEhlYWRlciBWTUlEIHN1cHBvcnQKPiArICogICAgICAgMCAgPSBTdXBwb3J0IGlzIGRpc2FibGVk
IChkZWZhdWx0KQo+ICsgKiAgICAgICAxICA9IFN1cHBvcnQgaXMgZW5hYmxlZAo+ICsgKiBWYWx1
ZSByYW5nZSBpcyBbMCwxXS4KPiArICovCj4gK0xQRkNfQVRUUl9SVyh2bWlkX2FwcF9oZWFkZXIs
IExQRkNfVk1JRF9BUFBfSEVBREVSX0RJU0FCTEUsCj4gKwkgICAgIExQRkNfVk1JRF9BUFBfSEVB
REVSX0RJU0FCTEUsIExQRkNfVk1JRF9BUFBfSEVBREVSX0VOQUJMRSwKPiArCSAgICAgIkVuYWJs
ZSBBcHAgSGVhZGVyIFZNSUQgc3VwcG9ydCIpOwo+ICsKPiArLyoKPiArICogbHBmY192bWlkX3By
aW9yaXR5X3RhZ2dpbmc6IEVuYWJsZSBQcmlvcml0eSBUYWdnaW5nIFZNSUQgc3VwcG9ydAo+ICsg
KiAgICAgICAwICA9IFN1cHBvcnQgaXMgZGlzYWJsZWQgKGRlZmF1bHQpCj4gKyAqICAgICAgIDEg
ID0gU3VwcG9ydCBpcyBlbmFibGVkCj4gKyAqIFZhbHVlIHJhbmdlIGlzIFswLDFdLi4KPiArICov
Cj4gK0xQRkNfQVRUUl9SVyh2bWlkX3ByaW9yaXR5X3RhZ2dpbmcsIExQRkNfVk1JRF9QUklPX1RB
R19ESVNBQkxFLAo+ICsJICAgICBMUEZDX1ZNSURfUFJJT19UQUdfRElTQUJMRSwKPiArCSAgICAg
TFBGQ19WTUlEX1BSSU9fVEFHX0FMTF9UQVJHRVRTLAo+ICsJICAgICAiRW5hYmxlIFByaW9yaXR5
IFRhZ2dpbmcgVk1JRCBzdXBwb3J0Iik7Cj4gKwo+ICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmxwZmNfaGJhX2F0dHJzW10gPSB7Cj4gICAJJmRldl9hdHRyX252bWVfaW5mbywKPiAgIAkmZGV2
X2F0dHJfc2NzaV9zdGF0LAo+IEBAIC02MjY4LDYgKzYzMDYsMTAgQEAgc3RydWN0IGRldmljZV9h
dHRyaWJ1dGUgKmxwZmNfaGJhX2F0dHJzW10gPSB7Cj4gICAJJmRldl9hdHRyX2xwZmNfZW5hYmxl
X2JiY3IsCj4gICAJJmRldl9hdHRyX2xwZmNfZW5hYmxlX2RwcCwKPiAgIAkmZGV2X2F0dHJfbHBm
Y19lbmFibGVfbWksCj4gKwkmZGV2X2F0dHJfbHBmY19tYXhfdm1pZCwKPiArCSZkZXZfYXR0cl9s
cGZjX3ZtaWRfaW5hY3Rpdml0eV90aW1lb3V0LAo+ICsJJmRldl9hdHRyX2xwZmNfdm1pZF9hcHBf
aGVhZGVyLAo+ICsJJmRldl9hdHRyX2xwZmNfdm1pZF9wcmlvcml0eV90YWdnaW5nLAo+ICAgCU5V
TEwsCj4gICB9Owo+ICAgCj4gQEAgLTczMjcsNiArNzM2OSwxMSBAQCBscGZjX2dldF9jZmdwYXJh
bShzdHJ1Y3QgbHBmY19oYmEgKnBoYmEpCj4gICAJbHBmY19lbmFibGVfaGJhX2hlYXJ0YmVhdF9p
bml0KHBoYmEsIGxwZmNfZW5hYmxlX2hiYV9oZWFydGJlYXQpOwo+ICAgCj4gICAJbHBmY19FbmFi
bGVYTGFuZV9pbml0KHBoYmEsIGxwZmNfRW5hYmxlWExhbmUpOwo+ICsJLyogVk1JRCBJbml0cyAq
Lwo+ICsJbHBmY19tYXhfdm1pZF9pbml0KHBoYmEsIGxwZmNfbWF4X3ZtaWQpOwo+ICsJbHBmY192
bWlkX2luYWN0aXZpdHlfdGltZW91dF9pbml0KHBoYmEsIGxwZmNfdm1pZF9pbmFjdGl2aXR5X3Rp
bWVvdXQpOwo+ICsJbHBmY192bWlkX2FwcF9oZWFkZXJfaW5pdChwaGJhLCBscGZjX3ZtaWRfYXBw
X2hlYWRlcik7Cj4gKwlscGZjX3ZtaWRfcHJpb3JpdHlfdGFnZ2luZ19pbml0KHBoYmEsIGxwZmNf
dm1pZF9wcmlvcml0eV90YWdnaW5nKTsKPiAgIAlpZiAocGhiYS0+c2xpX3JldiAhPSBMUEZDX1NM
SV9SRVY0KQo+ICAgCQlwaGJhLT5jZmdfRW5hYmxlWExhbmUgPSAwOwo+ICAgCWxwZmNfWExhbmVQ
cmlvcml0eV9pbml0KHBoYmEsIGxwZmNfWExhbmVQcmlvcml0eSk7Cj4gClJldmlld2VkLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
