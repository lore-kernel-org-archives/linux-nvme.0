Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC22C432C2
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 04:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DBB222BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 04:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFnh3LEm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZhhkpvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DBB222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:To:References:
	Date:Subject:Mime-Version:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGoTBGCYgQZJ9DU6Wtl6tbGXSOsihdkSJo667mYsu8w=; b=eFnh3LEmGlGb2A
	i89EowibTSNEazQncF6f6yD83sydLuAwp0UbZ5+mdM12zB+NxXUE7tu01Z1f5JgVOB3LD3tHWkwWO
	7/XZBhe1iVlVfuSLbvr23U6FPvEfuvWiCrRyGVZ9ZIwIWCDmA0qWzGlUKk4FBEJm+69ab+cL/kMMR
	qe9wrDjVChAkR3iiDKyTZZry82IQ55mytfi+IGo0N8jyha7p2diIl7PgKkKOglBzuM1TnvpqtMvbo
	LiVWc7qwGr+YigeL/FH2BzjmSp/1tznlZ7vlzgjzchwiaSqA+3b+fgyjbC5YoH0xWFXG8LeuOikS3
	QzpKPII96VIgJBfsJugg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDLF5-0003wE-ES; Thu, 26 Sep 2019 04:18:59 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDLF2-0003vk-PG
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 04:18:58 +0000
Received: by mail-yb1-xb43.google.com with SMTP id v6so264342ybe.9
 for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2019 21:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:content-transfer-encoding:mime-version:subject:date:references
 :to:in-reply-to:message-id;
 bh=44G1JeQJx5fbXVgLL+w8FpdL0rpLuzCjpWItJDIrJTo=;
 b=uZhhkpvl/FakpewgRafBEEQy2BDrCP0aVOG2ZslaNlsCTJ0ANjrVrdXezbvsgmdY68
 BG0KeqPkRRVAUfto7ppB+SewT8Vf4biyEiNRhW0XaLsZFhxIFTBBeuq8cG+C8AxfShVy
 bH0EfdYwuCVvbZQVxf+XzFgxAIIwmzkzeAhVgxX3y7XFYjzsJFfRajR82IVoYNncm9VD
 3s+AQ8oI5umQv4JgWVNRqc6WXz0M+36UhmS6SOoNCV1nYt17W9fTHVShnXkEbY6Yq2CL
 hY5dcpa5NcGrkX+OjODNyDsTbUO5340lGp3oDV50loMS/r3gBhyESQjWo00ujSp2cdk3
 s18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:date:references:to:in-reply-to:message-id;
 bh=44G1JeQJx5fbXVgLL+w8FpdL0rpLuzCjpWItJDIrJTo=;
 b=pMkUZ/EWsoxUMDAVVApJ60y3G5Y1noMRcaXJHx/SG/7So1ZjYrL23vIIeypO8wptG2
 tmKgCfbWibj94lM7wVPSHk9ejUtaNu2v6P7s5ojlbEQND9JgjHVdZtfoQ5MqFdZBz4uu
 cv4iskg4RBAwQbva7NmUY/eBNyE2yWA+I3lRf4mYYLzZ/tVPzt/sGXrF6hq5r/Kx+tUb
 Q05e0VG+YINoRFMdyPIY4fkXxHdS4MvyPf35wIguJeK6BhzTntmKx+C/Xz5NAOlJVxcK
 l/WMMI0AGpgvRMA5h6BKT56NcbrASz0VXbou68T/sS0yuq53lJHEoREldqq9t4o2aq0B
 hnXg==
X-Gm-Message-State: APjAAAVQB035sXjCjdkAsf1kr758ZACIkZoMesPjXwjctJNZmrKmEQ99
 g+LEQY3kl5VQO00WjV5tw5dq4HDE
X-Google-Smtp-Source: APXvYqzbk40GrS/GvmjIg3GvF9rdpusGx1TVsaj84PS2ay10m5GhUPWF+dDaJ0Ich7v/BHbQkfLfsA==
X-Received: by 2002:a5b:34e:: with SMTP id q14mr689103ybp.52.1569471533027;
 Wed, 25 Sep 2019 21:18:53 -0700 (PDT)
