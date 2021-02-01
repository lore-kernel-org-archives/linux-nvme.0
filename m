Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BDC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 08:48:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F2864E31
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 08:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2864E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mq0bo0O8AXEPfZo1scKzTHRbsfMG1ov/FAz/QqIsVKo=; b=XL1Zg53gVSEOUnZHHGnymp/mK
	t09RX3XrgpfrG1UCfrE8q3fwx4TSwc+BSK1RNHpeaN8TSAhcui60ZtZI23EUlVUurcidjj1pqeUsr
	W/T8/zkVaX5VVY9s+E2IVM0IGci8+XYnUie5p9JVlyyaq3wlMEyORwLEJ+t2U4f4g2xhrSvynVYKb
	RIYHhEwJeIeQOmryGxevt8vSDFo3QxXDCvUEHbtUPZazPLY8h0y9kp5cBGEZ9ELl2F/a9yICd4ZfK
	ukDHi3iiZtT5XThVL+VciwVJDHRTNTQ108Xuo5CnpLR1zCcVO3KN579c5UCrBmrOnbc+FaLI1cXOV
	82e+GfjhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6UsW-0002Sy-TD; Mon, 01 Feb 2021 08:48:12 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6UsQ-0002SZ-Q8
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 08:48:08 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DThNv34v3z13pGH;
 Mon,  1 Feb 2021 16:45:51 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 1 Feb 2021 16:47:53 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 1 Feb
 2021 16:47:52 +0800
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
From: Chao Leng <lengchao@huawei.com>
Message-ID: <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
Date: Mon, 1 Feb 2021 16:47:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_034807_352509_A3C9C87C 
X-CRM114-Status: GOOD (  22.54  )
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

