Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C38C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:51:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DC4212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XpRSsN6w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p3y/vyml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="alLi22d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DC4212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rnk1Nwt4lINHq2X8MQocskH2FI+t9pJFOga0cEkM/UQ=; b=XpRSsN6wsPHL6A
	JscBMoAtt14GTajtLRJfhSUWcGOKGSFn8hK07NSFt50Pg+opdbwMcSHVtw53a2iSCB9hszFHLMCLk
	w3bynXAlivTlMFV6YifD1QqHHoFw+jSS4w4iR6ZEfkZQuDL/hMzXScMHkE+R0LfXPlc+sosLWuo4c
	foH/LttbPNuAobfMnDQCx8zXx9XYHeocBjgM4pSu+rF3v5JaQ77MH1xmkmtIq6Z+Rzv7DckRfC63n
	41C67PTgbT+MNqygnz69znY9OJBbi+CB6SelvRa3ia0xbvBalxyarLVqzvhKYbEy0NF8K5wFwshso
	3nH2gDwf+o7dG8RLb4KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJih-0000K6-RZ; Sun, 19 Apr 2020 23:51:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJih-0000Jk-1w
 for linux-nvme@bombadil.infradead.org; Sun, 19 Apr 2020 23:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=PxQ522Ojlx5eKp5K3jDMoNX1kLChC7JTZvbFzbOHf7o=; b=p3y/vymlBsrdGjAMUYFP99C+5F
 lIhp5UT/XSKC7blePQ854FhMFWmSdzwdncMetJskvUzTbMYjloyPMlo16qhx/NajHeiQds1Ic5x0g
 0F3N7Qin5RwSGKs1LudkRS7uaUfSsWiSsMaPQYTEPhYoegiZBnpmRPp2FiBP8AAMqW0VNJNYAzV14
 iqCyLKaecWop3+Nx4S5ZpnOD7eFxX0qdt9LmNbpV7OyRNBdL6bd6dn0g5kZdzzRV27YK10Y4wMv83
 zfeOLO0/X+Za4xMC43szhqgjk2fQaTIk6INNetnO3/BtXFXAvaZPdWduWZF1vf1GYmQaCurdgtQmg
 4TbEOc5A==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJic-0004HD-Ku
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340283; x=1618876283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gI5sQG81mzX6B57pm+1gRIGLNVQf0xgQmlN9zfqZKqQ=;
 b=alLi22d57+AeTuEV7gBnNe+giNK6J1VTSmjcFdfbRJTju8uzt6PpHYJc
 +e4aSCf+3wduLEDbGQ3W3M/0tKHPj/VDbCqRF3hG5ZuDUl0AzLApHopXr
 lQPRXDhGJihfn4gCJOgeAQRp4eLDxI60ybuVouUcv7smHX9gsObR10LyD
 aGlCtDLu14FVh1mM7pyaWH+NxfRqnPh5RMK/+giOvMM7zSAxXKY9YxeNn
 5bofmRu7ezeqmyTAKVu31ZpWxsoEimjtSGQpjLUb/vFSoE+Lo+xQkDSxs
 o8Cy4lAwwpZyR/Vznl/61rYuiuO62i8z8ZLZstXif7yXmX5Sqo0EitdBI Q==;
IronPort-SDR: GY0gt1jgFtRleRrEI+lTi4MoK/ZmWY8a723AjQdmuBgjheuDlAtNCUGvoKFlk/UBKnidHvF4AH
 RqSzItp9/VFnosw01v3unMaK918TXCU1Db5QblRgz/GmbjpDmkITEYFwmYwgvHWTmkqMbVEzBw
 C2pCGdvD6BmBY2SgdHxYNAD1qHKw5+JvSb4hnzY092yMCY2If6evKgA8n2kiqNTLGkI+dOxyDY
 tVk6Hxs80hyV8mka7yIoNQkcH7mXbkENRBfTrRclhEf3ZZmiq2rO6+t1XnAuz9rljxwqVextLk
 uh8=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="135976417"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:49:57 +0800
IronPort-SDR: b3S7Y/pRVAaRy4nBH3rhAzuuPiOYvJTQaA26/Io2xmEZy5ezVyz62NgGzXLe2APf5tQMWrz8jm
 69zoGyFxWFdD+PS0PR6DP12ynFPjSiEsY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:40:51 -0700
IronPort-SDR: +NkmW2Yex6cyA0dfDdIW305F+thMq3zHGy70m2UJOS9fYwAXUeQQ8agm9mCZ485NOFsIyvIeDo
 QDZKMRB54yRg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:56 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 7/7] nvmet: add async event tracing support
