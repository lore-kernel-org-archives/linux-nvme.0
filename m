Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5420C3524A
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:11:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43E120732
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FOazFyb7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx/YInbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43E120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zuX+Izy6OG6b8xNF9+N4SXIyARorv4kXNOXOyW89NpA=; b=FOazFyb7TAUQWX
	7xtrVjorcaRqqIcu9rCDg+cJkBMa7GKMc5RqJUc2lLrN01vNyFk9xNm+wcuvAXmcAAQ6wjGmOMIq7
	J3h96eHDJF0k3YT4aQ52PEKAcRiVzIB5WQg0yidcOm5iG6KAK8InrtycDaTPCmoupk8MAeyB/b3OG
	L5zl0+LBCXV5VKsFH8AJJKjbdYSYirc9OqtE40sxoNaaLh8oGn6FDVoXOHSTjhVhOO9cZd36T71uk
	V4cwmpNhcUAp1GNRnn1RW2qrSmkiGAdWXcH+KZqQmTP/xEnMQS81sbzv76nCv/ZEjxdUFZ++PFZng
	mYi+siE1a1dJePIwXzPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyocm-0004KI-EL; Tue, 04 Feb 2020 03:11:40 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyock-0004Ji-01
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 03:11:39 +0000
Received: by mail-qk1-x742.google.com with SMTP id u19so8873255qku.8
 for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2020 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AQPvBn3+mpVQXLNFO7ln9Q3PQvFlywhORrkpfNdpRp4=;
 b=lx/YInbrNokwp5yZHxjAiGDoPWM9E2DKV37xld9nufJgcj4+Tu1yfL43ucz5nevePk
 LnNz27D4HpwIJGOaTtk8C0MnOYpbcXav3fJZY1FTPUOUG1wd2ISFOdZw4aXORQ0UotB3
 aPQMrXfuZ9/XNp4AIJOLGII5exFcPoOrViq9q3w3ZpzwInKdATwSVGJjkuJJyU6XRao4
 Y/ce3+O/FdwAZchKSzYBNHF22kFxA7zs3yzQfoJnOmxc+h6c/dZPdPxpon6xN25l17HF
 UyJS4pIwV5OLOvhsvCt4lMEbafQFOGDHUXmz8sdLPFUjMFAtgWdOkMEVYcwKUhSU7XO6
 wLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AQPvBn3+mpVQXLNFO7ln9Q3PQvFlywhORrkpfNdpRp4=;
 b=ZaenMtVHI+IHIdQQjQMhRtn6G+hZKocQbjDwoNkgCGpCuEXmQHP5I4BNLi/XGHaCSk
 wjGZZmlieCIpcd6fZtsFvyLqDTUljKF/eGKEOEIZEDqkdncFBAIgs+iB7/iiEbrY/4F8
 4dDn/mhXr/l413mEXGW2gLsPvl+5rcR4oj5BmIWOSjyf9DlZ9pFT9RyPZiLzEmHCUTEv
 bhJijWpwNVle/2EbqOhWg9uHb25XVGV2xibzf/ySCPkzJLiwM39s9oHe83343m0SNxMM
 4q6KRd6ddWoVCJCvI9S1rFcIRzYLMcvgGcgC9ut3piTgVc0ONfB7w6qIcMe4piyZCNTw
 vkWA==
X-Gm-Message-State: APjAAAVrXFMPVF2ryQBMbt0iaVL7316p5v7HIX48vga3PxMmPPmdWQk+
 T//1INLUzF6V8NmPj+8tgqdIO+odQ5NK6uI+bwQ=
X-Google-Smtp-Source: APXvYqwLxRaEyV3jwYdLDHu21TDE2JoYFeQudgfpqPsVtLg1JHeGtIi431wOJ0Z8XJYxLgSzUWQB3rh7Kr+aDHb0gag=
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr27537827qkm.430.1580785896457; 
 Mon, 03 Feb 2020 19:11:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580211965.git.zhangweiping@didiglobal.com>
 <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
 <871rrevfmz.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rrevfmz.fsf@nanos.tec.linutronix.de>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Tue, 4 Feb 2020 11:11:25 +0800
Message-ID: <CAA70yB7ThwiaGFkM6J-cja4OcD0oH_6KTwH7vpmp9mVG0Xte4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous
 affinity set
