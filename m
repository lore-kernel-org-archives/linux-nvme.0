Return-Path: <SRS0=n1R8=2N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991BC2D0C0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 13:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA52220715
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ABGqtXDo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7FN0ncL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=orzgjKOI1VVPAESghoYhmooWnrTC/76bqbbKOvw3pF0=; b=ABGqtXDo8eUBKE
	EfgNqIx+ji0us4TnLQRlRxSAwAZUFV56Fz7PMu5L7v8+ESVc16KEsA/JcWykjbvsSM3uHSDO6cKUH
	siCX7+PLB5fcC512+eFavwiL/Qay64uclFFiqL8oMeezbruIaY/ODyBuyV7Q3e7+4FSNlKNyg18yN
	ecarJM5H6N6pAWUNatj5weY9P4wLNPbdQXUUB8hGFdzo8lLkuGcL+Tijpa7s/ZsEGcGY8ixMO+HzW
	nfhwklVKvgwrCICg6LQ4/OpQSP6bjxpR+2XP9N+0FyaOHNOIvsgD2OiTTPt8RJx3ttvMUKLyJeS5k
	EG76ehGdQPMag2niM9mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ijNRE-0001hf-Ri; Mon, 23 Dec 2019 13:07:56 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijNRC-0001hA-8K
 for linux-nvme@lists.infradead.org; Mon, 23 Dec 2019 13:07:55 +0000
Received: by mail-lf1-x142.google.com with SMTP id y1so12575048lfb.6
 for <linux-nvme@lists.infradead.org>; Mon, 23 Dec 2019 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5eJH2So2Y3KqY/K1ixMNRpaPpKx0b38bhcNlkypecC0=;
 b=N7FN0ncLXb065P3FN14ZDLucMWMpNKGbWPL84vdRLA17Kc3XtT8pnSKLjbseUPj918
 b9yDdgKBeG55jltDFLk9cDzyCHWPNVXrw4qoKL0NK/RoO24MAp8q04nFdEJcZpgaT5BF
 Q15J2JBVrmMrQx4zFr9FLZw/VeElcbpyV3hIkGOi1aH3of4W5V7Pz5pv99zVfEeU/F0K
 SoqCCo4ejdPWZ5XPiDBHIxGsbm8jsgy1f4YZ0a2rDR8r1ttquMOBRfzWSCRjKNS9W/oB
 PELHjv9r8rJchpunfS3Od1m02nbafGGlA5trUX/4PLKhVRONJM6uv5xUiPD//ox37mFL
 dK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5eJH2So2Y3KqY/K1ixMNRpaPpKx0b38bhcNlkypecC0=;
 b=gguqxqgeAX6dyK0PFb1/3eus73Up9ErPz6zCUk4LQjEDfznzTTgrjpQnZOhEI2vL42
 uBbXQF3+mI94DFTfppg71zRu76WYfxAZPQJgdDg24zsfV+ocmPZXGYmF6ngsYdFlA7rS
 Pu7yZwODVbjADfOMDrsGnKdx6lgcoCIn96b7qqPf3GUN04v7reDIljHkFVlhO785HC/I
 FmnwUsELty/bI9kjOe8YwWovToO07QPOSlP3svs8E7ZUSa+W7LtvtOff4txM2zpmEQfu
 3395fLgMmV0wZCzFGGhOr36SrzWk8/uw/3DXCEdsEaKs5KukwDCgn8siFEvql/daurRy
 j5rw==
X-Gm-Message-State: APjAAAV+Jd70A4OyX5ccx0ZdZdXRE4U/Y8Dm8VY59E2Vv1nUWK6WNfkP
 lPlAqdADr+HfeTmOY8OkzfKgOlEstKrL86BVMLu/u1U5hVU=
X-Google-Smtp-Source: APXvYqx35NtG2msl9BoMH2SPDevhyYA9MZsbmqBAxBohTRg/NXhM9CHIaYC1N0ZR9f0Dh28z9OhNSEDQtt4irLWQGH0=
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr16617018lfp.121.1577106471345; 
 Mon, 23 Dec 2019 05:07:51 -0800 (PST)
MIME-Version: 1.0
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 23 Dec 2019 22:07:39 +0900
Message-ID: <CAC5umygqpmb0s8zHC+TFEFffQmsU4N1hUs_XWGDLtqkJEccfBw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] add header file for kelvin to/from Celsius
 conversion helpers
To: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, 
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 linux-iio <linux-iio@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191223_050754_324502_756B5225 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Stanislaw Gruszka <sgruszka@redhat.com>,
 Luca Coelho <luciano.coelho@intel.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Christoph Hellwig <hch@lst.de>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Johannes Berg <johannes.berg@intel.com>,
 Intel Linux Wireless <linuxwifi@intel.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Andy Shevchenko <andy@infradead.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QW5kcmV3LAoKQ291bGQgeW91IHRha2UgYSBsb29rIGF0IHRoaXMgc2VyaWVzLCBhbmQgY29uc2lk
ZXIgaW5jbHVkaW5nIGludG8gLW1tIHRyZWU/CgoyMDE55bm0MTLmnIgxNeaXpSjml6UpIDE0OjE2
IEFraW5vYnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWlsLmNvbT46Cj4KPiBUaGVyZSBhcmUgc2V2
ZXJhbCBoZWxwZXIgbWFjcm9zIHRvIGNvbnZlcnQga2VsdmluIHRvL2Zyb20gQ2Vsc2l1cyBpbgo+
IDxsaW51eC90aGVybWFsLmg+IGZvciB0aGVybWFsIGRyaXZlcnMuICBUaGVzZSBhcmUgdXNlZnVs
IGZvciBhbnkgb3RoZXIKPiBkcml2ZXJzIG9yIHN1YnN5c3RlbXMsIGJ1dCBpdCdzIG9kZCB0byBp
bmNsdWRlIDxsaW51eC90aGVybWFsLmg+IGp1c3QgZm9yCj4gdGhlIGhlbHBlcnMuCj4KPiBUaGlz
IGFkZHMgYSBuZXcgPGxpbnV4L3VuaXRzLmg+IHRoYXQgcHJvdmlkZXMgdGhlIGVxdWl2YWxlbnQg
aW5saW5lCj4gZnVuY3Rpb25zIGZvciBhbnkgZHJpdmVycyBvciBzdWJzeXN0ZW1zLCBhbmQgc3dp
dGNoZXMgYWxsIHRoZSB1c2VycyBvZgo+IGNvbnZlcnNpb24gaGVscGVycyBpbiA8bGludXgvdGhl
cm1hbC5oPiB0byB1c2UgPGxpbnV4L3VuaXRzLmg+Cj4gaGVscGVycy4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
