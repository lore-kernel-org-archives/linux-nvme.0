Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D94C433E5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62122065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBjCM62j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pl4Lp7Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62122065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9eWhT8+rvoIO1fech1/k5JRDSY83SFgfbT+YeeQHey4=; b=LBjCM62jDxIZO4HwRDBL7R/HR
	+fDYgOUAPW8xMXh6faISneYmSfIv3HPIa7PvJykbjkynY+wRP0boYOOG9YZBVDmyReNZW0d5Koqeh
	PXEDsAWq0+PJle4QUJ7+dmWgWRrr6L7PPcp3qCeJkgoBYdzetXhJBwonKPrsynDKRg/cA9uz2ZJCU
	TR0YKWF3FLfLQ6xIt791QObzZhUA9TYXjk7/fPXM5r4zMqYS7U/Fc/tEfKQu0HiF76LPS9GebwnXH
	u8i0CPK7u4e4TJV9h6UdkZfQyaw0y6gNqG4yOlynRX65RqbIH6kjxGtyVRCRlrNFlNWNqa42IC3tw
	Q67iKUJEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUP2-0005TY-Ug; Tue, 14 Jul 2020 23:32:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOz-0005S6-T3
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769553; x=1626305553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yBpeUnI4O84fCTOP+OTMqpQIPjINufcHPWuSaYRj7Gk=;
 b=pl4Lp7BoVijRsP3QXUaKsvA2uzH9pmiD/0l6BtbZn+vvos9hOrhJfC53
 VfX8jA0xiuN5qfIpQzx6Ifco+AP7ba8DWcwAxf4nki/0DVBrCD3r/WRqK
 hxTRyo867CDpDOFZi5WTea58nFH8haHax3TyDpMnSm/ZlGexPFXh3IZai
 cNvbW5kppcsRfmHRjIpgqIrQHdJZ4EJcBze4rGpk6xJXx1qlX/XXqbJ/3
 YyhcDPts/zBrABqqlV6iExWIa6FRjJOZ450zJakCZSgahQZlHlhq7syVz
 kX+B9idRxHoD4/KBSFIqlE+nDdBV0jTAAmV55QaGw7m2Ft2NLeC9HS+58 A==;
IronPort-SDR: XLH/1tPPQBZAtq6hBQNMqYkxxoFDj0A/9WjJ7j9LVrpurZZV/i500xwWFpPpLDU9IsYXZu7vZX
 5z9JCWkYHGkYSZHY+i1RWArAqiJhiuzDvA09WGexAp7mqqhvbASa2xB2AoJxGzUuvCfUJNbDWT
 LdRy78WU94SN2kVMOZFANSqOMEND5eNRP+xEFOFsL9HhVSupEntwtryMBKgyHj6ilUtSvh701g
 6+qwPzUQhoiCIUMPC5MvrhehNXyMsx4EuJ+hUvZ0jOxu+pinF+TVNMNUWbKAc3sDwISsjfyk44
 DFI=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="245499418"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:32:32 +0800
IronPort-SDR: jwfT9z+BnCzaqNFRauNs09x3acGOCq0m6xhCaditUfK0QvZmq5WKopAxy5os0aBGYHJnXJNkjj
 cCneKuaXMu95BHsPi/TqZSDylM2eXPyPM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:20:23 -0700
IronPort-SDR: JNOFDV1WBEzMtPoKPFaEJfjgymU93S55p5emH+4ZaCCyWHqpYi3HvhLkp15rBwNLVQOeKENx3K
 lMPOx71i7Efw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 05/10] nvme: centralize queue action nvme_wait_freeze()
