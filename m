Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE68C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A27D2075E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTi6WNLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A27D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jGnySg0bpDcR6sSgUHEgnWVZoZyufkwPgEGBEyOluH4=; b=KTi6WNLzB5HDeIZb6m+saI5NN
	vcEorzQzRl0XGqHU7ki6tiULMtsyP3h1jp57cJOCPSQziCU0L7SWzgw3OE7T9VEKhuUGyRh/NljSm
	SK3UPQXAwVyQ7yv3ILYNR/HRwPhIVGC8OuAVS+gV9aP3pqa+xZFvBvG7AYs0WR/hA44083WTWIr2t
	vdSAfLG8k3IWDmOkuefv7paclKkQhgIRbf9m6x64X0NdDjZvS6Dvlm6rve2jtsdT8NHmm3G4vrepJ
	yBRB7c/0GcjejOkbj992JbR2XqDhE+JzYMwbMUMMGfDf00crj40AS1+HrSBAzs3pC2NouwgJIvSCm
	y6WbP+RJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dyN-0003Ge-J6; Thu, 20 Aug 2020 06:22:51 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dyF-00039a-3z
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:22:48 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C82A776E5115F68AF5E8;
 Thu, 20 Aug 2020 14:22:34 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 20 Aug 2020 14:22:33 +0800
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a95ebc4b-8b9f-27bc-f64f-efebc2eb7f78@huawei.com>
Date: Thu, 20 Aug 2020 14:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_022243_451052_E9D571CC 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvMjAgMTI6MzMsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IG52bWVfcmV2
YWxpZGF0ZV9kaXNrIHRyYW5zbGF0ZSByZXR1cm4gZXJyb3IgdG8gMCBpZiBpdCBpcyBub3QgYSBm
YXRhbAo+PiBlcnJvciwgdGh1cyBhdm9pZCBmYWxzZSByZW1vdmUgbmFtZXNwYWNlLiBJZiByZXR1
cm4gZXJyb3IgbGVzcyB0aGFuIDAsCj4+IG5vdyBvbmx5IEVOT01FTSBiZSB0cmFuc2xhdGVkIHRv
IDAsIGJ1dCBvdGhlciBlcnJvciBleGNlcHQgRU5PREVWLAo+PiBzdWNoIGFzIEVBR0FJTiBvciBF
QlVTWSBldGMsIGFsc28gbmVlZCB0cmFuc2xhdGUgdG8gMC4KPj4gQW5vdGhlciByZWFzb24gZm9y
IGltcHJvdmluZyB0aGUgZXJyb3IgdHJhbnNsYXRpb246IElmIHJlcXVlc3QgdGltZW91dAo+PiB3
aGVuIGNvbm5lY3QsIF9fbnZtZV9zdWJtaXRfc3luY19jbWQgd2lsbCByZXR1cm4KPj4gTlZNRV9T
Q19IT1NUX0FCT1JURURfQ01EKD4wKS4gQXQgdGhpcyB0aW1lLCBzaG91bGQgdGVybWluYXRlIHRo
ZQo+PiBjb25uZWN0IHByb2Nlc3MsIGJ1dCBmYWxzZWx5IGNvbnRpbnVlIHRoZSBjb25uZWN0IHBy
b2Nlc3MsCj4+IHRoaXMgbWF5IGNhdXNlIGRlYWRsb2NrLiBNYW55IGZ1bmN0aW9ucyB3aGljaCBj
YWxsCj4+IF9fbnZtZV9zdWJtaXRfc3luY19jbWQgdHJlYXQgZXJyb3IgY29kZSg+IDApIGFzIHRh
cmdldCBub3Qgc3VwcG9ydCBhbmQKPj4gY29udGludWUsIGJ1dCBOVk1FX1NDX0hPU1RfQUJPUlRF
RF9DTUQgYW5kIE5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SIGJvdGgKPj4gYXJlIGNhbmNsZWQgaW8g
YnkgaG9zdCwgdG8gZml4IHRoaXMgYnVnLCB3ZSBuZWVkIHNldCB0aGUgZmxhZzoKPj4gTlZNRV9S
RVFfQ0FOQ0VMTEVELCB0aHVzIF9fbnZtZV9zdWJtaXRfc3luY19jbWQgd2lsbCB0cmFuc2xhdGUg
cmV0dXJuCj4+IGVycm9yIHRvIElOVFIuIFRoaXMgaXMgY29uZmxpY3Qgd2l0aCBlcnJvciB0cmFu
c2xhdGlvbiBvZgo+PiBudm1lX3JldmFsaWRhdGVfZGlzaywgbWF5IGNhdXNlIGZhbHNlIHJlbW92
ZSBuYW1lc3BhY2UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVh
d2VpLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDYgKysrLS0t
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKPj4gaW5kZXggODhjZmYzMDlkOGU0Li40M2FjOGExYWQ2NWQgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gQEAgLTIxMzAsMTAgKzIxMzAsMTAgQEAgc3RhdGljIGludCBfbnZtZV9yZXZh
bGlkYXRlX2Rpc2soc3RydWN0IGdlbmRpc2sgKmRpc2spCj4+IMKgwqDCoMKgwqDCoCAqIE9ubHkg
ZmFpbCB0aGUgZnVuY3Rpb24gaWYgd2UgZ290IGEgZmF0YWwgZXJyb3IgYmFjayBmcm9tIHRoZQo+
PiDCoMKgwqDCoMKgwqAgKiBkZXZpY2UsIG90aGVyd2lzZSBpZ25vcmUgdGhlIGVycm9yIGFuZCBq
dXN0IG1vdmUgb24uCj4+IMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgIGlmIChyZXQgPT0gLUVO
T01FTSB8fCAocmV0ID4gMCAmJiAhKHJldCAmIE5WTUVfU0NfRE5SKSkpCj4+IC3CoMKgwqDCoMKg
wqDCoCByZXQgPSAwOwo+PiAtwqDCoMKgIGVsc2UgaWYgKHJldCA+IDApCj4+ICvCoMKgwqAgaWYg
KHJldCA+IDAgJiYgKHJldCAmIE5WTUVfU0NfRE5SKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IGJsa19zdGF0dXNfdG9fZXJybm8obnZtZV9lcnJvcl9zdGF0dXMocmV0KSk7Cj4+ICvCoMKg
wqAgZWxzZSBpZiAocmV0ICE9IC1FTk9ERVYpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAwOwo+
PiDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gCj4gV2UgcmVhbGx5IG5lZWQgdG8gdGFrZSBhIHN0
ZXAgYmFjayBoZXJlLCBJIHJlYWxseSBkb24ndCBsaWtlIGhvdwo+IHdlIGFyZSBncm93aW5nIGlt
cGxpY2l0IGFzc3VtcHRpb25zIG9uIGhvdyBzdGF0dXNlcyBhcmUgaW50ZXJwcmV0ZWQuCmFncmVl
Lgo+IAo+IFdoeSBkb24ndCB3ZSByZW1vdmUgdGhlIC1FTk9ERVYgZXJyb3IgcHJvcGFnYXRpb24g
YmFjayBhbmQgaW5zdGVhZAo+IHRha2UgY2FyZSBvZiBpdCBpbiB0aGUgc3BlY2lmaWMgY2FsbC1z
aXRlcyB3aGVyZSB3ZSB3YW50IHRvIGlnbm9yZQo+IGVycm9ycyB3aXRoIHByb3BlciBxdWlya3M/
CgpNYXliZSB3ZSBjYW4gZG8gbGlrZSB0aGlzLgotLS0KICBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCAxNSArKysrLS0tLS0tLS0tLS0KICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggODhjZmYzMDlkOGU0Li5kYzAyMjA4ZmY2
NTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKQEAgLTIxMDQsNyArMjEwNCw3IEBAIHN0YXRpYyBpbnQgX252bWVfcmV2
YWxpZGF0ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQoKICAJcmV0ID0gbnZtZV9pZGVudGlm
eV9ucyhjdHJsLCBucy0+aGVhZC0+bnNfaWQsICZpZCk7CiAgCWlmIChyZXQpCi0JCWdvdG8gb3V0
OworCQlyZXR1cm4gMDsKCiAgCWlmIChpZC0+bmNhcCA9PSAwKSB7CiAgCQlyZXQgPSAtRU5PREVW
OwpAQCAtMjExMiw4ICsyMTEyLDEwIEBAIHN0YXRpYyBpbnQgX252bWVfcmV2YWxpZGF0ZV9kaXNr
KHN0cnVjdCBnZW5kaXNrICpkaXNrKQogIAl9CgogIAlyZXQgPSBudm1lX3JlcG9ydF9uc19pZHMo
Y3RybCwgbnMtPmhlYWQtPm5zX2lkLCBpZCwgJmlkcyk7Ci0JaWYgKHJldCkKKwlpZiAocmV0KSB7
CisJCXJldCA9IDA7CiAgCQlnb3RvIGZyZWVfaWQ7CisJfQoKICAJaWYgKCFudm1lX25zX2lkc19l
cXVhbCgmbnMtPmhlYWQtPmlkcywgJmlkcykpIHsKICAJCWRldl9lcnIoY3RybC0+ZGV2aWNlLApA
QCAtMjEyNSwxNSArMjEyNyw2IEBAIHN0YXRpYyBpbnQgX252bWVfcmV2YWxpZGF0ZV9kaXNrKHN0
cnVjdCBnZW5kaXNrICpkaXNrKQogIAlyZXQgPSBfX252bWVfcmV2YWxpZGF0ZV9kaXNrKGRpc2ss
IGlkKTsKICBmcmVlX2lkOgogIAlrZnJlZShpZCk7Ci1vdXQ6Ci0JLyoKLQkgKiBPbmx5IGZhaWwg
dGhlIGZ1bmN0aW9uIGlmIHdlIGdvdCBhIGZhdGFsIGVycm9yIGJhY2sgZnJvbSB0aGUKLQkgKiBk
ZXZpY2UsIG90aGVyd2lzZSBpZ25vcmUgdGhlIGVycm9yIGFuZCBqdXN0IG1vdmUgb24uCi0JICov
Ci0JaWYgKHJldCA9PSAtRU5PTUVNIHx8IChyZXQgPiAwICYmICEocmV0ICYgTlZNRV9TQ19ETlIp
KSkKLQkJcmV0ID0gMDsKLQllbHNlIGlmIChyZXQgPiAwKQotCQlyZXQgPSBibGtfc3RhdHVzX3Rv
X2Vycm5vKG52bWVfZXJyb3Jfc3RhdHVzKHJldCkpOwogIAlyZXR1cm4gcmV0OwogIH0KCi0tIAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