Received: from [192.168.1.47] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
 by smtp.gmail.com with ESMTPSA id h136sm203800ywc.83.2019.09.25.21.18.52
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 21:18:52 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] nvme: Add ctrl attributes for queue_count and sqsize
Date: Wed, 25 Sep 2019 21:18:51 -0700
References: <20190926002023.14033-1-jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
In-Reply-To: <20190926002023.14033-1-jsmart2021@gmail.com>
Message-Id: <DF784B7A-C76E-40A9-8840-F38F5F80C570@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190925_211856_844528_19C6BC3F 
X-CRM114-Status: GOOD (  15.05  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIFNlcCAyNSwgMjAxOSwgYXQgNToyMCBQTSwgSmFtZXMgU21hcnQgPGpzbWFydDIwMjFA
Z21haWwuY29tPiB3cm90ZToKPiAKPiBDdXJyZW50IGNvbnRyb2xsZXIgaW50ZXJyb2dhdGlvbiBy
ZXF1aXJlcyBhIGxvdCBvZiBndWVzc3dvcmsKPiBvbiBob3cgbWFueSBpbyBxdWV1ZXMgd2VyZSBj
cmVhdGVkIGFuZCB3aGF0IHRoZSBpbyBzcSBzaXplIGlzLgo+IFRoZSBudW1iZXJzIGFyZSBkZXBl
bmRlbnQgdXBvbiBjb3JlL2ZhYnJpYyBkZWZhdWx0cywgY29ubmVjdAo+IGFyZ3VtZW50cywgYW5k
IHRhcmdldCByZXNwb25zZXMuCj4gCj4gQWRkIHN5c2ZzIGF0dHJpYnV0ZXMgZm9yIHF1ZXVlX2Nv
dW50IGFuZCBzcXNpemUuCj4gCj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIw
MjFAZ21haWwuY29tPgo+IAo+IC0tLQo+IHYyOgo+ICBVcGRhdGVkIGlzX3Zpc2libGUgdG8gbm90
IHNob3cgc3FzaXplIGF0dHJpYnV0ZSBvbiBwY2llIGNvbnRyb2xsZXJzCj4gLS0tCj4gZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jIHwgNiArKysrKysKPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IGUwZTJkY2JmZDA1ZS4uZDNjODVjNmQ5MjMwIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwo+IEBAIC0zMDQwLDYgKzMwNDAsOCBAQCBzdGF0aWMgREVWSUNFX0FUVFIo
ZmllbGQsIFNfSVJVR08sIGZpZWxkIyNfc2hvdywgTlVMTCk7Cj4gCj4gbnZtZV9zaG93X2ludF9m
dW5jdGlvbihjbnRsaWQpOwo+IG52bWVfc2hvd19pbnRfZnVuY3Rpb24obnVtYV9ub2RlKTsKPiAr
bnZtZV9zaG93X2ludF9mdW5jdGlvbihxdWV1ZV9jb3VudCk7Cj4gK252bWVfc2hvd19pbnRfZnVu
Y3Rpb24oc3FzaXplKTsKPiAKPiBzdGF0aWMgc3NpemVfdCBudm1lX3N5c2ZzX2RlbGV0ZShzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4gCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25z
dCBjaGFyICpidWYsCj4gQEAgLTMxMjAsNiArMzEyMiw4IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmli
dXRlICpudm1lX2Rldl9hdHRyc1tdID0gewo+IAkmZGV2X2F0dHJfYWRkcmVzcy5hdHRyLAo+IAkm
ZGV2X2F0dHJfc3RhdGUuYXR0ciwKPiAJJmRldl9hdHRyX251bWFfbm9kZS5hdHRyLAo+ICsJJmRl
dl9hdHRyX3F1ZXVlX2NvdW50LmF0dHIsCj4gKwkmZGV2X2F0dHJfc3FzaXplLmF0dHIsCj4gCU5V
TEwKPiB9Owo+IAo+IEBAIC0zMTMzLDYgKzMxMzcsOCBAQCBzdGF0aWMgdW1vZGVfdCBudm1lX2Rl
dl9hdHRyc19hcmVfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwKPiAJCXJldHVybiAwOwo+
IAlpZiAoYSA9PSAmZGV2X2F0dHJfYWRkcmVzcy5hdHRyICYmICFjdHJsLT5vcHMtPmdldF9hZGRy
ZXNzKQo+IAkJcmV0dXJuIDA7Cj4gKwlpZiAoIXN0cm5jbXAoY3RybC0+b3BzLT5uYW1lLCAicGNp
ZSIsIDQpICYmIGEgPT0gJmRldl9hdHRyX3Nxc2l6ZS5hdHRyKQo+ICsJCXJldHVybiAwOwo+IAo+
IAlyZXR1cm4gYS0+bW9kZTsKPiB9Cj4gLS0gCj4gMi4xMy43Cj4gCgpPayBzY3JhdGNoIHRoZSB2
MiAtIG9yaWdpbmFsIHBhdGNoIHdhcyBmaW5lLgoKVGhhbmtzCgrigJQgamFtZXMKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
