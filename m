Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C7C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9238A206DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vj9DVlUV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a4pad/Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9238A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6CbihAXdG88UWiL1hxKJXUbPHOieqfUUaSdLgmFXgVs=; b=Vj9DVlUVK6RgZz
	mx59HY8So4/UGrJbhK4j+7+Exz9jMspaIADnG5/CmuEuo6nPTGFiJcktn8p10PX/XtiPZujA3Yrvb
	AbPFF+WJKnVy5Eq/TMy155FJvj2ZS4gUMWWEjlR1kneSRgzQI22D/45ZOf5d05EuyCWnYntyFt5cC
	PIvvHd6wVeekOZGNnOnswQ3Wsfv9mwFbTpL3nFXJdq0v4GwOCseMyr8cFMKuyH0l96HrradlM9J5J
	ghRKqG0AaaiuigXAhBMnnfsqp45fUl2KiyTKh+0gHiNCb+Z1yTAkwyjW8d8Up4Iv5Gidh60eu9Pl2
	W1wc/RFtc6W23uvl9e6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkydU-00057v-Vo; Mon, 15 Jun 2020 23:35:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkydI-0004yh-9i
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592264117; x=1623800117;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ts4aTclmB4oUq4++RrNc9NTK0M6BPwdTxbFaUukEoc0=;
 b=a4pad/MsjJGsJFjqvRZ/Zaddch5viEKF8d7h7mf4nF0Mq8WoAmZNdXj0
 2mBs0/OueLL7jVXqizkQP3S2FLWpLgyMezGjsIEmGaFWiERGAVcTpetvj
 6/hEVAIl3HUL9N+eDHdvEsWRiyyCCP0bbpCt1Haxkd03K+muFxiI1DqAP
 UrF57O4L1sS9tUo15SHmSNkISpcfx5U7I0Rv5zsVpWQULH0jo0O7SxUMX
 zkX/Xdz9tqd2+2dy/fryuhk8FmMqTJegB49S09WOXx9McXMaKcpm14DRN
 nwWziMVs5l9V9imNM/wURFQkO8eWgF08/HAyVK46Q7bexMqdaEyQ10M4n w==;
IronPort-SDR: uxEgBtC3nPU9icx2ertLsdsL1ALGka/GrkvGrIEStddu04wPYwxV7NYXhy3R4JF/9ED1Em9N+K
 sq7gNXJsJ8dc2yQJyH3QvZky2HseIwuIlJWD1j6NMUfFNQJ5V7OeOQUlXH6sEfFPgUpCeVkmXY
 jtVeWMiFHBPvpAR01qYVcWLpC0KGY5lDKrbXOPzWBl/HmJPoffBUf1BYBiiEJ7A0VMRI7x1SAn
 yn5Sj/YMNa1KVmQYsDX1y967fLxh/PIfTSN0kgXzbxdM2aeUuBWTiE8XFQ6U0MCalpz1mos6E8
 UKI=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144394453"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:16 +0800
IronPort-SDR: lPqSP7cICG3rDSEkZ9IGO1BHj+/s1APiLEK6OOZhV8po/OJpdyGIFtXfqkf+cyIALvK7QgbK4c
 KDCe/HRPFm04+BhXd+v6ddKr/+S4n6KNc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 16:24:33 -0700
IronPort-SDR: KNSQXFIT00Han6jm05uaHhwi67rlhVKWeJbiOXiZRkbJKJKcQYwlAQyksmuSy6r/96Ev+eUSzH
 XPgpgy3o0LvA==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:14 -0700
