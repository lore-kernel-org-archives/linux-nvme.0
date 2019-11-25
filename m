Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C3DC43215
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 19:05:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2BD2075C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gc+sMQ6I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJO2LxWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2BD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=isMuXiF1C1m91zeKGngxJDjHnXXEepS/BnwGeVjSVGU=; b=gc+sMQ6I23pVWD
	w6Jpi09b55Std8H4qjsuD6o/omAfgw0OeuX5/2VQ6LjYPhchFPbF/xdSUsEfhBBwL25DeKZ7u6lrE
	nbOV0wFViZ6yGeHfHDeXk9gk8ySH3KO42vpGfsAUFXq8LkJtKBxSCtqty48Fi4Ci154ERCiPf7qDB
	lxDg4RVvaysJ/8uXEIU6beulqCsfp6kr9N71SId/sHss35Gr9B+V8XB3WEnbqrWbPrjKlGNqnOvBy
	H7KbvVEiHodk8dpPrfzHYiuqgk0zkxR4NP8fULoZvt9EYSnUsSiMzLUUx5kmwC+g1XToK9V3hslgc
	44x92/ZrlLlC5Xnkscvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZJfe-0004Up-0v; Mon, 25 Nov 2019 19:05:14 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZJfb-0004UB-KO
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 19:05:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id s10so6913474plp.2
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P19DovHn3w/+n6hilY5zf6aVHKgMGVjkSijfGR+10vI=;
 b=SJO2LxWfQL/RpUPwjCS4HFD6Zi0CFuImYwngKnX2+isiSOQFMhpKZ9dY7m7ErmqtG4
 u8Ew0Quvr1Acigrzp5DqDA33h/fhbBej0bLLtoOm5gDL6ZBBDzASZkK57S4r97WCAUXv
 1kdCIwBr+MtYS4zQmwDjV39T7kR7KNCkvSsrsqnGn/RZtQGEgxclKTjXLcVc0+QlBA8/
 f2OJbsWGWbWcMTTgc86WqTPtoGq/x3aRQUZUATAjf061M9A4fWfzPoEwYDbAmVPYwZZh
 hdK+LgsacNAMnrFVgGKN0l0g8z5n1Wqe46FZrR+84JSKZupFL3Pm9iu8TlcA8gX7ZayR
 lA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P19DovHn3w/+n6hilY5zf6aVHKgMGVjkSijfGR+10vI=;
 b=cEWwoMd6/QYY5qOragoG4O46kB4xe3YBYcnl4eyTu8BFwWg2V9J/hdypUenG/e6xKi
 +EFSkLCwtCSgMnixki51YgIv3erQJJnKDfjB/+/mUFW9d1cvtxmHf78IYZT0tVrUaTuj
 xkLs7wU9uHhPhCI0DNOZM2ff3rTmgHeUDpb3MWFXKwG4GXc5n/dmV2DHUFsDADezkE6F
 0j1y2YemLU4BTgwpF68TdhHtgC/7wT2V3cenUe1+ScyuJ/mzQ9UBU2BvwdkDII09Yw4o
 m0l49UiUyRgcInwm7iAHql+huB0Izo8DC9ldfjcjoYNljCIfWvrz49xyT5CnMstQ0RyM
 y5sw==
X-Gm-Message-State: APjAAAWvTDJHIp8/LA3vEJcKjk9EretGfS4aN0Er5WfQFCXdHyvt/fch
 8hHioTRLYH7+wgib/zfnOgc60VyhHAy5M6VqUvI=
X-Google-Smtp-Source: APXvYqzb9QDOJ3vCeMWuto+UJ4Y/4ebOOkTH+Cb5IJCRGIdMR80O9owbytFNwFLnJBA3iU/X2miKDbF+Jt3xD0q+HaQ=
X-Received: by 2002:a17:902:bb84:: with SMTP id
 m4mr29810736pls.255.1574708710742; 
 Mon, 25 Nov 2019 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
 <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
In-Reply-To: <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Nov 2019 21:05:00 +0200
Message-ID: <CAHp75VdXUKLrnPEnga7An7BnCoGac=XxgWESWyV-ShmK_xiD4g@mail.gmail.com>
Subject: Re: [PATCH 1/8] add header file for kelvin to/from Celsius conversion
 helpers
To: Akinobu Mita <akinobu.mita@gmail.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_110511_694503_B3170936 
X-CRM114-Status: GOOD (  14.82  )
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
 Linux PM <linux-pm@vger.kernel.org>, Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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

T24gTW9uLCBOb3YgMjUsIDIwMTkgYXQgNDozMCBQTSBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0
YUBnbWFpbC5jb20+IHdyb3RlOgo+IDIwMTnlubQxMeaciDI05pelKOaXpSkgMjM6NTcgQW5keSBT
aGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjoKPiA+IE9uIFN1biwgTm92IDI0
LCAyMDE5IGF0IDQ6MDkgUE0gQWtpbm9idSBNaXRhIDxha2lub2J1Lm1pdGFAZ21haWwuY29tPiB3
cm90ZToKCj4gPiA+ICBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgfCAgMSArCgo+ID4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3Ro
ZXJtYWwuaAo+ID4gPiBAQCAtMTQsNiArMTQsNyBAQAo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2lk
ci5oPgo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4gPiAgI2luY2x1ZGUgPGxp
bnV4L3N5c2ZzLmg+Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvdGVtcGVyYXR1cmUuaD4KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4KPiA+ID4gICNpbmNsdWRlIDx1YXBpL2xpbnV4
L3RoZXJtYWwuaD4KPiA+Cj4gPiBJIGRvbid0IHNlZSBhbnkgdXNlcnMgb2YgaXQuIFdoeSBkaWQg
eW91IGluY2x1ZGU/Cj4KPiBUaGUgcmVzdCBvZiB0aGlzIHBhdGNoIHNlcmllcyBzdGFydHMgdXNp
bmcgaXQuCj4KPiBJIGRlY2lkZWQgdG8gaW5jbHVkZSA8bGludXgvdGVtcGVyYXR1cmUuaD4gZnJv
bSA8bGludXgvdGhlcm1hbC5oPiBiZWNhdXNlCj4gdGhlIGV4aXN0aW5nIDxsaW51eC90aGVybWFs
Lmg+IHByb3ZpZGVzIHRoZSBjb252ZXJzaW9uIGhlbHBlcnMuCj4KPiBIb3dldmVyLCBub3QgYWxs
IG9mIHRoZSB0aGVybWFsIGRyaXZlcnMgcmVxdWlyZSB0aGVzZSBjb252ZXJzaW9uIGhlbHBlcnMs
Cj4gc28gd2UgY2FuIGNoYW5nZSB0byBpbmNsdWRlIDxsaW51eC90ZW1wZXJhdHVyZS5oPiBmcm9t
IGVhY2ggdGhlcm1hbCBkcml2ZXIKPiBpbnN0ZWFkIG9mIGluY2x1ZGluZyBpdCBmcm9tIDxsaW51
eC90aGVybWFsLmg+Lgo+Cj4gV2hpY2ggd2F5IGRvIHlvdSBwcmVmZXI/CgpJIHRoaW5rIHVzZXJz
IHNob3VsZCBpbmNsdWRlIG5ldyBoZWFkZXIgZXhwbGljaXRseS4KCi0tIApXaXRoIEJlc3QgUmVn
YXJkcywKQW5keSBTaGV2Y2hlbmtvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
