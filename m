Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCD8C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:46:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787CE64F30
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787CE64F30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rB5PDzzhLhvink4mS/QVRW9ibM2W0Ldk3VPCTtQBxhs=; b=F31Ytdz99R5p2ahJrZTacbf1r
	LXSfUFltVGyfiKjgKw7Cbgu2IlGalWl/fetK0fiH+7d4C1cAHqgH30J+PYH2jvQLDzEXzFbZZZ0qV
	ZHI5m2ZVYHyEK1Mx/EMVZhpMBegcZXL7K0c1pUbBlnafgqcVDXY0ve+IIC5F2mQdTM+PUdEyS9ohd
	lbZeRMNsbAuV/SLfl9pwHnwBsSKiHq4J9vqZl9wVQ4gWuPtecWyqo5+RiQOY7kOUmftCEaJiwJITp
	h0x7VjAZwnt2eEsX2Y02QScfjb8mlPT30ntqU2vW92epEvyuCmp9AWURGtmrtIpmNZydSQgdBuVDT
	SKlkKsm7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMkXg-004RAy-P2; Thu, 18 Mar 2021 04:45:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMkXV-004R90-P6
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 04:45:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 85DB568C4E; Thu, 18 Mar 2021 05:45:39 +0100 (CET)
Date: Thu, 18 Mar 2021 05:45:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210318044539.GA27156@lst.de>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_044547_742418_D0FC7451 
X-CRM114-Status: GOOD (  23.42  )
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

