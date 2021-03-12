Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD297C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783F564F69
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783F564F69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B5/s256lFb/sHSJb6Wh4V/aquAE1wbBbA9mqB4EUva0=; b=hShaDKvIC/Apj+E2kCP7l7ILT
	+VQMVLptFZAXUXyHNAVQJMEY0gJ7D1u7fcHBoWSMBMBD0j9o9tp46iYjApY3oOT0D/PETsRz7Bvg8
	VI1c5PL7VMMohI55aI9tNDO5JGP7ScfExrhnvcXznzy47uNMhS/sb6fPHyR1SKnuuPDoXF0VLk2BO
	it2e9oGXhmn94tryM1BDG5YYaSSqxkCDf2ApFE5pRT1Gea8Mq3+IPq/QSh2lgjOY9zb44tD5YPmor
	e5ebxbknaUNQS6egPuN7FClh3ePN6yBKB+pz5YrWTW92ic0JNOMAVlJLrXfqLBWw/qnkq+1Zl8tl8
	Q8t10o1Uw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKmW8-00CC6e-Gn; Fri, 12 Mar 2021 18:28:08 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKmW4-00CC5V-7o
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 18:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Hyn4+hD/rcL5U1sAMSyBYqlThrIcs7n2BvWezL3fddg=; b=O02RcMlN/pcj/N4ypIgx4I/pQ5
 odKzndiBxONwDvQY7XeQHM0yUL6tNtRu+tqAeZboQCn2uqEptBRencRIbjQGRldJW/jyvUA/KDtL+
 coOgr94guexcTd1f7Szt8zRpwy1IvMAy2W3ftljmL4P8GFdKj1SN8onH4rfBxF57fhBf9xXAzAhQV
 /qljiRXeamubdsafvZ8ZJFJ3NXcbdH1tgLymdvkHTAsjp3Q7Tool9D/nXyWTP4daDpVDiawZwjhWQ
 lPu90abCSPKAPLbTenEiF3R13QKr9Taag/gseqawH8n8+t4hT7g05jFpAdVBsSakM2wzLS7c3hm29
 lwmEDUkA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKmVn-0000Xs-8W; Fri, 12 Mar 2021 11:27:48 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
 <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
 <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <367fa81e-588d-5734-c69c-8cdc800dcb7e@deltatee.com>
Date: Fri, 12 Mar 2021 11:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de,
 andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com,
 daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca,
 christian.koenig@amd.com, willy@infradead.org, dave.hansen@linux.intel.com,
 jhubbard@nvidia.com, dave.b.minturn@intel.com,
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
X-CRM114-CacheID: sfid-20210312_182804_325547_798F46EC 
X-CRM114-Status: GOOD (  25.34  )
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