Date: Sun, 19 Apr 2020 16:48:56 -0700
Message-Id: <20200419234856.59901-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_005123_264343_3F551DFA 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIGEgbmV3IHRyYWNlcG9pbnQgZm9yIHRoZSB0YXJnZXQgdG8gdHJhY2UgYXN5bmMg
ZXZlbnQuIFRoaXMgaXMKaGVscGZ1bCBpbiBkZWJ1Z2dpbmcgYW5kIGNvbXBhcmluZyBob3N0IGFu
ZCB0YXJnZXQgc2lkZSBhc3luYyBldmVudHMuwqAKClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Ci0tLQogZHJpdmVycy9udm1lL3Rh
cmdldC9jb3JlLmMgIHwgIDIgKysKIGRyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaCB8IDI4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIGIvZHJpdmVycy9u
dm1lL3RhcmdldC9jb3JlLmMKaW5kZXggNjNmYmQzMGYwZWMxLi43NDljMmQxZWM4ZWMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29yZS5jCkBAIC0xNTQsNiArMTU0LDggQEAgc3RhdGljIHZvaWQgbnZtZXRfYXN5bmNfZXZl
bnRzX3Byb2Nlc3Moc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsIHUxNiBzdGF0dXMpCiAJCWtmcmVl
KGFlbik7CiAKIAkJbXV0ZXhfdW5sb2NrKCZjdHJsLT5sb2NrKTsKKwkJdHJhY2VfbnZtZXRfYXN5
bmNfZXZlbnQoY3RybCwKKwkJCQkocmVxLT5jcWUtPnJlc3VsdC51MzIgJiAweGZmMDApID4+IDgp
OwogCQludm1ldF9yZXFfY29tcGxldGUocmVxLCBzdGF0dXMpOwogCX0KIH0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2Uu
aAppbmRleCBlNjQ1Y2FhODgyZGQuLmQwMjY3MjI2YzlhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL3RhcmdldC90cmFjZS5oCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaApAQCAt
MTMwLDYgKzEzMCwzNCBAQCBUUkFDRV9FVkVOVChudm1ldF9yZXFfY29tcGxldGUsCiAKICk7CiAK
KyNkZWZpbmUgYWVyX25hbWUoYWVyKSB7IGFlciwgI2FlciB9CisKK1RSQUNFX0VWRU5UKG52bWV0
X2FzeW5jX2V2ZW50LAorCVRQX1BST1RPKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsLCB1MzIgcmVz
dWx0KSwKKwlUUF9BUkdTKGN0cmwsIHJlc3VsdCksCisJVFBfU1RSVUNUX19lbnRyeSgKKwkJX19m
aWVsZChpbnQsIGN0cmxfaWQpCisJCV9fZmllbGQodTMyLCByZXN1bHQpCisJKSwKKwlUUF9mYXN0
X2Fzc2lnbigKKwkJX19lbnRyeS0+Y3RybF9pZCA9IGN0cmwtPmNudGxpZDsKKwkJX19lbnRyeS0+
cmVzdWx0ID0gcmVzdWx0OworCSksCisJVFBfcHJpbnRrKCJudm1ldCVkOiBOVk1FX0FFTj0lIzA4
eCBbJXNdIiwKKwkJX19lbnRyeS0+Y3RybF9pZCwgX19lbnRyeS0+cmVzdWx0LAorCQlfX3ByaW50
X3N5bWJvbGljKF9fZW50cnktPnJlc3VsdCwKKwkJYWVyX25hbWUoTlZNRV9BRVJfTk9USUNFX05T
X0NIQU5HRUQpLAorCQlhZXJfbmFtZShOVk1FX0FFUl9OT1RJQ0VfQU5BKSwKKwkJYWVyX25hbWUo
TlZNRV9BRVJfTk9USUNFX0ZXX0FDVF9TVEFSVElORyksCisJCWFlcl9uYW1lKE5WTUVfQUVSX05P
VElDRV9ESVNDX0NIQU5HRUQpLAorCQlhZXJfbmFtZShOVk1FX0FFUl9FUlJPUiksCisJCWFlcl9u
YW1lKE5WTUVfQUVSX1NNQVJUKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfQ1NTKSwKKwkJYWVyX25h
bWUoTlZNRV9BRVJfVlMpKQorCSkKKyk7CisjdW5kZWYgYWVyX25hbWUKKwogI2VuZGlmIC8qIF9U
UkFDRV9OVk1FVF9IICovCiAKICN1bmRlZiBUUkFDRV9JTkNMVURFX1BBVEgKLS0gCjIuMjIuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
