Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E8C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 03:13:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F4160FC4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 03:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89F4160FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PK7n4IBKWpiRV99gxcz2L+aF4dTpMYbb0aip9R5zZKs=; b=yRvEXpIID9OSGcnxv1T+gSJbLV
	/8vlBaYPyShtX2WwOonYQOQIu0sHhsQ4zOUkPosfCOiKmoVCRKu39B/TWLxlH+oqB7fGF/ok1cWm6
	K25fGqEBrvi+SI5L+guTLsbbwfzQyYAjthSn7WqoHoq4hsp3dUJvDlFNuYExWLeRRXEG05kEyhlFI
	yrwW0+4CBLHth5HFczBRjPwNVNDIj8cByk1f5Kr/V5HkEWaqXjwuft7H9iPrsVtxf/fi3SlyQAhRS
	9ih4EBPHXxNJUfgeSLQtOzQbbkfPHNKfmi71GAcF0g7cYvFbfzhdJd7ppS7oUf1syl/0xTOplwgE/
	vRd5cmoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mB7LG-004ftn-VJ; Wed, 04 Aug 2021 03:13:14 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mB7Kh-004ftF-A1
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 03:12:41 +0000
Received: from dggeme719-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GfcHH5kFPz1CS9B;
 Wed,  4 Aug 2021 11:12:27 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme719-chm.china.huawei.com
 (10.1.199.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 11:12:32 +0800
Subject: Re: [PATCH 2/2] nvme: don't do scan work if io queue count is zero
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-3-liruozhu@huawei.com>
 <20210803155512.GA2294634@dhcp-10-100-145-180.wdc.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <21e1d620-12d2-5122-1714-eebb9ce23244@huawei.com>
Date: Wed, 4 Aug 2021 11:12:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210803155512.GA2294634@dhcp-10-100-145-180.wdc.com>
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme719-chm.china.huawei.com (10.1.199.115)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_201239_568154_39EAEFEF 
X-CRM114-Status: GOOD (  15.25  )
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SXQgc2VlbXMgdGhhdCB0cmFuc3BvcnQgZHJpdmVyIHdpbGwgb25seSByZWxlYXNlIHRoZSB0YWdz
ZXQgd2hlbiB0aGUgCmNvbm5lY3Rpb24gaXMgY29tcGxldGVseSBkZWxldGVkLgpJbiByZWNvbm5l
Y3Rpb24sIGlmIElPIHRhZ3NldCBpcyBjcmVhdGVkLCB0cmFuc3BvcnQgZHJpdmVyIGlzIG5vdCAK
YWxsb3dlZCB0byByZWNvbm5lY3Qgd2l0aG91dCBhbnkgSU8gcXVldWVzLgpTZWUgcGF0Y2goIm52
bWUtcmRtYTogZml4IHBvc3NpYmxlIGhhbmcgd2hlbiBmYWlsaW5nIHRvIHNldCBpbyBxdWV1ZXMi
KS4KQnV0IGl0IGRpZG6hr3Qgd29yayBhcyBleHBlY3RlZCwgdGhlIGZpcnN0IHBhdGNoIHRyeSB0
byBmaXggaXQuCgpUaGlzIHBhdGNoIHRyeSB0byBwcmV2ZW50IHNpbWlsYXIgbG9naWNhbCBwcm9i
bGVtcyBpbiB0aGUgdHJhbnNwb3J0IGRyaXZlci4KClRoYW5rcywKUnVvemh1CtTaIDIwMjEvOC8z
IDIzOjU1LCBLZWl0aCBCdXNjaCDQtLXAOgo+IE9uIFR1ZSwgQXVnIDAzLCAyMDIxIGF0IDA1OjA2
OjMwUE0gKzA4MDAsIFJ1b3podSBMaSB3cm90ZToKPj4ga2VybmVsIHBhbmljIHdoZW4gdHJ5IHRv
IHJlc2NhbiBucyB3aGVuIGlvIHF1ZXVlIGNvdW50IGlzIHplcm8uQmVjYXVzZQo+PiBrZXJuZWwg
QlVHX09OIHdoZW4gaGN0eF9pZHggaXMgZ3JlYXRlciB0aGFuIGN0cmwtPnF1ZXVlX2NvdW50Lgo+
PiAtLQo+PiBudm1lX3JkbWFfaW5pdF9oY3R4KzB4NTgvMHg2MCBbbnZtZV9yZG1hXQo+PiBibGtf
bXFfcmVhbGxvY19od19jdHhzKzB4MTQwLzB4NGMwCj4+IGJsa19tcV9pbml0X2FsbG9jYXRlZF9x
dWV1ZSsweDEzMC8weDQxMAo+PiBibGtfbXFfaW5pdF9xdWV1ZSsweDQwLzB4ODgKPj4gbnZtZV92
YWxpZGF0ZV9ucysweGI4LzB4NzQwCj4+IG52bWVfc2Nhbl93b3JrKzB4MjljLzB4NDYwCj4+IHBy
b2Nlc3Nfb25lX3dvcmsrMHgxZjgvMHg0OTAKPj4gd29ya2VyX3RocmVhZCsweDUwLzB4NGI4Cj4+
IGt0aHJlYWQrMHgxMzQvMHgxMzgKPj4gcmV0X2Zyb21fZm9yaysweDEwLzB4MTgKPj4gLS0KPj4g
RGVmZW5jZSBpdCBieSBub3QgYWxsb3dpbmcgcmVzY2FuIG5zIHdoZW4gaW8gcXVldWUgY291bnQg
aXMgemVyby4KPj4KPj4gU2lnbmVkLW9mZi1ieTogUnVvemh1IExpIDxsaXJ1b3podUBodWF3ZWku
Y29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA2ICsrKystLQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKPj4gaW5kZXggZGZkOWRlYzBjMWY2Li5kOWY4MzdlYjNlMjYgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPj4gQEAgLTE0MSw3ICsxNDEsOCBAQCB2b2lkIG52bWVfcXVldWVfc2NhbihzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsKQo+PiAgIAkvKgo+PiAgIAkgKiBPbmx5IG5ldyBxdWV1ZSBzY2FuIHdvcmsg
d2hlbiBhZG1pbiBhbmQgSU8gcXVldWVzIGFyZSBib3RoIGFsaXZlCj4+ICAgCSAqLwo+PiAtCWlm
IChjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfTElWRSAmJiBjdHJsLT50YWdzZXQpCj4+ICsJaWYg
KGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9MSVZFICYmCj4+ICsJICAgIGN0cmwtPnRhZ3NldCAm
JiBjdHJsLT5xdWV1ZV9jb3VudCA+IDEpCj4gV2h5IGlzIHRoZSB0cmFuc3BvcnQgZHJpdmVyIGxl
YXZpbmcgYW4gdW51c2FibGUgdGFnc2V0IGFsbG9jYXRlZCB3aGVuCj4gdGhlcmUgYXJlIG5vIElP
IHF1ZXVlcyB0byBzdXBwb3J0IGl0PyBJIHRoaW5rIGl0IHNob3VsZCBmcmVlIHRoZSB0YWdzZXQK
PiBpbiB0aGF0IGNhc2UuIEF0IGxlYXN0IHRoYXQncyB3aGF0IHBjaSBkb2VzLgo+IC4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
