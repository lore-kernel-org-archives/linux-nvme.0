Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2EC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:43:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B2720786
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nnTE0wHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B2720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g0O9XEq+pSyZVkOKqBgSY/iR93CQrkMkccEMP69w66Q=; b=nnTE0wHt9MgD7PoFvVZ6gf05S
	Mcf43MvPjNh2hZWUTDsgc3E5hYBSUWnPhoP1AsBZcHpfZeZxNTcv+HKEvuhrKrE/5sPLInciu+DC4
	+I1lzJEtbSWkA5Nv4/8fjI2WxnQk0oxzOiu5VCclnvsLrKJGn1xCxIZ1y3/NXnLChu1pzEnKv3ini
	PV1+utHnoJ2G65KtVzmT8ruNID/sslZNsH50sN3deNUuIbW7VYgsJ5Gl3/ypsIKgc5xTVSLADn6oA
	mTGTxy9gTmfXL2cMSh2xaFJwK6hN9g57k0XHrhgThqfNl+5VjkN5w3ewJhNelFEuGD0tzqL2U6RkG
	1BGTfx4Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8eIR-0005Vi-UG; Thu, 20 Aug 2020 06:43:35 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8eIP-0005Uw-Si
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:43:35 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 75BECF5247D362C1A653;
 Thu, 20 Aug 2020 14:43:25 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 20 Aug 2020 14:43:21 +0800
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200820035413.1790-1-lengchao@huawei.com>
 <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
Date: Thu, 20 Aug 2020 14:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_024334_228366_75DAA745 
X-CRM114-Status: GOOD (  11.84  )
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

CgpPbiAyMDIwLzgvMjAgMTI6MzAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
Pj4gaW5kZXggNzRmNzZhYTc4YjAyLi5mNGMzNDdmZTkyNWEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4g
QEAgLTE0MjIsMjEgKzE0MjIsMjUgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9zZXRfcXVldWVf
Y291bnQpOwo+PiDCoMKgwqDCoMKgIChOVk1FX0FFTl9DRkdfTlNfQVRUUiB8IE5WTUVfQUVOX0NG
R19GV19BQ1QgfCBcCj4+IMKgwqDCoMKgwqDCoCBOVk1FX0FFTl9DRkdfQU5BX0NIQU5HRSB8IE5W
TUVfQUVOX0NGR19ESVNDX0NIQU5HRSkKPj4gLXN0YXRpYyB2b2lkIG52bWVfZW5hYmxlX2Flbihz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiArc3RhdGljIGludCBudm1lX2VuYWJsZV9hZW4oc3Ry
dWN0IG52bWVfY3RybCAqY3RybCkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHUzMiByZXN1bHQsIHN1
cHBvcnRlZF9hZW5zID0gY3RybC0+b2FlcyAmIE5WTUVfQUVOX1NVUFBPUlRFRDsKPj4gwqDCoMKg
wqDCoCBpbnQgc3RhdHVzOwo+PiDCoMKgwqDCoMKgIGlmICghc3VwcG9ydGVkX2FlbnMpCj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqDC
oMKgwqDCoCBzdGF0dXMgPSBudm1lX3NldF9mZWF0dXJlcyhjdHJsLCBOVk1FX0ZFQVRfQVNZTkNf
RVZFTlQsIHN1cHBvcnRlZF9hZW5zLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxM
LCAwLCAmcmVzdWx0KTsKPj4gLcKgwqDCoCBpZiAoc3RhdHVzKQo+PiArwqDCoMKgIGlmIChzdGF0
dXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGN0cmwtPmRldmljZSwgIkZhaWxl
ZCB0byBjb25maWd1cmUgQUVOIChjZmcgJXgpXG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN1cHBvcnRlZF9hZW5zKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMgPCAw
KQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3RhdHVzOwo+IAo+IFdoeSBkbyB5
b3UgbmVlZCB0byBjaGVjayBzdGF0dXMgPCAwLCB5b3UgbmVlZCB0byBmYWlsIGl0IHJlZ2FyZGxl
c3MuCgphZ3JlZS4KSnVzdCB3YW50IHRvIGtlZXAgdGhlIG9sZCBsb2dpYy4gSSBndWVzcyB0aGUg
b2xkIGxvZ2ljOiBpZiBzdXBwb3J0ZWRfYWVucwppcyB0cnVlLCB0aGUgcmVzdWx0IG9mIHNldCBm
ZWF0dXJlcyBjYW4gaWdub3JlLgoKSWYgdGhlcmUgaXMgbm8gb2JqZWN0aW9uIHRvIGRvaW5nIHNv
LCBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaCBsYXRlci4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
