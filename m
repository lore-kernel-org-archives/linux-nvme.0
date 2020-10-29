Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082BC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 18:58:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E3D20756
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oNNQR5yM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="a51t2eI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E3D20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lsnjr4Y3eqF+PHCpZKYNTz43kfd1fvNAGWgoudtPghU=; b=oNNQR5yMMowwdOSiilaX/JMliw
	DJ8kmsomTOsKo22MBwHAx6XlJcv+27xIVlIhZCYZ28m3gRMa/4WQZHbY9tDjk3WGg35cd2PLSyRLn
	Maznn2RNw/OVpaFlXjS4nyQdY/9HGIki2FSCdjfVpHbAsPRmnC/UA80Sj2euJLN+oFvkvC5XZy0A2
	WK/x1CVgldeIBBSWdjt0t6+JHMYRhQl5VLlgusf7ukJK/ptgD/vIXFMwhmdfq4cx0dgA9+94AfbcS
	hQuHsKQ2q5oYhn8mpFxX4EGVZrySpCYHcp+1+Zt6ZaZ6GBoVaHBSXe842bd6QIVL36ye47c5cUs0v
	E3arBO6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYD7u-0000tU-AY; Thu, 29 Oct 2020 18:58:22 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYD7p-0000sx-4o
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 18:58:17 +0000
Received: by mail-ed1-x543.google.com with SMTP id x1so4178501eds.1
 for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2020 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=89MgGJ2eLo/poQN08E10He93oDU/x3XhdHGWGtRSdCM=;
 b=a51t2eI/vR9CHjHzV2REhSPK/Vmz6ph8JXpIIUT+PMfFCzVwKOxNjdvXrVoVJ5jQFy
 kAjTIud/Db1ZhetL6W/9GdYwGECn53DEr38+d4OrAFocX6jREQUKl6Hgq3bkxt6q5SFX
 Plkdn8fSpw8Cc56XK/P3CpQSSr4EkbuQ/1ETqix4LUFQFNZdMVVqoaZa3SBU1MRKxve/
 IOKZy2NtVqf5baAHXUCUdlwaSSGr19/yeC2R/HMsQzMdtyIrXDR9XZYk/WAG7Hmy6VVJ
 YmPz25XOModxbznKLvbv3hVBvOQz43AD97htQ4QKY4hGjTn+3alwWGV4Yr0xFuSj2wQX
 N4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=89MgGJ2eLo/poQN08E10He93oDU/x3XhdHGWGtRSdCM=;
 b=Kk1+mqxfOu2w1sVqVtPWhDWiiOX6pUB5+HBsLXRGJqtz82dljAvKxaoirfyKzf4mH+
 bnJRCmXL63WYDA89DAwmo0SotWHQ4+N707MeHyTe5n0jP5T2miS/VweSYbZc6JsiM4Fs
 S2DJYRRZcliFpIsEAApvL0v5qY6X5+pKHh8/xc9FTQU2aXThBqwoHL+hUqVHqZVzXV4g
 qIPXH0RGT8lTRpRXVqgBvpSUWuZ1l029ycR0tG+EFdhUVwuv96VY3pdg9CRTntWX0t6G
 /jMIviblSliondBFgfutNYT3EmTKiYiHq57ZUf2n3GBbpgQNapyI6nyiJ4HI+AIJitwK
 5cFA==
X-Gm-Message-State: AOAM530Tg82FYSWOP9ksv4YPiDDJychr/P9QlwWGlymapMBLyxWCBNba
 8No5j0GrZmkksUfIyFhG/mwJ1b5WB0oeHhydS8w=
