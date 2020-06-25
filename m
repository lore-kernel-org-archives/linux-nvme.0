Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C973C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC4D206EB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gLyxh72P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ifgHFoOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC4D206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5hKEj2C1I3zmFS7bVyLBk18BxIcp4SCK579ApGM5gFg=; b=gLyxh72PTQ4daF1iZ/neGCJI3
	c4oOC4Zfj4jxRiTeS0B+UvOO96pzV0g1N0VC7QA7nqcnnco8/cqUaNzmNQshf+3PCg8aZ1nZYMsYs
	d1hYRM74pu/UNj7sjBDUPdhDWs2UJJEbfKIYqQ2qRmkTlemJE/In17v+Z6dhu/SnnA6YtQ4PVAPQG
	AV2qIwkCyexVSKQUrxdAx+08w4daw5QKN03JjHMBSCWVI6mpRltklpTBH7uG0lMC8qnAeR0DkI/yS
	OnLJrWhFiKknGu+eBJYie4dDGIMau2yYZyHq3m+KuXiw+g+25vHFXBcuYHy6+XII4wyGMDubdiUTX
	q+U+1eNiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQtc-0001gZ-4G; Thu, 25 Jun 2020 12:22:24 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQtW-0001eg-Mk
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:22:20 +0000
Received: by mail-wr1-x441.google.com with SMTP id s10so5594719wrw.12
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3bkv5TGbl7wYs9nS4zaCevytBrOA5cQbuULXOr6pl3k=;
 b=ifgHFoOGFnPjkhUJyWlsM6iDVmY6+dXBQ2RYy98T9hw6pqwoNJQ5ekXb4B1EPGXQT0
 MRKbDXdW2C/DboFLHOyBCoGGwN+6j0+r7IzErzD0WL5hOjs9oiNUhb162G9nRHs62jlV
 kz9ifdRLxZeqPD3rLCIttiz6uUFMXBjw4pIScjnHGIM05F+7MWOtgNFrfcMmkAtZrep6
 awZ96tfAVb0b9WvH7FJxTqrg8ZbWfmMDu/Tp8AixYn8oDKO8m+1iPpzIhs+cgICilSlt
 Bl1qzXwe+FYUTlI8xI6uvMzkgQgWE7/zuZofBLsJyuPoIn1fOgPlUcnSSoVBq8s3++4U
 bQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3bkv5TGbl7wYs9nS4zaCevytBrOA5cQbuULXOr6pl3k=;
 b=BO+JWfcvHkE6xRFlpaH8j5Dm6TpHXQKcQa7wSRc8FdT032S8m2GfGeghtFWcjH72io
 VAIpOE3hlwEWlTtOtB4EVGKY8RdYi2BpgxHovEDCpUK8pkW9tKHvECntlIEjtNZy3g/o
 AkUa7EWth3TumAZuIbLVc80z6H+ez+F+z0JOR2HJL5ElN+rvSQfUcOHysWRvHFRrGpZK
 QsdEVgBCnk/K3/+hhTDZhcHRM+dnWSlXrPHii4Kr+zgXS5nO9vl/mlm0S1MuFHbQA3Uf
 5ywkA4s2pSZf91HiEgzIpaquzSrkmo113L3dc7LX4KDMBpd1p+eMbO8WC3n7ZgyYZ/77
 zJPg==
X-Gm-Message-State: AOAM533JtLSJaFhToAV2PlNtK9Ld3I4H4xj417byLMvEBsPxH0FxlplD
 laGkzkMT8LrAmcpXFgWS2twX5SgxK37MOw==
X-Google-Smtp-Source: ABdhPJzF8GY0GnEa29w1laEfJi/6dSjQwhhYGR9JKKjHg3d8xUSjch6Sz0P0cntsTzsVn5L/uRebXw==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr20889677wrp.206.1593087737294; 
 Thu, 25 Jun 2020 05:22:17 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:22:16 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] block: add support for selecting all zones
