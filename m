Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21AAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:31:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319B564DED
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319B564DED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bx/vA8mzEdy3/fbFcgRVOfikJ2dKNSoK6m/j1w204VE=; b=hUwWtjo/kVsAleIUAgW03NHfY
	EkRbK6F5BSaF3ax+/mKwwCZT90YrN3cddnocBZ2tFekDs1AwMPHMGN2z3oLSCxadjh/z4i9oLHlNw
	i4jSH3YS36X/WKAVtvOMNi13ixPmlJCmkXHMOZye/jXWj9NdQ83f2o9EcSzvjku+HyNXYwSn1A84o
	AlkEcMXNBkkOuaJJwW3bnFkPWcZvZKRrtkWw7Ls4FltIANWYuBXH/Nn5/3k4aRjFeqNmAeIHQ7ZBw
	9OolXy8EKbOhMFUunE47eneZ/arK2nwcMcGuUwGp0jE09DFkyxuH6ESOB5MRCcbVKowUd6bazzZV5
	0RxUrQjEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53ed-00037v-JN; Thu, 28 Jan 2021 09:31:55 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53ea-00037K-VL
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:31:54 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DRFZV47DGzY2Yc;
 Thu, 28 Jan 2021 17:30:42 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 17:31:48 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 17:31:47 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
Date: Thu, 28 Jan 2021 17:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_043153_270733_D9435DAF 
X-CRM114-Status: GOOD (  10.84  )
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

CgpPbiAyMDIxLzEvMjggMTY6MzksIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IEBAIC0yMDg0
LDggKzIwODUsMTAgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3JkbWFfcXVldWVfcnEoc3Ry
dWN0IGJsa19tcV9od19jdHggKmhjdHgsCj4+IMKgwqDCoMKgwqAgZXJyID0gbnZtZV9yZG1hX3Bv
c3Rfc2VuZChxdWV1ZSwgc3FlLCByZXEtPnNnZSwgcmVxLT5udW1fc2dlLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXEtPm1yID8gJnJlcS0+cmVnX3dyLndyIDogTlVMTCk7Cj4+IC3C
oMKgwqAgaWYgKHVubGlrZWx5KGVycikpCj4+ICvCoMKgwqAgaWYgKHVubGlrZWx5KGVycikpIHsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGRyaXZlcl9lcnJvciA9IHRydWU7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycl91bm1hcDsKPiAKPiBXaHkgbm90IGp1c3QgY2FsbCBzZXQgdGhlIHN0YXR1
cyBhbmQgY2FsbCBudm1lX3JkbWFfY29tcGxldGVfcnEgYW5kCj4gcmV0dXJuIGhlcmU/CklmIHRo
ZSBlcnIgaXMgRU5PTUVNIG9yIEVBR0FJTiwgSSBhbSBub3Qgc3VyZSB0aGUgZXJyIG11c3QgYmUg
YQpwYXRoLXJlbGF0ZWQgZXJyb3IgZm9yIGFsbCBIQkEgZHJpdmVycy4gU28gcmV1c2VkIHRoZSBl
cnJvciBjaGVjayBjb2RlLgpJIHRoaW5rIGl0IHdvdWxkIGJlIG1vcmUgcmVhc29uYWJsZSB0byBh
c3N1bWUgYW55IGVycm9ycyByZXR1cm5lZCBieSBIQkEKZHJpdmVyIGFzIHBhdGgtcmVsYXRlZCBl
cnJvcnMuCklmIHlvdSB0aGluayBzbywgSSB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHBhdGNoIHZl
cnNpb24uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
