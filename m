Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B80C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 01:08:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0326D20738
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 01:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1CeiEyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0326D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4WIkuze33kp1wIyurKQToHae3mj2bIae3JLn6kjbK8Q=; b=J1CeiEyAYH1d40haZk9n//3MH
	mZxC4a8s2kEFsynISBPWgbi43svgvQM/Tg01NS6Rd+8Q3Y2+LxPsfvUJ0pj0C0Qb6xG+5R+z5SBa4
	NZPKCzgR0E9JeY3u1PqMwV05ANvICP+brr/S6wy1v34Svm46QVR0irJGehT768C5v/uRtquju5I4l
	bou8mjNE5eyfqWDvDbFAbL5XQGVZ2w9aDHRRssZfEvd24Mmb62+hE3VZe3g5+ukg6By/ZqGpybkL7
	YpHxwi9VFPJ7qx5uB+nNsvb3DLEya/TEedZf3spehU+Bhfk17VPeWjpWIM/kIXn3hv4ELrNdVjodU
	YA2/1ge5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k37uJ-0005yz-6c; Wed, 05 Aug 2020 01:07:51 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k37uF-0005yK-Dw
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 01:07:48 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 277EF1B171BC1A665E7C;
 Wed,  5 Aug 2020 09:07:31 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 5 Aug 2020 09:07:27 +0800
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, James Smart
 <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
Date: Wed, 5 Aug 2020 09:07:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200804_210747_712782_0061FF0C 
X-CRM114-Status: GOOD (  17.30  )
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

