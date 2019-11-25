Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494EEC432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DF1207FD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 14:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="relQ/9Lv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIdutctR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DF1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/ZaJ/Wtq/zerF6bHWoocpBcTZPMdq4HQ5j/mGG+RD4=; b=relQ/9LvvijfFp
	Qk+pqpja07m9QZ9mYjo/ICUDHJt0rSfEpBoLo+KX5XeNyoHP+DVaOpew/EFxtI0kvDp5bVgDbGe+b
	S3oSXuA+MjYZPHkFfZPvVky5tTj0HwKlEDe8VPJ4ro+3Xd8HAF58IcxH7K6SI+SeCZ09iU7/s6WDE
	HHE+ChJC+yUHAzZmxuQC646kAO64zsczuPBw+QctPB3JjlkozphxtCnfZvRQOIGm4DKXz8J+9BOxZ
	aiPw8zPkZ2mvL0yxPyBlqfmSTubMt09VA9KeUDN7BcYy+AquwtqMiKIcJ7Ja3RJ1sokIitcFT+i/V
	Ieq1kdGxv/TQxZe96sCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZFOW-0001WL-6O; Mon, 25 Nov 2019 14:31:16 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZFOT-0001Vl-CU
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 14:31:14 +0000
Received: by mail-lf1-x143.google.com with SMTP id v24so11180426lfi.7
 for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2019 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WJcL6zJlFuqqleMc2SkLefhJBqvomh77ELiAskEiwdQ=;
 b=JIdutctR8IGj0nY1GGFA1Nq9c87pfVEoit1PdYDo/pucpBPAiji50N0+eqzrWGReAH
 L5uzVZ6rMcd1FbkUZulHYKl1RixdeGyaXul59/1oyq/kPLmGckhYHYGlqdTsFDL0/3TW
 3JdVfKYUVAAR0fnwmNNEidkvFN1DQyolIrAwhXwCaJL3Yknlll5eOTSlTY7ir4jNNHlu
 d77dyp5tyvy3Fnke+HFu517JmSDHr8sl0nXEBMwS46ZctA0FF/kza+YAxW3azNbDiOaM
 0hJ6swR/nWe9Es/0nuuEcqNW2Rh4JvCAF/fhs/lYLH3LkySw4/ggx1dIKAmDB2cUK3e1
 3afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WJcL6zJlFuqqleMc2SkLefhJBqvomh77ELiAskEiwdQ=;
 b=GBxSE2catUqTzy3X0TI99xHSe7inQ2rUh0AYamMSmO7L0a9XqcSS7m500Ti3ysChaN
 W7CphbaZY3GEorUqz5wdc6UTIMJhfbGVl640TGTeEC6TnnfYH7PjGC/h2xdxxXTo/nK/
 udPpX9PyCIyvN2OLwZZlBaiHTSL6ojJEfTkaroPQv+8Edi0ElSaS6Ovmcfk4qs4Z6GOu
 j7uSM9alf1Y3HxKFMt2We4GilQIpL3X0ZJKBZctgJaYUBxB/IIkdz/Hw1jgijO8XZJwM
 yxvPXZTwg/CMZTsTTH5rdJMyDRMilHwvmUf1pcr1cjjvqkFsrPGDKbZ//q0N7Y6D5rem
 aIJg==
X-Gm-Message-State: APjAAAWq3A2B9D4iKdsac/FnSMK/t1EdqPTETDn/1VC/YvSHHwVi3Q4L
 hyZgYNr5iYqOC1XECkGVIaemE+Af2vh+PCWwrVM=
X-Google-Smtp-Source: APXvYqxXUiBF72dN+bSBfP+dVzJMyJQkB60RLYR3XrsVNUjjUY9fqHd5g80b2368oc2at00TYuTPqWhSDRZ3kyYJLlw=
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr11281925lfm.29.1574692271621; 
 Mon, 25 Nov 2019 06:31:11 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-3-git-send-email-akinobu.mita@gmail.com>
 <00fff683-d0e2-67ae-83e3-c472fdbe9e1d@roeck-us.net>
In-Reply-To: <00fff683-d0e2-67ae-83e3-c472fdbe9e1d@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 25 Nov 2019 23:31:00 +0900
Message-ID: <CAC5umyh4Ay_PnFGp4fA0_VSimD_Bm-+xpVz56jZnd5bT239B8w@mail.gmail.com>
Subject: Re: [PATCH 2/8] ACPI: thermal: switch to use <linux/temperature.h>
 helpers
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_063113_427857_94000D47 
X-CRM114-Status: GOOD (  10.28  )
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
 LKML <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Eduardo Valentin <edubezval@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Christoph Hellwig <hch@lst.de>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMjXml6Uo5pyIKSAwOjE3IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD46Cj4KPiBPbiAxMS8yNC8xOSA2OjA4IEFNLCBBa2lub2J1IE1pdGEgd3JvdGU6Cj4gPiBU
aGlzIHN3aXRjaGVzIHRoZSBBQ1BJIHRoZXJtYWwgem9uZSBkcml2ZXIgdG8gdXNlIGNlbHNpdXNf
dG9fZGVjaV9rZWx2aW4oKQo+ID4gYW5kIGRlY2lfa2VsdmluX3RvX2NlbHNpdXMoKSBpbiA8bGlu
dXgvdGVtcGVyYXR1cmUuaD4gaW5zdGVhZCBvZiBoZWxwZXJzCj4gPiBpbiA8bGludXgvdGhlcm1h
bC5oPi4KPiA+Cj4gPiBUaGlzIGlzIHByZXBhcmF0aW9uIGZvciBjZW50cmFsaXppbmcgdGhlIGtl
bHZpbiB0by9mcm9tIENlbHNpdXMgY29udmVyc2lvbgo+ID4gaGVscGVycyBpbiA8bGludXgvdGVt
cHJhdHVyZS5oPi4KPiA+Cj4gcy90ZW1wcmF0dXJlL3RlbXBlcmF0dXJlLwo+Cj4gTG9va3MgbGlr
ZSB0aGlzIGFwcGxpZXMgdG8gYWxsIHBhdGNoZXMuCgpPb3BzLiAgSSdsbCBmaXggaW4gdGhlIG5l
eHQgdmVyc2lvbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
