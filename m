Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D2C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 06:44:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A2220665
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 06:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AcBnLCCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A2220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oXimvlG41Ro+8svKE3mqTOs3dPvMIjWsS+qec6wcMLY=; b=AcBnLCCM/c0NjfE6fSdWu9iVY
	Uz0HZA228j+ou/I/J1o0/ctwT22tBLvxslwBwCLgCt9Egh8RiLYIQ/7eVL+LCYD8zPVdgVhQZ3vq+
	I25+sZB5Uq1ZPqQ/tAI3cgPKrsLGXLB6nCCDkkFapcskmvmHp36jVg2i5qNfP/pJDNok+lh1vtO7r
	wDRSQTsEdnSno6gWAFKfOBhnpr8u75wPJftHd7rOjPMPzNP8S5TIdD7KQvgmFNMAd29NINrHk1NGV
	/hkBY/kAw+Ljzrk5YcXPYF18nW/H81H5rEyc0VaTb2E1Spcb7GMQTd4MtguNBzQZsD4VPGiU2/mwL
	ItFkKhQqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI4hA-0002fN-0d; Tue, 15 Sep 2020 06:44:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI4h7-0002f4-Sj
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 06:44:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 050BB6736F; Tue, 15 Sep 2020 08:43:59 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:43:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Message-ID: <20200915064358.GA19535@lst.de>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
 <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <MN2PR19MB3005D217FD29FC88C64106F5EE220@MN2PR19MB3005.namprd19.prod.outlook.com>
 <4291dca3-618a-c6a6-8374-950f6cbb6af9@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4291dca3-618a-c6a6-8374-950f6cbb6af9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_024402_089129_556F4AB1 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMDQ6NTM6NDdQTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPgo+PiBIaSBTYWdpLAo+PiBTdGlsbCBkZWFsaW5nIHdpdGgga2VlcC1hbGl2ZSB0aW1l
b3V0ICB6ZXJvIHZhbHVlIGFuZCBob3cgaXQgYWZmZWN0cyBvdGhlciBzY2VuYXJpb3M6Cj4+IFdp
dGggbXkgbGF0ZXN0IHBhdGNoLCB3aGVuIGtlZXAgYWxpdmUgdGltZW91dCBpcyBzZXQgdG8gemVy
byB0aGUga2VlcC1hbGl2ZSB0aW1lciBpcyBkaXNhYmxlZC4gKFVwc3RyZWFtIGNvbW1pdCAwZDNi
NmE4ZDIxM2EzMDM4N2I1MTA0YjJmYjI1Mzc2ZDE4NjM2ZjIzKQo+PiBCdXQgdGhhdOKAmXMgb25s
eSBwYXJ0IG9mIHRoZSBwaWN0dXJlLAo+PiBXaGF0IGhhcHBlbnMgaWYgYSB1c2VyIHN0YXJ0cyB3
aXRoIGthdG8gPiAwIGFuZCBtb2RpZnlpbmcgaXQgYnkgc2V0IGZlYXR1cmUgYSB3aGlsZSBhZnRl
cj8KPj4gQWZ0ZXIgbW9kaWZ5aW5nIHRoZSBrYXRvIHRvIDAgd2l0aCBhIHNldCBmZWF0dXJlcyB3
ZSB3aWxsIG5ldmVyIHN0b3AgdGhlIHRpbWVyCj4+IEluIGEgc2ltaWxhciB3YXksIHdoZW4gc3Rh
cnRpbmcgd2l0aCBrYXRvIDAgYW5kIHRoZW4gbW9kaWZ5IHRvIGthdG8gPiAwIHdlIHdpbGwgbmV2
ZXIgc3RhcnQgdGhlIHRpbWVyCj4+Cj4+IFdlIHRob3VnaHQgYWJvdXQgc29sdmUgaXQgYnkgYWRk
aW5nIGNoZWNrcyBpbiDigJhudm1ldF9zZXRfZmVhdF9rYXRv4oCZIGZvciB0aGUgYWJvdmUgY2Fz
ZXMKPj4gQW5kIGhhbmRsZSB0aGUga2Ffd29yayBhY2NvcmRpbmdseQo+PiBXaGF0IGRvIHlvdSB0
aGluayA/Cj4KPiBXZSBjYW4gcHJvYmFibHkganVzdCBjYW5jZWwgYW5kIHJlc3RhcnQgdGhlIGtl
ZXAgYWxpdmUgdGltZXIgaW4gdGhhdAo+IGNhc2UuLgoKWWVzLCB0aGUgU2V0IEZlYXR1cmVzIGhh
bmRsZXIgc2hvdWxkOgoKICgxKSBjYW5jZWwgdGhlIHRpbWVyCiAoMikgdXBkYXRlIGl0IHRvIHRo
ZSBuZXcgdmFsdWUKICgzKSBzdGFydCB0aGUgdGltZXIgYWdhaW4gKG52bWV0X3N0YXJ0X2tlZXBf
YWxpdmVfdGltZXIgd2lsbCBoYW5kbGUKICAgICB0aGUga2F0byA9PSAwIGNhc2UpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
