Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE83C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:16:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773FE20870
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xfCaA/sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773FE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/hHWbOfPDjS/HpuqN4C8QpLYtWJpC2TNJbb4mN+NT/k=; b=xfCaA/sFRUjTtifKIkQ3aj7dN
	LI9KaPuo1Pbb7HCTHlUtywwOm25P3E7zsSrnoozT+6pUVhKcF3z6/Wf9VrvRABUloX70W4JAfBwZH
	djfwJZUjNgIrF5wHHO8oPfVCfqiDVc4J8iL6Knxe4++rLsARXCcfOB7hhGmzBM9bNS1uc7mTgre4/
	6ELB//A3tPR5GKLytQwi3gb7NZjYOZeqz8iAyY3gCibdeagnsVfGwPNfRNbpXursB4UcGRRM1b2yy
	Ahp6ndgnou9tXmjfHGhHb256MVG0aWuobz7G0y55GA2lzmwbGMcgCD9scbf64mDQzOFWFqUuCTMYn
	oT/yRP1kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV3gF-0002sd-I2; Wed, 21 Oct 2020 02:16:47 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV3gC-0002sB-KO
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 02:16:45 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 6ED17620A26F4E526D18;
 Wed, 21 Oct 2020 10:16:42 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 10:16:41 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 10:16:41 +0800
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20201020090808.27702-1-lengchao@huawei.com>
 <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
Date: Wed, 21 Oct 2020 10:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_221644_950545_B27889C0 
X-CRM114-Status: GOOD (  15.89  )
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

CgpPbiAyMDIwLzEwLzIxIDI6NDMsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IEF2b2lkIHJh
Y2UgYmV0d2VlbiB0aW1lIG91dCBhbmQgdGVhciBkb3duIGZvciByZG1hIGFuZCB0Y3AuCj4gCj4g
VGhpcyBwYXRjaHNldCBvdmVyYWxsIGxvb2tzIGdvb2QsIGJ1dCB3ZSBzdGlsbCBuZWVkIHRoZSBw
YXRjaCB0aGF0Cj4gYXZvaWRzIGRvdWJsZSBjb21wbGV0aW9uOgo+IAo+IC0tIAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4g
aW5kZXggNjI5YjAyNTY4NWQxLi40NjQyOGZmMGIwZmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvdGNwLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+IEBAIC0yMTc1
LDcgKzIxNzUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3RjcF9jb21wbGV0ZV90aW1lZF9vdXQoc3Ry
dWN0IHJlcXVlc3QgKnJxKQo+ICDCoMKgwqDCoMKgwqDCoCAvKiBmZW5jZSBvdGhlciBjb250ZXh0
cyB0aGF0IG1heSBjb21wbGV0ZSB0aGUgY29tbWFuZCAqLwo+ICDCoMKgwqDCoMKgwqDCoCBtdXRl
eF9sb2NrKCZ0b190Y3BfY3RybChjdHJsKS0+dGVhcmRvd25fbG9jayk7Cj4gIMKgwqDCoMKgwqDC
oMKgIG52bWVfdGNwX3N0b3BfcXVldWUoY3RybCwgbnZtZV90Y3BfcXVldWVfaWQocmVxLT5xdWV1
ZSkpOwo+IC3CoMKgwqDCoMKgwqAgaWYgKCFibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQocnEpKSB7
Cj4gK8KgwqDCoMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3Rfc3RhcnRlZChycSkgJiYgIWJsa19t
cV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpIHsKWWVzLCB0aGlzIHBhdGNoIGlzIG5lZWQuIGFuZCBz
YW1lbHkgZm9yIG52bWVfY2FuY2VsX3JlcXVlc3QuClRoaXMgd2lsbCBmaXggdGhlIHJhY2Ugd2l0
aCBhc3luY2hyb25vdXMgY29tcGxldGlvbi4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZTg1ZjYzMDRlZmQ3Li4x
ZTgzOGQ5NTIwOTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTMzOCw3ICszMzgsNyBAQCBib29sIG52bWVfY2Fu
Y2VsX3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgdm9pZCAqZGF0YSwgYm9vbCByZXNlcnZl
ZCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNhbmNlbGxpbmcgSS9PICVkIiwg
cmVxLT50YWcpOwoKICAgICAgICAgLyogZG9uJ3QgYWJvcnQgb25lIGNvbXBsZXRlZCByZXF1ZXN0
ICovCi0gICAgICAgaWYgKGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChyZXEpKQorICAgICAgIGlm
IChibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQocmVxKSB8fCAhYmxrX21xX3JlcXVlc3Rfc3RhcnRl
ZChycSkpCiAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CgogICAgICAgICBudm1lX3JlcShy
ZXEpLT5zdGF0dXMgPSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ7Ci0tIAo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXEocnEpLT5zdGF0dXMgPSBOVk1FX1NDX0hPU1Rf
QUJPUlRFRF9DTUQ7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfbXFfY29t
cGxldGVfcmVxdWVzdF9zeW5jKHJxKTsKPiAgwqDCoMKgwqDCoMKgwqAgfQo+IC0tIAo+IC4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
