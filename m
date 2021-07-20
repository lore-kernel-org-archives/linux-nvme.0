Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B0C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 14:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B125761357
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B125761357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHsoz52RdKY+GBx1RWaSP6R4xXfMWekySLIA8xlM3hQ=; b=ucgFh6mvkS3kRG
	Do+BW+PtZr2v4KuFXp1ibg99oUaNQteFTwRQs+eFj3lSlIzWnUegVIwMkMEQXnYp/gq2qiBd64hYu
	9jX325dufte/JoTHbMlBO1H6JKSSFZidYgA+dszOcitbgo0rkgOz4RWmFuFsjP8MnGbXgShwIXiDb
	MQ8itQm5Gs+eMaYV8UAHvRI8okqCziuG5hCiEqqxdxygouV71x56Ahf1bZ1ef/SnGuZDOLdrso0Dp
	x3xUnMUs10N7Yvg170GLRiEr96U/5wk84mQlkg3JvXmJ17fcBu3t1ikUKJeAt6p1efjY/w7MOf2Of
	lFBkzUatEv/eysWc40AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5r2x-00DG5T-FB; Tue, 20 Jul 2021 14:48:35 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5r2r-00DG3m-HL
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 14:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626792422;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=2ext2HbZCebivrUEfPaefJ7YkT8e3f+S3d0yax4+EMM=;
 b=mH5se4Db7wwSUq2HqPvlciYkQCP4NwGSehtiMD3a13xZBnZgLnGQHd9pYpBSYvHYJA
 DOzdMjyfNg4yldQbb3+8JZ8kjXMI9qAbApoE5Hjgzi9xG8pHm2UFJTWkNxJUnlV1lawI
 qJ2zOCdc+zV/Z57n1W/T2RiMhs3j+yv6QGfeI7knGB1FdHI61kkIXldPEbXFKt8J4URC
 Hv6jonONBwOC1NmvjBaIt6ONAUKROQtcVFPfr2g/hbL0qyw55b0ofHcopNtDrSUGr44m
 h3+KALsgjDjuKu3Gvxrz7ldbsGASSrAQUKyeLtgSWaqJJHJRaHIQ93FgUVXZVSayarLO
 i2+Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavLS5ZjMVaXg=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6KEl1NUn
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 20 Jul 2021 16:47:01 +0200 (CEST)
Message-ID: <d170c0cfcb8bbeb4fe4bed367cd4689a522ae469.camel@chronox.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From: Stephan Mueller <smueller@chronox.de>
To: Simo Sorce <simo@redhat.com>, Hannes Reinecke <hare@suse.de>, Christoph
 Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>, 
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Date: Tue, 20 Jul 2021 16:47:00 +0200
In-Reply-To: <5ec6c8d5a0259a2d632589c154093ebfbbcdb47b.camel@redhat.com>
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
 <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
 <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
 <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
 <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
 <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
 <aac9448e-29e9-6d03-1077-148be3c10f50@suse.de>
 <11ab4001f580a6b2c3cce959282259c1f9095f63.camel@redhat.com>
 <4cd673a8-a503-c29a-85f6-3c2703558181@suse.de>
 <5ec6c8d5a0259a2d632589c154093ebfbbcdb47b.camel@redhat.com>
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_074829_813932_F27D0A06 
X-CRM114-Status: GOOD (  56.41  )
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

