Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F7C47254
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 01:47:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FDE206A5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 01:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8o/Qhnl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bptkzkni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FDE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p7dUF7lE4nKM0EjyKlr/wnYy2dNlIW7XWN9h/KaaRYA=; b=J8o/QhnlNxMH61
	8KxdFn9vnzd4DB5w5b2pbOJRFkXVSAlHOTRoNYC47iJu4whd8lzD38suHH8JhnU6q8k1pXw6OXA5O
	qWJbXDb3W4o+dLMs1xKqsgNb3T6Gd9aL0+TlnUoh02jE3HiXTFzhpIslsqfXKyeZIXCoOg0OyVLNA
	N1cI8H6aV2HncekfjMSjSp2Cm2/yRcOo2exO/H89S0ZQ++PpX2hcy2oBPqxrgUSwDE1sdvZJp19lb
	r9QsVz5L3K+e/6U/3+R3gdgSjCHasHQ5ni4DjPojPM4AP83/Z7uo71qbaA0h5220mD/ilZ2XFErnx
	uFFLUZ7u1mUXMhXv4L1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jW99q-0002jw-R8; Wed, 06 May 2020 01:47:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW99X-0002Kf-NF
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 01:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588729648; x=1620265648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=StAlxfN/Rfccd6r5ICEJoZulBA8Fv8e0EuPISZV2j7I=;
 b=bptkzkniunku1di9Ao9Mo7y03Ard0O3Lr1ezbz9vkbiahQKlhLruBCBg
 QiQ9qhQsgkukWyI+pJHD7wFY370sG2uaOW9OyKvWtbJn6Npb6E8HZ2Puw
 Sq0ZP5b4+mmA7eqtVELDdN9vy3jb0y3Z80Ed42lnRHkjDIytKNs95MYD8
 5pe/QQpdxthSEVpbFtsA5EfJhtuuvbT5Vg5GAb2jl0/4QB+7PPoA2AT1O
 mAqrerNYSpLAflbdkeV9C43Wg/Y4sfOnxbPRRzFM50vxohNO25zqW92Uv
 3VYyQaONVnSqngojLEJZ8nEOe9oew5/cUfor+XeVqMkvFUYFCAXjE5GEg A==;
IronPort-SDR: O5MojPCVG0T8XCi6NNNrVj6jiVtUx765xalwrdx6t2/1n9aXAta788WD7AToDX+M5lbbE0ZuQG
 ffNkdrB2G7n5PqEzQnOjjKMRfmPatFpj70tzrq22LKDARyEaAtLI1Xf+1TsgcoJWzlAPHFwhuz
 9tjeODnNKTUrc0pNOkzVQ6mA+kuB9y7aCRDTf/Klw+HPSLI9nvJQTiuIPFPLaEjT7Lf3J2kmgL
 jrULuflbavr+NcvGwXBWmYiueUkHsq+Uww8ccLZyTrzMfFQzNJQehNmBd4QkhMk8vU/nfhBvTt
 lt8=
X-IronPort-AV: E=Sophos;i="5.73,357,1583164800"; d="scan'208";a="239629792"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 09:47:27 +0800
IronPort-SDR: JwnSL0Z98VGpcbXt5JjEOoHEFrfKtlAPjBcb76yAZOZZcw2/d4VLexS25K1Q2/P+4L3TmDfV4h
 cO33CGAmvK4xIv8kV4MjBvIdj3BcqKcI0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 18:37:09 -0700
IronPort-SDR: 8SumUYwKZgtB+qQRbIr2piVNor1Cu4JRg/pAG2FSyt67u1Dm/vpwq7rtqf5JIzu8PsADVRyI+Y
 4uAKEmNQKulw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 May 2020 18:47:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 3/3] nvmet: add async event tracing support
