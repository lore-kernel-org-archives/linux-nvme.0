Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99169C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:27:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338A660235
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338A660235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XGWgy2Aw3BSO5wcRzvrG+hQvVKYNZnGwRpN0yuGSxPQ=; b=iKYgPSovIJjgvv0ixOwZJZUDa
	p0APcpePGEis1YsgIIU+CGs77JfLl/FEsOyha3P09oqrICFqC3TJOxKCixuFjLv5G8qJuqwbQOSi+
	wiYjdlshYE94CfOktouOI8XIatkYFdcNtwKi8mpSvGMkYyr2WKECsIXbHW/fk0nFOIGtO6C9laiP7
	Bl/4bj6uAgmQWv8d/xBQjl0QfI3oeZt6J1SHtecBm1EIGC6wvNKoDoYUDyVufNbzyogj3+IExZ7cA
	8MXfc5ocXeFns8CxDFhdx6KJVC4xFR6IMsMFq4AGu8P9pzlPK+5Zftb2eoRNse7P7ROJ9qX9rvX91
	RzuJ9tY+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKkd1-00BxSh-Dk; Fri, 12 Mar 2021 16:27:07 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKkb2-00BweR-2S
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 16:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=z71Dy4S8XtDaYoM2XRkuE2wAHe2/+OE53EIe7Kw+TNU=; b=HqXLStXu7JHag3wGbK3mOgF/M8
 gsYjKlyGMCNs6Kp2trWSjJWEdoTTL7l0upjMGEke4ssz2qv6SN3QkQZ8mcg+a143IC5xIOM3SURoN
 lw4HuqO4LhNWzh1WAKj6/9SxZhr2mvmmvBMwjW/oqcvFMPefmD+CQ/sZD2cfS3DQ9XdARnulhX379
 XEmUxtLccrt+N+K+iBiVDqkj/U2P4KyQUA3p6kqQsHQwLLUNipLb7OSQ8YfLEh8+nzalEco/na8NL
 WnrW6BHAXcHt9X8Oyt7VfthZmCHT2QggtvHtaFRpzf4jqY5LDY0Xy1Vgj3qD6rJy+XfYFYP5DTIA3
 2H01sjhg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKkar-0007E2-BR; Fri, 12 Mar 2021 09:24:54 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
Date: Fri, 12 Mar 2021 09:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de,
 andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com,
 daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca,
 christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com,
 dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_162505_358752_D23EA3C3 
