Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88EEC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 04:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFFD2077B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 04:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaLaRBuT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBHRZju2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFFD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TIYgumTqwDUIhRm0+3Y0hikTBP3b7Lc77dzj92lQoJk=; b=GaLaRBuTJ6m+xj
	59NXne8wPrHQYexvx38/vVINWH+k7HwiECkaauYoeomVk2to3nCQy4cLZaFVPMH4WTrYQwvwNt27H
	CDIJVt+9RTY9KRpk2JAFNQGp6gwpSKCr+lVzoDlome2uBPigcWFQcvO9vFqAC5/QxVZrEoiFhQZQU
	fdriKsj1h6d2wgstX851Rs3iFwXon7dFeEjhYx64CluLFjSVMl2A7bVIAYh/8bfBxYLFkfXm4iAuQ
	lPMdpWArVJo0dJrJDbiOvciGTkcY+gyFAqIHWBFcunpmcahkkCYvWcg/obtZ0/YTIJgirjfQIInRt
	Z362fDMY3Q7L5bOPy2iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifcB0-0000KN-0n; Fri, 13 Dec 2019 04:03:38 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifcAw-0000Jh-39
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 04:03:36 +0000
Received: by mail-lj1-x243.google.com with SMTP id z17so1036657ljk.13
 for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2019 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L5uQwSQlRWVR2cnkqQftE5urW2BObiyzOTOXDSJ+kFg=;
 b=vBHRZju2P7wqsFDu1I1BrVyl+TSGW35FeBwccHGI55Ahuh9KF8JP9UfIsjVabDT7nn
 nujCbqKj1GAKOvoOd7SKsrlGZsmvp7L/egqhgp95a1uWh0lZDyEZi107UHEVlU47UIA6
 BgiLT6CGjfAHTlFKfefaQ2CGduDv992dpZuu1PE4LnXPOGepgDswA+bzQyWxBfEm5a8o
 d0hZAPnC1UIZ6toRqaiWvJi5Rct5Ky/ofx1UZ8CtMmqzigDliaNhSW4Figad2GmHimo1
 7KUBJf1qydJXa2Ml3/Z586FTYUw1VeemQkwx9SJBVJSxGC7/97fZUwow82uvGjez+AzZ
 yNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L5uQwSQlRWVR2cnkqQftE5urW2BObiyzOTOXDSJ+kFg=;
 b=rxcNtxMjsX/Webv/odptXxCFDoBAEDDkUwE+Z5gGQMI34yXCsoR/v0SbChG3xTEFh4
 +pApcFWXBGaXHgBg9sDRwQdbfleIGQaIpF4Kj51ylIGUicEZDhjuscC31NrcgqmmbQxi
 SLoVKt2Snlrz+3nheSLaMkxchtFVgVNpiLZKKYwQqOHldksL5vc37uABiF/rMMrGPi1k
 ROlDzDhnCteufjhu5MA23Ra0PkkthPUZ877XeYLQFOYmVeIHldqaJ3Rv6/yeSjOOD/Td
 5ufYhRVvlKCxWBdHO58VohD4Sog/RS6AqO5pL5qJMP6gvOFkPo8F0SRZUbG5Z31jd5t8
 n0YQ==
X-Gm-Message-State: APjAAAXGL94DPV4/DPhXIBNvBzSZ980meK1IlJvyGBxGOUR3udzfkAY2
 cuXr/G1tMHFbsnIzYMDSodzRZrYk6ivQ7QYsj3M=
X-Google-Smtp-Source: APXvYqyT8v8iAkBDf8j+50bdcZNss1V7LWKa6r0wn8vjpJJcFL0sE3pcZPl7nzaBuH2jdvozf4gysX5sLdUJRv/KSFs=
X-Received: by 2002:a05:651c:29b:: with SMTP id
 b27mr7973573ljo.31.1576209811384; 
 Thu, 12 Dec 2019 20:03:31 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
 <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
