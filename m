Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B8EC63697
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:39:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989B0222B9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8gk6/H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989B0222B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2ZGbr6FYjIg3eJaa/Auawajo8bC01OYt7AwmdACIw4w=; b=u8gk6/H6zF1sC3CX541cbUHjm
	rz+gzsnvhA5+lQ+mUf1F5ievT6i9JzTpQlwAL8n2f+8XmB/GOjeoRDzHkCy8Epn+dGhMNLLM0ddqm
	aG/kR/7FHRPUw1RTiTY4DD/LGSSsBcH+uSvRMFVxjgDDd6u2DTo8j/JwRnIuI81kKbEHoUgP6CsTc
	i6kaxtlnmxXnUjoVWiH9Yuz9hcfyEiOyuaanVJp3mlp8jjaoRg60B+HneL8xVIw/zS0SE/iORt2gQ
	FFEN4BgJNgqcu6F99f8zWb3nQdW8TUIM2fpIhxP+aSQVEpDf38cOD2WSsyMkYTb4DP+Wwb0tasucj
	YFBDN4IfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZ74-0004KZ-4k; Mon, 16 Nov 2020 07:39:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZ71-0004K1-Uk
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:39:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F2C6CACEB;
 Mon, 16 Nov 2020 07:39:42 +0000 (UTC)
Subject: Re: [PATCH v4 03/19] nvme: Added a newsysfs attribute appid_store
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-4-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <06359c8f-75d2-efe6-ed46-4001a4a0f84f@suse.de>
Date: Mon, 16 Nov 2020 08:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-4-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_023944_214475_2228E3B3 
X-CRM114-Status: GOOD (  33.40  )
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
 emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gQWRkZWQgYSBuZXcgc3lzZnMg