CgpPbiAyMDIwLzgvNCAyMzozNiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+Pj4gK3N0YXRp
YyB2b2lkIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IHJlcXVlc3QgKnJxKQo+
Pj4+PiArewo+Pj4+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JkbWFfcmVxdWVzdCAqcmVxID0gYmxr
X21xX3JxX3RvX3BkdShycSk7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IG52bWVfcmRtYV9xdWV1ZSAq
cXVldWUgPSByZXEtPnF1ZXVlOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JkbWFfY3RybCAq
Y3RybCA9IHF1ZXVlLT5jdHJsOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgLyogZmVuY2Ugb3RoZXIg
Y29udGV4dHMgdGhhdCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPj4+Pj4gK8KgwqDCoCBm
bHVzaF93b3JrKCZjdHJsLT5lcnJfd29yayk7Cj4+Pj4+ICvCoMKgwqAgbnZtZV9yZG1hX3N0b3Bf
cXVldWUocXVldWUpOwo+Pj4+IFRoZXJlIG1heWJlIGNvbmN1cnJlbnQgd2l0aCBlcnJvciByZWNv
dmVyeSwgbWF5IGNhdXNlIGFibm9ybWFsIGJlY2F1c2UKPj4+PiBudm1lX3JkbWFfc3RvcF9xdWV1
ZSB3aWxsIHJldHVybiBidXQgdGhlIHF1ZXVlIGlzIG5vdCBzdG9wZWQsCj4+Pj4gbWF5YmUgaXMg
c3RvcHBpbmcgYnkgdGhlIGVycm9yIHJlY292ZXJ5Lgo+Pj4KPj4+IGVycl93b3JrIGZsdXNoIHVz
ZWQgdG8gZmVuY2UsIG9uY2Ugd2UgZGlkIHF1ZXVlIHN0b3AsIGl0IHNob3VsZCBiZSBzYWZlCj4+
PiB0byBjb21wbGV0ZSB0aGUgY29tbWFuZCBmcm9tIHRoZSB0aW1lb3V0IGhhbmRsZXIuCj4+Cj4+
IEZsdXNoIHdvcmsganVzdCBjYW4gYXZvaWQgdHJpZ2dlciBlcnJvciByZWNvdmVyeSBieSBudm1l
X3JkbWFfdGltZW91dCBvcgo+PiByZWR1Y2UgY29uY3VycmVudCBwcm9iYWxpYml0eSB0cmlnZ2Vy
IGVycm9yIHJlY292ZXJ5IGJ5IG90aGVyIHByb2dyZXNzLAo+PiBidXQgY2FuIG5vdCBhdm9pZC4K
PiAKPiBUaGUgcG9pbnQgaXMgdGhhdCB3ZSBjYW4gY29tcGxldGUgdGhlIGNvbW1hbmQgYmVjYXVz
ZSBlcnJfd29yawo+IHdhcyBmbHVzaGVkIGFuZCB0aGUgcXVldWUgd2FzIHN0b3BwZWQsIHdoaWNo
IG1lYW5zIHdlIHNob3VsZG4ndCBoYXZlCj4gYW55IGNvbnRleHQgY29tcGxldGluZyB0aGUgcmVx
dWVzdC4KPiAKPj4gaWYgbnZtZV9yZG1hX2NtX2hhbmRsZXIgb3Igb3RoZXIgcHJvZ3Jlc3MgY2Fs
bAo+PiBudm1lX3JkbWFfZXJyb3JfcmVjb3ZlcnksIGJldHdlZW4gY2hhbmdlIHN0YXRlIHRvIHF1
ZXVlX3dvcmsgbWF5Cj4+IGludGVycnVwdCBieSBoYXJkIGludGVycnVwdCwgYW5kIHRoZW4gdGlt
ZW91dCBoYXBwZW4sIHRodXMgZmx1c2ggd29yawo+PiBjYW4gbm90IGF2b2lkIGNvbmN1cnJlbnQu
Cj4+IExpa2UgdGhpczoKPj4KPj4gc3RhdGljIHZvaWQgbnZtZV9yZG1hX2Vycm9yX3JlY292ZXJ5
KHN0cnVjdCBudm1lX3JkbWFfY3RybCAqY3RybCkKPj4gewo+PiDCoMKgwqDCoMKgaWYgKCFudm1l
X2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBOVk1FX0NUUkxfUkVTRVRUSU5HKSkKPj4g
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gCj4gSWYgd2UgYXJlIGluIFJFU0VUVElORy9DT05ORUNUSU5HIHN0YXRlIGFscmVhZHks
IHRoaXMgd29uJ3QgZG8gYW55dGhpbmcuCj4gCj4+IG1heSBpbnRlcnJ1cHQgYnkgaGFyZCBpbnRl
cnJ1cHQsIGFuZCB0aGVuIHRpbWVvdXQgcHJvZ3Jlc3MgZmx1c2ggd29yawo+PiBhdCB0aGlzIHRp
bWUuIFRodXMgZXJyb3IgcmVjb3ZlcnkgYW5kIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQg
bWF5Cj4+IGNvbmN1cnJlbnQgdG8gc3RvcCBxdWV1ZS4gd2lsbCBjYXVzZTogZXJyb3IgcmVjb3Zl
cnkgbWF5IGNhbmNlbCByZXF1ZXN0Cj4+IG9yIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQg
bWF5IGNvbXBsZXRlIHJlcXVlc3QsIGJ1dCB0aGUgcXVldWUgbWF5Cj4+IG5vdCBiZSBzdG9wZWQu
IFRodXMgd2lsbCBjYXVzZSBhYm5vcm1hbC4KPiAKPiBXZSBzaG91bGQgYmUgZmluZSBhbmQgc2Fm
ZSB0byBjb21wbGV0ZSB0aGUgSS9PLgoKQ29tcGxldGUgcmVxdWVzdCBpbiBudm1lX3JkbWFfdGlt
ZW91dCBvciBjYW5jZWwgcmVxdWVzdCBpbgpudm1lX3JkbWFfZXJyb3JfcmVjb3Zlcnlfd29yayBv
ciBudm1lX3JkbWFfcmVzZXRfY3RybF93b3JrIGlzIG5vdCBzYWZlLgpCZWNhdXNlIHRoZSBxdWV1
ZSBtYXkgYmUgbm90IHJlYWxseSBzdG9wZWQsIGl0IG1heSBqdXN0IGNsZWFyZCB0aGUgZmxhZzoK
TlZNRV9SRE1BX1FfQUxMT0NBVEVEIGZvciB0aGUgcXVldWUuIFRodXMgb25lIHJlcXVlc3QgbWF5
IGNvbmN1cnJlbnQKdHJlYXQgYnkgdHdvIHByb2dyZXNzLCBpdCBpcyBub3QgYWxsb3dlZC4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
