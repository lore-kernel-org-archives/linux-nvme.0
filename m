Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6573C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:18:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1342C60C41
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1342C60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OB8O7dKsBu77uAp0jeqAQQEkLs/wybEyu6D8CDYK5b8=; b=jOGRWKaMBujW0SzLE9/TQJ4bl
	ioqU+ONCLMUAdhgWz9Qs4CA7wwXR1/9Hni5uN2M3okijmsQ9vQpzkBkHQLCbp179YqJJUQ2AiZM5z
	lssS+2b0jX+nQdXKYleCVd7D/tCpMkj+lyQvupkvFSMfKqFvtmAkIbVBdCLpR7L2lvHiUb5v8mdab
	/cmJpbrV8DPQETChulentTXBN0/RRBRROmEmsoCgTDrYdg0RhAlNLZ7Qh4z6lAf1bfq74tjQLv4b0
	UjsH8+4QTSHo6taobh19R4ln2YUsorWAGdz1R9F4644Wq6+/+Wlpqv28tATaVkXwmaW/FeAkmyfTl
	jVnRhiXug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5IQV-0008I5-8C; Fri, 29 Jan 2021 01:18:19 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IQT-0008HV-BH
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:18:18 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRfYR3r1hz13nB5;
 Fri, 29 Jan 2021 09:16:11 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 09:18:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 09:18:10 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c91cb4df-6736-bc0f-9d33-ecc3e2f4f510@huawei.com>
Date: Fri, 29 Jan 2021 09:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_201817_666156_15816B2B 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjggMTc6MjMsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzI4LzIx
IDEwOjE4IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvMS8yOCAxNTo1OCwg
RGFuaWVsIFdhZ25lciB3cm90ZToKPj4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDA5OjMxOjMw
QU0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
bXVsdGlwYXRoLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4+
Pj4gQEAgLTIyMSw3ICsyMjEsNyBAQCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVfcm91bmRf
cm9iaW5fcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkLAo+Pj4+PiDCoMKgwqDCoMKgwqAg
fQo+Pj4+PiDCoMKgwqDCoMKgwqAgZm9yIChucyA9IG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwo+
Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoCBucyAhPSBvbGQ7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
IG5zICYmIG5zICE9IG9sZDsKPj4+PiBudm1lX3JvdW5kX3JvYmluX3BhdGgganVzdCBiZSBjYWxs
ZWQgd2hlbiAhIm9sZCIuCj4+Pj4gbnZtZV9uZXh0X25zIHNob3VsZCBub3QgcmV0dXJuIE5VTEwg
d2hlbiAhIm9sZCIuCj4+Pj4gSXQgc2VlbXMgdW5uZWNlc3NhcnkgdG8gYWRkIGNoZWNraW5nICJu
cyIuCj4+Pgo+Pj4gVGhlIHByb2JsZW0gaXMgd2hlbiB3ZSBlbnRlciBudm1lX3JvdW5kX3JvYmlu
X3BhdGgoKSBhbmQgdGhlcmUgaXMgbm8KPj4+IHBhdGggYXZhaWxhYmxlLiBJbiB0aGlzIGNhc2Ug
dGhlIGluaXRpYWxpemF0aW9uIG5zID0gbnZtZV9uZXh0X25zKGhlYWQsCj4+PiBvbGQpIGNvdWxk
IHJldHVybiBhIE5VTEwgcG9pbnRlci4ib2xkIiBzaG91bGQgbm90IGJlIE5VTEwsIHNvIHRoZXJl
IGlzIGF0IGxlYXN0IG9uZSBwYXRoIHRoYXQgaXMgIm9sZCIuCj4+IEl0IGlzIGltcG9zc2libGUg
dG8gcmV0dXJuIE5VTEwgZm9yIG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpLgo+IAo+IE5vLiBsaXN0
X25leHRfb3JfbnVsbF9yY3UoKS9saXN0X2ZpcnN0X29yX251bGxfcmN1KCkgd2lsbCByZXR1cm4g
TlVMTCB3aGVuIHRoZW4gZW5kIG9mIHRoZSBsaXN0IGlzIHJlYWNoZWQuCkFsdGhvdWdoIGxpc3Rf
bmV4dF9vcl9udWxsX3JjdSgpL2xpc3RfZmlyc3Rfb3JfbnVsbF9yY3UoKSBtYXkgcmV0dXJuCk5V
TEwsIGJ1dCBudm1lX25leHRfbnMoaGVhZCwgb2xkKSBhc3N1bWUgdGhhdCB0aGUgIm9sZCIgaXMg
aW4gdGhlICJoZWFkIiwKc28gbnZtZV9uZXh0X25zKGhlYWQsIG9sZCkgc2hvdWxkIG5vdCByZXR1
cm4gTlVMTC4gSWYgdGhlICJvbGQiIGlzIG5vdAppbiB0aGUgImhlYWQiLCBudm1lX25leHRfbnMo
aGVhZCwgb2xkKSB3aWxsIHJ1biBhYm5vcm1hbC4KU28gdGhlcmUgaXMgb3RoZXIgYnVnIHdoaWNo
IGNhdXNlIG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpLgoKSSByZXZpZXcgdGhlIGNvZGUgYWJvdXQg
aGVhZC0+bGlzdCBhbmQgaGVhZC0+Y3VycmVudF9wYXRoLCBJIGZpbmQgMiBidWdzCm1heSBjYXVz
ZSBudm1lX25leHRfbnMoaGVhZCwgb2xkKSBhYm5vcm1hbDoKRmlyc3QsIEkgYWxyZWFkeSBzZW5k
IHRoZSBwYXRjaC4gc2VlOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjEw
MTI4MDMzMzUxLjIyMTE2LTEtbGVuZ2NoYW9AaHVhd2VpLmNvbS8KU2Vjb25kLCBpbiBudm1lX25z
X3JlbW92ZSwgbGlzdF9kZWxfcmN1IGlzIGJlZm9yZQpudm1lX21wYXRoX2NsZWFyX2N1cnJlbnRf
cGF0aC4gVGhpcyBtYXkgY2F1c2UgIm9sZCIgaXMgZGVsZXRlZCBmcm9tIHRoZQoiaGVhZCIsIGJ1
dCBzdGlsbCB1c2UgIm9sZCIuIEknbSBub3Qgc3VyZSB0aGVyZSdzIGFueSBvdGhlcgpjb25zaWRl
cmF0aW9uIGhlcmUsIEkgd2lsbCBjaGVjayBpdCBhbmQgdHJ5IHRvIGZpeCBpdC4KPiAKPiBDaGVl
cnMsCj4gCj4gSGFubmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
