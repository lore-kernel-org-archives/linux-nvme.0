Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC01C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595BC64E22
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595BC64E22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ueRBj2woa1c9QaiUGC36LS5rghvm7KNvJRvPWj09UDs=; b=VzprmtM7UXi8GN6yC2Gk5yQuB
	vOF44KmOIZiYnzZjH/Sg+eEKoqbe2rOWTO67eLZjiNL3+CB1lJFZMHlAmIgNTLL/jj/j7PPoiSMPR
	fe54/IkOSpxdKsL/u6UXdhO9rOXF0VRDnMhWGsq+1C2Qpf8lmKD27IiWV0m5yB22NNTxcSpYyPoTX
	z+viwTjI9LxY/YlAUTYO1uZJ5NjFBhbBCFGA7rFk/ccZ09tvn0YeXztJoAzbl4s9zuDuhH2OhjC9s
	w+9OyiuVVI/OWjHaUKj/wBlxjq0RxeMKr204ClPvKJ/1oaW4+saTtDCTwUegvWi3Iwl23qflrccci
	2t9JmAD/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Tet-0006Pq-Ba; Mon, 01 Feb 2021 07:30:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Teq-0006Ox-Lz
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 07:30:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BA620AD19;
 Mon,  1 Feb 2021 07:29:57 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
Date: Mon, 1 Feb 2021 08:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_023000_988394_22805A97 
X-CRM114-Status: GOOD (  30.75  )
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

