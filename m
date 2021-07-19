Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96212C636C8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 01:41:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A21D61166
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 01:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21D61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CQcvVj9ZRSq6tJTFZNd5HgD3MoYH8uvfkpU7lc0zlkc=; b=SDVrHP7ZPby9yZ
	it0RBmq+oxCtQPLuqtOVZ2d7aKdpuHoXW6nFcL7iy0oooPdWyf0iKSpG1eDZCkxZpTA17vRdNGXvx
	qW+57HYRoieFtsvd7DKES88hKAUy/+SsG1UbJftK4lyrKlTQQ7AmkBUyHAPJuSatSioAnO5OXffi6
	4FOX/KFWve842n2qFsRzcZW2KaPDlaJnzCbWtRoXXKtlLKaoTP44JNAZ+Y/H2AEYlhu8aHwygwKvC
	DLI9/++IF+10zpPsIEfX86yKw0ulsSY4r/K3TxndzbrOQQxbEeRKsDxk00JfW59Be0HgxYWQfgyiY
	vg1uWDe56DB6duP0qxtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5IHN-008FhB-Jg; Mon, 19 Jul 2021 01:41:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5IHK-008Fga-1v
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 01:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626658861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEqAVMebt8KkaRBeojxifkyre8q09DDKsrxdRcTSaRM=;
 b=PcJ6FVT8i17KyyQG4S8TRJIWMq3LLoW6Xh5/WCtZPozKehrCBcyp3NNl+YSZiYjFFtIPj3
 S0RBDbIumWx3J9Yny9Kn5wf9ffKFaROmItf5IdPRXaFbpb8g0rroh587BI5/gWEu8I2+h7
 JETqHMADRJ25ua5k5ntjTW9zh1aYf2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-zjI_g7yqO8CK3PNlvtZDIw-1; Sun, 18 Jul 2021 21:41:00 -0400
X-MC-Unique: zjI_g7yqO8CK3PNlvtZDIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43EB9802C80;
 Mon, 19 Jul 2021 01:40:58 +0000 (UTC)
