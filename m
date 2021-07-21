Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA12C07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 08:01:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAE860FDB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 08:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAE860FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K1nv1/AbMrQr2frXzW+5O4RYE6+c3ZfKIJZgaScUgB8=; b=tjrrZYEnmUAP5P
	Ch/CevgF0TQ3Cb6Qbt3anrCr7Y5nDliol2DG8XIoRVWbz4JPMydVTLmLka1Ifl7oSAQzK3N96y/aB
	aejMUvpjyAmGlEPM/KyzvT659zBB/JnzM/MefDj0fewjTNqAj+w/pEEv/MkKkY5vOcZYCADiP4WEi
	KvZOI+vztAKwRfqqpkcR/+frue5I8XQbTydCqFa7953Nsmqb8weAIrz1JT79/mmn5Snedjy4/PdK0
	bl44jBBPs3Dwfb4bWn5BWmFmCwOZg4pG+sUhUpmTXGmNns1Lao0a4YrgocmUS4Ln/Na3iJ6hfFOf3
	oUmeQZ1vjFNG0F+TnMLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m67AQ-00EoLa-2k; Wed, 21 Jul 2021 08:01:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m67AM-00EoKS-Ll
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 08:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626854476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvuH6VK1mrxNm7ZXgEI2iox9G8vBz5MBjI5rE3+lsWo=;
 b=guV6+dR1aPhbnaQhEspFR54ZMPlnUA9Lahr1Z+F0VTgqk0ru0Z+HXGjEuPTaHudrQnQixc
 fB0ZOpmu3xLWzQTiBYdFvqZDL3sfbn5IU4ZMlkXtcq4SmaC1Wh+W5gs0V0ONgZvJcIsYqB
 G/Qqj1bgxdgZMYAAmIcG5AaHoDTQL3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-XlB02AQLNpOoQh2qJXUYCg-1; Wed, 21 Jul 2021 04:01:15 -0400
X-MC-Unique: XlB02AQLNpOoQh2qJXUYCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FD671005D5C;
 Wed, 21 Jul 2021 08:01:13 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C532D19C79;
 Wed, 21 Jul 2021 08:01:01 +0000 (UTC)
Date: Wed, 21 Jul 2021 16:00:56 +0800
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
Message-ID: <YPfUOKrxGs6FjaOZ@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPTYGD1zeae1x7Yp@T590>
 <2407736.Le3fEKZpXq@natalenko.name>
 <2356877.Yf5hrMSTGe@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2356877.Yf5hrMSTGe@natalenko.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_010118_841407_D01D125E 
X-CRM114-Status: GOOD (  31.51  )
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

