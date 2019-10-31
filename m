Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1F6CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858AF2080F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHZq3YMW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kClnC7uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858AF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=auE/h8saxstBvtbQ/Ho52MP+9RQCN+ZJrtIL3Bl/480=; b=sHZq3YMWHwByz0
	Shva294tmEqzSnGJ6iXnskQBY5DxGk0vs62Mjmc+27McqSashtymQqqidWT1DrSKKwO14JJCed/vq
	KoZalpBfcoasLgObB0cgUKXRIaJnTicwcNIJarHkA74fdfpvzt6XYAq/c1gDSHGd0o3wNRhh4hktl
	oFslgZVCPFPWiEy0wSQhnnTokQcfBljyLfxuoiRIyRrH4wZg8J3Ck3MFtOS06i2wC6ei4yQMtPtm3
	rknaOq3aBCuwXNlkarV1PWej80XvbX+YanaRpqIHBadFxM5pfmupcK891pnFRxExsWMACzTJ5TlC4
	WcDtzjWBbyuvtGDToX8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAkk-0007lY-JB; Thu, 31 Oct 2019 13:44:42 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAkh-0007l9-8K
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:44:40 +0000
Received: by mail-pl1-x642.google.com with SMTP id j12so777208plt.9
 for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2019 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6y88ku+FJUdhUiHptjPqtjsXAaLtim+0IMiXfQe0l/c=;
 b=kClnC7uqlGiwNBff2eaN3FaYdxv5GrMNnthtVrwqhPlHJljqFTEXJZzuIjlRIGFBN/
 lTW2cRQwEnuymUIsC1BdAnKUkxXQlyy4qUGLW7H+21IDwluFVOgB2NBYsA1gM43Ze5ck
 7zva61eyFN0Cb5wlXmYqEG9a2FqWIAugG+kLwktpwJybmZ5u58mo2L0uxgWR+lhJu3rW
 m53QcaXYV/ii8xvRpfWiQh0ZB3JvMaaX/VrBEl31nuUHf76qYKJcmz+EdaoD9DbyDxV1
 dtfYhutD2qWJ9ab9JKfYi9gd0k7nqLLeYC66WMUS2jjCfrDf8hb1rhzZRuuqiulY6b5P
 yfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6y88ku+FJUdhUiHptjPqtjsXAaLtim+0IMiXfQe0l/c=;
 b=CwEpvrkQyBZjhwMBzHkC8obWIMWwKNyYebPDvtX8JbJXV8UMof+KUG/9YJJ9TfMrNQ
 A5IyPsvZKGN3E+xJeYuMQKAmjVleWwWtN8lOnMhHtwgKBsMjXlZaVdqW5Sj6F68nK9/T
 uhe4FABVXN2OhYIaRNTPnTu4g0maxmrexBniL8Wi0/CWX+oPkHKcyUnMb4C1zAkztj/g
 dSiTFFiOeZeGXlhRIEL8xOqH5tImtfBzX1I2F60tJ7sNmJFIgpxbc5/O60/yQ9X1a0Hr
 QD8/4Zhk36068iaCQkmGMwtw0q4Ulpvc7cnE1mRBzBYx6CfHu1TFQ3KaHb/+o2apPFCL
 5WAg==
X-Gm-Message-State: APjAAAUXDdbLZZk6V86GMIXZ/h2zumNAYIstQ0EvxNubBLXGz0iOwjet
 n+e2rehLlty2OWVVXOru5vi/fO8Q1OlIPVPRTYQ=
X-Google-Smtp-Source: APXvYqyrzR6XIZRktDipu31wJpoWbBpvOQtSu9Q2KrNNdkdWl4+Sjukv611CtJUqK2iIR07BYZ5EvACGUByZf7+Yg3M=
X-Received: by 2002:a17:902:7786:: with SMTP id
 o6mr6654785pll.109.1572529477869; 
 Thu, 31 Oct 2019 06:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
