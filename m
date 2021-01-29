Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0913FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 02:49:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907CC64DFD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 02:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907CC64DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L0gQzr/zxzScoDafSbbU3Z+dezZFSaTmhl3jer78/Hc=; b=CnSzg1mNQujIgRyqWZf8Cv4hb
	gQHNGayyJ4HSknnq9yTvYSxq5ZavPyUT0jjULi9mVS7qtRqYR5wbfAyfT4m/6OjrA2kTP7M+Gumdc
	HkcBasKdX/Kj5iU+JHDpUFTn7BMzGfep1kjqieo59rs6TvB9KWxH5WkYyuum7yg08whTKeGRVpD2+
	YPU15tgI2P5yMnP/yDQvdKb+13nWOX64RiA7cm9Ojgo9azJpTQWjkGfLrDEiRHIDA8kZygEfevCal
	UmPr/8A5oQklQo0qDSJ3YhqmgYwXS69gS1ML8QK/q4tmPZHFMskKgOV4DH3yrL36zSoEgseITEWzF
	OJRYAXEtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5JqT-0006jq-C7; Fri, 29 Jan 2021 02:49:13 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5JqO-0006iw-OW
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 02:49:11 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRhZC1JCrz13mL4;
 Fri, 29 Jan 2021 10:46:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 10:48:59 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 10:48:58 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
Date: Fri, 29 Jan 2021 10:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_214909_039882_85FD68C2 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjkgOTozNSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBAQCAtMjA4
NCw4ICsyMDg1LDEwIEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9yZG1hX3F1ZXVlX3JxKHN0
cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LAo+Pj4+IMKgwqDCoMKgwqAgZXJyID0gbnZtZV9yZG1h
X3Bvc3Rfc2VuZChxdWV1ZSwgc3FlLCByZXEtPnNnZSwgcmVxLT5udW1fc2dlLAo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+bXIgPyAmcmVxLT5yZWdfd3Iud3IgOiBOVUxMKTsK
Pj4+PiAtwqDCoMKgIGlmICh1bmxpa2VseShlcnIpKQo+Pj4+ICvCoMKgwqAgaWYgKHVubGlrZWx5
KGVycikpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgZHJpdmVyX2Vycm9yID0gdHJ1ZTsKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfdW5tYXA7Cj4+Pgo+Pj4gV2h5IG5vdCBqdXN0IGNh
bGwgc2V0IHRoZSBzdGF0dXMgYW5kIGNhbGwgbnZtZV9yZG1hX2NvbXBsZXRlX3JxIGFuZAo+Pj4g
cmV0dXJuIGhlcmU/Cj4+IElmIHRoZSBlcnIgaXMgRU5PTUVNIG9yIEVBR0FJTiwgSSBhbSBub3Qg
c3VyZSB0aGUgZXJyIG11c3QgYmUgYQo+PiBwYXRoLXJlbGF0ZWQgZXJyb3IgZm9yIGFsbCBIQkEg
ZHJpdmVycy4gU28gcmV1c2VkIHRoZSBlcnJvciBjaGVjayBjb2RlLgo+PiBJIHRoaW5rIGl0IHdv
dWxkIGJlIG1vcmUgcmVhc29uYWJsZSB0byBhc3N1bWUgYW55IGVycm9ycyByZXR1cm5lZCBieSBI
QkEKPj4gZHJpdmVyIGFzIHBhdGgtcmVsYXRlZCBlcnJvcnMuCj4+IElmIHlvdSB0aGluayBzbywg
SSB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHBhdGNoIHZlcnNpb24uCj4gCj4gTWVhbnQgdG8gZG8g
dGhhdCBvbmx5IGZvciAtRUlPLiBXZSBzaG91bGQgYWJzb2x1dGVseSBub3QgZG8gYW55IG9mIHRo
aXMKPiBmb3Igc3R1ZmYgbGlrZSBFSU5WQUwsIEVPUE5PVFNVUFAsIEVQRVJNIG9yIGFueSBzdHJh
bmdlIGVycm9yIHRoYXQgbWF5Cj4gcmV0dXJuIGR1ZSB0byBhIGJ1ZyBvciBhbnl0aGluZyBsaWtl
IHRoYXQuCm9rLCBwbGVhc2UgcmV2aWV3IGFnYWluLCB0aGFuayB5b3UuCi0tLQogIGRyaXZlcnMv
bnZtZS9ob3N0L3JkbWEuYyB8IDkgKysrKysrKy0tCiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9y
ZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKaW5kZXggYjdjZTRmMjIxZDk5Li42NmI2
OTc0NjFiZDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYworKysgYi9kcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMKQEAgLTIwODQsOCArMjA4NCwxMyBAQCBzdGF0aWMgYmxrX3N0
YXR1c190IG52bWVfcmRtYV9xdWV1ZV9ycShzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwKCiAg
ICAgICAgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5zZ2UsIHJl
cS0+bnVtX3NnZSwKICAgICAgICAgICAgICAgICAgICAgICAgIHJlcS0+bXIgPyAmcmVxLT5yZWdf
d3Iud3IgOiBOVUxMKTsKLSAgICAgICBpZiAodW5saWtlbHkoZXJyKSkKKyAgICAgICBpZiAodW5s
aWtlbHkoZXJyKSkgeworICAgICAgICAgICAgICAgaWYgKGVyciA9PSAtRUlPKSB7CisgICAgICAg
ICAgICAgICAgICAgICAgIG52bWVfY29tcGxldGVfZmFpbGVkX3JxKHJxLCBOVk1FX1NDX0hPU1Rf
UEFUSF9FUlJPUik7CisgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IDA7CisgICAgICAgICAg
ICAgICB9CiAgICAgICAgICAgICAgICAgZ290byBlcnJfdW5tYXA7CisgICAgICAgfQoKICAgICAg
ICAgcmV0dXJuIEJMS19TVFNfT0s7CgpAQCAtMjA5NCw3ICsyMDk5LDcgQEAgc3RhdGljIGJsa19z
dGF0dXNfdCBudm1lX3JkbWFfcXVldWVfcnEoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsCiAg
ZXJyOgogICAgICAgICBpZiAoZXJyID09IC1FTk9NRU0gfHwgZXJyID09IC1FQUdBSU4pCiAgICAg
ICAgICAgICAgICAgcmV0ID0gQkxLX1NUU19SRVNPVVJDRTsKLSAgICAgICBlbHNlCisgICAgICAg
ZWxzZSBpZiAoZXJyKQogICAgICAgICAgICAgICAgIHJldCA9IEJMS19TVFNfSU9FUlI7CiAgICAg
ICAgIG52bWVfY2xlYW51cF9jbWQocnEpOwogIHVubWFwX3FlOgotLSAKPiAuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
