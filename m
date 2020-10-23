Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC773C4363A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 02:07:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2664D20747
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 02:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aVHorDy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664D20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0Ug9muTKmKI14fLJS6MTBzt1AXETNDwlEVZ7AGMKXss=; b=aVHorDy81ffy/bNCnlHgkwvgY
	ItJLzTccjp1qfvhBLnEvfizK43ygfOTuBM/m7fQ7w1IYLqxhfoOAY639SNtuhgb4WbEtS7lUmF0cG
	RgbsditXNmI1M79dqSPrnAKasIdFaAjZTM7Z1tcZaArKjjQJzgNx+giWyX/qEhUPG9CLp+MHHvxBL
	zBHqSEJFbwdTBBec1780i+xNRBYKIIYKCFAk8Gh6G5e9n/2JhcSmn+uB5Z+ptkOd3q8tjrYBPLMc4
	bk/iPBt3C+1uReT5JIH3/k+8AXyUF+2mOBtzX+dMVjZrBm7BpT8LLSlAok8ejxht3VDvs5R31tF0T
	gATXRijtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVmUG-0006dq-KF; Fri, 23 Oct 2020 02:07:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVmUD-0006d1-N8
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 02:07:22 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 173DF4436115AF78727F;
 Fri, 23 Oct 2020 10:07:12 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 23 Oct 2020 10:07:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 23
 Oct 2020 10:07:11 +0800
Subject: Re: [External] Re: [PATCH] nvme-rdma: handle nvme completion data
 length
To: zhenwei pi <pizhenwei@bytedance.com>
References: <20201022083850.1334880-1-pizhenwei@bytedance.com>
 <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
 <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c2891e98-a81c-7f3a-3b19-1e34bd1f212c@huawei.com>
