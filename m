Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C509FC34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDAC20675
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbdVrA+v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H+pABBg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDAC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2Eulg8rjiRIjdP6/xzmrUqVtbdFEuuNFpN1WbsPvla0=; b=pbdVrA+v28+Zx+
	JL6Y/XfPJmo0r5qGskKbMUrCaACuBYxNbP3/5dvi4i2YFkaHbi+Uib1ShzBd4/0XB5B1sM7oupAxy
	VVV/GOTip77mJYNC1OleR1DRX0K15Bi5HSSEu5pqr9sib+p7vyrTqp2mwSSWVmYV1ueKuwpzNXMNu
	uGPCZY9vEtJCp2Q1Y8PqMWQODvfciXxtRrYehjpTCWdOvdkB/a43byonQ9GbfmcEIIx04fboYzVvZ
	GOC/7hTXNf4JyjdGslITR1V0p1WLjZYi87VhGQihKca0xoKwYEgOyXrsQQdlUFHp2hZ+Z4rA6VGlC
	eyfURdnoRvML3LS2mNfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Rzy-0004EJ-U9; Wed, 19 Feb 2020 16:14:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Rzw-0004Dt-Hd
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 16:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582128893; x=1613664893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jjspKI2YBGfRSsXrn3au3PNfDOcA/NXT8QXHjUp1QZY=;
 b=H+pABBg0bW7fGK9IN9LaKq4Pf+EjYO/pVtq6/sEFn2LmxUVCgURb3a7O
 BjeFvwC68RsClGa/Uzapcxeoe3L1kCpfBxT/dpAayBZZSK4pgKEtCh2L0
 FS+HaVmt6YTtX54+byNto6LHbwgCzkH1dB2K8a8iQ+sFV9N34fUQFdP21
 LgnJRLr+KK8m44NK2N/UwLQFzobRC9JFLnQtwhgIP+O90OD+RJLIhToqD
 lCbvozHobZAjG9KiZXZUfiMoX4B/3gWgT1TVt4ZyhgIDDWxaCgX5UZ3jy
 RUdXgmxo0zm7oju5P0T5RTlvl8qrO9xH3XWtqUFEwxu51h4voN15OJWLj g==;
IronPort-SDR: DncNebuY+V2x6EY1KLVJes0XkaR71YwftWVcuAlTY9+5hcYxG4j2NBpr9A15mzZ9mMmhW4Nk/t
 fWyhyE52NgFWXQ0dQcxuXSoHBtzfQFbXpiMXvYJzBKetoffh9zGTzwDPl6p2ZpbKZcg+459pfz
 QPfI7Mp+aonbSAjEdGt9FKLLwdYlkt1f0CW0orQ3DoVCRVu5TnwzSc9aVRVcJH2bbNvVp9Id/D
 vOTHrPS9ugClJXjP9sq7nuv8SCAXP727sg66x+nADk709/zuqMjAlizTCr/kMimKkXiSxATDvb
 dqg=
X-IronPort-AV: E=Sophos;i="5.70,461,1574092800"; d="scan'208";a="232068963"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 00:15:01 +0800
IronPort-SDR: EQRHPeiodkvkPAYA2dj/xuh/KXqtqc2hpxSyCLNDWZIBH13CWq6J93RYT4XgU78fzKzXOBsLsn
 69BScSfFu8bDQPFIiq+UEMLtuyYiMGqQJFv+2/GalQ8AHR8KpE+mH4LPJdG4ECDifa5R/4f8M+
 4cQ9ezIMqOyDhwEfeYWf6/Xw3n7s/ytda2oC5ytOUkM4WzuuSgKncx0zeBXdFKjl6Sd7xpfGDz
 a5LFZMXHgX+o1Zi27sT+xVGU89D/yad7nFPEz32D0Z8qC3WVPKVL9Vq7Fl2ey3aJ15U1ukk9hk
 c7Wqg8qPcytqb5Il/6A9S8NB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 08:07:15 -0800
IronPort-SDR: U1CdnNHKhAcaaSomSDD2gXjHxBCPHKbwM/wDa5WCKQHKTykK97cCcQbRGuyTMcolryzqa3J5JI
 hKbAMW+Eaa0IAjsU0k2R1dizFBrULBsEFXVz+riDgCwRjyKXcwKM9tEtpXTJz9Q73qBmIPDdXJ
 AS+NyXEfKqS+ILzZsi8rxHcn2Ixtd6ZI9onFABX0yWrEVorMjuh/ggIrxrdKaITLewpFOWHsXf
 e+0l8guMYRCwJnCwJL/tTpyIKeVQCDgSbBXn++44SLU/3cxedjxQmQTooQWNg3LQBGChKcv2Y0
 HhU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Feb 2020 08:14:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3] nvme: code cleanup nvme_identify_ns_desc()
