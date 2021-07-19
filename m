Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2391C07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:53:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489CD6113B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489CD6113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zcmOw2/KKPX5TyHlu2iqGnVnxoFD7ZmpkD99FfuTsmQ=; b=s839LG4eSMDYIs
	oe/MXc6Xa41ro33oxn/M218egSiCs0qDNt+w5hA3LaAJiB1qnhdIHD0Hec4n0QPX5j2YvHJjwWAbG
	adWigIkFnMRjMR+CtLfK8ymJG30GzWgXpdVpdLa9d7OEBPqHReErTQHZFvVSJseaqYyIpfa9ww8y/
	dg2Z8ND7O5VMeGP4kE5r89HQc4nFQBuLZ8/oEHoRR8tvmVPCxcL3AgiyPY8htPHCQBi5nCJ5Qfpv7
	kiCQZr3nSpXWKfmhy3xvrQ2fdL1BJqiMu4AlhgYNKwYLxsDiSgUBRXcFx/EAproBCxMqiBS42wSH/
	Ad6cS5JB73PqCQcAoC1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5RpM-009XXw-NA; Mon, 19 Jul 2021 11:52:52 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5RpI-009XXP-UV
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 11:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626695555;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=hf47HkIPWtAcLkubNl+xFO6GIE/eA5xPlwVuQPPhhUc=;
 b=RlzlYHVzcDwBjMTt7O3WtE8tVc+OCheeNZ9brbbZ8OgCmQL/7OqFxzAacWeDq/A3f0
 qdqQni4vXAa6m+BiezMmmHAvn20X5un9b+UAfHsNt4afYaS++f15hzHBwOc1nxUO0Gre
 hNVPCaRztVVVIj8AjjHm+BQiev56hQhxcA9eW9ym4diZdBfDKDFhzx2PpbsyxeIL+Lua
 e0ZKUNHugleIhZDQUxb4kzRJSdlrTMGIw9q0F5wtte80dIECFjFsSUag01TSCGBRAn0C
 zTfa/qVpalxo1XKe4KhiRQUnKGyDvDZ9AdI3UsQyd1gQDnlCP6stz4b7aF2qTHfkI+r3
 IJPQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavJSlBkMRYMkE="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6JBqYI3k
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 19 Jul 2021 13:52:34 +0200 (CEST)
Message-ID: <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From: Stephan Mueller <smueller@chronox.de>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>, 
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Date: Mon, 19 Jul 2021 13:52:33 +0200
In-Reply-To: <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
 <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
 <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
 <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
 <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_045249_215558_0CC8019D 
X-CRM114-Status: GOOD (  46.23  )
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