YXR0cmlidXRlIGFwcGlkX3N0b3JlIHVuZGVyCj4gL3N5cy9jbGFzcy9mYy9mY191ZGV2X2Rldmlj
ZS8qCj4gCj4gV2l0aCB0aGlzIG5ldyBpbnRlcmZhY2UgdGhlIHVzZXIgY2FuIHNldCB0aGUgYXBw
bGljYXRpb24gaWRlbnRmaWVyCj4gaW4gIHRoZSBibGtjZyBhc3NvY2l0ZWQgd2l0aCBjZ3JvdXAg
aWQuCj4gCj4gT25jZSB0aGUgYXBwbGljYXRpb24gaWRlbnRpZmVyIGhhcyBzZXQgd2l0aCB0aGlz
IGludGVyZmFjZSBpdCBhbGxvd3MKPiBpZGVudGlmaWNhdGlvbiBvZiB0cmFmZmljIHNvdXJjZXMg
YXQgYW4gaW5kaXZpZHVhbCBjZ3JvdXAgYmFzZWQKPiBBcHBsaWNhdGlvbnMgKGV4OnZpcnR1YWwg
bWFjaGluZSAoVk0pKWxldmVsIGluIGJvdGggaG9zdCBhbmQKPiBmYWJyaWMgaW5mcmFzdHJ1Y3R1
cmUoRkMpLgo+IAo+IEJlbG93IGlzIHRoZSBpbnRlcmZhY2UgcHJvdmlkZWQgdG8gc2V0IHRoZSBh
cHBfaWQKPiAKPiBlY2hvICI8Y2dyb3VwaWQ+OjxhcHBpZD4iID4+IC9zeXMvY2xhc3MvZmMvZmNf
dWRldl9kZXZpY2UvYXBwaWRfc3RvcmUKPiBlY2hvICI0NTdFOjEwMDAwMDEwOWI1MjFkMjciID4+
IC9zeXMvY2xhc3MvZmMvZmNfdWRldl9kZXZpY2UvYXBwaWRfc3RvcmUKPiAKPiBTaWduZWQtb2Zm
LWJ5OiBNdW5lZW5kcmEgPG11bmVlbmRyYS5rdW1hckBicm9hZGNvbS5jb20+Cj4gCj4gLS0tCj4g
djQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6Cj4gUmVwbGFjZWQgYmxrY2dfc2V0X2FwcF9pZGVudGlm
aWVyIGZ1bmN0aW9uIHdpdGggYmxrY2dfc2V0X2ZjX2FwcGlkCj4gCj4gdjI6Cj4gTmV3IFBhdGNo
Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgNzMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9m
Yy5jIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+IGluZGV4IGVhZTQzYmI0NDRlMC4uNmQ2Y2Mw
NmZkNTRhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9mYy5jCj4gQEAgLTksNyArOSw3IEBACj4gICAjaW5jbHVkZSA8dWFwaS9z
Y3NpL2ZjL2ZjX2Vscy5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Cj4gICAjaW5jbHVk
ZSA8bGludXgvb3ZlcmZsb3cuaD4KPiAtCj4gKyNpbmNsdWRlIDxsaW51eC9ibGstY2dyb3VwLmg+
Cj4gICAjaW5jbHVkZSAibnZtZS5oIgo+ICAgI2luY2x1ZGUgImZhYnJpY3MuaCIKPiAgICNpbmNs
dWRlIDxsaW51eC9udm1lLWZjLWRyaXZlci5oPgo+IEBAIC0zNzY4LDEwICszNzY4LDgxIEBAIHN0
YXRpYyBzc2l6ZV90IG52bWVfZmNfbnZtZV9kaXNjb3Zlcnlfc3RvcmUoc3RydWN0IGRldmljZSAq
ZGV2LAo+ICAgCj4gICAJcmV0dXJuIGNvdW50Owo+ICAgfQo+ICsKPiArLypwYXJzZSB0aGUgQ2dy
b3VwIGlkIGZyb20gYSBidWYgYW5kIHJldHVybnMgdGhlIGxlbmd0aCBvZiBjZ3JwaWQqLwo+ICtz
dGF0aWMgaW50IGZjX3BhcnNlX2NncnBpZChjb25zdCBjaGFyICpidWYsIHU2NCAqaWQpCj4gK3sK
PiArCWNoYXIgY2dycF9pZFsxNisxXTsKPiArCWludCBjZ3JwaWRfbGVuLCBqOwo+ICsKPiArCW1l
bXNldChjZ3JwX2lkLCAweDAsIHNpemVvZihjZ3JwX2lkKSk7Cj4gKwlmb3IgKGNncnBpZF9sZW4g
PSAwLCBqID0gMDsgY2dycGlkX2xlbiA8IDE3OyBjZ3JwaWRfbGVuKyspIHsKPiArCQlpZiAoYnVm
W2NncnBpZF9sZW5dICE9ICc6JykKPiArCQkJY2dycF9pZFtjZ3JwaWRfbGVuXSA9IGJ1ZltjZ3Jw
aWRfbGVuXTsKPiArCQllbHNlIHsKPiArCQkJaiA9IDE7Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiAr
CX0KPiArCWlmICghaikKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCWlmIChrc3RydG91NjQoY2dy
cF9pZCwgMTYsIGlkKSA8IDApCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwlyZXR1cm4gY2dycGlk
X2xlbjsKPiArfQo+ICsKPiArLyoKPiArICogZmNfdXBkYXRlX2FwcGlkIDpwYXJzZXMgYW5kIHVw
ZGF0ZXMgdGhlIGFwcGlkIGluIHRoZSBibGtjZyBhc3NvY2lhdGVkIHdpdGgKPiArICogY2dyb3Vw
aWQuCj4gKyAqIEBidWY6IGJ1ZiBjb250YWlucyBib3RoIGNncnBpZCBhbmQgYXBwaWQgaW5mbwo+
ICsgKiBAY291bnQ6IHNpemUgb2YgdGhlIGJ1ZmZlcgo+ICsgKi8KPiArc3RhdGljIGludCBmY191
cGRhdGVfYXBwaWQoY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCj4gK3sKPiArCXU2NCBj
Z3JwX2lkOwo+ICsJaW50IGFwcGlkX2xlbiA9IDA7Cj4gKwlpbnQgY2dycGlkX2xlbiA9IDA7Cj4g
KwljaGFyIGFwcF9pZFtBUFBJRF9MRU5dOwo+ICsJaW50IHJldCA9IDA7Cj4gKwo+ICsJaWYgKGJ1
Zltjb3VudC0xXSA9PSAnXG4nKQo+ICsJCWNvdW50LS07Cj4gKwo+ICsJaWYgKChjb3VudCA+ICgx
NisxK0FQUElEX0xFTikpIHx8ICghc3RyY2hyKGJ1ZiwgJzonKSkpCj4gKwkJcmV0dXJuIC1FSU5W
QUw7Cj4gKwo+ICsJY2dycGlkX2xlbiA9IGZjX3BhcnNlX2NncnBpZChidWYsICZjZ3JwX2lkKTsK
PiArCWlmIChjZ3JwaWRfbGVuIDwgMCkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCS8qYXBwaWQg
bGVuIGlzIGNvdW50IC0gY2dycGlkX2xlbiAtMSAoOiArIFxuKSAqLwo+ICsJYXBwaWRfbGVuID0g
Y291bnQgLSBjZ3JwaWRfbGVuIC0gMTsKPiArCWlmIChhcHBpZF9sZW4gPiBBUFBJRF9MRU4pCj4g
KwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsJbWVtc2V0KGFwcF9pZCwgMHgwLCBzaXplb2YoYXBw
X2lkKSk7Cj4gKwltZW1jcHkoYXBwX2lkLCAmYnVmW2NncnBpZF9sZW4rMV0sIGFwcGlkX2xlbik7
Cj4gKwlyZXQgPSBibGtjZ19zZXRfYXBwX2lkZW50aWZpZXIoYXBwX2lkLCBjZ3JwX2lkLCBzaXpl
b2YoYXBwX2lkKSk7Cj4gKwlpZiAocmV0IDwgMCkKPiArCQlyZXR1cm4gcmV0Owo+ICsJcmV0dXJu
IGNvdW50Owo+ICt9Cj4gKwpSaWdodC4gU28geW91IF9kb18gYWxsb3cgZm9yIGFuIGFyYml0cmFy
eSBsZW5ndGggZm9yIHRoZSBhcHBfaWQuCldoaWNoIG1lYW5zIHRoZSBwcmV2aW91cyBwYXRjaCBo
YWQgYSBidWcsIGFuZCB5b3UgbmVlZCB0byBhbGxvY2F0ZSAKQVBQSURfTEVOICsgMSBmb3IgdGhl
ICdhcHBfaWQnIGVudHJ5LgoKPiArc3RhdGljIHNzaXplX3QgZmNfYXBwaWRfc3RvcmUoc3RydWN0
IGRldmljZSAqZGV2LAo+ICsJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBj
aGFyICpidWYsIHNpemVfdCBjb3VudCkKPiArewo+ICsJaW50IHJldCAgPSAwOwo+ICsKPiArCXJl
dCA9IGZjX3VwZGF0ZV9hcHBpZChidWYsIGNvdW50KTsKPiArCWlmIChyZXQgPCAwKQo+ICsJCXJl
dHVybiAtRUlOVkFMOwo+ICsJcmV0dXJuIGNvdW50Owo+ICt9Cj4gICBzdGF0aWMgREVWSUNFX0FU
VFIobnZtZV9kaXNjb3ZlcnksIDAyMDAsIE5VTEwsIG52bWVfZmNfbnZtZV9kaXNjb3Zlcnlfc3Rv
cmUpOwo+ICtzdGF0aWMgREVWSUNFX0FUVFIoYXBwaWRfc3RvcmUsIDAyMDAsIE5VTEwsIGZjX2Fw
cGlkX3N0b3JlKTsKPiAgIAo+ICAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm52bWVfZmNfYXR0
cnNbXSA9IHsKPiAgIAkmZGV2X2F0dHJfbnZtZV9kaXNjb3ZlcnkuYXR0ciwKPiArCSZkZXZfYXR0
cl9hcHBpZF9zdG9yZS5hdHRyLAo+ICAgCU5VTEwKPiAgIH07Cj4gICAKPiAKClJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
