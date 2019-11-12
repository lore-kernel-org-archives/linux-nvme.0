Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26522C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 14:40:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36EF20679
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sen151Ft";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvAzMbTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36EF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j5f95rtX0Kwq+E8QF5rWhKVUnUZW+GeWgEanOiQ0fZw=; b=Sen151Ft0dW3a7
	ZwCqoxTgrtnIXSeWYqAWdTxueluWT0v3r5tc4kkVTX0ax45anCYAFWC3SIu6eeby+IJe7KRjQLxmO
	tGUQZal7e4GfVuDYybc8j2RNfYqg3zqdZO3dKeyhVEAVd1VzmL2KxVPlPtJbNnulKl2G90K1d/xv7
	cR4AK/7ZoI33U8Ecga0+kKifnYz1dpzh5Et+KKf72UqmfdAbqK8gMIkO519sYJhcpp0KGXcY3N9Ua
	ujXPCpZtnjxoXGesQzZCqkOVb3oC0BLJJJTYx8Oq0tKIH4FQS/jTvtmDlkZHMVgcy/94nwuFuwswk
	OBQoSrXXu0pxzrLPSUDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUXLg-0005cG-DW; Tue, 12 Nov 2019 14:40:52 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUXLd-0005bh-Cp
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 14:40:50 +0000
Received: by mail-lf1-x141.google.com with SMTP id i26so1974574lfl.2
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D0+mCwJvHZZGpXOrejwBvoUrE1rKqIxcVrLLV65g3dU=;
 b=nvAzMbTC2bmnHwdji1J7sYUrM9QAPLElBkYCTZ0Zth9vuKzqOXYwgIZbgEpLjrGpyk
 RPhBLA1BMjgApnaEwfa2kU6dpw9mDYD887VzTydqNNffU1a0wLaMOo3lM5D/RiLnfHSa
 cInD9O75RNCtkHSHF4Iz4Yl5Qv8QvNAD3Vf/iUyIRtodsCR0C2PxApxNGJTbIUka3bi8
 n5HkTa3VNpMebLtauG2tGOQA35bGFZjqkQJmB9IMBXh5uG5vgL13rdu8gdLA9dWpCO1v
 9dazDp74rTFZx1qthy1/SL7z1GgMlq3iQvMJlVF5t/87pPd/vLwYEB0r9LeQZ8M+2ezE
 2itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D0+mCwJvHZZGpXOrejwBvoUrE1rKqIxcVrLLV65g3dU=;
 b=P/UMzZ+3zMFlxX/ZcDrGwcEciHeDni1wI89H2H/dZNbaJHplh4RBE9KeWcrYcPaXsN
 Zsh3X78UDHf7w8gx/GxraF4b46Bh6xPFIFLdy3/QSbcXFbchHxRHxHCVrqZuz2cOe62u
 RssC0oxMdIwuU/sRvr2GS7rbeRbi2GrC9V0ARhNkqfz9WGhGM1zJ1t3s/4OCMAmGvu6T
 wJCaCijeCj9NoH6SbhpG5sork9KhHyCDEboU4brF+H6ZsGP0CqcfeaT9mgHkqiKgyRE9
 lh8gech1Npjw4p8rHIExTBcI7t/o5cRLwH9ZIhLWdZ7atSnfT3C4FmkDulZHEY5HbF72
 ux3Q==
X-Gm-Message-State: APjAAAX4gNrRiiOQapNYbaMAA9iUCinWKTGXHn/+JoWB4Hv8ZjM+ihX0
 rXrjEVlVM5CYWyz2WgcM5dc5pOAR2Uaaa5v5VMM=
X-Google-Smtp-Source: APXvYqwHxZ+IyoJdKVYjIf4LG+E5Mo8okP10vfKBtWf/7bZE5nrjrmrW1YKxzv6NYAzs8mSVtNKlfXkTv+2kMrSMgtE=
X-Received: by 2002:a19:820e:: with SMTP id e14mr19885367lfd.29.1573569644343; 
 Tue, 12 Nov 2019 06:40:44 -0800 (PST)
