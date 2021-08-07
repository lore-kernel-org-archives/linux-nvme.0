Return-Path: <SRS0=WQK/=M6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61FCC4338F
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Aug 2021 03:21:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEDA61185
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Aug 2021 03:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BEDA61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUiuVW4x75sF6/0SPt1L2Llbgp8ACYMN7sFSl5nSNlY=; b=nTzAqK+j+T+0hOOqScDNuyMITR
	/7rXONnJX9sTXfpEy6ALBXvruKeOfuAPACZd/8WBLR6rY8F3RV4l6oikhNytPe28tpRwZZGEW8h9f
	cVdinSV9P4EeapBnveWGDm2yirQ8xu1dBnZfIIRBKnHNYeD9+n5NhuGZAR9cL3bshCwThErXs8Vtj
	FV20qVyC3SaiaLYM+2AgeLo1S3sslo+0u0J6mWDObwzKhmMohVMf+G2C+P0F1AIBnnKhiH/lQbd+D
	o2HOXLo00b7r4Ysq+ys+T2wNANxM5bvoFuOoJLW1a8iXLpo+bozR8IfKXIrc0yQhgY9UvW3dXft7c
	pqAU1vCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCCti-00E4q5-Hz; Sat, 07 Aug 2021 03:21:18 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCCte-00E4pg-QF
 for linux-nvme@lists.infradead.org; Sat, 07 Aug 2021 03:21:16 +0000
Received: from dggeme719-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GhSKg1pmyz1CTCB;
 Sat,  7 Aug 2021 11:20:55 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme719-chm.china.huawei.com
 (10.1.199.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 11:21:04 +0800
Subject: Re: [PATCH] nvme-rdma: Don't update queue count when failing to set
 io queues
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <lengchao@huawei.com>
References: <20210728094120.27041-1-liruozhu@huawei.com>
 <c651419b-2e14-03d3-42c2-59069bfc137f@grimberg.me>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <67825461-8370-7a02-f1a8-cd1466dcb019@huawei.com>
Date: Sat, 7 Aug 2021 11:21:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <c651419b-2e14-03d3-42c2-59069bfc137f@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme719-chm.china.huawei.com (10.1.199.115)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_202115_082744_03AC1FBC 
X-CRM114-Status: GOOD (  14.51  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhbmtzLCBJIHdpbGwgc2VuZCB0aGUgdGNwIHZlcnNpb24gb2YgdGhpcyBwYXRjaCByaWdodCBh
d2F5LgoKT24gMjAyMS84LzcgNDoxMSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBSZXZpZXdlZC1i
eTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPgo+IENhbiB5b3Ugc2VuZCB0aGlz
IHBhdGNoIGZvciB0Y3AgYXMgd2VsbD8KPgo+IE9uIDcvMjgvMjEgMjo0MSBBTSwgUnVvemh1IExp
IHdyb3RlOgo+PiBXZSB1cGRhdGUgY3RybC0+cXVldWVfY291bnQgYW5kIHNjaGVkdWxlIGFub3Ro
ZXIgcmVjb25uZWN0IHdoZW4gaW8gcXVldWUKPj4gY291bnQgaXMgemVyby5CdXQgd2Ugd2lsbCBu
ZXZlciB0cnkgdG8gY3JlYXRlIGFueSBpbyBxdWV1ZSBpbiBuZXh0IHJlY28tCj4+IG5uZWN0aW9u
LCBiZWNhdXNlIGN0cmwtPnF1ZXVlX2NvdW50IGFscmVhZHkgc2V0IHRvIHplcm8uV2Ugd2lsbCBl
bmQgdXAKPj4gaGF2aW5nIGFuIGFkbWluLW9ubHkgc2Vzc2lvbiBpbiBMaXZlIHN0YXRlLCB3aGlj
aCBpcyBleGFjdGx5IHdoYXQgd2UgdHJ5Cj4+IHRvIGF2b2lkIGluIHRoZSBvcmlnaW5hbCBwYXRj
aC4KPj4gVXBkYXRlIGN0cmwtPnF1ZXVlX2NvdW50IGFmdGVyIHF1ZXVlX2NvdW50IHplcm8gY2hl
Y2tpbmcgdG8gZml4IGl0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSdW96aHUgTGkgPGxpcnVvemh1
QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA0ICsr
LS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3JkbWEuYwo+PiBpbmRleCA3ZjZiM2E5OTE1MDEuLjNiZDljYmM4MDI0NiAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3JkbWEuYwo+PiBAQCAtNzM1LDEzICs3MzUsMTMgQEAgc3RhdGljIGludCBudm1lX3JkbWFf
YWxsb2NfaW9fcXVldWVzKHN0cnVjdCAKPj4gbnZtZV9yZG1hX2N0cmwgKmN0cmwpCj4+IMKgwqDC
oMKgwqAgaWYgKHJldCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgIC3C
oMKgwqAgY3RybC0+Y3RybC5xdWV1ZV9jb3VudCA9IG5yX2lvX3F1ZXVlcyArIDE7Cj4+IC3CoMKg
wqAgaWYgKGN0cmwtPmN0cmwucXVldWVfY291bnQgPCAyKSB7Cj4+ICvCoMKgwqAgaWYgKG5yX2lv
X3F1ZXVlcyA9PSAwKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwtPmN0cmwu
ZGV2aWNlLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidW5hYmxlIHRvIHNldCBhbnkg
SS9PIHF1ZXVlc1xuIik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4g
wqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKgwqAgY3RybC0+Y3RybC5xdWV1ZV9jb3VudCA9IG5yX2lv
X3F1ZXVlcyArIDE7Cj4+IMKgwqDCoMKgwqAgZGV2X2luZm8oY3RybC0+Y3RybC5kZXZpY2UsCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAiY3JlYXRpbmcgJWQgSS9PIHF1ZXVlcy5cbiIsIG5yX2lvX3F1
ZXVlcyk7Cj4+Cj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
