Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:50:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACE964DBD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACE964DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LJncelTzrp9AqEXqxzfQQ+G5uYsWGAEctlVknBJUoGM=; b=ik301uFprwEO2LfIg9xEstBQW
	SWQkXg4pNo+8xU0bzA6lIKkRRiOIl/O/pBeNwurKSOcT/QbSCILZfuABOH1/+16tbOGyZyN4ebt7W
	RvQ++kRXAAyRfmjflDF1pYcPx5oiBRi8l5jcGAt/PDDlsvIvahSMxOXcVGGfXqVMuBjjC+A0jY0wG
	msPq2s7UjvM67R6xVVbfNN50GStnBt74uscWVLMpckd3gbn+hLbpuRcdteUuL/4J4lySKNKuFW/0y
	YdJqf4Kwph/5gyyIZXFFNSEN4Hg9LxIsMUKf0InjAQk+pJHWSZ1me3wCkqMO2We8dBR1+kJoa1GfP
	HZJe7+wrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Knu-00038d-UR; Fri, 29 Jan 2021 03:50:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Knr-00037r-Ss
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:50:38 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjy33vMHz5MVr;
 Fri, 29 Jan 2021 11:49:15 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:50:29 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:50:28 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
 <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
 <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <871fd11a-b4e7-aa63-97f0-be483b3e1f9e@huawei.com>
Date: Fri, 29 Jan 2021 11:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_225037_041732_4107A513 
X-CRM114-Status: GOOD (  11.14  )
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

CgpPbiAyMDIxLzEvMjkgMTE6MzcsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEu
Ywo+Pj4+IGluZGV4IGI3Y2U0ZjIyMWQ5OS4uNjZiNjk3NDYxYmQ5IDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYwo+Pj4+IEBAIC0yMDg0LDggKzIwODQsMTMgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1l
X3JkbWFfcXVldWVfcnEoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsCj4+Pj4KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5z
Z2UsIHJlcS0+bnVtX3NnZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVxLT5tciA/ICZyZXEtPnJlZ193ci53ciA6IE5VTEwpOwo+Pj4+IC3C
oMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGVycikpCj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAodW5s
aWtlbHkoZXJyKSkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIg
PT0gLUVJTykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBudm1lX2NvbXBsZXRlX2ZhaWxlZF9ycShycSwgTlZNRV9TQ19IT1NUX1BBVEhfRVJST1Ip
Owo+Pj4KPj4+IEkgd2FzIHRoaW5raW5nIGFib3V0Ogo+Pj4gLS0gCj4+PiDCoMKgwqDCoMKgwqDC
oMKgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5zZ2UsIHJlcS0+
bnVtX3NnZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXEtPm1yID8gJnJlcS0+cmVnX3dyLndyIDogTlVMTCk7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgIGlmICh1bmxpa2VseShlcnIpKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZXJyID09IC1FSU8pIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBGYWlsIHRoZSByZXVxZXN0IHNvIHVwcGVyIGxheWVyIGNh
biBmYWlsb3ZlciBJL08KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogaWYgYW5vdGhlciBwYXRoIGlzIGF2YWlsYWJsZQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPnN0YXR1cyA9IE5W
TUVfU0NfSE9TVF9QQVRIX0VSUk9SOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9jb21wbGV0ZV9ycShycSk7Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEJMS19TVFNf
T0s7TmVlZCB0byBkbyBjbGVhbi4gc28gY2FuIG5vdCBkaXJlY3RseSByZXR1cm4uCj4gCj4gVGhl
IGNvbXBsZXRpb24gcGF0aCBjbGVhbnMgdXAgdGhvdWdoCm9rLCBpIHNlZS4KQnV0IHdlIG5lZWQg
dG8gdXNlIHRoZSBuZXcgaGVscGVyIG52bWVfY29tcGxldGVfZmFpbGVkX3JxIHRvIGF2b2lkIGRv
dWJsZSByZXF1ZXN0IGNvbXBsZXRpb24uCk9yIHdlIGNhbiBkbyBsaWtlIHRoaXM6CnJlcS0+c3Rh
dHVzID0gTlZNRV9TQ19IT1NUX1BBVEhfRVJST1I7CmJsa19tcV9zZXRfcmVxdWVzdF9jb21wbGV0
ZShyZXEpOwpudm1lX3JkbWFfY29tcGxldGVfcnEocnEpOwo+IAo+Pj4KPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gZXJyX3VubWFwOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiAtLSAKPj4+IC4K
Pj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4g
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKPj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
