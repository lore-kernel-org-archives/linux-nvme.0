Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC4C433EA
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFE62065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTbpYDPi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBC9hLej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFE62065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MSCQMhllQ/jpjkN4t8+ZguOywN454kusV02ORA2EUps=; b=pTbpYDPidB7Xva/r8wLt9JMZw
	d8AcsgWNz0sFkCndhxEBgxKc+J0Zq2P2Si6PT182saa9pIqA/mkv9DSBVpWbSEJIr8bv7L2UDzNSp
	HWdGYdQRs7h5vwtexdJqwD47dZ1CMNmSUgvHFmkovh1vhJbFfbUEBwzZX4Hu8EoxTu33xbcjKxHiR
	wT/mv6MzR/7+wxJHJS2LjsyEmJ36/slpcOX7HxAFUq1urMuIjG2+GjFBmZ4uQE9V+Rc3Y1mLuLEtY
	4+RUqZDNREKXY0W2eqTxoM64jRs6VmRPQw9cObFG59lzNnpZjWxFvhXHkP042x9GeP1lEgBQNNNbw
	gy+w1ruPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUPT-0005eY-9l; Tue, 14 Jul 2020 23:32:27 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUPQ-0005cd-AN
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769545; x=1626305545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Vr4YKUWTtdZGAzFAbg93dNY9QvnoEcEotRDJe4Pvhg=;
 b=UBC9hLejCnosnm+7yuVNu+HRchdDlRO35tg1fHF+GBKYk+hqaQewwAdz
 yUKSIypYbZmc3XyY1wVCtFczRn/tPbClS8MvScJUteHqwbSsQ1oGBvM1S
 L3mc8vgj1p38F1ElzeiO0eTwrWZcVJ/hpjWK+N2twHcgdXTDnebOlkLpd
 1XAvE9fabPk97JkkGw2aZ5ioK7lfa1MtTqu7QqhiJZyrwGP9LzyT4c8Or
 3NAhU2RbXAMYY5neUjCNhph/AWyooilz/rPWY9v4Lg5U7cMlTVmCyf1dr
 tEMy6d3qUY/Mk5esmoSSqWU2KgXjmn7j6mUmIM0B0sZlkzNt2//T0RCSZ w==;
IronPort-SDR: XGiEJRS6sw1MafZZm9Af7Ya8fn45dxGryrpB6l93+nuPKrTpolxATVJTMXr2T7yEXbwDwlBY39
 93PAYGoKIDhyC5LPPDYIkA5m4HcAppLf+BBA6vKoHh4QYIuLWn5e/fKcAcj3Fma5GGjyTj8sP+
 dQR0be5ySroCZRsfGt8R80KfVdKFPLj0FVGWQWejmeyoLz9p22kF+ZIylxHWGcftngGe4jLzpk
 R6Hk28R6T0A4uP1M8ich9N3j6Aoq2KUGyiHhGSn7tybse//Ao7Vps0v3Zfq+HczQT6dM/00tQT
 BYE=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="142609569"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:32:24 +0800
IronPort-SDR: KQ5/y82nkb4Z+JUn39WTGUTE3uJ3RFhgRy3lwPj8tTpYPVj/qXHKwrdeKbDeQZFx1oGTZN1d4W
 2Fj/Z+DwVzRcGudONWggJPYUWUNu/9N3c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:20:50 -0700
IronPort-SDR: eNtmWRbZ2hfmC3xJtgLpufKy46v4ffo+VONZQ9ijA3MZWslarU+o3dpw9IAAIKOOR3FLnzoFqH
 e8XrDyzLsfXw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:32:23 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 09/10] nvme: centralize queue action nvme_sync_queues()
