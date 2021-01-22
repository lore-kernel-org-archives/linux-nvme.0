Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A83C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:46:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C10238D7
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C10238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=91VulvaEe9Nto8Be0KSUZ+ppLKoTWoIdDU58JA82/2I=; b=w8s79ooeBVlzlBXqR0NQYT6Cy
	Vjv1TyVPVWuJKahSq0IBzg+IZ3E8V9beloOFwH8P6MMnVaCqkMHe64DX4wDoLfnxIMIb1S+3IbISX
	0PW2zq4rFXam+QbQ4eJhhUCMYcUhHjp4cQScIA+NPbBZfuvJdDL3gSBJdtfuTYUhO9C0m/vpqU8a8
	kElmwNipY2XWbv9YH+UdmjxGcpvVAxmK6HzwL1nXRdoL/nyK74pzhCC4ScAOuR4c5HIHNL9NMi1pr
	qgAkbDBdMsh0TCoMEYbGEstciUMCSlZVUHuIZ/cGu69UmlPqslU6p2Q/9bSOe7qet1BWNxx8CMOB7
	a38NSQhtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2lWa-0002nb-40; Fri, 22 Jan 2021 01:46:08 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2lWX-0002mS-Sp
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 01:46:06 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMMWh5cbHzR667
 for <linux-nvme@lists.infradead.org>; Fri, 22 Jan 2021 09:44:48 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:45:41 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:45:41 +0800
Subject: Re: [PATCH v2 2/6] nvme-core: introduce complete failed request
To: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-3-lengchao@huawei.com>
 <93e16361-6973-5245-b040-692ef2ec4d79@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <65d190fb-4a9d-1776-01aa-786acc306a1c@huawei.com>
Date: Fri, 22 Jan 2021 09:45:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <93e16361-6973-5245-b040-692ef2ec4d79@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_204606_155130_0F949404 
X-CRM114-Status: GOOD (  14.76  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjEgMTY6MTQsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzcvMjEg
NDozMSBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+PiBXaGVuIGEgcmVxdWVzdCBpcyBxdWV1ZWQgZmFp
bGVkLCBpZiB0aGUgZmFpbCBzdGF0dXMgaXMgbm90Cj4+IEJMS19TVFNfUkVTT1VSQ0UsIEJMS19T
VFNfREVWX1JFU09VUkNFLCBCTEtfU1RTX1pPTkVfUkVTT1VSQ0UsCj4+IHRoZSByZXF1ZXN0IGlz
IG5lZWQgdG8gY29tcGxldGUgd2l0aCBudm1lX2NvbXBsZXRlX3JxIGluIHF1ZXVlX3JxLgo+PiBT
byBpbnRyb2R1Y2UgbnZtZV90cnlfY29tcGxldGVfZmFpbGVkX3JlcS4KPj4gVGhlIHJlcXVlc3Qg
aXMgbmVlZGVkIHRvIGNvbXBsZXRlIHdpdGggTlZNRV9TQ19IT1NUX1BBVEhfRVJST1IgaW4KPj4g
bnZtZl9mYWlsX25vbnJlYWR5X2NvbW1hbmQgYW5kIHF1ZXVlX3JxLgo+PiBTbyBpbnRyb2R1Y2Ug
bnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVxLgo+PiBGb3IgZGV0YWlscywgc2VlIHRoZSBzdWJzZXF1
ZW50IHBhdGNoZXMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVh
d2VpLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDIxICsrKysr
KysrKysrKysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1l
L2hvc3QvbnZtZS5oCj4+IGluZGV4IGJmY2VkZmE0YjA1Ny4uZmM0ZWVmZGZiYjM0IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKPj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvbnZtZS5oCj4+IEBAIC02NDksNiArNjQ5LDI3IEBAIHZvaWQgbnZtZV9wdXRfbnNfZnJvbV9k
aXNrKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsIGludCBpZHgpOwo+PiDCoCBleHRlcm4gY29u
c3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqbnZtZV9uc19pZF9hdHRyX2dyb3Vwc1tdOwo+PiDC
oCBleHRlcm4gY29uc3Qgc3RydWN0IGJsb2NrX2RldmljZV9vcGVyYXRpb25zIG52bWVfbnNfaGVh
ZF9vcHM7Cj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVxKHN0
cnVjdCByZXF1ZXN0ICpyZXEpCj4+ICt7Cj4+ICvCoMKgwqAgbnZtZV9yZXEocmVxKS0+c3RhdHVz
ID0gTlZNRV9TQ19IT1NUX1BBVEhfRVJST1I7Cj4+ICvCoMKgwqAgYmxrX21xX3NldF9yZXF1ZXN0
X2NvbXBsZXRlKHJlcSk7Cj4+ICvCoMKgwqAgbnZtZV9jb21wbGV0ZV9ycShyZXEpOwo+PiArfQo+
PiArCj4+ICtzdGF0aWMgaW5saW5lIGJsa19zdGF0dXNfdCBudm1lX3RyeV9jb21wbGV0ZV9mYWls
ZWRfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX3N0YXR1c190IHJldCkKPj4gK3sKPj4g
K8KgwqDCoCBzd2l0Y2ggKHJldCkgewo+PiArwqDCoMKgIGNhc2UgQkxLX1NUU19SRVNPVVJDRToK
Pj4gK8KgwqDCoCBjYXNlIEJMS19TVFNfREVWX1JFU09VUkNFOgo+PiArwqDCoMKgIGNhc2UgQkxL
X1NUU19aT05FX1JFU09VUkNFOgo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4gK8Kg
wqDCoCBkZWZhdWx0Ogo+PiArwqDCoMKgwqDCoMKgwqAgbnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVx
KHJlcSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NUU19PSzsKPj4gK8KgwqDCoCB9
Cj4+ICt9Cj4+ICsKPj4gwqAgI2lmZGVmIENPTkZJR19OVk1FX01VTFRJUEFUSAo+PiDCoCBzdGF0
aWMgaW5saW5lIGJvb2wgbnZtZV9jdHJsX3VzZV9hbmEoc3RydWN0IG52bWVfY3RybCAqY3RybCkK
Pj4gwqAgewo+Pgo+IFRoaXMgaXMgbm90IGNvcnJlY3QuCj4gSE9TVF9QQVRIX0VSUk9SIG9ubHkg
c2hvdWxkIGJlIHNldCBfaWZmXyBpdCBpcyBhIHBhdGhpbmcgaXNzdWUsIGFuZCB0aGUgSEJBL3Ry
YW5zcG9ydCBpcyBlcXVpcHBlZCB0byBkZXRlcm1pbmUgdGhhdC4KPiBBbnkgb3RoZXIgZXJyb3Ig
aGF2ZSBvdGhlciBjYXVzZXMsIGFuZCB3ZSBuZWVkIHRvIGxvb2sgYXQgdGhlIGluZGl2aWR1YWwg
ZXJyb3IgY29kZXMgKGFuZCBzaXR1YXRpb25zKSB0byBkZXRlcm1pbmUgaWYgdGhpcyByZWFsbHkg
aXMgYSBwYXRoaW5nIGVycm9yLgpPcHRpbWl6YXRpb24gaGFzIGJlZW4gbWFkZSBpbiBwYXRjaCB2
My4KPiAKPiBDaGVlcnMsCj4gCj4gSGFubmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