T24gMi8xLzIxIDM6MTYgQU0sIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIxLzEvMjkg
MTc6MjAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gMS8yOS8yMSA5OjQ2IEFNLCBDaGFv
IExlbmcgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIwMjEvMS8yOSAxNjozMywgSGFubmVzIFJlaW5l
Y2tlIHdyb3RlOgo+Pj4+IE9uIDEvMjkvMjEgODo0NSBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+
Pgo+Pj4+Pgo+Pj4+PiBPbiAyMDIxLzEvMjkgMTU6MDYsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToK
Pj4+Pj4+IE9uIDEvMjkvMjEgNDowNyBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+Pj4+Cj4+Pj4+
Pj4KPj4+Pj4+PiBPbiAyMDIxLzEvMjkgOTo0MiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBZb3UgY2FuJ3Qgc2VlIGV4YWN0bHkgd2hlcmUgaXQgZGllcyBidXQgSSBm
b2xsb3dlZCB0aGUgCj4+Pj4+Pj4+Pj4gYXNzZW1ibHkgdG8KPj4+Pj4+Pj4+PiBudm1lX3JvdW5k
X3JvYmluX3BhdGgoKS4gTWF5YmUgaXQncyBub3QgdGhlIGluaXRpYWwgCj4+Pj4+Pj4+Pj4gbnZt
ZV9uZXh0X25zKGhlYWQsCj4+Pj4+Pj4+Pj4gb2xkKSB3aGljaCByZXR1cm5zIE5VTEwgYnV0IG52
bWVfbmV4dF9ucygpIGlzIHJldHVybmluZyBOVUxMIAo+Pj4+Pj4+Pj4+IGV2ZW50dWFsbHkKPj4+
Pj4+Pj4+PiAobGlzdF9uZXh0X29yX251bGxfcmN1KCkpLgo+Pj4+Pj4+Pj4gU28gdGhlcmUgaXMg
b3RoZXIgYnVnIGNhdXNlIG52bWVfbmV4dF9ucyBhYm9ybWFsLgo+Pj4+Pj4+Pj4gSSByZXZpZXcg
dGhlIGNvZGUgYWJvdXQgaGVhZC0+bGlzdCBhbmQgaGVhZC0+Y3VycmVudF9wYXRoLCBJIAo+Pj4+
Pj4+Pj4gZmluZCAyIGJ1Z3MKPj4+Pj4+Pj4+IG1heSBjYXVzZSB0aGUgYnVnOgo+Pj4+Pj4+Pj4g
Rmlyc3QsIEkgYWxyZWFkeSBzZW5kIHRoZSBwYXRjaC4gc2VlOgo+Pj4+Pj4+Pj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDIxMDEyODAzMzM1MS4yMjExNi0xLWxlbmdjaGFv
QGh1YXdlaS5jb20vIAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFNlY29uZCwgaW4gbnZtZV9uc19yZW1v
dmUsIGxpc3RfZGVsX3JjdSBpcyBiZWZvcmUKPj4+Pj4+Pj4+IG52bWVfbXBhdGhfY2xlYXJfY3Vy
cmVudF9wYXRoLiBUaGlzIG1heSBjYXVzZSAib2xkIiBpcyBkZWxldGVkIAo+Pj4+Pj4+Pj4gZnJv
bSB0aGUKPj4+Pj4+Pj4+ICJoZWFkIiwgYnV0IHN0aWxsIHVzZSAib2xkIi4gSSdtIG5vdCBzdXJl
IHRoZXJlJ3MgYW55IG90aGVyCj4+Pj4+Pj4+PiBjb25zaWRlcmF0aW9uIGhlcmUsIEkgd2lsbCBj
aGVjayBpdCBhbmQgdHJ5IHRvIGZpeCBpdC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhlIHJlYXNvbiB3
aHkgd2UgZmlyc3QgcmVtb3ZlIGZyb20gaGVhZC0+bGlzdCBhbmQgb25seSB0aGVuIGNsZWFyCj4+
Pj4+Pj4+IGN1cnJlbnRfcGF0aCBpcyBiZWNhdXNlIHRoZSBvdGhlciB3YXkgYXJvdW5kIHRoZXJl
IGlzIG5vIHdheQo+Pj4+Pj4+PiB0byBndWFyYW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24ndCBi
ZSBhc3NpZ25lZCBhcyBjdXJyZW50X3BhdGgKPj4+Pj4+Pj4gYWdhaW4gKGJlY2F1c2UgaXQgaXMg
aW4gaGVhZC0+bGlzdCkuCj4+Pj4+Pj4gb2ssIEkgc2VlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBudm1l
X25zX3JlbW92ZSBmZW5jZXMgY29udGludWUgb2YgZGVsZXRpb24gb2YgdGhlIG5zIGJ5IAo+Pj4+
Pj4+PiBzeW5jaHJvbml6aW5nCj4+Pj4+Pj4+IHRoZSBzcmN1IHN1Y2ggdGhhdCBmb3Igc3VyZSB0
aGUgY3VycmVudF9wYXRoIGNsZWFyYW5jZSBpcyB2aXNpYmxlLgo+Pj4+Pj4+IFRoZSBsaXN0IHdp
bGwgYmUgbGlrZSB0aGlzOgo+Pj4+Pj4+IGhlYWQtPm5leHQgPSBuczE7Cj4+Pj4+Pj4gbnMxLT5u
ZXh0ID0gaGVhZDsKPj4+Pj4+PiBvbGQtPm5leHQgPSBuczE7Cj4+Pj4+Pgo+Pj4+Pj4gV2hlcmUg
ZG9lcyAnb2xkJyBwb2ludGluZyB0bz8KPj4+Pj4+Cj4+Pj4+Pj4gVGhpcyBtYXkgY2F1c2UgaW5m
aW5pdGUgbG9vcCBpbiBudm1lX3JvdW5kX3JvYmluX3BhdGguCj4+Pj4+Pj4gZm9yIChucyA9IG52
bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwo+Pj4+Pj4+IMKgwqDCoMKgwqBucyAhPSBvbGQ7Cj4+Pj4+
Pj4gwqDCoMKgwqDCoG5zID0gbnZtZV9uZXh0X25zKGhlYWQsIG5zKSkKPj4+Pj4+PiBUaGUgbnMg
d2lsbCBhbHdheXMgYmUgbnMxLCBhbmQgdGhlbiBpbmZpbml0ZSBsb29wLgo+Pj4+Pj4KPj4+Pj4+
IE5vLiBudm1lX25leHRfbnMoKSB3aWxsIHJldHVybiBOVUxMLgo+Pj4+PiBJZiB0aGVyZSBpcyBq
dXN0IG9uZSBwYXRoKHRoZSAib2xkIikgYW5kIHRoZSAib2xkIiBpcyBkZWxldGVkLAo+Pj4+PiBu
dm1lX25leHRfbnMoKSB3aWxsIHJldHVybiBOVUxMLgo+Pj4+PiBUaGUgbGlzdCBsaWtlIHRoaXM6
Cj4+Pj4+IGhlYWQtPm5leHQgPSBoZWFkOwo+Pj4+PiBvbGQtPm5leHQgPSBoZWFkOwo+Pj4+PiBJ
ZiB0aGVyZSBpcyB0d28gb3IgbW9yZSBwYXRoIGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRlZCwKPj4+
Pj4gImZvciIgd2lsbCBiZSBpbmZpbml0ZSBsb29wLiBiZWNhdXNlIG52bWVfbmV4dF9ucygpIHdp
bGwgcmV0dXJuCj4+Pj4+IHRoZSBwYXRoIHdoaWNoIGluIHRoZSBsaXN0IGV4Y2VwdCB0aGUgIm9s
ZCIsIGNoZWNrIGNvbmRpdGlvbiB3aWxsCj4+Pj4+IGJlIHRydWUgZm9yIGV2ZXIuCj4+Pj4KPj4+
PiBCdXQgdGhhdCB3aWxsIGJlIGNhdWdodCBieSB0aGUgc3RhdGVtZW50IGFib3ZlOgo+Pj4+Cj4+
Pj4gaWYgKGxpc3RfaXNfc2luZ3VsYXIoJmhlYWQtPmxpc3QpKQo+Pj4+Cj4+Pj4gbm8/Cj4+PiBU
d28gcGF0aCBqdXN0IGEgc2FtcGxlIGV4YW1wbGUuCj4+PiBJZiB0aGVyZSBpcyBqdXN0IHR3byBw
YXRoLCB3aWxsIGVudGVyIGl0LCBtYXkgY2F1c2Ugbm8gcGF0aCBidXQgdGhlcmUgaXMKPj4+IGFj
dHVhbGx5IG9uZSBwYXRoLiBJdCBpcyBmYWxzZWx5IGFzc3VtZWQgdGhhdCB0aGUgIm9sZCIgbXVz
dCBiZSBub3QgCj4+PiBkZWxldGVkLgo+Pj4gSWYgdGhlcmUgaXMgbW9yZSB0aGFuIHR3byBwYXRo
LCB3aWxsIGNhdXNlIGluZmluaXRlIGxvb3AuCj4+IFNvIHlvdSBtZWFuIHdlJ2xsIG5lZWQgc29t
ZXRoaW5nIGxpa2UgdGhpcz8KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211
bHRpcGF0aC5jIAo+PiBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+IGluZGV4IDcx
Njk2ODE5YzIyOC4uOGZmY2NhZjljMTlhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9tdWx0aXBhdGguYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+PiBA
QCAtMjAyLDEwICsyMDIsMTIgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpfX252bWVfZmluZF9w
YXRoKHN0cnVjdCAKPj4gbnZtZV9uc19oZWFkICpoZWFkLCBpbnQgbm9kZSkKPj4gwqDCoHN0YXRp
YyBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9uZXh0X25zKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQs
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX25zICpucykK
Pj4gwqDCoHsKPj4gLcKgwqDCoMKgwqDCoCBucyA9IGxpc3RfbmV4dF9vcl9udWxsX3JjdSgmaGVh
ZC0+bGlzdCwgJm5zLT5zaWJsaW5ncywgc3RydWN0IAo+PiBudm1lX25zLAo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2libGluZ3MpOwo+PiAtwqDCoMKg
wqDCoMKgIGlmIChucykKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5z
Owo+PiArwqDCoMKgwqDCoMKgIGlmIChucykgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBucyA9IGxpc3RfbmV4dF9vcl9udWxsX3JjdSgmaGVhZC0+bGlzdCwgJm5zLT5zaWJsaW5n
cywKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdz
KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5zKQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5zOwo+PiArwqDCoMKg
wqDCoMKgIH0KPiBObywgaW4gdGhlIHNjZW5hcmlvLCBucyBzaG91bGQgbm90IGJlIE5VTEwuCgpX
aHkgbm90PyAnbnMgPT0gTlVMTCcgaXMgcHJlY2lzZWx5IHRoZSBjb3JuZXItY2FzZSB0aGlzIGlz
IHRyeWluZyB0byBmaXguLi4KCj4gTWF5IGJlIHdlIGNhbiBkbyBsaWtlIHRoaXM6Cj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPiBpbmRleCAyODJiN2E0ZWE5YTkuLmI4OTUwMTFhMmNiZCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4gQEAgLTE5OSwzMCArMTk5LDI0IEBAIHN0YXRpYyBzdHJ1Y3Qg
bnZtZV9ucyAqX19udm1lX2ZpbmRfcGF0aChzdHJ1Y3QgCj4gbnZtZV9uc19oZWFkICpoZWFkLCBp
bnQgbm9kZSkKPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZvdW5kOwo+ICDCoH0KPiAKPiAtc3Rh
dGljIHN0cnVjdCBudm1lX25zICpudm1lX25leHRfbnMoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVh
ZCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9ucyAqbnMpCj4g
LXsKPiAtwqDCoMKgwqDCoMKgIG5zID0gbGlzdF9uZXh0X29yX251bGxfcmN1KCZoZWFkLT5saXN0
LCAmbnMtPnNpYmxpbmdzLCBzdHJ1Y3QgCj4gbnZtZV9ucywKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2libGluZ3MpOwo+IC3CoMKgwqDCoMKgwqAgaWYg
KG5zKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBuczsKPiAtwqDCoMKg
wqDCoMKgIHJldHVybiBsaXN0X2ZpcnN0X29yX251bGxfcmN1KCZoZWFkLT5saXN0LCBzdHJ1Y3Qg
bnZtZV9ucywgCj4gc2libGluZ3MpOwo+IC19Cj4gKyNkZWZpbmUgbnZtZV9uZXh0X25zX2NvbmRp
dGlvbihoZWFkLCBjdXJyZW50LCBjb25kaXRpb24pIFwKPiArKHsgXAo+ICvCoMKgwqDCoMKgwqAg
c3RydWN0IG52bWVfbnMgKl9fcHRyID0gbGlzdF9uZXh0X29yX251bGxfcmN1KCYoaGVhZCktPmxp
c3QsIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmKGN1cnJlbnQpLT5zaWJsaW5n
cywgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsgXAo+ICvCoMKgwqDCoMKgwqAgX19wdHIgPyBf
X3B0ciA6IChjb25kaXRpb24pID8gKGNvbmRpdGlvbikgPSBmYWxzZSwgXAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZmlyc3Rfb3JfbnVsbF9yY3UoJihoZWFkKS0+bGlzdCwg
c3RydWN0IG52bWVfbnMsIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2libGluZ3MpIDogTlVMTDsgXAo+ICt9KQo+IApVcmdoLiBQbGVhc2UsIG5vLiBU
aGF0IGlzIHdlbGwgaW1wb3NzaWJsZSB0byBkZWJ1Zy4KQ2FuIHlvdSBwbGVhc2Ugb3Blbi1jb2Rl
IGl0IHRvIGRlbW9uc3RyYXRlIHdoZXJlIHRoZSBkaWZmZXJlbmNlIHRvIHRoZSAKY3VycmVudCAo
YW5kIG15IGZpeGVkKSB2ZXJzaW9ucyBpcz8KSSdtIHN0aWxsIG5vdCBjbGVhciB3aGVyZSB0aGUg
cHJvYmxlbSBpcyBvbmNlIHdlIGFwcGxpZWQgYm90aCBwYXRjaGVzLgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
