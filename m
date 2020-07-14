Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D90FC433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0092065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lRSFHKlt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q4FGhL+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0092065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=59Ji39aD4Qo4MXz+Hif23kUyPjrPIpPE0CRtC1TJeSw=; b=lRSFHKltmvfVViW1Gd3B+8Vyx
	ZqG1Mvwzuq9jeL/q1UVt9QEFYERtErjWHC82cr/RAxZTLkNaX/sdoaaAV3RxO9PldVtv6O8PEC7Cw
	ehy4RWQYr4K/c8JSSOCqts9QklV0zrUdxC8EVLBQW3tIEmyOYytKnzcuCWOSTom+TiDFm7V4bDL11
	YqApkczqUIfv88HqvOohKOqerj4rTzSrxij1MjlIgDWoH0PJbIsCbrOweIfhSapQaDwdVisFG8d4E
	YR0jprPVmT6xRHYHnSTbr+w79yPqf4dM9og3XBthEsFR6RZjACNvb75XKo8Qg0+EKJUOuTf/adrKG
	LxU7jXLfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUOx-0005RP-Ta; Tue, 14 Jul 2020 23:31:55 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOu-0005QB-DS
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769512; x=1626305512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BbGAtOJTc6/9foNgDVq4cCBdhuFPxLaL/q9naqakwzY=;
 b=q4FGhL+4gCxuxYVp4QcZql02VNFwCN0SjbQKAzgD3S72pe3yY6vZEXHr
 5esCprmsEvmMvBMkwoksarZ1NvQe62vjYuAP/CZ/UDwmuXALz97j3iVNM
 R25oz21vKxstJIyOupwuNTSEp1sljbkn34zUE6lBJnbh4xEJIcQSdGE9M
 5KrtMKy5xSEPVBFAy2q4jhuLJqFMVxNi3VBJCfwwHa4CeyelOGW2BJhTx
 n7CyE3pix+TrsSxaCZ3Tvy/4ulm7qmddv4vQKFSuotBZOjAipjmVCcblm
 33wYp2SSKrW1dvQFqlTBWLAcTRIgllFc0Wb0Fz9cv+ewgVZgEOVAXU+T2 Q==;
IronPort-SDR: oVjSPPh+imU+Wq2Ab6tKAw1nwKN9IpM8GzWdqlRVFD1oCLtgKBJLg5r77KC8NKL3M1Yh3jFy2N
 pjZgd0D9fDSP+MqN/SP3MM/N7fXx3Fw6HGnuAycKF6wIFuUxkHSJxzExYCgrMqk5iezBvEOB0g
 PBgxUsPbjQwDK1M5mQl7ynp7bA3sYr24z067Sv0bfhjew53Cq4aZD471348vGDezyK+C6qUSyj
 3XApPaMoJ1zjHWch8s1QBcV8OrSaKAOR7xxqotnZ5/q1DEqcVgIENa5Id6J1yFM4h9Of6snlJK
 NS0=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="251729635"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:31:50 +0800
IronPort-SDR: V6udfJUEZPSkyvW6Bht04rXYGt7FOzcMvrqK+4Up5D62QQ3ajZr2b3H7Ia3wKNxDKOh4evYu1G
 c9KG2P5mx0Fwwsn3HkdyiuRI33YLcM1Js=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:19:43 -0700
IronPort-SDR: cKkcH4ubKxtPWM6f+gC+pSjxqSo4j4E1SH1cGIHCXJIoumn5PNKYNtMT+O+miJHi8Whd8vvPEd
 s+ZHiHbWYD2g==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:50 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 04/10] nvme: centralize queue action nvme_unfreeze()
