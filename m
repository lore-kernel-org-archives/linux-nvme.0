Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D601C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:56:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818E2651D1
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818E2651D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hiKyLqqsVGrilva8WjAGOxZmUCiXYr6IiLHVqiRExf0=; b=H0NscFo5bmnzHft+JspRnmeTA
	1fWwR05nv9R+LhdD3lbMNq/buDx48Q/8ciSCdOT7FYBBcwqaQqHYPGskdLW3nOl23ny9p8GC9dXxk
	RTB+LJQgM1OMoaFRvuP016HJT7EHpdWEkn8Fl+RKeOfIljh3+hoa1IiyDXD0YAT6AyBGzuHE/ZgzT
	dB+ypB4kagyKpvfF0BHBrqDC599fIjk1SXtAn2yHG6M8mJdrwg3nJZdOHddoTUo0lfN4+d+QzsP1z
	WSWEYRqfmHwySDVBHUqEBPmqtpHFhBV3AjlX6IKOiRNG6G3aIooLYv5d88c7LEQZmCfjbh/fOApVa
	DhfbunTfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJGMa-0001tS-4h; Mon, 08 Mar 2021 13:56:01 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJGLC-000118-C8
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 13:54:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A7C76AD3B;
 Mon,  8 Mar 2021 13:54:33 +0000 (UTC)
Subject: Re: [PATCH 2/3] nvme: sanitize KATO setting
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-3-hare@suse.de>
 <c2fb8d9d-6dca-6666-d7a5-ad3f43c815aa@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a23fa0a4-eb55-c141-c842-ff0536899ed3@suse.de>
Date: Mon, 8 Mar 2021 14:54:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c2fb8d9d-6dca-6666-d7a5-ad3f43c815aa@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_135435_130208_9037D1B4 
X-CRM114-Status: GOOD (  19.49  )
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

