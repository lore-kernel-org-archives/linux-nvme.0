Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE0C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 11:20:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B032064B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 11:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EduoPtj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B032064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AZjY6cNIfbRWN+l4HCXGHbbTXY6JvWVFnHH9u4JIJPI=; b=EduoPtj4G/orjVzhOZIT8E6bY
	v6t/Sm8/5Fx94fTvurlMuD8aahnSAFNzEG31pZhu0/Y+TfWG7QOb+OX2HzfR8ANWowrqSKlCrP1Ms
	X4v6s712n4y2TjWEgaW/UCqyuIAJIi4Sz7lxlSQm8hw4dDs3JTuIMEeHaPqRIJWNWUZhZ9co//WAY
	xCPZNeFCN5QVEw6/nRiheW8PuU/+LQMd9+JPz/B0wlqJCi/mppaPF8LJ/CoTvo+SV1cM40Mm1Ii2T
	J03xE9eYb/gXf7oH8W8D1IzJRIDATpkvNI34bZStyVtEQhGDmNH0Hic+JAPZ8C26sGK9wFmxmONW9
	c7EICcwhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0NeM-0000Rz-UA; Tue, 28 Jul 2020 11:20:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0NeJ-0000QB-Lo
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 11:20:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E76B068C4E; Tue, 28 Jul 2020 13:19:56 +0200 (CEST)
Date: Tue, 28 Jul 2020 13:19:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Message-ID: <20200728111956.GA31546@lst.de>
References: <20200727055818.21430-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727055818.21430-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_071959_895115_EE487155 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKdWwgMjcsIDIwMjAgYXQgMDE6NTg6MThQTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+IFRoZSBwcm90b2NvbCBOVk0tRXhwcmVzcy0xLjQgZGVmaW5lOgo+IENvbW1hbmQgSW50ZXJy
dXB0ZWQ6IENvbW1hbmQgcHJvY2Vzc2luZyB3YXMgaW50ZXJydXB0ZWQgYW5kIHRoZQo+IGNvbnRy
b2xsZXIgaXMgdW5hYmxlIHRvIHN1Y2Nlc3NmdWxseSBjb21wbGV0ZSB0aGUgY29tbWFuZC4gVGhl
IGhvc3QKPiBzaG91bGQgcmV0cnkgdGhlIGNvbW1hbmQuIElmIHRoaXMgc3RhdHVzIGNvZGUgaXMg
cmV0dXJuZWQsIHRoZW4KPiB0aGUgY29udHJvbGxlciBzaGFsbCBjbGVhciB0aGUgRG8gTm90IFJl
dHJ5IGJpdCB0byDigJgw4oCZIGluIHRoZSBTdGF0dXMKPiBmaWVsZCBvZiB0aGUgQ1FFIChyZWZl
ciB0byBGaWd1cmUgMTI0KS4gVGhlIGNvbnRyb2xsZXIgc2hhbGwgbm90IHJldHVybgo+IHRoaXMg
c3RhdHVzIGNvZGUgdW5sZXNzIHRoZSBob3N0IGhhcyBzZXQgdGhlIEFkdmFuY2VkIENvbW1hbmQg
UmV0cnkKPiBFbmFibGUgKEFDUkUpIGZpZWxkIHRvIDFoIGluIHRoZSBIb3N0IEJlaGF2aW9yIFN1
cHBvcnQgZmVhdHVyZShyZWZlciB0bwo+IHNlY3Rpb24gNS4yMS4xLjIyKS4KPiAKPiBBY2NvcmRp
bmcgdGhlIHByb3RvY29sIGRlZmluZSwgTlZNRV9TQ19DTURfSU5URVJSVVBURUQgbmVlZCByZXRy
eS4KPiBUaGUgZXJyb3IgY29kZSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBzaG91bGQgbm90IHRy
YW5zbGF0ZSB0bwo+IEJMS19TVFNfVEFSR0VULCBiZWNhdXNlIGlmIHRoZSBlcnJvciBjb2RlIHRy
YW5zbGF0ZSB0byBCTEtfU1RTX1RBUkdFVCwKPiBkbS1tdWx0aXBhaCB3aWxsIHJldHVybiBlcnJv
ciB0byBhcHBsaWNhdGlvbi4gU28gaWYgdGFyZ2V0IHJldHVybiBlcnJvcgo+IGNvZGUgTlZNRV9T
Q19DTURfSU5URVJSVVBURUQsIGlvIHdpbGwgaW50ZXJydXB0LiBOVk1FX1NDX0NNRF9JTlRFUlJV
UFRFRAo+IHNob3VsZCB0cmFuc2xhdGUgdG8gQkxLX1NUU19JT0VSUiBieSBkZWZhdWx0LCBkbS1t
dWx0aXBhdGggd2lsbCBmYWlsCj4gb3ZlciB0byBvdGhlciBwYXRoIHJldHJ5IHRoZSBpby4KCklP
RVJSIHN0aWxsIHNlZW1zIHdyb25nLCB0aG91Z2guCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
