Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E9CC432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466B6207FD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6EMetWC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZG2o2nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466B6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cz1RQeFobCgcKYfaArIZ/Nci0OvleTYpna8SWnqr0q0=; b=D6EMetWC6mfoNh
	2wYwndlRE1hE9X99pud0xSUEEXbw5WXfOxho2P6PWGNQtzUBD1rWAVRGzIV8kCerBIl7Us6NhanXN
	WNrHp1AA29XhdSnFVOynPpJGs+zdnaDvJgS2TCZqX/iLfLQYEH3ywcpvCpO2ny8YpMvNhftf0tI5z
	w/gGEetCcagrtq6FY5cLcfSK80j9N+6wNjoa5lpylFYOqVlHute34g4lruNuierCYV7TDN1yeNNmm
	sepuABCtSV6W0d10GBl9XVjBEEufm6t5+MfIAl9/Zg23FQmFkktO0Tr3Z6Up83vDWeDF//6glVFRf
	6NthrI/39y6EJEZKRvyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZFNW-0001Hq-SA; Mon, 25 Nov 2019 14:30:14 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZFNT-0001F1-Ma
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 14:30:13 +0000
Received: by mail-lf1-x142.google.com with SMTP id l14so11177744lfh.10
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LKjdexg+LkffG26VUSsNwV+tvqoIqAg7PNu5vMgemIs=;
 b=uZG2o2nYUojcIlyWe8PXU+6To4lKeOe9RblB9GWLBDHP0ROIwlChkyw0SKs6JtiR1f
 MD2l3RucqTGhVbOhYG1uBeE6ZOOh5kvcDBIIW2cMvMhIgT707IS2IweaA8uIIlMxwob4
 DAmhCFqI+PYiMm5hgaQ7NH9ImizHriobDG60zsBWOlJpMTIMpk23p6obVPnKF8D9Jd0w
 Msd9NGRiv37kIRGnA1gDRLcvLDRdl8ucZ9K+rextcluWC7tAWJIYhcuQ2TuAL99qtP0E
 /KglPy0CcvOGFbyFrFpEgQV034Asp79um1Jn3oKBEstlAvZsFeBNDmVdfz7fqdwJAI4u
 0TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LKjdexg+LkffG26VUSsNwV+tvqoIqAg7PNu5vMgemIs=;
 b=YxPKQe4pP9trb7ZSvThBdliBFwwugT2m3WP2GJF1x/PGgKcXooGgMGVy/ovHeoJvce
 7lMzW2w4oyGRxhcTZTCHPAIjTFyjCo5B2pyNPOSSG+ypd6GBpuXrQc5imEpcwWQ5O1lL
 22PCjCwx26KMxuEZCIcJzpvNvnKslTpv6M3ef9S4tr1BiukdJ6YdvqUfO7vOCJQIB8zj
 F8wsx3k6CApHdGJCae2yyoRCQj2L/XAGu5h/HaBpKRi2sGCJe7Wa6az9vk3hU9Q75oEB
 pxOvzlsOTepz2vSIt8eu5e9JgAh5pIBXusCIlv8tqy/lD8iHNh1KcRi2zqOmaTpyaTOy
 WB0w==
X-Gm-Message-State: APjAAAV4sVSqR2JzBzLUHYQwDsZpIaDyeb7qwNh+eovYaPVoewEi0ZdK
 nDIK7q6WTF3lRhUE1/scVVSOXcSdw8h89S1DiFYVcN6WYLE=
X-Google-Smtp-Source: APXvYqwNQ1gDP49zPYN8njc+j07Y/QD6fHpbzABV0vcBHhUVmveHtPabf233H4srJ1klzQkQ15yydwmm2QnzFdfBd1w=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr14985341lfh.64.1574692208081; 
 Mon, 25 Nov 2019 06:30:08 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
In-Reply-To: <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 25 Nov 2019 23:29:56 +0900
Message-ID: <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
Subject: Re: [PATCH 1/8] add header file for kelvin to/from Celsius conversion
 helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_063011_765091_EC03166F 
