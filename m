Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C642E2067D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wekDlUct";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ASNQQXlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C642E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o0r9Fp0DX5OVkI0OGgi7TLsUutW7CvE/cOvln/9uTBA=; b=wekDlUctDUllx2AUYpHy2oW7w
	Me7B4Lwl1FW/BPBfUFVBjbaxU6I/TcWCg3cwJ6Yr2/lWKY/5l41UD3VzfSbIW5o+SnotZyoUTegmA
	eEuVPavZ6q4bp7IIBej5+7NwIBxz81KLT0GDlxv3oXO7w06K8bFeknpPBEGva/VC2uTwYB7yKOFDI
	LQcUSZUdd89icOV7pD8FgFB4isXdLwRiWu0xYumLOOKDk97mnBTSSF1pgzWUjEpxXSK9oa6+YcMea
	qLXVM6kedm4x83gma3k+iiZIsjliPAC3DbyVRJBa2NvfDD4iawOsrCjuE7HuhP2vcFMrZRnTwfsl8
	lrGLQXEfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqt7t-0008U5-R2; Thu, 02 Jul 2020 06:55:17 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqt7h-0008LG-Up
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 06:55:07 +0000
Received: by mail-ej1-x641.google.com with SMTP id f12so1726775eja.9
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jNqe3xdMxYATpvkBSQ9DPSFzqAXCkxXTgUf0+2M14v8=;
 b=ASNQQXlO2BS6HubW/chFoh77ZBHR2d6dw101imcfuWkntcyR6qnBw/a48xBQzmstf5
 7DLyUy+9rDpTkYmCjsQwhx48rHwV5sT4dnPHCaHEQew3/UEj0Tfbfip1wiIxE6p5vl65
 DE0KRZhDCoR+v4BnF9R0xaYOERxUe0+1qd8gV3RUKVJYQrQyEqGIbEJZNJUAivUqEjHh
 7JzNU3P9jYtOL/D8D4645XG2Y80izIk+D86VrSHJF/lQUKjAyKdnpPzR6DefMNGG8BdR
 ikF1YNpH/eKDeOPkeaivUdgVDXeJhF8+62WkqPnkjBdVWD8saaOAW/EpFKj5gJTNgUzY
 SSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jNqe3xdMxYATpvkBSQ9DPSFzqAXCkxXTgUf0+2M14v8=;
 b=KzO0nyhvUgE5RWgE/nbId/7md8jrVekxd1UmvEAzidihQzNCUXIeIc28fIWEziblV6
 Zkf8guCDtGx4o5EZp3TuttTVMgKlGtV1GlhtksTt7fU2d7H9kkh938aSLYyw9eohuhfF
 kYxzbeCZnvk4W6XPbDasTyiEyHW2XHHVz3rBKFYfTa9Wo9rwOEV1PJFrdMS5358gD1yW
 PPg7pHxmSoN1iSUydhCUQh3B05/SyVEOyRlcFr6yn4nEQHB9SLOu6cq1VWISEqL4ka0M
 Y9hUCqDgMt13eJkYIG+FLyB7EmUA2jlOdFhBb4ksaeGHH4Mt4YsYXXXZChZTH3wYe9Xy
 dWEQ==
X-Gm-Message-State: AOAM531rqsIK3gRW0Itiwv910JvfhIksoJP8pZBESbiqQ0QG3YE8+tKT
 Y1rPFJD+OnGvz6GorK2e72skUxKyJD2Uap90
X-Google-Smtp-Source: ABdhPJxDuednJiBTcKqTYBXgxGdlZ70OidSmz7DMv99/hfqdMejYL8GqON/h3xnBNhSzE3cnX69bTQ==
X-Received: by 2002:a17:906:33ca:: with SMTP id
 w10mr18822882eja.171.1593672904159; 
 Wed, 01 Jul 2020 23:55:04 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 23:55:03 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] block: Add zone flags to queue zone prop.
