Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCCC43215
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2596720740
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bs3ko2Ir";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH6P1Kq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2596720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jRzXwLYgP0yGWgRRAKoj7/fkdKrgGUZIKOK2zySeaUA=; b=Bs3ko2IrTWehzM
	SuRYk0G5hL+PUWaDaH+0grsiD7SdqVi0X8qT8ALc0tkAljXUzR2dppleMu4509AKNM6o05TBEge6l
	dcabcJAl65MjM1qyUGqxaQUYYgs1P+8vvKBKYMwQU2QTq5C/DUZ6gLJU7aBuWR8kXhXSVw5n1UXNu
	sHF4dD4EngMKHApqJMCobjki2/q/lKuzK1JzAVmf2EoqY5t+ERuGA4M4f8qxjsa5RJIp6J32fZWtZ
	lEjgUUj7muJ7z/BDy8s15VKdUrp7Lzq7493vjEe7G+ZYBZqxnuV6SsNSzYqWRP1dV75J9n6kGpkY1
	X833ht95ssbJLXY92n6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZFPO-0001r1-VL; Mon, 25 Nov 2019 14:32:10 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZFPM-0001qX-Nq
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 14:32:10 +0000
Received: by mail-lf1-x141.google.com with SMTP id 203so11166774lfa.12
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 06:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oGTTnKM0xwW7nj0x0MrfZUkr7TGce1cyBxrsce9fTz0=;
 b=kH6P1Kq2tBKFD4TQmcJWpSKJ6Hagdx11zVsv7mKgsiJXkYyHhoViKTtr3sadCGlZeL
 ehG6P1sCdCzZo3us3xttS17NdAC8JuBBBu2/iHQHjk8KzF1TRPEoa9TufBvSCutEj6SK
 DTxiSmYqOGBeDhSdnKY5GbiaPiWFTYTvf2gAf/wwtRybSNHMzyBBw40snnTXoxI4sRMI
 vzaeJsp/QYlJSyBYc4SrInm75e+vgf6lqgniLQF9GS50M7g9kv3GU6xrf0oHtXtlAHcb
 O1ZQEL9IRYyXdMr5mW0EVkKldcYv1mblryWchjlQGlCXJhYrUhbajFSRdHW0YGcxIxAf
 JO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oGTTnKM0xwW7nj0x0MrfZUkr7TGce1cyBxrsce9fTz0=;
 b=AAvnKg/cyweWU4dUOjFImm0m7c02Waqq6FSIei3Z+3VRB8rgfh/66SzoznuRlAfZih
 HNHLD/jVpJQtmHwk5+NK2tXXKwoM4dt3R3N0RtDvJzrWGYWfq0VDGVxn2U1wuQYV0X7N
 hMx2QkOvyD7xhHdHuWsQVinl0cglZo6+ucH/hwVws71fY2E1rdeJm7yKSsoa4rIq2Ujq
 zX+V49eTe0t26jYxQeVr1PNQg96t7f/xCQIB0H7LqYmkw4WWdh/XhYlVi87gQN/1w5W/
 Pk2FqdQFrNG4wmJcc4y9q6jL1BcvyJV0xPp+RtK5P+Y1DlZMgySU32IZky1hhnxdI+r9
 sShw==
X-Gm-Message-State: APjAAAVntoFWEemstbEA8T0gxCBgLKKIIH1ekBqRI7wSMixmOR7NRjw9
 wADpSVNcvr9w+OIRrjyRBHShwUvj1D87fyla3y0=
X-Google-Smtp-Source: APXvYqxEZzHQPIyjGRJIRceOVV99/gHLbc042Znh/KAbP8bMgC3AKDkjIZgHKxBU2iKFp3ecyEUrHxfT37I88etCPEI=
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr6024078lfi.98.1574692327003; 
 Mon, 25 Nov 2019 06:32:07 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
In-Reply-To: <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 25 Nov 2019 23:31:55 +0900
Message-ID: <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: asus-wmi: switch to use
 <linux/temperature.h> helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_063208_773274_8D71DA14 
X-CRM114-Status: GOOD (  18.37  )
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

