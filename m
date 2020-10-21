Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A4C56201
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 06:52:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665542227F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 06:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnsdLHSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665542227F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wXmti+E1ugvgIanr2VCE62xbI+gPqO0HFF8K4qplHX0=; b=NnsdLHSlYJM+TzH+WUQrvZktj
	l0C/zHmseNnYbZVH2dwKXxi6ZVFf9ibw717rLaI0qsEVItULIYF+0B7zs1zAazEjai4yPk/F9Mgca
	xnQZmOdW+Rsennzh54rDwj/1z9Uov2HWMTyO7VljyB0i5smDInKGxDXRs/VPcpPLkn0y6EIiH7qGa
	4S3w6YoL5YEzTIr8CETIJjyXcuJrbckYQpO+rHUkyGpzqBHLuAkFldflfpGfGMHckTsCUUFJ0Y6vs
	8i5KyExmCnv2yzjHkZtLMz1q+KDlbQP+AWGO62Zg+Ys0Jl70DCkD/RsqpbOUaBX9eHciS2FMpeZoC
	NPy8/qKCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV7yY-0004pH-PB; Wed, 21 Oct 2020 06:51:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV7yU-0004ot-MH
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 06:51:55 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 0F28934287988291CAAF;
 Wed, 21 Oct 2020 14:51:48 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 14:51:47 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 14:51:47 +0800
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20201020090808.27702-1-lengchao@huawei.com>
 <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
 <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
 <b60f34ea-86f1-ef86-8e1f-b156b7681699@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5a48d20f-e9c9-5d37-776a-1fe3b1eb79a8@huawei.com>
Date: Wed, 21 Oct 2020 14:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b60f34ea-86f1-ef86-8e1f-b156b7681699@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_025155_141623_8B413201 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzEwLzIxIDEyOjU5LCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+IEF2b2lk
IHJhY2UgYmV0d2VlbiB0aW1lIG91dCBhbmQgdGVhciBkb3duIGZvciByZG1hIGFuZCB0Y3AuCj4+
Pgo+Pj4gVGhpcyBwYXRjaHNldCBvdmVyYWxsIGxvb2tzIGdvb2QsIGJ1dCB3ZSBzdGlsbCBuZWVk
IHRoZSBwYXRjaCB0aGF0Cj4+PiBhdm9pZHMgZG91YmxlIGNvbXBsZXRpb246Cj4+Pgo+Pj4gLS0g
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUv
aG9zdC90Y3AuYwo+Pj4gaW5kZXggNjI5YjAyNTY4NWQxLi40NjQyOGZmMGIwZmMgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvdGNwLmMKPj4+IEBAIC0yMTc1LDcgKzIxNzUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3RjcF9j
b21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IHJlcXVlc3QgKnJxKQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oCAvKiBmZW5jZSBvdGhlciBjb250ZXh0cyB0aGF0IG1heSBjb21wbGV0ZSB0aGUgY29tbWFuZCAq
Lwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZ0b190Y3BfY3RybChjdHJsKS0+dGVh
cmRvd25fbG9jayk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIG52bWVfdGNwX3N0b3BfcXVldWUoY3Ry
bCwgbnZtZV90Y3BfcXVldWVfaWQocmVxLT5xdWV1ZSkpOwo+Pj4gLcKgwqDCoMKgwqDCoCBpZiAo
IWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpIHsKPj4+ICvCoMKgwqDCoMKgwqAgaWYgKGJs
a19tcV9yZXF1ZXN0X3N0YXJ0ZWQocnEpICYmICFibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQocnEp
KSB7Cj4+IFllcywgdGhpcyBwYXRjaCBpcyBuZWVkLiBhbmQgc2FtZWx5IGZvciBudm1lX2NhbmNl
bF9yZXF1ZXN0Lgo+PiBUaGlzIHdpbGwgZml4IHRoZSByYWNlIHdpdGggYXN5bmNocm9ub3VzIGNv
bXBsZXRpb24uCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gaW5kZXggZTg1ZjYzMDRlZmQ3Li4xZTgzOGQ5NTIw
OTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gQEAgLTMzOCw3ICszMzgsNyBAQCBib29sIG52bWVfY2Fu
Y2VsX3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgdm9pZCAqZGF0YSwgYm9vbCByZXNlcnZl
ZCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAiQ2FuY2VsbGluZyBJL08gJWQiLCByZXEtPnRhZyk7Cj4+Cj4+IMKgwqDC
oMKgwqDCoMKgwqAgLyogZG9uJ3QgYWJvcnQgb25lIGNvbXBsZXRlZCByZXF1ZXN0ICovCj4+IC3C
oMKgwqDCoMKgwqAgaWYgKGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChyZXEpKQo+PiArwqDCoMKg
wqDCoMKgIGlmIChibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQocmVxKSB8fCAhYmxrX21xX3JlcXVl
c3Rfc3RhcnRlZChycSkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biB0cnVlOwo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmVxKHJlcSktPnN0YXR1cyA9IE5W
TUVfU0NfSE9TVF9BQk9SVEVEX0NNRDsKPiAKPiBUaGlzIG9uZSBpcyB1bm5lZWRlZCBiZWNhdXNl
IGJsa19tcV90YWdzZXRfYnVzeV9pdGVyIGNoZWNrcyB0aGF0IHRoZQo+IHJlcXVlc3QgaGFzIHN0
YXJ0ZWQuLi4KWWVzLCBpdCBpcyBhbHJlYWR5IGNoZWNrZWQuCj4gLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
