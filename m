Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA3CC388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BAB2068D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3PTG+a8N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="leoNSQPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BAB2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WTmmC/xsMuEwys3lYc+zu/TWBGlehA8HQyyQFUvrjE=; b=3PTG+a8NBB9dk3t+cqoQ+G/lB1
	6LQg7Ts+tkmxMEvTU3+m9RDIFDAQPu3hKBHrUlmDgcD78Z95cihHzHFiEDBnCBiIbXVZomt+EsqEv
	aQ8FXxQ7rCa6nlf50I2ZjaywEyFihiuMVifiYQk6CugyWe8Ou1Y+HHTmn/cCkp2R0Ht0vPdnwFPyo
	QIKlP6GOF2mP8gGWrp3lCLKJsNakHxB14letxwHKsuMOZHT0mJJjcdF2Korm5okuU9Dbq8t6XFSls
	Y/QeK7pjpqWFlNG4kCZN5Upyu7XLXMi+cshXHJ2Buj3zmbbaIEIT2aqWri5+7gvLgF0TNsUPwNuoF
	QF9dcmpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcpWR-0002wQ-Mr; Wed, 11 Nov 2020 12:46:47 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcpWP-0002ue-Bm
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 12:46:46 +0000
Received: by mail-ej1-x643.google.com with SMTP id i19so2551456ejx.9
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 04:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nMEopWDrD+ugiSvfFXLXwcXEOZdgi3F7y/TkjGT26q0=;
 b=leoNSQPNzsuyI/ZFHg9GdriMvv3wwK9ahsZkC4gkVquYW09oTTri0qG4pL/pORa364
 q8/eyC7VTegWUCH0X4vluB1L/8u/qckZN1NeU0caakF/JhW+dueZgBfHDbNW9Z3rSiMI
 FIKRI5ODONpzdja6fyqFN9i2PicLA5v8QiwHCrWspolMqb5sJnDU5oEnBOXgv//qpRYq
 45jA9uCgfWCc/ydwzqQ09090Z81ecibH5M9l5CFp+qx9WFrN8LtseKF1jyqBpLmPI4X5
 2waow2baqA3u7idvkvzvgokPYboVxhsbonD3g/augXXlDxU7ukNYNwlwoHAHW0e39Dn6
 fVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nMEopWDrD+ugiSvfFXLXwcXEOZdgi3F7y/TkjGT26q0=;
 b=A74JtRR4aX6gVQMDwR56yrhcy+kQXYEeLK2et+zrBOiQyrEg2EkHoNbuvxVKRbkGIC
 jR3A9CYu14G1Y6rTpoJ+Jx+OrK6VbhQNIBOjtWfg1H3J2Km0DWTPuXN43F4tFz8DypH+
 mnmKXLKfU7wt52lBYKRup7D4siW7jtUoT+/CgzdDzFq5u1uS4jkqMLdKlGlR8slBPHDY
 wtffDQFBZku1CDhbHH8fKdIk3mB/9Op4JAWuNmww73j1aHNC4ey7JAhElRjYUWSZ01SI
 lZn0xsYzpJeY06IvM6vSzuUlp2Nb4oKJ+v0E402cG13UmG87hgYF9+pcOdU9q7cTtMwa
 cvJQ==
X-Gm-Message-State: AOAM532498TRR6bCeZmqUpV2U5Jqb/5igh3E2eZk5k1Rd6WPv68cunKN
 vOsdyK2Jk5Shmc9DkSU24aMgjkMHhsWRAeqN
X-Google-Smtp-Source: ABdhPJyBs/G4oEHFb0D3AMKSGJzDeYyJQufISO3OWqqRT2PrFfDJ9YsnSXEQXlNICFo43L6g8J0Dig==
X-Received: by 2002:a17:906:5f89:: with SMTP id
 a9mr24450770eju.262.1605098801867; 
 Wed, 11 Nov 2020 04:46:41 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id h22sm840290ejt.21.2020.11.11.04.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 04:46:41 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: allow to force refresh of effects log