QW0gRGllbnN0YWcsIGRlbSAyMC4wNy4yMDIxIHVtIDEwOjQ0IC0wNDAwIHNjaHJpZWIgU2ltbyBT
b3JjZToKPiBPbiBUdWUsIDIwMjEtMDctMjAgYXQgMTM6MzEgKzAyMDAsIEhhbm5lcyBSZWluZWNr
ZSB3cm90ZToKPiA+IE9uIDcvMjAvMjEgMTI6NDkgUE0sIFNpbW8gU29yY2Ugd3JvdGU6Cj4gPiA+
IE9uIFR1ZSwgMjAyMS0wNy0yMCBhdCAxMjoxNCArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3Rl
Ogo+ID4gPiA+IE9uIDcvMTkvMjEgMTo1MiBQTSwgU3RlcGhhbiBNdWVsbGVyIHdyb3RlOgo+ID4g
PiA+ID4gQW0gTW9udGFnLCBkZW0gMTkuMDcuMjAyMSB1bSAxMzoxMCArMDIwMCBzY2hyaWViIEhh
bm5lcyBSZWluZWNrZToKPiA+ID4gPiA+ID4gT24gNy8xOS8yMSAxMjoxOSBQTSwgU3RlcGhhbiBN
dWVsbGVyIHdyb3RlOgo+ID4gPiA+ID4gPiA+IEFtIE1vbnRhZywgZGVtIDE5LjA3LjIwMjEgdW0g
MTE6NTcgKzAyMDAgc2NocmllYiBIYW5uZXMKPiA+ID4gPiA+ID4gPiBSZWluZWNrZToKPiA+ID4g
PiA+ID4gPiA+IE9uIDcvMTkvMjEgMTA6NTEgQU0sIFN0ZXBoYW4gTXVlbGxlciB3cm90ZToKPiA+
ID4gPiBbIC4uIF0KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rIHlv
dSBmb3IgY2xhcmlmeWluZyB0aGF0LiBJdCBzb3VuZHMgdG8gbWUgdGhhdCB0aGVyZSBpcwo+ID4g
PiA+ID4gPiA+ID4gPiBubwo+ID4gPiA+ID4gPiA+ID4gPiBkZWZpbmVkIHByb3RvY29sIChvciBp
ZiB0aGVyZSwgSSB3b3VsZCBiZSB3b25kZXJpbmcgaG93IHRoZQo+ID4gPiA+ID4gPiA+ID4gPiBj
b2RlIHdvdWxkIGhhdmUKPiA+ID4gPiA+ID4gPiA+ID4gd29ya2VkCj4gPiA+ID4gPiA+ID4gPiA+
IHdpdGggYSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24pLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRv
Cj4gPiA+ID4gPiA+ID4gPiA+IGZpcnN0IHNwZWNpZnkKPiA+ID4gPiA+ID4gPiA+ID4gYSBwcm90
b2NvbCBmb3IgYXV0aGVudGljYXRpb24gYW5kIGhhdmUgaXQgZGlzY3Vzc2VkPyBJCj4gPiA+ID4g
PiA+ID4gPiA+IHBlcnNvbmFsbHkgdGhpbmsKPiA+ID4gPiA+ID4gPiA+ID4gaXQgaXMgYSBiaXQg
ZGlmZmljdWx0IHRvIGZ1bGx5IHVuZGVyc3RhbmQgdGhlIHByb3RvY29sIGZyb20KPiA+ID4gPiA+
ID4gPiA+ID4gdGhlIGNvZGUgYW5kCj4gPiA+ID4gPiA+ID4gPiA+IGRpc2N1c3MgcHJvdG9jb2wt
bGV2ZWwgaXRlbXMgYmFzZWQgb24gdGhlIGNvZGUuCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiA+ID4gT2gsIHRoZSBwcm90b2NvbCBfaXNfIHNwZWNpZmllZDoKPiA+ID4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiA+ID4gwqAKPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbnZtZXhwcmVzcy5v
cmcvd3AtY29udGVudC91cGxvYWRzL05WTS1FeHByZXNzLUJhc2UtU3BlY2lmaWNhdGlvbi0yXzAt
MjAyMS4wNi4wMi1SYXRpZmllZC01LnBkZgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiBJdCdzIGp1c3QgdGhhdCBJIGhhdmUgaXNzdWVzIHRyYW5zbGF0aW5nIHRoYXQgc3BlYyBvbnRv
IHdoYXQKPiA+ID4gPiA+ID4gPiA+IHRoZSBrZXJuZWwKPiA+ID4gPiA+ID4gPiA+IHByb3ZpZGVz
Lgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IGFjY29yZGluZyB0byB0aGUgbmFtaW5nIGNv
bnZlbnRpb25zIHRoZXJlIGluIGZpZ3VyZXMgNDQ3IGFuZAo+ID4gPiA+ID4gPiA+IGZvbGxvd2lu
ZzoKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiAtIHggYW5kIHk6IERIIHByaXZhdGUga2V5
IChrZXJuZWwgY2FsbHMgaXQgc2VjcmV0IHNldCB3aXRoCj4gPiA+ID4gPiA+ID4gZGhfc2V0X3Nl
Y3JldAo+ID4gPiA+ID4gPiA+IG9yCj4gPiA+ID4gPiA+ID4gZW5jb2RlZCBpbnRvIHBhcmFtLmtl
eSkKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEJ1dCB0aGF0J3Mgd2Vy
ZSBJIGdvdCBjb25mdXNlZDsgb25lIG5lZWRzIGEgcHJpdmF0ZSBrZXkgaGVyZSwgYnV0Cj4gPiA+
ID4gPiA+IHRoZXJlCj4gPiA+ID4gPiA+IGlzIG5vIG9idmlvdXMgY2FuZGlkYXRlIGZvciBpdC4g
QnV0IHJlYWRpbmcgaXQgbW9yZSBjbG9zZWx5IEkKPiA+ID4gPiA+ID4gZ3Vlc3MgdGhlCj4gPiA+
ID4gPiA+IHByaXZhdGUga2V5IGlzIGp1c3QgYSByYW5kb20gbnVtYmVyIChjZiB0aGUgc3BlYzog
Z155IG1vZCBwLCB3aGVyZQo+ID4gPiA+ID4gPiB5IGlzCj4gPiA+ID4gPiA+IGEgcmFuZG9tIG51
bWJlciBzZWxlY3RlZCBieSB0aGUgaG9zdCB0aGF0IHNoYWxsIGJlIGF0IGxlYXN0IDI1Ngo+ID4g
PiA+ID4gPiBiaXRzCj4gPiA+ID4gPiA+IGxvbmcpLiBTbyBJJ2xsIGZpeCBpdCB1cCB3aXRoIHRo
ZSBuZXh0IHJvdW5kLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBIZXJlIGNvbWVzIHRoZSBjcnV4OiB0
aGUga2VybmVsIGhhcyBhbiBFQ0MgcHJpdmF0ZSBrZXkgZ2VuZXJhdGlvbgo+ID4gPiA+ID4gZnVu
Y3Rpb24KPiA+ID4gPiA+IGVjZGhfc2V0X3NlY3JldCB0cmlnZ2VyZWQgd2l0aCBjcnlwdG9fa3Bw
X3NldF9zZWNyZXQgdXNpbmcgYSBOVUxMCj4gPiA+ID4gPiBrZXksIGJ1dCBpdAo+ID4gPiA+ID4g
aGFzIG5vIEZGQy1ESCBjb3VudGVycGFydC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhhdCBzYWlk
LCBnZW5lcmF0aW5nIGEgcmFuZG9tIG51bWJlciBpcyB0aGUgbW9zdCBvYnZpb3VzIGNob2ljZSwK
PiA+ID4gPiA+IGJ1dCBub3QgdGhlCj4gPiA+ID4gPiByaWdodCBvbmUuCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IFRoZSBjb3JyZWN0IG9uZSB3b3VsZCBiZSBmb2xsb3dpbmcgU1A4MDAtNTZBIHJldiAz
IGFuZCBoZXJlIGVpdGhlcgo+ID4gPiA+ID4gc2VjdGlvbgo+ID4gPiA+ID4gNS42LjEuMS4zIG9y
IDUuNi4xLjEuNC4KPiA+ID4gPiA+IAo+ID4gPiA+IEhtbS4gT2theS4gQnV0IGFmdGVyIGhhdmlu
ZyByZWFkIHNlY3Rpb24gNS42LjEuMS40LCBJIHN0aWxsIGRvIGhhdmUKPiA+ID4gPiBzb21lCj4g
PiA+ID4gcXVlc3Rpb25zLgo+ID4gPiA+IAo+ID4gPiA+IEFzc3VtZSB3ZSB3aWxsIGJlIHVzaW5n
IGEgYml0IGxlbmd0aCBvZiA1MTIgZm9yIEZGREhFLCB0aGVuIHdlIHdpbGwKPiA+ID4gPiB0cml2
aWFsbHkgcGFzcyBTdGVwIDIgZm9yIGFsbCBzdXBwb3J0ZWQgRkZESEUgZ3JvdXBzICh0aGUgbWF4
aW11bQo+ID4gPiA+IHN5bW1ldHJpYy1lcXVpdmFsZW50IHN0cmVuZ3RoIGZvciBmZmRoZTgxOTIg
aXMgMTkyIGJpdHMpLgo+ID4gPiAKPiA+ID4gTiA9IDUxMiBpcyBub3QgYSBnb29kIGNob2ljZSwg
bWluaW11bSBsZW5ndGggdGhlc2UgZGF5cyBmb3IgREggc2hvdWxkCj4gPiA+IGJlIDIwNDggb3Ig
bW9yZS4KPiA+ID4gCj4gPiAKPiA+IEFjY29yZGluZyB0byBSRkM3OTE5Ogo+ID4gUGVlcnMgdXNp
bmcgZmZkaGU4MTkyIHRoYXQgd2FudCB0byBvcHRpbWl6ZSB0aGVpciBrZXkgZXhjaGFuZ2Ugd2l0
aCBhCj4gPiBzaG9ydCBleHBvbmVudCAoU2VjdGlvbiA1LjIpIHNob3VsZCBjaG9vc2UgYSBzZWNy
ZXQga2V5IG9mIGF0IGxlYXN0Cj4gPiA0MDAgYml0cy4KPiA+IAo+ID4gU28gd2hhdCBpcyB3cm9u
ZyB3aXRoIDUxMiBiaXRzPwo+IAo+IAo+IFJGQzc1MTkgaXMgVExTIFNwZWNpZmljLgo+IEkgZG8g
bm90IGtub3cgaWYgc2hvcnQtZXhwb25lbnRzIGFyZSBzYWZlIHRvIHVzZSBpbiBhbGwgdXNlIGNh
c2VzLgo+IAo+IElmIGl0IGlzIHNhZmUsIHlvdXIgY2hvaWNlIGlzIGZpbmUgYW5kIHlvdXIgYXJn
dW1lbnRzIHdpbGwgZm9sbG93LCBidXQKPiB0aGVuIGEgY29tbWVudCB0aGF0IGV4cGxhaW5zIHRo
ZSBjaG9pY2UgYW5kIHdhcm5zIGFib3V0IGtleSBjaGVja3MgaWYKPiBpdCBpcyBjaGFuZ2VkIHdv
dWxkIGJlIGEgZ29vZCBpZGVhLgo+IAo+IE90aGVyd2lzZSB0aGUgZGVmYXVsdCBzaG91bGQgYmUg
dG8gdXNlIE4gPSBsZW4ocSksIHdoaWNoIGltcGxpZXMgdGhlCj4gcHJvcGVyIGNoZWNrcyBuZWVk
IHRvIGJlIGFwcGxpZWQuCgpBZ3JlZWQuCgpDaWFvClN0ZXBoYW4KPiAKPiBTaW1vLgo+IAo+ID4g
PiA+IEZyb20gbXkgdW5kZXJzdGFuZGluZywgdGhlIHJhbmRvbSBudW1iZXIgZ2VuZXJhdG9yIHdp
bGwgZmlsbCBvdXQgYWxsCj4gPiA+ID4gYXZhaWxhYmxlIGJ5dGVzIGluIHRoZSBzdHJpbmcgKGFu
ZCBub3RoaW5nIG1vcmUpLCBzbyB3ZSB0cml2aWFsbHkKPiA+ID4gPiBzYXRpc2Z5IHN0ZXAgMyBh
bmQgNC4KPiA+ID4gPiAKPiA+ID4gPiBBbmQgYXMgcSBpcyBhbHdheXMgbGFyZ2VyIHRoYW4gdGhl
IHJhbmRvbSBudW1iZXIsIHN0ZXAgNiByZWR1Y2VzIHRvCj4gPiA+ID4gJ2lmIChjID4gMl5OIC0g
MiknLAo+ID4gPiAKPiA+ID4gV2hlcmUgaXMgdGhpcyBjb21pbmcgZnJvbSA/Cj4gPiA+IEl0IHNl
ZW0geW91IGFzc3VtZSBNID0gMl5OIGJ1dCBNID0gbWluKDJeTiwgcSkKPiA+ID4gCj4gPiA+IFRo
ZSBwb2ludCBoZXJlIGlzIHRvIG1ha2Ugc3VyZSB0aGUgbnVtYmVyIFggeW91IHJldHVybiBpczoK
PiA+ID4gMCA8IFggPCAocS0xKQo+ID4gPiAKPiA+IAo+ID4gV2hpY2ggaXMgd2hhdCBJJ3ZlIHRy
aWVkIHRvIGFyZ3VlLiBGb3IgNTEyIGJpdHMgcHJpdmF0ZSBrZXkgYW5kIHRoZQo+ID4gc21hbGxl
c3QgcG9zc2libGUgRkZESEUgZ3JvdXAgKHdoaWNoIGhhcyAyMDQ4IGJpdHMsIHdpdGggdGhlIHRv
cCBiaXQKPiA+IG5vbi16ZXJvKSAyXk4gaXMgYWx3YXlzIHNtYWxsZXIgdGhhbiAocSAtIDEpLgo+
ID4gQXMgdGhlIG90aGVyIEZGSERFIGdyb3VwcyBhcmUgdXNpbmcgZXZlbiBsYXJnZXIgJ3EnIHZh
bHVlcywgdGhpcyBpcyB0cnVlCj4gPiBmb3IgYWxsIEZGSERFIGdyb3Vwcy4KPiA+IAo+ID4gPiA+
IMKgaWUgd2UganVzdCBuZWVkIHRvIGNoZWNrIGlmIHRoZSByYW5kb20gbnVtYmVyIGlzIGEKPiA+
ID4gPiBzdHJpbmcgb2YgMHhmZiBjaGFyYWN0ZXJzLiBXaGljaCBoYXJkbHkgaXMgYSByYW5kb20g
bnVtYmVyIGF0IGFsbCwgc28KPiA+ID4gPiBpdCdsbCBiZSBpbXBvc3NpYmxlIHRvIGdldCB0aGlz
Lgo+ID4gPiA+IAo+ID4gPiA+IFdoaWNoIHRoZW4gd291bGQgbWVhbiB0aGF0IG91ciAneCcgaXMg
c2ltcGx5IHRoZSByYW5kb20gbnVtYmVyICsgMSwKPiA+ID4gCj4gPiA+IFRoaXMgaXMgYW4gYXJ0
aWZhY3QgZHVlIHRvIHRoZSByYW5kb20gbnVtYmVyIGJlaW5nIDAgPD0gYyA8IDJeTiAtIDEsCj4g
PiA+IHRoZXJlZm9yZSAxIG5lZWRzIHRvIGJlIGFkZGVkIHRvIG1ha2Ugc3VyZSB5b3UgbmV2ZXIg
cmV0dXJuIDAuCj4gPiA+IAo+ID4gCj4gPiBBbmQgbXkgYXJndW1lbnQgaGVyZSBpcyB0aGF0IGFs
bCB6ZXJvcyAoYW5kIGFsbCBvbmVzKSBhcmUgbm90IGEgdmFsdWUgSQo+ID4gd291bGQgZXhwZWN0
IGZyb20gb3VyIFJORy4KPiA+IAo+ID4gPiA+IHdoaWNoIGFyZ3VhYmx5IGlzIHNsaWdodGx5IHBv
aW50bGVzcyAob25lIG1vcmUgdGhhbiBhIHJhbmRvbSBudW1iZXIgaXMKPiA+ID4gPiBhcyByYW5k
b20gYXMgdGhlIG51bWJlciBpdHNlbGYpLCBzbyBJIGRvIGZlZWwganVzdGlmaWVkIHdpdGgganVz
dAo+ID4gPiA+IHJldHVybmluZyBhIHJhbmRvbSBudW1iZXIgaGVyZS4KPiA+ID4gPiAKPiA+ID4g
PiBBbSBJIHdyb25nIHdpdGggdGhhdCByZWFzb25pbmc/Cj4gPiA+IAo+ID4gPiBMb29rcyB0byBt
ZSB5b3UgYXJlIG5vdCBhY2NvdW50aW5nIGZvciB0aGUgZmFjdCB0aGF0IE4gPSA1MTIgaXMgdG9v
Cj4gPiA+IHNtYWxsIGFuZCBhIHJhbmRvbSBudW1iZXIgZmFsbGluZyBpbiB0aGUgaW50ZXJ2YWwg
KHEgLSAyKSA8IFggPCAyXk4gaXMKPiA+ID4gdW5zdWl0YWJsZT8KPiA+ID4gCj4gPiAKPiA+IE9u
bHkgaWYgKHEgLSAyKSA8IDJeTi4gQW5kIG15IHBvaW50IGlzIHRoYXQgaXQncyBub3QuCj4gPiAK
PiA+IENoZWVycywKPiA+IAo+ID4gSGFubmVzCj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
