Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BD6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:48:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F46223C8
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F46223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DjTusZUfUuKVmkPfKC6HsRK4gHsKUqr8eNarbZRf+hE=; b=VlV5X6YLeSs4aKpbxsSf3Evf0
	o74zFxDp4Xvbifea5VtDRfFz1idhXpcO3YajsOWCrhY8qXuCUYzTihy5UL3MDfNcxtut2HjAQW7YB
	6qDs15LOIy+cpuWND+Me0EVR3HFSmiAgD9SyIO57nDKtWJcbpK8yBqy/Rg6BCi1Y4sguWhlZOK3yw
	AHi8q6DyJx0+h/nHaeZ1ouSTjXiMjv3WhamyL+YSnjkm3PD6VRGvPx4t0CidzH2G1rrxY28fmJS7B
	gWEYKEwjuYVxRWQTHOs7pnb6+CQ3Lox4+tfs8YI03BGV2Cv44HvVuGODgSD82HQVCbTvb3pP1P3+F
	x/gpUFVTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2lYZ-00037Z-4J; Fri, 22 Jan 2021 01:48:11 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2lYW-00036y-4X
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 01:48:09 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DMMZH3x9lzXtNt;
 Fri, 22 Jan 2021 09:47:03 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:48:04 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:48:03 +0800
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a100b5dd-d38b-3158-d000-b84920a4e274@huawei.com>
Date: Fri, 22 Jan 2021 09:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_204808_673680_F0D9909E 
X-CRM114-Status: GOOD (  17.15  )
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

