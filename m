Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A7EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B85206EB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puwbiozx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Kh44WkYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B85206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=864tdKHvmVF3UmyASfFiSj9GU/E0szm47F4Qk0o4Ocw=; b=puwbiozxI/oWgupjJXs7xFba/
	h6b6jFLdibIFLioR2emzQ4yVuTHSqNPIhBirNcFoyUgN5vjAiQw3A1W7tiPCpwkYzPsYjZZLA+9cY
	LgzgdVvCKtfd18fVPl0jEmzSMk5jErcKke/+IYETmkFaeHaaYYAWtJBR0Y5ArMjKT5g7cATOQnfFL
	mZ9gyrTGz7n/o//pcFHigni8wOrTfXGa+xeHn4Gx4sr5Ot+cO51q7bdlbzmjZzN3M7R9XAcGgx+EO
	UePJ9vXWW8r58BOBN/GWG3JqaNsC7PAakhpzE0HXEmsu7lhi7UUs2bcWi+mQbee+JOJBwegZuyF6c
	MvjUf2z0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQtq-0001mO-Vx; Thu, 25 Jun 2020 12:22:39 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQtb-0001gG-6s
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:22:26 +0000
Received: by mail-wm1-x341.google.com with SMTP id t194so5706304wmt.4
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2L00CNHKBCbfy3cMWAQy/pd7OUpZtWDs/eSSmk8PMi4=;
 b=Kh44WkYOain0Pp75DcY1C7bHN1YW5+QHFdo0wKvqm9K7NX2tVMrXpvj0g6MLYu+In9
 6l8Xk8BxfTXc6h02EsJj/CABUJVdAsbvA4lCOPPMgSOEnZXXp9t7zWzNnf65+lyl6Lyz
 zjRuKiajCZJBs3MdoA4P9WnKTWsYDL9rOITff9JoBR5oxIwH8PgFJ1J2HcbLzt18F1dq
 n8xTt4fzX3bFSM/myHNFJPFcraZDxYSu+DnKkSXsaeU7QHUfT8Naodsb+K6Fb6LTrD+K
 a+mUhAfxMtNS+cS0JuxLOjLeIYaqPvdllhcjxmDI+pLRpnG7a4JmFLELeZ3nSRO8Mc6R
 P7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2L00CNHKBCbfy3cMWAQy/pd7OUpZtWDs/eSSmk8PMi4=;
 b=I/g8xWJT0DmbJSPkk5sKNaCm4/T1eo6wyHHexJYVOJntZaum6vMaqBfK6Sd484H+5u
 /k40qzkDMKKFuMns6WLPN25RRLXFNy1iQrtASjI3rQmp0Z4OFLGu2sZUMXaLIuCUdu9w
 3gu91OSggarknLa6eYL8pHIle9MzpZEL0WJpUkIULBQkvIgLtUfSVs3KnfX5ZixKSZ5F
 qLyBeOBfadpEtf+zqFy0REoii/a+NlcNcZuAx3m22x+9rFznwfWb2EOOqpRkGnL/a0lH
 MMR06jL9oY1V87OkPCgX7blvLd0QzriZs/lQ31v1OrFdZ/rEWDnwVrOKqsc3wLjl12rt
 nVjw==
X-Gm-Message-State: AOAM530we42pjMLZD/qwv0asGh3lOY45PE09sewMZ+16bX7Xf9p2EvOM
 grhThYP5gVDL5+NldkzHX8EqeQpA50RnTw==
X-Google-Smtp-Source: ABdhPJwLQKCVAuxkPWqx617ggfLTUwSVHSwvKTQYrG5rXSz42pycHLAu2PUhv9lJFRFCtaThehrtNw==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr2389198wmf.1.1593087738990; 
 Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] block: add support for zone offline transition
