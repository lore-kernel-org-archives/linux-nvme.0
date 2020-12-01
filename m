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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E6C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:05:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C800520857
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMBzfJE5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gquOn/Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C800520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tO/o5pcuf4H+wsD8asBNn3PUuBDduCUDg23UU9zmNyo=; b=nMBzfJE5YMV7oGWOfhhsZt6un
	XqxvULgOAD+J4aJi+h9yCt6df4K7czcRv9Oprdvx5ikBhttyYWvizYogfcWgtlXVy117UmBXY5Jge
	DliUs7H3ja23ynlGNVL2NGuL5AQ+JbU3Vs9YQcMEN42vi7HoJBs/gGv1JsQk7GWFAUWAJGGUApTSU
	F1AjWQiNRJpvm3/7dOGYyw+/0ogP5rMkIgcG0LqAIfspYbYMDDK60QZhCGHxfUAMuMBQz1PmxfAel
	ctCbisRoAEifAXX+sv1WPujT0brzgE6R4J4Tql7+nIPVYpsC7LC/wCvCYtKPc2C7B/3CQJi8rb8ex
	D1DFhjO+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk6Hq-0004h6-Lb; Tue, 01 Dec 2020 14:05:46 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk6Ho-0004g7-RL
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 14:05:45 +0000
Received: by mail-pj1-x1041.google.com with SMTP id hk16so1293319pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Qbc9MbzyU2rrGPS6kr7szf8duaLj3Tc36yZl5Cf5ftY=;
 b=gquOn/PaH3sQENvP10cBp2mfR/s43GYUAvK3nNzo3QspKXlgvPZTL0eECdWQZui6w6
 J/HHcOBBlCNEXlnoznM1F6Ogy8uR52PXWhwsq9TR3XF/3FKLQatoUaBakO5EkoiFfNbK
 ro6OZT3vDy8YSvL2vZ0qBxpltwEj1H/Wm7OtM40AOAfCDncrEQzkrayC0klGqrk8nqbb
 s1PeIDvoNZ5YsdhE+0bGv5QgYrJnm4sdzeuLdylGyJeGgdgi7iI+S9Bf3aMwP8dRNjmi
 0kjuTck6gN054i1S5q98SyMMPfi/L5Ay0JCoHtplfZtSNM3qgtWKiVxye5yZPXtbLtZc
 HDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Qbc9MbzyU2rrGPS6kr7szf8duaLj3Tc36yZl5Cf5ftY=;
 b=nlQBz4+Ui5tHTXsdyjCbxFVPkO8fglfVVPPBsEFdVgM0eKKdQ/rFNfYYn6Ljkcwy19
 eRZbqj3jUeMhWTlxfkQDte25hgvhvseJAtteFHvpDddOnjnjz/x6ZooPm5Pp6kxqrLN/
 VZgQ4rM5anYKd6+LzoEYWPIUwiLKSZA763i+g0qFB3xxwo9747nL3nRcpdmJ8vBTHga8
 eYh+CfDEdxvqQXlG+6pHQynHTso37gg1Uw4m6IEH0Ixi7Shozw4jqlHdOstvuKDe05AA
 1xUilEuA4SlYTFJOlOWECVtOKY99TXdLKnh0X6GW6k7r2/m/zvxD2JjkgXTKeUHSDCHx
 OORQ==
X-Gm-Message-State: AOAM532EHEL9ort4F5TEB2cy3/gKmXjNXYThnaLtY9C+6n9DELs/2V6y
 5OYaCyTyPhV/vav6nBdazIg=
X-Google-Smtp-Source: ABdhPJxxVmbJRBt8GpXCp9dnX1Sd91q8ua+WL3bDHTNbE+7xQwv61/exOpk9+1dfBmnSBs1c/lRBLw==
X-Received: by 2002:a17:90a:2d6:: with SMTP id
 d22mr2907206pjd.38.1606831542692; 
 Tue, 01 Dec 2020 06:05:42 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id k9sm2931093pfp.68.2020.12.01.06.05.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 06:05:42 -0800 (PST)
Date: Tue, 1 Dec 2020 23:05:39 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: javier@javigon.com
Subject: Re: [PATCH 2/4] nvme: rename controller base dev_t char device
Message-ID: <20201201140539.GC5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-3-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201125610.17138-3-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_090544_921144_0741EFF7 
X-CRM114-Status: GOOD (  11.97  )
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

SGVsbG8sCgpPbiAyMC0xMi0wMSAxMzo1NjowOCwgamF2aWVyQGphdmlnb24uY29tIHdyb3RlOgo+
IEZyb206IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+IAo+IFJl
bmFtZSBjb250cm9sbGVyIGJhc2UgZGV2X3QgY2hhciBkZXZpY2UgaW4gcHJlcGFyYXRpb24gZm9y
IGFkZGluZyBhCj4gbmFtZXNwYWNlIGNoYXIgZGV2aWNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEph
dmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgoKSSB0aGluayBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gZGVzY3JpYmUgdGhpbmdzIGFib3V0IGZvbGxvd2luZyBwYXRjaGVzCndo
aWNoIHJlcHJlc2VudCB3aHkgdGhpcyBraW5kIG9mIHJlbmFtaW5nIGlzIG5lZWRlZCBpbiB0aGlz
IHBhdGNoLgoKQW55d2F5LCBsb29rcyBnb29kIHRvIG1lLgoKUmV2aWV3ZWQtYnk6IE1pbndvbyBJ
bSA8bWlud29vLmltLmRldkBnbWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