T24gVHVlLCBKdWwgMjAsIDIwMjEgYXQgMTE6MDU6MjlBTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBIZWxsbywgTWluZy4KPiAKPiBPbiBwb25kxJtsw60gMTkuIMSNZXJ2ZW5j
ZSAyMDIxIDg6Mjc6MjkgQ0VTVCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOgo+ID4gT24gcG9u
ZMSbbMOtIDE5LiDEjWVydmVuY2UgMjAyMSAzOjQwOjQwIENFU1QgTWluZyBMZWkgd3JvdGU6Cj4g
PiA+IE9uIFNhdCwgSnVsIDE3LCAyMDIxIGF0IDAyOjM1OjE0UE0gKzAyMDAsIE9sZWtzYW5kciBO
YXRhbGVua28gd3JvdGU6Cj4gPiA+ID4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDox
OTo1OSBDRVNUIE9sZWtzYW5kciBOYXRhbGVua28gd3JvdGU6Cj4gPiA+ID4gPiBPbiBzb2JvdGEg
MTcuIMSNZXJ2ZW5jZSAyMDIxIDE0OjExOjA1IENFU1QgT2xla3NhbmRyIE5hdGFsZW5rbyB3cm90
ZToKPiA+ID4gPiA+ID4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxMTozNTozMiBDRVNU
IE1pbmcgTGVpIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE1heWJlIHlvdSBuZWVkIHRvIGNoZWNrIGlm
IHRoZSBidWlsZCBpcyBPSywgSSBjYW4ndCByZXByb2R1Y2UgaXQKPiA+ID4gPiA+ID4gPiBpbgo+
ID4gPiA+ID4gPiA+IG15Cj4gPiA+ID4gPiA+ID4gVk0sIGFuZCBCRlEgaXMgc3RpbGwgYnVpbHRp
bjoKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBbcm9vdEBrdGVzdC0wMSB+XSMgdW5hbWUg
LWEKPiA+ID4gPiA+ID4gPiBMaW51eCBrdGVzdC0wMSA1LjE0LjAtcmMxKyAjNTIgU01QIEZyaSBK
dWwgMTYgMTg6NTY6MzYgQ1NUIDIwMjEKPiA+ID4gPiA+ID4gPiB4ODZfNjQKPiA+ID4gPiA+ID4g
PiB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eCBbcm9vdEBrdGVzdC0wMSB+XSMgY2F0Cj4gPiA+ID4g
PiA+ID4gL3N5cy9ibG9jay9udm1lMG4xL3F1ZXVlL3NjaGVkdWxlcgo+ID4gPiA+ID4gPiA+IFtu
b25lXSBtcS1kZWFkbGluZSBreWJlciBiZnEKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEkgZG9u
J3QgdGhpbmsgdGhpcyBpcyBhbiBpc3N1ZSB3aXRoIHRoZSBidWlsZOKApiBCVFcsIHdpdGgKPiA+
ID4gPiA+ID4gYGluaXRjYWxsX2RlYnVnYDoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGBgYAo+
ID4gPiA+ID4gPiBbICAgIDAuOTAyNTU1XSBjYWxsaW5nICBiZnFfaW5pdCsweDAvMHg4YiBAIDEK
PiA+ID4gPiA+ID4gWyAgICAwLjkwMzQ0OF0gaW5pdGNhbGwgYmZxX2luaXQrMHgwLzB4OGIgcmV0
dXJuZWQgLTI4IGFmdGVyIDUwNwo+ID4gPiA+ID4gPiB1c2Vjcwo+ID4gPiA+ID4gPiBgYGAKPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+IC1FTk9TUEM/IFdoeT8gQWxzbyByZS10ZXN0ZWQgd2l0aCB0
aGUgbGF0ZXN0IGdpdCB0aXAsIHNhbWUgcmVzdWx0Cj4gPiA+ID4gPiA+IDooLgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBPSywgb25lIGV4dHJhIHByX2luZm8sIGFuZCBJIHNlZSB0aGlzOgo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBgYGAKPiA+ID4gPiA+IFsgICAgMC44NzExODBdIGJsa2NnX3BvbGljeV9y
ZWdpc3RlcjogQkxLQ0dfTUFYX1BPTFMgdG9vIHNtYWxsCj4gPiA+ID4gPiBbICAgIDAuODcxNjEy
XSBibGtjZ19wb2xpY3lfcmVnaXN0ZXI6IC0yOAo+ID4gPiA+ID4gYGBgCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IFdoYXQgZG9lcyBpdCBtZWFuIHBsZWFzZSA6KT8gVGhlIHZhbHVlIHNlZW1zIHRvIGJl
IGhhcmQtY29kZWQ6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGBgYAo+ID4gPiA+ID4gaW5jbHVkZS9s
aW51eC9ibGtkZXYuaAo+ID4gPiA+ID4gNjA6I2RlZmluZSBCTEtDR19NQVhfUE9MUyAgICAgICAg
ICAgICAgIDUKPiA+ID4gPiA+IGBgYAo+ID4gPiA+IAo+ID4gPiA+IE9LLCBhZnRlciBpbmNyZWFz
aW5nIHRoaXMgdG8gNiBJJ3ZlIGdvdCBteSBCRlEgYmFjay4gUGxlYXNlIHNlZSBbMV0uCj4gPiA+
ID4gCj4gPiA+ID4gWzFdCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxv
Y2svMjAyMTA3MTcxMjMzMjguOTQ1ODEwLTEtb2xla3NhbmRyQG5hCj4gPiA+ID4gdAo+ID4gPiA+
IGFsZW5rby5uYW1lLwo+ID4gPiAKPiA+ID4gT0ssIGFmdGVyIHlvdSBmaXhlZCB0aGUgaXNzdWUg
aW4gYmxrY2dfcG9saWN5X3JlZ2lzdGVyKCksIGNhbiB5b3UKPiA+ID4gcmVwcm9kdWNlIHRoZSBk
aXNjYXJkIGlzc3VlIG9uIHY1LjE0LXJjMSB3aXRoIEJGUSBhcHBsaWVkPyBJZiB5ZXMsCj4gPiA+
IGNhbiB5b3UgdGVzdCB0aGUgcGF0Y2ggSSBwb3N0ZWQgcHJldmlvdXNseT8KPiA+IAo+ID4gWWVz
LCB0aGUgaXNzdWUgaXMgcmVwcm9kdWNpYmxlIHdpdGggYm90aCB2NS4xMy4yIGFuZCB2NS4xNC1y
YzEuIEkgaGF2ZW4ndAo+ID4gbWFuYWdlZCB0byByZXByb2R1Y2UgaXQgd2l0aCB2NS4xMy4yK3lv
dXIgcGF0Y2guIE5vdyBJIHdpbGwgYnVpbGQgdjUuMTQtCj4gPiByYzIreW91ciBwYXRjaCBhbmQg
dGVzdCBmdXJ0aGVyLgo+IAo+IEknbSBzdGlsbCBoYW1tZXJpbmcgdjUuMTQtcmMyICsgeW91ciBw
YXRjaCwgYW5kIEkgY2Fubm90IHJlcHJvZHVjZSB0aGUgaXNzdWUuIAo+IEdpdmVuIEkgZG8gbm90
IGhhdmUgYSByZWxpYWJsZSByZXByb2R1Y2VyIChJJ20ganVzdCBmaXJpbmcgdXAgdGhlIGtlcm5l
bCBidWlsZCwgCj4gYW5kIHRoZSBpc3N1ZSBwb3BzIHVwIGV2ZW50dWFsbHksIHNvb25lciBvciBs
YXRlciwgYnV0IHVzdWFsbHkgd2l0aGluIGEgY291cGxlIAo+IG9mIGZpcnN0IHRyaWVzKSwgZm9y
IGhvdyBsb25nIEkgc2hvdWxkIGhhbW1lciBpdCBmb3IgeW91ciBmaXggdG8gYmUgY29uc2lkZXJl
ZCAKPiBwcm92ZW4/CgpZb3UgbWVudGlvbmVkIHRoYXQgdGhlIGlzc3VlIGlzIHJlcHJvZHVjaWJs
ZSB3aXRoIHY1LjE0LXJjLCB0aGF0IG1lYW5zCml0IGNhbiBiZSBhbHdheXMgcmVwcm9kdWNlZCBp
biBsaW1pdGVkIHRpbWUoc3VwcG9zZSBpdCBpcyBBKS4gSWYgdGhlIGlzc3VlCmNhbid0IGJlIHJl
cHJvZHVjZWQgYW55IG1vcmUgYWZ0ZXIgYXBwbHlpbmcgdGhlIHBhdGNoIGluIGxvbmcgZW5vdWdo
IHRpbWUgQihCID4+IEEpLAp3ZSBjYW4gdGhpbmsgaXQgaXMgZml4ZWQgYnkgdGhlIHBhdGNoLgoK
Rm9yIGV4YW1wbGUsIGlmIEEgaXMgb25lIGhvdXIsIHdlIGNhbiBzZXQgQiBhcyA1KkEgb3IgYmln
Z2VyIHRvIHNpbXVsYXRlCnRoZSBsb25nIGVub3VnaCB0aW1lLgoKClRoYW5rcywKTWluZwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