Date: Tue, 14 Jul 2020 16:30:52 -0700
Message-Id: <20200714233057.10915-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193158_096790_0406A0DC 
X-CRM114-Status: GOOD (  12.53  )
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
c3ltYm9sLgoKVGhpcyBwYXRjaCBtZXJnZXMgbnZtZV93YWl0X2ZyZWV6ZSgpIGludG8gbmV3bHkg
aW50cm9kdWNlZApudm1lX3F1ZXVlX2FjdCgpIHdoaWNoIGhhbmRsZXMgdGhlIHF1ZXVlIG1hbmFn
ZW1lbnQuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxr
YXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE1ICsrKystLS0t
LS0tLS0tLQogZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jICB8ICA0ICsrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZmRmNDdmZjdjNjBjLi41ZDJmODViMjIwNjEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKQEAgLTE0MTgsNyArMTQxOCw3IEBAIHN0YXRpYyB1MzIgbnZtZV9wYXNzdGhy
dV9zdGFydChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsCiAJCW52
bWVfbXBhdGhfc3RhcnRfZnJlZXplKGN0cmwtPnN1YnN5cyk7CiAJCW52bWVfbXBhdGhfd2FpdF9m
cmVlemUoY3RybC0+c3Vic3lzKTsKIAkJbnZtZV9zdGFydF9mcmVlemUoY3RybCk7Ci0JCW52bWVf
d2FpdF9mcmVlemUoY3RybCk7CisJCW52bWVfcXVldWVfYWN0KGN0cmwsIE5WTUVfV0FJVF9GUkVF
WkVfUVVFVUVTKTsKIAl9CiAJcmV0dXJuIGVmZmVjdHM7CiB9CkBAIC00NDc1LDYgKzQ0NzUsOSBA
QCB2b2lkIG52bWVfcXVldWVfYWN0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGVudW0gbnZtZV9x
dWV1ZV9hY3Qgb3ApCiAJCWNhc2UgTlZNRV9VTkZSRUVaRV9RVUVVRVM6CiAJCQlibGtfbXFfdW5m
cmVlemVfcXVldWUobnMtPnF1ZXVlKTsKIAkJCWJyZWFrOworCQljYXNlIE5WTUVfV0FJVF9GUkVF
WkVfUVVFVUVTOgorCQkJYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0KG5zLT5xdWV1ZSk7CisJCQli
cmVhazsKIAkJZGVmYXVsdDoKIAkJCXByX3dhcm4oImludmFsaWQgJXMgb3AgMHgleFxuIiwgX19m
dW5jX18sIG9wKTsKIAkJCWJyZWFrOwpAQCAtNDQ5NiwxNiArNDQ5OSw2IEBAIHZvaWQgbnZtZV93
YWl0X2ZyZWV6ZV90aW1lb3V0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGxvbmcgdGltZW91dCkK
IH0KIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfd2FpdF9mcmVlemVfdGltZW91dCk7CiAKLXZvaWQg
bnZtZV93YWl0X2ZyZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQotewotCXN0cnVjdCBudm1l
X25zICpuczsKLQl1bnNpZ25lZCBsb25nIGlkeDsKLQotCXhhX2Zvcl9lYWNoKCZjdHJsLT5uYW1l
c3BhY2VzLCBpZHgsIG5zKQotCQlibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQobnMtPnF1ZXVlKTsK
LX0KLUVYUE9SVF9TWU1CT0xfR1BMKG52bWVfd2FpdF9mcmVlemUpOwotCiB2b2lkIG52bWVfc3Rh
cnRfZnJlZXplKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiB7CiAJc3RydWN0IG52bWVfbnMgKm5z
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hv
c3QvbnZtZS5oCmluZGV4IGExYjIzNjRkMmJiMi4uMzQ5ZTdjZDZkZDY1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9udm1lLmgKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCkBA
IC01NDgsMTMgKzU0OCwxMyBAQCB2b2lkIG52bWVfY29tcGxldGVfYXN5bmNfZXZlbnQoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgX19sZTE2IHN0YXR1cywKIGVudW0gbnZtZV9xdWV1ZV9hY3Qgewog
CU5WTUVfS0lMTF9RVUVVRVMgPSAxLAogCU5WTUVfVU5GUkVFWkVfUVVFVUVTLAorCU5WTUVfV0FJ
VF9GUkVFWkVfUVVFVUVTLAogfTsKIAogdm9pZCBudm1lX3F1ZXVlX2FjdChzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsLCBlbnVtIG52bWVfcXVldWVfYWN0IG9wKTsKIHZvaWQgbnZtZV9zdG9wX3F1ZXVl
cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIHZvaWQgbnZtZV9zdGFydF9xdWV1ZXMoc3RydWN0
IG52bWVfY3RybCAqY3RybCk7CiB2b2lkIG52bWVfc3luY19xdWV1ZXMoc3RydWN0IG52bWVfY3Ry
bCAqY3RybCk7Ci12b2lkIG52bWVfd2FpdF9mcmVlemUoc3RydWN0IG52bWVfY3RybCAqY3RybCk7
CiB2b2lkIG52bWVfd2FpdF9mcmVlemVfdGltZW91dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBs
b25nIHRpbWVvdXQpOwogdm9pZCBudm1lX3N0YXJ0X2ZyZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpj
dHJsKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYwppbmRleCBiODdlMmYwZGNkZjIuLjcxZTU4ZDUxZDFiMCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMK
QEAgLTI2MjIsNyArMjYyMiw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcmVzZXRfd29yayhzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCiAJCW52bWVfZnJlZV90YWdzZXQoZGV2KTsKIAl9IGVsc2Ugewog
CQludm1lX3N0YXJ0X3F1ZXVlcygmZGV2LT5jdHJsKTsKLQkJbnZtZV93YWl0X2ZyZWV6ZSgmZGV2
LT5jdHJsKTsKKwkJbnZtZV9xdWV1ZV9hY3QoJmRldi0+Y3RybCwgTlZNRV9XQUlUX0ZSRUVaRV9R
VUVVRVMpOwogCQludm1lX2Rldl9hZGQoZGV2KTsKIAkJbnZtZV9xdWV1ZV9hY3QoJmRldi0+Y3Ry
bCwgTlZNRV9VTkZSRUVaRV9RVUVVRVMpOwogCX0KQEAgLTI5NjQsNyArMjk2NCw3IEBAIHN0YXRp
YyBpbnQgbnZtZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIAkJcmV0dXJuIG52bWVfZGlz
YWJsZV9wcmVwYXJlX3Jlc2V0KG5kZXYsIHRydWUpOwogCiAJbnZtZV9zdGFydF9mcmVlemUoY3Ry
bCk7Ci0JbnZtZV93YWl0X2ZyZWV6ZShjdHJsKTsKKwludm1lX3F1ZXVlX2FjdChjdHJsLCBOVk1F
X1dBSVRfRlJFRVpFX1FVRVVFUyk7CiAJbnZtZV9zeW5jX3F1ZXVlcyhjdHJsKTsKIAogCWlmIChj
dHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfTElWRSkKLS0gCjIuMjYuMAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
