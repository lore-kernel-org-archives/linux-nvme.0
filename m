Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF9C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 09:20:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FBC64DDB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 09:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FBC64DDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ICGJpxd6M8lzEvNzFCc4iCvRbxP26rB0NBOxzb31EPo=; b=afbec8mrbQfrFDmGWKvURxtCa
	q9tQPxlZuWUDclKv/ZlRAvG354ll6sNjgtjiaAhNXQC/0YS51K/H9VXt0LhFAMUsKu+LvTQlxI878
	8h5T8KNkjiNuPuvD+86Z/DSeU24RQ95IhgJ77gZNj7SH345r1fKvnj6nzgCJr1wbvIu1XVgmEF/ZH
	fRvuSOlqiKn9m2i2nM2Vq52/Scp6BRBwfUl1iGZdoKoXCUHUZWmmsFHp/TypUWiq/H1yO2O7JtUJV
	BIdNMsh8x3SU7uFDUUfS46KDVhagJHnG8vQOH69aAGnAyd21UGZMHkFMXUGXoHynObMC2tjKv1e8w
	ReJqLqsBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5PxT-0004yM-Dl; Fri, 29 Jan 2021 09:20:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5PxO-0004xu-MI
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 09:20:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2898EAD29;
 Fri, 29 Jan 2021 09:20:45 +0000 (UTC)
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
Date: Fri, 29 Jan 2021 10:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_042047_076963_CD421DE5 
X-CRM114-Status: GOOD (  25.99  )
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

