Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C5C47257
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 01:47:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095A6206A5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 01:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c6I+q2PA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SRiVi1B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A6206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S/kBh6WY9z3ujz9OAVU8BCJ4WozCKqGVBH7FWGJez3s=; b=c6I+q2PA+BcUoo
	j045TVE3nKA4M4zVonjTYVIrIgsUKb0GAZPI8jkGCWeXn691onkte1PlRkUgJA4d/G7IFbH4teDbM
	tSzZb4ohbYyFCTJ9TJUV+UEQcInGuP28/6dtwYZiRsQTPJbWn6eXKlQ+tssfiORmTM6tUiQb1Kz0S
	oySChJyBVCuA7xYfJocILFeMsNAZ7iJbxKzeV9019oyoFT2dvuAiJ8vPA9urOfJIzhIXbYsoai8v1
	pAWww7Q7LjVGQ63p9pSzA70Y/S17QQ8yPMAlv/6jx93XHawC0MnSr4zSoFg6AKxJhYVrII40E+3jO
	OhcCP9qR8+UeIwAZ5vdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jW99V-0002Mf-Kw; Wed, 06 May 2020 01:47:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW99Q-0002EX-G9
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 01:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588729628; x=1620265628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J6JGX16B6dAoCJ67BJgNaU2PD3GCP3YJJJTBevjJ9BE=;
 b=SRiVi1B+3CE8HlVCW+AjNW/kdyJ/V7G1sAjZptWMBeUYMjJ87DDkNdiB
 /0L/jEi7rQL3+jk5uuuL494lSnH13+/gcOdLwyOnh0pyrrUWdao08GEy7
 mLC4Rm5KM8PbEDweHB3GlNLWt61ahOF09CfDuImrCKzEIvF0smVAOZ9cb
 VbXxFmOcSHuBKJyycNDUnVqFK/Ri+YKzvLRzurhRoqfMjRMIddR5Kcz5w
 DHY+20ozKWKQzM6KcmscbIrXjRLr0q1WuaBMTxk5mzZOECKaCnJnd2gcB
 n4djVdqpcdma+My6pHclozwuhoVAn5je4mFqMNaCK25A7Yg0gUCGD1gBS A==;
IronPort-SDR: NddQDNXjQAKPfn8vbtGATjtthlJEkZxNNxZqpUOfU7nWQgC50RC1zlbA20kUA5cqgCEX0qmWXw
 fZgcJgGlynM1q8sM1MFnAbksk/T6M6UaZ0ZJtoFQid6yXNUT6vTog/cdGIv+/Mm2a/HOM4Jnk/
 qQsrcP+4LQ47j3QzSBVQQ06z5yfng+SP8vQ9vpKWblUqTwNQY5uzBKzILfZ1VWRN9VQtjFAeB6
 jMfOqDwOTX7TdltbImTK5LbKEQbYVIwTovMWp4tEh5ziPWYrn18NvhdZav+jEwME6EHQDiESkQ
 DUA=
X-IronPort-AV: E=Sophos;i="5.73,357,1583164800"; d="scan'208";a="137339266"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 09:47:05 +0800
IronPort-SDR: 0pbtkJtWSo7nxYTzIcnm0UCYMIx3RgfT8Nd0WN+bz9gu58EZLif8u9c3zvvRijeeLFA3J6tVYz
 TC/0F5b7ZlW3QAOKNdgAqCgKa6LuEGBRo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 18:36:59 -0700
IronPort-SDR: U2fPU0R2mXe710F0mM3l4Z8gVGYoMvcOB0LN/p1chO+pnOSGaaCMVPzT5yw1AUJrsvRWabSOux
 +Zf13vdAuB0Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 May 2020 18:47:04 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 1/3] nvmet: add helper to revalidate bdev and file ns