In-Reply-To: <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 13 Dec 2019 13:03:19 +0900
Message-ID: <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h>
 helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_200334_158012_9444FBD9 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: linux-hwmon@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux PM <linux-pm@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Guenter Roeck <linux@roeck-us.net>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEy5pyIMTLml6Uo5pyoKSAwOjI5IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT46Cj4KPiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCA0OjM5IFBNIEFraW5v
YnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBzd2l0
Y2hlcyB0aGUgQUNQSSB0aGVybWFsIHpvbmUgZHJpdmVyIHRvIHVzZSBjZWxzaXVzX3RvX2RlY2lf
a2VsdmluKCksCj4gPiBkZWNpX2tlbHZpbl90b19jZWxzaXVzKCksIGFuZCBkZWNpX2tlbHZpbl90
b19taWxsaWNlbHNpdXNfd2l0aF9vZmZzZXQoKSBpbgo+ID4gPGxpbnV4L3VuaXRzLmg+IGluc3Rl
YWQgb2YgaGVscGVycyBpbiA8bGludXgvdGhlcm1hbC5oPi4KPiA+Cj4gPiBUaGlzIGlzIHByZXBh
cmF0aW9uIGZvciBjZW50cmFsaXppbmcgdGhlIGtlbHZpbiB0by9mcm9tIENlbHNpdXMgY29udmVy
c2lvbgo+ID4gaGVscGVycyBpbiA8bGludXgvdW5pdHMuaD4uCj4KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvcmVib290Lmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4gICNpbmNsdWRl
IDxsaW51eC90aGVybWFsLmg+Cj4KPiA+ICsjaW5jbHVkZSA8bGludXgvdW5pdHMuaD4KPgo+IENh
biB3ZSB0cnkgdG8ga2VlcCAqc29tZSogb3JkZXIsIGkuZS4gcHV0IHRoaXMgYWZ0ZXIgYWNwaS5o
IGJlbG93PwoKT0suCgo+ID4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+Cj4gPiAgI2luY2x1ZGUg
PGxpbnV4L3dvcmtxdWV1ZS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+Cj4KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoY3J0ID4gMCkgewo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGNydF9rID0gQ0VMU0lVU19U
T19ERUNJX0tFTFZJTihjcnQpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIGNydF9rID0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjZWxzaXVzX3RvX2RlY2lfa2VsdmluKGNydCk7Cj4KPiBJdCB1c2VkIHRvIGJlIG9u
ZSBsaW5lLCB3aHkgZG8gdHdvPwoKQmVjYXVzZSB0aGlzIGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJz
LiAgVGhpcyBwYXRjaCBkb2Vzbid0IG1ha2UgdGhpcyBsaW5lCmxvbmdlciwgYnV0IGNoZWNrcGF0
Y2gucGwgY29tcGxhaW5zIGFib3V0IGl0LgoKPiA+ICAgICAgICAgcHJfaW5mbyhQUkVGSVggIiVz
IFslc10gKCVsZCBDKVxuIiwgYWNwaV9kZXZpY2VfbmFtZShkZXZpY2UpLAo+ID4gLSAgICAgICAg
ICAgICAgIGFjcGlfZGV2aWNlX2JpZChkZXZpY2UpLCBERUNJX0tFTFZJTl9UT19DRUxTSVVTKHR6
LT50ZW1wZXJhdHVyZSkpOwo+ID4gKyAgICAgICAgICAgICAgIGFjcGlfZGV2aWNlX2JpZChkZXZp
Y2UpLAo+ID4gKyAgICAgICAgICAgICAgIGRlY2lfa2VsdmluX3RvX2NlbHNpdXModHotPnRlbXBl
cmF0dXJlKSk7Cj4KPiBEaXR0by4KClNhbWUgYXMgYWJvdmUsIGNoZWNrcGF0Y2gucGwgY29tcGxh
aW5zIGFib3V0IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