Date: Fri, 23 Oct 2020 10:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_220722_013035_B1F63649 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 Yibo Zhu <zhuyibo@bytedance.com>, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzEwLzIyIDE4OjA1LCB6aGVud2VpIHBpIHdyb3RlOgo+IE9uIDEwLzIyLzIwIDU6
NTUgUE0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMC8xMC8yMiAxNjozOCwgemhl
bndlaSBwaSB3cm90ZToKPj4+IEhpdCBhIGtlcm5lbCB3YXJuaW5nOgo+Pj4gcmVmY291bnRfdDog
dW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4KPj4+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDAgYXQg
bGliL3JlZmNvdW50LmM6MjgKPj4+Cj4+PiBSSVA6IDAwMTA6cmVmY291bnRfd2Fybl9zYXR1cmF0
ZSsweGQ5LzB4ZTAKPj4+IENhbGwgVHJhY2U6Cj4+PiDCoCA8SVJRPgo+Pj4gwqAgbnZtZV9yZG1h
X3JlY3ZfZG9uZSsweGYzLzB4MjgwIFtudm1lX3JkbWFdCj4+PiDCoCBfX2liX3Byb2Nlc3NfY3Er
MHg3Ni8weDE1MCBbaWJfY29yZV0KPj4+IMKgIC4uLgo+Pj4KPj4+IFRoZSByZWFzb24gaXMgdGhh
dCBhIHplcm8gYnl0ZXMgbWVzc2FnZSByZWNlaXZlZCBmcm9tIHRhcmdldCwgYW5kIHRoZQo+Pj4g
aG9zdCBzaWRlIGNvbnRpbnVlcyB0byBwcm9jZXNzIHdpdGhvdXQgbGVuZ3RoIGNoZWNraW5nLCB0
aGVuIHRoZQo+Pj4gcHJldmlvdXMgQ1FFIGlzIHByb2Nlc3NlZCB0d2ljZS4KPj4+Cj4+PiBIYW5k
bGUgZGF0YSBsZW5ndGgsIGlnbm9yZSB6ZXJvIGJ5dGVzIG1lc3NhZ2UsIGFuZCB0cnkgdG8gcmVj
b3ZlcnkgZm9yCj4+PiBjb3JydXB0ZWQgQ1FFIGNhc2UuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
emhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYyB8IDExICsrKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+IGluZGV4IDllMzc4ZDBhMGMw
MS4uOWY1MTEyMDQwZDQzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
Cj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+IEBAIC0xNzY3LDYgKzE3Njcs
MTcgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3JlY3ZfZG9uZShzdHJ1Y3QgaWJfY3EgKmNxLCBz
dHJ1Y3QgaWJfd2MgKndjKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+IMKgwqDC
oMKgwqAgfQo+Pj4gK8KgwqDCoCBpZiAodW5saWtlbHkoIXdjLT5ieXRlX2xlbikpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCAvKiB6ZXJvIGJ5dGVzIG1lc3NhZ2UgY291bGQgYmUgaWdub3JlZCAqLwo+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKUmVzb3VyY2UgbGVhaywgbmVlZCBudm1lX3JkbWFf
cG9zdF9yZWN2Lgo+Pj4gK8KgwqDCoCB9IGVsc2UgaWYgKHVubGlrZWx5KHdjLT5ieXRlX2xlbiA8
IGxlbikpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBDb3JydXB0ZWQgY29tcGxldGlvbiwgdHJ5
IHRvIHJlY292cnkgKi8KPj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKHF1ZXVlLT5jdHJsLT5j
dHJsLmRldmljZSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmV4cGVjdGVkIG52bWUg
Y29tcGxldGlvbiBsZW5ndGgoJWQpXG4iLCB3Yy0+Ynl0ZV9sZW4pOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIG52bWVfcmRtYV9lcnJvcl9yZWNvdmVyeShxdWV1ZS0+Y3RybCk7Cj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOwo+Pj4gK8KgwqDCoCB9Cj4+ICF3Yy0+Ynl0ZV9sZW4gYW5kIHdjLT5ieXRl
X2xlbiA8IGxlbiBtYXkgYmUgdGhlIHNhbWUgdHlwZSBvZiBhbm9tYWx5Lgo+PiBXaHkgZG8gZGlm
ZmVyZW50IGVycm9yIGhhbmRsaW5nPwo+PiBJbiB3aGljaCBzY2VuYXJpbyB6ZXJvIGJ5dGVzIG1l
c3NhZ2UgcmVjZWl2ZWQgZnJvbSB0YXJnZXQ/IGZhdWx0IGluamVjdCB0ZXN0IG9yIG5vcm1hbCB0
ZXN0L3J1bj8KPiAKPiBaZXJvIGJ5dGVzIG1lc3NhZ2UgY291bGQgYmUgdXNlZCBhcyB0cmFuc3Bv
cnQgbGF5ZXIga2VlcCBhbGl2ZSBtZWNoYW5pc20gKEkncyBhbHNvIGRldmVsb3BpbmcgdGFyZ2V0
IHNpZGUgdHJhbnNwb3J0IGxheWVyIGtlZXAgYWxpdmUgbm93LiBUbyByZWNsYWltIHJlc291cmNl
LCB0YXJnZXQgc2lkZSBuZWVkcyB0byBjbG9zZSBkZWFkIGNvbm5lY3Rpb25zIGV2ZW4ga2F0byBp
cyBzZXQgYXMgMCkuCm52bWUgb3ZlciBmYWJyaWMgcHJvdG9jb2wgZG8gbm90IGRlZmluZSB0aGlz
LgpNYXkgYmUgYXN5bmMgZXZlbnQgaXMgYSBvcHRpb24gZm9yIHRhcmdldCBrZWVwIGFsaXZlKGlm
IGthdG8gc2V0IGFzIDApLgo+IAo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCBpYl9kbWFfc3luY19zaW5n
bGVfZm9yX2NwdShpYmRldiwgcWUtPmRtYSwgbGVuLCBETUFfRlJPTV9ERVZJQ0UpOwo+Pj4gwqDC
oMKgwqDCoCAvKgo+Pj4gwqDCoMKgwqDCoMKgICogQUVOIHJlcXVlc3RzIGFyZSBzcGVjaWFsIGFz
IHRoZXkgZG9uJ3QgdGltZSBvdXQgYW5kIGNhbgo+Pj4KPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
