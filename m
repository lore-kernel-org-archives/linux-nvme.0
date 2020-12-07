Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C3C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:25:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1CF2371F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1CF2371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oIXVOfmcKlvbj7XKaZ70QjMQbBHokeDFc/dLjdwIMfw=; b=eBHO5v8DuF+i/qKJeHm4NhoHp
	tvrFcdGSdxiWMdS/cKa4jg2d63GO7J4q1t96XZoqKUV+QqzfbIKawmApUXLNcfXKsPLmtg4uiSTau
	FvZZKkN+eQ2G/+eUz0UpSGyjIl+11Ykj7HTtbZYstKHigr2Bi7QLvyPshx5RUXzfmjS/ctnHV1c+u
	kRytG/ZLVVYQxnt0QXvF4Uog9rs8RD9LlA18N3n7pUlU8WtQAHyKJ6Uky65YV+ej0IyCxv1jqfdJ6
	u6l1aJB/kxAAUvNJs8vdNJVNtFlxjxRk1MCASmMO88d9r294Bba/Ey05xVhBcg621mbWslgX0EDVP
	sG+RNWQwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmIOS-0007qr-69; Mon, 07 Dec 2020 15:25:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmIOO-0007pc-QT
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 15:25:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6408667373; Mon,  7 Dec 2020 16:25:32 +0100 (CET)
Date: Mon, 7 Dec 2020 16:25:32 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201207152532.GA4527@lst.de>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_102536_984757_56B039E8 
X-CRM114-Status: GOOD (  15.68  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

R2V0dGluZyBiYWNrIHRvIHRoaXMgd2hpbGUgSSdtIHJldmlld2luZyB0aGUgbGF0ZXN0IGNvbXBl
dGluZyBwYXRjaGVzLgoKT24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgMDM6Mjc6MzVQTSArMDAwMCwg
S25pZ2h0LCBGcmVkZXJpY2sgd3JvdGU6Cj4gSGVyZSBpcyB3aGF0IEkgd291bGQgZXhwZWN0IHRv
Ogo+IEEpIGNyZWF0ZSBhIG5hbWVzcGFjZSBpbiBleGlzdGluZyBBTkEgZ3JvdXA6Cj4gCTEpIE5T
IEF0dHJpYnV0ZSBDaGFuZ2VkIEFFTiAoYmVjYXVzZSB0aGUgTlMgTGlzdCByZXR1cm5lZCBoYXMg
Y2hhbmdlZCkKPiAJMikgSG9zdCBnZXRzIHRoZSBsaXN0IC0gZGlzY292ZXJzIHRoZSBORVcgTlMK
PiAJCUluY2x1ZGluZzogRGV0ZXJtaW5lIHdoaWNoIEFOQUdSUElEIHRoYXQgTlMgYmVsb25ncyB0
byAoZm9yIHdoaWNoIHRoZSBob3N0IGFscmVhZHkga25vd3MgdGhlIHN0YXRlKS4KClllcy4KCj4g
Cj4gQikgY3JlYXRlIGEgbmFtZXNwYWNlIGluIGEgTkVXIEFOQSBncm91cAo+IAkxKSBOUyBBdHRy
aWJ1dGUgQ2hhbmdlZCBBRU4gKGJlY2F1c2UgdGhlIE5TIExpc3QgcmV0dXJuZWQgaGFzIGNoYW5n
ZWQpCj4gCTIpIEhvc3QgZ2V0cyB0aGUgbGlzdCAtIGRpc2NvdmVycyB0aGUgbmV3IE5TCj4gCQlJ
bmNsdWRpbmc6IERldGVybWluZSB0aGVyZSBpcyBhIEJSQU5EIE5FVyBBTkFHUlBJRCB0aGF0IHRo
ZSBob3N0IGtub3dzIE5PVEhJTkcgYWJvdXQuCj4gCQlTaW5jZSB0aGUgaG9zdCBrbm93cyBOT1RI
SU5HIGFib3V0IHRoYXQgQU5BR1JQSUQsIGl0IHNlZW1zIHRoZSBob3N0IHNob3VsZCBnbyBsb29r
LgoKSSBzdHJvbmdseSBkaXNhZ3JlZS4KCj4gSXQgc2VlbXMgdGhhdCB0aGUgZXhpc3RpbmcgdGV4
dCBzYXlzIHRoZXJlIGlzIE5PIEFOQSBBRU4gZm9yIGEgIm5ldyIgbmFtZXNwYWNlLiAgSm9obiBx
dW90ZWQgdGhlIHRleHQ6Cj4gCj4gQSBjb250cm9sbGVyIHNoYWxsIG5vdCBzZW5kIHRoaXMgZXZl
bnQgaWY6Cj4gYSkJdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGNyZWF0aW9uIG9mIGEgbmFtZXNw
YWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApOyBvcgo+IGIpCXRoZSBjaGFuZ2UgaXMgZHVlIHRv
IHRoZSBkZWxldGlvbiBvZiBhIG5hbWVzcGFjZSAocmVmZXIgdG8gc2VjdGlvbiA1LjIwKSwKPiBh
cyB0aGUgTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkIGV2ZW50IGlzIHNlbnQgZm9yIHRoZXNl
IGNoYW5nZXMuCgpFeGFjdGx5ISAgQnV0IG9ubHkgaWYgdGhlIGNoYW5nZSBpcyBkdWUgdGhlIGNy
ZWF0aW9uIG9yIGRlbGV0aW9uIG9mCmEgbmFtZXNwYWNlcy4gIE5vdGUgdGhlIGNyZWF0aW9uIG9m
IGJvdGggYSBuYW1lc3BhY2UgYW5kIGEgQU5BIGdyb3VwIGF0CnRoZSBzYW1lIHRpbWUuICBJbiBm
YWN0IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIGluIE5WTWUgd2hpY2ggd291bGQgYWxsb3cKZm9yIHRo
aXMgY29tcG91bmQgb3BlcmF0aW9ucy4gIFlvdSBhbHdheXMgbmVlZCB0byBjcmVhdGUgYW4gQU5B
IGdyb3VwCmZpcnN0LCBhbmQgY2FuIHRoZW4gY3JlYXRlIGEgbmFtZXNwYWNlIHVzaW5nIGl0LCBh
bmQgeW91IG5lZWQgdG8gc2VuZCB0aGUKQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIENoYW5n
ZSBBRU4gdGhhdCBhIG5ldyBBTkEgZ3JvdXAgaGFzIGJlZW4KY3JlYXRlZCwgYW5kIHRoZW4gYSBO
YW1lc3BhY2UgQXR0cmlidXRlIENoYW5nZWQgb25lLgoKCj4gQ2hyaXN0b3BoIGNsYWltcyB0aGF0
IHRoZSBBTkEgQUVOIHNob3VsZCBiZSBzZW5kIGJlZm9yZSB0aGUgTlMgQXR0cmlidXRlIENoYW5n
ZWQgQUVOLiAgQW5kLCB0aGF0IGNvdWxkIGJlIHRydWUgZm9yIGFuIEFOQUdSUElEIHRoYXQgY2hh
bmdlZCAoYWx0aG91Z2gsIEkgZG9uJ3Qgc2VlIHRleHQgZGVzY3JpYmluZyBhbnkgcHJlY2VkZW5j
ZSBvciBvcmRlciByZXF1aXJlbWVudHMgZm9yIGRlbGl2ZXJ5IG9mIEFFTnMpLCBidXQgdGhlIE5T
IGNyZWF0aW9uIGNhc2UgaXMgZXhwbGljaXRseSBleGNsdWRlZC4gIEZXSVcg4oCTIENocmlzdG9w
aCB3YXMgb25lIG9mIHRoZSBwZW9wbGUgdGhhdCByZXF1ZXN0ZWQgdGhpcyBleGNsdXNpb24gdG8g
cHJldmVudCBzcGFtaW5nIHRoZSBob3N0IHdpdGggbXVsdGlwbGUgQUVOcyBmb3IgdGhlIHNhbWUg
ZXZlbnQgKGEgTlMgY3JlYXRlKS4KClllcywgYW5kIHRoZSBleGNsdXNpb24gYXMgaXQgZXhpc3Rz
IGluIHRoZSBzcGVjIG1ha2VzIHBlcmZlY3Qgc2Vuc2UgLQp0aGUgaG9zdCBkb2VzIG5vdCBuZWVk
IHR3byBBRU4gdG8gbm90aWZ5IHRoYXQgYSBuYW1lc3BhY2UgaGFzIGJlZW4gY3JlYXRlZAphbmQg
YXMgcGFydCBvZiB0aGUgY3JlYXRpb24gd2FzIGFkZGVkIHRvIGFuIEFFTiBncm91cC4gIEJ1dCB0
aGUgaG9zdCBkb2VzCm5lZWQgYW4gQUVOIHdoZW4gYSBuZXcgZ3JvdXAgaGFzIGJlZW4gY3JlYXRl
ZCwgcGVyaW9kLiAgVGhlcmUgYWxzbyBpcyBubwpsYW5ndWFnZSB0aGF0IGFsbG93cyBza2lwcGlu
ZyB0aGF0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
