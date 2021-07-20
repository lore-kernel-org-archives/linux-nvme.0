Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF6BC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 09:05:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E32E61209
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 09:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E32E61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7Qqj9AwkqlMv0iIwW8FHozrgOCDdxq21s0sz3/dHQY=; b=nMrpd6uv+GG+0y
	VmwELzBXrrkHkSYrkNGd4rQFarYntiDJlS7+hlB100EVNIv+4fOnwIl2htFA7z6Na9GGB1vasIUDb
	wDhPLl0+3ra7+AqUTkOaabhZpHiAqwav1xAEQPekjxldoqtZu0xC3hEdrfP12JbcY+OWZr2/fx5gc
	xE+MF0VqpfcGBitPPLqK+rvVCY7o60ueWCH7qEpKCWyCsH9W4RuLcjGde6Eq8+Kr7a+x7RDh54IIR
	TnjB0ZO+/UT4M4dbPM5Vo7/6qKOlY9acy3gexRm1yL3y/igMnb1VhV9eSOWo3i4zZiWrMNHTtjgJC
	QDrEFO8cBU7dC7QUMW7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5lh5-00CMq2-R2; Tue, 20 Jul 2021 09:05:39 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5lh2-00CMny-GX
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 09:05:38 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 6D05AB41E7E;
 Tue, 20 Jul 2021 11:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626771931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTkNNItkMBlaqFMYurWQMqTjRu8UVH4wWx+Z1y3Sv9o=;
 b=NsWnK6DIEsHFO/M0/bzgppZTDvUtPXdBU0oyQHXWoDFC+rtKa0p9TmNGrulekbWKkUGV22
 wIwfi0LscB5GHq+4sJa8fi9yyKoY8CnOfMvQ/nq+BgNwkR8NtqjvetL8vTCFQzQG8Bx0LQ
 ZM8huj4wu4W8qKswXrpe1JIxbSqrvB4=
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
Date: Tue, 20 Jul 2021 11:05:29 +0200
Message-ID: <2356877.Yf5hrMSTGe@natalenko.name>
In-Reply-To: <2407736.Le3fEKZpXq@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPTYGD1zeae1x7Yp@T590>
 <2407736.Le3fEKZpXq@natalenko.name>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_020536_893479_7C346D21 
X-CRM114-Status: GOOD (  24.66  )
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

