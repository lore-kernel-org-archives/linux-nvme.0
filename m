Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF50C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:12:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAF9601FB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAF9601FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lFHkfs5Szz6gqq0NgoNwuOo4Wk5bebS5aP7DT/DC7ps=; b=gh/wvYXqVUXqApi6zjB+T7NuC
	mnTwJ7B96tWFCTDzjhWV7QrwT9jQ3Jz9L1WZJktV7MSX2JuJsiG1MkXuZhUvVWrpUjjtRAh1iaL94
	HKoAbVfL+J8eG85mqp8ANf6n4hvpF/4gNNtvKIG2XhZ5QvNtyjAw4VC8qmtSPoGxx2N2x0Zaizl9P
	zRV0otQMvaO89nhfrxODpcSkP28pdqXqtpfFEGK+3eEZcLlvn/3kUjywqnpd30pB6MumGcOHWqKfg
	M8iTgWclPEypuGNDIpXj2+31CPSF+XeYmyPe8xKpSrMsfyn442ExCEf5+MykeNKDUMrlW0u9blbmO
	Dcwht1xoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6kFI-0001Kg-RW; Tue, 02 Feb 2021 01:12:44 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6kFF-0001Jz-4E
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 01:12:42 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DV6G62tJzzR969;
 Tue,  2 Feb 2021 09:11:26 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Feb 2021 09:12:31 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 2 Feb
 2021 09:12:30 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, "Daniel
 Wagner" <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
 <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
 <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
 <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
 <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
 <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
 <2752ed93-6bd5-1a13-0e05-b91e2dcc24e1@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6ef6df55-318b-887d-b14f-62cae6419b4a@huawei.com>