Date: Tue, 14 Jul 2020 16:30:56 -0700
Message-Id: <20200714233057.10915-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193224_520583_13B3BD27 
X-CRM114-Status: GOOD (  12.39  )
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
c3ltYm9sLgoKVGhpcyBwYXRjaCBtZXJnZXMgbnZtZV9zeW5jX3F1ZXVlcygpIGludG8gbmV3bHkg
aW50cm9kdWNlZApudm1lX3F1ZXVlX2FjdCgpIHdoaWNoIGhhbmRsZXMgdGhlIHF1ZXVlIG1hbmFn
ZW1lbnQuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxr
YXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDEzICsrKy0tLS0t
LS0tLS0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8ICAyICstCiBkcml2ZXJzL252bWUvaG9z
dC9wY2kuYyAgfCAgNiArKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggNjUwNGU3MTNjMGZiLi45MzZjZGM3ODY4ZTIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKQEAgLTQ0ODcsNiArNDQ4Nyw5IEBAIHZvaWQgbnZtZV9xdWV1ZV9hY3Qoc3Ry
dWN0IG52bWVfY3RybCAqY3RybCwgZW51bSBudm1lX3F1ZXVlX2FjdCBvcCkKIAkJY2FzZSBOVk1F
X1NUQVJUX1FVRVVFUzoKIAkJCWJsa19tcV91bnF1aWVzY2VfcXVldWUobnMtPnF1ZXVlKTsKIAkJ
CWJyZWFrOworCQljYXNlIE5WTUVfU1lOQ19RVUVVRVM6CisJCQlibGtfc3luY19xdWV1ZShucy0+
cXVldWUpOworCQkJYnJlYWs7CiAJCWRlZmF1bHQ6CiAJCQlwcl93YXJuKCJpbnZhbGlkICVzIG9w
IDB4JXhcbiIsIF9fZnVuY19fLCBvcCk7CiAJCQlicmVhazsKQEAgLTQ1MDgsMTYgKzQ1MTEsNiBA
QCB2b2lkIG52bWVfd2FpdF9mcmVlemVfdGltZW91dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBs
b25nIHRpbWVvdXQpCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3dhaXRfZnJlZXplX3RpbWVv
dXQpOwogCi12b2lkIG52bWVfc3luY19xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCkKLXsK
LQlzdHJ1Y3QgbnZtZV9ucyAqbnM7Ci0JdW5zaWduZWQgbG9uZyBpZHg7Ci0KLQl4YV9mb3JfZWFj
aCgmY3RybC0+bmFtZXNwYWNlcywgaWR4LCBucykKLQkJYmxrX3N5bmNfcXVldWUobnMtPnF1ZXVl
KTsKLX0KLUVYUE9SVF9TWU1CT0xfR1BMKG52bWVfc3luY19xdWV1ZXMpOwotCiAvKgogICogQ2hl
Y2sgd2UgZGlkbid0IGluYWR2ZXJ0ZW50bHkgZ3JvdyB0aGUgY29tbWFuZCBzdHJ1Y3R1cmUgc2l6
ZXM6CiAgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaAppbmRleCA0MTkwNzBkMGM0NDIuLjhkNzRlYWJlZTQxZCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaApAQCAtNTUyLDEwICs1NTIsMTAgQEAgZW51bSBudm1lX3F1ZXVlX2FjdCB7CiAJTlZNRV9T
VEFSVF9GUkVFWkVfUVVFVUVTLAogCU5WTUVfU1RPUF9RVUVVRVMsCiAJTlZNRV9TVEFSVF9RVUVV
RVMsCisJTlZNRV9TWU5DX1FVRVVFUywKIH07CiAKIHZvaWQgbnZtZV9xdWV1ZV9hY3Qoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgZW51bSBudm1lX3F1ZXVlX2FjdCBvcCk7Ci12b2lkIG52bWVfc3lu
Y19xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCk7CiB2b2lkIG52bWVfd2FpdF9mcmVlemVf
dGltZW91dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBsb25nIHRpbWVvdXQpOwogCiAjZGVmaW5l
IE5WTUVfUUlEX0FOWSAtMQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9wY2kuYwppbmRleCBiN2UxNGI4NmUwMGEuLjIzOGZmNGM3N2RlNyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvcGNpLmMKQEAgLTI1MzIsNyArMjUzMiw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcmVzZXRfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJICovCiAJaWYgKGRldi0+Y3RybC5jdHJsX2Nv
bmZpZyAmIE5WTUVfQ0NfRU5BQkxFKQogCQludm1lX2Rldl9kaXNhYmxlKGRldiwgZmFsc2UpOwot
CW52bWVfc3luY19xdWV1ZXMoJmRldi0+Y3RybCk7CisJbnZtZV9xdWV1ZV9hY3QoJmRldi0+Y3Ry
bCwgTlZNRV9TWU5DX1FVRVVFUyk7CiAKIAltdXRleF9sb2NrKCZkZXYtPnNodXRkb3duX2xvY2sp
OwogCXJlc3VsdCA9IG52bWVfcGNpX2VuYWJsZShkZXYpOwpAQCAtMjg1OSw3ICsyODU5LDcgQEAg
c3RhdGljIHZvaWQgbnZtZV9yZXNldF9wcmVwYXJlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogCSAq
IHdpdGggLT5yZW1vdmUoKS4KIAkgKi8KIAludm1lX2Rpc2FibGVfcHJlcGFyZV9yZXNldChkZXYs
IGZhbHNlKTsKLQludm1lX3N5bmNfcXVldWVzKCZkZXYtPmN0cmwpOworCW52bWVfcXVldWVfYWN0
KCZkZXYtPmN0cmwsIE5WTUVfU1lOQ19RVUVVRVMpOwogfQogCiBzdGF0aWMgdm9pZCBudm1lX3Jl
c2V0X2RvbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCkBAIC0yOTY1LDcgKzI5NjUsNyBAQCBzdGF0
aWMgaW50IG52bWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAKIAludm1lX3F1ZXVlX2Fj
dChjdHJsLCBOVk1FX1NUQVJUX0ZSRUVaRV9RVUVVRVMpOwogCW52bWVfcXVldWVfYWN0KGN0cmws
IE5WTUVfV0FJVF9GUkVFWkVfUVVFVUVTKTsKLQludm1lX3N5bmNfcXVldWVzKGN0cmwpOworCW52
bWVfcXVldWVfYWN0KGN0cmwsIE5WTUVfU1lOQ19RVUVVRVMpOwogCiAJaWYgKGN0cmwtPnN0YXRl
ICE9IE5WTUVfQ1RSTF9MSVZFKQogCQlnb3RvIHVuZnJlZXplOwotLSAKMi4yNi4wCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
