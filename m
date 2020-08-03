Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2965DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 15:03:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE8020775
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4e76wf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE8020775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9mxpM+n4epvDuxAKovHdWq/uHCkbLBU0CIu+EQD9K1c=; b=Z4e76wf8iZGuzozBrKQf7X+QW
	GTBNNNBlm6OYWwekzIyFip/AZr01fgvrhWZh7fVm3iSJsjBv2M4hR8S+WZIuxpy/Zx4CoWglhN1zJ
	u3WU93tcTijyI6LjujIx0rhIr36gf/mUsFBJ+P3iS4qaulB1/aFQBBpYKiLkGdr/kx9oR//iM1LX4
	w2RmXXc+52xnJJLQwOkpaKuTVAHhZjSUJ8kOw89tL3iJ20jOODH28QQfxHVo6slMlkxZKUiFc9gkb
	bMAneiw6fT5oCfPRLnMvTUsRPO1Wh451jwdLiOvo3dtdmoR3aoReoOUyMr4kzYj689fJXrU9FmjTz
	tGOYEIO2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2bzy-0006vP-12; Mon, 03 Aug 2020 15:03:34 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2bzi-0006uv-EF
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 15:03:20 +0000
Received: by mail-wm1-f44.google.com with SMTP id c19so198033wmd.1
 for <linux-nvme@lists.infradead.org>; Mon, 03 Aug 2020 08:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eff1ienRTz788VVG9RtArOjPyvtFHSuo97W4qvv1GgY=;
 b=bCtmU/lNd88U2LK/ZGL+i+l9u1vgdvC45BprLRwvu4zMt64zLVyik//Ly4jnlrC8yc
 TE5Mox98WbO1rFN3jES+7pyMVA3rVISPGP/COVZv15sN38AtTxNlbpIsUK3E0p5Vq59d
 d/QWVuCQSNgLtJFJTaiS/mY5LeaMhgR3SPdFxUU/nqq4C7n1DtVt/Qjz3rVtLWG4MVAQ
 VV8aaVHRntHfOwSEK69ARnlR5hI4KssFgWEI1FGhuwlpXbAZou71c8gHpR+3FOi+sqTb
 GMYyIAqRSTqU3LjQEbZtZuzkkB3J28w3+f3Iq2E8fBQMo5jkBnMLPO0n8SIkYVP0++/e
 Yshw==
X-Gm-Message-State: AOAM5315FzOEfpXXaKDG09/jTIPTKIy3i+NE4B3mI9Kti3q04FvhhcUE
 aWCS4CRFr4rIA/1OR2O3radpH4Xs
X-Google-Smtp-Source: ABdhPJyInf8OIOhDHNhR73FAHkwzakrsVJ8jlxjC7XC53PZZu8F32CI0q5niA8wcrRpHe/hyOLVr4Q==
X-Received: by 2002:a05:600c:2907:: with SMTP id
 i7mr369557wmd.182.1596466996918; 
 Mon, 03 Aug 2020 08:03:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6dac:e394:c378:553e?
 ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id i14sm30768372wrc.19.2020.08.03.08.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:03:16 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
Date: Mon, 3 Aug 2020 08:03:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_110318_529925_3EE5BDFA 
X-CRM114-Status: GOOD (  15.93  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEBAIC0xOTQ2LDYgKzE5NDcsMjIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfY21faGFuZGxl
cihzdHJ1Y3QgCj4+IHJkbWFfY21faWQgKmNtX2lkLAo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+
PiDCoCB9Cj4+ICtzdGF0aWMgdm9pZCBudm1lX3JkbWFfY29tcGxldGVfdGltZWRfb3V0KHN0cnVj
dCByZXF1ZXN0ICpycSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX3JlcXVlc3Qg
KnJlcSA9IGJsa19tcV9ycV90b19wZHUocnEpOwo+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JkbWFf
cXVldWUgKnF1ZXVlID0gcmVxLT5xdWV1ZTsKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX2N0
cmwgKmN0cmwgPSBxdWV1ZS0+Y3RybDsKPj4gKwo+PiArwqDCoMKgIC8qIGZlbmNlIG90aGVyIGNv
bnRleHRzIHRoYXQgbWF5IGNvbXBsZXRlIHRoZSBjb21tYW5kICovCj4+ICvCoMKgwqAgZmx1c2hf
d29yaygmY3RybC0+ZXJyX3dvcmspOwo+PiArwqDCoMKgIG52bWVfcmRtYV9zdG9wX3F1ZXVlKHF1
ZXVlKTsKPiBUaGVyZSBtYXliZSBjb25jdXJyZW50IHdpdGggZXJyb3IgcmVjb3ZlcnksIG1heSBj
YXVzZSBhYm5vcm1hbCBiZWNhdXNlCj4gbnZtZV9yZG1hX3N0b3BfcXVldWUgd2lsbCByZXR1cm4g
YnV0IHRoZSBxdWV1ZSBpcyBub3Qgc3RvcGVkLAo+IG1heWJlIGlzIHN0b3BwaW5nIGJ5IHRoZSBl
cnJvciByZWNvdmVyeS4KCmVycl93b3JrIGZsdXNoIHVzZWQgdG8gZmVuY2UsIG9uY2Ugd2UgZGlk
IHF1ZXVlIHN0b3AsIGl0IHNob3VsZCBiZSBzYWZlCnRvIGNvbXBsZXRlIHRoZSBjb21tYW5kIGZy
b20gdGhlIHRpbWVvdXQgaGFuZGxlci4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