CgpPbiAyMDIxLzEvMjEgMTY6NTgsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzIxLzIx
IDg6MDMgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4gV2hlbiByZWNvbm5lY3QsIHRoZSByZXF1ZXN0
IG1heSBiZSBjb21wbGV0ZWQgd2l0aCBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUgo+PiBpbiBudm1m
X2ZhaWxfbm9ucmVhZHlfY29tbWFuZC4gVGhlIHN0YXRlIG9mIHJlcXVlc3Qgd2lsbCBiZSBjaGFu
Z2VkIHRvCj4+IE1RX1JRX0lOX0ZMSUdIVCBiZWZvcmUgY2FsbCBudm1lX2NvbXBsZXRlX3JxLiBJ
ZiBmcmVlIHRoZSByZXF1ZXN0Cj4+IGFzeW5jaHJvbm91c2x5IHN1Y2ggYXMgaW4gbnZtZV9zdWJt
aXRfdXNlcl9jbWQsIGluIGV4dHJlbWUgc2NlbmFyaW8KPj4gdGhlIHJlcXVlc3QgbWF5IGJlIGNv
bXBsZXRlZCBhZ2FpbiBpbiB0ZWFyIGRvd24gcHJvY2Vzcy4KPj4gbnZtZl9mYWlsX25vbnJlYWR5
X2NvbW1hbmQgZG8gbm90IG5lZWQgY2FsbGluZyBibGtfbXFfc3RhcnRfcmVxdWVzdAo+PiBiZWZv
cmUgY29tcGxldGUgdGhlIHJlcXVlc3QuIG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kIHNob3Vs
ZCBzZXQKPj4gdGhlIHN0YXRlIG9mIHJlcXVlc3QgdG8gTVFfUlFfQ09NUExFVEUgYmVmb3JlIGNv
bXBsZXRlIHRoZSByZXF1ZXN0Lgo+Pgo+IAo+IFNvIHdoYXQgeW91IGFyZSBzYXlpbmcgaXMgdGhh
dCB0aGVyZSBpcyBhIHJhY2UgY29uZGl0aW9uIGJldHdlZW4KPiBibGtfbXFfc3RhcnRfcmVxdWVz
dCgpCj4gYW5kCj4gbnZtZV9jb21wbGV0ZV9yZXF1ZXN0KCkKWWVzLiBUaGUgcmFjZSBpczoKcHJv
Y2VzczE6ZXJyb3IgcmVjb3ZlcnktPnRlYXIgZG93bi0+cXVpZXNjZSBxdWV1ZSh3YWl0IGRpc3Bh
dGNoIGRvbmUpCnByb2Nlc3MyOmRpc3BhdGNoLT5xdWV1ZV9ycS0+bnZtZl9mYWlsX25vbnJlYWR5
X2NvbW1hbmQtPgogICAgIG52bWVfY29tcGxldGVfcnEoaWYgdGhlIHJlcXVlc3QgaXMgZnJlZWQg
YXN5bmNocm9ub3VzbHksIHdha2UKCW52bWVfc3VibWl0X3VzZXJfY21kKCBmb3IgZXhhbXBsZSkg
YnV0IGhhdmUgbm8gY2hhbmNlIHRvIHJ1bikuCnByb2Nlc3MxOmNvbnRpbnVlIC0+Y2FuY2xlIHN1
c3BlbmQgcmVxdWVzdCwgY2hlY2sgdGhlIHN0YXRlIGlzIG5vdAogICAgIE1RX1JRX0lETEUgYW5k
IE1RX1JRX0NPTVBMRVRFLCBjb21wbGV0ZShmcmVlKSB0aGUgcmVxdWVzdC4KcHJvY2VzczM6IG52
bWVfc3VibWl0X3VzZXJfY21kIG5vdyBoYXMgY2hhbmNlIHRvIHJ1biwgYW5kIHRoZSBmcmVlIHRo
ZQogICAgIHJlcXVlc3QgYWdhaW4uClRlc3QgSW5qZWN0aW9uIE1ldGhvZDogaW5qZWN0IGEgbXNs
ZWVwIGJlZm9yZSBjYWxsIGJsa19tcV9mcmVlX3JlcXVlc3QKaW4gbnZtZV9zdWJtaXRfdXNlcl9j
bWQuCj4gCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4K
Pj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyB8IDQgKy0tLQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9m
YWJyaWNzLmMKPj4gaW5kZXggNzJhYzAwMTczNTAwLi44NzRlNDMyMGUyMTQgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9mYWJyaWNzLmMKPj4gQEAgLTU1Myw5ICs1NTMsNyBAQCBibGtfc3RhdHVzX3QgbnZtZl9mYWls
X25vbnJlYWR5X2NvbW1hbmQoc3RydWN0IG52bWVfY3RybCAqY3RybCwKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgICFibGtfbm9yZXRyeV9yZXF1ZXN0KHJxKSAmJiAhKHJxLT5jbWRfZmxhZ3MgJiBSRVFf
TlZNRV9NUEFUSCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NUU19SRVNPVVJD
RTsKPj4gLcKgwqDCoCBudm1lX3JlcShycSktPnN0YXR1cyA9IE5WTUVfU0NfSE9TVF9QQVRIX0VS
Uk9SOwo+PiAtwqDCoMKgIGJsa19tcV9zdGFydF9yZXF1ZXN0KHJxKTsKPj4gLcKgwqDCoCBudm1l
X2NvbXBsZXRlX3JxKHJxKTsKPj4gK8KgwqDCoCBudm1lX2NvbXBsZXRlX2ZhaWxlZF9yZXEocnEp
Owo+PiDCoMKgwqDCoMKgIHJldHVybiBCTEtfU1RTX09LOwo+PiDCoCB9Cj4+IMKgIEVYUE9SVF9T
WU1CT0xfR1BMKG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kKTsKPj4gSSdkIHJhdGhlciBoYXZl
ICdudm1lX2NvbXBsZXRlX2ZhaWxlZF9yZXEoKScgYWNjZXB0IHRoZSBzdGF0dXMgYXMgCj4gYXJn
dW1lbnQsIGxpa2UKPiAKPiBudm1lX2NvbXBsZXRlX2ZhaWxlZF9yZXF1ZXN0KHJxLCBOVk1FX1ND
X0hPU1RfUEFUSF9FUlJPUikKPiAKPiB0aGF0IHdheSBpdCdzIG9idmlvdXMgd2hhdCBpcyBoYXBw
ZW5pbmcsIGFuZCB0aGUgc3RhdHVzIGlzbid0IGhpZGRlbiBpbiB0aGUgZnVuY3Rpb24uCk9rLCBn
b29kIGlkZWEuIFRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLgo+IAo+IENoZWVycywKPiAK
PiBIYW5uZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