Received: from T590 (ovpn-13-11.pek2.redhat.com [10.72.13.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF5A27068;
 Mon, 19 Jul 2021 01:40:45 +0000 (UTC)
Date: Mon, 19 Jul 2021 09:40:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPTYGD1zeae1x7Yp@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <5053297.vgnLoh5Ws3@natalenko.name>
 <8988303.mDXGIdCtx8@natalenko.name>
 <3383530.3bVf3B8HMu@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3383530.3bVf3B8HMu@natalenko.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_184106_219579_AB3A999F 
X-CRM114-Status: GOOD (  21.11  )
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

T24gU2F0LCBKdWwgMTcsIDIwMjEgYXQgMDI6MzU6MTRQTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBPbiBzb2JvdGEgMTcuIMSNZXJ2ZW5jZSAyMDIxIDE0OjE5OjU5IENFU1Qg
T2xla3NhbmRyIE5hdGFsZW5rbyB3cm90ZToKPiA+IE9uIHNvYm90YSAxNy4gxI1lcnZlbmNlIDIw
MjEgMTQ6MTE6MDUgQ0VTVCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOgo+ID4gPiBPbiBzb2Jv
dGEgMTcuIMSNZXJ2ZW5jZSAyMDIxIDExOjM1OjMyIENFU1QgTWluZyBMZWkgd3JvdGU6Cj4gPiA+
ID4gTWF5YmUgeW91IG5lZWQgdG8gY2hlY2sgaWYgdGhlIGJ1aWxkIGlzIE9LLCBJIGNhbid0IHJl
cHJvZHVjZSBpdCBpbiBteQo+ID4gPiA+IFZNLCBhbmQgQkZRIGlzIHN0aWxsIGJ1aWx0aW46Cj4g
PiA+ID4gCj4gPiA+ID4gW3Jvb3RAa3Rlc3QtMDEgfl0jIHVuYW1lIC1hCj4gPiA+ID4gTGludXgg
a3Rlc3QtMDEgNS4xNC4wLXJjMSsgIzUyIFNNUCBGcmkgSnVsIDE2IDE4OjU2OjM2IENTVCAyMDIx
IHg4Nl82NAo+ID4gPiA+IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4IFtyb290QGt0ZXN0LTAxIH5d
IyBjYXQKPiA+ID4gPiAvc3lzL2Jsb2NrL252bWUwbjEvcXVldWUvc2NoZWR1bGVyCj4gPiA+ID4g
W25vbmVdIG1xLWRlYWRsaW5lIGt5YmVyIGJmcQo+ID4gPiAKPiA+ID4gSSBkb24ndCB0aGluayB0
aGlzIGlzIGFuIGlzc3VlIHdpdGggdGhlIGJ1aWxk4oCmIEJUVywgd2l0aCBgaW5pdGNhbGxfZGVi
dWdgOgo+ID4gPiAKPiA+ID4gYGBgCj4gPiA+IFsgICAgMC45MDI1NTVdIGNhbGxpbmcgIGJmcV9p
bml0KzB4MC8weDhiIEAgMQo+ID4gPiBbICAgIDAuOTAzNDQ4XSBpbml0Y2FsbCBiZnFfaW5pdCsw
eDAvMHg4YiByZXR1cm5lZCAtMjggYWZ0ZXIgNTA3IHVzZWNzCj4gPiA+IGBgYAo+ID4gPiAKPiA+
ID4gLUVOT1NQQz8gV2h5PyBBbHNvIHJlLXRlc3RlZCB3aXRoIHRoZSBsYXRlc3QgZ2l0IHRpcCwg
c2FtZSByZXN1bHQgOiguCj4gPiAKPiA+IE9LLCBvbmUgZXh0cmEgcHJfaW5mbywgYW5kIEkgc2Vl
IHRoaXM6Cj4gPiAKPiA+IGBgYAo+ID4gWyAgICAwLjg3MTE4MF0gYmxrY2dfcG9saWN5X3JlZ2lz
dGVyOiBCTEtDR19NQVhfUE9MUyB0b28gc21hbGwKPiA+IFsgICAgMC44NzE2MTJdIGJsa2NnX3Bv
bGljeV9yZWdpc3RlcjogLTI4Cj4gPiBgYGAKPiA+IAo+ID4gV2hhdCBkb2VzIGl0IG1lYW4gcGxl
YXNlIDopPyBUaGUgdmFsdWUgc2VlbXMgdG8gYmUgaGFyZC1jb2RlZDoKPiA+IAo+ID4gYGBgCj4g
PiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCj4gPiA2MDojZGVmaW5lIEJMS0NHX01BWF9QT0xTICAg
ICAgICAgICAgICAgNQo+ID4gYGBgCj4gCj4gT0ssIGFmdGVyIGluY3JlYXNpbmcgdGhpcyB0byA2
IEkndmUgZ290IG15IEJGUSBiYWNrLiBQbGVhc2Ugc2VlIFsxXS4KPiAKPiBbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMTA3MTcxMjMzMjguOTQ1ODEwLTEtb2xla3Nh
bmRyQG5hdGFsZW5rby5uYW1lLwoKT0ssIGFmdGVyIHlvdSBmaXhlZCB0aGUgaXNzdWUgaW4gYmxr
Y2dfcG9saWN5X3JlZ2lzdGVyKCksIGNhbiB5b3UKcmVwcm9kdWNlIHRoZSBkaXNjYXJkIGlzc3Vl
IG9uIHY1LjE0LXJjMSB3aXRoIEJGUSBhcHBsaWVkPyBJZiB5ZXMsCmNhbiB5b3UgdGVzdCB0aGUg
cGF0Y2ggSSBwb3N0ZWQgcHJldmlvdXNseT8KCgpUaGFua3MsCk1pbmcKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
