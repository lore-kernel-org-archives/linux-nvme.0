Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E29C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 08:33:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F79A64DDE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 08:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F79A64DDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yj1lbh8tb35jGcnRCjkSfGMyW3vBZOOD8p7rlp7g1n8=; b=hu7e7LXv7f2KCuE9OOuBrTmJQ
	1pzQvGUvCUgMeirhu+xmsbG4L65B440r24WrMt7pMmdLY6EbzeJNiRRkYOilgLWfUgjPAYj8xlfqM
	1BGRnYya4xawdrZnAFB7YwyatxVLu/pnOGbbhdyg1mCHpIUyVXYupbbIZoyhDdLC9XAV3NJHp8qYE
	ffiyuiiaMEafXsTqwYMcEDpNczJCynCoYJ5g8i6ebSpqwNEqPhnsjPpXUNbX2vniVQ6HkWNV2w4/Y
	Hmt5GHOb4bXTwYvHrMUWRqKScKvPLC4eShMMha5TrZHFbKi7/OyAb2fT2jedfRW/s+BHsukTVOoO5
	nkbX8LweQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5PDZ-0005jW-5G; Fri, 29 Jan 2021 08:33:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5PDV-0005iz-Lj
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 08:33:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 860A1B000;
 Fri, 29 Jan 2021 08:33:20 +0000 (UTC)
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
Date: Fri, 29 Jan 2021 09:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_033322_420536_FB5D7AD3 
X-CRM114-Status: GOOD (  22.06  )
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

