Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BDDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:59:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3B2207F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="glohlGmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3B2207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iB0A3aTS1tahzXEc165+cnhoVQPz9juJm+lbabwJXJI=; b=glohlGmc5m/muIyLJMEbsOXJn
	MslZvr++vOR8uHVcX8jruVRr15s5FtXCatGGqk0IYDqwSDDlFcmKJgkQw0tjRtjLEvcrRd+lfMHyN
	1I/KXR5JPiI68dRXpWH7cIzIKlgDXTd3F2hosjX2KarRF9uqBInBXyuyt2bQc3zasxXidtciTO4NL
	k4zihXMDcJcGE9Kv9+bOTiHWs5/ghWVHavDYae7C7+tlD2RZbqgyK7zCXkXAT9jwCfc1K3jjCBtRa
	IFszKFhU2H52ej5DUsxsmad6fwzxkCiG/WcNP/tN2uAgyLIQNqV5UfqnZq+E3ZuqLo/DVYi3vexTh
	2gSUhMXZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0f7M-0000H8-DE; Wed, 29 Jul 2020 05:59:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0f7K-0000GV-I0
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 05:59:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D42EA68B05; Wed, 29 Jul 2020 07:59:03 +0200 (CEST)
Date: Wed, 29 Jul 2020 07:59:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Message-ID: <20200729055903.GC31113@lst.de>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_015906_720412_B0C909D7 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: kbusch@kernel.org, axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKdWwgMjksIDIwMjAgYXQgMTA6NTQ6MjlBTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+Cj4KPiBPbiAyMDIwLzcvMjggMTk6MTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBP
biBNb24sIEp1bCAyNywgMjAyMCBhdCAwMTo1ODoxOFBNICswODAwLCBDaGFvIExlbmcgd3JvdGU6
Cj4+PiBUaGUgcHJvdG9jb2wgTlZNLUV4cHJlc3MtMS40IGRlZmluZToKPj4+IENvbW1hbmQgSW50
ZXJydXB0ZWQ6IENvbW1hbmQgcHJvY2Vzc2luZyB3YXMgaW50ZXJydXB0ZWQgYW5kIHRoZQo+Pj4g
Y29udHJvbGxlciBpcyB1bmFibGUgdG8gc3VjY2Vzc2Z1bGx5IGNvbXBsZXRlIHRoZSBjb21tYW5k
LiBUaGUgaG9zdAo+Pj4gc2hvdWxkIHJldHJ5IHRoZSBjb21tYW5kLiBJZiB0aGlzIHN0YXR1cyBj
b2RlIGlzIHJldHVybmVkLCB0aGVuCj4+PiB0aGUgY29udHJvbGxlciBzaGFsbCBjbGVhciB0aGUg
RG8gTm90IFJldHJ5IGJpdCB0byDigJgw4oCZIGluIHRoZSBTdGF0dXMKPj4+IGZpZWxkIG9mIHRo
ZSBDUUUgKHJlZmVyIHRvIEZpZ3VyZSAxMjQpLiBUaGUgY29udHJvbGxlciBzaGFsbCBub3QgcmV0
dXJuCj4+PiB0aGlzIHN0YXR1cyBjb2RlIHVubGVzcyB0aGUgaG9zdCBoYXMgc2V0IHRoZSBBZHZh
bmNlZCBDb21tYW5kIFJldHJ5Cj4+PiBFbmFibGUgKEFDUkUpIGZpZWxkIHRvIDFoIGluIHRoZSBI
b3N0IEJlaGF2aW9yIFN1cHBvcnQgZmVhdHVyZShyZWZlciB0bwo+Pj4gc2VjdGlvbiA1LjIxLjEu
MjIpLgo+Pj4KPj4+IEFjY29yZGluZyB0aGUgcHJvdG9jb2wgZGVmaW5lLCBOVk1FX1NDX0NNRF9J
TlRFUlJVUFRFRCBuZWVkIHJldHJ5Lgo+Pj4gVGhlIGVycm9yIGNvZGUgTlZNRV9TQ19DTURfSU5U
RVJSVVBURUQgc2hvdWxkIG5vdCB0cmFuc2xhdGUgdG8KPj4+IEJMS19TVFNfVEFSR0VULCBiZWNh
dXNlIGlmIHRoZSBlcnJvciBjb2RlIHRyYW5zbGF0ZSB0byBCTEtfU1RTX1RBUkdFVCwKPj4+IGRt
LW11bHRpcGFoIHdpbGwgcmV0dXJuIGVycm9yIHRvIGFwcGxpY2F0aW9uLiBTbyBpZiB0YXJnZXQg
cmV0dXJuIGVycm9yCj4+PiBjb2RlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVELCBpbyB3aWxsIGlu
dGVycnVwdC4gTlZNRV9TQ19DTURfSU5URVJSVVBURUQKPj4+IHNob3VsZCB0cmFuc2xhdGUgdG8g
QkxLX1NUU19JT0VSUiBieSBkZWZhdWx0LCBkbS1tdWx0aXBhdGggd2lsbCBmYWlsCj4+PiBvdmVy
IHRvIG90aGVyIHBhdGggcmV0cnkgdGhlIGlvLgo+Pgo+PiBJT0VSUiBzdGlsbCBzZWVtcyB3cm9u
ZywgdGhvdWdoLgo+PiAuCj4KPiBCTEtfU1RTX1RBUkdFVCBtZWFucyB0YXJnZXQgaGFzIGNyaXRp
Y2FsIGVycm9yLiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRAo+IGp1c3QgbWVhbnMgdGFyZ2V0IG5l
ZWQgcmV0cnkgaW8uIEl0IGlzIG5vdCBzdWl0YWJsZSB0byB0cmFuc2xhdGUKPiBOVk1FX1NDX0NN
RF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVC4gTWF5YmUgdHJhbnNsYXRlIHRvCj4gQkxL
X1NUU19JT0VSUiBpcyBhbHNvIG5vdCBzdWl0YWJsZSwgd2Ugc2hvdWxkIHRyYW5zbGF0ZQo+IE5W
TUVfU0NfQ01EX0lOVEVSUlVQVEVEIHRvIEJMS19TVFNfQUdBSU4uCj4gV2UgY2FuIGRvIGxpa2Ug
dGhpczoKCkJMS19TVFNfQUdBSU4gaXMgYSBiYWQgY2hvaWNlIGFzIHdlIHVzZSBpdCBmb3IgY2Fs
bHMgdGhhdCBibG9jayB3aGVuCnRoZSBjYWxsZXJzIGFza2VkIGZvciBub24tYmxvY2tpbmcgc3Vi
bWlzc2lvbi4gIEknbSByZWFsbHkgbm90IHN1cmUKd2Ugd2FudCB0byBjaGFuZ2UgYW55dGhpbmcg
aGVyZSAtIHRoZSBlcnJvciBkZWZpbml0aW9uIGNsZWFybHkgc3RhdGVzCml0IGlzIG5vdCBhIGZh
aWx1cmUgYnV0IGEgcmVxdWVzdCB0byByZXRyeSBsYXRlci4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