QW0gTW9udGFnLCBkZW0gMTkuMDcuMjAyMSB1bSAxMzoxMCArMDIwMCBzY2hyaWViIEhhbm5lcyBS
ZWluZWNrZToKPiBPbiA3LzE5LzIxIDEyOjE5IFBNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6Cj4g
PiBBbSBNb250YWcsIGRlbSAxOS4wNy4yMDIxIHVtIDExOjU3ICswMjAwIHNjaHJpZWIgSGFubmVz
IFJlaW5lY2tlOgo+ID4gPiBPbiA3LzE5LzIxIDEwOjUxIEFNLCBTdGVwaGFuIE11ZWxsZXIgd3Jv
dGU6Cj4gPiA+ID4gQW0gTW9udGFnLCBkZW0gMTkuMDcuMjAyMSB1bSAxMDoxNSArMDIwMCBzY2hy
aWViIEhhbm5lcyBSZWluZWNrZToKPiA+ID4gPiA+IE9uIDcvMTgvMjEgMjo1NiBQTSwgU3RlcGhh
biBNw7xsbGVyIHdyb3RlOgo+ID4gPiA+ID4gPiBBbSBTb25udGFnLCAxOC4gSnVsaSAyMDIxLCAx
NDozNzozNCBDRVNUIHNjaHJpZWIgSGFubmVzIFJlaW5lY2tlOgo+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+IFRoZSBrZXkgaXMgYWxzbyB1c2VkIHdoZW4gdXNpbmcgdGhlIGZmZGhlIGFsZ29yaXRobS4K
PiA+ID4gPiA+ID4gPiBOb3RlOiBJIF90aGlua18gdGhhdCBJIG5lZWQgdG8gdXNlIHRoaXMga2V5
IGZvciB0aGUgZmZkaGUKPiA+ID4gPiA+ID4gPiBhbGdvcml0aG0sCj4gPiA+ID4gPiA+ID4gYmVj
YXVzZSB0aGUgaW1wbGVtZW50YXRpb24gSSBjYW1lIHVwIHdpdGggaXMgZXNzZW50aWFsbHkgcGxh
aW4KPiA+ID4gPiA+ID4gPiBESAo+ID4gPiA+ID4gPiA+IHdpdGgKPiA+ID4gPiA+ID4gPiBwcmUt
ZGVmaW5lZCAncCcsICdxJyBhbmQgJ2cnIHZhbHVlcy4gQnV0IHRoZSBESCBpbXBsZW1lbnRhdGlv
bgo+ID4gPiA+ID4gPiA+IGFsc28KPiA+ID4gPiA+ID4gPiByZXF1aXJlcyBhICdrZXknLCBhbmQg
Zm9yIHRoYXQgSSdtIHVzaW5nIHRoaXMga2V5IGhlcmUuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gSXQgbWlnaHQgYmUgdGhhdCBJJ20gY29tcGxldGVseSBvZmYsIGFuZCBkb24ndCBuZWVk
IHRvIHVzZSBhIGtleQo+ID4gPiA+ID4gPiA+IGZvcgo+ID4gPiA+ID4gPiA+IG91cgo+ID4gPiA+
ID4gPiA+IERIIGltcGxlbWVudGF0aW9uLiBJbiB0aGF0IGNhc2UgeW91IGFyZSBjb3JyZWN0Lgo+
ID4gPiA+ID4gPiA+IChBbmQgdGhhdCdzIHdoeSBJIHNhaWQgSSdsbCBuZWVkIGEgcmV2aWV3IG9m
IHRoZSBGRkRIRQo+ID4gPiA+ID4gPiA+IGltcGxlbWVudGF0aW9uKS4KPiA+ID4gPiA+ID4gPiBC
dXQgZm9yIG5vdyBJJ2xsIG5lZWQgdGhlIGtleSBmb3IgRkZESEUuCj4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiBEbyBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3RseSB0aGF0IHRoZSBkaGNoYXBfa2V5
IGlzIHVzZWQgYXMgdGhlCj4gPiA+ID4gPiA+IGlucHV0Cj4gPiA+ID4gPiA+IHRvCj4gPiA+ID4g
PiA+IHRoZSAKPiA+ID4gPiA+ID4gREggLSBpLmUuIGl0IGlzIHRoZSByZW1vdGUgcHVibGljIGtl
eSB0aGVuPyBJdCBsb29rcyBzdHJhbmdlIHRoYXQKPiA+ID4gPiA+ID4gdGhpcwo+ID4gPiA+ID4g
PiBpcwo+ID4gPiA+ID4gPiB1c2VkIAo+ID4gPiA+ID4gPiBmb3IgREggYnV0IHRoZW4gaXQgaXMg
Y2hhbmdlZCBoZXJlIGJ5IGhhc2hpbmcgaXQgdG9nZXRoZXIgd2l0aAo+ID4gPiA+ID4gPiBzb21l
dGhpbmcKPiA+ID4gPiA+ID4gZWxzZSAKPiA+ID4gPiA+ID4gdG8gZm9ybSBhIG5ldyBkaGNoYXBf
a2V5LiBNYXliZSB0aGF0IGlzIHdoYXQgdGhlIHByb3RvY29sIHNheXMuCj4gPiA+ID4gPiA+IEJ1
dCBpdAo+ID4gPiA+ID4gPiBzb3VuZHMgCj4gPiA+ID4gPiA+IHN0cmFuZ2UgdG8gbWUsIGVzcGVj
aWFsbHkgd2hlbiB5b3UgdGhpbmsgdGhhdCBkaGNoYXBfa2V5IHdvdWxkIGJlLAo+ID4gPiA+ID4g
PiBzYXksCj4gPiA+ID4gPiA+IDIwNDggCj4gPiA+ID4gPiA+IGJpdHMgaWYgaXQgaXMgdHJ1bHkg
dGhlIHJlbW90ZSBwdWJsaWMga2V5IGFuZCB0aGVuIGFmdGVyIHRoZQo+ID4gPiA+ID4gPiBoYXNo
aW5nCj4gPiA+ID4gPiA+IGl0IGlzCj4gPiA+ID4gPiA+IDI1NiAKPiA+ID4gPiA+ID4gdGhpcyBk
aGNoYXBfa2V5IGNhbm5vdCBiZSB1c2VkIGZvciBGRkMtREguCj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiBPciBhcmUgeW91IHVzaW5nIHRoZSBkaGNoYXBfa2V5IGZvciB0d28gZGlmZmVyZW50IHB1
cnBvc2VzPwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSXQgc2VlbXMgSSBtaXNzIHNvbWV0aGlu
ZyBoZXJlLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+IE5vLCBub3QgZW50aXJlbHkuIEl0J3MgbWUg
d2hvIGJ1Z2dlcmVkIGl0IHVwLgo+ID4gPiA+ID4gSSBnb3QgY2FycmllZCBhd2F5IGJ5IHRoZSBm
YWN0IHRoYXQgdGhlcmUgaXMgYQo+ID4gPiA+ID4gY3J5cHRvX2RoX2VuY29kZV9rZXkoKQo+ID4g
PiA+ID4gZnVuY3Rpb24sIGFuZCB0aG91Z2h0IEkgbmVlZCB0byB1c2UgaXQgaGVyZS4KPiA+ID4g
PiAKPiA+ID4gPiBUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1l
IHRoYXQgdGhlcmUgaXMgbm8KPiA+ID4gPiBkZWZpbmVkCj4gPiA+ID4gcHJvdG9jb2wgKG9yIGlm
IHRoZXJlLCBJIHdvdWxkIGJlIHdvbmRlcmluZyBob3cgdGhlIGNvZGUgd291bGQgaGF2ZQo+ID4g
PiA+IHdvcmtlZAo+ID4gPiA+IHdpdGggYSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24pLiBXb3Vs
ZCBpdCBtYWtlIHNlbnNlIHRvIGZpcnN0IHNwZWNpZnkKPiA+ID4gPiBhCj4gPiA+ID4gcHJvdG9j
b2wgZm9yIGF1dGhlbnRpY2F0aW9uIGFuZCBoYXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJzb25hbGx5
IHRoaW5rCj4gPiA+ID4gaXQKPiA+ID4gPiBpcyBhCj4gPiA+ID4gYml0IGRpZmZpY3VsdCB0byBm
dWxseSB1bmRlcnN0YW5kIHRoZSBwcm90b2NvbCBmcm9tIHRoZSBjb2RlIGFuZAo+ID4gPiA+IGRp
c2N1c3MKPiA+ID4gPiBwcm90b2NvbC1sZXZlbCBpdGVtcyBiYXNlZCBvbiB0aGUgY29kZS4KPiA+
ID4gPiAKPiA+ID4gT2gsIHRoZSBwcm90b2NvbCBfaXNfIHNwZWNpZmllZDoKPiA+ID4gCj4gPiA+
ICAKPiA+ID4gaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMvTlZNLUV4
cHJlc3MtQmFzZS1TcGVjaWZpY2F0aW9uLTJfMC0yMDIxLjA2LjAyLVJhdGlmaWVkLTUucGRmCj4g
PiA+IAo+ID4gPiBJdCdzIGp1c3QgdGhhdCBJIGhhdmUgaXNzdWVzIHRyYW5zbGF0aW5nIHRoYXQg
c3BlYyBvbnRvIHdoYXQgdGhlIGtlcm5lbAo+ID4gPiBwcm92aWRlcy4KPiA+IAo+ID4gYWNjb3Jk
aW5nIHRvIHRoZSBuYW1pbmcgY29udmVudGlvbnMgdGhlcmUgaW4gZmlndXJlcyA0NDcgYW5kIGZv
bGxvd2luZzoKPiA+IAo+ID4gLSB4IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxz
IGl0IHNlY3JldCBzZXQgd2l0aCBkaF9zZXRfc2VjcmV0Cj4gPiBvcgo+ID4gZW5jb2RlZCBpbnRv
IHBhcmFtLmtleSkKPiA+IAo+IAo+IEJ1dCB0aGF0J3Mgd2VyZSBJIGdvdCBjb25mdXNlZDsgb25l
IG5lZWRzIGEgcHJpdmF0ZSBrZXkgaGVyZSwgYnV0IHRoZXJlCj4gaXMgbm8gb2J2aW91cyBjYW5k
aWRhdGUgZm9yIGl0LiBCdXQgcmVhZGluZyBpdCBtb3JlIGNsb3NlbHkgSSBndWVzcyB0aGUKPiBw
cml2YXRlIGtleSBpcyBqdXN0IGEgcmFuZG9tIG51bWJlciAoY2YgdGhlIHNwZWM6IGdeeSBtb2Qg
cCwgd2hlcmUgeSBpcwo+IGEgcmFuZG9tIG51bWJlciBzZWxlY3RlZCBieSB0aGUgaG9zdCB0aGF0
IHNoYWxsIGJlIGF0IGxlYXN0IDI1NiBiaXRzCj4gbG9uZykuIFNvIEknbGwgZml4IGl0IHVwIHdp
dGggdGhlIG5leHQgcm91bmQuCgpIZXJlIGNvbWVzIHRoZSBjcnV4OiB0aGUga2VybmVsIGhhcyBh
biBFQ0MgcHJpdmF0ZSBrZXkgZ2VuZXJhdGlvbiBmdW5jdGlvbgplY2RoX3NldF9zZWNyZXQgdHJp
Z2dlcmVkIHdpdGggY3J5cHRvX2twcF9zZXRfc2VjcmV0IHVzaW5nIGEgTlVMTCBrZXksIGJ1dCBp
dApoYXMgbm8gRkZDLURIIGNvdW50ZXJwYXJ0LgoKVGhhdCBzYWlkLCBnZW5lcmF0aW5nIGEgcmFu
ZG9tIG51bWJlciBpcyB0aGUgbW9zdCBvYnZpb3VzIGNob2ljZSwgYnV0IG5vdCB0aGUKcmlnaHQg
b25lLgoKVGhlIGNvcnJlY3Qgb25lIHdvdWxkIGJlIGZvbGxvd2luZyBTUDgwMC01NkEgcmV2IDMg
YW5kIGhlcmUgZWl0aGVyIHNlY3Rpb24KNS42LjEuMS4zIG9yIDUuNi4xLjEuNC4KCkNpYW8KU3Rl
cGhhbgo+IAo+ID4gLSBnXnggbW9kIHDCoCAvIGdeeSBtb2QgcDogREggcHVibGljIGtleXMgZnJv
bSBlaXRoZXIgZW5kIHRoYXQgaXMKPiA+IGNvbW11bmljYXRlZAo+ID4gb3ZlciB0aGUgd2lyZSAo
Y29ycmVzcG9uZGluZyB0byB0aGUgdGhlIERIIHByaXZhdGUga2V5cyBvZiB4IGFuZCB5KSAtIHRv
Cj4gPiBzZXQKPiA+IGl0LCB5b3UgaW5pdGlhbGl6ZSBhIGRoIHJlcXVlc3QgYW5kIHNldCB0aGUg
cHVibGljIGtleSB0byBpdCB3aXRoCj4gPiBrcHBfcmVxdWVzdF9zZXRfaW5wdXQuIEFmdGVyIHBl
cmZvcm1pbmcgdGhlCj4gPiBjcnlwdG9fa3BwX2NvbXB1dGVfc2hhcmVkX3NlY3JldAo+ID4geW91
IHJlY2VpdmUgdGhlIHNoYXJlZCBzZWNyZXQKPiA+IAo+ID4gLSBnXnh5IG1vZCBwOiBESCBzaGFy
ZWQgc2VjcmV0IC0gdGhpcyBpcyB0aGUgb25lIHRoYXQgaXMgdG8gYmUgdXNlZCBmb3IKPiA+IHRo
ZQo+ID4gc3Vic2VxdWVudCBoYXNoaW5nIC9ITUFDIG9wZXJhdGlvbnMgYXMgdGhpcyBpcyB0aGUg
b25lIHRoYXQgaXMgaWRlbnRpY2FsCj4gPiBvbgo+ID4gYm90aCwgdGhlIGhvc3QgYW5kIHRoZSBj
b250cm9sbGVyLgo+ID4gCj4gVGhhbmtzLiBXaWxsIGJlIGNoZWNraW5nIHRoZSBjb2RlIGlmIEkg
ZG8gaXQgY29ycmVjdGx5Lgo+IAo+IENoZWVycywKPiAKPiBIYW5uZXMKCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