X-CRM114-Status: GOOD (  23.18  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLTAzLTEyIDg6NTIgYS5tLiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiArCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBzZy0+ZG1hX2FkZHJlc3MgPSBkbWFfZGlyZWN0X21hcF9wYWdlKGRl
diwgc2dfcGFnZShzZyksCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2ct
Pm9mZnNldCwgc2ctPmxlbmd0aCwgZGlyLCBhdHRycyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoc2ctPmRtYV9hZGRyZXNzID09IERNQV9NQVBQSU5HX0VSUk9SKQo+PiBAQCAtNDExLDcgKzQ0
MCw3IEBAIGludCBkbWFfZGlyZWN0X21hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdAo+
PiBzY2F0dGVybGlzdCAqc2dsLCBpbnQgbmVudHMsCj4+IMKgIMKgIG91dF91bm1hcDoKPj4gwqDC
oMKgwqDCoCBkbWFfZGlyZWN0X3VubWFwX3NnKGRldiwgc2dsLCBpLCBkaXIsIGF0dHJzIHwKPj4g
RE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7Cj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+ICvCoMKgwqAg
cmV0dXJuIHJldDsKPj4gwqAgfQo+PiDCoCDCoCBkbWFfYWRkcl90IGRtYV9kaXJlY3RfbWFwX3Jl
c291cmNlKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QKPj4gcGFkZHIsCj4+IGRpZmYg
LS1naXQgYS9rZXJuZWwvZG1hL21hcHBpbmcuYyBiL2tlcm5lbC9kbWEvbWFwcGluZy5jCj4+IGlu
ZGV4IGI2YTYzMzY3OTkzMy4uYWRjMWE4Mzk1MGJlIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZG1h
L21hcHBpbmcuYwo+PiArKysgYi9rZXJuZWwvZG1hL21hcHBpbmcuYwo+PiBAQCAtMTc4LDggKzE3
OCwxNSBAQCB2b2lkIGRtYV91bm1hcF9wYWdlX2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4g
ZG1hX2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSwKPj4gwqAgRVhQT1JUX1NZTUJPTChkbWFfdW5t
YXBfcGFnZV9hdHRycyk7Cj4+IMKgIMKgIC8qCj4+IC0gKiBkbWFfbWFwc19zZ19hdHRycyByZXR1
cm5zIDAgb24gZXJyb3IgYW5kID4gMCBvbiBzdWNjZXNzLgo+PiAtICogSXQgc2hvdWxkIG5ldmVy
IHJldHVybiBhIHZhbHVlIDwgMC4KPj4gKyAqIGRtYV9tYXBzX3NnX2F0dHJzIHJldHVybnMgMCBv
biBhbnkgcmVzb3VyY2UgZXJyb3IgYW5kID4gMCBvbiBzdWNjZXNzLgo+PiArICoKPj4gKyAqIElm
IDAgaXMgcmV0dXJuZWQsIHRoZSBtYXBwaW5nIGNhbiBiZSByZXRyaWVkIGFuZCB3aWxsIHN1Y2Nl
ZWQgb25jZQo+PiArICogc3VmZmljaWVudCByZXNvdXJjZXMgYXJlIGF2YWlsYWJsZS4KPiAKPiBU
aGF0J3Mgbm90IGEgZ3VhcmFudGVlIHdlIGNhbiB1cGhvbGQuIFJldHJ5aW5nIGZvcmV2ZXIgaW4g
dGhlIHZhaW4gaG9wZQo+IHRoYXQgYSBkZXZpY2UgbWlnaHQgZXZvbHZlIHNvbWUgZXh0cmEgYWRk
cmVzcyBiaXRzLCBvciBhIGJvdW5jZSBidWZmZXIKPiBtaWdodCBtYWdpY2FsbHkgZ3JvdyBiaWcg
ZW5vdWdoIGZvciBhIGdpZ2FudGljIG1hcHBpbmcsIGlzbid0Cj4gbmVjZXNzYXJpbHkgdGhlIGJl
c3QgaWRlYS4KClBlcmhhcHMgdGhpcyBpcyBqdXN0IHBvb3JseSB3b3JkZWQuIFJldHVybmluZyAw
IGlzIHRoZSBub3JtYWwgY2FzZSBhbmQKbm90aGluZyBoYXMgY2hhbmdlZCB0aGVyZS4gVGhlIGJs
b2NrIGxheWVyLCBmb3IgZXhhbXBsZSwgd2lsbCByZXRyeSBpZgp6ZXJvIGlzIHJldHVybmVkIGFz
IHRoaXMgb25seSBoYXBwZW5zIGlmIGl0IGZhaWxlZCB0byBhbGxvY2F0ZSByZXNvdXJjZXMKZm9y
IHRoZSBtYXBwaW5nLiBUaGUgcmVhc29uIHdlIGhhdmUgdG8gcmV0dXJuIC0xIGlzIHRvIHRlbGwg
dGhlIGJsb2NrCmxheWVyIG5vdCB0byByZXRyeSB0aGVzZSByZXF1ZXN0cyBhcyB0aGV5IHdpbGwg
bmV2ZXIgc3VjY2VlZCBpbiB0aGUgZnV0dXJlLgoKPj4gKyAqCj4+ICsgKiBJZiB0aGVyZSBhcmUg
UDJQRE1BIHBhZ2VzIGluIHRoZSBzY2F0dGVybGlzdCB0aGVuIHRoaXMgZnVuY3Rpb24gbWF5Cj4+
ICsgKiByZXR1cm4gLUVSRU1PVEVJTyB0byBpbmRpY2F0ZSB0aGF0IHRoZSBwYWdlcyBhcmUgbm90
IG1hcHBhYmxlIGJ5IHRoZQo+PiArICogZGV2aWNlLiBJbiB0aGlzIGNhc2UsIGFuIGVycm9yIHNo
b3VsZCBiZSByZXR1cm5lZCBmb3IgdGhlIElPIGFzIGl0Cj4+ICsgKiB3aWxsIG5ldmVyIGJlIHN1
Y2Nlc3NmdWxseSByZXRyaWVkLgo+PiDCoMKgICovCj4+IMKgIGludCBkbWFfbWFwX3NnX2F0dHJz
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50Cj4+IG5lbnRz
LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLCB1bnNp
Z25lZCBsb25nIGF0dHJzKQo+PiBAQCAtMTk3LDcgKzIwNCw3IEBAIGludCBkbWFfbWFwX3NnX2F0
dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+IHNjYXR0ZXJsaXN0ICpzZywgaW50IG5l
bnRzLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cyA9IGRtYV9kaXJlY3RfbWFwX3NnKGRldiwg
c2csIG5lbnRzLCBkaXIsIGF0dHJzKTsKPj4gwqDCoMKgwqDCoCBlbHNlCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBlbnRzID0gb3BzLT5tYXBfc2coZGV2LCBzZywgbmVudHMsIGRpciwgYXR0cnMpOwo+
PiAtwqDCoMKgIEJVR19PTihlbnRzIDwgMCk7Cj4+ICsKPiAKPiBUaGlzIHNjYXJlcyBtZSAtIEkg
aGVzaXRhdGUgdG8gaW1hZ2luZSB0aGUgYW1vdW50IG9mIGRyaXZlci9zdWJzeXN0ZW0KPiBjb2Rl
IG91dCB0aGVyZSB0aGF0IHdpbGwgc2VlIG5vbnplcm8gYW5kIG1lcnJpbHkgc2V0IG9mZiBpdGVy
YXRpbmcgYQo+IG5lZ2F0aXZlIG51bWJlciBvZiBzZWdtZW50cywgaWYgd2Ugb3BlbiB0aGUgZmxv
b2RnYXRlcyBvZiBhbGxvd2luZwo+IGltcGxlbWVudGF0aW9ucyB0byByZXR1cm4gZXJyb3IgY29k
ZXMgaGVyZS4KClllcywgYnV0IGl0IHdpbGwgbmV2ZXIgaGFwcGVuIG9uIGV4aXN0aW5nIGRyaXZl
cnMvc3Vic3lzdGVtcy4gVGhlIG9ubHkKd2F5IGl0IGNhbiByZXR1cm4gYSBuZWdhdGl2ZSBudW1i
ZXIgaXMgaWYgdGhlIGRyaXZlciBwYXNzZXMgaW4gUDJQRE1BCnBhZ2VzIHdoaWNoIGNhbid0IGhh
cHBlbiB3aXRob3V0IGNoYW5nZXMgaW4gdGhlIGRyaXZlci4gV2UgYXJlIGNhcmVmdWwKYWJvdXQg
d2hlcmUgUDJQRE1BIHBhZ2VzIGNhbiBnZXQgaW50byBzbyB3ZSBkb24ndCBoYXZlIHRvIHdvcnJ5
IGFib3V0CmFsbCB0aGUgZXhpc3RpbmcgZHJpdmVyIGNvZGUgb3V0IHRoZXJlLgoKTG9nYW4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