Date: Tue,  5 May 2020 18:46:29 -0700
Message-Id: <20200506014629.39509-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200505_184715_856459_42FFD7C5 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIGEgbmV3IHRyYWNlcG9pbnQgZm9yIHRoZSB0YXJnZXQgdG8gdHJhY2UgYXN5bmMg
ZXZlbnQuIFRoaXMgaXMKaGVscGZ1bCBpbiBkZWJ1Z2dpbmcgYW5kIGNvbXBhcmluZyBob3N0IGFu
ZCB0YXJnZXQgc2lkZSBhc3luYyBldmVudHMKZXNwZWNpYWxseSB3aGVuIGhvc3QgaXMgY29ubmVj
dGVkIHRvIGRpZmZlcmVudCB0YXJnZXRzIG9uIGRpZmZlcmVudAptYWNoaW5lcyBhbmQgbm93IHRo
YXQgd2UgcmVseSBvbiB1c2Vyc3BhY2UgY29tcG9uZW50cyB0byBnZW5lcmF0ZSBBRU4uwqAKClNp
Z25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5j
b20+Ci0tLQogZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgIHwgIDIgKysKIGRyaXZlcnMvbnZt
ZS90YXJnZXQvdHJhY2UuaCB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmls
ZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvY29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKaW5kZXggMjE5YmNmMjFk
NGJmLi5kNGYxMTA3OGE1NzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5j
CisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCkBAIC0xNTEsNiArMTUxLDggQEAgc3Rh
dGljIHZvaWQgbnZtZXRfYXN5bmNfZXZlbnRzX3Byb2Nlc3Moc3RydWN0IG52bWV0X2N0cmwgKmN0
cmwsIHUxNiBzdGF0dXMpCiAJCWtmcmVlKGFlbik7CiAKIAkJbXV0ZXhfdW5sb2NrKCZjdHJsLT5s
b2NrKTsKKwkJdHJhY2VfbnZtZXRfYXN5bmNfZXZlbnQoY3RybCwKKwkJCQkocmVxLT5jcWUtPnJl
c3VsdC51MzIgJiAweGZmMDApID4+IDgpOwogCQludm1ldF9yZXFfY29tcGxldGUocmVxLCBzdGF0
dXMpOwogCX0KIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaCBiL2Ry
aXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaAppbmRleCBlNjQ1Y2FhODgyZGQuLmQwMjY3MjI2Yzlh
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oCisrKyBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvdHJhY2UuaApAQCAtMTMwLDYgKzEzMCwzNCBAQCBUUkFDRV9FVkVOVChudm1l
dF9yZXFfY29tcGxldGUsCiAKICk7CiAKKyNkZWZpbmUgYWVyX25hbWUoYWVyKSB7IGFlciwgI2Fl
ciB9CisKK1RSQUNFX0VWRU5UKG52bWV0X2FzeW5jX2V2ZW50LAorCVRQX1BST1RPKHN0cnVjdCBu
dm1ldF9jdHJsICpjdHJsLCB1MzIgcmVzdWx0KSwKKwlUUF9BUkdTKGN0cmwsIHJlc3VsdCksCisJ
VFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIGN0cmxfaWQpCisJCV9fZmllbGQodTMy
LCByZXN1bHQpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJX19lbnRyeS0+Y3RybF9pZCA9IGN0
cmwtPmNudGxpZDsKKwkJX19lbnRyeS0+cmVzdWx0ID0gcmVzdWx0OworCSksCisJVFBfcHJpbnRr
KCJudm1ldCVkOiBOVk1FX0FFTj0lIzA4eCBbJXNdIiwKKwkJX19lbnRyeS0+Y3RybF9pZCwgX19l
bnRyeS0+cmVzdWx0LAorCQlfX3ByaW50X3N5bWJvbGljKF9fZW50cnktPnJlc3VsdCwKKwkJYWVy
X25hbWUoTlZNRV9BRVJfTk9USUNFX05TX0NIQU5HRUQpLAorCQlhZXJfbmFtZShOVk1FX0FFUl9O
T1RJQ0VfQU5BKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfTk9USUNFX0ZXX0FDVF9TVEFSVElORyks
CisJCWFlcl9uYW1lKE5WTUVfQUVSX05PVElDRV9ESVNDX0NIQU5HRUQpLAorCQlhZXJfbmFtZShO
Vk1FX0FFUl9FUlJPUiksCisJCWFlcl9uYW1lKE5WTUVfQUVSX1NNQVJUKSwKKwkJYWVyX25hbWUo
TlZNRV9BRVJfQ1NTKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfVlMpKQorCSkKKyk7CisjdW5kZWYg
YWVyX25hbWUKKwogI2VuZGlmIC8qIF9UUkFDRV9OVk1FVF9IICovCiAKICN1bmRlZiBUUkFDRV9J
TkNMVURFX1BBVEgKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
