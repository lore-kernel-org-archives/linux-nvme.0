Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6336CC2D0C9
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 09:08:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38779206D8
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CqvKaadZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUrsMEMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38779206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YYMxDX/PFtHL8UJr1Pt9ryy6FzFU6PNpG4zD9EUL1yc=; b=CqvKaadZC3oZoi
	6RuhxHf1AlcyDKW7W/FZ+voLFxRHY5ZOxQ4y5T03qwFxedf1/wqG9OqZGjq1OANuEctKjI94IWErJ
	hdPmXtQPoEiW+v+8XZRrmKSIt6GdGKQfyS1WpusdUY0+dyD/oBIlOAxnoB2eKeCpIoKiELSLBr1FF
	35JtuNwwvk+1qLWAOY3TJ3YKxMBwutleJqQC+Y7pWcDStUcX76S8M42oKmI35/Lrgt0GMuRS4bRlJ
	qBma/ZKLers+wc09JRpl480KAuGB6ku+Jsu/0bv51jXyA3/9G3RjWxBmu+dtRAIzIcpfokZOXe6MP
	xg55aODAbASYk4ZUM/lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifgw7-0007Qj-6v; Fri, 13 Dec 2019 09:08:35 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifgw4-0007QK-Nv
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 09:08:34 +0000
Received: by mail-pg1-x542.google.com with SMTP id k3so1255310pgc.3
 for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2019 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RxPqLVLahzfTFPSjd2lbJPuyMQNKnrepmPG6ocYBcx4=;
 b=SUrsMEMb5l0PWA8gLMCZ1Chtvg3jnhwK2/vgh7F9R9In+qm04qH8UaVIXa50MCqpVK
 dnt7pnwdnNTCUOACxo9GxwGBfj7c6IRCGWMufFXGS1S2Ixgxe2tCl05gtQpMXclq3Q7/
 tGC7HF8nj8qtD/gejuVIjf28O6u3iYTCh2B9qZ0bLAzW82Puhx2GXsdjsGBSUeqwe1pn
 tuDg66dObvKLPKFwx1mV8T2MWzGWjSYShGj7U6cxllJlJbihWHbnfxqJAeIDpIfqOEMn
 A65cCdjjhsJOUldvAIpNcMeERAwRluWMptbaeEF3UiJq6qwZNR9kDDlfSNG8z6PdMxxi
 ATwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RxPqLVLahzfTFPSjd2lbJPuyMQNKnrepmPG6ocYBcx4=;
 b=YFfw4Jl4LcLDKQr5L9WkVvsP7EvgYe2z0/827zhiKEi5ldlNa9r5/UQyYW2yKpk9qC
 +M58de0r6GyfSHxaNIadhZ1wOCOSiUXp08Kirnhz8P1tSj0uB4yW44/aXalphlDOZF9l
 13xO7rTEitzphftBpyFpKPkow3LBW0gt6VeVUg6R+km0/ECeGryCwGR2Y/k3HyWsrhwF
 KirSEVbJ2E3jU2wOVLiv69kKWMCWBEelL2I38K0hilHJ85KoYKPValdbJtRlE9xU3D+c
 0/rCi0fadIswt9xXCI9k7wmVNX+QCgrDpWgyc2D0RJDDegy2DmI68jqo8W0cUH1iVGtj
 eNaw==
X-Gm-Message-State: APjAAAUxocJmy8oPJisfNwEmh5hy+xBPJu3Cg2IRj2pBkxtC1EaaM0gu
 vdmQKglK9SW5+0Sd5YYIBZtdFfi24lhjii2t7S8=
X-Google-Smtp-Source: APXvYqy7AOFT9gacPFy8fva2qjxrkgVB2Bc8boyHgJDbZ7PTWw6lUx6ECBqGHWTyq1Okaig8E2i7/9mXsCoNAO75THE=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr15392101pgk.74.1576228112226; 
 Fri, 13 Dec 2019 01:08:32 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
 <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
 <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
In-Reply-To: <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Dec 2019 11:08:22 +0200
Message-ID: <CAHp75VdhOgUt6rCMyJdM+NpweJbS7=Lrxf+KA+goiaj+xmNu-Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h>
 helpers
To: Akinobu Mita <akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191213_010832_780214_9D5E55D9 
X-CRM114-Status: GOOD (  11.86  )
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

T24gRnJpLCBEZWMgMTMsIDIwMTkgYXQgNjowMyBBTSBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0
YUBnbWFpbC5jb20+IHdyb3RlOgo+IDIwMTnlubQxMuaciDEy5pelKOacqCkgMDoyOSBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+Ogo+ID4gT24gV2VkLCBEZWMgMTEs
IDIwMTkgYXQgNDozOSBQTSBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+IHdy
b3RlOgoKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChjcnQgPiAwKSB7
Cj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBjcnRf
ayA9IENFTFNJVVNfVE9fREVDSV9LRUxWSU4oY3J0KTsKPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGNydF9rID0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNlbHNpdXNfdG9fZGVjaV9rZWx2aW4oY3J0KTsKPiA+
Cj4gPiBJdCB1c2VkIHRvIGJlIG9uZSBsaW5lLCB3aHkgZG8gdHdvPwo+Cj4gQmVjYXVzZSB0aGlz
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzLiAgVGhpcyBwYXRjaCBkb2Vzbid0IG1ha2UgdGhpcyBs
aW5lCj4gbG9uZ2VyLCBidXQgY2hlY2twYXRjaC5wbCBjb21wbGFpbnMgYWJvdXQgaXQuCgpJJ20g
bm90IGEgbWFpbnRhaW5lciBoZXJlLCBidXQgYXMgaXQgd2FzIGJlZm9yZSB3aHkgbm90IHRvIGxl
YXZlIGFzIGlzCihpbiB0ZXJtcyBvZiBsaW5lIGxlbmd0aCk/ClN1cHBvc2VkbHkgbWFpbnRhaW5l
cnMgYXJlIG9rYXkgd2l0aCBpdC4KCj4gPiA+ICAgICAgICAgcHJfaW5mbyhQUkVGSVggIiVzIFsl
c10gKCVsZCBDKVxuIiwgYWNwaV9kZXZpY2VfbmFtZShkZXZpY2UpLAo+ID4gPiAtICAgICAgICAg
ICAgICAgYWNwaV9kZXZpY2VfYmlkKGRldmljZSksIERFQ0lfS0VMVklOX1RPX0NFTFNJVVModHot
PnRlbXBlcmF0dXJlKSk7Cj4gPiA+ICsgICAgICAgICAgICAgICBhY3BpX2RldmljZV9iaWQoZGV2
aWNlKSwKPiA+ID4gKyAgICAgICAgICAgICAgIGRlY2lfa2VsdmluX3RvX2NlbHNpdXModHotPnRl
bXBlcmF0dXJlKSk7Cj4gPgo+ID4gRGl0dG8uCj4KPiBTYW1lIGFzIGFib3ZlLCBjaGVja3BhdGNo
LnBsIGNvbXBsYWlucyBhYm91dCBsaW5lIG92ZXIgODAgY2hhcmFjdGVycy4KClNhbWUgYXMgYWJv
dmUuCgpQLlMuIGNoZWNrcGF0Y2ggaXMgcmVjb21tZW5kYXRpb24sIGFuZCBub3Qgc29tZXRoaW5n
IG9uZSBtdXN0IGZvbGxvdy4KCi0tIApXaXRoIEJlc3QgUmVnYXJkcywKQW5keSBTaGV2Y2hlbmtv
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
