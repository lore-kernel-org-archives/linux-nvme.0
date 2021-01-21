Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D4C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:59:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72B7239D0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72B7239D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v8yreiZI0YPUjN/H5sT7PekvzGYQVwoP3oCEer8W5zU=; b=qYQhLmXi8gS3NVNBUuORX4S2e
	45rAQvQJJZtQ7VeVHfzv1gWlsf2qcePyO2FejsZUwas0avNbmQVqvmhI5N8s0bcI/bta0PDZJY/M5
	pVzMwwnBONFd6WybDEeo4h+7YGrFOi9t8GGBx5AFFNgF1/tNFLIZhrDZeDLy2FS/V3uQZDN1JR3Sj
	KxaYrPyf2H5GaayFu7dtICVzlUEMXCMubAtVNmP0S9YPfHg7iJ/c1pRhyaHzu6DSaxyZKCNpBmk+y
	nCRrg9/PyRqyjRhofqmc6aNj8UhrnwCD4Vi5tHMD0tESsh3dIbYUgLpp99a8tVjhtmcPFaneAwurw
	nbt6os0WQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Vng-0001UB-BV; Thu, 21 Jan 2021 08:58:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Vne-0001TM-1W
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:58:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CE63CAD0B;
 Thu, 21 Jan 2021 08:58:40 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
Date: Thu, 21 Jan 2021 09:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121070330.19701-4-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_035842_185001_45A938ED 
X-CRM114-Status: GOOD (  23.75  )
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
Cc: axboe@kernel.dk, axboe@fb.com, sagi@grimberg.me,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yMS8yMSA4OjAzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gV2hlbiByZWNvbm5lY3QsIHRo
ZSByZXF1ZXN0IG1heSBiZSBjb21wbGV0ZWQgd2l0aCBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUgo+
IGluIG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kLiBUaGUgc3RhdGUgb2YgcmVxdWVzdCB3aWxs
IGJlIGNoYW5nZWQgdG8KPiBNUV9SUV9JTl9GTElHSFQgYmVmb3JlIGNhbGwgbnZtZV9jb21wbGV0
ZV9ycS4gSWYgZnJlZSB0aGUgcmVxdWVzdAo+IGFzeW5jaHJvbm91c2x5IHN1Y2ggYXMgaW4gbnZt
ZV9zdWJtaXRfdXNlcl9jbWQsIGluIGV4dHJlbWUgc2NlbmFyaW8KPiB0aGUgcmVxdWVzdCBtYXkg
YmUgY29tcGxldGVkIGFnYWluIGluIHRlYXIgZG93biBwcm9jZXNzLgo+IG52bWZfZmFpbF9ub25y
ZWFkeV9jb21tYW5kIGRvIG5vdCBuZWVkIGNhbGxpbmcgYmxrX21xX3N0YXJ0X3JlcXVlc3QKPiBi
ZWZvcmUgY29tcGxldGUgdGhlIHJlcXVlc3QuIG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kIHNo
b3VsZCBzZXQKPiB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0byBNUV9SUV9DT01QTEVURSBiZWZvcmUg
Y29tcGxldGUgdGhlIHJlcXVlc3QuCj4gCgpTbyB3aGF0IHlvdSBhcmUgc2F5aW5nIGlzIHRoYXQg
dGhlcmUgaXMgYSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuCmJsa19tcV9zdGFydF9yZXF1ZXN0KCkK
YW5kCm52bWVfY29tcGxldGVfcmVxdWVzdCgpCgo+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8
bGVuZ2NoYW9AaHVhd2VpLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3Mu
YyB8IDQgKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPiBpbmRleCA3MmFjMDAxNzM1MDAuLjg3NGU0MzIwZTIx
NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPiBAQCAtNTUzLDkgKzU1Myw3IEBAIGJsa19zdGF0dXNf
dCBudm1mX2ZhaWxfbm9ucmVhZHlfY29tbWFuZChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLAo+ICAg
CSAgICAhYmxrX25vcmV0cnlfcmVxdWVzdChycSkgJiYgIShycS0+Y21kX2ZsYWdzICYgUkVRX05W
TUVfTVBBVEgpKQo+ICAgCQlyZXR1cm4gQkxLX1NUU19SRVNPVVJDRTsKPiAgIAo+IC0JbnZtZV9y
ZXEocnEpLT5zdGF0dXMgPSBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUjsKPiAtCWJsa19tcV9zdGFy
dF9yZXF1ZXN0KHJxKTsKPiAtCW52bWVfY29tcGxldGVfcnEocnEpOwo+ICsJbnZtZV9jb21wbGV0
ZV9mYWlsZWRfcmVxKHJxKTsKPiAgIAlyZXR1cm4gQkxLX1NUU19PSzsKPiAgIH0KPiAgIEVYUE9S
VF9TWU1CT0xfR1BMKG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kKTsKPiBJJ2QgcmF0aGVyIGhh
dmUgJ252bWVfY29tcGxldGVfZmFpbGVkX3JlcSgpJyBhY2NlcHQgdGhlIHN0YXR1cyBhcyAKYXJn
dW1lbnQsIGxpa2UKCm52bWVfY29tcGxldGVfZmFpbGVkX3JlcXVlc3QocnEsIE5WTUVfU0NfSE9T
VF9QQVRIX0VSUk9SKQoKdGhhdCB3YXkgaXQncyBvYnZpb3VzIHdoYXQgaXMgaGFwcGVuaW5nLCBh
bmQgdGhlIHN0YXR1cyBpc24ndCBoaWRkZW4gaW4gCnRoZSBmdW5jdGlvbi4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFn
ZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bD
vGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
