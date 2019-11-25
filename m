Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D5C432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 19:06:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBCD2075C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aE8mLumY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8bWlsWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBCD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cmiJDQhcK37Ge0lVmEQMcV7f4EqS3w5bx+qczLM/yUM=; b=aE8mLumYfMTzLB
	66AiJFrfOAdT21uNG9D1vMZP45pzhS2xhjPvpApiO5hXWY/5SfxHwvSjZ5COEDe6VCDZjXuI7qXon
	CCSsop8WOoleOTbbdAMHCt3flXx3ZcUGVXDJKiP09Sug7PLJ1YHqcJuaWdK7IbvuVO8/XCFNayV2t
	cT8ci4cNEXpkiaTXy2dC22w3Mxk4DYJ4ueUug1kY6KptIpZZt7wbp2qTtBjL60salPxUaCG43sqs/
	/bZaoEeIj9g+6aBXTPBa2PIdxx9A7RCIYiwBVDDvDDKk07ircDiEGzj/BFzMDkjuiZKuSlqSyn1uk
	gstKZsApbgEKgFMplAiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZJgj-0004je-8z; Mon, 25 Nov 2019 19:06:21 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZJgf-0004jG-DB
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 19:06:20 +0000
Received: by mail-pf1-x442.google.com with SMTP id z4so7809932pfn.12
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 11:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LU40ef0rAaum+eK/P6tsM0HgubIoAsYgjhlVKN9TpQs=;
 b=C8bWlsWYOfJE+eaDIQUHKbAy1HyHWEp+OZ/BByrW20ecGjCJf5WF/yN00gZApPZRmB
 qH/iXLSeK3uUD0vFmXwb+9BOZhbaDZTxfIArmW7Czw/7CIaoqalB2saiWnFL8iDaSmd1
 87JBSvaUTYJIndOKi0bgn25mN6nGEd1/4ktZPPPNQgKWiH6Wfgh17guFFlT8govHRFU2
 jx8ObqaxOpQ9/OI8FaX0FyHZRSJcIe2NRTPE4DZry0Fzu4OP5XZuoGZtg9lDG1irZuzV
 54itsePORLKovCUk+ojFMyGeeJ/GM0Mr/PVqa57M8ukTWE4QNDnLwEVeAy3HpkJ06tFO
 7i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LU40ef0rAaum+eK/P6tsM0HgubIoAsYgjhlVKN9TpQs=;
 b=VU36rXm/h2DcgZfJ38THlp0LwLnCKcR131rPjOaxiSnxO7ba3po/86A7+1x0YVZHR6
 a5PERkgZGmOjJSOlJHLjo/diuxA6LQMTcajVNfG/w24GPqQKGF5wNUufarwSePbBjHr8
 wt3FqOaXlXhhUQd51LID44bBWUSrFvvVf7BXmM6OLPOyIQhPoR8dPO9e3FxZi0eYhavq
 xp+Bb7y6jsBaEWrFZLelCWfQ89JqkWpF8w7y8pDfu6J0lS0F4RmPnTmi8xpAt16a6JTA
 JaqlE2OcYSEySrGu4BqIw+0dRFgLtgR3ZMLbdDNJa1wxvVSSfL9VZhw7bKndgPBAXvhD
 7+bg==
X-Gm-Message-State: APjAAAV6w9o5OXScf8zHmRZGn3fx3EkKJPOGWJVF2/Emd+omqJ2bSE01
 pp7EOTQ1K2WId4hhCQy+kNnH+CFKqjbWCEn2j1Y=
X-Google-Smtp-Source: APXvYqy39ijvq81YlLmNNwHzlG7mr/+qq0TmYtKp519K+Bg6nnf0Ofs1DdS6b75x+HwFkKnFdO2IOzskZloIiG9tpJI=
X-Received: by 2002:a65:5542:: with SMTP id t2mr33354313pgr.74.1574708776962; 
 Mon, 25 Nov 2019 11:06:16 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
 <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
In-Reply-To: <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Nov 2019 21:06:06 +0200
Message-ID: <CAHp75VcODtDb8Y-6hrfqMtwSstn2DOYMSxNvdeG8VwYpUQ03uw@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: asus-wmi: switch to use
 <linux/temperature.h> helpers
To: Akinobu Mita <akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_110618_901438_BECBD7C5 
X-CRM114-Status: GOOD (  11.54  )
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

T24gTW9uLCBOb3YgMjUsIDIwMTkgYXQgNDozMiBQTSBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0
YUBnbWFpbC5jb20+IHdyb3RlOgo+IDIwMTnlubQxMeaciDI15pelKOaciCkgNDo1NCBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+Ogo+ID4gT24gU3VuLCBOb3YgMjQs
IDIwMTkgYXQgNDowOSBQTSBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+IHdy
b3RlOgoKPiA+ID4gLSAgICAgICB2YWx1ZSA9IERFQ0lfS0VMVklOX1RPX0NFTFNJVVMoKHZhbHVl
ICYgMHhGRkZGKSkgKiAxMDAwOwo+ID4gPiAtCj4gPiA+IC0gICAgICAgcmV0dXJuIHNwcmludGYo
YnVmLCAiJWRcbiIsIHZhbHVlKTsKPiA+Cj4gPiA+ICsgICAgICAgcmV0dXJuIHNwcmludGYoYnVm
LCAiJWxkXG4iLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgIGRlY2lfa2VsdmluX3RvX21p
bGxpY2Vsc2l1cyh2YWx1ZSAmIDB4RkZGRikpOwo+ID4KPiA+IExlYXZlIGl0IGluIG9uZSBsaW5l
Lgo+Cj4gSXQgY2F1c2VzIHRoaXMgbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMuCgpBbmQgSSBkb24n
dCBjYXJlLgoKPiAgT3IgZG8geW91IHByZWZlciB0byBzYXZlIHRoZQo+IGNvbnZlcnNpb24gcmVz
dWx0IGluICd2YWx1ZScgdGVtcG9yYXJpbHkgYXMgYmVmb3JlPwoKTm8uCgotLSAKV2l0aCBCZXN0
IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
