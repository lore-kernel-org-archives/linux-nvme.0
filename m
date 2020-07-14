Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDFFC433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8802065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKt0qyMt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pFuYEu9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8802065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pX+J3dXrfDK0LAx1/MephJVTQ5QxStRvJ9D6jKBqR+A=; b=BKt0qyMtNIfRW9Ets7MP2o7id
	ZB2fA8JocIXEG5qVoWm01GVr8dGowTC+Qd2xMtuSsxjrlm/O+Y1G8BfORphAFf2L6LKcQYwe5QphR
	dIvruN4hNeHlOpGlYJ2eZuSNbkwhgs5nSKj0I6rR4/GNJBB03EOLHrxCfaRdz4ZsMGxJdRWMXRvd5
	Rc1sTp4Cod19iq20VaOUwGAVXGEB8OxSrUw2iWeBwsfzlNE8qTIxcmlB+752QrXCkK5POagHbDe2C
	jsJiKmO5TunDgXSMiPyvaBSi3LPx6Y97/EgoEPfYQG9qDQ7zHkdLsunYJeZFCvEuFEBZNGHLunonS
	raOTDcltw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUP9-0005Vl-8e; Tue, 14 Jul 2020 23:32:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUP6-0005UZ-QM
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769525; x=1626305525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JL2BhpglT0dbR2uHM9WP2foj84XefU85SxQE8AcnYs0=;
 b=pFuYEu9s3vC4yqy5pZ06OXFWDnWUb6d12wRk/1/oiGawy8h2S+AwwKUb
 fYqBz0K6YDRzX8FUD+rsF89EqHm4GyQ+nIsIE0jqbgKOnbmhmjyOsWHR+
 wiTGcNB4LSXVyBPxdHeMjAPI6fyeiNaoMo++PcuvCMwsaHhWlnhMKl95g
 6sMPn0TiqAEWPWpHqqzzKC4NfnUK/NKU1VHJtnxm8Cxv39A5T+D7Y0TFw
 ZXUtIU//Wd2H3bt//0FqDYyHbBELrdDhFUwPf78y7dz6/NyTMz7zI6vso
 CbcDG7qajWgQlPMeML1mpUuyzlr8OtE+aCfszhT9yhEzOKpLx1qMgnJ6j Q==;
IronPort-SDR: JPYpbkvJp5oUB+QKW43U3GPDAroWh4wiuqdyFNjUFmvXzMiO7J++y+no8riAedIBJOCWRcaOf5
 OBuW0UdfzMoC5BwxfpJ8tJyrkV4FHq6cyKE2Q1/PZ4nFZM+mM+buO1jDmWkt5LOTt4cfxLfnU0
 KfqbLTvGxejci/PdfOaCDqPVYFwGoCqqT7cVYSaCYXIbDQtKjY6p9/pS5gdw5cpDNsSLybF76E
 xByNrhoNme9+Zhy75ujHb5USyG/wRSe8kAe6CNdnfXK8a5QUAi8MbTvHDOvk0epHjeAa+HfoTJ
 Cc4=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="146783459"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:32:04 +0800
IronPort-SDR: 6m8y3aGYQkNUEiJki4NYl99ji26lQDPYG0GmOj1DJkzeDXzjfi1qcnFAMwYBAVkELadEAGDviV
 eMKwsfkYeWKxx5gZaGtRwa/h6XBUlSowY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:20:30 -0700
IronPort-SDR: W/ytxoPdRTfT0fCMpnQTji8D8NP7jFb5Uwd2HgmM2KuWAJVUrMqkB6EaLPvruX9nz4rFCCOxMD
 BN91DBca2RVg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:32:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 06/10] nvme: centralize queue action nvme_start_freeze()