CgpPbiAyMDIxLzIvMSAxNToyOSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDIvMS8yMSAz
OjE2IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvMS8yOSAxNzoyMCwgSGFu
bmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4gT24gMS8yOS8yMSA5OjQ2IEFNLCBDaGFvIExlbmcgd3Jv
dGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIwMjEvMS8yOSAxNjozMywgSGFubmVzIFJlaW5lY2tlIHdy
b3RlOgo+Pj4+PiBPbiAxLzI5LzIxIDg6NDUgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4gT24gMjAyMS8xLzI5IDE1OjA2LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
Pj4+Pj4gT24gMS8yOS8yMSA0OjA3IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IE9uIDIwMjEvMS8yOSA5OjQyLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5IHdoZXJlIGl0IGRpZXMgYnV0
IEkgZm9sbG93ZWQgdGhlIGFzc2VtYmx5IHRvCj4+Pj4+Pj4+Pj4+IG52bWVfcm91bmRfcm9iaW5f
cGF0aCgpLiBNYXliZSBpdCdzIG5vdCB0aGUgaW5pdGlhbCBudm1lX25leHRfbnMoaGVhZCwKPj4+
Pj4+Pj4+Pj4gb2xkKSB3aGljaCByZXR1cm5zIE5VTEwgYnV0IG52bWVfbmV4dF9ucygpIGlzIHJl
dHVybmluZyBOVUxMIGV2ZW50dWFsbHkKPj4+Pj4+Pj4+Pj4gKGxpc3RfbmV4dF9vcl9udWxsX3Jj
dSgpKS4KPj4+Pj4+Pj4+PiBTbyB0aGVyZSBpcyBvdGhlciBidWcgY2F1c2UgbnZtZV9uZXh0X25z
IGFib3JtYWwuCj4+Pj4+Pj4+Pj4gSSByZXZpZXcgdGhlIGNvZGUgYWJvdXQgaGVhZC0+bGlzdCBh
bmQgaGVhZC0+Y3VycmVudF9wYXRoLCBJIGZpbmQgMiBidWdzCj4+Pj4+Pj4+Pj4gbWF5IGNhdXNl
IHRoZSBidWc6Cj4+Pj4+Pj4+Pj4gRmlyc3QsIEkgYWxyZWFkeSBzZW5kIHRoZSBwYXRjaC4gc2Vl
Ogo+Pj4+Pj4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyMTAxMjgw
MzMzNTEuMjIxMTYtMS1sZW5nY2hhb0BodWF3ZWkuY29tLwo+Pj4+Pj4+Pj4+IFNlY29uZCwgaW4g
bnZtZV9uc19yZW1vdmUsIGxpc3RfZGVsX3JjdSBpcyBiZWZvcmUKPj4+Pj4+Pj4+PiBudm1lX21w
YXRoX2NsZWFyX2N1cnJlbnRfcGF0aC4gVGhpcyBtYXkgY2F1c2UgIm9sZCIgaXMgZGVsZXRlZCBm
cm9tIHRoZQo+Pj4+Pj4+Pj4+ICJoZWFkIiwgYnV0IHN0aWxsIHVzZSAib2xkIi4gSSdtIG5vdCBz
dXJlIHRoZXJlJ3MgYW55IG90aGVyCj4+Pj4+Pj4+Pj4gY29uc2lkZXJhdGlvbiBoZXJlLCBJIHdp
bGwgY2hlY2sgaXQgYW5kIHRyeSB0byBmaXggaXQuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gVGhlIHJl
YXNvbiB3aHkgd2UgZmlyc3QgcmVtb3ZlIGZyb20gaGVhZC0+bGlzdCBhbmQgb25seSB0aGVuIGNs
ZWFyCj4+Pj4+Pj4+PiBjdXJyZW50X3BhdGggaXMgYmVjYXVzZSB0aGUgb3RoZXIgd2F5IGFyb3Vu
ZCB0aGVyZSBpcyBubyB3YXkKPj4+Pj4+Pj4+IHRvIGd1YXJhbnRlZSB0aGF0IHRoYXQgdGhlIG5z
IHdvbid0IGJlIGFzc2lnbmVkIGFzIGN1cnJlbnRfcGF0aAo+Pj4+Pj4+Pj4gYWdhaW4gKGJlY2F1
c2UgaXQgaXMgaW4gaGVhZC0+bGlzdCkuCj4+Pj4+Pj4+IG9rLCBJIHNlZS4KPj4+Pj4+Pj4+Cj4+
Pj4+Pj4+PiBudm1lX25zX3JlbW92ZSBmZW5jZXMgY29udGludWUgb2YgZGVsZXRpb24gb2YgdGhl
IG5zIGJ5IHN5bmNocm9uaXppbmcKPj4+Pj4+Pj4+IHRoZSBzcmN1IHN1Y2ggdGhhdCBmb3Igc3Vy
ZSB0aGUgY3VycmVudF9wYXRoIGNsZWFyYW5jZSBpcyB2aXNpYmxlLgo+Pj4+Pj4+PiBUaGUgbGlz
dCB3aWxsIGJlIGxpa2UgdGhpczoKPj4+Pj4+Pj4gaGVhZC0+bmV4dCA9IG5zMTsKPj4+Pj4+Pj4g
bnMxLT5uZXh0ID0gaGVhZDsKPj4+Pj4+Pj4gb2xkLT5uZXh0ID0gbnMxOwo+Pj4+Pj4+Cj4+Pj4+
Pj4gV2hlcmUgZG9lcyAnb2xkJyBwb2ludGluZyB0bz8KPj4+Pj4+Pgo+Pj4+Pj4+PiBUaGlzIG1h
eSBjYXVzZSBpbmZpbml0ZSBsb29wIGluIG52bWVfcm91bmRfcm9iaW5fcGF0aC4KPj4+Pj4+Pj4g
Zm9yIChucyA9IG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwo+Pj4+Pj4+PiDCoMKgwqDCoMKgbnMg
IT0gb2xkOwo+Pj4+Pj4+PiDCoMKgwqDCoMKgbnMgPSBudm1lX25leHRfbnMoaGVhZCwgbnMpKQo+
Pj4+Pj4+PiBUaGUgbnMgd2lsbCBhbHdheXMgYmUgbnMxLCBhbmQgdGhlbiBpbmZpbml0ZSBsb29w
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gTm8uIG52bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuIE5VTEwuCj4+
Pj4+PiBJZiB0aGVyZSBpcyBqdXN0IG9uZSBwYXRoKHRoZSAib2xkIikgYW5kIHRoZSAib2xkIiBp
cyBkZWxldGVkLAo+Pj4+Pj4gbnZtZV9uZXh0X25zKCkgd2lsbCByZXR1cm4gTlVMTC4KPj4+Pj4+
IFRoZSBsaXN0IGxpa2UgdGhpczoKPj4+Pj4+IGhlYWQtPm5leHQgPSBoZWFkOwo+Pj4+Pj4gb2xk
LT5uZXh0ID0gaGVhZDsKPj4+Pj4+IElmIHRoZXJlIGlzIHR3byBvciBtb3JlIHBhdGggYW5kIHRo
ZSAib2xkIiBpcyBkZWxldGVkLAo+Pj4+Pj4gImZvciIgd2lsbCBiZSBpbmZpbml0ZSBsb29wLiBi
ZWNhdXNlIG52bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuCj4+Pj4+PiB0aGUgcGF0aCB3aGljaCBp
biB0aGUgbGlzdCBleGNlcHQgdGhlICJvbGQiLCBjaGVjayBjb25kaXRpb24gd2lsbAo+Pj4+Pj4g
YmUgdHJ1ZSBmb3IgZXZlci4KPj4+Pj4KPj4+Pj4gQnV0IHRoYXQgd2lsbCBiZSBjYXVnaHQgYnkg
dGhlIHN0YXRlbWVudCBhYm92ZToKPj4+Pj4KPj4+Pj4gaWYgKGxpc3RfaXNfc2luZ3VsYXIoJmhl
YWQtPmxpc3QpKQo+Pj4+Pgo+Pj4+PiBubz8KPj4+PiBUd28gcGF0aCBqdXN0IGEgc2FtcGxlIGV4
YW1wbGUuCj4+Pj4gSWYgdGhlcmUgaXMganVzdCB0d28gcGF0aCwgd2lsbCBlbnRlciBpdCwgbWF5
IGNhdXNlIG5vIHBhdGggYnV0IHRoZXJlIGlzCj4+Pj4gYWN0dWFsbHkgb25lIHBhdGguIEl0IGlz
IGZhbHNlbHkgYXNzdW1lZCB0aGF0IHRoZSAib2xkIiBtdXN0IGJlIG5vdCBkZWxldGVkLgo+Pj4+
IElmIHRoZXJlIGlzIG1vcmUgdGhhbiB0d28gcGF0aCwgd2lsbCBjYXVzZSBpbmZpbml0ZSBsb29w
Lgo+Pj4gU28geW91IG1lYW4gd2UnbGwgbmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzPwo+Pj4KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4+PiBpbmRleCA3MTY5NjgxOWMyMjguLjhmZmNjYWY5YzE5YSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+PiArKysgYi9k
cml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4gQEAgLTIwMiwxMCArMjAyLDEyIEBAIHN0
YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqX19udm1lX2ZpbmRfcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFk
ICpoZWFkLCBpbnQgbm9kZSkKPj4+IMKgwqBzdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVfbmV4
dF9ucyhzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMgKm5zKQo+Pj4gwqDCoHsKPj4+IC3CoMKgwqDCoMKg
wqAgbnMgPSBsaXN0X25leHRfb3JfbnVsbF9yY3UoJmhlYWQtPmxpc3QsICZucy0+c2libGluZ3Ms
IHN0cnVjdCBudm1lX25zLAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNpYmxpbmdzKTsKPj4+IC3CoMKgwqDCoMKgwqAgaWYgKG5zKQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5zOwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAo
bnMpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5zID0gbGlzdF9uZXh0X29y
X251bGxfcmN1KCZoZWFkLT5saXN0LCAmbnMtPnNpYmxpbmdzLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChucykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbnM7Cj4+PiArwqDCoMKgwqDCoMKgIH0KPj4gTm8sIGlu
IHRoZSBzY2VuYXJpbywgbnMgc2hvdWxkIG5vdCBiZSBOVUxMLgo+IAo+IFdoeSBub3Q/ICducyA9
PSBOVUxMJyBpcyBwcmVjaXNlbHkgdGhlIGNvcm5lci1jYXNlIHRoaXMgaXMgdHJ5aW5nIHRvIGZp
eC4uLgo+IAo+PiBNYXkgYmUgd2UgY2FuIGRvIGxpa2UgdGhpczoKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMKPj4gaW5kZXggMjgyYjdhNGVhOWE5Li5iODk1MDExYTJjYmQgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0
L211bHRpcGF0aC5jCj4+IEBAIC0xOTksMzAgKzE5OSwyNCBAQCBzdGF0aWMgc3RydWN0IG52bWVf
bnMgKl9fbnZtZV9maW5kX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCwgaW50IG5vZGUp
Cj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZvdW5kOwo+PiDCoMKgfQo+Pgo+PiAtc3RhdGlj
IHN0cnVjdCBudm1lX25zICpudm1lX25leHRfbnMoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCwK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMgKm5zKQo+PiAt
ewo+PiAtwqDCoMKgwqDCoMKgIG5zID0gbGlzdF9uZXh0X29yX251bGxfcmN1KCZoZWFkLT5saXN0
LCAmbnMtPnNpYmxpbmdzLCBzdHJ1Y3QgbnZtZV9ucywKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpYmxpbmdzKTsKPj4gLcKgwqDCoMKgwqDCoCBpZiAo
bnMpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBuczsKPj4gLcKgwqDC
oMKgwqDCoCByZXR1cm4gbGlzdF9maXJzdF9vcl9udWxsX3JjdSgmaGVhZC0+bGlzdCwgc3RydWN0
IG52bWVfbnMsIHNpYmxpbmdzKTsKPj4gLX0KPj4gKyNkZWZpbmUgbnZtZV9uZXh0X25zX2NvbmRp
dGlvbihoZWFkLCBjdXJyZW50LCBjb25kaXRpb24pIFwKPj4gKyh7IFwKPj4gK8KgwqDCoMKgwqDC
oCBzdHJ1Y3QgbnZtZV9ucyAqX19wdHIgPSBsaXN0X25leHRfb3JfbnVsbF9yY3UoJihoZWFkKS0+
bGlzdCwgXAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmKGN1cnJlbnQpLT5zaWJs
aW5ncywgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsgXAo+PiArwqDCoMKgwqDCoMKgIF9fcHRy
ID8gX19wdHIgOiAoY29uZGl0aW9uKSA/IChjb25kaXRpb24pID0gZmFsc2UsIFwKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9maXJzdF9vcl9udWxsX3JjdSgmKGhlYWQpLT5s
aXN0LCBzdHJ1Y3QgbnZtZV9ucywgXAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2libGluZ3MpIDogTlVMTDsgXAo+PiArfSkKPj4KPiBVcmdoLiBQbGVh
c2UsIG5vLiBUaGF0IGlzIHdlbGwgaW1wb3NzaWJsZSB0byBkZWJ1Zy4KPiBDYW4geW91IHBsZWFz
ZSBvcGVuLWNvZGUgaXQgdG8gZGVtb25zdHJhdGUgd2hlcmUgdGhlIGRpZmZlcmVuY2UgdG8gdGhl
IGN1cnJlbnQgKGFuZCBteSBmaXhlZCkgdmVyc2lvbnMgaXM/Cj4gSSdtIHN0aWxsIG5vdCBjbGVh
ciB3aGVyZSB0aGUgcHJvYmxlbSBpcyBvbmNlIHdlIGFwcGxpZWQgYm90aCBwYXRjaGVzLgpGb3Ig
ZXhhbXBsZSBhc3N1bWUgdGhlIGxpc3QgaGFzIHRocmVlIHBhdGgsIGFuZCBhbGwgcGF0aCBpcyBu
b3QgTlZNRV9BTkFfT1BUSU1JWkVEOgpoZWFkLT5uZXh0ID0gbnMxOwpuczEtPm5leHQgPSBuczI7
Cm5zMi0+bmV4dCA9IGhlYWQ7Cm9sZC0+bmV4dCA9IG5zMjsKCk15IHBhdGNoIHdvcmsgZmxvdzoK
bnZtZV9uZXh0X25zX2NvbmRpdGlvbihoZWFkLCBvbGQsIHRydWUpIHJldHVybiBuczI7Cm52bWVf
bmV4dF9uc19jb25kaXRpb24oaGVhZCwgbnMyLCB0cnVlKSBjaGFuZ2UgdGhlIGNvbmRpdGlvbiB0
byBmYWxzZQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuZCByZXR1
cm4gbnMxOwpudm1lX25leHRfbnNfY29uZGl0aW9uKGhlYWQsIG5zMSwgZmFsc2UpIHJldHVybiBu
czI7Cm52bWVfbmV4dF9uc19jb25kaXRpb24oaGVhZCwgbnMyLCBmYWxzZSkgcmV0dXJuIE5VTEw7
CkFuZCB0aGVuIHRoZSBsb29wIGVuZC4KCllvdXIgcGF0Y2ggd29yayBmbG93Ogpudm1lX25leHRf
bnMoaGVhZCwgb2xkKSByZXR1cm4gbnMyOwpudm1lX25leHRfbnMoaGVhZCwgbnMyKSByZXR1cm4g
bnMxOwpudm1lX25leHRfbnMoaGVhZCwgbnMxKSByZXR1cm4gbnMyOwpudm1lX25leHRfbnMoaGVh
ZCwgbnMyKSByZXR1cm4gbnMxOwpudm1lX25leHRfbnMoaGVhZCwgbnMxKSByZXR1cm4gbnMyOwpB
bmQgdGhlbiB0aGUgbG9vcCBpcyBpbmZpbml0ZS4KPiAKPiBDaGVlcnMsCj4gCj4gSGFubmVzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