CgpPbiAyMDIxLTAzLTEyIDExOjExIGEubS4sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIx
LTAzLTEyIDE2OjI0LCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEtMDMt
MTIgODo1MiBhLm0uLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNnLT5kbWFfYWRkcmVzcyA9IGRtYV9kaXJlY3RfbWFwX3BhZ2UoZGV2LCBzZ19w
YWdlKHNnKSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2ctPm9m
ZnNldCwgc2ctPmxlbmd0aCwgZGlyLCBhdHRycyk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHNnLT5kbWFfYWRkcmVzcyA9PSBETUFfTUFQUElOR19FUlJPUikKPj4+PiBAQCAtNDExLDcg
KzQ0MCw3IEBAIGludCBkbWFfZGlyZWN0X21hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dAo+Pj4+IHNjYXR0ZXJsaXN0ICpzZ2wsIGludCBuZW50cywKPj4+PiDCoMKgIMKgIG91dF91bm1h
cDoKPj4+PiDCoMKgwqDCoMKgwqAgZG1hX2RpcmVjdF91bm1hcF9zZyhkZXYsIHNnbCwgaSwgZGly
LCBhdHRycyB8Cj4+Pj4gRE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7Cj4+Pj4gLcKgwqDCoCByZXR1
cm4gMDsKPj4+PiArwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4gwqDCoCB9Cj4+Pj4gwqDCoCDCoCBk
bWFfYWRkcl90IGRtYV9kaXJlY3RfbWFwX3Jlc291cmNlKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5
c19hZGRyX3QKPj4+PiBwYWRkciwKPj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9tYXBwaW5n
LmMgYi9rZXJuZWwvZG1hL21hcHBpbmcuYwo+Pj4+IGluZGV4IGI2YTYzMzY3OTkzMy4uYWRjMWE4
Mzk1MGJlIDEwMDY0NAo+Pj4+IC0tLSBhL2tlcm5lbC9kbWEvbWFwcGluZy5jCj4+Pj4gKysrIGIv
a2VybmVsL2RtYS9tYXBwaW5nLmMKPj4+PiBAQCAtMTc4LDggKzE3OCwxNSBAQCB2b2lkIGRtYV91
bm1hcF9wYWdlX2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+PiBkbWFfYWRkcl90IGFkZHIs
IHNpemVfdCBzaXplLAo+Pj4+IMKgwqAgRVhQT1JUX1NZTUJPTChkbWFfdW5tYXBfcGFnZV9hdHRy
cyk7Cj4+Pj4gwqDCoCDCoCAvKgo+Pj4+IC0gKiBkbWFfbWFwc19zZ19hdHRycyByZXR1cm5zIDAg
b24gZXJyb3IgYW5kID4gMCBvbiBzdWNjZXNzLgo+Pj4+IC0gKiBJdCBzaG91bGQgbmV2ZXIgcmV0
dXJuIGEgdmFsdWUgPCAwLgo+Pj4+ICsgKiBkbWFfbWFwc19zZ19hdHRycyByZXR1cm5zIDAgb24g
YW55IHJlc291cmNlIGVycm9yIGFuZCA+IDAgb24KPj4+PiBzdWNjZXNzLgo+Pj4+ICsgKgo+Pj4+
ICsgKiBJZiAwIGlzIHJldHVybmVkLCB0aGUgbWFwcGluZyBjYW4gYmUgcmV0cmllZCBhbmQgd2ls
bCBzdWNjZWVkIG9uY2UKPj4+PiArICogc3VmZmljaWVudCByZXNvdXJjZXMgYXJlIGF2YWlsYWJs
ZS4KPj4+Cj4+PiBUaGF0J3Mgbm90IGEgZ3VhcmFudGVlIHdlIGNhbiB1cGhvbGQuIFJldHJ5aW5n
IGZvcmV2ZXIgaW4gdGhlIHZhaW4gaG9wZQo+Pj4gdGhhdCBhIGRldmljZSBtaWdodCBldm9sdmUg
c29tZSBleHRyYSBhZGRyZXNzIGJpdHMsIG9yIGEgYm91bmNlIGJ1ZmZlcgo+Pj4gbWlnaHQgbWFn
aWNhbGx5IGdyb3cgYmlnIGVub3VnaCBmb3IgYSBnaWdhbnRpYyBtYXBwaW5nLCBpc24ndAo+Pj4g
bmVjZXNzYXJpbHkgdGhlIGJlc3QgaWRlYS4KPj4KPj4gUGVyaGFwcyB0aGlzIGlzIGp1c3QgcG9v
cmx5IHdvcmRlZC4gUmV0dXJuaW5nIDAgaXMgdGhlIG5vcm1hbCBjYXNlIGFuZAo+PiBub3RoaW5n
IGhhcyBjaGFuZ2VkIHRoZXJlLiBUaGUgYmxvY2sgbGF5ZXIsIGZvciBleGFtcGxlLCB3aWxsIHJl
dHJ5IGlmCj4+IHplcm8gaXMgcmV0dXJuZWQgYXMgdGhpcyBvbmx5IGhhcHBlbnMgaWYgaXQgZmFp
bGVkIHRvIGFsbG9jYXRlIHJlc291cmNlcwo+PiBmb3IgdGhlIG1hcHBpbmcuIFRoZSByZWFzb24g
d2UgaGF2ZSB0byByZXR1cm4gLTEgaXMgdG8gdGVsbCB0aGUgYmxvY2sKPj4gbGF5ZXIgbm90IHRv
IHJldHJ5IHRoZXNlIHJlcXVlc3RzIGFzIHRoZXkgd2lsbCBuZXZlciBzdWNjZWVkIGluIHRoZQo+
PiBmdXR1cmUuCj4+Cj4+Pj4gKyAqCj4+Pj4gKyAqIElmIHRoZXJlIGFyZSBQMlBETUEgcGFnZXMg
aW4gdGhlIHNjYXR0ZXJsaXN0IHRoZW4gdGhpcyBmdW5jdGlvbiBtYXkKPj4+PiArICogcmV0dXJu
IC1FUkVNT1RFSU8gdG8gaW5kaWNhdGUgdGhhdCB0aGUgcGFnZXMgYXJlIG5vdCBtYXBwYWJsZSBi
eQo+Pj4+IHRoZQo+Pj4+ICsgKiBkZXZpY2UuIEluIHRoaXMgY2FzZSwgYW4gZXJyb3Igc2hvdWxk
IGJlIHJldHVybmVkIGZvciB0aGUgSU8gYXMgaXQKPj4+PiArICogd2lsbCBuZXZlciBiZSBzdWNj
ZXNzZnVsbHkgcmV0cmllZC4KPj4+PiDCoMKgwqAgKi8KPj4+PiDCoMKgIGludCBkbWFfbWFwX3Nn
X2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50Cj4+
Pj4gbmVudHMsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkbWFfZGF0YV9kaXJlY3Rp
b24gZGlyLCB1bnNpZ25lZCBsb25nIGF0dHJzKQo+Pj4+IEBAIC0xOTcsNyArMjA0LDcgQEAgaW50
IGRtYV9tYXBfc2dfYXR0cnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QKPj4+PiBzY2F0dGVy
bGlzdCAqc2csIGludCBuZW50cywKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRzID0gZG1h
X2RpcmVjdF9tYXBfc2coZGV2LCBzZywgbmVudHMsIGRpciwgYXR0cnMpOwo+Pj4+IMKgwqDCoMKg
wqDCoCBlbHNlCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cyA9IG9wcy0+bWFwX3NnKGRl
diwgc2csIG5lbnRzLCBkaXIsIGF0dHJzKTsKPj4+PiAtwqDCoMKgIEJVR19PTihlbnRzIDwgMCk7
Cj4+Pj4gKwo+Pj4KPj4+IFRoaXMgc2NhcmVzIG1lIC0gSSBoZXNpdGF0ZSB0byBpbWFnaW5lIHRo
ZSBhbW91bnQgb2YgZHJpdmVyL3N1YnN5c3RlbQo+Pj4gY29kZSBvdXQgdGhlcmUgdGhhdCB3aWxs
IHNlZSBub256ZXJvIGFuZCBtZXJyaWx5IHNldCBvZmYgaXRlcmF0aW5nIGEKPj4+IG5lZ2F0aXZl
IG51bWJlciBvZiBzZWdtZW50cywgaWYgd2Ugb3BlbiB0aGUgZmxvb2RnYXRlcyBvZiBhbGxvd2lu
Zwo+Pj4gaW1wbGVtZW50YXRpb25zIHRvIHJldHVybiBlcnJvciBjb2RlcyBoZXJlLgo+Pgo+PiBZ
ZXMsIGJ1dCBpdCB3aWxsIG5ldmVyIGhhcHBlbiBvbiBleGlzdGluZyBkcml2ZXJzL3N1YnN5c3Rl
bXMuIFRoZSBvbmx5Cj4+IHdheSBpdCBjYW4gcmV0dXJuIGEgbmVnYXRpdmUgbnVtYmVyIGlzIGlm
IHRoZSBkcml2ZXIgcGFzc2VzIGluIFAyUERNQQo+PiBwYWdlcyB3aGljaCBjYW4ndCBoYXBwZW4g
d2l0aG91dCBjaGFuZ2VzIGluIHRoZSBkcml2ZXIuIFdlIGFyZSBjYXJlZnVsCj4+IGFib3V0IHdo
ZXJlIFAyUERNQSBwYWdlcyBjYW4gZ2V0IGludG8gc28gd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeSBh
Ym91dAo+PiBhbGwgdGhlIGV4aXN0aW5nIGRyaXZlciBjb2RlIG91dCB0aGVyZS4KPiAKPiBTdXJl
LCB0aGF0J3MgaG93IHRoaW5ncyBzdGFuZCBpbW1lZGlhdGVseSBhZnRlciB0aGlzIHBhdGNoLiBC
dXQgdGhlbgo+IHNvbWVvbmUgY29tZXMgYWxvbmcgd2l0aCB0aGUgcGVyZmVjdGx5IHJlYXNvbmFi
bGUgYXJndW1lbnQgZm9yIHJldHVybmluZwo+IG1vcmUgZXhwcmVzc2l2ZSBlcnJvciBpbmZvcm1h
dGlvbiBmb3IgcmVndWxhciBtYXBwaW5nIGZhaWx1cmVzIGFzIHdlbGwKPiAoYmVjYXVzZSBzb21l
dGltZXMgdGhvc2UgY2FuIGJlIHRlcm1pbmFsIHRvbywgYXMgYWJvdmUpLCB3ZSBzdGFydCB0byBn
ZXQKPiBkaXZlcmdlbnQgYmVoYXZpb3VyIGFjcm9zcyBhcmNoaXRlY3R1cmVzIGFuZCByYW5kb20g
Yml0cyBvZiBvbGQgY29kZQo+IHN1YnRseSBicmVha2luZyBkb3duIHRoZSBsaW5lLiAqVGhhdCog
aXMgd2hhdCBtYWtlcyBtZSB3YXJ5IG9mIG1ha2luZyBhCj4gZnVuZGFtZW50YWwgY2hhbmdlIHRv
IGEgbG9uZy1zdGFuZGluZyAibm9uemVybyBtZWFucyBzdWNjZXNzIiBpbnRlcmZhY2UuLi4KClNv
IHRoZW4gd2UgcmVqZWN0IHRoZSBwYXRjaGVzIHRoYXQgbWFrZSB0aGF0IGNoYW5nZS4gU2VlbXMg
bGlrZSBhbiBvZGQKYXJndW1lbnQgdG8gc2F5IHRoYXQgd2UgY2FuJ3QgZG8gc29tZXRoaW5nIHRo
YXQgd29uJ3QgY2F1c2UgcHJvYmxlbXMKYmVjYXVzZSBzb21lb25lIG1pZ2h0IHVzZSBpdCBhcyBh
biBleGFtcGxlIGFuZCBkbyBzb21ldGhpbmcgdGhhdCB3aWxsCmNhdXNlIHByb2JsZW1zLiBSZWpl
Y3QgdGhlIGNoYW5nZSB0aGF0IGNhdXNlcyB0aGUgcHJvYmxlbS4KCkxvZ2FuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
