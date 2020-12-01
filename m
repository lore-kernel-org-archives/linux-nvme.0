Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50750C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DBB20725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/VzFeUw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y4ru6fo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DBB20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lAVH9pAWQdQ/7u3VsoX0Bn0IUOhZNiFoq5qHC+oVLAA=; b=Q/VzFeUw5Bs4sgXjuLajTtkVm
	4LPecF56WoBDOikPxXOTNtI9bc/8vZIJWvTigCJA2YE2l6vwYfvy3LS9VVs8o6UhpJ7MpkdaX9RtW
	2QgG79IdcwJ+qXf6UjFb5/LLtr7qKfgUpOcUMLYixqM4/qFGeC/QB6MM5ABGLy17fuk/VzAUlLdOK
	qRvoJMc4GQHvEWcR8ypOuq98uxO/MpHz353i4WUlM5d7eUeITGMzsT16Gwpyz4rtudXFzqWE/wX1t
	6IGp4hTK+QnfUhuXqWu9AKHy4tzK0mSzl+NwYZ3fTLa0ewE57XBgfMeG8gswHub5oIZW8TLi1aNsx
	wHLYdjQVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx45-0008N4-J3; Tue, 01 Dec 2020 04:14:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx42-0008Lu-MY
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796094; x=1638332094;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
 b=Y4ru6fo7dTglG6Dep2t1MkWH4ZVhgc+Z1zuLciJ0IrKO5Y4/4uMFgqel
 rCRlVo//9+N2UVSbXoHSuJruv8753W4p9bZ3fi9EHavGX2lalD+RYgLY0
 l864GqioK5scgb9ClY1cjkRcYJk3QG0GYJHVND+7lnlfehn80lAbqnN2y
 Z3zSKYU2LfVChimjAGepnON0VpwX4TS588P0Ltc7pNZ90/PGMK7cJey1/
 /hX0W0ga6bXaJUKHqAfJzWtcUGIJj3qevKxUdszT7ZnHDxzQZOTq9u5UC
 2i5h51Y8oj40oqfKDhxKOgfaVXWtrmf79yWC9mdeS6GH8rJluk/N27ywg A==;
IronPort-SDR: HvDIQPvB0BXjusucobU0BczqO2/YOIQxeWcFzandfxEhY3EJ0EkECUj1svAjtCuM6OSPDjdHYT
 m7QPSlLPrERm8tGuyvkYYj0ychpslmF8P8cXJwRS2X7aJNk5K9H+g8m611OgxLbq+shMP6mmlR
 V8l1u9B/mRXxIyZAMVMEPPYii1b1HEi4A3XUBqu+59MxAegQtqg8gEST6l3N4zxesDct1t/ycf
 xqAwRUy6EyV3/VInCEIPbgtrzPxg4ovUxLtBxyxMJd+uzQsnB65ELKHO/cduTi0MY8RJLUyfD/
 GzQ=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="155078157"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:54 +0800
IronPort-SDR: eQ/f1LWPRwgeEMWIAouuTJLE6EzXOUSi9/EHP4VDFeKFzPerYXUDy/AOPjHVVqU176+5s48pLV
 ZI4eSU4aTcVNQYOL+sBv5t8udi8l5Y2Ao=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:59:06 -0800
IronPort-SDR: 5htoikVM1SkY+ej8If5dpDTgcxoRwylrhnTsqR9sjWeSXn0Wk4fe7mQrlNd1wtGAyq8PXTCm/X
 aJRr4nVlpHSQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date: Mon, 30 Nov 2020 20:14:11 -0800
Message-Id: <20201201041416.16293-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231454_887253_BF9794C8 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2hlbiBkaXNjb3ZlcmluZyB0aGUgWk5TLCB0aGUgaG9zdC1zaWRlwqBsb29rcyBmb3IgdGhlIE5W
TUVfQ1NJX1pOUwp2YWx1ZSBpbiB0aGUgbnMtZGVzYy4gVXBkYXRlIHRoZSBudm1ldF9leGVjdXRl
X2lkZW50aWZ5X2Rlc2NsaXN0KCkKc3VjaCB0aGF0IGl0IGNhbiBub3cgdXBkYXRlIHRoZSBucy1k
ZXNjIHdpdGggTlZNRV9DU0lfWk5TIGlmIGJkZXYgaXMKem9uZWQuCgpTaWduZWQtb2ZmLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZl
cnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5j
IGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCBjNjRiNDBjNjMxZTAuLmQ0
ZmMxYmIxYTMxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwor
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC02MjgsNiArNjI4LDEwIEBA
IHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfZGVzY2xpc3Qoc3RydWN0IG52bWV0
X3JlcSAqcmVxKQogCQkJZ290byBvdXQ7CiAJfQogCisJc3RhdHVzID0gbnZtZXRfcHJvY2Vzc196
bnNfY2lzKHJlcSwgJm9mZik7CisJaWYgKHN0YXR1cykKKwkJZ290byBvdXQ7CisKIAlpZiAoc2df
emVyb19idWZmZXIocmVxLT5zZywgcmVxLT5zZ19jbnQsIE5WTUVfSURFTlRJRllfREFUQV9TSVpF
IC0gb2ZmLAogCQkJb2ZmKSAhPSBOVk1FX0lERU5USUZZX0RBVEFfU0laRSAtIG9mZikKIAkJc3Rh
dHVzID0gTlZNRV9TQ19JTlRFUk5BTCB8IE5WTUVfU0NfRE5SOwotLSAKMi4yMi4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