In-Reply-To: <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 31 Oct 2019 22:44:26 +0900
Message-ID: <CAC5umygHEcVJQskfX0Ef4Z5Ti5B1-zKbmvvAbPPi4YtcQsV-WA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_064439_320736_1CED971F 
X-CRM114-Status: GOOD (  22.78  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEw5pyIMzHml6Uo5pyoKSAxMToyMCBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11
cy5uZXQ+Ogo+Cj4gT24gMTAvMzAvMTkgNDoxNiBBTSwgQWtpbm9idSBNaXRhIHdyb3RlOgo+ID4g
MjAxOeW5tDEw5pyIMzDml6Uo5rC0KSA3OjMyIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD46Cj4gPj4KPiA+PiBudm1lIGRldmljZXMgcmVwb3J0IHRlbXBlcmF0dXJlIGluZm9ybWF0
aW9uIGluIHRoZSBjb250cm9sbGVyIGluZm9ybWF0aW9uCj4gPj4gKGZvciBsaW1pdHMpIGFuZCBp
biB0aGUgc21hcnQgbG9nLiBDdXJyZW50bHksIHRoZSBvbmx5IG1lYW5zIHRvIHJldHJpZXZlCj4g
Pj4gdGhpcyBpbmZvcm1hdGlvbiBpcyB0aGUgbnZtZSBjb21tYW5kIGxpbmUgaW50ZXJmYWNlLCB3
aGljaCByZXF1aXJlcwo+ID4+IHN1cGVyLXVzZXIgcHJpdmlsZWdlcy4KPiA+Pgo+ID4+IEF0IHRo
ZSBzYW1lIHRpbWUsIGl0IHdvdWxkIGJlIGRlc2lyYWJsZSB0byB1c2UgTlZNRSB0ZW1wZXJhdHVy
ZSBpbmZvcm1hdGlvbgo+ID4+IGZvciB0aGVybWFsIGNvbnRyb2wuCj4gPj4KPiA+PiBUaGlzIHBh
dGNoIGFkZHMgc3VwcG9ydCB0byByZWFkIE5WTUUgdGVtcGVyYXR1cmVzIGZyb20gdGhlIGtlcm5l
bCB1c2luZyB0aGUKPiA+PiBod21vbiBBUEkgYW5kIGFkZHMgdGVtcGVyYXR1cmUgem9uZXMgZm9y
IE5WTUUgZHJpdmVzLiBUaGUgdGhlcm1hbCBzdWJzeXN0ZW0KPiA+PiBjYW4gdXNlIHRoaXMgaW5m
b3JtYXRpb24gdG8gc2V0IHRoZXJtYWwgcG9saWNpZXMsIGFuZCB1c2Vyc3BhY2UgY2FuIGFjY2Vz
cwo+ID4+IGl0IHVzaW5nIGxpYnNlbnNvcnMgYW5kL29yIHRoZSAic2Vuc29ycyIgY29tbWFuZC4K
PiA+Pgo+ID4+IEV4YW1wbGUgb3V0cHV0IGZyb20gdGhlICJzZW5zb3JzIiBjb21tYW5kOgo+ID4+
Cj4gPj4gbnZtZTAtcGNpLTAxMDAKPiA+PiBBZGFwdGVyOiBQQ0kgYWRhcHRlcgo+ID4+IENvbXBv
c2l0ZTogICAgKzM5LjDCsEMgIChoaWdoID0gKzg1LjDCsEMsIGNyaXQgPSArODUuMMKwQykKPiA+
PiBTZW5zb3IgMTogICAgICszOS4wwrBDCj4gPj4gU2Vuc29yIDI6ICAgICArNDEuMMKwQwo+ID4+
Cj4gPj4gU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pgo+
ID4+IC0tLQo+ID4+IHYyOiBVc2UgZGV2bV9rZnJlZSgpIHRvIHJlbGVhc2UgbWVtb3J5IGluIGVy
cm9yIHBhdGgKPiA+Pgo+ID4+ICAgZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZyAgICAgIHwgIDEw
ICsrCj4gPj4gICBkcml2ZXJzL252bWUvaG9zdC9NYWtlZmlsZSAgICAgfCAgIDEgKwo+ID4+ICAg
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgIHwgICA1ICsKPiA+PiAgIGRyaXZlcnMvbnZt
ZS9ob3N0L252bWUtaHdtb24uYyB8IDE2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+PiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgICB8ICAgOCArKwo+ID4+ICAg
NSBmaWxlcyBjaGFuZ2VkLCAxODcgaW5zZXJ0aW9ucygrKQo+ID4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbnZtZS9ob3N0L252bWUtaHdtb24uYwo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcgYi9kcml2ZXJzL252bWUvaG9zdC9LY29uZmlnCj4g
Pj4gaW5kZXggMmIzNmYwNTJiZmI5Li5hZWI0OWUxNmUzODYgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvS2NvbmZpZwo+ID4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25m
aWcKPiA+PiBAQCAtMjMsNiArMjMsMTYgQEAgY29uZmlnIE5WTUVfTVVMVElQQVRICj4gPj4gICAg
ICAgICAgICAgL2Rldi9udm1lWG5ZIGRldmljZSB3aWxsIHNob3cgdXAgZm9yIGVhY2ggTlZNZSBu
YW1lc3BhY2VzLAo+ID4+ICAgICAgICAgICAgIGV2ZW4gaWYgaXQgaXMgYWNjZXNzaWJsZSB0aHJv
dWdoIG11bHRpcGxlIGNvbnRyb2xsZXJzLgo+ID4+Cj4gPj4gK2NvbmZpZyBOVk1FX0hXTU9OCj4g
Pj4gKyAgICAgICBib29sICJOVk1FIGhhcmR3YXJlIG1vbml0b3JpbmciCj4gPj4gKyAgICAgICBk
ZXBlbmRzIG9uIChOVk1FX0NPUkU9eSAmJiBIV01PTj15KSB8fCAoTlZNRV9DT1JFPW0gJiYgSFdN
T04pCj4gPj4gKyAgICAgICBoZWxwCj4gPj4gKyAgICAgICAgIFRoaXMgcHJvdmlkZXMgc3VwcG9y
dCBmb3IgTlZNRSBoYXJkd2FyZSBtb25pdG9yaW5nLiBJZiBlbmFibGVkLAo+ID4+ICsgICAgICAg
ICBhIGhhcmR3YXJlIG1vbml0b3JpbmcgZGV2aWNlIHdpbGwgYmUgY3JlYXRlZCBmb3IgZWFjaCBO
Vk1FIGRyaXZlCj4gPj4gKyAgICAgICAgIGluIHRoZSBzeXN0ZW0uCj4gPj4gKwo+ID4+ICsgICAg
ICAgICBJZiB1bnN1cmUsIHNheSBOLgo+ID4+ICsKPiA+PiAgIGNvbmZpZyBOVk1FX0ZBQlJJQ1MK
PiA+PiAgICAgICAgICB0cmlzdGF0ZQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L01ha2VmaWxlIGIvZHJpdmVycy9udm1lL2hvc3QvTWFrZWZpbGUKPiA+PiBpbmRleCA4
YTRiNjcxYzVmMGMuLjAzZGU0Nzk3YTg3NyAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9NYWtlZmlsZQo+ID4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L01ha2VmaWxlCj4gPj4g
QEAgLTE0LDYgKzE0LDcgQEAgbnZtZS1jb3JlLSQoQ09ORklHX1RSQUNJTkcpICAgICAgICAgICAr
PSB0cmFjZS5vCj4gPj4gICBudm1lLWNvcmUtJChDT05GSUdfTlZNRV9NVUxUSVBBVEgpICAgICAr
PSBtdWx0aXBhdGgubwo+ID4+ICAgbnZtZS1jb3JlLSQoQ09ORklHX05WTSkgICAgICAgICAgICAg
ICAgICAgICAgICArPSBsaWdodG52bS5vCj4gPj4gICBudm1lLWNvcmUtJChDT05GSUdfRkFVTFRf
SU5KRUNUSU9OX0RFQlVHX0ZTKSAgICs9IGZhdWx0X2luamVjdC5vCj4gPj4gK252bWUtY29yZS0k
KENPTkZJR19OVk1FX0hXTU9OKSAgICAgICAgICs9IG52bWUtaHdtb24ubwo+ID4+Cj4gPj4gICBu
dm1lLXkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArPSBwY2kubwo+ID4+Cj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYwo+ID4+IGluZGV4IGZhN2JhMDlkY2E3Ny4uZmMxZDRiMTQ2NzE3IDEwMDY0NAo+ID4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ID4+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+ID4+IEBAIC0yNzk2LDYgKzI3OTYsOSBAQCBpbnQgbnZtZV9pbml0X2lkZW50
aWZ5KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gPj4gICAgICAgICAgY3RybC0+b25jcyA9IGxl
MTZfdG9fY3B1KGlkLT5vbmNzKTsKPiA+PiAgICAgICAgICBjdHJsLT5tdGZhID0gbGUxNl90b19j
cHUoaWQtPm10ZmEpOwo+ID4+ICAgICAgICAgIGN0cmwtPm9hZXMgPSBsZTMyX3RvX2NwdShpZC0+
b2Flcyk7Cj4gPj4gKyAgICAgICBjdHJsLT53Y3RlbXAgPSBsZTE2X3RvX2NwdShpZC0+d2N0ZW1w
KTsKPiA+PiArICAgICAgIGN0cmwtPmNjdGVtcCA9IGxlMTZfdG9fY3B1KGlkLT5jY3RlbXApOwo+
ID4+ICsKPiA+PiAgICAgICAgICBhdG9taWNfc2V0KCZjdHJsLT5hYm9ydF9saW1pdCwgaWQtPmFj
bCArIDEpOwo+ID4+ICAgICAgICAgIGN0cmwtPnZ3YyA9IGlkLT52d2M7Cj4gPj4gICAgICAgICAg
aWYgKGlkLT5tZHRzKQo+ID4+IEBAIC0yODk3LDYgKzI5MDAsOCBAQCBpbnQgbnZtZV9pbml0X2lk
ZW50aWZ5KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gPj4KPiA+PiAgICAgICAgICBjdHJsLT5p
ZGVudGlmaWVkID0gdHJ1ZTsKPiA+Pgo+ID4+ICsgICAgICAgbnZtZV9od21vbl9pbml0KGN0cmwp
Owo+ID4+ICsKPiA+PiAgICAgICAgICByZXR1cm4gMDsKPiA+Pgo+ID4+ICAgb3V0X2ZyZWU6Cj4g
Pgo+ID4gVGhlIG52bWVfaW5pdF9pZGVudGlmeSgpIGNhbiBiZSBjYWxsZWQgbXVsdGlwbGUgdGlt
ZSBpbiBudm1lIGN0cmwncwo+ID4gbGlmZXRpbWUgKGUuZyAnbnZtZSByZXNldCAvZGV2L252bWUq
JyBvciBzdXNwZW5kL3Jlc3VtZSBwYXRocyksIHNvCj4gPiBzaG91bGQgd2UgbmVlZCB0byBwcmV2
ZW50IG52bWVfaHdtb25faW5pdCgpIGZyb20gcmVnaXN0ZXJpbmcgaHdtb24KPiA+IGRldmljZSBt
b3JlIHRoYW4gdHdpY2U/Cj4gPgo+ID4gSW4gdGhlIG52bWUgdGhlcm1hbCB6b25lIHBhdGNoc2V0
WzFdLCB0aGVybmFsIHpvbmUgaXMgcmVnaXN0ZXJlZCBpbgo+ID4gbnZtZV9pbml0X2lkZW50aWZ5
IGFuZCB1bnJlZ2lzdGVyZWQgaW4gbnZtZV9zdG9wX2N0cmwoKS4KPiA+Cj4KPiBEb2Vzbid0IHRo
YXQgbWVhbiB0aGF0IHRoZSBpbml0aWFsaXphdGlvbiBzaG91bGQgaGFwcGVuIGluIG52bWVfc3Rh
cnRfY3RybCgpCj4gYW5kIG5vdCBoZXJlID8KClNlZW1zIHBvc3NpYmxlLiAgQnV0IEkgd291bGQg
bGlrZSB0byBhc2sgbWFpbnRhaW5lcnMnIG9waW5pb24uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