X-CRM114-Status: GOOD (  16.14  )
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
Cc: linux-hwmon@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMjTml6Uo5pelKSAyMzo1NyBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb20+Ogo+Cj4gT24gU3VuLCBOb3YgMjQsIDIwMTkgYXQgNDowOSBQTSBBa2lu
b2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IFRoZXJlIGFy
ZSBzZXZlcmFsIGhlbHBlciBtYWNyb3MgdG8gY29udmVydCBrZWx2aW4gdG8vZnJvbSBDZWxzaXVz
IGluCj4gPiA8bGludXgvdGhlcm1hbC5oPiBmb3IgdGhlcm1hbCBkcml2ZXJzLiAgVGhlc2UgYXJl
IHVzZWZ1bCBmb3IgYW55IG90aGVyCj4gPiBkcml2ZXJzIG9yIHN1YnN5c3RlbXMsIGJ1dCBpdCdz
IG9kZCB0byBpbmNsdWRlIDxsaW51eC90aGVybWFsLmg+IGp1c3QgZm9yCj4gPiB0aGUgaGVscGVy
cy4KPiA+Cj4gPiBUaGlzIGFkZHMgYSBuZXcgPGxpbnV4L3RlbXBlcmF0dXJlLmg+IHRoYXQgcHJv
dmlkZXMgdGhlIGVxdWl2YWxlbnQgaW5saW5lCj4gPiBmdW5jdGlvbnMgZm9yIGFueSBkcml2ZXJz
IG9yIHN1YnN5c3RlbXMuICBJdCBpcyBpbnRlbmRlZCB0byByZXBsYWNlIHRoZQo+ID4gaGVscGVy
cyBpbiA8bGludXgvdGhlcm1hbC5oPi4KPiA+Cj4gPiBDYzogU3VqaXRoIFRob21hcyA8c3VqaXRo
LnRob21hc0BpbnRlbC5jb20+Cj4gPiBDYzogRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQu
b3JnPgo+ID4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPgo+ID4gQ2M6
IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KPiA+IENjOiBFZHVhcmRvIFZhbGVudGlu
IDxlZHViZXp2YWxAZ21haWwuY29tPgo+ID4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6
Y2Fub0BsaW5hcm8ub3JnPgo+ID4gQ2M6IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAdmVy
ZHVyZW50LmNvbT4KPiA+IENjOiBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuY29tPgo+ID4g
Q2M6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4KPiA+IENjOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+Cj4gPiBDYzogSmVucyBBeGJvZSA8YXhib2VAZmIuY29tPgo+
ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+ID4gQ2M6IFNhZ2kgR3JpbWJl
cmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBa2lub2J1IE1pdGEgPGFr
aW5vYnUubWl0YUBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBpbmNsdWRlL2xpbnV4L3RlbXBlcmF0
dXJlLmggfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPgo+ID4g
IGluY2x1ZGUvbGludXgvdGhlcm1hbC5oICAgICB8ICAxICsKPgo+Cj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3RoZXJtYWwuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmgKPiA+IEBA
IC0xNCw2ICsxNCw3IEBACj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lkci5oPgo+ID4gICNpbmNsdWRl
IDxsaW51eC9kZXZpY2UuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvc3lzZnMuaD4KPiA+ICsjaW5j
bHVkZSA8bGludXgvdGVtcGVyYXR1cmUuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvd29ya3F1ZXVl
Lmg+Cj4gPiAgI2luY2x1ZGUgPHVhcGkvbGludXgvdGhlcm1hbC5oPgo+Cj4gSSBkb24ndCBzZWUg
YW55IHVzZXJzIG9mIGl0LiBXaHkgZGlkIHlvdSBpbmNsdWRlPwoKVGhlIHJlc3Qgb2YgdGhpcyBw
YXRjaCBzZXJpZXMgc3RhcnRzIHVzaW5nIGl0LgoKSSBkZWNpZGVkIHRvIGluY2x1ZGUgPGxpbnV4
L3RlbXBlcmF0dXJlLmg+IGZyb20gPGxpbnV4L3RoZXJtYWwuaD4gYmVjYXVzZQp0aGUgZXhpc3Rp
bmcgPGxpbnV4L3RoZXJtYWwuaD4gcHJvdmlkZXMgdGhlIGNvbnZlcnNpb24gaGVscGVycy4KCkhv
d2V2ZXIsIG5vdCBhbGwgb2YgdGhlIHRoZXJtYWwgZHJpdmVycyByZXF1aXJlIHRoZXNlIGNvbnZl
cnNpb24gaGVscGVycywKc28gd2UgY2FuIGNoYW5nZSB0byBpbmNsdWRlIDxsaW51eC90ZW1wZXJh
dHVyZS5oPiBmcm9tIGVhY2ggdGhlcm1hbCBkcml2ZXIKaW5zdGVhZCBvZiBpbmNsdWRpbmcgaXQg
ZnJvbSA8bGludXgvdGhlcm1hbC5oPi4KCldoaWNoIHdheSBkbyB5b3UgcHJlZmVyPwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWls
aW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
