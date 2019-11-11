Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B8C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01688214DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FgShOOT0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdEctRSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01688214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DPsAvkt6dTI9fmR0W1brbiyH2RZcAo5KCkiCq/e8bls=; b=FgShOOT0SNQ/UZ
	KWZPfGdlixqjEcghL0etYeENnJ6INfLMil4CYGUQv1ItwgGpR4nNTDcI3w/FuqjF4lXRF/lJK8S94
	Bj/g4vy/Sed8ycNR3lGwg13S1FAonYlL5jgE89ohQKQ8DpkiUtTiAfBcPD8lwrpxrrKWNeYAzwjyq
	2mPUtQSI1G5gEw2sxpFjl8dEg7jMt5KaPsaX25uIZrD54UlzhX8D27P1APvUzGFJJ/+Xb8ByNM+rh
	p7BIToysnccMsjesPuMGmgKV8IwGnhP5n+kSmIti3qFnFNC6mYBblnGas/l6mBBg0ZLS1rUEJ/5cB
	psgnPVp18Sg1NyolwuYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUDaq-0003ie-U7; Mon, 11 Nov 2019 17:35:12 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUDan-0003Xs-EO
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 17:35:11 +0000
Received: by mail-pl1-x644.google.com with SMTP id h13so2698479plr.1
 for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2019 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Eo2i+iMeMaAm046EL5ip69xym4vsibb65zfJmkDz5pk=;
 b=bdEctRShAzxa/jV0BuGcfQDkptImnrUbIM2Z4I/ZyXjh9/TCNML+ov2jtilDJcHBq5
 rL/8vidc5cZSYznwuGtbShMyeIBh/7gonA1E+0M5XgcqGblJXTWBvQaqOtjX9StQJIqV
 mXo/Cn1fxh06JCTWbOub8kcrQN6ibuPrhtIUQUo79HjT/d3riQt3+9fm13uiSqyylQAi
 +DA6rraX2ruGpd02XRrQGU7asutg9h1WnAbssYQKvXy+gIPhFAfZ78fOW8BeCWGwm/U/
 8vlzp+3NPuaQfJbGemb0mU0wldwoC6fIjfmJHTSfA2RgWn6RlW9F6/D/jZvmXWrEimMV
 I67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=Eo2i+iMeMaAm046EL5ip69xym4vsibb65zfJmkDz5pk=;
 b=iLP6X4Hyd//BSwl7docGqMgrSWIXgc3tZWGGa8sRVlw8R6RGO68h2YvlLRyfJN+TIN
 doDSXvkv2lLmFyLfQu+JNJsf+7stgcS8QAKDxMHzVztXb3hwdAKt8rVTktBbvfsXq8sb
 +kVTcpg99i8IwrC2IwqEcZHnMS4S/ZxNz2wu0vy4qs+eo4n+Pf6Cp15ZEPb+wBNx48w7
 0jWCDnJBMWujlhK2ehzSJx3JIG/yObuefGsWtyuVHZOsN21nvkfRVvr+RTJNEgOs6onZ
 wDRZ1LMhZTwhIB3Q+xqYncDLVrLUNp+CkwZrMSooT/9iL9H+u07NV/nIiXPQ7F00X8CT
 z3Dg==
X-Gm-Message-State: APjAAAX3YCgdHpY1Yur4d18T3Rcrt9sw8y8/wjK9fqG0OyV7rIPNwdRm
 7sEWm0CmgDRMUAlCXovCeoQ=
X-Google-Smtp-Source: APXvYqzYYlnft3p/Q8XhFnDvCTl5UP0JI7nX1zsbvaEnNTqVBxON0dI3HZgyRaVTZo7oP53S6IwyVQ==
X-Received: by 2002:a17:902:ac90:: with SMTP id
 h16mr27749316plr.147.1573493708116; 
 Mon, 11 Nov 2019 09:35:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id k20sm17766123pgn.40.2019.11.11.09.35.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Nov 2019 09:35:06 -0800 (PST)
Date: Mon, 11 Nov 2019 09:35:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
Message-ID: <20191111173505.GB5826@roeck-us.net>
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <d3c0c9a7-00b9-0465-16e1-6fd7ba97dfd0@roeck-us.net>
 <CAC5umyiju2Q2fdfVaFyX+Q=sMKr5Gsc_GDVYmSa0vB+w8acvAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC5umyiju2Q2fdfVaFyX+Q=sMKr5Gsc_GDVYmSa0vB+w8acvAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_093509_512541_D93023FD 
X-CRM114-Status: GOOD (  26.54  )
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

