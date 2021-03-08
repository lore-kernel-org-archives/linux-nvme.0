Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5248EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 01:31:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA226514A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 01:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA226514A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ckWeo94caGFSCoQmxqiAYvBAxvaLVDAQ5hriQ75i0Js=; b=O/QJS1adN2/DO0gfWq67fEiuT
	HQmD5+SPhikleSZDB3swU366rYpsrFHup6XL6wI9TujbSLvizbyI3jwyetqh+pnyWB2NCv4/VhHaf
	Tf5K1dc2xQO36k/7fHAL51N4dcGddwPj2oKlQqROOeOGZLOiBjTG53m5fWOiwK/q5xgmisG3s3wfP
	qHK3KZrMSAQI8YheFkycHWs79x+wL0UczYKGdNBuJh1IMRdKm/2b50NgglmJhjjGuNUJoOfkl1bIR
	uDDVQlFR4Lg6WSAPlHV9e/CvpkI52UwZHMujVb4RADjX89lEpL18XZ29Vj+Zo942dl1wJXlpsh1ja
	MrHZBGmGg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJ4ju-00ELcC-8J; Mon, 08 Mar 2021 01:31:18 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJ4jc-00ELTX-5u
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 01:31:07 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dv12x0VqkzYD92;
 Mon,  8 Mar 2021 09:29:13 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Mar 2021 09:30:48 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 8 Mar
 2021 09:30:48 +0800
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
Date: Mon, 8 Mar 2021 09:30:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_013100_640244_357D9058 
X-CRM114-Status: GOOD (  22.39  )
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

CgpPbiAyMDIxLzMvNiA0OjU4LCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBBIGNyYXNoIGhh
cHBlbnMgd2hlbiBzZXQgZmVhdHVyZShOVk1FX0ZFQVRfTlVNX1FVRVVFUykgdGltZW91dCBpbiBu
dm1lCj4+IG92ZXIgcmRtYShyb2NlKSByZWNvbm5lY3Rpb24sIHRoZSByZWFzb24gaXMgdXNlIHRo
ZSBxdWV1ZSB3aGljaCBpcyBub3QKPj4gYWxsb2NlZC4KPj4KPj4gSWYgcXVldWUgaXMgbm90IGxp
dmUsIHNob3VsZCBub3QgYWxsb3cgcXVldWUgcmVxdWVzdC4KPiAKPiBDYW4geW91IGRlc2NyaWJl
IGV4YWN0bHkgdGhlIHNjZW5hcmlvIGhlcmU/IFdoYXQgaXMgdGhlIHN0YXRlCj4gaGVyZT8gTElW
RT8gb3IgREVMRVRJTkc/CklmIHNldGluZyBmZWF0dXJlKE5WTUVfRkVBVF9OVU1fUVVFVUVTKSBm
YWlsZWQgZHVlIHRvIHRpbWUgb3V0IG9yCnRoZSB0YXJnZXQgcmV0dXJuIDAgaW8gcXVldWVzLCBu
dm1lX3NldF9xdWV1ZV9jb3VudCB3aWxsIHJldHVybiAwLAphbmQgdGhlbiByZWNvbm5lY3Rpb24g
d2lsbCBjb250aW51ZSBhbmQgc3VjY2Vzcy4gVGhlIHN0YXRlIG9mIGNvbnRyb2xsZXIKaXMgTElW
RS4gVGhlIHJlcXVlc3Qgd2lsbCBjb250aW51ZSB0byBkZWxpdmVyIGJ5IGNhbGwgLT5xdWV1ZV9y
cSgpLAphbmQgdGhlbiBjcmFzaCBoYXBwZW5zLgo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFv
IExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9z
dC9mYWJyaWNzLmggfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmlj
cy5oIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4+IGluZGV4IDczMzAxMGQyZWFmZC4u
MjQ3OTc0NGZjMzQ5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgK
Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4+IEBAIC0xODksNyArMTg5LDcg
QEAgc3RhdGljIGlubGluZSBib29sIG52bWZfY2hlY2tfcmVhZHkoc3RydWN0IG52bWVfY3RybCAq
Y3RybCwgc3RydWN0IHJlcXVlc3QgKnJxLAo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaWYgKGxpa2Vs
eShjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfTElWRSB8fAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0RFTEVUSU5HKSkKPj4gLcKgwqDCoMKgwqDC
oMKgIHJldHVybiB0cnVlOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHF1ZXVlX2xpdmU7Cj4+
IMKgwqDCoMKgwqAgcmV0dXJuIF9fbnZtZl9jaGVja19yZWFkeShjdHJsLCBycSwgcXVldWVfbGl2
ZSk7Cj4+IMKgIH0KPiAKPiBUaGVyZSB3ZXJlIHNvbWUgaXNzdWVzIGluIHRoZSBwYXN0IHRoYXQg
bWFkZSB1cyBhbGxvdyBzdWJtaXR0aW5nCj4gcmVxdWVzdHMgaW4gREVMRVRJTkcgc3RhdGUgYW5k
IGludHJvZHVjaW5nIERFTEVUSU5HX05PSU8uIFNlZQo+IHBhdGNoIGVjY2EzOTBlODA1NiAoIm52
bWU6IGZpeCBkZWFkbG9jayBpbiBkaXNjb25uZWN0IGR1cmluZyBzY2FuX3dvcmsgYW5kL29yIGFu
YV93b3JrIikKVGhpcyBkb2Vzbid0IG1ha2UgYW55IGRpZmZlcmVuY2UuIFdoZW4gaW4gZGVsZXRp
bmcgc3RhdGUgdGhlIHF1ZXVlIGlzCnN0aWxsIGxpdmUuCj4gCj4gVGhlIGRyaXZlciBzaG91bGQg
YmUgYWJsZSB0byBhY2NlcHQgSS9PIGluIERFTEVUSU5HIGJlY2F1c2UgdGhlIGNvcmUKPiBjaGFu
Z2VzIHRoZSBzdGF0ZSB0byBERUxFVElOR19OT0lPIF9iZWZvcmVfIGl0IGNhbGxzIC0+ZGVsZXRl
X2N0cmwgc28gSQo+IGRvbid0IHVuZGVyc3RhbmQgaG93IHlvdSBnZXQgdG8gdGhpcyBpZiB0aGUg
cXVldWUgaXMgbm90IGFsbG9jYXRlZC4uLgpUaGUgc3RhdGUgb2YgY29udHJvbGxlciBpcyBsaXZl
LiBUaGUgZGVsZXRpb24gcHJvY2VzcyBsb29rcyBnb29kLgo+IC4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
