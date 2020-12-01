Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3276C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:06:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A97B20705
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEY9hZtC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJDGOZ4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A97B20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0CIbgwNHaxJU/4pnqA/e0lsIj27AANg9t0wP4cYNahg=; b=hEY9hZtCQS0q5sCs0c28UrhkE
	NoOg0wB+d+/RydFapUr1psrz29oMuMr2Y3vfSrN96A06z3ouJlWL1T3fQeTKyqz448ko45r9Ectl8
	fFpZjRsH3PaQaY87yOHwfhUJ2FIebUmkoLSUwKVL2C9lS7yhtiYZkKvphYDfgxlZdqiqa4E2mXww2
	zKaEt2lTfax9poRh8j30Y4fuojyI9JFUvsFRgzjeNP46xnpQcNc8kW2VERafl50KDGmDPJffBUkBL
	cr4yBxRGaTBTCpJN5NpBGfZlZTMSdVUorOCTKnG/bUmx6KAeE5qJxuI0Ve4DolRs6Q7pc0Dtw6RiM
	vnOCGXGAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk6IH-0004s5-Bd; Tue, 01 Dec 2020 14:06:13 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk6ID-0004pf-6O
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 14:06:10 +0000
Received: by mail-pf1-x443.google.com with SMTP id b6so1175681pfp.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=RJKbvCtCn89+WUXWjU1z9Yx539VBEXROtVpS4goNlLk=;
 b=FJDGOZ4Qvrudqm68gElDVoV6oiMSb5ze3xk5W2oo3qullia/YsLT6+HubheMZwIrIa
 ugNl2w8UaF1YIluBTbgYuOtv6qD/M4I7rG4ggqSOOm7u6l4kYlSkpRXGmGAJr5BWBmcj
 B7rqmzQj4eJ0cZb7xTwNA2qGzsoOz0FPeMds36Issu6RbYXhsHg7kvrhk1zZOdJEWUnz
 e7d6uLtDkWOyDyhCAWxKe9li86zbNtm7oio21mPBVair4jrGsb7XstLuE01ol5nd/+Ce
 WURnV2aVUPjrfeF789bzqigsEf7JtA6sa28OlDzg3/MfUA1SjvLYcghkyMIUvnIF6OO4
 qiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=RJKbvCtCn89+WUXWjU1z9Yx539VBEXROtVpS4goNlLk=;
 b=q2qew/OejQ7IKgX3lzMvzgdyMKU9E7gKTLstIu7PaOoQeZHEBLCtwXNT1bLk6IOqYH
 ZQavtEmj0QM/kV2qxZ4tGLPMMdUThnWIq19FJ+/hLhb9UFdGdiCH5zqU1fjX3medlTGe
 rhWRVEFh7HU1h33mGs3SsoXk3StcY8yssRF0FDAbirM7re+RyCczDwwlUkjgwgVhrPrq
 6HaHCl3OFBGtZOrDd+BYgPyFRfJu0DhU/2cZGKZwGzELLBpSOpNWiL4rM4N/LyN56tqG
 wLvQTgzWmCp1at3ENmG9nHOElW1S6JO588Nw4cIxkf1pNjYo4TCYg6tSj4xtN2yE7bMK
 D/hQ==
X-Gm-Message-State: AOAM531SC7GOu2llZauAeEksSos1Miz6ADvfSOwlUM2Vk1tBCDhH/8v7
 tVdWPxRXeurd3xRzTY83s60=
X-Google-Smtp-Source: ABdhPJxn24nY6ZYllJ97s6NwTgIspwOqhwmEvHFf3+nm/2dgFoXtYVz6UcGpoTx3YXcuPk1nzlEyuA==
X-Received: by 2002:a62:e901:0:b029:197:ca81:4bb9 with SMTP id
 j1-20020a62e9010000b0290197ca814bb9mr2875492pfh.26.1606831567265; 
 Tue, 01 Dec 2020 06:06:07 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id k17sm2836342pji.50.2020.12.01.06.06.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 06:06:06 -0800 (PST)
Date: Tue, 1 Dec 2020 23:06:03 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: javier@javigon.com
Subject: Re: [PATCH 3/4] nvme: rename bdev operations
Message-ID: <20201201140603.GD5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-4-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201125610.17138-4-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_090609_814486_CB473FE8 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpPbiAyMC0xMi0wMSAxMzo1NjowOSwgamF2aWVyQGphdmlnb24uY29tIHdyb3RlOgo+
IEZyb206IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+IAo+IFJl
bWFuZSBibG9jayBkZXZpY2Ugb3BlcmF0aW9ucyBpbiBwcmVwYXJhdGlvbiB0byBhZGQgY2hhciBk
ZXZpY2UgZmlsZQo+IG9wZXJhdGlvbnMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrD
oWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpSZXZpZXdlZC1ieTogTWlud29vIEltIDxt
aW53b28uaW0uZGV2QGdtYWlsLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
