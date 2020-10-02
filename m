Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BAC4741F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336D9206CA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDQGfR3L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TOrxNyDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336D9206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fp6Xh7Bm7kvYltLP7BCD0xF+NyP4GzeKTcxZZVT/Qks=; b=XDQGfR3LWuOjC+7qoqVvAaVJv
	DGvxOtaUGCXX1CfsBpqxJGygh4YqawgBsYaiSs+v8/c5pG3zIU2M17sugyQdLDTO72CkE2+EFfeL6
	I8c0dtBU+Oqr4MD0IBtcLCnym5Mmfh572VwuGhNASxF/h2V6swsJnNhobLh4USm239a5g46siAi9m
	fAqRwLXflaB8fSnC7KQ3bSYmgpCBsvI1BuXQL/UTobn/BOnE4HoAyHzLwv+0M4SOPnJ6J4x8hXZcJ
	BnCSPStRXCWVDpqh7BCM+swWwj1bX3g4uTdEjlebV1R/+Oz3H1WmSiJM3jiSbVPHXvN2yUBpvdI6r
	topopZBlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOBFk-0004sy-3j; Fri, 02 Oct 2020 02:57:00 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOBFi-0004sX-7t
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 02:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601607419; x=1633143419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ArWdz+BcYvNr9/X6QuxLOhyTQ5tARmtBxhFGxO78oyY=;
 b=TOrxNyDqErD+rD8Bbhpei54M+8oy2LnbsNQbs4sek4lTQBtR/C3vokb2
 Lft6r9AXb8Lp9q0SWxomjrkHjBPDjeeOB+ICOQMmA2RMBVimZFSg3F8VA
 T1VyfU89F7J0ptXPpwcBckw4DGDEBUWjMK2QzaQSTVmVUzoQkuKDTotTC
 zOVc2dVal8yJdR5IqQ4ZxbbU4kNQ6eXmw5oNLgscIaF9w9mhZLaHoKrTS
 WRYMvaYpBDZ6YHcwIvMt6V9IeB+Q45PJocbXAP81PkYgIJk6DWIOYt4vh
 1aRweuPSYajd44nSujEjz0egwLmeamqVB1/YvtfLxFADjza+fXCz53+kG A==;
IronPort-SDR: JrzFZzy/sHyPzU4+AgYC2mqLZQpm+Mx/fU5NSU173Y7nfnwLrcgg61f6fm2jNvaLTnPFwr/P8r
 j8qm/1LmW/BvDg5cuKbcFJWNPaemh5+V9G1tmzSNIewGt1u3yba53W8MuM7vzNirwl2XR5qfFc
 e+KQbkmJYnK5rpSiL+O+HXLIhFatE2el+L+XPIU4T4lPv0YjwfbYtIrzQwPq8YsDx8hNQ+L/IF
 hq0SjSbin8ahiyHdEOFv5yqiO3pcOIUEANY6JdTM/RWKZNZaM6fvV+kAm0mWYCaCi6HUkpS5fr
 lRo=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="153282549"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 10:56:57 +0800
IronPort-SDR: iMU9qH2evzCRTTViYzeD7Dtdaz/43agaBzWZEthQ1fWJpB+oFmXAu6gtQ6W0o0cs1MxY6eLk33
 xr1JHxBS/f6g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 19:43:48 -0700
IronPort-SDR: ZucubkkvCcAFhgrxtxWgKnUegaxcqL7lW0jZkMY8umxrAKXs4S4UJnToYQqiT/S1iPVN85yYbR
 p4uE1a8ktUOg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 19:56:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/4] nvmet: change the type of the ns->readonly
