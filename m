Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54655C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2587420771
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qd0c0dOp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Eiz0lbAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2587420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TnrPYQrQqLtJT/V094HJYGSxWr/4L2vk2mOcmT7X7yM=; b=qd0c0dOpXlXBQlYrh2yWDil1k
	Pi1ZJigaafkXXryN2PPh85lqY2SGtpCfLE2yxV5/RdGTAru7NueaXzU5eLRPozV95iUxdIE16pMH0
	vGhZnQAlccwC1BJnfl20GZEE4TVarmZQ34HoR4vyTZridWLNG8LlV8aV6HqF9eWeVlS6W9taUml3I
	Ek32bX1rbJ1zNZw3LW/QBWWHIoRrqbOT9mWzqwSpH24lOLQl8Q2tJlMq3DIXA2vlhL7TgONuE7Meq
	fT4zn/sqccKGzL4lSt3QxxJqueoEYfOgcHibDTlDEGoSoJRafVKSH3vrrhQ0MknC2eHCLZF+I3VjC
	lkHuiSa0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvT7-0008Lt-UW; Thu, 02 Jul 2020 09:25:21 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvT5-0008KE-2C
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:25:19 +0000
Received: by mail-ej1-x642.google.com with SMTP id ga4so28414399ejb.11
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RFQAZPjeEEYPnNvZUHiuMpATVhic2B+bZ8De7e+nmoI=;
 b=Eiz0lbAmK2GuapskPcLetUryfUEnrhbufhFxX+2rC0p89cws92fGcolnElsigE062O
 42STEJ0EaxP+HGZjgYn2sA2VXzKeQmaGDZly3yGtEfZx4rvPKrlSpLBCf0EejmGJLsx4
 bGhDx7WZz+Rz16H34AsqNZ+oX5ncXFR4IYAAhlxIwlNpWjmfUV3cYDvAJfLstA7wpBOy
 LTPx9bhOiQJ6Aeaw9g1fDQ8Ep3umS74Wkk6JbaMlrVeAm/BETjGAI7DhLJ2Btx+69X53
 cmoiMyYc3EiIiujXbnX5nnQ9A+MfagAg1Gq8R05I33L1gvBMrfc6spvnnWlMldiCqX1U
 VM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFQAZPjeEEYPnNvZUHiuMpATVhic2B+bZ8De7e+nmoI=;
 b=qd9bZs/YeymTeKj7WUCN/V9I42XMwvNHTwc11zudAYB5Xe7bbTMl2A+pFAnPB5HdRc
 bJTxxuHpXHEPuIIqd4jHVTQ2zhSb6Zsh7zv+Im0zmxnQ2gvGQXUUNkMIROXBBShvfli5
 caW97NfDU/ZgVVBfLtoJ6whP53NEMmxSQD+OIeMvzuEbLfNA7l+11jz4iUKnzyXMzZJX
 1W/P4FTMDKmhemBkrDEA1QeR4IFN6vKQwNtlLk8XfIZuxkXYt7hlQ8Uhgm8zMr8U7Cs9
 t+3ly/rz+vv4D8hzScyh1vr++Xg4h6CgD7doFOIBl0rr8gJF+EV9ItxtyVm38m/cYXNM
 0v9A==
X-Gm-Message-State: AOAM532/dqSb7kelTaw9Uwfn4olyyY6wYJvVbnPsfyEZbALRy9T09TMo
 vUZoe/2oJB4BeQoaf1QNf2zwXlvV2SIitagZ
X-Google-Smtp-Source: ABdhPJynySCUYW9OcsHXk9q3JwHz0Wmor0c6AIMY6LxpHHERrZ9Q1QmtUZAnZR2fonz7CQR0wbc2+g==
X-Received: by 2002:a17:906:924d:: with SMTP id
 c13mr20309117ejx.518.1593681917258; 
 Thu, 02 Jul 2020 02:25:17 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:25:16 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Date: Thu,  2 Jul 2020 11:24:35 +0200
Message-Id: <20200702092438.63717-2-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_052519_140524_6A1FA93E 
X-CRM114-Status: GOOD (  16.63  )
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
 Kanchan Joshi <joshi.k@samsung.com>, Johannes.Thumshirn@wdc.com,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 kbusch@kernel.org,
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
cy9udm1lL2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCBjMDhmNjI4
MWI2MTQuLmFmZTYyZGMyN2ZmNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMK
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