T24gMy84LzIxIDI6MTEgUE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPiAKPiBPbiAzLzIvMjAyMSAx
MToyNiBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBBY2NvcmRpbmcgdG8gdGhlIE5WTWUg
YmFzZSBzcGVjIHRoZSBLQVRPIGNvbW1hbmRzIHNob3VsZCBiZSBzZW50Cj4+IGF0IGhhbGYgb2Yg
dGhlIEtBVE8gaW50ZXJ2YWwsIHRvIHByb3Blcmx5IGFjY291bnQgZm9yIHJvdW5kLXRyaXAKPj4g
dGltZXMuCj4+IEFzIHdlIG5vdyB3aWxsIG9ubHkgZXZlciBzZW5kIG9uZSBLQVRPIGNvbW1hbmQg
cGVyIGNvbm5lY3Rpb24gd2UKPj4gY2FuIGVhc2lseSB1c2UgdGhlIHJlY29tbWVuZGVkIHZhbHVl
cy4KPj4gVGhpcyBhbHNvIGZpeGVzIGEgcG90ZW50aWFsIGlzc3VlIHdoZXJlIHRoZSByZXF1ZXN0
IHRpbWVvdXQgZm9yCj4+IHRoZSBLQVRPIGNvbW1hbmQgZG9lcyBub3QgbWF0Y2ggdGhlIHZhbHVl
IGluIHRoZSBjb25uZWN0IGNvbW1hbmQsCj4+IHdoaWNoIG1pZ2h0IGJlIGNhdXNpbmcgc3B1cmlv
dXMgY29ubmVjdGlvbiBkcm9wcyBmcm9tIHRoZSB0YXJnZXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jwqDCoMKgIHwgOSArKysrKystLS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3Qv
ZmFicmljcy5jIHwgMiArLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9udm1lLmjCoMKgwqAgfCA5
ICsrKysrKysrLQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gaW5kZXggZjg5MGIzMTA0OTllLi42ZDA5NmQ0MWE4
MmYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gQEAgLTEyMjMsNyArMTIyMyw4IEBAIHN0YXRpYyB2b2lk
IG52bWVfa2VlcF9hbGl2ZV9lbmRfaW8oc3RydWN0Cj4+IHJlcXVlc3QgKnJxLCBibGtfc3RhdHVz
X3Qgc3RhdHVzKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnRrYSA9IHRydWU7Cj4+IMKgwqDC
oMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY3RybC0+bG9jaywgZmxhZ3MpOwo+PiDCoMKg
wqDCoMKgIGlmIChzdGFydGthKQo+PiAtwqDCoMKgwqDCoMKgwqAgcXVldWVfZGVsYXllZF93b3Jr
KG52bWVfd3EsICZjdHJsLT5rYV93b3JrLCBjdHJsLT5rYXRvICogSFopOwo+PiArwqDCoMKgwqDC
oMKgwqAgcXVldWVfZGVsYXllZF93b3JrKG52bWVfd3EsICZjdHJsLT5rYV93b3JrLAo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5WTUVfS0FUT19ERUxBWShjdHJsLT5r
YXRvKSAqIEhaKTsKPj4gwqAgfQo+PiDCoCDCoCBzdGF0aWMgaW50IG52bWVfa2VlcF9hbGl2ZShz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiBAQCAtMTI1OCw3ICsxMjU5LDggQEAgc3RhdGljIHZv
aWQgbnZtZV9rZWVwX2FsaXZlX3dvcmsoc3RydWN0Cj4+IHdvcmtfc3RydWN0ICp3b3JrKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZGV2X2RiZyhjdHJsLT5kZXZpY2UsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJyZXNjaGVkdWxlIHRyYWZmaWMgYmFzZWQga2VlcC1hbGl2ZSB0aW1lclxu
Iik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5jb21wX3NlZW4gPSBmYWxzZTsKPj4gLcKg
wqDCoMKgwqDCoMKgIHF1ZXVlX2RlbGF5ZWRfd29yayhudm1lX3dxLCAmY3RybC0+a2Ffd29yaywg
Y3RybC0+a2F0byAqIEhaKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlbGF5ZWRfd29yayhu
dm1lX3dxLCAmY3RybC0+a2Ffd29yaywKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBOVk1FX0tBVE9fREVMQVkoY3RybC0+a2F0bykgKiBIWik7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCBAQCAtMTI3NSw3ICsxMjc3LDgg
QEAgc3RhdGljIHZvaWQgbnZtZV9zdGFydF9rZWVwX2FsaXZlKHN0cnVjdAo+PiBudm1lX2N0cmwg
KmN0cmwpCj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGN0cmwtPmthdG8gPT0gMCkpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IMKgIC3CoMKgwqAgcXVldWVfZGVsYXllZF93b3Jr
KG52bWVfd3EsICZjdHJsLT5rYV93b3JrLCBjdHJsLT5rYXRvICogSFopOwo+PiArwqDCoMKgIHF1
ZXVlX2RlbGF5ZWRfd29yayhudm1lX3dxLCAmY3RybC0+a2Ffd29yaywKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTlZNRV9LQVRPX0RFTEFZKGN0cmwtPmthdG8pICogSFopOwo+PiDC
oCB9Cj4+IMKgIMKgIHZvaWQgbnZtZV9zdG9wX2tlZXBfYWxpdmUoc3RydWN0IG52bWVfY3RybCAq
Y3RybCkKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiBpbmRleCA1ZGZkODA2ZmMyZDIuLmRiYTMyZTM5YWZi
ZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiBAQCAtMzgyLDcgKzM4Miw3IEBAIGludCBudm1m
X2Nvbm5lY3RfYWRtaW5fcXVldWUoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPj4gwqDCoMKgwqDC
oMKgICogYW5kIGFkZCBhIGdyYWNlIHBlcmlvZCBmb3IgY29udHJvbGxlciBrYXRvIGVuZm9yY2Vt
ZW50Cj4+IMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDCoMKgIGNtZC5jb25uZWN0LmthdG8gPSBj
dHJsLT5rYXRvID8KPj4gLcKgwqDCoMKgwqDCoMKgIGNwdV90b19sZTMyKChjdHJsLT5rYXRvICsg
TlZNRV9LQVRPX0dSQUNFKSAqIDEwMDApIDogMDsKPj4gK8KgwqDCoMKgwqDCoMKgIGNwdV90b19s
ZTMyKGN0cmwtPmthdG8gKiAxMDAwKSA6IDA7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGN0cmwtPm9w
dHMtPmRpc2FibGVfc3FmbG93KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY21kLmNvbm5lY3QuY2F0
dHIgfD0gTlZNRV9DT05ORUNUX0RJU0FCTEVfU1FGTE9XOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCj4+IGluZGV4IDIz
NzExZjZiN2QxMy4uOTEyODMwMzg5OTk3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCj4+IEBAIC0yNyw3ICsy
NywxNCBAQCBleHRlcm4gdW5zaWduZWQgaW50IGFkbWluX3RpbWVvdXQ7Cj4+IMKgICNkZWZpbmUg
TlZNRV9BRE1JTl9USU1FT1VUwqDCoMKgIChhZG1pbl90aW1lb3V0ICogSFopCj4+IMKgIMKgICNk
ZWZpbmUgTlZNRV9ERUZBVUxUX0tBVE/CoMKgwqAgNQo+PiAtI2RlZmluZSBOVk1FX0tBVE9fR1JB
Q0XCoMKgwqDCoMKgwqDCoCAxMAo+PiArCj4+ICsvKgo+PiArICogVGhlIHJlY29tbWVuZGVkIGZy
ZXF1ZW5jeSBmb3IgS0FUTyBjb21tYW5kcwo+PiArICogYWNjb3JkaW5nIHRvIE5WTWUgMS40IHNl
Y3Rpb24gNy4xMi4xOgo+PiArICogVGhlIGhvc3Qgc2hvdWxkIHNlbmQgS2VlcCBBbGl2ZSBjb21t
YW5kcyBhdCBoYWxmIG9mIHRoZQo+PiArICogS2VlcCBBbGl2ZSBUaW1lb3V0IGFjY291bnRpbmcg
Zm9yIHRyYW5zcG9ydCByb3VuZHRyaXAgdGltZXMgWy4uXS4KPj4gKyAqLwo+PiArI2RlZmluZSBO
Vk1FX0tBVE9fREVMQVkoaynCoMKgwqAgKChrKSA+PiAxKQo+IAo+IHdoYXQgd2lsbCBoYXBwZW4g
aW4gY2FzZSBrID09IDEgPwo+IAo+IApIby1odW0uIEdvb2QgcG9pbnQuCldpbGwgZml4IGl0IHVw
LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdG
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