Date: Thu,  1 Oct 2020 19:56:46 -0700
Message-Id: <20201002025649.30724-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
References: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_225658_423958_B7225285 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SW4gdGhpcyBwYXRjaCwgd2UgY2hhbmdlIHRoZSB0eXBlIG9mIHRoZSBucy0+cmVhZG9ubHkgYXR0
cmlidXRlIGZyb20KYm9vbCB0byB0aGXCoG52bWVfbnNfd3Bfc3RhdGUgYW5kIHJlbmFtZSBpdCB0
byB3cml0ZV9wcm90ZWN0IHNvIHRoYXQgd2UKY2FuIGFjdHVhbGx5IHN0b3JlIHRoZSBzdGF0ZSBv
ZiB0aGUgbnMgd3JpdGUgcHJvdGVjdGlvbi4gVGhpcyBpcyBuZWVkZWQKdG8gc3RvcmUgdGhlIG5z
IHdyaXRlIHByb3RlY3Rpb24gcGVybWFuZW50IHN0YXRlIHNpbmNlIGluIHRoZSBuZXh0IHBhdGNo
CndlIGFsbG93IHVzZXIgdG8gc2V0IHRoZSB3cml0ZSBwcm90ZWN0aW9uIGZyb20gdGhlIGNvbmZp
Z2ZzIG5zIGF0dHIgdG8KZXhwb3J0IHRoZSByZWFkLW9ubHkgc25hcHNob3RzIHN1Y2ggdGhhdCBo
b3N0IHNob3VsZCBub3QgY2hhbmdlIHRoZSB3cml0ZQpwcm90ZWN0IHZhbHVlIHdoZW4gaXQgaXMg
c2V0IHRvIHBlcm1hbmVudCBmcm9tIGNvbmZpZ2ZzLgoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUv
dGFyZ2V0L2FkbWluLWNtZC5jIHwgMjcgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiBkcml2
ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyAgICAgIHwgIDMgKystCiBkcml2ZXJzL252bWUvdGFyZ2V0
L252bWV0LmggICAgIHwgIDIgKy0KIGluY2x1ZGUvbGludXgvbnZtZS5oICAgICAgICAgICAgfCAg
MiArLQogNCBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIGIvZHJpdmVycy9u
dm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCBkY2EzNDQ4OWExZGMuLjI2M2NmZmY2ZGRkNCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYworKysgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC01MzcsOCArNTM3LDE3IEBAIHN0YXRpYyB2b2lk
IG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfbnMoc3RydWN0IG52bWV0X3JlcSAqcmVxKQogCQlpZC0+
bGJhZlswXS5tcyA9IGNwdV90b19sZTE2KG5zLT5tZXRhZGF0YV9zaXplKTsKIAl9CiAKLQlpZiAo
bnMtPnJlYWRvbmx5KQorCXN3aXRjaCAobnMtPndyaXRlX3Byb3RlY3QpIHsKKwljYXNlIE5WTUVf
TlNfTk9fV1JJVEVfUFJPVEVDVDoKKwkJaWQtPm5zYXR0ciB8PSAwOworCQlicmVhazsKKwljYXNl
IE5WTUVfTlNfV1JJVEVfUFJPVEVDVDoKIAkJaWQtPm5zYXR0ciB8PSAoMSA8PCAwKTsKKwkJYnJl
YWs7CisJZGVmYXVsdDoKKwkJYnJlYWs7CisJfQorCiAJbnZtZXRfcHV0X25hbWVzcGFjZShucyk7
CiBkb25lOgogCXN0YXR1cyA9IG52bWV0X2NvcHlfdG9fc2dsKHJlcSwgMCwgaWQsIHNpemVvZigq
aWQpKTsKQEAgLTcwNCwxMyArNzEzLDE0IEBAIHN0YXRpYyB1MTYgbnZtZXRfc2V0X2ZlYXRfd3Jp
dGVfcHJvdGVjdChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiAJbXV0ZXhfbG9jaygmc3Vic3lzLT5s
b2NrKTsKIAlzd2l0Y2ggKHdyaXRlX3Byb3RlY3QpIHsKIAljYXNlIE5WTUVfTlNfV1JJVEVfUFJP
VEVDVDoKLQkJcmVxLT5ucy0+cmVhZG9ubHkgPSB0cnVlOwogCQlzdGF0dXMgPSBudm1ldF93cml0
ZV9wcm90ZWN0X2ZsdXNoX3N5bmMocmVxKTsKLQkJaWYgKHN0YXR1cykKLQkJCXJlcS0+bnMtPnJl
YWRvbmx5ID0gZmFsc2U7CisJCWlmIChzdGF0dXMgPT0gTlZNRV9TQ19TVUNDRVNTKQorCQkJcmVx
LT5ucy0+d3JpdGVfcHJvdGVjdCA9IE5WTUVfTlNfV1JJVEVfUFJPVEVDVDsKKwkJZWxzZQorCQkJ
cmVxLT5ucy0+d3JpdGVfcHJvdGVjdCA9IE5WTUVfTlNfTk9fV1JJVEVfUFJPVEVDVDsKIAkJYnJl
YWs7CiAJY2FzZSBOVk1FX05TX05PX1dSSVRFX1BST1RFQ1Q6Ci0JCXJlcS0+bnMtPnJlYWRvbmx5
ID0gZmFsc2U7CisJCXJlcS0+bnMtPndyaXRlX3Byb3RlY3QgPSBOVk1FX05TX05PX1dSSVRFX1BS
T1RFQ1Q7CiAJCXN0YXR1cyA9IDA7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CkBAIC03OTgsNyArODA4
LDYgQEAgdm9pZCBudm1ldF9leGVjdXRlX3NldF9mZWF0dXJlcyhzdHJ1Y3QgbnZtZXRfcmVxICpy
ZXEpCiBzdGF0aWMgdTE2IG52bWV0X2dldF9mZWF0X3dyaXRlX3Byb3RlY3Qoc3RydWN0IG52bWV0
X3JlcSAqcmVxKQogewogCXN0cnVjdCBudm1ldF9zdWJzeXMgKnN1YnN5cyA9IHJlcS0+c3EtPmN0
cmwtPnN1YnN5czsKLQl1MzIgcmVzdWx0OwogCiAJcmVxLT5ucyA9IG52bWV0X2ZpbmRfbmFtZXNw
YWNlKHJlcS0+c3EtPmN0cmwsIHJlcS0+Y21kLT5jb21tb24ubnNpZCk7CiAJaWYgKCFyZXEtPm5z
KSAgewpAQCAtODA2LDExICs4MTUsNyBAQCBzdGF0aWMgdTE2IG52bWV0X2dldF9mZWF0X3dyaXRl
X3Byb3RlY3Qoc3RydWN0IG52bWV0X3JlcSAqcmVxKQogCQlyZXR1cm4gTlZNRV9TQ19JTlZBTElE
X05TIHwgTlZNRV9TQ19ETlI7CiAJfQogCW11dGV4X2xvY2soJnN1YnN5cy0+bG9jayk7Ci0JaWYg
KHJlcS0+bnMtPnJlYWRvbmx5ID09IHRydWUpCi0JCXJlc3VsdCA9IE5WTUVfTlNfV1JJVEVfUFJP
VEVDVDsKLQllbHNlCi0JCXJlc3VsdCA9IE5WTUVfTlNfTk9fV1JJVEVfUFJPVEVDVDsKLQludm1l
dF9zZXRfcmVzdWx0KHJlcSwgcmVzdWx0KTsKKwludm1ldF9zZXRfcmVzdWx0KHJlcSwgcmVxLT5u
cy0+d3JpdGVfcHJvdGVjdCk7CiAJbXV0ZXhfdW5sb2NrKCZzdWJzeXMtPmxvY2spOwogCiAJcmV0
dXJuIDA7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvY29yZS5jCmluZGV4IDI1ZDYyZDg2NzU2My4uMDM2Y2UzOWNmODM4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L2NvcmUuYwpAQCAtNjgxLDYgKzY4MSw3IEBAIHN0cnVjdCBudm1ldF9ucyAqbnZtZXRfbnNf
YWxsb2Moc3RydWN0IG52bWV0X3N1YnN5cyAqc3Vic3lzLCB1MzIgbnNpZCkKIAogCXV1aWRfZ2Vu
KCZucy0+dXVpZCk7CiAJbnMtPmJ1ZmZlcmVkX2lvID0gZmFsc2U7CisJbnMtPndyaXRlX3Byb3Rl
Y3QgPSBOVk1FX05TX05PX1dSSVRFX1BST1RFQ1Q7CiAKIAlyZXR1cm4gbnM7CiB9CkBAIC04Mzks
NyArODQwLDcgQEAgc3RhdGljIGlubGluZSB1MTYgbnZtZXRfY2hlY2tfYW5hX3N0YXRlKHN0cnVj
dCBudm1ldF9wb3J0ICpwb3J0LAogCiBzdGF0aWMgaW5saW5lIHUxNiBudm1ldF9pb19jbWRfY2hl
Y2tfYWNjZXNzKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIHsKLQlpZiAodW5saWtlbHkocmVxLT5u
cy0+cmVhZG9ubHkpKSB7CisJaWYgKHVubGlrZWx5KHJlcS0+bnMtPndyaXRlX3Byb3RlY3QpKSB7
CiAJCXN3aXRjaCAocmVxLT5jbWQtPmNvbW1vbi5vcGNvZGUpIHsKIAkJY2FzZSBudm1lX2NtZF9y
ZWFkOgogCQljYXNlIG52bWVfY21kX2ZsdXNoOgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rh
cmdldC9udm1ldC5oIGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oCmluZGV4IDU1OWExNWNj
YzMyMi4uN2I5ZDY0YzA5N2ViIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0
LmgKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oCkBAIC01Nyw3ICs1Nyw3IEBAIHN0
cnVjdCBudm1ldF9ucyB7CiAJc3RydWN0IHBlcmNwdV9yZWYJcmVmOwogCXN0cnVjdCBibG9ja19k
ZXZpY2UJKmJkZXY7CiAJc3RydWN0IGZpbGUJCSpmaWxlOwotCWJvb2wJCQlyZWFkb25seTsKKwll
bnVtIG52bWVfbnNfd3Bfc3RhdGUJd3JpdGVfcHJvdGVjdDsKIAl1MzIJCQluc2lkOwogCXUzMgkJ
CWJsa3NpemVfc2hpZnQ7CiAJbG9mZl90CQkJc2l6ZTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbnZtZS5oIGIvaW5jbHVkZS9saW51eC9udm1lLmgKaW5kZXggZDkyNTM1OTk3Njg3Li5hZTU0
MTMyY2ZhYjAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbnZtZS5oCisrKyBiL2luY2x1ZGUv
bGludXgvbnZtZS5oCkBAIC0xMDY3LDcgKzEwNjcsNyBAQCBlbnVtIHsKIH07CiAKIC8qIE5WTWUg
TmFtZXNwYWNlIFdyaXRlIFByb3RlY3QgU3RhdGUgKi8KLWVudW0geworZW51bSBudm1lX25zX3dw
X3N0YXRlIHsKIAlOVk1FX05TX05PX1dSSVRFX1BST1RFQ1QgPSAwLAogCU5WTUVfTlNfV1JJVEVf
UFJPVEVDVCwKIAlOVk1FX05TX1dSSVRFX1BST1RFQ1RfUE9XRVJfQ1lDTEUsCi0tIAoyLjIyLjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