Date: Tue, 14 Jul 2020 16:30:51 -0700
Message-Id: <20200714233057.10915-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193152_617255_D6441218 
X-CRM114-Status: GOOD (  12.89  )
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
c3ltYm9sLgoKVGhpcyBwYXRjaCBtZXJnZXMgbnZtZV91bmZyZWV6ZSgpIGludG8gbmV3bHkgaW50
cm9kdWNlZCBudm1lX3F1ZXVlX2FjdCgpCndoaWNoIGhhbmRsZXMgdGhlIHF1ZXVlIG1hbmFnZW1l
bnQuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJu
aUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE1ICsrKystLS0tLS0t
LS0tLQogZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS9ob3N0
L3BjaS5jICB8ICA0ICsrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggYjM5YWFmY2JkZGU5Li5mZGY0N2ZmN2M2MGMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKQEAgLTE0NTIsNyArMTQ1Miw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcGFzc3RocnVf
ZW5kKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHUzMiBlZmZlY3RzKQogCWlmIChlZmZlY3RzICYg
TlZNRV9DTURfRUZGRUNUU19MQkNDKQogCQludm1lX3VwZGF0ZV9mb3JtYXRzKGN0cmwsICZlZmZl
Y3RzKTsKIAlpZiAoZWZmZWN0cyAmIChOVk1FX0NNRF9FRkZFQ1RTX0xCQ0MgfCBOVk1FX0NNRF9F
RkZFQ1RTX0NTRV9NQVNLKSkgewotCQludm1lX3VuZnJlZXplKGN0cmwpOworCQludm1lX3F1ZXVl
X2FjdChjdHJsLCBOVk1FX1VORlJFRVpFX1FVRVVFUyk7CiAJCW52bWVfbXBhdGhfdW5mcmVlemUo
Y3RybC0+c3Vic3lzKTsKIAkJbXV0ZXhfdW5sb2NrKCZjdHJsLT5zdWJzeXMtPmxvY2spOwogCQlu
dm1lX3JlbW92ZV9pbnZhbGlkX25hbWVzcGFjZXMoY3RybCwgTlZNRV9OU0lEX0FMTCk7CkBAIC00
NDcyLDYgKzQ0NzIsOSBAQCB2b2lkIG52bWVfcXVldWVfYWN0KHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwsIGVudW0gbnZtZV9xdWV1ZV9hY3Qgb3ApCiAJCWNhc2UgTlZNRV9LSUxMX1FVRVVFUzoKIAkJ
CW52bWVfc2V0X3F1ZXVlX2R5aW5nKG5zKTsKIAkJCWJyZWFrOworCQljYXNlIE5WTUVfVU5GUkVF
WkVfUVVFVUVTOgorCQkJYmxrX21xX3VuZnJlZXplX3F1ZXVlKG5zLT5xdWV1ZSk7CisJCQlicmVh
azsKIAkJZGVmYXVsdDoKIAkJCXByX3dhcm4oImludmFsaWQgJXMgb3AgMHgleFxuIiwgX19mdW5j
X18sIG9wKTsKIAkJCWJyZWFrOwpAQCAtNDQ4MCwxNiArNDQ4Myw2IEBAIHZvaWQgbnZtZV9xdWV1
ZV9hY3Qoc3RydWN0IG52bWVfY3RybCAqY3RybCwgZW51bSBudm1lX3F1ZXVlX2FjdCBvcCkKIH0K
IEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfcXVldWVfYWN0KTsKIAotdm9pZCBudm1lX3VuZnJlZXpl
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCi17Ci0Jc3RydWN0IG52bWVfbnMgKm5zOwotCXVuc2ln
bmVkIGxvbmcgaWR4OwotCi0JeGFfZm9yX2VhY2goJmN0cmwtPm5hbWVzcGFjZXMsIGlkeCwgbnMp
Ci0JCWJsa19tcV91bmZyZWV6ZV9xdWV1ZShucy0+cXVldWUpOwotfQotRVhQT1JUX1NZTUJPTF9H
UEwobnZtZV91bmZyZWV6ZSk7Ci0KIHZvaWQgbnZtZV93YWl0X2ZyZWV6ZV90aW1lb3V0KHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwsIGxvbmcgdGltZW91dCkKIHsKIAlzdHJ1Y3QgbnZtZV9ucyAqbnM7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgKaW5kZXggYjFjZGU4NWU5YTg1Li5hMWIyMzY0ZDJiYjIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKQEAg
LTU0NywxMyArNTQ3LDEzIEBAIHZvaWQgbnZtZV9jb21wbGV0ZV9hc3luY19ldmVudChzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsLCBfX2xlMTYgc3RhdHVzLAogCiBlbnVtIG52bWVfcXVldWVfYWN0IHsK
IAlOVk1FX0tJTExfUVVFVUVTID0gMSwKKwlOVk1FX1VORlJFRVpFX1FVRVVFUywKIH07CiAKIHZv
aWQgbnZtZV9xdWV1ZV9hY3Qoc3RydWN0IG52bWVfY3RybCAqY3RybCwgZW51bSBudm1lX3F1ZXVl
X2FjdCBvcCk7CiB2b2lkIG52bWVfc3RvcF9xdWV1ZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCk7
CiB2b2lkIG52bWVfc3RhcnRfcXVldWVzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpOwogdm9pZCBu
dm1lX3N5bmNfcXVldWVzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpOwotdm9pZCBudm1lX3VuZnJl
ZXplKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpOwogdm9pZCBudm1lX3dhaXRfZnJlZXplKHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwpOwogdm9pZCBudm1lX3dhaXRfZnJlZXplX3RpbWVvdXQoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgbG9uZyB0aW1lb3V0KTsKIHZvaWQgbnZtZV9zdGFydF9mcmVlemUo
c3RydWN0IG52bWVfY3RybCAqY3RybCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9w
Y2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCmluZGV4IGNlMDRhNzZhNDhhZi4uYjg3ZTJm
MGRjZGYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYworKysgYi9kcml2ZXJz
L252bWUvaG9zdC9wY2kuYwpAQCAtMjYyNCw3ICsyNjI0LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9y
ZXNldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJbnZtZV9zdGFydF9xdWV1ZXMo
JmRldi0+Y3RybCk7CiAJCW52bWVfd2FpdF9mcmVlemUoJmRldi0+Y3RybCk7CiAJCW52bWVfZGV2
X2FkZChkZXYpOwotCQludm1lX3VuZnJlZXplKCZkZXYtPmN0cmwpOworCQludm1lX3F1ZXVlX2Fj
dCgmZGV2LT5jdHJsLCBOVk1FX1VORlJFRVpFX1FVRVVFUyk7CiAJfQogCiAJLyoKQEAgLTI5OTcs
NyArMjk5Nyw3IEBAIHN0YXRpYyBpbnQgbnZtZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikK
IAkJY3RybC0+bnBzcyA9IDA7CiAJfQogdW5mcmVlemU6Ci0JbnZtZV91bmZyZWV6ZShjdHJsKTsK
Kwludm1lX3F1ZXVlX2FjdChjdHJsLCBOVk1FX1VORlJFRVpFX1FVRVVFUyk7CiAJcmV0dXJuIHJl
dDsKIH0KIAotLSAKMi4yNi4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
