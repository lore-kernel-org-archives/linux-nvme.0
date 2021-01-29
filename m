Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFBAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:31:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF3D64DE7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF3D64DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5tCcvRG9MEg+TFP5RqYZoUbngw6UgEbWp5PiN4yM9lI=; b=joIQ28FGh2gl2VqsmFsn/s/Vw
	sFP6tJgi9wXbNK1ImmecrBkV74QHdojqEb5vYRF+9/4CvSe8ZHpqHt/FtXHQ9L9pC9szWx3tccBET
	OZhlV7zk3hVapRxPj/2WBx76S9UltqfVusylEsNSbj/P3m9lJ4Bucbwx6Y5oUeDMr+ZO1pCw1aZ4I
	33Xoa8Wga2G3ERmy/wjI6mXzguHngMmE3R63+U3GVGBbhXRoBAcaEgqY2XD5nZEZur+ETKt79Y2F1
	eOvmKORdEcOSdE8w4eIKA82Lr6bPFB33VXzIEVHiiyJs1C9ATXNWGaOBW5KF56ADTzobeftoqwnQ7
	w0OJ9EXCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5KUr-0001JO-Gg; Fri, 29 Jan 2021 03:30:57 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5KUo-0001Im-V0
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:30:56 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjWL00zRz5MTk;
 Fri, 29 Jan 2021 11:29:33 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:30:47 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:30:47 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
Date: Fri, 29 Jan 2021 11:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_223055_490102_3F4FF5A4 
X-CRM114-Status: GOOD (  16.83  )
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

CgpPbiAyMDIxLzEvMjkgMTE6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4+IFdoeSBu
b3QganVzdCBjYWxsIHNldCB0aGUgc3RhdHVzIGFuZCBjYWxsIG52bWVfcmRtYV9jb21wbGV0ZV9y
cSBhbmQKPj4+Pj4gcmV0dXJuIGhlcmU/Cj4+Pj4gSWYgdGhlIGVyciBpcyBFTk9NRU0gb3IgRUFH
QUlOLCBJIGFtIG5vdCBzdXJlIHRoZSBlcnIgbXVzdCBiZSBhCj4+Pj4gcGF0aC1yZWxhdGVkIGVy
cm9yIGZvciBhbGwgSEJBIGRyaXZlcnMuIFNvIHJldXNlZCB0aGUgZXJyb3IgY2hlY2sgY29kZS4K
Pj4+PiBJIHRoaW5rIGl0IHdvdWxkIGJlIG1vcmUgcmVhc29uYWJsZSB0byBhc3N1bWUgYW55IGVy
cm9ycyByZXR1cm5lZCBieSBIQkEKPj4+PiBkcml2ZXIgYXMgcGF0aC1yZWxhdGVkIGVycm9ycy4K
Pj4+PiBJZiB5b3UgdGhpbmsgc28sIEkgd2lsbCBtb2RpZnkgaXQgaW4gbmV4dCBwYXRjaCB2ZXJz
aW9uLgo+Pj4KPj4+IE1lYW50IHRvIGRvIHRoYXQgb25seSBmb3IgLUVJTy4gV2Ugc2hvdWxkIGFi
c29sdXRlbHkgbm90IGRvIGFueSBvZiB0aGlzCj4+PiBmb3Igc3R1ZmYgbGlrZSBFSU5WQUwsIEVP
UE5PVFNVUFAsIEVQRVJNIG9yIGFueSBzdHJhbmdlIGVycm9yIHRoYXQgbWF5Cj4+PiByZXR1cm4g
ZHVlIHRvIGEgYnVnIG9yIGFueXRoaW5nIGxpa2UgdGhhdC4KPj4gb2ssIHBsZWFzZSByZXZpZXcg
YWdhaW4sIHRoYW5rIHlvdS4KPj4gLS0tCj4+IMKgwqBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMg
fCA5ICsrKysrKystLQo+PiDCoMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBpbmRleCBiN2NlNGYyMjFkOTkuLjY2YjY5NzQ2
MWJkOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBAQCAtMjA4NCw4ICsyMDg0LDEzIEBAIHN0YXRpYyBi
bGtfc3RhdHVzX3QgbnZtZV9yZG1hX3F1ZXVlX3JxKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4
LAo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUs
IHNxZSwgcmVxLT5zZ2UsIHJlcS0+bnVtX3NnZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+bXIgPyAmcmVxLT5yZWdfd3Iud3IgOiBOVUxM
KTsKPj4gLcKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoZXJyKSkKPj4gK8KgwqDCoMKgwqDCoCBp
ZiAodW5saWtlbHkoZXJyKSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZXJyID09IC1FSU8pIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG52bWVfY29tcGxldGVfZmFpbGVkX3JxKHJxLCBOVk1FX1NDX0hPU1RfUEFUSF9FUlJP
Uik7Cj4gCj4gSSB3YXMgdGhpbmtpbmcgYWJvdXQ6Cj4gLS0gCj4gIMKgwqDCoMKgwqDCoMKgIGVy
ciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5zZ2UsIHJlcS0+bnVtX3Nn
ZSwKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEt
Pm1yID8gJnJlcS0+cmVnX3dyLndyIDogTlVMTCk7Cj4gIMKgwqDCoMKgwqDCoMKgIGlmICh1bmxp
a2VseShlcnIpKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyID09
IC1FSU8pIHsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKgo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBGYWlsIHRoZSByZXVxZXN0IHNvIHVwcGVyIGxheWVyIGNhbiBmYWlsb3ZlciBJL08KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaWYgYW5vdGhl
ciBwYXRoIGlzIGF2YWlsYWJsZQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKi8KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXEtPnN0YXR1cyA9IE5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SOwo+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9jb21w
bGV0ZV9ycShycSk7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIEJMS19TVFNfT0s7TmVlZCB0byBkbyBjbGVhbi4gc28gY2FuIG5vdCBkaXJl
Y3RseSByZXR1cm4uCj4gCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl91bm1hcDsKPiAgwqDCoMKgwqDC
oMKgwqAgfQo+IC0tIAo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
