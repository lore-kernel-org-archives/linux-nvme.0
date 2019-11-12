Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3789C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24822067B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T1IJ2Fhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24822067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+3xBlhyDPsH2PjeWzSRDKijt6RgbnEiK1SBxTII4fDM=; b=T1IJ2FhdFxHB49Zt6/nMkJ78q
	mQmgka3OIhZl1p6bZSArnGr9d0HXWO/hFNuIQF+AQYcy9XaMikXwkdEXOBE2y0Q9WelCAHytcy1kF
	lwseld6XgqKDpGZgKAPxhQZWuWQJwloP/7oOLlwwFBbfuecnRv/+uId8pGhz3PpglVdsb+r1L9T2T
	aR1Hep4EdLpU3e0sq8ePP8pDW001zeFFdaKa2Yt+KVo8hzL02WDhs21PgRai/k59eWOCqy2e0AiGZ
	/aDQQ/zBPnhx5dV8D9h6g42eUQQoz2w4ef+eONy49AgDsHlAISk9U79kpGW7qy2PusYNF7r0ia8Mo
	ToJfJ97ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUZz4-0005nT-Il; Tue, 12 Nov 2019 17:29:42 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUZz1-0005n2-HD
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 17:29:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 77212B13D;
 Tue, 12 Nov 2019 17:29:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
To: Keith Busch <kbusch@kernel.org>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com> <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
 <8198fd99-6b47-7594-ba1c-4a15ffe25269@suse.de>
 <20191112164947.GB29135@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f69d4e4c-3d6e-74c0-ed97-cac3c6b230c2@suse.de>
Date: Tue, 12 Nov 2019 18:29:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112164947.GB29135@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_092939_716247_74EA053F 
X-CRM114-Status: GOOD (  20.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTIvMTkgNTo0OSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gVHVlLCBOb3YgMTIs
IDIwMTkgYXQgMDU6MjU6NTlQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiAoTml0
cGljazogd2hhdCBkb2VzIGhhcHBlbiB3aXRoIHRoZSBpbnRlcnJ1cHQgaWYgd2UgaGF2ZSBhIG1h
c2sgb2YKPj4gc2V2ZXJhbCBDUFVzPyBXaWxsIHRoZSBpbnRlcnJ1cHQgZGVsaXZlcmVkIHRvIG9u
ZSBDUFU/Cj4+IFRvIGFsbCBpbiB0aGUgbWFzaz8KPiAKPiBUaGUgaGFyZC1pbnRlcnJ1cHQgd2ls
bCBiZSBkZWxpdmVyZWQgdG8gZWZmZWN0aXZlbHkgb25lIG9mIHRoZSBDUFVzIGluIHRoZQo+IG1h
c2suIFRoZSBvbmUgdGhhdCBpcyBzZWxlY3RlZCBpcyBkZXRlcm1pbmVkIHdoZW4gdGhlIElSUSBp
cyBhbGxvY2F0ZWQsCj4gYW5kIGl0IHNob3VsZCB0cnkgdG8gc2VsZWN0IG9uZSBmb3JtIHRoZSBt
YXNrIHRoYXQgaXMgbGVhc3QgdXNlZCAoc2VlCj4gbWF0cml4X2ZpbmRfYmVzdF9jcHVfbWFuYWdl
ZCgpKS4KPiAKWWVhaCwganVzdCBhcyBJIHRob3VnaHQuCldoaWNoIGFsc28gbWVhbnMgdGhhdCB3
ZSBuZWVkIHRvIHJlZGlyZWN0IHRoZSBpcnEgdG8gYSBub24tYnVzeSBjcHUgdG8gCmF2b2lkIHN0
YWxscyB1bmRlciBoaWdoIGxvYWQuCkV4cGVjaWFsbHkgaWYgd2UgaGF2ZSBzZXZlcmFsIE5WTWVz
IHRvIGRlYWwgd2l0aC4KCj4+IENhbid0IHdlIGltcGxlbWVudCBibGtfcG9sbD8gT3IgbWF5YmUg
ZXZlbiB0aHJlYWRlZCBpbnRlcnJ1cHRzPwo+IAo+IFRocmVhZGVkIGludGVycnVwdHMgc291bmQg
Z29vZC4gQ3VycmVudGx5LCB0aG91Z2gsIHRocmVhZGVkIGludGVycnVwdHMKPiBleGVjdXRlIG9u
bHkgb24gdGhlIHNhbWUgY3B1IGFzIHRoZSBoYXJkIGlycS4gVGhlcmUgd2FzIGEgcHJvcG9zYWwg
aGVyZSB0bwo+IGNoYW5nZSB0aGF0IHRvIHVzZSBhbnkgQ1BVIGluIHRoZSBtYXNrLCBhbmQgSSBz
dGlsbCB0aGluayBpdCBtYWtlcyBzZW5zZQo+IAo+ICAgIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMTktQXVndXN0LzAyNjYyOC5odG1sCj4gClRoYXQg
bG9va3MgbGlrZSBqdXN0IHRoZSB0aWNrZXQuCkluIGNvbWJpbmF0aW9uIHdpdGggdGhyZWFkZWQg
aXJxcyBhbmQgcG9zc2libHkgYmxrX3BvbGwgdG8gYXZvaWQgaXJxIApzdG9ybXMgd2Ugc2hvdWxk
IGJlIGdvb2QuCgpMZXQncyBzZWUgaWYgSSBjYW4gY29tZSB1cCB3aXRoIHNvbWV0aGluZy4uLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxl
YWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBMSU5VWCBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgTWFyeSBIaWdnaW5zLCBT
cmkgUmFzaWFoCkhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