Date: Wed, 19 Feb 2020 08:14:31 -0800
Message-Id: <20200219161431.5025-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_081452_661289_17FF0DA2 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlIGZ1bmN0aW9uIG52bWVfaWRlbnRpZnlfbnNfZGVzYygpIGhhcyAzIGxldmVscyBvZiBuZXN0
aW5nIHdoaWNoIG1ha2UKZXJyb3IgbWVzc2FnZSB0byBleGNlZWRlZCA+IDgwIGNoYXIgcGVyIGxp
bmUgd2hpY2ggaXMgbm90IGFsaWduZWQgd2l0aAp0aGUga2VybmVsIGNvZGUgc3RhbmRhcmRzIGFu
ZCByZXN0IG9mIHRoZSBOVk1lIHN1YnN5c3RlbSBjb2RlLgrCoApBZGQgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gbW92ZSB0aGUgcHJvY2Vzc2luZyBvZiB0aGUgbG9nIHdoZW4gdGhlCmNvbW1hbmQgaXMg
c3VjY2Vzc2Z1bCBieSByZWR1Y2luZyB0aGUgbmVzdGluZyBhbmQga2VlcGluZyB0aGUKY29kZSA8
IDgwIGNoYXIgcGVyIGxpbmUuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNo
YWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KQ2hhbmdlcyBmcm9tIFYyIChDaHJpc3RvcGgp
Oi0KCjEuIERvbid0IG1peCB0aGUgY29kaW5nIHN0eWxlcyBmb3IgZnVuY3Rpb24gYXJndW1lbnRz
IGluIHRoZSBoZWFkZXIuCjIuIEdldCByaWQgb2YgbGVuIHZhcmlhYmxlIGluIG52bWVfcHJvY2Vz
c19uc19kZXNjKCkuCjMuIFJlbW92ZSBleHRyYSBsaW5lcy4KCkNoYW5nZXMgZnJvbSBWMTogLQoK
MS4gUGFzcyBzdHJ1Y3QgbnZtZV9uc19pZF9kZXNjICpjdXIgYXMgaXQgaXMgdG8gYXZvaWQgZGF0
YSBhbmQgcG9zCiAgIHBhcmFtZXRlcnMgdG8gaGF2ZSBhIHNsaWdodGx5IGNsZWFuZXIgcGF0Y2gu
IChLZWl0aCkKCi0tLQogZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNzYgKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlv
bnMoKyksIDM2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCBjZDBiNDdlZDIxOWUuLjg0OTE0
MjIzYzUzNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMTA1NSw2ICsxMDU1LDQzIEBAIHN0YXRpYyBpbnQgbnZt
ZV9pZGVudGlmeV9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmRldiwgc3RydWN0IG52bWVfaWRfY3Ry
bCAqKmlkKQogCXJldHVybiBlcnJvcjsKIH0KIAorc3RhdGljIGludCBudm1lX3Byb2Nlc3NfbnNf
ZGVzYyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9uc19pZHMgKmlkcywKKwkJ
c3RydWN0IG52bWVfbnNfaWRfZGVzYyAqY3VyKQoreworCWNvbnN0IGNoYXIgKndhcm5fc3RyID0g
ImN0cmwgcmV0dXJuZWQgYm9ndXMgbGVuZ3RoOiI7CisJdm9pZCAqZGF0YSA9IGN1cjsKKworCXN3
aXRjaCAoY3VyLT5uaWR0KSB7CisJY2FzZSBOVk1FX05JRFRfRVVJNjQ6CisJCWlmIChjdXItPm5p
ZGwgIT0gTlZNRV9OSURUX0VVSTY0X0xFTikgeworCQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAi
JXMgJWQgZm9yIE5WTUVfTklEVF9FVUk2NFxuIiwKKwkJCQkgd2Fybl9zdHIsIGN1ci0+bmlkbCk7
CisJCQlyZXR1cm4gLTE7CisJCX0KKwkJbWVtY3B5KGlkcy0+ZXVpNjQsIGRhdGEgKyBzaXplb2Yo
KmN1ciksIE5WTUVfTklEVF9FVUk2NF9MRU4pOworCQlyZXR1cm4gTlZNRV9OSURUX0VVSTY0X0xF
TjsKKwljYXNlIE5WTUVfTklEVF9OR1VJRDoKKwkJaWYgKGN1ci0+bmlkbCAhPSBOVk1FX05JRFRf
TkdVSURfTEVOKSB7CisJCQlkZXZfd2FybihjdHJsLT5kZXZpY2UsICIlcyAlZCBmb3IgTlZNRV9O
SURUX05HVUlEXG4iLAorCQkJCSB3YXJuX3N0ciwgY3VyLT5uaWRsKTsKKwkJCXJldHVybiAtMTsK
KwkJfQorCQltZW1jcHkoaWRzLT5uZ3VpZCwgZGF0YSArIHNpemVvZigqY3VyKSwgTlZNRV9OSURU
X05HVUlEX0xFTik7CisJCXJldHVybiBOVk1FX05JRFRfTkdVSURfTEVOOworCWNhc2UgTlZNRV9O
SURUX1VVSUQ6CisJCWlmIChjdXItPm5pZGwgIT0gTlZNRV9OSURUX1VVSURfTEVOKSB7CisJCQlk
ZXZfd2FybihjdHJsLT5kZXZpY2UsICIlcyAlZCBmb3IgTlZNRV9OSURUX1VVSURcbiIsCisJCQkJ
IHdhcm5fc3RyLCBjdXItPm5pZGwpOworCQkJcmV0dXJuIC0xOworCQl9CisJCXV1aWRfY29weSgm
aWRzLT51dWlkLCBkYXRhICsgc2l6ZW9mKCpjdXIpKTsKKwkJcmV0dXJuIE5WTUVfTklEVF9VVUlE
X0xFTjsKKwlkZWZhdWx0OgorCQkvKiBTa2lwIHVua25vd24gdHlwZXMgKi8KKwkJcmV0dXJuIGN1
ci0+bmlkbDsKKwl9Cit9CisKIHN0YXRpYyBpbnQgbnZtZV9pZGVudGlmeV9uc19kZXNjcyhzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAogCQlzdHJ1Y3QgbnZtZV9uc19pZHMg
KmlkcykKIHsKQEAgLTEwODMsNDIgKzExMjAsOSBAQCBzdGF0aWMgaW50IG52bWVfaWRlbnRpZnlf
bnNfZGVzY3Moc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5zaWduZWQgbnNpZCwKIAkJaWYgKGN1
ci0+bmlkbCA9PSAwKQogCQkJYnJlYWs7CiAKLQkJc3dpdGNoIChjdXItPm5pZHQpIHsKLQkJY2Fz
ZSBOVk1FX05JRFRfRVVJNjQ6Ci0JCQlpZiAoY3VyLT5uaWRsICE9IE5WTUVfTklEVF9FVUk2NF9M
RU4pIHsKLQkJCQlkZXZfd2FybihjdHJsLT5kZXZpY2UsCi0JCQkJCSAiY3RybCByZXR1cm5lZCBi
b2d1cyBsZW5ndGg6ICVkIGZvciBOVk1FX05JRFRfRVVJNjRcbiIsCi0JCQkJCSBjdXItPm5pZGwp
OwotCQkJCWdvdG8gZnJlZV9kYXRhOwotCQkJfQotCQkJbGVuID0gTlZNRV9OSURUX0VVSTY0X0xF
TjsKLQkJCW1lbWNweShpZHMtPmV1aTY0LCBkYXRhICsgcG9zICsgc2l6ZW9mKCpjdXIpLCBsZW4p
OwotCQkJYnJlYWs7Ci0JCWNhc2UgTlZNRV9OSURUX05HVUlEOgotCQkJaWYgKGN1ci0+bmlkbCAh
PSBOVk1FX05JRFRfTkdVSURfTEVOKSB7Ci0JCQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLAotCQkJ
CQkgImN0cmwgcmV0dXJuZWQgYm9ndXMgbGVuZ3RoOiAlZCBmb3IgTlZNRV9OSURUX05HVUlEXG4i
LAotCQkJCQkgY3VyLT5uaWRsKTsKLQkJCQlnb3RvIGZyZWVfZGF0YTsKLQkJCX0KLQkJCWxlbiA9
IE5WTUVfTklEVF9OR1VJRF9MRU47Ci0JCQltZW1jcHkoaWRzLT5uZ3VpZCwgZGF0YSArIHBvcyAr
IHNpemVvZigqY3VyKSwgbGVuKTsKLQkJCWJyZWFrOwotCQljYXNlIE5WTUVfTklEVF9VVUlEOgot
CQkJaWYgKGN1ci0+bmlkbCAhPSBOVk1FX05JRFRfVVVJRF9MRU4pIHsKLQkJCQlkZXZfd2Fybihj
dHJsLT5kZXZpY2UsCi0JCQkJCSAiY3RybCByZXR1cm5lZCBib2d1cyBsZW5ndGg6ICVkIGZvciBO
Vk1FX05JRFRfVVVJRFxuIiwKLQkJCQkJIGN1ci0+bmlkbCk7Ci0JCQkJZ290byBmcmVlX2RhdGE7
Ci0JCQl9Ci0JCQlsZW4gPSBOVk1FX05JRFRfVVVJRF9MRU47Ci0JCQl1dWlkX2NvcHkoJmlkcy0+
dXVpZCwgZGF0YSArIHBvcyArIHNpemVvZigqY3VyKSk7Ci0JCQlicmVhazsKLQkJZGVmYXVsdDoK
LQkJCS8qIFNraXAgdW5rbm93biB0eXBlcyAqLwotCQkJbGVuID0gY3VyLT5uaWRsOwotCQkJYnJl
YWs7Ci0JCX0KKwkJbGVuID0gbnZtZV9wcm9jZXNzX25zX2Rlc2MoY3RybCwgaWRzLCBjdXIpOwor
CQlpZiAobGVuIDwgMCkKKwkJCWdvdG8gZnJlZV9kYXRhOwogCiAJCWxlbiArPSBzaXplb2YoKmN1
cik7CiAJfQotLSAKMi4yMi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
