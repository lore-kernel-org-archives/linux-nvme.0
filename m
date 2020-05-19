Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D50C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:06:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573CC207FB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ok14rC72";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P1V8QVcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573CC207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHULZKf3MT2sYxIF0PIoUhjDqYpWJt/76J3msnL8vIo=; b=ok14rC72+t31wf
	EReeIWYoOs+HDjQBhDfIu56T5LL0tLprEpl2GAf6xpvpnLrH5shp7d0BUgQG2ntym65H1lY+anc5+
	4SRFVZJp7N2KupEN5FvWt6W/7HpBcGV0fruSPLC1sRpUL12FvmpJ8huc7JbMBiRCQdWRQI26lNEto
	xQXuGKZzLA222v3qCCsHgQ+9momtq80/uOwQozW6oreAPGk83cJz5Fca9n32Gnl2GmbUDgFZBD9Xz
	gOC/KnTkGKqiSxK4WMZQayCM3qLJHf0lB2zcHBzj6k2ELFT0jQY10cBVjwYmJJEkGrR2sOO0MZ4in
	npQQ0GQGIuNKrTbyULyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxGp-0006Dj-5i; Tue, 19 May 2020 08:06:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxGl-0006AD-Lk
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589875618; x=1621411618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PAXNOt/gYgLDe/1MYgBDzRFwzYrVrwbTbXg8eF5JGV4=;
 b=P1V8QVcj5e7TRLwOUabGbptWUDNjtIx+ZyM/OJABpjdgygUVsp+eqk1j
 dt/aLhf9qow3Gmy95YDJnLunc1l/ZZ/j7sK7Y3ScBgvR1DFT9x80vw/R7
 hYMyLPGKDyMmEHw6Z2XyZkxQD4mVQRGx7I9X2npeoJYk87/lxBnlao93z
 edHyyzu92tkHRYRAXOgdHUqDk7DrxDhzSyatp9uKE3GIZfXGgaudXZbTh
 lLMAg6fHWVIIu7vcW14TqAa4tTMTBRhiPolX7q27Yi9TUjtfuQMtJ6iBo
 Dg/brjNaqOWrIVgJ9kkvO9AdN2SQAsjVgOtO7AmNbT/v7BYGDToHv3BT6 Q==;
IronPort-SDR: bOxpTS1Xvhi5GWs+xFPtmbgRC0m6oeimSP3pA1bsCE6DCLFriYQBJlW9i84Qan9afTECtcb1mT
 CD02IJ74m3DUAMwqHBf9Pbir2gROuQh1bpuBMa134yXzCL0x723G3950A92Znj8EndJnaMVSI7
 4ZsWV7acB1ZTcPwa1yRK3PuRd/C7yBFBDaaNCp+rf67QR3B2hPc0fuyOMzlAtP6a5veguB/oOh
 wYVNRYcmZ6E25VJsZfeBZpKfAj1AueTTiqoCUhouh8qF52KZuEpj948w4uTd2b9uU1fj+Xzbge
 QGg=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; d="scan'208";a="240756800"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:06:58 +0800
IronPort-SDR: 4M3rtTn1zwkb9QaiqQ8F2/KoDtYfrMQb8V4Wl/E39h7fPTlHdJJDH+pWHCLxSkiIZGAURJiaM4
 8A8RjjAvuYaxpfldujBh8lZ42eGRaE58U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 00:56:39 -0700
IronPort-SDR: R8S1RsUgXg9k7pY1djYh1/FJT0qCDQdD8ZW/bjdaKYY8JEJe3i1L5iqYm3SoraJ0KowmNqLGTL
 eoIi/kF7WIZQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 01:06:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 1/4] nvmet: add helper to revalidate bdev and file ns