T24gVGh1LCBNYXIgMTgsIDIwMjEgYXQgMDk6NTE6MTRBTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+Pj4+IFRoZSBtdWx0aXBhdGggY29kZSB3b3VsZCBoYXZlIHRvIGtpY2sgdGhlIGxpc3QuwqAg
V2UgY291bGQgYWxzbyB0cnkgdG8KPj4+PiBzcGxpdCBpbnRvIHR3byBmbGFncywgb25lIHRoYXQg
YWZmZWN0cyBibGtfcXVldWVfZW50ZXIgYW5kIG9uZSB0aGF0Cj4+Pj4gYWZmZWN0cyB0aGUgdGFn
IGFsbG9jYXRpb24uCj4+Pj4KPj4+Pj4gbW92aW5nIG52bWVfc3RhcnRfZnJlZXplIGZyb20gbnZt
ZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyB0byBudm1lX3JkbWFfY29uZmlndXJlX2lvX3F1ZXVl
cyBjYW4gZml4IGl0Lgo+Pj4+PiBJdCBjYW4gYWxzbyBhdm9pZCBJL08gaGFuZyBsb25nIHRpbWUg
aWYgcmVjb25uZWN0aW9uIGZhaWxlZC4KPj4+Pgo+Pj4+IENhbiB5b3UgZXhwbGFpbiBob3cgd2Un
ZCBzdGlsbCBlbnN1cmUgdGhhdCBubyBuZXcgY29tbWFuZHMgZ2V0IHF1ZXVlZAo+Pj4+IGR1cmlu
ZyB0ZWFyZG93biB1c2luZyB0aGF0IHNjaGVtZT8KPj4+IDEuIHRlYXIgZG93biB3aWxsIGNhbmNl
bCBhbGwgaW5mbGlnaHQgcmVxdWVzdHMsIGFuZCB0aGVuIG11bHRpcGF0aCB3aWxsIGNsZWFyIHRo
ZSBwYXRoLgo+Pj4gMi4gYW5kIHRoZW4gd2UgbWF5IGZyZWV6ZSB0aGUgY29udHJvbGVyLgo+Pj4g
My4gbnZtZV9uc19oZWFkX3N1Ym1pdF9iaW8gY2FuIG5vdCBmaW5kIHRoZSByZWNvbm5lY3Rpb24g
Y29udHJvbGxlciBhcyB2YWxpZCBwYXRoLCBzbyBpdCBpcyBzYWZlLgo+Pgo+PiBJbiBub24tbXBh
dGggKHdoaWNoIHVuZm9ydHVuYXRlbHkgaXMgYSB2YWxpZCB1c2UtY2FzZSksIHRoZXJlIGlzIG5v
Cj4+IGZhaWxvdmVyLCBhbmQgd2UgY2Fubm90IGZyZWV6ZSB0aGUgcXVldWUgYWZ0ZXIgd2Ugc3Rv
cHBlZCAoYW5kL29yCj4+IHN0YXJ0ZWQpIHRoZSBxdWV1ZXMgYmVjYXVzZSB0aGVuIGZhaWxfbm9u
X3JlYWR5X2NvbW1hbmQoKSBjb25zdGFudGx5IHJldHVybiBCTEtfU1RTX1JFU09VUkNFIChqdXN0
IGNhdXNpbmcgYSByZS1zdWJtaXNzaW9uIG92ZXIgYW5kIG92ZXIKPj4gYWdhaW4pIGFuZCB0aGUg
ZnJlZXplIHdpbGwgbmV2ZXIgY29tcGxldGUgKHRoZSBjb21tYW5kcyBhcmUgc3RpbGwKPj4gaW5m
bGlnaHQgZnJvbSB0aGUgcXVldWUtPmdfdXNhZ2VfY291bnRlciBwZXJzcGVjdGl2ZSkuCj4gSWYg
dGhlIHJlcXVlc3Qgc2V0IHRoZSBmbGFncyB0byBSRVFfRkFJTEZBU1RfeHh4LCB3aWxsIGhhbmcg
bG9uZyB0aW1lIGlmIHJlY29ubmVjdGlvbiBmYWlsZWQuCj4gVGhpcyBpcyBub3QgZXhwZWN0ZWQu
Cj4gQW5vdGhlciwgSWYgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGxpdmUgYW5kIHRoZSBjb250cm9s
bGVyIGlzIGZyZWV6ZWQg77yMZmFzdF9pb19mYWlsX3RtbyB3aWxsIG5vdCB3b3JrLgo+IFRoaXMg
aXMgYWxzbyBub3QgZXhwZWN0ZWQuCj4gU28gSSB0aGluayBmcmVlemluZyB0aGUgY29udHJvbGxl
ciB3aGVuIHJlY29ubmVjdGluZyBpcyBub3QgZ29vZCBpZGVhLgo+IEl0J3MgcmVhbGx5IG5vdCBn
b29kIGJlaGF2aW9yIHRvIHRyeSBhZ2FpbiBhbmQgYWdhaW4uIFRoaXMgaXMgYXQgbGVhc3QgYmV0
dGVyIHRoYW4gcmVxdWVzdCBoYW5nIGxvbmcgdGltZS4KCldlbGwsIGl0IGlzIHByZXR0eSBjbGVh
ciB0aGF0IFJFUV9GQUlMRkFTVF8qIChhbmQgSSdtIHN0aWxsIGNvbmZ1c2VkCmFib3V0IHRoZSB0
aHJlZSB2YXJpYW50cyBvZiB0aGF0KSBzaG91bGQgbm90IGJsb2NrIGluIGJsa19xdWV1ZV9lbnRl
ciwKYW5kIHdlIHNob3VsZCBtYWtlIHN1cmUgbnZtZS1tdWx0aXBhdGggdHJpZ2dlcnMgdGhhdC4g
IExldCBtZSB0aGluZwpvZiBhIGdvb2Qgd2F5IHRvIHJlZmFjdG9yIGJsa19xdWV1ZV9lbnRlciBm
aXJzdCB0byBtYWtlIHRoYXQgbGVhc3QKcGFpbmZ1bC4KCj4+IFNvIEkgdGhpbmsgd2Ugc2hvdWxk
IHN0aWxsIHN0YXJ0IHF1ZXVlIGZyZWV6ZSBiZWZvcmUgd2UgcXVpZXNjZQo+PiB0aGUgcXVldWVz
Lgo+IFdlIHNob3VsZCB1bnF1aWVzY2UgYW5kIHVuZnJlZXplIHRoZSBxdWV1ZXMgd2hlbiByZWNv
bm5lY3RpbmcsIG90aGVyd2lzZSBmYXN0X2lvX2ZhaWxfdG1vIHdpbGwgbm90IHdvcmsuCj4+Cj4+
IEkgc3RpbGwgZG9uJ3Qgc2VlIGhvdyB0aGUgbXBhdGggTk9XQUlUIHN1Z2dlc3Rpb24gd29ya3Mg
ZWl0aGVyLi4uCj4gbXBhdGggd2lsbCBxdWV1dWUgcmVxdWVzdCB0byBvdGhlciBsaXZlIHBhdGgg
b3IgcmVxdWV1ZSB0aGUgcmVxdWVzdChpZiBubyB1c2VkIHBhdGgpLCBzbyBpdCB3aWxsIG5vdCB3
YWl0Lgo+PiAuCgpZZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