Date: Wed, 11 Nov 2020 13:46:38 +0100
Message-Id: <20201111124639.11305-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_074645_562591_D000E8BC 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBbGxvdyB0
aGUgY2FsbGVkIG9mIG52bWVfZ2V0X2VmZmVjdHNfbG9nKCkgdG8gZm9yY2UgcmUtcmVhZGluZyB0
aGUgbG9nCnBhZ2UgZnJvbSB0aGUgZGV2aWNlIGluc3RlYWQgb2YgZ2V0dGluZyB0aGUgY2FjaGVk
IHZlcnNpb24gd2hlbgphdmFpbGFibGUuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
fCAxOCArKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCBmZmY5MDIwMDQ5N2MuLmU0Yzc5ZjFkMmU5
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwpAQCAtMjk1MSwxOCArMjk1MSwyMCBAQCBpbnQgbnZtZV9nZXRfbG9nKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwsIHUzMiBuc2lkLCB1OCBsb2dfcGFnZSwgdTggbHNwLCB1OCBj
c2ksCiAJcmV0dXJuIG52bWVfc3VibWl0X3N5bmNfY21kKGN0cmwtPmFkbWluX3EsICZjLCBsb2cs
IHNpemUpOwogfQogCi1zdGF0aWMgaW50IG52bWVfZ2V0X2VmZmVjdHNfbG9nKHN0cnVjdCBudm1l
X2N0cmwgKmN0cmwsIHU4IGNzaSwKLQkJCQlzdHJ1Y3QgbnZtZV9lZmZlY3RzX2xvZyAqKmxvZykK
K3N0YXRpYyBpbnQgbnZtZV9nZXRfZWZmZWN0c19sb2coc3RydWN0IG52bWVfY3RybCAqY3RybCwg
dTggY3NpLCBzdHJ1Y3QgbnZtZV9lZmZlY3RzX2xvZyAqKmxvZywKKwkJCQlib29sIGZvcmNlKQog
ewogCXN0cnVjdCBudm1lX2NlbCAqY2VsID0geGFfbG9hZCgmY3RybC0+Y2VscywgY3NpKTsKIAlp
bnQgcmV0OwogCi0JaWYgKGNlbCkKKwlpZiAoY2VsICYmICFmb3JjZSkKIAkJZ290byBvdXQ7CiAK
LQljZWwgPSBremFsbG9jKHNpemVvZigqY2VsKSwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFjZWwpCi0J
CXJldHVybiAtRU5PTUVNOworCWlmICghY2VsKSB7CisJCWNlbCA9IGt6YWxsb2Moc2l6ZW9mKCpj
ZWwpLCBHRlBfS0VSTkVMKTsKKwkJaWYgKCFjZWwpCisJCQlyZXR1cm4gLUVOT01FTTsKKwl9CiAK
IAlyZXQgPSBudm1lX2dldF9sb2coY3RybCwgMHgwMCwgTlZNRV9MT0dfQ01EX0VGRkVDVFMsIDAs
IGNzaSwKIAkJCSZjZWwtPmxvZywgc2l6ZW9mKGNlbC0+bG9nKSwgMCk7CkBAIC0zMDA4LDcgKzMw
MTAsNyBAQCBpbnQgbnZtZV9pbml0X2lkZW50aWZ5KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiAJ
fQogCiAJaWYgKGlkLT5scGEgJiBOVk1FX0NUUkxfTFBBX0NNRF9FRkZFQ1RTX0xPRykgewotCQly
ZXQgPSBudm1lX2dldF9lZmZlY3RzX2xvZyhjdHJsLCBOVk1FX0NTSV9OVk0sICZjdHJsLT5lZmZl
Y3RzKTsKKwkJcmV0ID0gbnZtZV9nZXRfZWZmZWN0c19sb2coY3RybCwgTlZNRV9DU0lfTlZNLCAm
Y3RybC0+ZWZmZWN0cywgZmFsc2UpOwogCQlpZiAocmV0IDwgMCkKIAkJCWdvdG8gb3V0X2ZyZWU7
CiAJfQpAQCAtMzcyNSw3ICszNzI3LDcgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zX2hlYWQgKm52
bWVfYWxsb2NfbnNfaGVhZChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLAogCX0KIAogCWlmIChoZWFk
LT5pZHMuY3NpKSB7Ci0JCXJldCA9IG52bWVfZ2V0X2VmZmVjdHNfbG9nKGN0cmwsIGhlYWQtPmlk
cy5jc2ksICZoZWFkLT5lZmZlY3RzKTsKKwkJcmV0ID0gbnZtZV9nZXRfZWZmZWN0c19sb2coY3Ry
bCwgaGVhZC0+aWRzLmNzaSwgJmhlYWQtPmVmZmVjdHMsIGZhbHNlKTsKIAkJaWYgKHJldCkKIAkJ
CWdvdG8gb3V0X2NsZWFudXBfc3JjdTsKIAl9IGVsc2UKLS0gCjIuMTcuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
