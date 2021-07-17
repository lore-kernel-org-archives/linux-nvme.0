Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766AEC636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 09:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F3761380
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F3761380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MlacwaDk0im1/3CcKGgBqtPfUZ0b4/bWqFCsvb1XNr8=; b=R2avPEn9fbaSMq
	5e+7yrL/gnKOSyb4FGx+q+ancS1JdfK9RYekgsGccB3FF/6Duaqd438Zq+88k7r3mLlq7857+OgXR
	Ga/CjONaGHhPOrRPMuFQnHc1rU/yZwU9pa0tkDt3HI0piRnQdZ8WNT57mzM5EvDCVGfQeLRyVeoBK
	QSjo+JmKl45KITxNA/3Yai9gWqJ1k8kY6SdQnXI83vUl7pkExwDSrYzBw1KB+W/8m7OHD9EQzHCDT
	nf0vex3hMeKUoLkThZbL3wsV4BRaKtvp+BD8H/NmK1K3Lmvqah7YgzSQPtO50cFbzHGh77dE8kVCh
	ZUlrS5FxEskRNQjZNEgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4gji-006NDl-61; Sat, 17 Jul 2021 09:35:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4gjf-006NDJ-HC
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 09:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626514550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMfm6Ul5FP8FBIaSxrSqUf9N4MLQ8vm57kxlps+k2qU=;
 b=Ulk/UrRUg1XuRk7jQcPLN6q0hKJz+48LvyicKEdMQXKU9PApsHAUAjd7bS1VgDC0AXd9ZK
 SOBCTJPDaFUBrU9aZ7XsK7XiN6tpzwuXXNDcH1QGOw0leoBgwH7ZlARl8ycWzgcF+ASkci
 BxBKaQpSc/ZkJXvKI/4fVPFAMf/hN6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-br8uF12bMaujpXW8N-2Tmg-1; Sat, 17 Jul 2021 05:35:48 -0400
X-MC-Unique: br8uF12bMaujpXW8N-2Tmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5762A1084F53;
 Sat, 17 Jul 2021 09:35:46 +0000 (UTC)
Received: from T590 (ovpn-12-83.pek2.redhat.com [10.72.12.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C433260862;
 Sat, 17 Jul 2021 09:35:36 +0000 (UTC)
Date: Sat, 17 Jul 2021 17:35:32 +0800
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
Message-ID: <YPKkZJWsD84mmKuk@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <2455133.St5lIfLNcX@natalenko.name> <YPFicCW90Jse4oms@T590>
 <1687461.6WkTYu5mUM@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1687461.6WkTYu5mUM@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_023551_701765_14AF6C53 
X-CRM114-Status: GOOD (  18.43  )
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

T24gRnJpLCBKdWwgMTYsIDIwMjEgYXQgMDI6NTY6MjJQTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBPbiBww6F0ZWsgMTYuIMSNZXJ2ZW5jZSAyMDIxIDEyOjQxOjUyIENFU1Qg
TWluZyBMZWkgd3JvdGU6Cj4gPiA+IERvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB0aGlz
IHdpbGwgYmUgc29tZXRoaW5nIGxpa2U6Cj4gPiA+IAo+ID4gPiBGaXhlczogMjcwNWRmYjIwOSAo
ImJsb2NrOiBmaXggZGlzY2FyZCByZXF1ZXN0IG1lcmdlIikKPiA+ID4gCj4gPiA+ID8KPiA+ID4g
Cj4gPiA+IEJlY2F1c2UgYXMgdGhlIGJpc2VjdGlvbiBwcm9ncmVzc2VzLCBJJ3ZlIGJ1bXBlZCBp
bnRvIHRoaXMgY29tbWl0IG9ubHkuCj4gPiA+IFdpdGhvdXQgaXQgdGhlIGlzc3VlIGlzIG5vdCBy
ZXByb2R1Y2libGUsIGF0IGxlYXN0IHNvIGZhci4KPiA+IAo+ID4gSXQgY291bGQgYmUuCj4gPiAK
PiA+IFNvIGNhbiB5b3UganVzdCB0ZXN0IHY1LjE0LXJjMT8KPiAKPiBEb2luZyBpdCByaWdodCBu
b3csIGJ1dCBJJ3ZlIGdvdCBhbm90aGVyIGlzc3VlLiBXaHkgQkZRIGlzIG5vdCBsaXN0ZWQgaGVy
ZToKPiAKPiBgYGAKPiAvc3lzL2NsYXNzL2Jsb2NrL252bWUwbjEvcXVldWUvc2NoZWR1bGVyOltt
cS1kZWFkbGluZV0ga3liZXIgbm9uZQo+IC9zeXMvY2xhc3MvYmxvY2svbnZtZTFuMS9xdWV1ZS9z
Y2hlZHVsZXI6W21xLWRlYWRsaW5lXSBreWJlciBub25lCj4gYGBgCgpNYXliZSB5b3UgbmVlZCB0
byBjaGVjayBpZiB0aGUgYnVpbGQgaXMgT0ssIEkgY2FuJ3QgcmVwcm9kdWNlIGl0IGluIG15ClZN
LCBhbmQgQkZRIGlzIHN0aWxsIGJ1aWx0aW46Cgpbcm9vdEBrdGVzdC0wMSB+XSMgdW5hbWUgLWEK
TGludXgga3Rlc3QtMDEgNS4xNC4wLXJjMSsgIzUyIFNNUCBGcmkgSnVsIDE2IDE4OjU2OjM2IENT
VCAyMDIxIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eApbcm9vdEBrdGVzdC0wMSB+XSMg
Y2F0IC9zeXMvYmxvY2svbnZtZTBuMS9xdWV1ZS9zY2hlZHVsZXIKW25vbmVdIG1xLWRlYWRsaW5l
IGt5YmVyIGJmcQoKPiAKPiA/Cj4gCj4gSXQgaXMgYSBidWlsdC1pbiwgRldJVzoKPiAKPiBgYGAK
PiAkIG1vZGluZm8gYmZxCj4gbmFtZTogICAgICAgICAgIGJmcQo+IGZpbGVuYW1lOiAgICAgICAo
YnVpbHRpbikKPiBkZXNjcmlwdGlvbjogICAgTVEgQnVkZ2V0IEZhaXIgUXVldWVpbmcgSS9PIFNj
aGVkdWxlcgo+IGxpY2Vuc2U6ICAgICAgICBHUEwKPiBmaWxlOiAgICAgICAgICAgYmxvY2svYmZx
Cj4gYXV0aG9yOiAgICAgICAgIFBhb2xvIFZhbGVudGUKPiBhbGlhczogICAgICAgICAgYmZxLWlv
c2NoZWQKPiBgYGAKPiAKPiBTbyBmYXIgdGhlIGlzc3VlIGlzIG5vdCByZXByb2R1Y2libGUgd2l0
aCB5b3VyIHBhdGNoICsgNS4xMy4yIGFzIHdlbGwgYXMgNS4xNC0KPiByYzEgKGJ1dCBJIGRvbid0
IGhhdmUgQkZRIGVpdGhlciB3aXRoIHY1LjE0LXJjMSkuCgpZb3UgaGF2ZSB0byB2ZXJpZnkgaXQg
d2l0aCBCRlEgYXBwbGllZCwgOi0pCgoKVGhhbmtzLCAKTWluZwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
