Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A4FC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 04:31:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E55520787
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 04:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="chCV7O5x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CWzUQsTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E55520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cN49PG9aITpKHMaBde28PvzJWopXruZKD6nLpLs81IE=; b=chCV7O5xX2iQi1
	uwUHNS8lEtXqe43NOoYdyYAyng2ZNRnoycLZQTqtbO+B+RvlkDtbxojmj34g663fiY6kVjycRvlnh
	Xz0ckyOXSl9Dkv7L9aioC3J8K9te71d92QIt8m5PRHJPqVNUyAVSEi2Okco+QWBD7/r407+0w4N7g
	XzmEOBfdopECz9/o9ydGBdreUSjn+UQiXtbRF0rzXhWH/K2PQHxfaqjV7TeeigUeTUpMwWLaj546u
	akn1o282/CYmNjNPMYsd1XrPO8zFEX48nOqE9/qYdps9hkb0fEZPRlMM+TSSVAiShlBl9FdKZVn1P
	SWlsQvBikDzQh+V1u9ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaXR1-000250-SL; Mon, 18 May 2020 04:31:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaXQV-0001YH-11
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 04:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589776254; x=1621312254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=js+V3zgtwWLM68ZZqtX50b4P/N9XKeYCTTZR/OJfj44=;
 b=CWzUQsTP/p7qQNYA9aIgSPTcOeNZ9pj3FwKEc/oGRiCOBvAds76Kj8iD
 wMw7bj61g8b6ykYFtIVZweC0UemjTv63Mw2MYTKKcI4WTIy+QlwDJz54C
 sMtcZBs+uYTftHR+cvsw8AcO4dwzP2tBD9NWj3aCsewXehkxvBm8E0VYy
 Ez1blNKSAT/RGkCkJrv4/8saVl3fLYIZME92EBDFI1CT9CT6RgUZP2xAk
 99cfagG/UG52RV3Qwc/ZRFOcwghR76eNLODWlA5IS0ECcAG3dLKaZ4NB+
 Fh48xljIe3ItCBGYmrgag9kinbEY9Z32rEtsD1zc6KhVJ8kqDG6uWMnKn w==;
IronPort-SDR: fQnk/aJPKaHE2OkKJP3AHbBv4Cmw7AN7CV4iMxQgrbw9NLhN/8OlNpHQoV4H7dQurzxoXLN6CL
 JPYKkPnIxHRMr4VxNpHjU90OqbYqQTM5aZJgpxmJ/GdpQS+JlFImOsjPJzSwIu3R9LGr/FUlsa
 t2NqpkDmV6a8U72x6wkV1QJD4m8VrOYh3X4+KZcH5mXHdTlYL2EAB2R227843L4KCG9e2pmzH/
 rlmsKcKzKkJBOYswjH9j+4aIhtqoylvMvz5bxkeSfhAtxhvZMM59jQw2IO+LxxeIWfx9AypIxV
 xUY=
X-IronPort-AV: E=Sophos;i="5.73,406,1583164800"; d="scan'208";a="246898193"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 12:30:54 +0800
IronPort-SDR: E2enVAbUnWNmgxg6LYTvnWwKi1QEX3i/7g3NWN+bmjWvK51fibp0ye0eEWM13XjZOhFzml2LBO
 6fpy8FppqIc3wm2riY+jx5WXmiTe91+GQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2020 21:20:28 -0700
IronPort-SDR: NxvWTvKQaEvQ64dcc0OGG0z2EYBtHGoh5dP8ufJIdbUgq7+Nh1YmCEB48iQpfHrv4EvFOicg2i
 3e2gn2sNPzUw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 May 2020 21:30:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V3 3/3] nvmet: add async event tracing support
Date: Sun, 17 May 2020 21:30:34 -0700
Message-Id: <20200518043034.48277-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
References: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200517_213055_137826_A5ED92AF 
X-CRM114-Status: GOOD (  10.70  )
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
b20+ClJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KUmV2aWV3ZWQt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Ci0tLQogZHJpdmVycy9udm1lL3Rh
cmdldC9jb3JlLmMgIHwgIDEgKwogZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L2NvcmUuYwppbmRleCA5YjdjYjYxNDdjYTguLmRmZWQ3OWEwZTQxNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmMKQEAgLTE1MSw2ICsxNTEsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9hc3luY19ldmVu
dHNfcHJvY2VzcyhzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwgdTE2IHN0YXR1cykKIAkJa2ZyZWUo
YWVuKTsKIAogCQltdXRleF91bmxvY2soJmN0cmwtPmxvY2spOworCQl0cmFjZV9udm1ldF9hc3lu
Y19ldmVudChjdHJsLCByZXEtPmNxZS0+cmVzdWx0LnUzMik7CiAJCW52bWV0X3JlcV9jb21wbGV0
ZShyZXEsIHN0YXR1cyk7CiAJfQogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC90
cmFjZS5oIGIvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oCmluZGV4IGU2NDVjYWE4ODJkZC4u
NzhmMjdmMGExMjFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmgKKysr
IGIvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oCkBAIC0xMzAsNiArMTMwLDM0IEBAIFRSQUNF
X0VWRU5UKG52bWV0X3JlcV9jb21wbGV0ZSwKIAogKTsKIAorI2RlZmluZSBhZXJfbmFtZShhZXIp
IHsgYWVyLCAjYWVyIH0KKworVFJBQ0VfRVZFTlQobnZtZXRfYXN5bmNfZXZlbnQsCisJVFBfUFJP
VE8oc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsIHUzMiByZXN1bHQpLAorCVRQX0FSR1MoY3RybCwg
cmVzdWx0KSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlfX2ZpZWxkKGludCwgY3RybF9pZCkKKwkJ
X19maWVsZCh1MzIsIHJlc3VsdCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5LT5j
dHJsX2lkID0gY3RybC0+Y250bGlkOworCQlfX2VudHJ5LT5yZXN1bHQgPSAocmVzdWx0ICYgMHhm
ZjAwKSA+PiA4OworCSksCisJVFBfcHJpbnRrKCJudm1ldCVkOiBOVk1FX0FFTj0lIzA4eCBbJXNd
IiwKKwkJX19lbnRyeS0+Y3RybF9pZCwgX19lbnRyeS0+cmVzdWx0LAorCQlfX3ByaW50X3N5bWJv
bGljKF9fZW50cnktPnJlc3VsdCwKKwkJYWVyX25hbWUoTlZNRV9BRVJfTk9USUNFX05TX0NIQU5H
RUQpLAorCQlhZXJfbmFtZShOVk1FX0FFUl9OT1RJQ0VfQU5BKSwKKwkJYWVyX25hbWUoTlZNRV9B
RVJfTk9USUNFX0ZXX0FDVF9TVEFSVElORyksCisJCWFlcl9uYW1lKE5WTUVfQUVSX05PVElDRV9E
SVNDX0NIQU5HRUQpLAorCQlhZXJfbmFtZShOVk1FX0FFUl9FUlJPUiksCisJCWFlcl9uYW1lKE5W
TUVfQUVSX1NNQVJUKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfQ1NTKSwKKwkJYWVyX25hbWUoTlZN
RV9BRVJfVlMpKQorCSkKKyk7CisjdW5kZWYgYWVyX25hbWUKKwogI2VuZGlmIC8qIF9UUkFDRV9O
Vk1FVF9IICovCiAKICN1bmRlZiBUUkFDRV9JTkNMVURFX1BBVEgKLS0gCjIuMjIuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