Date: Thu,  2 Jul 2020 08:54:35 +0200
Message-Id: <20200702065438.46350-2-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702065438.46350-1-javier@javigon.com>
References: <20200702065438.46350-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_025506_035282_479CF0F0 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, mb@lightnvm.io,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBcyB0aGUg
em9uZWQgYmxvY2sgZGV2aWNlIHdpbGwgaGF2ZSB0byBkZWFsIHdpdGggZmVhdHVyZXMgdGhhdCBh
cmUKb3B0aW9uYWwgZm9yIHRoZSBiYWNrZW5kIGRldmljZSwgYWRkIGEgZmxhZyBmaWVsZCB0byBp
bmZvcm0gdGhlIGJsb2NrCmxheWVyIGFib3V0IHN1cHBvcnRlZCBmZWF0dXJlcy4gVGhpcyBidWls
ZHMgb24gdG9wIG9mCmJsa196b25lX3JlcG9ydF9mbGFncyBhbmQgZXh0ZW5kZXMgdG8gdGhlIHpv
bmUgcmVwb3J0IGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIu
Z29uekBzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEu
czFAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtAc2Ft
c3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBzYW1zdW5n
LmNvbT4KLS0tCiBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAzICsrLQogZHJpdmVy
cy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgMiArKwogZHJpdmVycy9udm1lL2hvc3Qvem5zLmMg
ICAgICAgIHwgMSArCiBkcml2ZXJzL3Njc2kvc2QuYyAgICAgICAgICAgICAgfCAyICsrCiBpbmNs
dWRlL2xpbnV4L2Jsa2Rldi5oICAgICAgICAgfCAzICsrKwogNSBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLXpvbmVk
LmMgYi9ibG9jay9ibGstem9uZWQuYwppbmRleCA4MTE1MmEyNjAzNTQuLjBmMTU2ZTk2ZTQ4ZiAx
MDA2NDQKLS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKKysrIGIvYmxvY2svYmxrLXpvbmVkLmMKQEAg
LTMxMiw3ICszMTIsOCBAQCBpbnQgYmxrZGV2X3JlcG9ydF96b25lc19pb2N0bChzdHJ1Y3QgYmxv
Y2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCiAJCXJldHVybiByZXQ7CiAKIAlyZXAubnJf
em9uZXMgPSByZXQ7Ci0JcmVwLmZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOworCXJlcC5m
bGFncyA9IHEtPnpvbmVfZmxhZ3M7CisKIAlpZiAoY29weV90b191c2VyKGFyZ3AsICZyZXAsIHNp
emVvZihzdHJ1Y3QgYmxrX3pvbmVfcmVwb3J0KSkpCiAJCXJldHVybiAtRUZBVUxUOwogCXJldHVy
biAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIGIvZHJpdmVy
cy9ibG9jay9udWxsX2Jsa196b25lZC5jCmluZGV4IGIwNTgzMmViMjFiMi4uOTU3YzIxMDNmMjQw
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMKKysrIGIvZHJpdmVy
cy9ibG9jay9udWxsX2Jsa196b25lZC5jCkBAIC03OCw2ICs3OCw4IEBAIGludCBudWxsX2luaXRf
em9uZWRfZGV2KHN0cnVjdCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUg
KnEpCiAJfQogCiAJcS0+bGltaXRzLnpvbmVkID0gQkxLX1pPTkVEX0hNOworCXEtPnpvbmVfZmxh
Z3MgPSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFk7CisKIAlibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVf
RkxBR19aT05FX1JFU0VUQUxMLCBxKTsKIAlibGtfcXVldWVfcmVxdWlyZWRfZWxldmF0b3JfZmVh
dHVyZXMocSwgRUxFVkFUT1JfRl9aQkRfU0VRX1dSSVRFKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCAwNjQyZDNj
NTRlOGYuLjg4ODI2NDI2MWJhMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMK
KysrIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKQEAgLTgxLDYgKzgxLDcgQEAgaW50IG52bWVf
dXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5z
LAogCX0KIAogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKKwlxLT56b25lX2ZsYWdz
ID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwogCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFH
X1pPTkVfUkVTRVRBTEwsIHEpOwogZnJlZV9kYXRhOgogCWtmcmVlKGlkKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS9zZC5jIGIvZHJpdmVycy9zY3NpL3NkLmMKaW5kZXggZDkwZmVmZmZlMzFi
Li5iOWM5MjBiYWNlMjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9zZC5jCisrKyBiL2RyaXZl
cnMvc2NzaS9zZC5jCkBAIC0yOTY3LDYgKzI5NjcsNyBAQCBzdGF0aWMgdm9pZCBzZF9yZWFkX2Js
b2NrX2NoYXJhY3RlcmlzdGljcyhzdHJ1Y3Qgc2NzaV9kaXNrICpzZGtwKQogCWlmIChzZGtwLT5k
ZXZpY2UtPnR5cGUgPT0gVFlQRV9aQkMpIHsKIAkJLyogSG9zdC1tYW5hZ2VkICovCiAJCXEtPmxp
bWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKKwkJcS0+em9uZV9mbGFncyA9IEJMS19aT05FX1JF
UF9DQVBBQ0lUWTsKIAl9IGVsc2UgewogCQlzZGtwLT56b25lZCA9IChidWZmZXJbOF0gPj4gNCkg
JiAzOwogCQlpZiAoc2RrcC0+em9uZWQgPT0gMSAmJiAhZGlza19oYXNfcGFydGl0aW9ucyhzZGtw
LT5kaXNrKSkgewpAQCAtMjk4Myw2ICsyOTg0LDcgQEAgc3RhdGljIHZvaWQgc2RfcmVhZF9ibG9j
a19jaGFyYWN0ZXJpc3RpY3Moc3RydWN0IHNjc2lfZGlzayAqc2RrcCkKIAkJCQkJICAiRHJpdmUt
bWFuYWdlZCBTTVIgZGlza1xuIik7CiAJCX0KIAl9CisKIAlpZiAoYmxrX3F1ZXVlX2lzX3pvbmVk
KHEpICYmIHNka3AtPmZpcnN0X3NjYW4pCiAJCXNkX3ByaW50ayhLRVJOX05PVElDRSwgc2RrcCwg
Ikhvc3QtJXMgem9uZWQgYmxvY2sgZGV2aWNlXG4iLAogCQkgICAgICBxLT5saW1pdHMuem9uZWQg
PT0gQkxLX1pPTkVEX0hNID8gIm1hbmFnZWQiIDogImF3YXJlIik7CmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAppbmRleCA4ZmQ5MDA5
OThiNGUuLjNmMmUzNDI1ZmE1MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCkBAIC01MTIsMTIgKzUxMiwxNSBAQCBzdHJ1Y3Qg
cmVxdWVzdF9xdWV1ZSB7CiAJICogU3RhY2tpbmcgZHJpdmVycyAoZGV2aWNlIG1hcHBlcnMpIG1h
eSBvciBtYXkgbm90IGluaXRpYWxpemUKIAkgKiB0aGVzZSBmaWVsZHMuCiAJICoKKwkgKiBGbGFn
cyByZXByZXNlbnQgZmVhdHVyZXMgYXMgZGVzY3JpYmVkIGJ5IGJsa196b25lX3JlcG9ydF9mbGFn
cyBpbiBibGt6b25lZC5oCisJICoKIAkgKiBSZWFkcyBvZiB0aGlzIGluZm9ybWF0aW9uIG11c3Qg
YmUgcHJvdGVjdGVkIHdpdGggYmxrX3F1ZXVlX2VudGVyKCkgLwogCSAqIGJsa19xdWV1ZV9leGl0
KCkuIE1vZGlmeWluZyB0aGlzIGluZm9ybWF0aW9uIGlzIG9ubHkgYWxsb3dlZCB3aGlsZQogCSAq
IG5vIHJlcXVlc3RzIGFyZSBiZWluZyBwcm9jZXNzZWQuIFNlZSBhbHNvIGJsa19tcV9mcmVlemVf
cXVldWUoKSBhbmQKIAkgKiBibGtfbXFfdW5mcmVlemVfcXVldWUoKS4KIAkgKi8KIAl1bnNpZ25l
ZCBpbnQJCW5yX3pvbmVzOworCXVuc2lnbmVkIGludAkJem9uZV9mbGFnczsKIAl1bnNpZ25lZCBs
b25nCQkqY29udl96b25lc19iaXRtYXA7CiAJdW5zaWduZWQgbG9uZwkJKnNlcV96b25lc193bG9j
azsKICNlbmRpZiAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAqLwotLSAKMi4xNy4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
