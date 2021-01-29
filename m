Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 08:46:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301F364E13
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 08:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F364E13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T68ryp+FasjabYeP77mVPv2pBFJHw67rT6+NStGsYzo=; b=m3Ug+CFRW8Vs2BZZMHNsVyoa2
	fgj4VfbgMNwu4FvkMn06/q6524coUAd0DUNU783e0mn82AfdjPDnvJv4Yhg+cSmeIC5/pIPNt4iK8
	ELBUcvWheT2VyKNsNrrgvvMyaf06R6SWmMGVowF2yT8eETWUkiAi9KisFwjWuq80gpRgNQfmrVQlH
	drvd54Z6Kui6YO39PwPxDpsZ+6p2Rrcx8msv7uGE7e9VlpQtN7rMDEuuTYXFrxoER3MQXD4zYID7a
	ZaCV2zW3oNRdnJAHg1j13VJ3lkQ7FhQjwCFNdIZJSS0XaMpDmdP1ZUGfoBkMpqUSgonxJ7XCdl33h
	De1BYfVXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5PQC-0007O9-Oy; Fri, 29 Jan 2021 08:46:28 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5PQ9-0007N3-W1
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 08:46:27 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DRrWW3KYjzY3h3;
 Fri, 29 Jan 2021 16:45:11 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 16:46:18 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 16:46:17 +0800
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
From: Chao Leng <lengchao@huawei.com>
Message-ID: <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
Date: Fri, 29 Jan 2021 16:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_034626_561453_75C3F6B7 
X-CRM114-Status: GOOD (  16.11  )
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

