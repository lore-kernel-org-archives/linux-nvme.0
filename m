Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D384C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:15:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4394720671
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g31dhJ5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4394720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aUhZVX2+Gonkzu0vXIJOS2tlptRuWlu7edC8fO5CqjA=; b=g31dhJ5v2UvVFN
	SPdqdmleM8UuXlWJoTY6fCSBRcDxJcQa46QHEW2OXdU1R9pY2vxNvBxDALxXwpKdsP/djSqQn9FVJ
	Hmz/XaFoxLJLRt6iOQBw/BnZlu+hgdgQfLDDIPkowa6mge1Tx4vtlxpdRmsFDpYSMGSIyGu49GEoZ
	armaCGGtULVJlcHUYuXmZvalDoaMefVclGdKyd+mLyPPtKFRxHLDg7//OTFkVSQwcckuS3yPV3SxU
	mJivWdtdUJJgmRidpXjPNQuwlsAf3NJqHIj0dl3RLAq/URdHwdNgOJmPHDROagYz2zIPs36BEj/uZ
	bcufgXy/6Rp5NMFxfGlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbTFZ-0005jt-VU; Wed, 20 May 2020 18:15:29 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jbTFW-0005jR-H5; Wed, 20 May 2020 18:15:26 +0000
Date: Wed, 20 May 2020 11:15:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining
 aens in nvmet_async_events_free
Message-ID: <20200520181526.GA11892@infradead.org>
References: <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
 <20200520172741.GB22182@infradead.org>
 <df8d9a64-d7ff-b249-e5f9-c3b0cf092c4c@grimberg.me>
 <20200520174632.GA11265@infradead.org>
 <38af0291-4d09-d8c4-59fe-2d642ddaaaa2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38af0291-4d09-d8c4-59fe-2d642ddaaaa2@grimberg.me>
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
Cc: Christoph Hellwig <hch@infradead.org>, David Milburn <dmilburn@redhat.com>,
 chaitanya.kulkarni@wdc.com, dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBNYXkgMjAsIDIwMjAgYXQgMTE6MDQ6MjhBTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPiAKPiAKPiBPbiA1LzIwLzIwIDEwOjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDEwOjQxOjU2QU0gLTA3MDAsIFNhZ2kgR3Jp
bWJlcmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiAKPiA+ID4gT24gNS8yMC8yMCAxMDoyNyBBTSwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiA+ID4gT24gV2VkLCBNYXkgMjAsIDIwMjAgYXQgMDU6
Mzk6MThBTSAtMDUwMCwgRGF2aWQgTWlsYnVybiB3cm90ZToKPiA+ID4gPiA+IFlpIHdhcyBhYmxl
IHRvIHJlcHJvZHVjZSB0aGUgbWVtbGVhayB1c2luZyB0aGUgdjIgb2YgdGhlIHBhdGNoIHNlcmll
cwo+ID4gPiA+ID4gc2luY2UgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUoKSByYW4gYmVmb3JlIG52
bWV0X2FkZF9hc3luY19ldmVudCgpLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIwLU1heS8wMzA1MTIuaHRtbAo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBXaXRoIFNhZ2kncyBwYXRjaCBiZWxvdywgSSBkbyBzZWUgYWZ0
ZXIgbnZtZXRfYWRkX2FzeW5jX2V2ZW50KCksCj4gPiA+ID4gPiBudm1ldF9hc3luY19ldmVudHNf
cHJvY2VzcyBwdWxscyB0aGUgcmVxdWVzdCwgZGVjcmVtZW50cwo+ID4gPiA+ID4gY3RybC0+bnJf
YXN5bmNfZXZlbnRfY21kcyB0byAwLCBhbmQgZnJlZXMgdGhlIGFlbiwKPiA+ID4gPiA+IGFuZCBu
byBtZW1vcnkgbGVhay4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMC1NYXkvMDMwNTQ4Lmh0bWwKPiA+ID4gPiAK
PiA+ID4gPiBPaywgbGV0J3MgdHJ5IGEgdmVyc2lvbiBvZiBTYWdpcyBsYXRlc3Qgc3VnZ2VzdGlv
biB0aGVuLiAgV2hhdCBhYm91dAo+ID4gPiA+IHRoaXMgKHJlcGxhY2VtZW50IGZvciB0aGlzIHBh
dGNoIG9ubHksIEkgYXBwbGllZCB0aGUgZmlyc3Qgb25lIGFscmVhZHkpOgo+ID4gPiAKPiA+ID4g
UGF0Y2ggIzEgaXMgbm90IG5lZWRlZCwgYnV0IHdoZXJlIGRpZCB5b3UgYXBwbHkgaXQ/Cj4gPiAK
PiA+IG52bWUtNS44Lgo+ID4gCj4gPiA+IERvIHlvdSB0aGluayB0aGUgZml4IGlzIDUuNy1yYyBt
YXRlcmlhbD8KPiA+IAo+ID4gQXQgdGhpcyBwb2ludCDQhiBkb24ndCB0aGluayBhIG1lbWxlYWsg
dGhhdCBoYXMgYmVlbiB0aGVyZSBzaW5jZSBkYXkgMQo+ID4gaXMgNS43IG1hdGVyaWFsLiAg0IYn
ZCByYXRoZXIgd2FpdCBmb3IgNS44IGFuIGdldCBhIHN0YWJsZSBiYWNrcG9ydAo+ID4gd2l0aCB0
aGUgcHJvcGVyIEZpeGVzIHRhZy4KPiAKPiBNYWtlcyBzZW5zZS4KPiAKPiA+ID4gVGhlIGJlbG93
IGxvb2tzIGZpbmUsIGJ1dCBtYXliZSBpdCB3b3VsZCBiZSBnb29kIHRvIHNwbGl0IGZvciBzbWFs
bAo+ID4gPiBhbmQgZWFzeSBmaXggdGhhdCBjYW4gZ28gdG8gc3RhYmxlLCBhbmQgdGhlbiBhIGJp
dCBtb3JlIGNsZWFudXA/Cj4gPiAKPiA+IFdoYXQgd291bGQgdGhlIHNtYWxsIGFuZCBzaW1wbGUg
Zml4IGJlPwo+IAo+IEp1c3QgdGhlIGZpeCByZWxhdGVkIHBhcnQuIFRoZW4gaGF2ZSBhIHNtYWxs
IGNsZWFudXAgaW5jcmVtZW50YWxseS4KPiBtb3ZlIHRoZSBudm1ldF9hc3luY19ldmVudHNfZnJl
ZSB0byBudm1ldF9jdHJsX2ZyZWUgYW5kIG1ha2UgaXQKPiBqdXN0IGZyZWUgdGhlIGFlbnMuCgpP
ay4gIERvIHlvdSB3YW50IHRvIHNlbmQgYSBwcm9wZXIgcGF0Y2g/CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