From: Keith Busch <keith.busch@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: add capacity field to zone descriptors
Date: Tue, 16 Jun 2020 08:34:20 +0900
Message-Id: <20200615233424.13458-2-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200615233424.13458-1-keith.busch@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_163516_349688_EE8F8043 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogTWF0aWFzIEJqw7hybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+CgpJbiB0aGUg
em9uZWQgc3RvcmFnZSBtb2RlbCwgdGhlIHNlY3RvcnMgd2l0aGluIGEgem9uZSBhcmUgdHlwaWNh
bGx5IGFsbAp3cml0ZWFibGUuIFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgWm9uZWQgTmFt
ZXNwYWNlIChaTlMpIENvbW1hbmQKU2V0IGluIHRoZSBOVk0gRXhwcmVzcyBvcmdhbml6YXRpb24s
IHRoZSBtb2RlbCB3YXMgZXh0ZW5kZWQgdG8gaGF2ZSBhCnNwZWNpZmljIHdyaXRlYWJsZSBjYXBh
Y2l0eS4KCkV4dGVuZCB0aGUgem9uZSBkZXNjcmlwdG9yIGRhdGEgc3RydWN0dXJlIHdpdGggYSB6
b25lIGNhcGFjaXR5IGZpZWxkIHRvCmluZGljYXRlIHRvIHRoZSB1c2VyIGhvdyBtYW55IHNlY3Rv
cnMgaW4gYSB6b25lIGFyZSB3cml0ZWFibGUuCgpJbnRyb2R1Y2UgYmFja3dhcmQgY29tcGF0aWJp
bGl0eSBpbiB0aGUgem9uZSByZXBvcnQgaW9jdGwgYnkgZXh0ZW5kaW5nCnRoZSB6b25lIHJlcG9y
dCBoZWFkZXIgZGF0YSBzdHJ1Y3R1cmUgd2l0aCBhIGZsYWdzIGZpZWxkIHRvIGluZGljYXRlIGlm
CnRoZSBjYXBhY2l0eSBmaWVsZCBpcyBhdmFpbGFibGUuCgpTaWduZWQtb2ZmLWJ5OiBNYXRpYXMg
QmrDuHJsaW5nIDxtYXRpYXMuYmpvcmxpbmdAd2RjLmNvbT4KLS0tCiBibG9jay9ibGstem9uZWQu
YyAgICAgICAgICAgICAgfCAgMSArCiBkcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMgfCAg
MiArKwogZHJpdmVycy9zY3NpL3NkX3piYy5jICAgICAgICAgIHwgIDEgKwogaW5jbHVkZS91YXBp
L2xpbnV4L2Jsa3pvbmVkLmggIHwgMTUgKysrKysrKysrKysrKy0tCiA0IGZpbGVzIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxr
LXpvbmVkLmMgYi9ibG9jay9ibGstem9uZWQuYwppbmRleCAyMzgzMWZhODcwMWQuLjgxMTUyYTI2
MDM1NCAxMDA2NDQKLS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKKysrIGIvYmxvY2svYmxrLXpvbmVk
LmMKQEAgLTMxMiw2ICszMTIsNyBAQCBpbnQgYmxrZGV2X3JlcG9ydF96b25lc19pb2N0bChzdHJ1
Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCiAJCXJldHVybiByZXQ7CiAKIAly
ZXAubnJfem9uZXMgPSByZXQ7CisJcmVwLmZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwog
CWlmIChjb3B5X3RvX3VzZXIoYXJncCwgJnJlcCwgc2l6ZW9mKHN0cnVjdCBibGtfem9uZV9yZXBv
cnQpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0dXJuIDA7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrX3pvbmVkLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMK
aW5kZXggY2M0NzYwNmQ4ZmZlLi42MjRhYWMwOWIwMDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxv
Y2svbnVsbF9ibGtfem9uZWQuYworKysgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMK
QEAgLTQ3LDYgKzQ3LDcgQEAgaW50IG51bGxfaW5pdF96b25lZF9kZXYoc3RydWN0IG51bGxiX2Rl
dmljZSAqZGV2LCBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKIAogCQl6b25lLT5zdGFydCA9IHNl
Y3RvcjsKIAkJem9uZS0+bGVuID0gZGV2LT56b25lX3NpemVfc2VjdHM7CisJCXpvbmUtPmNhcGFj
aXR5ID0gem9uZS0+bGVuOwogCQl6b25lLT53cCA9IHpvbmUtPnN0YXJ0ICsgem9uZS0+bGVuOwog
CQl6b25lLT50eXBlID0gQkxLX1pPTkVfVFlQRV9DT05WRU5USU9OQUw7CiAJCXpvbmUtPmNvbmQg
PSBCTEtfWk9ORV9DT05EX05PVF9XUDsKQEAgLTU5LDYgKzYwLDcgQEAgaW50IG51bGxfaW5pdF96
b25lZF9kZXYoc3RydWN0IG51bGxiX2RldmljZSAqZGV2LCBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSkKIAogCQl6b25lLT5zdGFydCA9IHpvbmUtPndwID0gc2VjdG9yOwogCQl6b25lLT5sZW4gPSBk
ZXYtPnpvbmVfc2l6ZV9zZWN0czsKKwkJem9uZS0+Y2FwYWNpdHkgPSB6b25lLT5sZW47CiAJCXpv
bmUtPnR5cGUgPSBCTEtfWk9ORV9UWVBFX1NFUVdSSVRFX1JFUTsKIAkJem9uZS0+Y29uZCA9IEJM
S19aT05FX0NPTkRfRU1QVFk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zZF96YmMuYyBi
L2RyaXZlcnMvc2NzaS9zZF96YmMuYwppbmRleCA2ZjdlYmE2NjY4N2UuLjE4M2EyMDcyMGRhOSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3NkX3piYy5jCisrKyBiL2RyaXZlcnMvc2NzaS9zZF96
YmMuYwpAQCAtNTksNiArNTksNyBAQCBzdGF0aWMgaW50IHNkX3piY19wYXJzZV9yZXBvcnQoc3Ry
dWN0IHNjc2lfZGlzayAqc2RrcCwgdTggKmJ1ZiwKIAkJem9uZS5ub25fc2VxID0gMTsKIAogCXpv
bmUubGVuID0gbG9naWNhbF90b19zZWN0b3JzKHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZb
OF0pKTsKKwl6b25lLmNhcGFjaXR5ID0gem9uZS5sZW47CiAJem9uZS5zdGFydCA9IGxvZ2ljYWxf
dG9fc2VjdG9ycyhzZHAsIGdldF91bmFsaWduZWRfYmU2NCgmYnVmWzE2XSkpOwogCXpvbmUud3Ag
PSBsb2dpY2FsX3RvX3NlY3RvcnMoc2RwLCBnZXRfdW5hbGlnbmVkX2JlNjQoJmJ1ZlsyNF0pKTsK
IAlpZiAoem9uZS50eXBlICE9IFpCQ19aT05FX1RZUEVfQ09OViAmJgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQu
aAppbmRleCAwY2RlZjY3MTM1ZjAuLjQyYzMzNjZjYzI1ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS91
YXBpL2xpbnV4L2Jsa3pvbmVkLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgK
QEAgLTczLDYgKzczLDE1IEBAIGVudW0gYmxrX3pvbmVfY29uZCB7CiAJQkxLX1pPTkVfQ09ORF9P
RkZMSU5FCT0gMHhGLAogfTsKIAorLyoqCisgKiBlbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyAt
IEZlYXR1cmUgZmxhZ3Mgb2YgcmVwb3J0ZWQgem9uZSBkZXNjcmlwdG9ycy4KKyAqCisgKiBAQkxL
X1pPTkVfUkVQX0NBUEFDSVRZOiBab25lIGRlc2NyaXB0b3IgaGFzIGNhcGFjaXR5IGZpZWxkLgor
ICovCitlbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyB7CisJQkxLX1pPTkVfUkVQX0NBUEFDSVRZ
CT0gKDEgPDwgMCksCit9OworCiAvKioKICAqIHN0cnVjdCBibGtfem9uZSAtIFpvbmUgZGVzY3Jp
cHRvciBmb3IgQkxLUkVQT1JUWk9ORSBpb2N0bC4KICAqCkBAIC05OSw3ICsxMDgsOSBAQCBzdHJ1
Y3QgYmxrX3pvbmUgewogCV9fdTgJY29uZDsJCS8qIFpvbmUgY29uZGl0aW9uICovCiAJX191OAlu
b25fc2VxOwkvKiBOb24tc2VxdWVudGlhbCB3cml0ZSByZXNvdXJjZXMgYWN0aXZlICovCiAJX191
OAlyZXNldDsJCS8qIFJlc2V0IHdyaXRlIHBvaW50ZXIgcmVjb21tZW5kZWQgKi8KLQlfX3U4CXJl
c2VydmVkWzM2XTsKKwlfX3U4CXJlc3ZbNF07CisJX191NjQJY2FwYWNpdHk7CS8qIFpvbmUgY2Fw
YWNpdHkgaW4gbnVtYmVyIG9mIHNlY3RvcnMgKi8KKwlfX3U4CXJlc2VydmVkWzI0XTsKIH07CiAK
IC8qKgpAQCAtMTE1LDcgKzEyNiw3IEBAIHN0cnVjdCBibGtfem9uZSB7CiBzdHJ1Y3QgYmxrX3pv
bmVfcmVwb3J0IHsKIAlfX3U2NAkJc2VjdG9yOwogCV9fdTMyCQlucl96b25lczsKLQlfX3U4CQly
ZXNlcnZlZFs0XTsKKwlfX3UzMgkJZmxhZ3M7CiAJc3RydWN0IGJsa196b25lIHpvbmVzWzBdOwog
fTsKIAotLSAKMi4yNC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