T24gMS8yOS8yMSA5OjQ2IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8xLzI5
IDE2OjMzLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDEvMjkvMjEgODo0NSBBTSwgQ2hh
byBMZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzEvMjkgMTU6MDYsIEhhbm5lcyBSZWlu
ZWNrZSB3cm90ZToKPj4+PiBPbiAxLzI5LzIxIDQ6MDcgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4+
Pj4KPj4+Pj4KPj4+Pj4gT24gMjAyMS8xLzI5IDk6NDIsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+
Pj4+Pgo+Pj4+Pj4+PiBZb3UgY2FuJ3Qgc2VlIGV4YWN0bHkgd2hlcmUgaXQgZGllcyBidXQgSSBm
b2xsb3dlZCB0aGUgYXNzZW1ibHkgdG8KPj4+Pj4+Pj4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoKCku
IE1heWJlIGl0J3Mgbm90IHRoZSBpbml0aWFsIAo+Pj4+Pj4+PiBudm1lX25leHRfbnMoaGVhZCwK
Pj4+Pj4+Pj4gb2xkKSB3aGljaCByZXR1cm5zIE5VTEwgYnV0IG52bWVfbmV4dF9ucygpIGlzIHJl
dHVybmluZyBOVUxMIAo+Pj4+Pj4+PiBldmVudHVhbGx5Cj4+Pj4+Pj4+IChsaXN0X25leHRfb3Jf
bnVsbF9yY3UoKSkuCj4+Pj4+Pj4gU28gdGhlcmUgaXMgb3RoZXIgYnVnIGNhdXNlIG52bWVfbmV4
dF9ucyBhYm9ybWFsLgo+Pj4+Pj4+IEkgcmV2aWV3IHRoZSBjb2RlIGFib3V0IGhlYWQtPmxpc3Qg
YW5kIGhlYWQtPmN1cnJlbnRfcGF0aCwgSSBmaW5kIAo+Pj4+Pj4+IDIgYnVncwo+Pj4+Pj4+IG1h
eSBjYXVzZSB0aGUgYnVnOgo+Pj4+Pj4+IEZpcnN0LCBJIGFscmVhZHkgc2VuZCB0aGUgcGF0Y2gu
IHNlZToKPj4+Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjEwMTI4
MDMzMzUxLjIyMTE2LTEtbGVuZ2NoYW9AaHVhd2VpLmNvbS8gCj4+Pj4+Pj4KPj4+Pj4+PiBTZWNv
bmQsIGluIG52bWVfbnNfcmVtb3ZlLCBsaXN0X2RlbF9yY3UgaXMgYmVmb3JlCj4+Pj4+Pj4gbnZt
ZV9tcGF0aF9jbGVhcl9jdXJyZW50X3BhdGguIFRoaXMgbWF5IGNhdXNlICJvbGQiIGlzIGRlbGV0
ZWQgCj4+Pj4+Pj4gZnJvbSB0aGUKPj4+Pj4+PiAiaGVhZCIsIGJ1dCBzdGlsbCB1c2UgIm9sZCIu
IEknbSBub3Qgc3VyZSB0aGVyZSdzIGFueSBvdGhlcgo+Pj4+Pj4+IGNvbnNpZGVyYXRpb24gaGVy
ZSwgSSB3aWxsIGNoZWNrIGl0IGFuZCB0cnkgdG8gZml4IGl0Lgo+Pj4+Pj4KPj4+Pj4+IFRoZSBy
ZWFzb24gd2h5IHdlIGZpcnN0IHJlbW92ZSBmcm9tIGhlYWQtPmxpc3QgYW5kIG9ubHkgdGhlbiBj
bGVhcgo+Pj4+Pj4gY3VycmVudF9wYXRoIGlzIGJlY2F1c2UgdGhlIG90aGVyIHdheSBhcm91bmQg
dGhlcmUgaXMgbm8gd2F5Cj4+Pj4+PiB0byBndWFyYW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24n
dCBiZSBhc3NpZ25lZCBhcyBjdXJyZW50X3BhdGgKPj4+Pj4+IGFnYWluIChiZWNhdXNlIGl0IGlz
IGluIGhlYWQtPmxpc3QpLgo+Pj4+PiBvaywgSSBzZWUuCj4+Pj4+Pgo+Pj4+Pj4gbnZtZV9uc19y
ZW1vdmUgZmVuY2VzIGNvbnRpbnVlIG9mIGRlbGV0aW9uIG9mIHRoZSBucyBieSBzeW5jaHJvbml6
aW5nCj4+Pj4+PiB0aGUgc3JjdSBzdWNoIHRoYXQgZm9yIHN1cmUgdGhlIGN1cnJlbnRfcGF0aCBj
bGVhcmFuY2UgaXMgdmlzaWJsZS4KPj4+Pj4gVGhlIGxpc3Qgd2lsbCBiZSBsaWtlIHRoaXM6Cj4+
Pj4+IGhlYWQtPm5leHQgPSBuczE7Cj4+Pj4+IG5zMS0+bmV4dCA9IGhlYWQ7Cj4+Pj4+IG9sZC0+
bmV4dCA9IG5zMTsKPj4+Pgo+Pj4+IFdoZXJlIGRvZXMgJ29sZCcgcG9pbnRpbmcgdG8/Cj4+Pj4K
Pj4+Pj4gVGhpcyBtYXkgY2F1c2UgaW5maW5pdGUgbG9vcCBpbiBudm1lX3JvdW5kX3JvYmluX3Bh
dGguCj4+Pj4+IGZvciAobnMgPSBudm1lX25leHRfbnMoaGVhZCwgb2xkKTsKPj4+Pj4gwqDCoMKg
wqDCoG5zICE9IG9sZDsKPj4+Pj4gwqDCoMKgwqDCoG5zID0gbnZtZV9uZXh0X25zKGhlYWQsIG5z
KSkKPj4+Pj4gVGhlIG5zIHdpbGwgYWx3YXlzIGJlIG5zMSwgYW5kIHRoZW4gaW5maW5pdGUgbG9v
cC4KPj4+Pgo+Pj4+IE5vLiBudm1lX25leHRfbnMoKSB3aWxsIHJldHVybiBOVUxMLgo+Pj4gSWYg
dGhlcmUgaXMganVzdCBvbmUgcGF0aCh0aGUgIm9sZCIpIGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRl
ZCwKPj4+IG52bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuIE5VTEwuCj4+PiBUaGUgbGlzdCBsaWtl
IHRoaXM6Cj4+PiBoZWFkLT5uZXh0ID0gaGVhZDsKPj4+IG9sZC0+bmV4dCA9IGhlYWQ7Cj4+PiBJ
ZiB0aGVyZSBpcyB0d28gb3IgbW9yZSBwYXRoIGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRlZCwKPj4+
ICJmb3IiIHdpbGwgYmUgaW5maW5pdGUgbG9vcC4gYmVjYXVzZSBudm1lX25leHRfbnMoKSB3aWxs
IHJldHVybgo+Pj4gdGhlIHBhdGggd2hpY2ggaW4gdGhlIGxpc3QgZXhjZXB0IHRoZSAib2xkIiwg
Y2hlY2sgY29uZGl0aW9uIHdpbGwKPj4+IGJlIHRydWUgZm9yIGV2ZXIuCj4+Cj4+IEJ1dCB0aGF0
IHdpbGwgYmUgY2F1Z2h0IGJ5IHRoZSBzdGF0ZW1lbnQgYWJvdmU6Cj4+Cj4+IGlmIChsaXN0X2lz
X3Npbmd1bGFyKCZoZWFkLT5saXN0KSkKPj4KPj4gbm8/Cj4gVHdvIHBhdGgganVzdCBhIHNhbXBs
ZSBleGFtcGxlLgo+IElmIHRoZXJlIGlzIGp1c3QgdHdvIHBhdGgsIHdpbGwgZW50ZXIgaXQsIG1h
eSBjYXVzZSBubyBwYXRoIGJ1dCB0aGVyZSBpcwo+IGFjdHVhbGx5IG9uZSBwYXRoLiBJdCBpcyBm
YWxzZWx5IGFzc3VtZWQgdGhhdCB0aGUgIm9sZCIgbXVzdCBiZSBub3QgCj4gZGVsZXRlZC4KPiBJ
ZiB0aGVyZSBpcyBtb3JlIHRoYW4gdHdvIHBhdGgsIHdpbGwgY2F1c2UgaW5maW5pdGUgbG9vcC4K
U28geW91IG1lYW4gd2UnbGwgbmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzPwoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMKaW5kZXggNzE2OTY4MTljMjI4Li44ZmZjY2FmOWMxOWEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0
aC5jCkBAIC0yMDIsMTAgKzIwMiwxMiBAQCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKl9fbnZtZV9m
aW5kX3BhdGgoc3RydWN0IApudm1lX25zX2hlYWQgKmhlYWQsIGludCBub2RlKQogIHN0YXRpYyBz
dHJ1Y3QgbnZtZV9ucyAqbnZtZV9uZXh0X25zKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsCiAg
ICAgICAgICAgICAgICAgc3RydWN0IG52bWVfbnMgKm5zKQogIHsKLSAgICAgICBucyA9IGxpc3Rf
bmV4dF9vcl9udWxsX3JjdSgmaGVhZC0+bGlzdCwgJm5zLT5zaWJsaW5ncywgc3RydWN0IApudm1l
X25zLAotICAgICAgICAgICAgICAgICAgICAgICBzaWJsaW5ncyk7Ci0gICAgICAgaWYgKG5zKQot
ICAgICAgICAgICAgICAgcmV0dXJuIG5zOworICAgICAgIGlmIChucykgeworICAgICAgICAgICAg
ICAgbnMgPSBsaXN0X25leHRfb3JfbnVsbF9yY3UoJmhlYWQtPmxpc3QsICZucy0+c2libGluZ3Ms
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbnZtZV9u
cywgc2libGluZ3MpOworICAgICAgICAgICAgICAgaWYgKG5zKQorICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gbnM7CisgICAgICAgfQogICAgICAgICByZXR1cm4gbGlzdF9maXJzdF9vcl9u
dWxsX3JjdSgmaGVhZC0+bGlzdCwgc3RydWN0IG52bWVfbnMsIApzaWJsaW5ncyk7CiAgfQoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