T24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMTI6NTY6MjFBTSArMDkwMCwgQWtpbm9idSBNaXRhIHdy
b3RlOgo+IDIwMTnlubQxMeaciDEx5pelKOaciCkgMTozMCBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+Ogo+ID4KPiAKWyAuLi4gXQoKPiA+ID4gRXhhbXBsZSBvdXRwdXQgZnJvbSB0
aGUgInNlbnNvcnMiIGNvbW1hbmQ6Cj4gPiA+Cj4gPiA+IG52bWUtcGNpLTAxMDAKPiA+ID4gQWRh
cHRlcjogUENJIGFkYXB0ZXIKPiA+ID4gQ29tcG9zaXRlOiAgICArNTMuMCBDICAobG93ICA9IC0y
NzMuMCBDLCBoaWdoID0gKzcwLjAgQykKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgKGNy
aXQgPSArODAuMCBDKQo+ID4gPiBTZW5zb3IgMTogICAgICs1Ni4wIEMgIChsb3cgID0gLTI3My4w
IEMsIGhpZ2ggPSArNjUyNjIuMCBDKQo+ID4gPiBTZW5zb3IgMjogICAgICs1MS4wIEMgIChsb3cg
ID0gLTI3My4wIEMsIGhpZ2ggPSArNjUyNjIuMCBDKQo+ID4gPiBTZW5zb3IgNTogICAgICs3My4w
IEMgIChsb3cgID0gLTI3My4wIEMsIGhpZ2ggPSArNjUyNjIuMCBDKQo+ID4gPgo+ID4KPiA+IEhh
dmUgeW91IHRyaWVkIHdyaXRpbmcgdGhlIGxpbWl0cyA/IE9uIG15IEludGVsIE5WTUUgZHJpdmUg
KFNTRFBFS0tXNTEyRzcpLCB3cml0aW5nCj4gPiBhbnkgbWluaW11bSBsaW1pdCBvbiB0aGUgQ29t
cG9zaXRlIHRlbXBlcmF0dXJlIHNlbnNvciByZXN1bHRzIGluIGEgdGVtcGVyYXR1cmUKPiA+IHdh
cm5pbmcsIGFuZCB0aGF0IHdhcm5pbmcgaXMgc3RpY2t5IHVudGlsIEkgcmVzZXQgdGhlIGNvbnRy
b2xsZXIuCj4gPiBJIGRvbid0IHNlZSB0aGF0IHByb2JsZW0gb24gU2Ftc3VuZyBTU0QgOTcwIEVW
TyA1MDBHQjsgSSBoYXZlIG5vdCB5ZXQgdHJpZWQgb3RoZXJzLgo+IAo+IEkgaGF2ZSBDcnVjaWFs
IENUNTAwUDFTU0Q4IGFuZCBXREMgV0RTNTEyRzFYMEMtMDBFTlgwLCBhbmQgSSBoYXZlIG5vCj4g
cHJvYmxlbSB3aXRoIHRoZXNlIGRldmljZXMuCj4gCj4gPiByb290QGp1cGl0ZXI6L3N5cy9jbGFz
cy9od21vbi9od21vbjAjIHNlbnNvcnMgbnZtZS1wY2ktMDEwMAo+ID4gbnZtZS1wY2ktMDEwMAo+
ID4gQWRhcHRlcjogUENJIGFkYXB0ZXIKPiA+IENvbXBvc2l0ZTogICAgKzMwLjDCsEMgIChsb3cg
ID0gLTI3My4wwrBDLCBoaWdoID0gKzcwLjDCsEMpCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAoY3JpdCA9ICs4MC4wwrBDKQo+ID4KPiA+IHJvb3RAanVwaXRlcjovc3lzL2NsYXNzL2h3bW9u
L2h3bW9uMCMgZWNobyAwID4gdGVtcDFfbWluCj4gPiByb290QGp1cGl0ZXI6L3N5cy9jbGFzcy9o
d21vbi9od21vbjAjIHNlbnNvcnMgbnZtZS1wY2ktMDEwMAo+ID4gbnZtZS1wY2ktMDEwMAo+ID4g
QWRhcHRlcjogUENJIGFkYXB0ZXIKPiA+IENvbXBvc2l0ZTogICAgKzMwLjDCsEMgIChsb3cgID0g
ICswLjDCsEMsIGhpZ2ggPSArNzAuMMKwQykgIEFMQVJNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAoY3JpdCA9ICs4MC4wwrBDKQo+ID4KPiA+IEl0IGRvZXNuJ3Qgc2VlbSB0byBtYXR0ZXIg
d2hpY2ggdGVtcGVyYXR1cmUgSSB3cml0ZTsgd3JpdGluZyAtMjczMDAwIGhhcwo+ID4gdGhlIHNh
bWUgcmVzdWx0Lgo+ID4KPiA+IFtUaGlzIGlzIGFjdHVhbGx5IHdoeSBJIGRpZG4ndCB1c2UgdGhl
IGZlYXR1cmVzIGNvbW1hbmRzOyBub3QgdGhhdCBJIGhhZCBvYnNlcnZlZAo+ID4gICB0aGUgcHJv
YmxlbSwgYnV0IEkgd2FzIGNvbmNlcm5lZCB0aGF0IHByb2JsZW1zIGxpa2UgdGhpcyB3b3VsZCBz
aG93IHVwLl0KPiAKPiBNYXliZSB3ZSBzaG91bGQgaW50cm9kdWNlIGEgbmV3IHF1aXJrIHNvIHRo
YXQgd2UgY2FuIGF2b2lkIGNoYW5naW5nCj4gdGVtcGVyYXR1cmUgdGhyZXNob2xkIGZvciBzdWNo
IGRldmljZXMuICBDb3VsZCB5b3UgdGVsbCBTU0RQRUtLVzUxMkc3J3MKPiB2ZW5kb3IgYW5kIGRl
dmljZSBJRD8gIFF1aWNrIGdvb2dsaW5nIGFuc3dlcnMgaXQncyA4MDg2OmYxYTUsIGJ1dCBJIHdh
bnQKPiB0byBtYWtlIHN1cmUuCgpZZXMsIHRoYXQgaXMgY29ycmVjdC4KCjAxOjAwLjAgTm9uLVZv
bGF0aWxlIG1lbW9yeSBjb250cm9sbGVyIFswMTA4XTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNl
IFs4MDg2OmYxYTVdIChyZXYgMDMpCgpJJ2xsIHNlZSBpZiBJIGNhbiB0ZXN0IHRoaXMgdG9uaWdo
dCBvbiBteSBvdGhlciBOVk1Fcy4gSSBhbHNvIGR1ZyB1cCBhbiBvbGQKTlZNZSBkcml2ZSBmcm9t
IFRvc2hpYmE7IEknbGwgc2VlIGlmIEkgY2FuIGNvbm5lY3QgYW5kIHRlc3QgaXQgYXMgd2VsbC4K
ClsgLi4uIF0KCj4gPiA+ICAgICAgICAqLwo+ID4gPiAgICAgICBzd2l0Y2ggKGF0dHIpIHsKPiA+
ID4gICAgICAgY2FzZSBod21vbl90ZW1wX21heDoKPiA+ID4gLSAgICAgICAgICAgICAqdmFsID0g
KGRhdGEtPmN0cmwtPndjdGVtcCAtIDI3MykgKiAxMDAwOwo+ID4gPiArICAgICAgICAgICAgIGVy
ciA9IG52bWVfZ2V0X3RlbXBfdGhyZXNoKGRhdGEtPmN0cmwsIGNoYW5uZWwsIGZhbHNlLCB2YWwp
Owo+ID4gPiArICAgICAgICAgICAgIGlmIChlcnIpCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAqdmFsID0gKGRhdGEtPmN0cmwtPndjdGVtcCAtIDI3MykgKiAxMDAwOwo+ID4KPiA+IFRoaXMg
d291bGQgcmVwb3J0IFdDVEVNUCBmb3IgYWxsIHNlbnNvcnMgb24gZXJyb3JzLCBpbmNsdWRpbmcg
ZXJyb3JzIHNlZW4gd2hpbGUKPiA+IHRoZSBjb250cm9sbGVyIGlzIHJlc2V0dGluZy4gSSB0aGlu
ayBpdCBzaG91bGQgYmUgc29tZXRoaW5nIGxpa2UKPiA+Cj4gPiAgICAgICAgICAgICAgICAgaW50
IGVyciA9IDA7Cj4gPiAgICAgICAgICAgICAgICAgLi4uCj4gPgo+ID4gICAgICAgICAgICAgICAg
IGlmICghY2hhbm5lbCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSAoZGF0YS0+
Y3RybC0+d2N0ZW1wIC0gMjczKSAqIDEwMDA7Cj4gPiAgICAgICAgICAgICAgICAgZWxzZQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gbnZtZV9nZXRfdGVtcF90aHJlc2goZGF0YS0+
Y3RybCwgY2hhbm5lbCwgZmFsc2UsIHZhbCk7Cj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGVy
cjsKPiA+Cj4gPiBhc3N1bWluZyB3ZSBrZWVwIHVzaW5nIGN0cmwtPndjdGVtcCAoc2VlIGJlbG93
KS4gSWYgY2hhbmdpbmcgdGhlIHVwcGVyIENvbXBvc2l0ZQo+ID4gdGVtcGVyYXR1cmUgc2Vuc29y
IGxpbWl0IGNoYW5nZXMgd2N0ZW1wLCBhbmQgd2UgZG9uJ3QgdXBkYXRlIGl0LCB3ZSBzaG91bGQg
bm90Cj4gPiB1c2UgaXQgYXQgYWxsIGFmdGVyIHJlZ2lzdHJhdGlvbiBhbmQganVzdCByZXBvcnQg
dGhlIGVycm9yLgo+ID4KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ID4gKyAgICAg
Y2FzZSBod21vbl90ZW1wX21pbjoKPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gbnZtZV9nZXRf
dGVtcF90aHJlc2goZGF0YS0+Y3RybCwgY2hhbm5lbCwgdHJ1ZSwgdmFsKTsKPiA+ID4gICAgICAg
Y2FzZSBod21vbl90ZW1wX2NyaXQ6Cj4gPiA+ICAgICAgICAgICAgICAgKnZhbCA9IChkYXRhLT5j
dHJsLT5jY3RlbXAgLSAyNzMpICogMTAwMDsKPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsK
PiA+ID4gQEAgLTczLDYgKzExNywyMyBAQCBzdGF0aWMgaW50IG52bWVfaHdtb25fcmVhZChzdHJ1
Y3QgZGV2aWNlICpkZXYsIGVudW0gaHdtb25fc2Vuc29yX3R5cGVzIHR5cGUsCj4gPiA+ICAgICAg
IHJldHVybiBlcnI7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIGludCBudm1lX2h3bW9u
X3dyaXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5zb3JfdHlwZXMgdHlwZSwK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgYXR0ciwgaW50IGNoYW5uZWwsIGxv
bmcgdmFsKQo+ID4gPiArewo+ID4gPiArICAgICBzdHJ1Y3QgbnZtZV9od21vbl9kYXRhICpkYXRh
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gPiA+ICsKPiA+ID4gKyAgICAgc3dpdGNoIChhdHRy
KSB7Cj4gPiA+ICsgICAgIGNhc2UgaHdtb25fdGVtcF9tYXg6Cj4gPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIG52bWVfc2V0X3RlbXBfdGhyZXNoKGRhdGEtPmN0cmwsIGNoYW5uZWwsIGZhbHNlLCB2
YWwpOwo+ID4KPiA+IERvZXMgdGhpcyBjaGFuZ2UgV0NURU1QIGlmIHdyaXR0ZW4gb24gY2hhbm5l
bCAwID8gSWYgc28sIHdlIHdvdWxkIGhhdmUgdG8gdXBkYXRlCj4gPiB0aGUgY2FjaGVkIHZhbHVl
IG9mIGN0cmwtPndjdGVtcCAob3IgbmV2ZXIgdXNlIGl0IGFmdGVyIHJlZ2lzdHJhdGlvbikuCj4g
Cj4gQXQgbGVhc3QgZm9yIHRoZSBkZXZpY2VzIEkgaGF2ZSwgc2V0dGluZyB0aGUgb3ZlciB0ZW1w
ZXJhdHVyZSB0aHJlc2hvbGQKPiBkb2Vzbid0IGNoYW5nZSB0aGUgV0NURU1QLgo+IEkgaGF2ZSBj
aGVja2VkIHdpdGggICdudm1lIGlkLWN0cmwgL2Rldi9udm1lMCB8IGdyZXAgY3RlbXAnLgo+IAoK
SW50ZXJlc3RpbmcuIEkganVzdCB0ZXN0ZWQgdGhpcywgYW5kIHRoZSByZXN1bHQgaXMgdGhlIHNh
bWUgd2l0aCBTYW1zdW5nClNTRCA5NzAgRVZPLiBXaXRoIHRoYXQgaW4gbWluZCwgbWF5YmUgd2Ug
c2hvdWxkIHJlYWxseSBub3QgdXNlIHdjdGVtcAphdCBhbGwgYWZ0ZXIgaW5pdGlhbGl6YXRpb24s
IGFzIEkgaGFkIHN1Z2dlc3RlZCBhYm92ZS4gV2hhdCBkbyB5b3UgdGhpbmsgPwoKVGhhbmtzLApH
dWVudGVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