Date: Tue,  5 May 2020 18:46:27 -0700
Message-Id: <20200506014629.39509-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200505_184708_569244_B328B8C6 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBhZGRzIGEgd3JhcHBlciBoZWxwZXIgdG8gaW5kaWNhdGUgc2l6ZSBjaGFuZ2Ug
aW4gdGhlIGJkZXYgJgpmaWxlLWJhY2tlZCBuYW1lc3BhY2Ugd2hlbiByZXZhbGlkYXRpbmcgbnMu
IFRoZSBuZXcgaGVscGVyCm52bWV0X25zX3JldmFsaWF0ZSgpIHJldHVybnMgdHJ1ZSBpZiB0aGUg
bmV3IHNpemUgaXMgZGlmZmVyZW50IHRoYW7CoHRoZQpvcmlnaW5hbCBzaXplIGZhbHNlIG90aGVy
d2lzZS4gVGhpcyBoZWxwZXIgaXMgbmVlZGVkIGluIG9yZGVyIHRvCm1pbmltaXplIGNvZGUgcmVw
ZXRpdGlvbiBpbiB0aGUgbmV4dCBwYXRjaCBmb3IgY29uZmlnZnMuYyBhbmQgZXhpc3RpbmcKYWRt
aW4tY21kLmMuIMKgCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55
YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMg
ICB8ICA1ICstLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyAgICAgICAgfCAgOCArKysr
KysrKwogZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIHwgIDYgKysrKystCiBkcml2
ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1maWxlLmMgfCAxMSArKysrKysrKy0tLQogZHJpdmVycy9u
dm1lL3RhcmdldC9udm1ldC5oICAgICAgIHwgIDUgKysrLS0KIDUgZmlsZXMgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L3RhcmdldC9hZG1pbi1jbWQuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMKaW5k
ZXggNGM3OWFhODA0ODg3Li5mNTQ0YTE0ZThiNWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvYWRtaW4tY21kLmMKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwpA
QCAtNDg2LDEwICs0ODYsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5X25z
KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAlpZiAoIW5zKQogCQlnb3RvIGRvbmU7CiAKLQlpZiAo
bnMtPmJkZXYpCi0JCW52bWV0X2JkZXZfbnNfcmV2YWxpZGF0ZShucyk7Ci0JZWxzZQotCQludm1l
dF9maWxlX25zX3JldmFsaWRhdGUobnMpOworCW52bWV0X25zX3JldmFsaWRhdGUobnMpOwogCiAJ
LyoKIAkgKiBudXNlID0gbmNhcCA9IG5zemUgaXNuJ3QgYWx3YXlzIHRydWUsIGJ1dCB3ZSBoYXZl
IG5vIHdheSB0byBmaW5kCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBi
L2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCmluZGV4IGI2ODVmOTlkNTZhMS4uMjE5YmNmMjFk
NGJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYworKysgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L2NvcmUuYwpAQCAtNTE0LDYgKzUxNCwxNCBAQCBzdGF0aWMgdm9pZCBudm1l
dF9wMnBtZW1fbnNfYWRkX3AycChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwKIAkJbnMtPm5zaWQp
OwogfQogCitib29sIG52bWV0X25zX3JldmFsaWRhdGUoc3RydWN0IG52bWV0X25zICpucykKK3sK
KwlpZiAobnMtPmJkZXYpCisJCXJldHVybiBudm1ldF9iZGV2X25zX3JldmFsaWRhdGUobnMpOwor
CisJcmV0dXJuIG52bWV0X2ZpbGVfbnNfcmV2YWxpZGF0ZShucywgTlVMTCk7Cit9CisKIGludCBu
dm1ldF9uc19lbmFibGUoc3RydWN0IG52bWV0X25zICpucykKIHsKIAlzdHJ1Y3QgbnZtZXRfc3Vi
c3lzICpzdWJzeXMgPSBucy0+c3Vic3lzOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9pby1jbWQtYmRldi5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jCmluZGV4
IDA0MjdlMDQwZTNkZC4uMzQ0NDM4ODFhMzg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2lvLWNtZC1iZGV2LmMKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5j
CkBAIC03NSw5ICs3NSwxMyBAQCB2b2lkIG52bWV0X2JkZXZfbnNfZGlzYWJsZShzdHJ1Y3QgbnZt
ZXRfbnMgKm5zKQogCX0KIH0KIAotdm9pZCBudm1ldF9iZGV2X25zX3JldmFsaWRhdGUoc3RydWN0
IG52bWV0X25zICpucykKK2Jvb2wgbnZtZXRfYmRldl9uc19yZXZhbGlkYXRlKHN0cnVjdCBudm1l
dF9ucyAqbnMpCiB7CisJbG9mZl90IG9sZHNpemUgPSBucy0+c2l6ZTsKKwogCW5zLT5zaXplID0g
aV9zaXplX3JlYWQobnMtPmJkZXYtPmJkX2lub2RlKTsKKworCXJldHVybiBvbGRzaXplICE9IG5z
LT5zaXplID8gdHJ1ZSA6IGZhbHNlOwogfQogCiBzdGF0aWMgdTE2IGJsa190b19udm1lX3N0YXR1
cyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEsIGJsa19zdGF0dXNfdCBibGtfc3RzKQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtZmlsZS5jIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9pby1jbWQtZmlsZS5jCmluZGV4IGYwYmQwOGQ4NmFjMC4uZjA4OTJmMzEwYWUwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1maWxlLmMKKysrIGIvZHJpdmVycy9udm1l
L3RhcmdldC9pby1jbWQtZmlsZS5jCkBAIC0xMyw4ICsxMyw5IEBACiAjZGVmaW5lIE5WTUVUX01B
WF9NUE9PTF9CVkVDCQkxNgogI2RlZmluZSBOVk1FVF9NSU5fTVBPT0xfT0JKCQkxNgogCi1pbnQg
bnZtZXRfZmlsZV9uc19yZXZhbGlkYXRlKHN0cnVjdCBudm1ldF9ucyAqbnMpCitib29sIG52bWV0
X2ZpbGVfbnNfcmV2YWxpZGF0ZShzdHJ1Y3QgbnZtZXRfbnMgKm5zLCBpbnQgKnJldHApCiB7CisJ
bG9mZl90IG9sZHNpemUgPSBucy0+c2l6ZTsKIAlzdHJ1Y3Qga3N0YXQgc3RhdDsKIAlpbnQgcmV0
OwogCkBAIC0yMiw3ICsyMywxMSBAQCBpbnQgbnZtZXRfZmlsZV9uc19yZXZhbGlkYXRlKHN0cnVj
dCBudm1ldF9ucyAqbnMpCiAJCQkgIEFUX1NUQVRYX0ZPUkNFX1NZTkMpOwogCWlmICghcmV0KQog
CQlucy0+c2l6ZSA9IHN0YXQuc2l6ZTsKLQlyZXR1cm4gcmV0OworCisJaWYgKHJldHApCisJCSpy
ZXRwID0gcmV0OworCisJcmV0dXJuIG9sZHNpemUgIT0gbnMtPnNpemUgPyB0cnVlIDogZmFsc2U7
CiB9CiAKIHZvaWQgbnZtZXRfZmlsZV9uc19kaXNhYmxlKHN0cnVjdCBudm1ldF9ucyAqbnMpCkBA
IC01NCw3ICs1OSw3IEBAIGludCBudm1ldF9maWxlX25zX2VuYWJsZShzdHJ1Y3QgbnZtZXRfbnMg
Km5zKQogCQlyZXR1cm4gUFRSX0VSUihucy0+ZmlsZSk7CiAJfQogCi0JcmV0ID0gbnZtZXRfZmls
ZV9uc19yZXZhbGlkYXRlKG5zKTsKKwludm1ldF9maWxlX25zX3JldmFsaWRhdGUobnMsICZyZXQp
OwogCWlmIChyZXQpCiAJCWdvdG8gZXJyOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFy
Z2V0L252bWV0LmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKaW5kZXggM2Q5ODFlYjZl
MTAwLi45MGM3YTYxZDcyNjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQu
aAorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKQEAgLTQ5OCw4ICs0OTgsOSBAQCB2
b2lkIG52bWV0X2ZpbGVfbnNfZGlzYWJsZShzdHJ1Y3QgbnZtZXRfbnMgKm5zKTsKIHUxNiBudm1l
dF9iZGV2X2ZsdXNoKHN0cnVjdCBudm1ldF9yZXEgKnJlcSk7CiB1MTYgbnZtZXRfZmlsZV9mbHVz
aChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpOwogdm9pZCBudm1ldF9uc19jaGFuZ2VkKHN0cnVjdCBu
dm1ldF9zdWJzeXMgKnN1YnN5cywgdTMyIG5zaWQpOwotdm9pZCBudm1ldF9iZGV2X25zX3JldmFs
aWRhdGUoc3RydWN0IG52bWV0X25zICpucyk7Ci1pbnQgbnZtZXRfZmlsZV9uc19yZXZhbGlkYXRl
KHN0cnVjdCBudm1ldF9ucyAqbnMpOworYm9vbCBudm1ldF9iZGV2X25zX3JldmFsaWRhdGUoc3Ry
dWN0IG52bWV0X25zICpucyk7Citib29sIG52bWV0X2ZpbGVfbnNfcmV2YWxpZGF0ZShzdHJ1Y3Qg
bnZtZXRfbnMgKm5zLCBpbnQgKnJldCk7Citib29sIG52bWV0X25zX3JldmFsaWRhdGUoc3RydWN0
IG52bWV0X25zICpucyk7CiAKIHN0YXRpYyBpbmxpbmUgdTMyIG52bWV0X3J3X2xlbihzdHJ1Y3Qg
bnZtZXRfcmVxICpyZXEpCiB7Ci0tIAoyLjIyLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
