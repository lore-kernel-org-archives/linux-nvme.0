Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0BC2D0F6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 03:06:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D63208C7
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 03:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5cDhUTv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfJjP2qJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D63208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ROypoopHrWCFbVpYk7iYswtuIZGkx2ZQSPZ35AzVz0Q=; b=t5cDhUTv+XapO0wen8R684UDu
	+e38CJN85gFVo/dphNr+VQLKORGZWecK5csaPTIO5nmiUDMepSaX3CItLpnKSiLWRYKnSl+U21XyG
	+q4kGBqmRoHYIsPCBxnChM8B0DzN0uWnO8RJdcoX1M1YBbAAkD0WKB0KVsXly6iZRURiQYVCfqIJt
	FT0mI2juVrF6JhDJF7dtu57ktchxS9kMfD6VHRcQo9adqgzs7Jxu3fywbHegrDqBb39rVmzmw8bU/
	3PQge2h++s50m/IWMg8YiKR06iQSoMh+kV/A9h0gzAKWZ3SU4sH5P4jIhEAgXXobc+Wo8g4ICmpLB
	Cuv4z3eRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHep2-0002Pw-Aa; Mon, 14 Sep 2020 03:06:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHeoz-0002PE-F2
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 03:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600052784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eBi5sSIatPEaDlkdTNdVnDuFPoGMg+QGwpj5+4NF2E=;
 b=SfJjP2qJ/MBFmj6H10cH+kf14Y9HukpAoYYxUZUpyqneZQtKNRzTmzDXUaSUQ2r8vY7408
 FrfKKVdTPvvXNMrZB4PKNJ+BF3GzIhuJ47t2eMunNavbKjGmP0HuU3r0J1SufaxglUIN2V
 y/Jsf7XVuGEikq2cjYsETYIZ24KGvlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Wi8n9ebnPRqf_yLJaxTNbg-1; Sun, 13 Sep 2020 23:05:56 -0400
X-MC-Unique: Wi8n9ebnPRqf_yLJaxTNbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74F251882FB3;
 Mon, 14 Sep 2020 03:05:54 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B6D19C4F;
 Mon, 14 Sep 2020 03:05:46 +0000 (UTC)
Date: Mon, 14 Sep 2020 11:05:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200914030542.GA342981@T590>
References: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
 <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200913_230625_524539_6D8A4E8D 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBTZXAgMTEsIDIwMjAgYXQgMDE6MTQ6MjlQTSAtMDYwMCwgSmVucyBBeGJvZSB3cm90
ZToKPiBPbiBTZXAgMTEsIDIwMjAsIGF0IDE6MTIgUE0sIFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3Jp
bWJlcmcubWU+IHdyb3RlOgo+ID4gCj4gPiDvu78KPiA+Pj4gSGkgSmVucywKPiA+Pj4gCj4gPj4+
IFRoZSAxc3QgcGF0Y2ggYWRkIC5tcV9xdWllc2NlX211dGV4IGZvciBzZXJpYWxpemluZyBxdWll
c2NlL3VucXVpZXNjZSwKPiA+Pj4gYW5kIHByZXBhcmVzIGZvciByZXBsYWNpbmcgc3JjdSB3aXRo
IHBlcmNwdV9yZWYuCj4gPj4+IAo+ID4+PiBUaGUgMm5kIHBhdGNoIHJlcGxhY2VzIHNyY3Ugd2l0
aCBwZXJjcHVfcmVmLgo+ID4+PiAKPiA+Pj4gVGhlIDNyZCBwYXRjaCBhZGRzIHRhZ3NldCBxdWll
c2NlIGludGVyZmFjZS4KPiA+Pj4gCj4gPj4+IFRoZSA0dGggcGF0Y2ggYXBwbGllcyB0YWdzZXQg
cXVpZXNjZSBpbnRlcmZhY2UgZm9yIE5WTWUgc3Vic3lzdGVtLgo+ID4+IFdoYXQgaXMgdGhpcyBz
ZXJpZXMgYWdhaW5zdD8KPiA+IAo+ID4gSXQgZGlkbid0IGFwcGx5IGNsZWFubHkgdG8gbWUgdG9v
IHVudGlsIEkgcmVhbGl6ZWQgaXQgaXMKPiA+IG9uIHRvcCBvZiB2NCBvZjogInBlcmNwdV9yZWYg
JiBibG9jazogcmVkdWNlIG1lbW9yeSBmb290cHJpbnQgb2YgcGVyY3B1X3JlZiBpbiBmYXN0IHBh
dGgiCj4gCj4gUmlnaHQsIGFuZCB0aGF04oCZcyB3aGF0IGhhcyB0aGUgbGVhayBpc3N1ZSB5b3Ug
Zm91bmQuIEnigJlsbCBob2xkIG9mZiBvbiB0aGlzIG9uZSB1bnRpbCB0aGF04oCZcyBzb3J0ZWQu
IAoKQWN0dWFsbHkgdGhpcyBwYXRjaHNldCBkb2Vzbid0IGRlcGVuZCBvbiBwYXRjaCBvZiAncGVy
Y3B1X3JlZiAmIGJsb2NrOiByZWR1Y2UgbWVtb3J5CmZvb3RwcmludCBvZiBwZXJjcHVfcmVmIGlu
IGZhc3QgcGF0aCcsIGFuZCBJIGhvbGQgdGhlbSBpbiBvbmUgYnJhbmNoLCBzbwpjYXVzZXMgdGhl
IGNvbmZsaWN0LgoKVjYgaGFzIGJlZW4gc2VudCBvdXQsIGFuZCBqdXN0IHJlYmFzZSBhZ2FpbnN0
IGZvci01LjEwL2Jsb2NrIGRpcmVjdGx5LgoKVGhhbmtzLApNaW5nCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