Date: Thu, 25 Jun 2020 14:21:49 +0200
Message-Id: <20200625122152.17359-4-javier@javigon.com>
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

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBZGQgc3Vw
cG9ydCBmb3Igb2ZmbGluZSB0cmFuc2l0aW9uIG9uIHRoZSB6b25lZCBibG9jayBkZXZpY2UgdXNp
bmcgdGhlCm5ldyB6b25lIG1hbmFnZW1lbnQgSU9DVEwKClNpZ25lZC1vZmYtYnk6IEphdmllciBH
b256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1
bWFyIFMgPHNlbHZha3VtYS5zMUBzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBK
b3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogTml0ZXNoIFNoZXR0eSA8
bmouc2hldHR5QHNhbXN1bmcuY29tPgotLS0KIGJsb2NrL2Jsay1jb3JlLmMgICAgICAgICAgICAg
IHwgMiArKwogYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgfCAzICsrKwogZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jICAgICAgfCAzICsrKwogaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCAg
ICAgfCAzICsrKwogaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICAgICAgfCAxIC0KIGluY2x1ZGUv
dWFwaS9saW51eC9ibGt6b25lZC5oIHwgMSArCiA2IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ibG9jay9ibGstY29yZS5jIGIvYmxv
Y2svYmxrLWNvcmUuYwppbmRleCAwMzI1MmFmOGM4MmMuLjU4OWNiZGFjYzVlYyAxMDA2NDQKLS0t
IGEvYmxvY2svYmxrLWNvcmUuYworKysgYi9ibG9jay9ibGstY29yZS5jCkBAIC0xNDAsNiArMTQw
LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IGJsa19vcF9uYW1lW10gPSB7CiAJUkVRX09Q
X05BTUUoWk9ORV9DTE9TRSksCiAJUkVRX09QX05BTUUoWk9ORV9GSU5JU0gpLAogCVJFUV9PUF9O
QU1FKFpPTkVfQVBQRU5EKSwKKwlSRVFfT1BfTkFNRShaT05FX09GRkxJTkUpLAogCVJFUV9PUF9O
QU1FKFdSSVRFX1NBTUUpLAogCVJFUV9PUF9OQU1FKFdSSVRFX1pFUk9FUyksCiAJUkVRX09QX05B
TUUoU0NTSV9JTiksCkBAIC0xMDMwLDYgKzEwMzEsNyBAQCBnZW5lcmljX21ha2VfcmVxdWVzdF9j
aGVja3Moc3RydWN0IGJpbyAqYmlvKQogCWNhc2UgUkVRX09QX1pPTkVfT1BFTjoKIAljYXNlIFJF
UV9PUF9aT05FX0NMT1NFOgogCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgorCWNhc2UgUkVRX09Q
X1pPTkVfT0ZGTElORToKIAkJaWYgKCFibGtfcXVldWVfaXNfem9uZWQocSkpCiAJCQlnb3RvIG5v
dF9zdXBwb3J0ZWQ7CiAJCWJyZWFrOwpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLXpvbmVkLmMgYi9i
bG9jay9ibGstem9uZWQuYwppbmRleCAyOTE5NDM4OGExYmIuLjcwNGZjMTU4MTNkMSAxMDA2NDQK
LS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKKysrIGIvYmxvY2svYmxrLXpvbmVkLmMKQEAgLTQxNiw2
ICs0MTYsOSBAQCBpbnQgYmxrZGV2X3pvbmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiZGV2LCBmbW9kZV90IG1vZGUsCiAJY2FzZSBCTEtfWk9ORV9NR01UX1JFU0VUOgogCQlvcCA9
IFJFUV9PUF9aT05FX1JFU0VUOwogCQlicmVhazsKKwljYXNlIEJMS19aT05FX01HTVRfT0ZGTElO
RToKKwkJb3AgPSBSRVFfT1BfWk9ORV9PRkZMSU5FOworCQlicmVhazsKIAlkZWZhdWx0OgogCQly
ZXR1cm4gLUVOT1RUWTsKIAl9CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZjEyMTU1MjM3OTJiLi41Yjk1YzgxZDJh
MmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKQEAgLTc3Niw2ICs3NzYsOSBAQCBibGtfc3RhdHVzX3QgbnZtZV9zZXR1
cF9jbWQoc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxLAogCWNhc2UgUkVR
X09QX1pPTkVfRklOSVNIOgogCQlyZXQgPSBudm1lX3NldHVwX3pvbmVfbWdtdF9zZW5kKG5zLCBy
ZXEsIGNtZCwgTlZNRV9aT05FX0ZJTklTSCk7CiAJCWJyZWFrOworCWNhc2UgUkVRX09QX1pPTkVf
T0ZGTElORToKKwkJcmV0ID0gbnZtZV9zZXR1cF96b25lX21nbXRfc2VuZChucywgcmVxLCBjbWQs
IE5WTUVfWk9ORV9PRkZMSU5FKTsKKwkJYnJlYWs7CiAJY2FzZSBSRVFfT1BfV1JJVEVfWkVST0VT
OgogCQlyZXQgPSBudm1lX3NldHVwX3dyaXRlX3plcm9lcyhucywgcmVxLCBjbWQpOwogCQlicmVh
azsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmggYi9pbmNsdWRlL2xpbnV4
L2Jsa190eXBlcy5oCmluZGV4IDE2YjU3ZmIyYjk5Yy4uYjM5MjEyNjNjM2RkIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oCisrKyBiL2luY2x1ZGUvbGludXgvYmxrX3R5cGVz
LmgKQEAgLTMxNiw2ICszMTYsOCBAQCBlbnVtIHJlcV9vcGYgewogCVJFUV9PUF9aT05FX0ZJTklT
SAk9IDEyLAogCS8qIHdyaXRlIGRhdGEgYXQgdGhlIGN1cnJlbnQgem9uZSB3cml0ZSBwb2ludGVy
ICovCiAJUkVRX09QX1pPTkVfQVBQRU5ECT0gMTMsCisJLyogVHJhbnNpdGlvbiBhIHpvbmUgdG8g
b2ZmbGluZSAqLworCVJFUV9PUF9aT05FX09GRkxJTkUJPSAxNCwKIAogCS8qIFNDU0kgcGFzc3Ro
cm91Z2ggdXNpbmcgc3RydWN0IHNjc2lfcmVxdWVzdCAqLwogCVJFUV9PUF9TQ1NJX0lOCQk9IDMy
LApAQCAtNDU2LDYgKzQ1OCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBvcF9pc196b25lX21nbXQo
ZW51bSByZXFfb3BmIG9wKQogCWNhc2UgUkVRX09QX1pPTkVfT1BFTjoKIAljYXNlIFJFUV9PUF9a
T05FX0NMT1NFOgogCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgorCWNhc2UgUkVRX09QX1pPTkVf
T0ZGTElORToKIAkJcmV0dXJuIHRydWU7CiAJZGVmYXVsdDoKIAkJcmV0dXJuIGZhbHNlOwpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgK
aW5kZXggYmQ4NTIxZjk0ZGM0Li44MzA4ZDhhMzcyMGIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvYmxrZGV2LmgKKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaApAQCAtMzcyLDcgKzM3Miw2
IEBAIGV4dGVybiBpbnQgYmxrZGV2X3pvbmVfb3BzX2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYsIGZtb2RlX3QgbW9kZSwKIAkJCQkgIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxv
bmcgYXJnKTsKIGV4dGVybiBpbnQgYmxrZGV2X3pvbmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tf
ZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCiAJCQkJICB1bnNpZ25lZCBpbnQgY21kLCB1bnNp
Z25lZCBsb25nIGFyZyk7Ci0KICNlbHNlIC8qIENPTkZJR19CTEtfREVWX1pPTkVEICovCiAKIHN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGJsa2Rldl9ucl96b25lcyhzdHJ1Y3QgZ2VuZGlzayAq
ZGlzaykKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKaW5kZXggYThjODlmZTU4Zjk3Li5kMDk3OGVlMTBmYzcg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCisrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9ibGt6b25lZC5oCkBAIC0xNTUsNiArMTU1LDcgQEAgZW51bSBibGtfem9uZV9h
Y3Rpb24gewogCUJMS19aT05FX01HTVRfRklOSVNICT0gMHgyLAogCUJMS19aT05FX01HTVRfT1BF
Tgk9IDB4MywKIAlCTEtfWk9ORV9NR01UX1JFU0VUCT0gMHg0LAorCUJMS19aT05FX01HTVRfT0ZG
TElORQk9IDB4NSwKIH07CiAKIC8qKgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
