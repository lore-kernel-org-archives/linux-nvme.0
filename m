Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2274BC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 04:06:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7472077B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 04:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pRL9+loy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni2xtTjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7472077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JxPh+CkxpeTjH3QO3Dg0qQG1NdA1nR/vTX82c/GN+4M=; b=pRL9+loyZ4BtFF
	E0bB6p5DU0H0e/Q2tgzicOLo8PlLUbzPhv2lU/3ittkX3gkQZ4tc81yK5lNRfppCg3VHpe0fob4m1
	hQ9Aib8KFE8/zmrgEPrP9Vs77U1T22y/SPNkt84CsGduWtuhnwWu/ObNBs+nkYYx0qxGr9Dg2EjH9
	Babfzaely9ZOOiUEpFxvL17ihTr6Ll+GNK/KxcB2ioeJ5/5Hm57dUAGc82ipEruvCFUclvfciqNz6
	78y+yXZohUXClDHv7T7M3IjFzTslwKyAuMKvpuZnksEO1EuqI38HKRCblU4E/ediawf9ubYyJJtxG
	qCwPC1fQnBxrRDoWJpdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifcDa-0001mq-1a; Fri, 13 Dec 2019 04:06:18 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifcDX-0001mM-Cs
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 04:06:16 +0000
Received: by mail-lj1-x241.google.com with SMTP id h23so1070198ljc.8
 for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2019 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=URwD2kqbKtqHBmAr97llX1pKhl7DZxsGfB/7E5QLYGE=;
 b=ni2xtTjM+9tiMdl0vEVZN6oCJYd5JkmqYneP9rmdFfxSNkEaRNTnpDtUAPxhg/WkG2
 bkcQ+xCwU3likRm558tmzXfAvt+hvoTytoPU3MIOrbdLtLvmidkGbTvIm04/n6ZeT85X
 3xEf/wk45HDrPEj5DMysxfiNMrEZYPAFSya2j9VTgoc0bJQdq+P2lCsPoSKFd01V881b
 ooCAS1DF8X1cCO4GwWMohtH8hHF+7K4mJYFktzDdsPSii+EjZNaSc37bMgU6z0B9h8/g
 opfpUHJgMg/y+kTWNMp4tMhMGLKNOljlpF9vXqLJUYmQZWhYxz+dEuOyH2zld1Xq3CeY
 fzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=URwD2kqbKtqHBmAr97llX1pKhl7DZxsGfB/7E5QLYGE=;
 b=NVrijsFancj+fO7DEZEZqRCLMBrfuritFitAOwNFWPwxomSVsNaXTYdLuDBZdG5TrH
 PtCz7mQaEz3cMvJi1dlBHUFTkFYjMZF6+TmhplsJF7uIRxPwChOqeTM4SAFdMjH8AXGV
 bbGTMVrRF2rndJstnjNoEOF82ZUORKQL+nGy9htZOSZAlvSWxLezSKhwYCYbX2gRtG7i
 6s+/+swbjQxCD+wseJPo7HLxpWDQBPAj+gAgkzwiBxTDVi0HirXcivkv7m5kHrcF27nY
 PWSesnn76Oa68CEKMIxXkUSQU4wQf1Jd8tlPTSGJ8jeplBpcTsQ11eSb6jzeQHNoWCYm
 ZJMA==
X-Gm-Message-State: APjAAAU6OwCsr1Cn6/q3BdKkTKD15Ie29YadynAznGMIIdxTb4E51U0X
 sygEzsVuEUWSbAxPrjFivksIDIGgcL+52U+7W2A=
X-Google-Smtp-Source: APXvYqzu65JNr8Zns5VVeks/iQ8D6CeQ4H0T8PGRqqD+u82N39Gk52MLphGw89g9L21cri/7kJtnKuJByOQxugJm9Ls=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr7997476ljc.84.1576209973389; 
 Thu, 12 Dec 2019 20:06:13 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
In-Reply-To: <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 13 Dec 2019 13:06:02 +0900
Message-ID: <CAC5umygGZqWh2rRGMLvPhWFvD9Mv-5u6stY3c+5Z9_QC6OrNvA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_200615_438120_D61E0062 
X-CRM114-Status: GOOD (  14.58  )
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

MjAxOeW5tDEy5pyIMTLml6Uo5pyoKSAwOjMyIEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT46Cgo+Cj4gT24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgNDozOSBQTSBBa2lu
b2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IFRoZSBhc3Vz
LXdtaSBkcml2ZXIgZG9lc24ndCBpbXBsZW1lbnQgdGhlIHRoZXJtYWwgZGV2aWNlIGZ1bmN0aW9u
YWxpdHkKPiA+IGRpcmVjdGx5LCBzbyBpbmNsdWRpbmcgPGxpbnV4L3RoZXJtYWwuaD4ganVzdCBm
b3IgREVDSV9LRUxWSU5fVE9fQ0VMU0lVUygpCj4gPiBpcyBhIGJpdCBvZGQuCj4gPgo+ID4gVGhp
cyBzd2l0Y2hlcyB0aGUgYXN1cy13bWkgZHJpdmVyIHRvIHVzZSBkZWNpX2tlbHZpbl90b19taWxs
aWNlbHNpdXMoKSBpbgo+ID4gPGxpbnV4L3VuaXRzLmg+Lgo+Cj4gPiBAQCAtMzMsNyArMzMsNyBA
QAo+ID4gICNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kYXRhL3g4Ni9hc3VzLXdtaS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4KPiA+IC0jaW5jbHVkZSA8bGludXgvdGhlcm1hbC5oPgo+ID4gKyNpbmNsdWRl
IDxsaW51eC91bml0cy5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+Cj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2RtaS5oPgo+Cj4gU2ltaWxhciBjb21tZW50IGFib3V0IG9yZGVyaW5nLiBDYW4g
d2UgbW92ZSBpdCB0byB0aGUgZW5kIGFmdGVyIGRtaS5oPwoKT0suCgo+ID4gLSAgICAgICByZXR1
cm4gc3ByaW50ZihidWYsICIlZFxuIiwgdmFsdWUpOwo+Cj4gPiArICAgICAgIHJldHVybiBzcHJp
bnRmKGJ1ZiwgIiVsZFxuIiwKPgo+ICVkIC0+ICVsZCBtdXN0IGJlIGV4cGxhaW5lZCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UgKGUuZy4gImR1ZSB0bwo+IGZ1bmN0aW9uIHJldHVybmVkIHR5cGUpLgoK
T0suCgo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBkZWNpX2tlbHZpbl90b19taWxsaWNlbHNp
dXModmFsdWUgJiAweEZGRkYpKTsKPgo+IEkgcHJlZmVyIHRvIGhhdmUgdGhpcyBpbiBvbmUgbGlu
ZS4KCkl0IGNhdXNlcyBsaW5lIG92ZXIgODAgY2hhcmFjdGVycy4KV2UgaGFkIHRoZSBzYW1lIGNv
bnZlcnNhdGlvbiBpbiB2MSA6KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