SGVsbG8sIE1pbmcuCgpPbiBwb25kxJtsw60gMTkuIMSNZXJ2ZW5jZSAyMDIxIDg6Mjc6MjkgQ0VT
VCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOgo+IE9uIHBvbmTEm2zDrSAxOS4gxI1lcnZlbmNl
IDIwMjEgMzo0MDo0MCBDRVNUIE1pbmcgTGVpIHdyb3RlOgo+ID4gT24gU2F0LCBKdWwgMTcsIDIw
MjEgYXQgMDI6MzU6MTRQTSArMDIwMCwgT2xla3NhbmRyIE5hdGFsZW5rbyB3cm90ZToKPiA+ID4g
T24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDoxOTo1OSBDRVNUIE9sZWtzYW5kciBOYXRh
bGVua28gd3JvdGU6Cj4gPiA+ID4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDoxMTow
NSBDRVNUIE9sZWtzYW5kciBOYXRhbGVua28gd3JvdGU6Cj4gPiA+ID4gPiBPbiBzb2JvdGEgMTcu
IMSNZXJ2ZW5jZSAyMDIxIDExOjM1OjMyIENFU1QgTWluZyBMZWkgd3JvdGU6Cj4gPiA+ID4gPiA+
IE1heWJlIHlvdSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBidWlsZCBpcyBPSywgSSBjYW4ndCByZXBy
b2R1Y2UgaXQKPiA+ID4gPiA+ID4gaW4KPiA+ID4gPiA+ID4gbXkKPiA+ID4gPiA+ID4gVk0sIGFu
ZCBCRlEgaXMgc3RpbGwgYnVpbHRpbjoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFtyb290QGt0
ZXN0LTAxIH5dIyB1bmFtZSAtYQo+ID4gPiA+ID4gPiBMaW51eCBrdGVzdC0wMSA1LjE0LjAtcmMx
KyAjNTIgU01QIEZyaSBKdWwgMTYgMTg6NTY6MzYgQ1NUIDIwMjEKPiA+ID4gPiA+ID4geDg2XzY0
Cj4gPiA+ID4gPiA+IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4IFtyb290QGt0ZXN0LTAxIH5dIyBj
YXQKPiA+ID4gPiA+ID4gL3N5cy9ibG9jay9udm1lMG4xL3F1ZXVlL3NjaGVkdWxlcgo+ID4gPiA+
ID4gPiBbbm9uZV0gbXEtZGVhZGxpbmUga3liZXIgYmZxCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyBhbiBpc3N1ZSB3aXRoIHRoZSBidWlsZOKApiBCVFcsIHdpdGgK
PiA+ID4gPiA+IGBpbml0Y2FsbF9kZWJ1Z2A6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGBgYAo+ID4g
PiA+ID4gWyAgICAwLjkwMjU1NV0gY2FsbGluZyAgYmZxX2luaXQrMHgwLzB4OGIgQCAxCj4gPiA+
ID4gPiBbICAgIDAuOTAzNDQ4XSBpbml0Y2FsbCBiZnFfaW5pdCsweDAvMHg4YiByZXR1cm5lZCAt
MjggYWZ0ZXIgNTA3Cj4gPiA+ID4gPiB1c2Vjcwo+ID4gPiA+ID4gYGBgCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IC1FTk9TUEM/IFdoeT8gQWxzbyByZS10ZXN0ZWQgd2l0aCB0aGUgbGF0ZXN0IGdpdCB0
aXAsIHNhbWUgcmVzdWx0Cj4gPiA+ID4gPiA6KC4KPiA+ID4gPiAKPiA+ID4gPiBPSywgb25lIGV4
dHJhIHByX2luZm8sIGFuZCBJIHNlZSB0aGlzOgo+ID4gPiA+IAo+ID4gPiA+IGBgYAo+ID4gPiA+
IFsgICAgMC44NzExODBdIGJsa2NnX3BvbGljeV9yZWdpc3RlcjogQkxLQ0dfTUFYX1BPTFMgdG9v
IHNtYWxsCj4gPiA+ID4gWyAgICAwLjg3MTYxMl0gYmxrY2dfcG9saWN5X3JlZ2lzdGVyOiAtMjgK
PiA+ID4gPiBgYGAKPiA+ID4gPiAKPiA+ID4gPiBXaGF0IGRvZXMgaXQgbWVhbiBwbGVhc2UgOik/
IFRoZSB2YWx1ZSBzZWVtcyB0byBiZSBoYXJkLWNvZGVkOgo+ID4gPiA+IAo+ID4gPiA+IGBgYAo+
ID4gPiA+IGluY2x1ZGUvbGludXgvYmxrZGV2LmgKPiA+ID4gPiA2MDojZGVmaW5lIEJMS0NHX01B
WF9QT0xTICAgICAgICAgICAgICAgNQo+ID4gPiA+IGBgYAo+ID4gPiAKPiA+ID4gT0ssIGFmdGVy
IGluY3JlYXNpbmcgdGhpcyB0byA2IEkndmUgZ290IG15IEJGUSBiYWNrLiBQbGVhc2Ugc2VlIFsx
XS4KPiA+ID4gCj4gPiA+IFsxXQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1i
bG9jay8yMDIxMDcxNzEyMzMyOC45NDU4MTAtMS1vbGVrc2FuZHJAbmEKPiA+ID4gdAo+ID4gPiBh
bGVua28ubmFtZS8KPiA+IAo+ID4gT0ssIGFmdGVyIHlvdSBmaXhlZCB0aGUgaXNzdWUgaW4gYmxr
Y2dfcG9saWN5X3JlZ2lzdGVyKCksIGNhbiB5b3UKPiA+IHJlcHJvZHVjZSB0aGUgZGlzY2FyZCBp
c3N1ZSBvbiB2NS4xNC1yYzEgd2l0aCBCRlEgYXBwbGllZD8gSWYgeWVzLAo+ID4gY2FuIHlvdSB0
ZXN0IHRoZSBwYXRjaCBJIHBvc3RlZCBwcmV2aW91c2x5Pwo+IAo+IFllcywgdGhlIGlzc3VlIGlz
IHJlcHJvZHVjaWJsZSB3aXRoIGJvdGggdjUuMTMuMiBhbmQgdjUuMTQtcmMxLiBJIGhhdmVuJ3QK
PiBtYW5hZ2VkIHRvIHJlcHJvZHVjZSBpdCB3aXRoIHY1LjEzLjIreW91ciBwYXRjaC4gTm93IEkg
d2lsbCBidWlsZCB2NS4xNC0KPiByYzIreW91ciBwYXRjaCBhbmQgdGVzdCBmdXJ0aGVyLgoKSSdt
IHN0aWxsIGhhbW1lcmluZyB2NS4xNC1yYzIgKyB5b3VyIHBhdGNoLCBhbmQgSSBjYW5ub3QgcmVw
cm9kdWNlIHRoZSBpc3N1ZS4gCkdpdmVuIEkgZG8gbm90IGhhdmUgYSByZWxpYWJsZSByZXByb2R1
Y2VyIChJJ20ganVzdCBmaXJpbmcgdXAgdGhlIGtlcm5lbCBidWlsZCwgCmFuZCB0aGUgaXNzdWUg
cG9wcyB1cCBldmVudHVhbGx5LCBzb29uZXIgb3IgbGF0ZXIsIGJ1dCB1c3VhbGx5IHdpdGhpbiBh
IGNvdXBsZSAKb2YgZmlyc3QgdHJpZXMpLCBmb3IgaG93IGxvbmcgSSBzaG91bGQgaGFtbWVyIGl0
IGZvciB5b3VyIGZpeCB0byBiZSBjb25zaWRlcmVkIApwcm92ZW4/CgpUaGFua3MuCgotLSAKT2xl
a3NhbmRyIE5hdGFsZW5rbyAocG9zdC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