MIME-Version: 1.0
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <d3c0c9a7-00b9-0465-16e1-6fd7ba97dfd0@roeck-us.net>
 <CAC5umyiju2Q2fdfVaFyX+Q=sMKr5Gsc_GDVYmSa0vB+w8acvAw@mail.gmail.com>
 <20191111173505.GB5826@roeck-us.net>
In-Reply-To: <20191111173505.GB5826@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 12 Nov 2019 23:40:32 +0900
Message-ID: <CAC5umyjviR1J5HojE6WBhYQCzu=CFPPoNxXY=T9KRw2yTpO=VQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_064049_436416_D21722BD 
X-CRM114-Status: GOOD (  28.49  )
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMTLml6Uo54GrKSAyOjM1IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD46Cj4KPiBPbiBUdWUsIE5vdiAxMiwgMjAxOSBhdCAxMjo1NjoyMUFNICswOTAwLCBBa2lu
b2J1IE1pdGEgd3JvdGU6Cj4gPiAyMDE55bm0MTHmnIgxMeaXpSjmnIgpIDE6MzAgR3VlbnRlciBS
b2VjayA8bGludXhAcm9lY2stdXMubmV0PjoKPiA+ID4KPiA+Cj4gWyAuLi4gXQo+Cj4gPiA+ID4g
RXhhbXBsZSBvdXRwdXQgZnJvbSB0aGUgInNlbnNvcnMiIGNvbW1hbmQ6Cj4gPiA+ID4KPiA+ID4g
PiBudm1lLXBjaS0wMTAwCj4gPiA+ID4gQWRhcHRlcjogUENJIGFkYXB0ZXIKPiA+ID4gPiBDb21w
b3NpdGU6ICAgICs1My4wIEMgIChsb3cgID0gLTI3My4wIEMsIGhpZ2ggPSArNzAuMCBDKQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIChjcml0ID0gKzgwLjAgQykKPiA+ID4gPiBTZW5z
b3IgMTogICAgICs1Ni4wIEMgIChsb3cgID0gLTI3My4wIEMsIGhpZ2ggPSArNjUyNjIuMCBDKQo+
ID4gPiA+IFNlbnNvciAyOiAgICAgKzUxLjAgQyAgKGxvdyAgPSAtMjczLjAgQywgaGlnaCA9ICs2
NTI2Mi4wIEMpCj4gPiA+ID4gU2Vuc29yIDU6ICAgICArNzMuMCBDICAobG93ICA9IC0yNzMuMCBD
LCBoaWdoID0gKzY1MjYyLjAgQykKPiA+ID4gPgo+ID4gPgo+ID4gPiBIYXZlIHlvdSB0cmllZCB3
cml0aW5nIHRoZSBsaW1pdHMgPyBPbiBteSBJbnRlbCBOVk1FIGRyaXZlIChTU0RQRUtLVzUxMkc3
KSwgd3JpdGluZwo+ID4gPiBhbnkgbWluaW11bSBsaW1pdCBvbiB0aGUgQ29tcG9zaXRlIHRlbXBl
cmF0dXJlIHNlbnNvciByZXN1bHRzIGluIGEgdGVtcGVyYXR1cmUKPiA+ID4gd2FybmluZywgYW5k
IHRoYXQgd2FybmluZyBpcyBzdGlja3kgdW50aWwgSSByZXNldCB0aGUgY29udHJvbGxlci4KPiA+
ID4gSSBkb24ndCBzZWUgdGhhdCBwcm9ibGVtIG9uIFNhbXN1bmcgU1NEIDk3MCBFVk8gNTAwR0I7
IEkgaGF2ZSBub3QgeWV0IHRyaWVkIG90aGVycy4KPiA+Cj4gPiBJIGhhdmUgQ3J1Y2lhbCBDVDUw
MFAxU1NEOCBhbmQgV0RDIFdEUzUxMkcxWDBDLTAwRU5YMCwgYW5kIEkgaGF2ZSBubwo+ID4gcHJv
YmxlbSB3aXRoIHRoZXNlIGRldmljZXMuCj4gPgo+ID4gPiByb290QGp1cGl0ZXI6L3N5cy9jbGFz
cy9od21vbi9od21vbjAjIHNlbnNvcnMgbnZtZS1wY2ktMDEwMAo+ID4gPiBudm1lLXBjaS0wMTAw
Cj4gPiA+IEFkYXB0ZXI6IFBDSSBhZGFwdGVyCj4gPiA+IENvbXBvc2l0ZTogICAgKzMwLjDCsEMg
IChsb3cgID0gLTI3My4wwrBDLCBoaWdoID0gKzcwLjDCsEMpCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIChjcml0ID0gKzgwLjDCsEMpCj4gPiA+Cj4gPiA+IHJvb3RAanVwaXRlcjovc3lz
L2NsYXNzL2h3bW9uL2h3bW9uMCMgZWNobyAwID4gdGVtcDFfbWluCj4gPiA+IHJvb3RAanVwaXRl
cjovc3lzL2NsYXNzL2h3bW9uL2h3bW9uMCMgc2Vuc29ycyBudm1lLXBjaS0wMTAwCj4gPiA+IG52
bWUtcGNpLTAxMDAKPiA+ID4gQWRhcHRlcjogUENJIGFkYXB0ZXIKPiA+ID4gQ29tcG9zaXRlOiAg
ICArMzAuMMKwQyAgKGxvdyAgPSAgKzAuMMKwQywgaGlnaCA9ICs3MC4wwrBDKSAgQUxBUk0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgKGNyaXQgPSArODAuMMKwQykKPiA+ID4KPiA+ID4g
SXQgZG9lc24ndCBzZWVtIHRvIG1hdHRlciB3aGljaCB0ZW1wZXJhdHVyZSBJIHdyaXRlOyB3cml0
aW5nIC0yNzMwMDAgaGFzCj4gPiA+IHRoZSBzYW1lIHJlc3VsdC4KPiA+ID4KPiA+ID4gW1RoaXMg
aXMgYWN0dWFsbHkgd2h5IEkgZGlkbid0IHVzZSB0aGUgZmVhdHVyZXMgY29tbWFuZHM7IG5vdCB0
aGF0IEkgaGFkIG9ic2VydmVkCj4gPiA+ICAgdGhlIHByb2JsZW0sIGJ1dCBJIHdhcyBjb25jZXJu
ZWQgdGhhdCBwcm9ibGVtcyBsaWtlIHRoaXMgd291bGQgc2hvdyB1cC5dCj4gPgo+ID4gTWF5YmUg
d2Ugc2hvdWxkIGludHJvZHVjZSBhIG5ldyBxdWlyayBzbyB0aGF0IHdlIGNhbiBhdm9pZCBjaGFu
Z2luZwo+ID4gdGVtcGVyYXR1cmUgdGhyZXNob2xkIGZvciBzdWNoIGRldmljZXMuICBDb3VsZCB5
b3UgdGVsbCBTU0RQRUtLVzUxMkc3J3MKPiA+IHZlbmRvciBhbmQgZGV2aWNlIElEPyAgUXVpY2sg
Z29vZ2xpbmcgYW5zd2VycyBpdCdzIDgwODY6ZjFhNSwgYnV0IEkgd2FudAo+ID4gdG8gbWFrZSBz
dXJlLgo+Cj4gWWVzLCB0aGF0IGlzIGNvcnJlY3QuCj4KPiAwMTowMC4wIE5vbi1Wb2xhdGlsZSBt
ZW1vcnkgY29udHJvbGxlciBbMDEwOF06IEludGVsIENvcnBvcmF0aW9uIERldmljZSBbODA4Njpm
MWE1XSAocmV2IDAzKQoKT0suICBJJ2xsIGFkZCBOVk1FX1FVSVJLX05PX1RFTVBfVEhSRVNIX0NI
QU5HRSBhbmQgbWFyayB0aGUgZGV2aWNlLgoKPiBJJ2xsIHNlZSBpZiBJIGNhbiB0ZXN0IHRoaXMg
dG9uaWdodCBvbiBteSBvdGhlciBOVk1Fcy4gSSBhbHNvIGR1ZyB1cCBhbiBvbGQKPiBOVk1lIGRy
aXZlIGZyb20gVG9zaGliYTsgSSdsbCBzZWUgaWYgSSBjYW4gY29ubmVjdCBhbmQgdGVzdCBpdCBh
cyB3ZWxsLgoKVGhhdCdzIG5pY2UuCgo+IFsgLi4uIF0KPgo+ID4gPiA+ICAgICAgICAqLwo+ID4g
PiA+ICAgICAgIHN3aXRjaCAoYXR0cikgewo+ID4gPiA+ICAgICAgIGNhc2UgaHdtb25fdGVtcF9t
YXg6Cj4gPiA+ID4gLSAgICAgICAgICAgICAqdmFsID0gKGRhdGEtPmN0cmwtPndjdGVtcCAtIDI3
MykgKiAxMDAwOwo+ID4gPiA+ICsgICAgICAgICAgICAgZXJyID0gbnZtZV9nZXRfdGVtcF90aHJl
c2goZGF0YS0+Y3RybCwgY2hhbm5lbCwgZmFsc2UsIHZhbCk7Cj4gPiA+ID4gKyAgICAgICAgICAg
ICBpZiAoZXJyKQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAqdmFsID0gKGRhdGEtPmN0
cmwtPndjdGVtcCAtIDI3MykgKiAxMDAwOwo+ID4gPgo+ID4gPiBUaGlzIHdvdWxkIHJlcG9ydCBX
Q1RFTVAgZm9yIGFsbCBzZW5zb3JzIG9uIGVycm9ycywgaW5jbHVkaW5nIGVycm9ycyBzZWVuIHdo
aWxlCj4gPiA+IHRoZSBjb250cm9sbGVyIGlzIHJlc2V0dGluZy4gSSB0aGluayBpdCBzaG91bGQg
YmUgc29tZXRoaW5nIGxpa2UKPiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgIGludCBlcnIgPSAw
Owo+ID4gPiAgICAgICAgICAgICAgICAgLi4uCj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICBp
ZiAoIWNoYW5uZWwpCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSAoZGF0YS0+
Y3RybC0+d2N0ZW1wIC0gMjczKSAqIDEwMDA7Cj4gPiA+ICAgICAgICAgICAgICAgICBlbHNlCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IG52bWVfZ2V0X3RlbXBfdGhyZXNoKGRh
dGEtPmN0cmwsIGNoYW5uZWwsIGZhbHNlLCB2YWwpOwo+ID4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIGVycjsKPiA+ID4KPiA+ID4gYXNzdW1pbmcgd2Uga2VlcCB1c2luZyBjdHJsLT53Y3RlbXAg
KHNlZSBiZWxvdykuIElmIGNoYW5naW5nIHRoZSB1cHBlciBDb21wb3NpdGUKPiA+ID4gdGVtcGVy
YXR1cmUgc2Vuc29yIGxpbWl0IGNoYW5nZXMgd2N0ZW1wLCBhbmQgd2UgZG9uJ3QgdXBkYXRlIGl0
LCB3ZSBzaG91bGQgbm90Cj4gPiA+IHVzZSBpdCBhdCBhbGwgYWZ0ZXIgcmVnaXN0cmF0aW9uIGFu
ZCBqdXN0IHJlcG9ydCB0aGUgZXJyb3IuCj4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgICByZXR1
cm4gMDsKPiA+ID4gPiArICAgICBjYXNlIGh3bW9uX3RlbXBfbWluOgo+ID4gPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIG52bWVfZ2V0X3RlbXBfdGhyZXNoKGRhdGEtPmN0cmwsIGNoYW5uZWwsIHRy
dWUsIHZhbCk7Cj4gPiA+ID4gICAgICAgY2FzZSBod21vbl90ZW1wX2NyaXQ6Cj4gPiA+ID4gICAg
ICAgICAgICAgICAqdmFsID0gKGRhdGEtPmN0cmwtPmNjdGVtcCAtIDI3MykgKiAxMDAwOwo+ID4g
PiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4gQEAgLTczLDYgKzExNywyMyBAQCBz
dGF0aWMgaW50IG52bWVfaHdtb25fcmVhZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gaHdtb25f
c2Vuc29yX3R5cGVzIHR5cGUsCj4gPiA+ID4gICAgICAgcmV0dXJuIGVycjsKPiA+ID4gPiAgIH0K
PiA+ID4gPgo+ID4gPiA+ICtzdGF0aWMgaW50IG52bWVfaHdtb25fd3JpdGUoc3RydWN0IGRldmlj
ZSAqZGV2LCBlbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0eXBlLAo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgdTMyIGF0dHIsIGludCBjaGFubmVsLCBsb25nIHZhbCkKPiA+ID4gPiAr
ewo+ID4gPiA+ICsgICAgIHN0cnVjdCBudm1lX2h3bW9uX2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsKPiA+ID4gPiArCj4gPiA+ID4gKyAgICAgc3dpdGNoIChhdHRyKSB7Cj4gPiA+
ID4gKyAgICAgY2FzZSBod21vbl90ZW1wX21heDoKPiA+ID4gPiArICAgICAgICAgICAgIHJldHVy
biBudm1lX3NldF90ZW1wX3RocmVzaChkYXRhLT5jdHJsLCBjaGFubmVsLCBmYWxzZSwgdmFsKTsK
PiA+ID4KPiA+ID4gRG9lcyB0aGlzIGNoYW5nZSBXQ1RFTVAgaWYgd3JpdHRlbiBvbiBjaGFubmVs
IDAgPyBJZiBzbywgd2Ugd291bGQgaGF2ZSB0byB1cGRhdGUKPiA+ID4gdGhlIGNhY2hlZCB2YWx1
ZSBvZiBjdHJsLT53Y3RlbXAgKG9yIG5ldmVyIHVzZSBpdCBhZnRlciByZWdpc3RyYXRpb24pLgo+
ID4KPiA+IEF0IGxlYXN0IGZvciB0aGUgZGV2aWNlcyBJIGhhdmUsIHNldHRpbmcgdGhlIG92ZXIg
dGVtcGVyYXR1cmUgdGhyZXNob2xkCj4gPiBkb2Vzbid0IGNoYW5nZSB0aGUgV0NURU1QLgo+ID4g
SSBoYXZlIGNoZWNrZWQgd2l0aCAgJ252bWUgaWQtY3RybCAvZGV2L252bWUwIHwgZ3JlcCBjdGVt
cCcuCj4gPgo+Cj4gSW50ZXJlc3RpbmcuIEkganVzdCB0ZXN0ZWQgdGhpcywgYW5kIHRoZSByZXN1
bHQgaXMgdGhlIHNhbWUgd2l0aCBTYW1zdW5nCj4gU1NEIDk3MCBFVk8uIFdpdGggdGhhdCBpbiBt
aW5kLCBtYXliZSB3ZSBzaG91bGQgcmVhbGx5IG5vdCB1c2Ugd2N0ZW1wCj4gYXQgYWxsIGFmdGVy
IGluaXRpYWxpemF0aW9uLCBhcyBJIGhhZCBzdWdnZXN0ZWQgYWJvdmUuIFdoYXQgZG8geW91IHRo
aW5rID8KClllcy4gV2Ugb25seSBuZWVkIHRvIHVzZSB0aGUgV0NURU1QIGluIG52bWVfaHdtb25f
aXNfdmlzaWJsZSgpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
