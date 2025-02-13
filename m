Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9B8C021A0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=; b=cHNsOmoYGEgVtHMDC8714hLQ7Y
	txv3lohAwh4sgYF4xRwI47CAthjoVkocP21Pq/4mdiNc06SMnHScgdBGAAt8sh4bV2tKKd5RYbsZq
	Q+lD4I0HJ+a+3cNETGMh98KGFJhQwoNFUUbBczdae6/+I7yUpj0ikHGlP1WdCmrxDcOFN234DoQCX
	jwX2ZdacULc+wcVNo5VeZYIrPUFC12YqGkYV/yt87x5ov47vNjAVJ+hN0CYVkIJD8aLbA4U/Mjobk
	07hll41OjP7MyPdtjb8nm7Jh7uAEo8HEiD+x0o615ZEjC7QXA9ak3ML4seSIHVXl9A6amCokfkI8N
	iz0h8FLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiaIl-0000000BLqC-2dFu;
	Thu, 13 Feb 2025 14:34:51 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiZxX-0000000BHBv-3feU
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 14:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1739455973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A4/k8Kc95K05s8Lir9RWavqF2gsPpctAHAuiizBdxsFC+57yq1aWjqzhbSEL21eO+O1SkQwKredjO5gegRItaZL3CEctSo4hkNpApf1pWAD1aSYjHD8rEW1NITtYvQCNAyoG0p9nE/tRM7RQHxvHLD7kGUnPGGDwyC6F1m/gHvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739455973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=; 
	b=f46mJmmbWufwl2kWIjpXeEhCLFZ0YELBee29a9E0xxBvZKXYJvKXEytALSxX4fyuJeYe3u8DJ1yPUWOxHpyk5NP8/458k2HSM+WdOZmSyYiVp3L1RRkRAYvq5T7Kb6DxSBjCQcdIcHclKdJOkWfqnGmHR57Y7NIwLbyLvJSkobc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739455973;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=;
	b=KFfPd+YhDtKA5z2PZwJ4wZtTwU4dC5SF5iTC50HvCN4E3EZg/Jx2mRnWP8nW9sCt
	2CpR6RAmZixRUzUNU10rVFiczVyOgjv9Ox+WldMV71dml8sQGLGOAq/x8DIsjH+yS5H
	uSkPQdncXDKs6ST8kI7F3RdvjrfnbKJFR6QK+7Xcc/WCnsCAcPLdAbYOap0q812nlIY
	1+5+bUzpTMhqSkVaKLNCgM2QuO2BaBQ/CZAh6SLPifYmkZXOupwUSwsoOZaqz2sHPyq
	mxF1BpZi8c9TI5BPDrxmeU4dS4Q4FM0tXsi0y0kULrK6tbAjHvvmj5QybEaxu/gQ00D
	Q3nIPKzd4Q==
Received: by mx.zohomail.com with SMTPS id 1739455971954542.0288903467681;
	Thu, 13 Feb 2025 06:12:51 -0800 (PST)
Message-ID: <632b7f807d51d8d6f2eef075e60b756e1e0c78f4.camel@icenowy.me>
Subject: Re: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI P2P
 DMA
From: Icenowy Zheng <uwu@icenowy.me>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 22:12:45 +0800
In-Reply-To: <20250213055825.GD19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250212170444.16138-3-uwu@icenowy.me> <20250213055825.GD19370@lst.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_061255_982726_A4753DD5 
X-CRM114-Status: GOOD (  14.20  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

5ZyoIDIwMjUtMDItMTPmmJ/mnJ/lm5vnmoQgMDY6NTggKzAxMDDvvIxDaHJpc3RvcGggSGVsbHdp
Z+WGmemBk++8mgo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDAxOjA0OjQ0QU0gKzA4MDAsIElj
ZW5vd3kgWmhlbmcgd3JvdGU6Cj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKgwqDC
oMKgICogQ29udHJvbGxlcnMgbWF5IHN1cHBvcnQgYSBDTUIgc2l6ZSBsYXJnZXIgdGhhbiB0aGVp
cgo+ID4gQkFSLAo+ID4gK8KgwqDCoMKgwqDCoMKgICogZm9yIGV4YW1wbGUsIGR1ZSB0byBiZWlu
ZyBiZWhpbmQgYSBicmlkZ2UuIFJlZHVjZSB0aGUKPiA+IENNQiB0bwo+ID4gK8KgwqDCoMKgwqDC
oMKgICogdGhlIHJlcG9ydGVkIHNpemUgb2YgdGhlIEJBUgo+ID4gK8KgwqDCoMKgwqDCoMKgICov
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoc2l6ZSA+IGJhcl9zaXplIC0gb2Zmc2V0KQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSBiYXJfc2l6ZSAtIG9mZnNldDsKPiAK
PiBOaXQ6IHVzZSB1cCB0aGUgZnVsbCA4MCBjaGFyYWN0ZXJzIGZvciB0aGUgY29tbWVudCwgYW5k
IG1heWJlIHN3aXRjaAo+IHRoZSBhYm92ZSBleHByZXNzaW9uIHRvIHVzZSB0aGUgbWluKCkgaGVs
cGVyLgoKSSBhbSBvbmx5IG1vdmluZyBhcm91bmQgZXhpc3RpbmcgY29kZSBoZXJlLgoKTWF5YmUg
SSBzaG91bGQgcmVmYWN0b3IgdGhlIGNvZGUgaGVyZSBhbmQgdGhlbiBtb3ZlIGl0PwoKPiAKPiA+
ICvCoMKgwqDCoMKgwqDCoGlmICghSVNfQUxJR05FRChzaXplLCBtZW1yZW1hcF9jb21wYXRfYWxp
Z24oKSkgfHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAhSVNfQUxJR05FRChwY2lfcmVzb3Vy
Y2Vfc3RhcnQocGRldiwgYmFyKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWVtcmVtYXBfY29tcGF0X2FsaWduKCkpKQo+IAo+IFRoZXNlIGNvbXBh
dCBuYW1lcyBsb29rZWQgb2RkIHRvIG1lLCBidXQgaXQgbG9va3MgbGlrZSB0aGV5IGFyZQo+IGlu
ZGVlZAo+IHRoZSBwcm9wZXIgaW50ZXJmYWNlIGhlcmUuwqAgU28gbW9kdWxvIHRoZSBsaXR0bGUg
c3R5bGUgdGhpbmdzIGFib3ZlCj4gdGhpcyBsb29rcyBnb29kLCB0aGFua3MgYSBsb3QhCj4gCgo=


