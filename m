Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5261C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 01:51:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6676108E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 01:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C6676108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPY+n7vmQxq2jdwzITZGq7584URDaS2KvLp23JKJ+Ds=; b=hVtDv/aj4QC27+x6EVaSbNO6Pg
	vAXh2/MZD7BJQLl7o0jOg+4Dqb1U2xcciw0tFsLQaS9OhDAZY26DdNJ/EvYfpapr1C3E5wSnNKXXr
	SNulfDCj7E5xIpna+3jcNIx7CqjGY0huXkFptIcbu1r3B9/jenfIswX+OVIsgDei0I+sJlLlrXiY2
	EhHQvefdI0efkXRYZwV/JaMjwTbvc/RMfF8WbnqyB4hDUM8TYguwBV8i8ltMseeXyBhTS7mqVexdE
	fGwOYQCsdDx/wBx5ou3F1iu4cYAcwzJlD29599T+TWIh6TK2/uPskC+nCc5ew5po7w2tVxIxx1ZTQ
	wFexB6LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPb75-0007bY-Gw; Mon, 13 Sep 2021 01:50:27 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPb6V-0007Z8-Vb
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 01:49:54 +0000
Received: from dggeme718-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H78SJ2Xkjz8yKW;
 Mon, 13 Sep 2021 09:45:20 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme718-chm.china.huawei.com
 (10.1.199.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 13
 Sep 2021 09:49:44 +0800
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com> <YToUji9WujpL9vnt@infradead.org>
 <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <9aa78ab2-ef69-abf7-7fca-7f135553f429@huawei.com>
Date: Mon, 13 Sep 2021 09:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme718-chm.china.huawei.com (10.1.199.114)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_184952_387931_FBCAE949 
X-CRM114-Status: GOOD (  19.62  )
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

SGkgYWxsLAoKSSB0ZXN0ZWQgdGhlIHRlc3Qgc2NlbmFyaW8gbWVudGlvbmVkIGJ5IG1heCwgYW5k
IEkgaGF2ZW4ndCBmb3VuZCBhbnkgCmFibm9ybWFsaXR5IGluIHRoZSBob3N0LgoKSWYgdGhlcmUg
YXJlIG90aGVyIGludGVyZXN0aW5nIHNjZW5lcyBvciBzdWdnZXN0aW9ucyBmb3IgcGF0Y2gsIHBs
ZWFzZSAKbGV0IG1lIGtub3cuCgpUaGFua3MuCgpPbiAyMDIxLzkvMTAgMTozMiwgTWF4IEd1cnRv
dm95IHdyb3RlOgo+Cj4gT24gOS85LzIwMjEgNTowNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6Cj4+IFRoaXMgbG9va3MgcmVhc29uYWJsZSB0byBtZS7CoCBTYWdpLCBNYXg6IGFueSBjb21t
ZW50cz8KPj4KPj4gT24gTW9uLCBTZXAgMDYsIDIwMjEgYXQgMTE6NTE6MzRBTSArMDgwMCwgUnVv
emh1IExpIHdyb3RlOgo+Pj4gV2Ugc2hvdWxkIGFsd2F5cyBkZXN0cm95IGNtX2lkIGJlZm9yZSBk
ZXN0cm95IHFwIHRvIGF2b2lkIHRvIGdldCBjbWEKPj4+IGV2ZW50IGFmdGVyIHFwIHdhcyBkZXN0
cm95ZWQsIHdoaWNoIG1heSBsZWFkIHRvIHVzZSBhZnRlciBmcmVlLgo+Cj4gRG8geW91IHJlYWxs
eSBlbmNvdW50ZXIgdXNlLWFmdGVyLWZyZWUgPwo+Cj4gSSB0aGluayB0aGUgY29kZSBsb29rcyBj
b3JyZWN0IGJ1dCBmcm9tIGV4cGVyaWVuY2Ugd2l0aCBSRE1BLUNNIEkgCj4gd291bGQgbGlrZSB0
byBrbm93IHdoaWNoIHRlc3RzIGRpZCB5b3UgcnVuIHdpdGggdGhpcyBjb2RlID8KPgo+IGludGVy
ZXN0aW5nIHRlc3RzIGFyZTogcG9ydCB0b2dnbGluZyB3aXRoL3dpdGhvdXQgSU8sIHVubG9hZCAK
PiBtbHg1L290aGVyX3JkbWFfaHcgZHJpdmVycyBkdXJpbmcgY29ubmVjdGlvbiBlc3RhYmxpc2ht
ZW50IG9yIGR1cmluZyAKPiBJTywgcmVib290IHRhcmdldCwgcmVib290IHRhcmdldCBkdXJpbmcg
Y29ubmVjdGlvbiBlc3RhYmxpc2htZW50LCAKPiByZWJvb3QgdGFyZ2V0IGR1cmluZyBJTy4KPgo+
IFRoYW5rcy4KPgo+Cj4+PiBJbiBSRE1BIGNvbm5lY3Rpb24gZXN0YWJsaXNobWVudCBlcnJvciBm
bG93LCBkb24ndCBkZXN0cm95IHFwIGluIGNtCj4+PiBldmVudCBoYW5kbGVyLkp1c3QgcmVwb3J0
IGNtX2Vycm9yIHRvIHVwcGVyIGxldmVsLCBxcCB3aWxsIGJlIGRlc3Ryb3kKPj4+IGluIG52bWVf
cmRtYV9hbGxvY19xdWV1ZSgpIGFmdGVyIGRlc3Ryb3kgY20gaWQuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogUnVvemh1IExpIDxsaXJ1b3podUBodWF3ZWkuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMgfCAxNiArKystLS0tLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
Cj4+PiBpbmRleCBhNjg3MDRlMzkwODQuLjA0MmM1OTRiYzU3ZSAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
Cj4+PiBAQCAtNjU2LDggKzY1Niw4IEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9mcmVlX3F1ZXVl
KHN0cnVjdCAKPj4+IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUpCj4+PiDCoMKgwqDCoMKgIGlmICgh
dGVzdF9hbmRfY2xlYXJfYml0KE5WTUVfUkRNQV9RX0FMTE9DQVRFRCwgJnF1ZXVlLT5mbGFncykp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gwqAgLcKgwqDCoCBudm1lX3JkbWFf
ZGVzdHJveV9xdWV1ZV9pYihxdWV1ZSk7Cj4+PiDCoMKgwqDCoMKgIHJkbWFfZGVzdHJveV9pZChx
dWV1ZS0+Y21faWQpOwo+Pj4gK8KgwqDCoCBudm1lX3JkbWFfZGVzdHJveV9xdWV1ZV9pYihxdWV1
ZSk7Cj4+PiDCoMKgwqDCoMKgIG11dGV4X2Rlc3Ryb3koJnF1ZXVlLT5xdWV1ZV9sb2NrKTsKPj4+
IMKgIH0KPj4+IMKgIEBAIC0xODE1LDE0ICsxODE1LDEwIEBAIHN0YXRpYyBpbnQgCj4+PiBudm1l
X3JkbWFfY29ubl9lc3RhYmxpc2hlZChzdHJ1Y3QgbnZtZV9yZG1hX3F1ZXVlICpxdWV1ZSkKPj4+
IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHF1ZXVlLT5xdWV1ZV9zaXplOyBpKyspIHsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBudm1lX3JkbWFfcG9zdF9yZWN2KHF1ZXVlLCAmcXVl
dWUtPnJzcF9yaW5nW2ldKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZGVzdHJveV9xdWV1ZV9pYjsKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIMKg
wqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiAtCj4+PiAtb3V0X2Rlc3Ryb3lfcXVldWVfaWI6Cj4+PiAt
wqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X3F1ZXVlX2liKHF1ZXVlKTsKPj4+IC3CoMKgwqAgcmV0
dXJuIHJldDsKPj4+IMKgIH0KPj4+IMKgIMKgIHN0YXRpYyBpbnQgbnZtZV9yZG1hX2Nvbm5fcmVq
ZWN0ZWQoc3RydWN0IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUsCj4+PiBAQCAtMTkxNiwxNCArMTkx
MiwxMCBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9yb3V0ZV9yZXNvbHZlZChzdHJ1Y3QgCj4+PiBu
dm1lX3JkbWFfcXVldWUgKnF1ZXVlKQo+Pj4gwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2X2VycihjdHJsLT5jdHJsLmRldmljZSwKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJyZG1hX2Nvbm5lY3RfbG9ja2VkIGZhaWxlZCAoJWQpLlxuIiwgcmV0
KTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9kZXN0cm95X3F1ZXVlX2liOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4+PiAtCj4+PiAtb3V0X2Rlc3Ryb3lfcXVldWVfaWI6Cj4+PiAtwqDCoMKg
IG52bWVfcmRtYV9kZXN0cm95X3F1ZXVlX2liKHF1ZXVlKTsKPj4+IC3CoMKgwqAgcmV0dXJuIHJl
dDsKPj4+IMKgIH0KPj4+IMKgIMKgIHN0YXRpYyBpbnQgbnZtZV9yZG1hX2NtX2hhbmRsZXIoc3Ry
dWN0IHJkbWFfY21faWQgKmNtX2lkLAo+Pj4gQEAgLTE5NTQsOCArMTk0Niw2IEBAIHN0YXRpYyBp
bnQgbnZtZV9yZG1hX2NtX2hhbmRsZXIoc3RydWN0IAo+Pj4gcmRtYV9jbV9pZCAqY21faWQsCj4+
PiDCoMKgwqDCoMKgIGNhc2UgUkRNQV9DTV9FVkVOVF9ST1VURV9FUlJPUjoKPj4+IMKgwqDCoMKg
wqAgY2FzZSBSRE1BX0NNX0VWRU5UX0NPTk5FQ1RfRVJST1I6Cj4+PiDCoMKgwqDCoMKgIGNhc2Ug
UkRNQV9DTV9FVkVOVF9VTlJFQUNIQUJMRToKPj4+IC3CoMKgwqDCoMKgwqDCoCBudm1lX3JkbWFf
ZGVzdHJveV9xdWV1ZV9pYihxdWV1ZSk7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZmFsbHRocm91Z2g7
Cj4+PiDCoMKgwqDCoMKgIGNhc2UgUkRNQV9DTV9FVkVOVF9BRERSX0VSUk9SOgo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGRldl9kYmcocXVldWUtPmN0cmwtPmN0cmwuZGV2aWNlLAo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNNIGVycm9yIGV2ZW50ICVkXG4iLCBldi0+ZXZlbnQpOwo+
Pj4gLS0gCj4+PiAyLjE2LjQKPj4+Cj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4+IExpbnV4LW52bWUgbWFpbGluZyBsaXN0Cj4+PiBMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo+PiAtLS1lbmQgcXVvdGVkIHRleHQtLS0KPiAu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
