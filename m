Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99E0C12002
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 06:28:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430A961073
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 06:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430A961073
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9pIJDV+S5sBefwiGu0EtMWM446ILQDa6fINBxiz2cQE=; b=Bx7rUGzg+pPCVX
	F23cpybg6ul/xCMsGpECBz/1uqBQNB5RuSIM+ShQqBDo3pQm+mjDMyZr8ENcXmSt2J5J8Hy8pS7CF
	LAO+688+muapYzvHz+XTgkiypTE+5FGxNfsMdp59RixQn3ML9HRmLVVvBlo4fvSRN/ztyrQUZ+tZp
	wVEUff+OUuxNDnJHmEZA8aeDIg+jZXrb0qCXadgRELrgKSlnk7h3zQW5lPq/smbRI4X+tauuoScLS
	2eRz2buB7yqt48SftDGX9HXU2DplvpX0tlmWRkLCUqK+pLyXHJqFp+Kz3ZM6zzT1n5Te/I3qU1/j+
	I/mJqsvi8/q8jvc+ZACQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Mkh-008TkE-3S; Mon, 19 Jul 2021 06:27:43 +0000
Received: from vulcan.natalenko.name ([2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m5Mkc-008Tjh-Rh
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 06:27:40 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id A7605B3EB05;
 Mon, 19 Jul 2021 08:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626676052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0v0oBiJSSwI4t8kOgBANJD3E8AfEItyUoFNrqOwtw/k=;
 b=CoUK7msWh4ZR8H9c9RULRkAEDiRFhiKF79kXZfsJXWHsy4xyGPj7euxv1SxESTXSurfVJ2
 9yzwjpzRuR8K5KLYrgj9tpr0+Hdy71qL4lz3gjGV/b5I7zWpZsgIAMwfyiBZt4xIqcsJL8
 il/H9M4DRQvsbu6jP2oHzKYsypN1nyI=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Mon, 19 Jul 2021 08:27:29 +0200
Message-ID: <2407736.Le3fEKZpXq@natalenko.name>
In-Reply-To: <YPTYGD1zeae1x7Yp@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <3383530.3bVf3B8HMu@natalenko.name> <YPTYGD1zeae1x7Yp@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_232739_222701_A9EABCF3 
X-CRM114-Status: GOOD (  22.07  )
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

SGVsbG8uCgpPbiBwb25kxJtsw60gMTkuIMSNZXJ2ZW5jZSAyMDIxIDM6NDA6NDAgQ0VTVCBNaW5n
IExlaSB3cm90ZToKPiBPbiBTYXQsIEp1bCAxNywgMjAyMSBhdCAwMjozNToxNFBNICswMjAwLCBP
bGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOgo+ID4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAy
MSAxNDoxOTo1OSBDRVNUIE9sZWtzYW5kciBOYXRhbGVua28gd3JvdGU6Cj4gPiA+IE9uIHNvYm90
YSAxNy4gxI1lcnZlbmNlIDIwMjEgMTQ6MTE6MDUgQ0VTVCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdy
b3RlOgo+ID4gPiA+IE9uIHNvYm90YSAxNy4gxI1lcnZlbmNlIDIwMjEgMTE6MzU6MzIgQ0VTVCBN
aW5nIExlaSB3cm90ZToKPiA+ID4gPiA+IE1heWJlIHlvdSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBi
dWlsZCBpcyBPSywgSSBjYW4ndCByZXByb2R1Y2UgaXQgaW4KPiA+ID4gPiA+IG15Cj4gPiA+ID4g
PiBWTSwgYW5kIEJGUSBpcyBzdGlsbCBidWlsdGluOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBbcm9v
dEBrdGVzdC0wMSB+XSMgdW5hbWUgLWEKPiA+ID4gPiA+IExpbnV4IGt0ZXN0LTAxIDUuMTQuMC1y
YzErICM1MiBTTVAgRnJpIEp1bCAxNiAxODo1NjozNiBDU1QgMjAyMQo+ID4gPiA+ID4geDg2XzY0
Cj4gPiA+ID4gPiB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eCBbcm9vdEBrdGVzdC0wMSB+XSMgY2F0
Cj4gPiA+ID4gPiAvc3lzL2Jsb2NrL252bWUwbjEvcXVldWUvc2NoZWR1bGVyCj4gPiA+ID4gPiBb
bm9uZV0gbXEtZGVhZGxpbmUga3liZXIgYmZxCj4gPiA+ID4gCj4gPiA+ID4gSSBkb24ndCB0aGlu
ayB0aGlzIGlzIGFuIGlzc3VlIHdpdGggdGhlIGJ1aWxk4oCmIEJUVywgd2l0aAo+ID4gPiA+IGBp
bml0Y2FsbF9kZWJ1Z2A6Cj4gPiA+ID4gCj4gPiA+ID4gYGBgCj4gPiA+ID4gWyAgICAwLjkwMjU1
NV0gY2FsbGluZyAgYmZxX2luaXQrMHgwLzB4OGIgQCAxCj4gPiA+ID4gWyAgICAwLjkwMzQ0OF0g
aW5pdGNhbGwgYmZxX2luaXQrMHgwLzB4OGIgcmV0dXJuZWQgLTI4IGFmdGVyIDUwNyB1c2Vjcwo+
ID4gPiA+IGBgYAo+ID4gPiA+IAo+ID4gPiA+IC1FTk9TUEM/IFdoeT8gQWxzbyByZS10ZXN0ZWQg
d2l0aCB0aGUgbGF0ZXN0IGdpdCB0aXAsIHNhbWUgcmVzdWx0IDooLgo+ID4gPiAKPiA+ID4gT0ss
IG9uZSBleHRyYSBwcl9pbmZvLCBhbmQgSSBzZWUgdGhpczoKPiA+ID4gCj4gPiA+IGBgYAo+ID4g
PiBbICAgIDAuODcxMTgwXSBibGtjZ19wb2xpY3lfcmVnaXN0ZXI6IEJMS0NHX01BWF9QT0xTIHRv
byBzbWFsbAo+ID4gPiBbICAgIDAuODcxNjEyXSBibGtjZ19wb2xpY3lfcmVnaXN0ZXI6IC0yOAo+
ID4gPiBgYGAKPiA+ID4gCj4gPiA+IFdoYXQgZG9lcyBpdCBtZWFuIHBsZWFzZSA6KT8gVGhlIHZh
bHVlIHNlZW1zIHRvIGJlIGhhcmQtY29kZWQ6Cj4gPiA+IAo+ID4gPiBgYGAKPiA+ID4gaW5jbHVk
ZS9saW51eC9ibGtkZXYuaAo+ID4gPiA2MDojZGVmaW5lIEJMS0NHX01BWF9QT0xTICAgICAgICAg
ICAgICAgNQo+ID4gPiBgYGAKPiA+IAo+ID4gT0ssIGFmdGVyIGluY3JlYXNpbmcgdGhpcyB0byA2
IEkndmUgZ290IG15IEJGUSBiYWNrLiBQbGVhc2Ugc2VlIFsxXS4KPiA+IAo+ID4gWzFdCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDIxMDcxNzEyMzMyOC45NDU4MTAt
MS1vbGVrc2FuZHJAbmF0Cj4gPiBhbGVua28ubmFtZS8KPiBPSywgYWZ0ZXIgeW91IGZpeGVkIHRo
ZSBpc3N1ZSBpbiBibGtjZ19wb2xpY3lfcmVnaXN0ZXIoKSwgY2FuIHlvdQo+IHJlcHJvZHVjZSB0
aGUgZGlzY2FyZCBpc3N1ZSBvbiB2NS4xNC1yYzEgd2l0aCBCRlEgYXBwbGllZD8gSWYgeWVzLAo+
IGNhbiB5b3UgdGVzdCB0aGUgcGF0Y2ggSSBwb3N0ZWQgcHJldmlvdXNseT8KClllcywgdGhlIGlz
c3VlIGlzIHJlcHJvZHVjaWJsZSB3aXRoIGJvdGggdjUuMTMuMiBhbmQgdjUuMTQtcmMxLiBJIGhh
dmVuJ3QgCm1hbmFnZWQgdG8gcmVwcm9kdWNlIGl0IHdpdGggdjUuMTMuMit5b3VyIHBhdGNoLiBO
b3cgSSB3aWxsIGJ1aWxkIHY1LjE0LQpyYzIreW91ciBwYXRjaCBhbmQgdGVzdCBmdXJ0aGVyLgoK
VGhhbmtzLgoKLS0gCk9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