CgpPbiAyMDIxLzEvMjkgMTY6MzMsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzI5LzIx
IDg6NDUgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS8xLzI5IDE1OjA2LCBI
YW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiAxLzI5LzIxIDQ6MDcgQU0sIENoYW8gTGVuZyB3
cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS8xLzI5IDk6NDIsIFNhZ2kgR3JpbWJlcmcgd3Jv
dGU6Cj4+Pj4+Cj4+Pj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5IHdoZXJlIGl0IGRpZXMgYnV0
IEkgZm9sbG93ZWQgdGhlIGFzc2VtYmx5IHRvCj4+Pj4+Pj4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRo
KCkuIE1heWJlIGl0J3Mgbm90IHRoZSBpbml0aWFsIG52bWVfbmV4dF9ucyhoZWFkLAo+Pj4+Pj4+
IG9sZCkgd2hpY2ggcmV0dXJucyBOVUxMIGJ1dCBudm1lX25leHRfbnMoKSBpcyByZXR1cm5pbmcg
TlVMTCBldmVudHVhbGx5Cj4+Pj4+Pj4gKGxpc3RfbmV4dF9vcl9udWxsX3JjdSgpKS4KPj4+Pj4+
IFNvIHRoZXJlIGlzIG90aGVyIGJ1ZyBjYXVzZSBudm1lX25leHRfbnMgYWJvcm1hbC4KPj4+Pj4+
IEkgcmV2aWV3IHRoZSBjb2RlIGFib3V0IGhlYWQtPmxpc3QgYW5kIGhlYWQtPmN1cnJlbnRfcGF0
aCwgSSBmaW5kIDIgYnVncwo+Pj4+Pj4gbWF5IGNhdXNlIHRoZSBidWc6Cj4+Pj4+PiBGaXJzdCwg
SSBhbHJlYWR5IHNlbmQgdGhlIHBhdGNoLiBzZWU6Cj4+Pj4+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1udm1lLzIwMjEwMTI4MDMzMzUxLjIyMTE2LTEtbGVuZ2NoYW9AaHVhd2VpLmNv
bS8KPj4+Pj4+IFNlY29uZCwgaW4gbnZtZV9uc19yZW1vdmUsIGxpc3RfZGVsX3JjdSBpcyBiZWZv
cmUKPj4+Pj4+IG52bWVfbXBhdGhfY2xlYXJfY3VycmVudF9wYXRoLiBUaGlzIG1heSBjYXVzZSAi
b2xkIiBpcyBkZWxldGVkIGZyb20gdGhlCj4+Pj4+PiAiaGVhZCIsIGJ1dCBzdGlsbCB1c2UgIm9s
ZCIuIEknbSBub3Qgc3VyZSB0aGVyZSdzIGFueSBvdGhlcgo+Pj4+Pj4gY29uc2lkZXJhdGlvbiBo
ZXJlLCBJIHdpbGwgY2hlY2sgaXQgYW5kIHRyeSB0byBmaXggaXQuCj4+Pj4+Cj4+Pj4+IFRoZSBy
ZWFzb24gd2h5IHdlIGZpcnN0IHJlbW92ZSBmcm9tIGhlYWQtPmxpc3QgYW5kIG9ubHkgdGhlbiBj
bGVhcgo+Pj4+PiBjdXJyZW50X3BhdGggaXMgYmVjYXVzZSB0aGUgb3RoZXIgd2F5IGFyb3VuZCB0
aGVyZSBpcyBubyB3YXkKPj4+Pj4gdG8gZ3VhcmFudGVlIHRoYXQgdGhhdCB0aGUgbnMgd29uJ3Qg
YmUgYXNzaWduZWQgYXMgY3VycmVudF9wYXRoCj4+Pj4+IGFnYWluIChiZWNhdXNlIGl0IGlzIGlu
IGhlYWQtPmxpc3QpLgo+Pj4+IG9rLCBJIHNlZS4KPj4+Pj4KPj4+Pj4gbnZtZV9uc19yZW1vdmUg
ZmVuY2VzIGNvbnRpbnVlIG9mIGRlbGV0aW9uIG9mIHRoZSBucyBieSBzeW5jaHJvbml6aW5nCj4+
Pj4+IHRoZSBzcmN1IHN1Y2ggdGhhdCBmb3Igc3VyZSB0aGUgY3VycmVudF9wYXRoIGNsZWFyYW5j
ZSBpcyB2aXNpYmxlLgo+Pj4+IFRoZSBsaXN0IHdpbGwgYmUgbGlrZSB0aGlzOgo+Pj4+IGhlYWQt
Pm5leHQgPSBuczE7Cj4+Pj4gbnMxLT5uZXh0ID0gaGVhZDsKPj4+PiBvbGQtPm5leHQgPSBuczE7
Cj4+Pgo+Pj4gV2hlcmUgZG9lcyAnb2xkJyBwb2ludGluZyB0bz8KPj4+Cj4+Pj4gVGhpcyBtYXkg
Y2F1c2UgaW5maW5pdGUgbG9vcCBpbiBudm1lX3JvdW5kX3JvYmluX3BhdGguCj4+Pj4gZm9yIChu
cyA9IG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwo+Pj4+IMKgwqDCoMKgwqBucyAhPSBvbGQ7Cj4+
Pj4gwqDCoMKgwqDCoG5zID0gbnZtZV9uZXh0X25zKGhlYWQsIG5zKSkKPj4+PiBUaGUgbnMgd2ls
bCBhbHdheXMgYmUgbnMxLCBhbmQgdGhlbiBpbmZpbml0ZSBsb29wLgo+Pj4KPj4+IE5vLiBudm1l
X25leHRfbnMoKSB3aWxsIHJldHVybiBOVUxMLgo+PiBJZiB0aGVyZSBpcyBqdXN0IG9uZSBwYXRo
KHRoZSAib2xkIikgYW5kIHRoZSAib2xkIiBpcyBkZWxldGVkLAo+PiBudm1lX25leHRfbnMoKSB3
aWxsIHJldHVybiBOVUxMLgo+PiBUaGUgbGlzdCBsaWtlIHRoaXM6Cj4+IGhlYWQtPm5leHQgPSBo
ZWFkOwo+PiBvbGQtPm5leHQgPSBoZWFkOwo+PiBJZiB0aGVyZSBpcyB0d28gb3IgbW9yZSBwYXRo
IGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRlZCwKPj4gImZvciIgd2lsbCBiZSBpbmZpbml0ZSBsb29w
LiBiZWNhdXNlIG52bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuCj4+IHRoZSBwYXRoIHdoaWNoIGlu
IHRoZSBsaXN0IGV4Y2VwdCB0aGUgIm9sZCIsIGNoZWNrIGNvbmRpdGlvbiB3aWxsCj4+IGJlIHRy
dWUgZm9yIGV2ZXIuCj4gCj4gQnV0IHRoYXQgd2lsbCBiZSBjYXVnaHQgYnkgdGhlIHN0YXRlbWVu
dCBhYm92ZToKPiAKPiBpZiAobGlzdF9pc19zaW5ndWxhcigmaGVhZC0+bGlzdCkpCj4gCj4gbm8/
ClR3byBwYXRoIGp1c3QgYSBzYW1wbGUgZXhhbXBsZS4KSWYgdGhlcmUgaXMganVzdCB0d28gcGF0
aCwgd2lsbCBlbnRlciBpdCwgbWF5IGNhdXNlIG5vIHBhdGggYnV0IHRoZXJlIGlzCmFjdHVhbGx5
IG9uZSBwYXRoLiBJdCBpcyBmYWxzZWx5IGFzc3VtZWQgdGhhdCB0aGUgIm9sZCIgbXVzdCBiZSBu
b3QgZGVsZXRlZC4KSWYgdGhlcmUgaXMgbW9yZSB0aGFuIHR3byBwYXRoLCB3aWxsIGNhdXNlIGlu
ZmluaXRlIGxvb3AuCj4gCj4gQ2hlZXJzLAo+IAo+IEhhbm5lcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