Date: Thu, 25 Jun 2020 14:21:48 +0200
Message-Id: <20200625122152.17359-3-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
MIME-Version: 1.0
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBZGQgZmxh
ZyB0byBhbGxvdyBzZWxlY3RpbmcgYWxsIHpvbmVzIG9uIGEgc2luZ2xlIHpvbmUgbWFuYWdlbWVu
dApvcGVyYXRpb24KClNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmllci5nb256
QHNhbXN1bmcuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNlbHZha3VtYS5zMUBz
YW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5n
LmNvbT4KU2lnbmVkLW9mZi1ieTogTml0ZXNoIFNoZXR0eSA8bmouc2hldHR5QHNhbXN1bmcuY29t
PgotLS0KIGJsb2NrL2Jsay16b25lZC5jICAgICAgICAgICAgIHwgMyArKysKIGluY2x1ZGUvbGlu
dXgvYmxrX3R5cGVzLmggICAgIHwgMyArKy0KIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5o
IHwgOSArKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVk
LmMKaW5kZXggZTg3YzYwMDA0ZGM1Li4yOTE5NDM4OGExYmIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Js
ay16b25lZC5jCisrKyBiL2Jsb2NrL2Jsay16b25lZC5jCkBAIC00MjAsNiArNDIwLDkgQEAgaW50
IGJsa2Rldl96b25lX21nbXRfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVf
dCBtb2RlLAogCQlyZXR1cm4gLUVOT1RUWTsKIAl9CiAKKwlpZiAoem1nbXQuZmxhZ3MgJiBCTEtf
Wk9ORV9TRUxFQ1RfQUxMKQorCQlvcCB8PSBSRVFfWk9ORV9BTEw7CisKIAlyZXR1cm4gYmxrZGV2
X3pvbmVfbWdtdChiZGV2LCBvcCwgem1nbXQuc2VjdG9yLCB6bWdtdC5ucl9zZWN0b3JzLAogCQkJ
CUdGUF9LRVJORUwpOwogfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBi
L2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKaW5kZXggY2NiODk1ZjkxMWIxLi4xNmI1N2ZiMmI5
OWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9ibGtfdHlwZXMuaApAQCAtMzUxLDYgKzM1MSw3IEBAIGVudW0gcmVxX2ZsYWdfYml0cyB7
CiAJICogd29yayBpdGVtIHRvIGF2b2lkIHN1Y2ggcHJpb3JpdHkgaW52ZXJzaW9ucy4KIAkgKi8K
IAlfX1JFUV9DR1JPVVBfUFVOVCwKKwlfX1JFUV9aT05FX0FMTCwJCS8qIGFwcGx5IHpvbmUgb3Bl
cmF0aW9uIHRvIGFsbCB6b25lcyAqLwogCiAJLyogY29tbWFuZCBzcGVjaWZpYyBmbGFncyBmb3Ig
UkVRX09QX1dSSVRFX1pFUk9FUzogKi8KIAlfX1JFUV9OT1VOTUFQLAkJLyogZG8gbm90IGZyZWUg
YmxvY2tzIHdoZW4gemVyb2luZyAqLwpAQCAtMzc4LDcgKzM3OSw3IEBAIGVudW0gcmVxX2ZsYWdf
Yml0cyB7CiAjZGVmaW5lIFJFUV9CQUNLR1JPVU5ECQkoMVVMTCA8PCBfX1JFUV9CQUNLR1JPVU5E
KQogI2RlZmluZSBSRVFfTk9XQUlUCQkoMVVMTCA8PCBfX1JFUV9OT1dBSVQpCiAjZGVmaW5lIFJF
UV9DR1JPVVBfUFVOVAkJKDFVTEwgPDwgX19SRVFfQ0dST1VQX1BVTlQpCi0KKyNkZWZpbmUgUkVR
X1pPTkVfQUxMCQkoMVVMTCA8PCBfX1JFUV9aT05FX0FMTCkKICNkZWZpbmUgUkVRX05PVU5NQVAJ
CSgxVUxMIDw8IF9fUkVRX05PVU5NQVApCiAjZGVmaW5lIFJFUV9ISVBSSQkJKDFVTEwgPDwgX19S
RVFfSElQUkkpCiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIGIv
aW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKaW5kZXggMDdiNWZkZTIxZDlmLi5hOGM4OWZl
NThmOTcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCisrKyBiL2lu
Y2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCkBAIC0xNTcsNiArMTU3LDE1IEBAIGVudW0gYmxr
X3pvbmVfYWN0aW9uIHsKIAlCTEtfWk9ORV9NR01UX1JFU0VUCT0gMHg0LAogfTsKIAorLyoqCisg
KiBlbnVtIGJsa196b25lX21nbXRfZmxhZ3MgLSBGbGFncyBmb3IgYmxrX3pvbmVfbWdtdAorICoK
KyAqIEJMS19aT05FX1NFTEVDVF9BTEw6IFNlbGVjdCBhbGwgem9uZXMgZm9yIGN1cnJlbnQgem9u
ZSBhY3Rpb24KKyAqLworZW51bSBibGtfem9uZV9tZ210X2ZsYWdzIHsKKwlCTEtfWk9ORV9TRUxF
Q1RfQUxMCT0gMSA8PCAwLAorfTsKKwogLyoqCiAgKiBzdHJ1Y3QgYmxrX3pvbmVfbWdtdCAtIEV4
dGVuZGVkIHpvbmVkIG1hbmFnZW1lbnQKICAqCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