Date: Tue, 19 May 2020 01:06:27 -0700
Message-Id: <20200519080630.3500-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
References: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_010635_796331_743DD604 
X-CRM114-Status: GOOD (  12.58  )
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
IFRoaXMgaGVscGVyIGlzIG5lZWRlZCBpbgpvcmRlciB0byBtaW5pbWl6ZSBjb2RlIHJlcGV0aXRp
b24gaW4gdGhlIG5leHQgcGF0Y2ggZm9yIGNvbmZpZ2ZzLmMgYW5kCmV4aXN0aW5nIGFkbWluLWNt
ZC5jLiDCoAoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vs
a2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIHwgNSAr
LS0tLQogZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgICAgICB8IDggKysrKysrKysKIGRyaXZl
cnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICAgfCAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2FkbWluLWNtZC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCA0
Yzc5YWE4MDQ4ODcuLmY1NDRhMTRlOGI1YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9hZG1pbi1jbWQuYworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC00
ODYsMTAgKzQ4Niw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfbnMoc3Ry
dWN0IG52bWV0X3JlcSAqcmVxKQogCWlmICghbnMpCiAJCWdvdG8gZG9uZTsKIAotCWlmIChucy0+
YmRldikKLQkJbnZtZXRfYmRldl9uc19yZXZhbGlkYXRlKG5zKTsKLQllbHNlCi0JCW52bWV0X2Zp
bGVfbnNfcmV2YWxpZGF0ZShucyk7CisJbnZtZXRfbnNfcmV2YWxpZGF0ZShucyk7CiAKIAkvKgog
CSAqIG51c2UgPSBuY2FwID0gbnN6ZSBpc24ndCBhbHdheXMgdHJ1ZSwgYnV0IHdlIGhhdmUgbm8g
d2F5IHRvIGZpbmQKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIGIvZHJp
dmVycy9udm1lL3RhcmdldC9jb3JlLmMKaW5kZXggYjY4NWY5OWQ1NmExLi44NmE3NWM3Nzc5ZDUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZt
ZS90YXJnZXQvY29yZS5jCkBAIC01MTQsNiArNTE0LDE0IEBAIHN0YXRpYyB2b2lkIG52bWV0X3Ay
cG1lbV9uc19hZGRfcDJwKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsLAogCQlucy0+bnNpZCk7CiB9
CiAKK3ZvaWQgbnZtZXRfbnNfcmV2YWxpZGF0ZShzdHJ1Y3QgbnZtZXRfbnMgKm5zKQoreworCWlm
IChucy0+YmRldikKKwkJbnZtZXRfYmRldl9uc19yZXZhbGlkYXRlKG5zKTsKKwllbHNlCisJCW52
bWV0X2ZpbGVfbnNfcmV2YWxpZGF0ZShucyk7Cit9CisKIGludCBudm1ldF9uc19lbmFibGUoc3Ry
dWN0IG52bWV0X25zICpucykKIHsKIAlzdHJ1Y3QgbnZtZXRfc3Vic3lzICpzdWJzeXMgPSBucy0+
c3Vic3lzOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIGIvZHJpdmVy
cy9udm1lL3RhcmdldC9udm1ldC5oCmluZGV4IDNkOTgxZWI2ZTEwMC4uOTNlMGMyYWEzZTcxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKKysrIGIvZHJpdmVycy9udm1l
L3RhcmdldC9udm1ldC5oCkBAIC01MDAsNiArNTAwLDcgQEAgdTE2IG52bWV0X2ZpbGVfZmx1c2go
c3RydWN0IG52bWV0X3JlcSAqcmVxKTsKIHZvaWQgbnZtZXRfbnNfY2hhbmdlZChzdHJ1Y3QgbnZt
ZXRfc3Vic3lzICpzdWJzeXMsIHUzMiBuc2lkKTsKIHZvaWQgbnZtZXRfYmRldl9uc19yZXZhbGlk
YXRlKHN0cnVjdCBudm1ldF9ucyAqbnMpOwogaW50IG52bWV0X2ZpbGVfbnNfcmV2YWxpZGF0ZShz
dHJ1Y3QgbnZtZXRfbnMgKm5zKTsKK3ZvaWQgbnZtZXRfbnNfcmV2YWxpZGF0ZShzdHJ1Y3QgbnZt
ZXRfbnMgKm5zKTsKIAogc3RhdGljIGlubGluZSB1MzIgbnZtZXRfcndfbGVuKHN0cnVjdCBudm1l
dF9yZXEgKnJlcSkKIHsKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