X-Google-Smtp-Source: ABdhPJzCKg8H/rV7NMAwOKOsmKObGB2b4LfWMi8r1jAoj+6+80WZx39v/Svl8CzLDRRXX6+hUcIfMg==
X-Received: by 2002:a50:8745:: with SMTP id 5mr5391983edv.49.1603997892755;
 Thu, 29 Oct 2020 11:58:12 -0700 (PDT)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk.
 [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id p3sm1974957edy.38.2020.10.29.11.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 11:58:12 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Date: Thu, 29 Oct 2020 19:57:53 +0100
Message-Id: <20201029185753.14368-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_145817_202623_FA874095 
X-CRM114-Status: GOOD (  18.42  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, joshi.k@samsung.com,
 k.jensen@samsung.com, linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWxsb3cgWk5TIFNTRHMgdG8gYmUgcHJlc2VudGVkIHRvIHRoZSBob3N0IGV2ZW4gd2hlbiB0aGV5
IGltcGxlbWVudApmZWF0dXJlcyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBrZXJuZWwg
em9uZWQgYmxvY2sgZGV2aWNlLgoKSW5zdGVhZCBvZiByZWplY3RpbmcgdGhlIFNTRCBhdCB0aGUg
TlZNZSBkcml2ZXIgbGV2ZWwsIGRlYWwgd2l0aCB0aGlzIGluCnRoZSBibG9jayBsYXllciBieSBz
ZXR0aW5nIGNhcGFjaXR5IHRvIDAsIGFzIHdlIGRvIHdpdGggb3RoZXIgdGhpbmdzCnN1Y2ggYXMg
dW5zdXBwb3J0ZWQgUEkgY29uZmlndXJhdGlvbnMuIFRoaXMgYWxsb3dzIHRvIHVzZSBzdGFuZGFy
ZAptYW5hZ2VtZW50IHRvb2xzIHN1Y2ggYXMgbnZtZS1jbGkgdG8gY2hvb3NlIGEgZGlmZmVyZW50
IGZvcm1hdCBvcgpmaXJtd2FyZSBzbG90IHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBMaW51
eCB6b25lZCBibG9jayBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxq
YXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAg
NSArKysrKwogZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDEgKwogZHJpdmVycy9udm1lL2hv
c3Qvem5zLmMgIHwgMzEgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXgg
YzE5MGM1NmJmNzAyLi45Y2E0ZjBhNmZmMmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTIwMjYsNiArMjAyNiwx
MSBAQCBzdGF0aWMgdm9pZCBudm1lX3VwZGF0ZV9kaXNrX2luZm8oc3RydWN0IGdlbmRpc2sgKmRp
c2ssCiAJCQljYXBhY2l0eSA9IDA7CiAJfQogCisjaWZkZWYgQ09ORklHX0JMS19ERVZfWk9ORUQK
KwlpZiAoIW5zLT56b25lX3N1cCkKKwkJY2FwYWNpdHkgPSAwOworI2VuZGlmCisKIAlzZXRfY2Fw
YWNpdHlfcmV2YWxpZGF0ZV9hbmRfbm90aWZ5KGRpc2ssIGNhcGFjaXR5LCBmYWxzZSk7CiAKIAlu
dm1lX2NvbmZpZ19kaXNjYXJkKGRpc2ssIG5zKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAppbmRleCA4NzczN2ZhMzIzNjAu
LjQyY2JlNWJiYzUxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCisrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaApAQCAtNDQzLDYgKzQ0Myw3IEBAIHN0cnVjdCBudm1l
X25zIHsKIAl1OCBwaV90eXBlOwogI2lmZGVmIENPTkZJR19CTEtfREVWX1pPTkVECiAJdTY0IHpz
emU7CisJYm9vbCB6b25lX3N1cDsKICNlbmRpZgogCXVuc2lnbmVkIGxvbmcgZmVhdHVyZXM7CiAJ
dW5zaWduZWQgbG9uZyBmbGFnczsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5j
IGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKaW5kZXggNTdjZmQ3ODczMWZiLi43N2E3ZmVkNTA4
ZWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCisrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3pucy5jCkBAIC00NCwyMCArNDQsMjMgQEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5m
byhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAogCXN0cnVjdCBudm1l
X2lkX25zX3pucyAqaWQ7CiAJaW50IHN0YXR1czsKIAotCS8qIERyaXZlciByZXF1aXJlcyB6b25l
IGFwcGVuZCBzdXBwb3J0ICovCisJbnMtPnpvbmVfc3VwID0gdHJ1ZTsKKwogCWlmICghKGxlMzJf
dG9fY3B1KGxvZy0+aW9jc1tudm1lX2NtZF96b25lX2FwcGVuZF0pICYKIAkJCU5WTUVfQ01EX0VG
RkVDVFNfQ1NVUFApKSB7CisJCW5zLT56b25lX3N1cCA9IGZhbHNlOwogCQlkZXZfd2Fybihucy0+
Y3RybC0+ZGV2aWNlLAogCQkJImFwcGVuZCBub3Qgc3VwcG9ydGVkIGZvciB6b25lZCBuYW1lc3Bh
Y2U6JWRcbiIsCiAJCQlucy0+aGVhZC0+bnNfaWQpOwotCQlyZXR1cm4gLUVJTlZBTDsKLQl9Ci0K
LQkvKiBMYXppbHkgcXVlcnkgY29udHJvbGxlciBhcHBlbmQgbGltaXQgZm9yIHRoZSBmaXJzdCB6
b25lZCBuYW1lc3BhY2UgKi8KLQlpZiAoIW5zLT5jdHJsLT5tYXhfem9uZV9hcHBlbmQpIHsKLQkJ
c3RhdHVzID0gbnZtZV9zZXRfbWF4X2FwcGVuZChucy0+Y3RybCk7Ci0JCWlmIChzdGF0dXMpCi0J
CQlyZXR1cm4gc3RhdHVzOworCX0gZWxzZSB7CisJCS8qIExhemlseSBxdWVyeSBjb250cm9sbGVy
IGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZpcnN0CisJCSAqIHpvbmVkIG5hbWVzcGFjZQorCQkgKi8K
KwkJaWYgKCFucy0+Y3RybC0+bWF4X3pvbmVfYXBwZW5kKSB7CisJCQlzdGF0dXMgPSBudm1lX3Nl
dF9tYXhfYXBwZW5kKG5zLT5jdHJsKTsKKwkJCWlmIChzdGF0dXMpCisJCQkJcmV0dXJuIHN0YXR1
czsKKwkJfQogCX0KIAogCWlkID0ga3phbGxvYyhzaXplb2YoKmlkKSwgR0ZQX0tFUk5FTCk7CkBA
IC03MywyNSArNzYsMTkgQEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlz
ayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAogCWlmIChzdGF0dXMpCiAJCWdvdG8gZnJlZV9k
YXRhOwogCi0JLyoKLQkgKiBXZSBjdXJyZW50bHkgZG8gbm90IGhhbmRsZSBkZXZpY2VzIHJlcXVp
cmluZyBhbnkgb2YgdGhlIHpvbmVkCi0JICogb3BlcmF0aW9uIGNoYXJhY3RlcmlzdGljcy4KLQkg
Ki8KIAlpZiAoaWQtPnpvYykgeworCQlucy0+em9uZV9zdXAgPSBmYWxzZTsKIAkJZGV2X3dhcm4o
bnMtPmN0cmwtPmRldmljZSwKIAkJCSJ6b25lIG9wZXJhdGlvbnM6JXggbm90IHN1cHBvcnRlZCBm
b3IgbmFtZXNwYWNlOiV1XG4iLAogCQkJbGUxNl90b19jcHUoaWQtPnpvYyksIG5zLT5oZWFkLT5u
c19pZCk7Ci0JCXN0YXR1cyA9IC1FSU5WQUw7Ci0JCWdvdG8gZnJlZV9kYXRhOwogCX0KIAogCW5z
LT56c3plID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUoaWQtPmxiYWZlW2xiYWZd
LnpzemUpKTsKIAlpZiAoIWlzX3Bvd2VyX29mXzIobnMtPnpzemUpKSB7CisJCW5zLT56b25lX3N1
cCA9IGZhbHNlOwogCQlkZXZfd2Fybihucy0+Y3RybC0+ZGV2aWNlLAogCQkJImludmFsaWQgem9u
ZSBzaXplOiVsbHUgZm9yIG5hbWVzcGFjZToldVxuIiwKIAkJCW5zLT56c3plLCBucy0+aGVhZC0+
bnNfaWQpOwotCQlzdGF0dXMgPSAtRUlOVkFMOwotCQlnb3RvIGZyZWVfZGF0YTsKIAl9CiAKIAlx
LT5saW1pdHMuem9uZWQgPSBCTEtfWk9ORURfSE07Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