To: Thomas Gleixner <tglx@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_191138_065276_04D0DDDC 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, Minwoo Im <minwoo.im.dev@gmail.com>,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IOS6jjIwMjDlubQy5pyIMeaXpeWR
qOWFrSDkuIvljYg1OjE55YaZ6YGT77yaCj4KPiBXZWlwaW5nIFpoYW5nIDx6aGFuZ3dlaXBpbmdA
ZGlkaWdsb2JhbC5jb20+IHdyaXRlczoKPgo+ID4gbnZtZSBkcml2ZXIgd2lsbCBhZGQgNCBzZXRz
IGZvciBzdXBwb3J0aW5nIE5WTWUgd2VpZ2h0ZWQgcm91bmQgcm9iaW4sCj4gPiBhbmQgc29tZSBv
ZiB0aGVzZSBzZXRzIG1heSBiZSBlbXB0eShkZXBlbmRzIG9uIHVzZXIgY29uZmlndXJhdGlvbiks
Cj4gPiBzbyBlYWNoIHBhcnRpY3VsYXIgc2V0IGlzIGFzc2lnbmVkIG9uZSBzdGF0aWMgaW5kZXgg
Zm9yIGF2b2lkaW5nIHRoZQo+ID4gbWFuYWdlbWVudCB0cm91YmxlLCB0aGVuIHRoZSBlbXB0eSBz
ZXQgd2lsbCBiZSBiZWVuIGJ5Cj4gPiBpcnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCkuCj4KPiBX
aGF0J3MgdGhlIHBvaW50IG9mIGFuIGVtcHR5IGludGVycnVwdCBzZXQgaW4gdGhlIGZpcnN0IHBs
YWNlPyBUaGlzIGRvZXMKPiBub3QgbWFrZSBzZW5zZSBhbmQgc21lbGxzIGxpa2UgYSByZWFsbHkg
YmFkIGhhY2suCj4KPiBDYW4geW91IHBsZWFzZSBleHBsYWluIGluIGRldGFpbCB3aHkgdGhpcyBp
cyByZXF1aXJlZCBhbmQgd2h5IGl0Cj4gYWN0dWFsbHkgbWFrZXMgc2Vuc2U/Cj4KSGkgVGhvbWFz
LApTb3JyeSB0byBsYXRlIHJlcGx5LCBJIHdpbGwgcG9zdCBuZXcgcGF0Y2ggdG8gYXZvaWQgY3Jl
YXRpbmcgZW1wdHkgc2V0cy4KSW4gdGhpcyB2ZXJzaW9uLCBudm1lIGFkZCBleHRyYSA0IHNldHMs
IGJlY2F1c2UgbnZtZSB3aWxsIHNwbGl0IGl0cwppbyBxdWV1ZXMgaW50byA3IHBhcnRzIChwb2xs
LCBkZWZhdWx0LCByZWFkLCB3cnJfbG93LCB3cnJfbWVkaXVtLAp3cnJfaGlnaCwgd3JyX3VyZ2Vu
dCksCnRoZSBwb2xsIHF1ZXVlcyBkb2VzIG5vdCB1c2UgaXJxLCBzbyBudm1lIHdpbGwgaGFzIGF0
IG1vc3QgNiBpcnEgc2V0cy4KQW5kIG52bWUgZHJpdmVyIHVzZQp0d28gdmFyaWFibGVzKGRldi0+
aW9fcXVldWVzW2luZGV4XSBhbmQgYWZmZC0+c2V0X3NpemVbaW5kZXhdKSB0bwp0cmFjayBob3cg
bWFueSBxdWV1ZXMvaXJxcwppbiBlYWNoIHBhcnQuIEFuZCB0aGUgdXNlciBtYXkgc2V0IHNvbWUg
cXVldWVzIGNvdW50IHRvIDAsIGZvciBleGFtcGxlOgpudm1lIHVzZSA5NiBpbyBxdWV1ZXMuCgpk
ZWZhdWx0CmRldi0+aW9fcXVldWVzWzBdPTkwCmFmZmQtPnNldF9zaXplWzBdID0gOTAKCnJlYWQK
ZGV2LT5pb19xdWV1ZXNbMV09MAphZmZkLT5zZXRfc2l6ZVsxXSA9IDAKCndyciBsb3cKZGV2LT5p
b19xdWV1ZXNbMl09MAphZmZkLT5zZXRfc2l6ZVsyXSA9IDAKCndyciBtZWRpdW0KZGV2LT5pb19x
dWV1ZXNbM109MAphZmZkLT5zZXRfc2l6ZVszXSA9IDAKCndyciBoaWdoCmRldi0+aW9fcXVldWVz
WzRdPTYKYWZmZC0+c2V0X3NpemVbNF0gPSA2Cgp3cnIgdXJnZW50CmRldi0+aW9fcXVldWVzWzVd
PTAKYWZmZC0+c2V0X3NpemVbNV0gPSAwCgpJbiB0aGlzIGNhc2UgdGhlIGluZGV4IGZyb20gMSB0
byAzIHdpbGwgaGFzIDAgaXJxcy4KCkJ1dCBhY3R1YWxseSwgaXQncyBubyBuZWVkIHRvIHVzZSBm
aXhlZCBpbmRleCBmb3IgaW9fcXVldWVzIGFuZCBzZXRfc2l6ZSwKbnZtZSBqdXN0IHRlbGxzIGly
cSBlbmdpbmUsIGhvdyBtYW55IGlycV9zZXRzIGl0IGhhcywgYW5kIGhvdyBtYXkgaXJxcwppbiBl
YWNoIHNldCwKc28gaSB3aWxsIHBvc3QgVjUgdG8gc29sdmUgdGhpcyBwcm9ibGVtLgogICAgICAg
IG5yX3NldHMgPSAxOwogICAgICAgIGRldi0+aW9fcXVldWVzW0hDVFhfVFlQRV9ERUZBVUxUXSA9
IG5yX2RlZmF1bHQ7CiAgICAgICAgYWZmZC0+c2V0X3NpemVbbnJfc2V0cyAtIDFdID0gbnJfZGVm
YXVsdDsKICAgICAgICBkZXYtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVfUkVBRF0gPSBucl9yZWFkOwog
ICAgICAgIGlmIChucl9yZWFkKSB7CiAgICAgICAgICAgICAgICBucl9zZXRzKys7CiAgICAgICAg
ICAgICAgICBhZmZkLT5zZXRfc2l6ZVtucl9zZXRzIC0gMV0gPSBucl9yZWFkOwogICAgICAgIH0K
ICAgICAgICBkZXYtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVfV1JSX0xPV10gPSBucl93cnJfbG93Owog
ICAgICAgIGlmIChucl93cnJfbG93KSB7CiAgICAgICAgICAgICAgICBucl9zZXRzKys7CiAgICAg
ICAgICAgICAgICBhZmZkLT5zZXRfc2l6ZVtucl9zZXRzIC0gMV0gPSBucl93cnJfbG93OwogICAg
ICAgIH0KICAgICAgICBkZXYtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVfV1JSX01FRElVTV0gPSBucl93
cnJfbWVkaXVtOwogICAgICAgIGlmIChucl93cnJfbWVkaXVtKSB7CiAgICAgICAgICAgICAgICBu
cl9zZXRzKys7CiAgICAgICAgICAgICAgICBhZmZkLT5zZXRfc2l6ZVtucl9zZXRzIC0gMV0gPSBu
cl93cnJfbWVkaXVtOwogICAgICAgIH0KICAgICAgICBkZXYtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVf
V1JSX0hJR0hdID0gbnJfd3JyX2hpZ2g7CiAgICAgICAgaWYgKG5yX3dycl9oaWdoKSB7CiAgICAg
ICAgICAgICAgICBucl9zZXRzKys7CiAgICAgICAgICAgICAgICBhZmZkLT5zZXRfc2l6ZVtucl9z
ZXRzIC0gMV0gPSBucl93cnJfaGlnaDsKICAgICAgICB9CiAgICAgICAgZGV2LT5pb19xdWV1ZXNb
SENUWF9UWVBFX1dSUl9VUkdFTlRdID0gbnJfd3JyX3VyZ2VudDsKICAgICAgICBpZiAobnJfd3Jy
X3VyZ2VudCkgewogICAgICAgICAgICAgICAgbnJfc2V0cysrOwogICAgICAgICAgICAgICAgYWZm
ZC0+c2V0X3NpemVbbnJfc2V0cyAtIDFdID0gbnJfd3JyX3VyZ2VudDsKICAgICAgICB9CiAgICAg
ICAgYWZmZC0+bnJfc2V0cyA9IG5yX3NldHM7CgpUaGFua3MKV2VpcGluZwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