MjAxOeW5tDEx5pyIMjXml6Uo5pyIKSA0OjU0IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT46Cj4KPiBPbiBTdW4sIE5vdiAyNCwgMjAxOSBhdCA0OjA5IFBNIEFraW5v
YnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhlIGFzdXMt
d21pIGRyaXZlciBkb2Vzbid0IGltcGxlbWVudCB0aGUgdGhlcm1hbCBkZXZpY2UgZnVuY3Rpb25h
bGl0eQo+ID4gZGlyZWN0bHksIHNvIGluY2x1ZGluZyA8bGludXgvdGhlcm1hbC5oPiBqdXN0IGZv
ciBERUNJX0tFTFZJTl9UT19DRUxTSVVTKCkKPiA+IGlzIGEgYml0IG9kZC4KPiA+Cj4gPiBUaGlz
IHN3aXRjaGVzIHRoZSBhc3VzLXdtaSBkcml2ZXIgdG8gdXNlIGRlY2lfa2VsdmluX3RvX21pbGxp
Y2Vsc2l1cygpIGluCj4gPiA8bGludXgvdGVtcGVyYXR1cmUuaD4uCj4gPgo+ID4gQ2M6IFN1aml0
aCBUaG9tYXMgPHN1aml0aC50aG9tYXNAaW50ZWwuY29tPgo+ID4gQ2M6IERhcnJlbiBIYXJ0IDxk
dmhhcnRAaW5mcmFkZWFkLm9yZz4KPiA+IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHlAaW5mcmFk
ZWFkLm9yZz4KPiA+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Cj4gPiBDYzog
RWR1YXJkbyBWYWxlbnRpbiA8ZWR1YmV6dmFsQGdtYWlsLmNvbT4KPiA+IENjOiBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KPiA+IENjOiBBbWl0IEt1Y2hlcmlhIDxh
bWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb20+Cj4gPiBDYzogSmVhbiBEZWx2YXJlIDxqZGVsdmFy
ZUBzdXNlLmNvbT4KPiA+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Cj4g
PiBDYzogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgo+ID4gQ2M6IEplbnMgQXhib2Ug
PGF4Ym9lQGZiLmNvbT4KPiA+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiA+
IENjOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+ID4gU2lnbmVkLW9mZi1ieTog
QWtpbm9idSBNaXRhIDxha2lub2J1Lm1pdGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYyB8IDcgKysrLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3Vz
LXdtaS5jCj4gPiBpbmRleCA4MjFiMDhlLi42YTFhMmY5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYwo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYv
YXN1cy13bWkuYwo+ID4gQEAgLTMzLDcgKzMzLDcgQEAKPiA+ICAjaW5jbHVkZSA8bGludXgvc2Vx
X2ZpbGUuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGF0YS94ODYvYXN1cy13bWku
aD4KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4gPiAtI2luY2x1ZGUg
PGxpbnV4L3RoZXJtYWwuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvdGVtcGVyYXR1cmUuaD4KPiA+
ICAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9kbWkuaD4KPiA+
Cj4gPiBAQCAtMTUxMiw5ICsxNTEyLDggQEAgc3RhdGljIHNzaXplX3QgYXN1c19od21vbl90ZW1w
MShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiAgICAgICAgIGlmIChlcnIgPCAwKQo+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gPgo+ID4gLSAgICAgICB2YWx1ZSA9IERFQ0lfS0VMVklO
X1RPX0NFTFNJVVMoKHZhbHVlICYgMHhGRkZGKSkgKiAxMDAwOwo+ID4gLQo+ID4gLSAgICAgICBy
ZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgdmFsdWUpOwo+Cj4gPiArICAgICAgIHJldHVybiBz
cHJpbnRmKGJ1ZiwgIiVsZFxuIiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgZGVjaV9rZWx2
aW5fdG9fbWlsbGljZWxzaXVzKHZhbHVlICYgMHhGRkZGKSk7Cj4KPiBMZWF2ZSBpdCBpbiBvbmUg
bGluZS4KCkl0IGNhdXNlcyB0aGlzIGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzLiAgT3IgZG8geW91
IHByZWZlciB0byBzYXZlIHRoZQpjb252ZXJzaW9uIHJlc3VsdCBpbiAndmFsdWUnIHRlbXBvcmFy
aWx5IGFzIGJlZm9yZT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