T24gMS8yOS8yMSA4OjQ1IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8xLzI5
IDE1OjA2LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDEvMjkvMjEgNDowNyBBTSwgQ2hh
byBMZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzEvMjkgOTo0MiwgU2FnaSBHcmltYmVy
ZyB3cm90ZToKPj4+Pgo+Pj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5IHdoZXJlIGl0IGRpZXMg
YnV0IEkgZm9sbG93ZWQgdGhlIGFzc2VtYmx5IHRvCj4+Pj4+PiBudm1lX3JvdW5kX3JvYmluX3Bh
dGgoKS4gTWF5YmUgaXQncyBub3QgdGhlIGluaXRpYWwgCj4+Pj4+PiBudm1lX25leHRfbnMoaGVh
ZCwKPj4+Pj4+IG9sZCkgd2hpY2ggcmV0dXJucyBOVUxMIGJ1dCBudm1lX25leHRfbnMoKSBpcyBy
ZXR1cm5pbmcgTlVMTCAKPj4+Pj4+IGV2ZW50dWFsbHkKPj4+Pj4+IChsaXN0X25leHRfb3JfbnVs
bF9yY3UoKSkuCj4+Pj4+IFNvIHRoZXJlIGlzIG90aGVyIGJ1ZyBjYXVzZSBudm1lX25leHRfbnMg
YWJvcm1hbC4KPj4+Pj4gSSByZXZpZXcgdGhlIGNvZGUgYWJvdXQgaGVhZC0+bGlzdCBhbmQgaGVh
ZC0+Y3VycmVudF9wYXRoLCBJIGZpbmQgMiAKPj4+Pj4gYnVncwo+Pj4+PiBtYXkgY2F1c2UgdGhl
IGJ1ZzoKPj4+Pj4gRmlyc3QsIEkgYWxyZWFkeSBzZW5kIHRoZSBwYXRjaC4gc2VlOgo+Pj4+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjEwMTI4MDMzMzUxLjIyMTE2LTEt
bGVuZ2NoYW9AaHVhd2VpLmNvbS8gCj4+Pj4+Cj4+Pj4+IFNlY29uZCwgaW4gbnZtZV9uc19yZW1v
dmUsIGxpc3RfZGVsX3JjdSBpcyBiZWZvcmUKPj4+Pj4gbnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50
X3BhdGguIFRoaXMgbWF5IGNhdXNlICJvbGQiIGlzIGRlbGV0ZWQgZnJvbSAKPj4+Pj4gdGhlCj4+
Pj4+ICJoZWFkIiwgYnV0IHN0aWxsIHVzZSAib2xkIi4gSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYW55
IG90aGVyCj4+Pj4+IGNvbnNpZGVyYXRpb24gaGVyZSwgSSB3aWxsIGNoZWNrIGl0IGFuZCB0cnkg
dG8gZml4IGl0Lgo+Pj4+Cj4+Pj4gVGhlIHJlYXNvbiB3aHkgd2UgZmlyc3QgcmVtb3ZlIGZyb20g
aGVhZC0+bGlzdCBhbmQgb25seSB0aGVuIGNsZWFyCj4+Pj4gY3VycmVudF9wYXRoIGlzIGJlY2F1
c2UgdGhlIG90aGVyIHdheSBhcm91bmQgdGhlcmUgaXMgbm8gd2F5Cj4+Pj4gdG8gZ3VhcmFudGVl
IHRoYXQgdGhhdCB0aGUgbnMgd29uJ3QgYmUgYXNzaWduZWQgYXMgY3VycmVudF9wYXRoCj4+Pj4g
YWdhaW4gKGJlY2F1c2UgaXQgaXMgaW4gaGVhZC0+bGlzdCkuCj4+PiBvaywgSSBzZWUuCj4+Pj4K
Pj4+PiBudm1lX25zX3JlbW92ZSBmZW5jZXMgY29udGludWUgb2YgZGVsZXRpb24gb2YgdGhlIG5z
IGJ5IHN5bmNocm9uaXppbmcKPj4+PiB0aGUgc3JjdSBzdWNoIHRoYXQgZm9yIHN1cmUgdGhlIGN1
cnJlbnRfcGF0aCBjbGVhcmFuY2UgaXMgdmlzaWJsZS4KPj4+IFRoZSBsaXN0IHdpbGwgYmUgbGlr
ZSB0aGlzOgo+Pj4gaGVhZC0+bmV4dCA9IG5zMTsKPj4+IG5zMS0+bmV4dCA9IGhlYWQ7Cj4+PiBv
bGQtPm5leHQgPSBuczE7Cj4+Cj4+IFdoZXJlIGRvZXMgJ29sZCcgcG9pbnRpbmcgdG8/Cj4+Cj4+
PiBUaGlzIG1heSBjYXVzZSBpbmZpbml0ZSBsb29wIGluIG52bWVfcm91bmRfcm9iaW5fcGF0aC4K
Pj4+IGZvciAobnMgPSBudm1lX25leHRfbnMoaGVhZCwgb2xkKTsKPj4+IMKgwqDCoMKgwqBucyAh
PSBvbGQ7Cj4+PiDCoMKgwqDCoMKgbnMgPSBudm1lX25leHRfbnMoaGVhZCwgbnMpKQo+Pj4gVGhl
IG5zIHdpbGwgYWx3YXlzIGJlIG5zMSwgYW5kIHRoZW4gaW5maW5pdGUgbG9vcC4KPj4KPj4gTm8u
IG52bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuIE5VTEwuCj4gSWYgdGhlcmUgaXMganVzdCBvbmUg
cGF0aCh0aGUgIm9sZCIpIGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRlZCwKPiBudm1lX25leHRfbnMo
KSB3aWxsIHJldHVybiBOVUxMLgo+IFRoZSBsaXN0IGxpa2UgdGhpczoKPiBoZWFkLT5uZXh0ID0g
aGVhZDsKPiBvbGQtPm5leHQgPSBoZWFkOwo+IElmIHRoZXJlIGlzIHR3byBvciBtb3JlIHBhdGgg
YW5kIHRoZSAib2xkIiBpcyBkZWxldGVkLAo+ICJmb3IiIHdpbGwgYmUgaW5maW5pdGUgbG9vcC4g
YmVjYXVzZSBudm1lX25leHRfbnMoKSB3aWxsIHJldHVybgo+IHRoZSBwYXRoIHdoaWNoIGluIHRo
ZSBsaXN0IGV4Y2VwdCB0aGUgIm9sZCIsIGNoZWNrIGNvbmRpdGlvbiB3aWxsCj4gYmUgdHJ1ZSBm
b3IgZXZlci4KCkJ1dCB0aGF0IHdpbGwgYmUgY2F1Z2h0IGJ5IHRoZSBzdGF0ZW1lbnQgYWJvdmU6
CgppZiAobGlzdF9pc19zaW5ndWxhcigmaGVhZC0+bGlzdCkpCgpubz8KCkNoZWVycywKCkhhbm5l
cwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBB
cmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkx
MSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwg
OTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhy
ZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