Date: Tue, 14 Jul 2020 16:30:53 -0700
Message-Id: <20200714233057.10915-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193205_025046_E1554654 
X-CRM114-Status: GOOD (  12.71  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlcmUgaXMgbm8gcG9pbnQgaW4gaGF2aW5nIDcgZGlmZmVyZW50IGZ1bmN0aW9ucyB3aGljaCBh
cmUgZGlmZmVyaW5nCndpdGgganVzdCBvbmUgbGluZS4KClRoZSBoZWxwZXIgZnVuY3Rpb25zIGZv
ciBjdHJsIHF1ZXVlIG1hbmFnZW1lbnQgY2FuIGJlIGNlbnRyYWxpemVkwqB3aXRoCnRoZSBoZWxw
IG9mIHRoZSBkZXNjcmlwdGl2ZSBlbnVtcyBmb3IgYWN0aW9uLiBUaGlzIGF2b2lkcyBjb2RlCmR1
cGxpY2F0aW9uIHdoaWNoIHNwYW5zIGFjcm9zcyB0aGUgNyBmdW5jdGlvbnMgYXMgY29tcGFyZSB0
byBvbmUKZnVuY3Rpb24gYW5kIGV4cG9ydGluZyA3IHN5bWJvbHMgYXMgY29tcGFyZSB0byBvbmUg
c3ltYm9sLgoKVGhpcyBwYXRjaCBtZXJnZXMgbnZtZV9zdGFydF9mcmVlemUoKSBpbnRvIG5ld2x5
IGludHJvZHVjZWQKbnZtZV9xdWV1ZV9hY3QoKSB3aGljaCBoYW5kbGVzIHRoZSBxdWV1ZSBtYW5l
Z2VtZW50LgoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vs
a2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxNSArKysrLS0t
LS0tLS0tLS0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8ICAyICstCiBkcml2ZXJzL252bWUv
aG9zdC9wY2kuYyAgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IDVkMmY4NWIyMjA2MS4uMjIwMmExM2Q1NDhk
IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCkBAIC0xNDE3LDcgKzE0MTcsNyBAQCBzdGF0aWMgdTMyIG52bWVfcGFzc3Ro
cnVfc3RhcnQoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfbnMgKm5zLAogCQlt
dXRleF9sb2NrKCZjdHJsLT5zdWJzeXMtPmxvY2spOwogCQludm1lX21wYXRoX3N0YXJ0X2ZyZWV6
ZShjdHJsLT5zdWJzeXMpOwogCQludm1lX21wYXRoX3dhaXRfZnJlZXplKGN0cmwtPnN1YnN5cyk7
Ci0JCW52bWVfc3RhcnRfZnJlZXplKGN0cmwpOworCQludm1lX3F1ZXVlX2FjdChjdHJsLCBOVk1F
X1NUQVJUX0ZSRUVaRV9RVUVVRVMpOwogCQludm1lX3F1ZXVlX2FjdChjdHJsLCBOVk1FX1dBSVRf
RlJFRVpFX1FVRVVFUyk7CiAJfQogCXJldHVybiBlZmZlY3RzOwpAQCAtNDQ3OCw2ICs0NDc4LDkg
QEAgdm9pZCBudm1lX3F1ZXVlX2FjdChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBlbnVtIG52bWVf
cXVldWVfYWN0IG9wKQogCQljYXNlIE5WTUVfV0FJVF9GUkVFWkVfUVVFVUVTOgogCQkJYmxrX21x
X2ZyZWV6ZV9xdWV1ZV93YWl0KG5zLT5xdWV1ZSk7CiAJCQlicmVhazsKKwkJY2FzZSBOVk1FX1NU
QVJUX0ZSRUVaRV9RVUVVRVM6CisJCQlibGtfZnJlZXplX3F1ZXVlX3N0YXJ0KG5zLT5xdWV1ZSk7
CisJCQlicmVhazsKIAkJZGVmYXVsdDoKIAkJCXByX3dhcm4oImludmFsaWQgJXMgb3AgMHgleFxu
IiwgX19mdW5jX18sIG9wKTsKIAkJCWJyZWFrOwpAQCAtNDQ5OSwxNiArNDUwMiw2IEBAIHZvaWQg
bnZtZV93YWl0X2ZyZWV6ZV90aW1lb3V0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGxvbmcgdGlt
ZW91dCkKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfd2FpdF9mcmVlemVfdGltZW91dCk7CiAK
LXZvaWQgbnZtZV9zdGFydF9mcmVlemUoc3RydWN0IG52bWVfY3RybCAqY3RybCkKLXsKLQlzdHJ1
Y3QgbnZtZV9ucyAqbnM7Ci0JdW5zaWduZWQgbG9uZyBpZHg7Ci0KLQl4YV9mb3JfZWFjaCgmY3Ry
bC0+bmFtZXNwYWNlcywgaWR4LCBucykKLQkJYmxrX2ZyZWV6ZV9xdWV1ZV9zdGFydChucy0+cXVl
dWUpOwotfQotRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9zdGFydF9mcmVlemUpOwotCiB2b2lkIG52
bWVfc3RvcF9xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCkKIHsKIAlzdHJ1Y3QgbnZtZV9u
cyAqbnM7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmgKaW5kZXggMzQ5ZTdjZDZkZDY1Li44OTIxNTRkMmE0NjUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1l
LmgKQEAgLTU0OSw2ICs1NDksNyBAQCBlbnVtIG52bWVfcXVldWVfYWN0IHsKIAlOVk1FX0tJTExf
UVVFVUVTID0gMSwKIAlOVk1FX1VORlJFRVpFX1FVRVVFUywKIAlOVk1FX1dBSVRfRlJFRVpFX1FV
RVVFUywKKwlOVk1FX1NUQVJUX0ZSRUVaRV9RVUVVRVMsCiB9OwogCiB2b2lkIG52bWVfcXVldWVf
YWN0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGVudW0gbnZtZV9xdWV1ZV9hY3Qgb3ApOwpAQCAt
NTU2LDcgKzU1Nyw2IEBAIHZvaWQgbnZtZV9zdG9wX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9jdHJsICpj
dHJsKTsKIHZvaWQgbnZtZV9zdGFydF9xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCk7CiB2
b2lkIG52bWVfc3luY19xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCk7CiB2b2lkIG52bWVf
d2FpdF9mcmVlemVfdGltZW91dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBsb25nIHRpbWVvdXQp
Owotdm9pZCBudm1lX3N0YXJ0X2ZyZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIAogI2Rl
ZmluZSBOVk1FX1FJRF9BTlkgLTEKIHN0cnVjdCByZXF1ZXN0ICpudm1lX2FsbG9jX3JlcXVlc3Qo
c3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9w
Y2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCmluZGV4IDcxZTU4ZDUxZDFiMC4uOTI4MjBm
ZGJhNTk1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYworKysgYi9kcml2ZXJz
L252bWUvaG9zdC9wY2kuYwpAQCAtMjQwNSw3ICsyNDA1LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9k
ZXZfZGlzYWJsZShzdHJ1Y3QgbnZtZV9kZXYgKmRldiwgYm9vbCBzaHV0ZG93bikKIAkJaWYgKGRl
di0+Y3RybC5zdGF0ZSA9PSBOVk1FX0NUUkxfTElWRSB8fAogCQkgICAgZGV2LT5jdHJsLnN0YXRl
ID09IE5WTUVfQ1RSTF9SRVNFVFRJTkcpIHsKIAkJCWZyZWV6ZSA9IHRydWU7Ci0JCQludm1lX3N0
YXJ0X2ZyZWV6ZSgmZGV2LT5jdHJsKTsKKwkJCW52bWVfcXVldWVfYWN0KCZkZXYtPmN0cmwsIE5W
TUVfU1RBUlRfRlJFRVpFX1FVRVVFUyk7CiAJCX0KIAkJZGVhZCA9ICEhKChjc3RzICYgTlZNRV9D
U1RTX0NGUykgfHwgIShjc3RzICYgTlZNRV9DU1RTX1JEWSkgfHwKIAkJCXBkZXYtPmVycm9yX3N0
YXRlICAhPSBwY2lfY2hhbm5lbF9pb19ub3JtYWwpOwpAQCAtMjk2Myw3ICsyOTYzLDcgQEAgc3Rh
dGljIGludCBudm1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQogCSAgICAobmRldi0+Y3Ry
bC5xdWlya3MgJiBOVk1FX1FVSVJLX1NJTVBMRV9TVVNQRU5EKSkKIAkJcmV0dXJuIG52bWVfZGlz
YWJsZV9wcmVwYXJlX3Jlc2V0KG5kZXYsIHRydWUpOwogCi0JbnZtZV9zdGFydF9mcmVlemUoY3Ry
bCk7CisJbnZtZV9xdWV1ZV9hY3QoY3RybCwgTlZNRV9TVEFSVF9GUkVFWkVfUVVFVUVTKTsKIAlu
dm1lX3F1ZXVlX2FjdChjdHJsLCBOVk1FX1dBSVRfRlJFRVpFX1FVRVVFUyk7CiAJbnZtZV9zeW5j
X3F1ZXVlcyhjdHJsKTsKIAotLSAKMi4yNi4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