Date: Tue, 2 Feb 2021 09:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2752ed93-6bd5-1a13-0e05-b91e2dcc24e1@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_201241_685825_75C29B8D 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzIvMSAxODo0NSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDIvMS8yMSAx
MDo0MCBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDIxLzIvMSAxNjo1NywgSGFu
bmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4gT24gMi8xLzIxIDk6NDcgQU0sIENoYW8gTGVuZyB3cm90
ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS8yLzEgMTU6MjksIEhhbm5lcyBSZWluZWNrZSB3cm90
ZTpbIC4uIF0KPj4+Pj4gVXJnaC4gUGxlYXNlLCBuby4gVGhhdCBpcyB3ZWxsIGltcG9zc2libGUg
dG8gZGVidWcuCj4+Pj4+IENhbiB5b3UgcGxlYXNlIG9wZW4tY29kZSBpdCB0byBkZW1vbnN0cmF0
ZSB3aGVyZSB0aGUgZGlmZmVyZW5jZSB0byB0aGUgY3VycmVudCAoYW5kIG15IGZpeGVkKSB2ZXJz
aW9ucyBpcz8KPj4+Pj4gSSdtIHN0aWxsIG5vdCBjbGVhciB3aGVyZSB0aGUgcHJvYmxlbSBpcyBv
bmNlIHdlIGFwcGxpZWQgYm90aCBwYXRjaGVzLgo+Pj4+IEZvciBleGFtcGxlIGFzc3VtZSB0aGUg
bGlzdCBoYXMgdGhyZWUgcGF0aCwgYW5kIGFsbCBwYXRoIGlzIG5vdCBOVk1FX0FOQV9PUFRJTUla
RUQ6Cj4+Pj4gaGVhZC0+bmV4dCA9IG5zMTsKPj4+PiBuczEtPm5leHQgPSBuczI7Cj4+Pj4gbnMy
LT5uZXh0ID0gaGVhZDsKPj4+PiBvbGQtPm5leHQgPSBuczI7Cj4+Pj4KPj4+IEFuZCB0aGlzIGlz
IHdoZXJlIEkgaGF2ZSBpc3N1ZXMgd2l0aC4KPj4+IFdoZXJlIGRvZXMgJ29sZCcgY29tZSBmcm9t
Pwo+Pj4gQ2xlYXJseSBpdCB3YXMgcGFydCBvZiB0aGUgbGlzdCBhdCBvbmUgcG9pbnQ7IHNvIHdo
YXQgaGFwcGVuZWQgdG8gaXQ/Cj4+IEkgZXhwbGFpbmVkIHRoaXMgZWFybGllci4KPj4gSW4gbnZt
ZV9uc19yZW1vdmUsIHRoZXJlIGlzIGEgaG9sZSBiZXR3ZWVuIGxpc3RfZGVsX3JjdSBhbmQKPj4g
bnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50X3BhdGguIElmIGhlYWQtPmN1cnJlbnRfcGF0aCBpcyB0
aGUgIm9sZCIsIGFuZAo+PiB0aGUgIm9sZCIgaXMgcmVtb3ZpbmcuIFRoZSAib2xkIiBpcyBhbHJl
YWR5IHJlbW92ZWQgZnJvbSB0aGUgbGlzdCBieQo+PiBsaXN0X2RlbF9yY3UsIGJ1dCBoZWFkLT5j
dXJyZW50X3BhdGggaXMgbm90IGNsZWFyIHRvIE5VTEwgYnkKPj4gbnZtZV9tcGF0aF9jbGVhcl9j
dXJyZW50X3BhdGguCj4+IEZpbmQgcGF0aCBpcyByYWNlIHdpdGggbnZtZV9uc19yZW1vdmUsIHVz
ZSB0aGUgIm9sZCIgcGFzcyB0bwo+PiBudm1lX3JvdW5kX3JvYmluX3BhdGggdG8gZmluZCBwYXRo
Lgo+IAo+IEFoLiBTbyB0aGlzIHNob3VsZCBiZSBiZXR0ZXI6Cj4gCj4gQEAgLTIwMiwxMCArMjAy
LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqX19udm1lX2ZpbmRfcGF0aChzdHJ1Y3QgbnZt
ZV9uc19oZWFkICpoZWFkLCBpbnQgbm9kZSkKPiAgwqBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52
bWVfbmV4dF9ucyhzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkLAo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMgKm5zKQo+ICDCoHsKPiAtwqDCoMKgwqDCoMKg
IG5zID0gbGlzdF9uZXh0X29yX251bGxfcmN1KCZoZWFkLT5saXN0LCAmbnMtPnNpYmxpbmdzLCBz
dHJ1Y3QgbnZtZV9ucywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2libGluZ3MpOwo+IC3CoMKgwqDCoMKgwqAgaWYgKG5zKQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBuczsKPiArwqDCoMKgwqDCoMKgIGlmIChucyAmJiAhdGVz
dF9iaXQoTlZNRV9OU19SRU1PVklORywgJm5zLT5mbGFncykpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBucyA9IGxpc3RfbmV4dF9vcl9udWxsX3JjdSgmaGVhZC0+bGlzdCwgJm5z
LT5zaWJsaW5ncywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9ucywg
c2libGluZ3MpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChucykKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5zOwo+ICvC
oMKgwqDCoMKgwqAgfQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbGlzdF9maXJzdF9vcl9udWxs
X3JjdSgmaGVhZC0+bGlzdCwgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsKPiAgwqB9Cj4gCj4g
VGhlICdOVk1FX05TX1JFTU9WSU5HJyBiaXQgaXMgc2V0IGJlZm9yZSBsaXN0X2RlbF9yY3UoKSBp
cyBjYWxsZWQsIHNvIGl0IHNob3VsZCBndWFyZCBhZ2FpbnN0IHRoZSBpc3N1ZSB5b3UgbWVudGlv
bmVkLgpMb29rcyB1c2VsZXNzLCBpdCBpcyBzdGlsbCBpbmZpbml0ZSBsb29wLiBZb3UgY2FuIGNo
ZWNrIHRoZSB3b3JrZmxvdyBmb3IgdGhlIHNjZW5hcmlvIEkgbWVudGlvbmVkLgo+IAo+IENoZWVy
cywKPiAKPiBIYW5uZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
