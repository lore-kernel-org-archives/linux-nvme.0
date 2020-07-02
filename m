Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D4CC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2423C206A1
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vz+KCiX0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ox3BWTAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423C206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=63EyXEf+1OKOH76RJ2YRGvZwo1XIGPX1EZUZu48le+I=; b=Vz+KCiX0xjpJcgVxizTPm40kp
	m+mtwjwFaTmtViV6ky9wxmst8nZR+6EyuSSynPajnTeDssgi/Ze5PXfQELeGUBKzlyQFKWqqnF+bv
	FhXFsTJgsm7e3q6hpseKvgsRaCR52g8RBxu4vWffAuZDT4SjDTHkgmZaHELPQagd291WJRdpeZSpG
	v8MQxHYRjAlhAfgk8YKaokAzDRvvplN9LAMaez8/T64azeZUElCiCJ7wTDm5GeqVlD+hifBfEZ8/t
	vji3hxykFrWKV1gi+8a8niFAV9sphnJLsjqOGB59F+yiRimqxFDyOMsRwFSBzTezb1rC1hxNWipEW
	1ya8/kkiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquZY-0008TX-1g; Thu, 02 Jul 2020 08:27:56 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquZV-0008SR-IZ
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:27:54 +0000
Received: by mail-ej1-x635.google.com with SMTP id f12so2053495eja.9
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=RKNNI9ilwlTW24O/K9HeiTVOSxJ/N3BqN+ZQDEWHhcQ=;
 b=ox3BWTAxS7015W5ouWIph5TlQaJD64Q/jzbWXSueNXw5InF4mgLX9zWqSqhCNUd5ui
 Nmh6O5s+ftnGOQ2flcWnqEgi0qb0YTOfndBn9aw7erT5rGpuwv8TurItWIdD69bRAaeK
 Zt+MjYBfYZ9o7fQ91yQg4Ma8cHG8V6aCfbE4U7qA667dguUrqhLO3cjNH84slbhPW7gp
 nWt+i5xhw4y6sMWRfMNKcfpOsWAintVELYw84QpF7Y6FjvVU3Ymb3tkAuo81Buz7FB2E
 u5+sQIy4RTtYyHaMy7dqWLud9vpISf7s7AC9VGfs4MyXN+WqrZWOnv67/5tftkNr5fk3
 f0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RKNNI9ilwlTW24O/K9HeiTVOSxJ/N3BqN+ZQDEWHhcQ=;
 b=RP7qCqGJl4lMxJaAHPl8SFxv0uHP3hzKCZ+Tuale7K5Gxc3s1wkTenwEWgDv/ByHV8
 fMnruqKECtdmTqukt20jiRwwf87yAsNveiTfjp/oMxgjpbt9c9fZJku9qHTZTG58oXiT
 FMpfybYRo6gsitOymUr1GW8U9jZ3c3z/17/gi/PV9XjJNNPbv/1+w94SVltXyklrh+3J
 QEDmiaxqBIh7kChEE/y4jxS2j9CZwCTaFx+g8bhxGNRbRUuL/cYBZbw5Uc9AH+hUZ3V1
 xL5vQkStLNfXAs+4Ldr1Rey3I1EJcJdpGzeUgCbnG/XosDrizjP5wGplYCWiX8EwRyOt
 urJw==
X-Gm-Message-State: AOAM530muw5ui5uELuuBA30NIi+d0fl5eadcfoauVBjnFKMzM1puPfl6
 Xow+h/IXFtfMnUq39LjhqfNznA==
X-Google-Smtp-Source: ABdhPJwLYs3u1lg4itWPmPWTqmj9rfL+4jOz/2f+iuNc6XCeNvc40KrjILE7OBRTGcMtPpUFGNlGxg==
X-Received: by 2002:a17:906:4bcf:: with SMTP id
 x15mr17409793ejv.188.1593678472297; 
 Thu, 02 Jul 2020 01:27:52 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id q3sm5163437eds.41.2020.07.02.01.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 01:27:51 -0700 (PDT)
Date: Thu, 2 Jul 2020 10:27:34 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Message-ID: <20200702082734.pb775iqyqkm2if6w@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
 <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_042753_742688_0088BD38 
X-CRM114-Status: UNSURE (   8.03  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
 "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDIuMDcuMjAyMCAwODoxOSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+T24gMDIvMDcv
MjAyMCAwODo1NSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4gIGludCBudm1lX3VwZGF0ZV96
b25lX2luZm8oc3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX25zICpucywKPj4gLQkJ
CSAgdW5zaWduZWQgbGJhZikKPj4gKwkJCSAgdW5zaWduZWQgaW50IGxiYWYsIHNlY3Rvcl90IG5z
emUpCj4+ICB7Cj4+ICAvLwlzdHJ1Y3QgbnZtZV9lZmZlY3RzX2xvZyAqbG9nID0gbnMtPmhlYWQt
PmVmZmVjdHM7Cj4+ICAJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBkaXNrLT5xdWV1ZTsKPgo+
Cj5QbGVhc2Ugbm8gQysrIHN0eWxlIGNvbW1lbnRzIGFuZCBubyBjb21tZW50aW5nIG91dCBvZiBj
b2RlIGluIGFuIG9mZmljaWFsIHN1Ym1pc3Npb24uCgpTb3JyeS4gSSBzZWUgc29tZSBkZWJ1ZyBj
b2RlIGxlYWtlZCBoZXJlLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
