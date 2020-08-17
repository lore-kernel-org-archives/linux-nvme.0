Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF78C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 05:50:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1173B2054F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dTYlQ8N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hzQ2b34h3jNkBRZoYsgl3KzQK+LK0I8sR9yGRZCX5eA=; b=dTYlQ8N4VpiYXQgCfOrkFSP+y
	FDLL9y/at9MJpodvU+LoAK5pw/ZjLymj8N+DcUPoiZ++3qdVy7odx5Oo2ZHHLnC28ry/8kkbTlrtR
	FGXwvDDyX9Beuj+hiBQGhkzNIEd6xmPUQkXrKngy5xcwn4PtASWXTWojwmJT3eMB9xzyCGPdsvI6+
	+p/Juha6cKrgFVnLzRGXgUC0Rx66CWF6FKXP/OyG8ZXrleCyJ5WxVSpJbq9AQnvRiVEYctdx6uI8W
	FRBnmZ94r+RaKJQPSlZUARHPB5uh0lMoZF3FkFJeOLJ8YTcZ3vqUHZhalX2xhDJZwwRcJkQzP0LCs
	jVbSJMsVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7Y24-00007d-DY; Mon, 17 Aug 2020 05:50:08 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Y20-00005W-DQ
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 05:50:07 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 102586CD30B400931CC7;
 Mon, 17 Aug 2020 13:49:51 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 17 Aug 2020 13:49:47 +0800
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
From: Chao Leng <lengchao@huawei.com>
To: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
 <fa05af11-d82a-13a4-e892-6dd8e65bf981@huawei.com>
Message-ID: <aeb44221-8740-3ff8-1932-e9c2c106ea57@huawei.com>
Date: Mon, 17 Aug 2020 13:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fa05af11-d82a-13a4-e892-6dd8e65bf981@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_015005_695124_EB30051B 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvMTcgMTE6NDEsIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIwLzgv
MTQgMjM6MTUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBGcm9tOiBDaGFvIExlbmcgPGxl
bmdjaGFvQGh1YXdlaS5jb20+Cj4+Cj4+IElmIGEgY29tbWFuZCBzZW5kIHRocm91Z2ggbnZtZS1t
dWx0dXBhdGggZmFpbGVkIG9uIGEgZHlpbmcgcXVldWUsIHJlc2VuZCBpdAo+PiBvbiBhbm90aGVy
IHBhdGguCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNv
bT4KPj4gW2hjaDogcmViYXNlZCBvbiB0b3Agb2YgdGhlIGNvbXBsZXRpb24gcmVmYWN0b3Jpbmdd
Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+PiAtLS0K
Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgOCArKysrLS0tLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
IGluZGV4IDhkNDc0YWRhZDcyMWZiLi4yNzFjYjliZjI5ZGNkMCAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
PiBAQCAtMjc1LDEzICsyNzUsMTMgQEAgc3RhdGljIGlubGluZSBlbnVtIG52bWVfZGlzcG9zaXRp
b24gbnZtZV9kZWNpZGVfZGlzcG9zaXRpb24oc3RydWN0IHJlcXVlc3QgKnJlcSkKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBDT01QTEVURTsKPj4gwqDCoMKgwqDCoCBpZiAocmVxLT5jbWRf
ZmxhZ3MgJiBSRVFfTlZNRV9NUEFUSCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKG52bWVfaXNf
cGF0aF9lcnJvcihzdGF0dXMpKQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG52bWVfaXNfcGF0aF9l
cnJvcihzdGF0dXMpIHx8IGJsa19xdWV1ZV9keWluZyhyZXEtPnEpKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gRkFJTE9WRVI7Cj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIChibGtfcXVldWVfZHlpbmcocmVxLT5xKSkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIENPTVBMRVRFOwo+PiDCoMKgwqDCoMKgIH0KPj4gLcKgwqDCoCBp
ZiAoYmxrX3F1ZXVlX2R5aW5nKHJlcS0+cSkpCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gQ09N
UExFVEU7Cj4+IC0KPj4gwqDCoMKgwqDCoCByZXR1cm4gUkVUUlk7Cj4+IMKgIH0gCj4gSWYgcGF0
aCByZWxhdGVkIGVycm9yLCByZXRyeSBtYXliZSBmYWlsIGFnYWluLiBTbyB3ZSBzaG91bGQgbm90
IHJldHJ5IGxvY2FsCj4gZm9yIHBhdGggcmVsYXRlZCBlcnJvci4gU3VnZ2VzdCBkbyBsaWtlIHRo
aXM6Cj4gIMKgwqDCoMKgaWYgKG52bWVfaXNfcGF0aF9lcnJvcihzdGF0dXMpIHx8IGJsa19xdWV1
ZV9keWluZyhyZXEtPnEpKSB7Cj4gIMKgwqDCoMKgwqDCoMKgIGlmIChyZXEtPmNtZF9mbGFncyAm
IFJFUV9OVk1FX01QQVRIKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBGQUlMT1ZF
UjsKPiAgwqDCoMKgwqDCoMKgwqAgZWxzZQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBDT01QTEVURTsKSWYgd2l0aG91dCBhbnkgbXVsdGlwYXRoLCB3aWxsIG5vdCByZXRyeS4gVGhp
cyBtYXkgbm90IGJlIHdoYXQgd2UgZXhwZWN0ZWQuCklmIHdlIGNhbiBzdXBwb3J0IGJvdGggTlZN
ZSBtdWx0aXBhdGhpbmcgYW5kIHRoaXJkLXBhcnR5IG11bHRpcGF0aGluZywKaXQgd291bGQgYmUg
Z3JlYXQuIEluIGFkZGl0aW9uIHRvIERNLU1VTFRJUEFUSCwgdGhpcmQtcGFydHkgbXVsdGlwYXRo
aW5nCnNvZnR3YXJlIGlzIHByb3ZpZGVkIGJ5IHN0b3JhZ2UgdmVuZG9ycywgc3VjaCBhcyBQb3dl
clBhdGgoREVMTCZFTUMpLApTZWN1cmVQYXRoKGhwKSwgVWx0cmFwYXRoKGh1YXdlaSksIGV0Yy4K
PiAgwqDCoMKgwqB9Cj4gIMKgwqDCoMKgcmV0dXJuIFJFVFJZOwo+IAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKPiBMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
