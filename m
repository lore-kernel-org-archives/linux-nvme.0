Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB912C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B23206BE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qIiROmM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B23206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GD0J2uA9JUWBgwHnTKuqIcHIppzh4FkgZ3KSZaWbYxE=; b=qIiROmM9pdz+g9
	quUcNenmJHyy8nr2wYTObIxwt2DLSAT2tw9hweNyZsiLOLEChrlH298L3Z/WjGujNvAraZVF4van+
	6GU2Hu7+ATygIRSrQG64dlzaycDUmF25PTUrFrkYe5oDyiNz/XbIJQ3XMLMTsR2Pc8ZaoDoSfx2Oi
	KxYxFMPYWpeZPhPzuz5pW45s3EWt28doDNKPgFefCgyMOPmTKUp1k3QMcknh73sYTCntEu9AGt0XW
	reyTo0zKyfkE8wRcAMLNH9+KMEKSJfJQMmwRSI1mmcHGx0qsanGFXqJ9G3+evTTCdvh8wyXkZvc6/
	UsRW+vpUdE5a8t4IX89Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSnZ-00032w-SH; Wed, 20 May 2020 17:46:33 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jbSnY-00032a-2z; Wed, 20 May 2020 17:46:32 +0000
Date: Wed, 20 May 2020 10:46:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining
 aens in nvmet_async_events_free
Message-ID: <20200520174632.GA11265@infradead.org>
References: <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
 <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
 <20200520172741.GB22182@infradead.org>
 <df8d9a64-d7ff-b249-e5f9-c3b0cf092c4c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df8d9a64-d7ff-b249-e5f9-c3b0cf092c4c@grimberg.me>
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

T24gV2VkLCBNYXkgMjAsIDIwMjAgYXQgMTA6NDE6NTZBTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPiAKPiAKPiBPbiA1LzIwLzIwIDEwOjI3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDA1OjM5OjE4QU0gLTA1MDAsIERhdmlkIE1p
bGJ1cm4gd3JvdGU6Cj4gPiA+IFlpIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgbWVtbGVhayB1
c2luZyB0aGUgdjIgb2YgdGhlIHBhdGNoIHNlcmllcwo+ID4gPiBzaW5jZSBudm1ldF9hc3luY19l
dmVudHNfZnJlZSgpIHJhbiBiZWZvcmUgbnZtZXRfYWRkX2FzeW5jX2V2ZW50KCkuCj4gPiA+IAo+
ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIw
LU1heS8wMzA1MTIuaHRtbAo+ID4gPiAKPiA+ID4gV2l0aCBTYWdpJ3MgcGF0Y2ggYmVsb3csIEkg
ZG8gc2VlIGFmdGVyIG52bWV0X2FkZF9hc3luY19ldmVudCgpLAo+ID4gPiBudm1ldF9hc3luY19l
dmVudHNfcHJvY2VzcyBwdWxscyB0aGUgcmVxdWVzdCwgZGVjcmVtZW50cwo+ID4gPiBjdHJsLT5u
cl9hc3luY19ldmVudF9jbWRzIHRvIDAsIGFuZCBmcmVlcyB0aGUgYWVuLAo+ID4gPiBhbmQgbm8g
bWVtb3J5IGxlYWsuCj4gPiA+IAo+ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBl
cm1haWwvbGludXgtbnZtZS8yMDIwLU1heS8wMzA1NDguaHRtbAo+ID4gCj4gPiBPaywgbGV0J3Mg
dHJ5IGEgdmVyc2lvbiBvZiBTYWdpcyBsYXRlc3Qgc3VnZ2VzdGlvbiB0aGVuLiAgV2hhdCBhYm91
dAo+ID4gdGhpcyAocmVwbGFjZW1lbnQgZm9yIHRoaXMgcGF0Y2ggb25seSwgSSBhcHBsaWVkIHRo
ZSBmaXJzdCBvbmUgYWxyZWFkeSk6Cj4gCj4gUGF0Y2ggIzEgaXMgbm90IG5lZWRlZCwgYnV0IHdo
ZXJlIGRpZCB5b3UgYXBwbHkgaXQ/Cgpudm1lLTUuOC4KCj4gRG8geW91IHRoaW5rIHRoZSBmaXgg
aXMgNS43LXJjIG1hdGVyaWFsPwoKQXQgdGhpcyBwb2ludCDQhiBkb24ndCB0aGluayBhIG1lbWxl
YWsgdGhhdCBoYXMgYmVlbiB0aGVyZSBzaW5jZSBkYXkgMQppcyA1LjcgbWF0ZXJpYWwuICDQhidk
IHJhdGhlciB3YWl0IGZvciA1LjggYW4gZ2V0IGEgc3RhYmxlIGJhY2twb3J0CndpdGggdGhlIHBy
b3BlciBGaXhlcyB0YWcuCgo+IFRoZSBiZWxvdyBsb29rcyBmaW5lLCBidXQgbWF5YmUgaXQgd291
bGQgYmUgZ29vZCB0byBzcGxpdCBmb3Igc21hbGwKPiBhbmQgZWFzeSBmaXggdGhhdCBjYW4gZ28g
dG8gc3RhYmxlLCBhbmQgdGhlbiBhIGJpdCBtb3JlIGNsZWFudXA/CgpXaGF0IHdvdWxkIHRoZSBz
bWFsbCBhbmQgc2ltcGxlIGZpeCBiZT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
