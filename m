Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE5C433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823C12065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="taXmSLPw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="frVZGFrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823C12065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J+pNVB5YJoAv2k6m82XsZDltWMIsG7t6yBpnbWOCZ/U=; b=taXmSLPw3Ir3fUmjlhpyXNpQ2
	pdwlioLirVHcseReHxoWpruiN6SdNAmX5uYOLA1oLZ9jIjFlA6y/4gtsi5vBjjZZLvr163+3xa+5V
	7BU398LH8N0v/gMptuU29Bn+02M4VJSGZMaRmTU/AMoX3HgPjspscxTYcH3M7/rQExkiSm8vpGips
	gjgCUka4uqSKpiLS4SKGRZcSnmfiuz6NdZglril+SrhIPjdk1TURFxkiJgeaUnOh0vn4BsVSRouQC
	IOPizIxxE+cO6ggKahznrfV6E8wnQVZp9zGn2so+c1u2o3lz+L2j7/0yTBXO55Q8KW4X2TwPYD+DF
	/FiVBKNxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUOn-0005Or-Hh; Tue, 14 Jul 2020 23:31:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOl-0005Nm-7z
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769503; x=1626305503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bRrlhFqzDcYFqfTdk9x2ya/1rW/PclWXMDrJ6eL/WEg=;
 b=frVZGFrrcYTILjj+n/Dph8pH1A+2SwNxW12Rsy0woLdSjWiST6COx/JO
 4joBPJqAj6tbeGz/3HKjDZDJ2WhzWFYkwbmKFv4UNiVtEUMkOe5J49wFd
 GeHO9xkQKAqIdAx/tzXJ7mPvlFt/NRysJlB0/Pqz1O5Xx7SkVD9us+UOF
 6DcRDIls2YPmDq/h/Q3HxYqje1QWXk9iyCHJuDNPpzuHPnWIE3QwO2Q4G
 1DWL6UUohciKVjEPd1DKiwzR7vaFxqrVqiBOR8Gj3YLvPSW8nGThn8UQX
 q3GvjOA5BicrPahEtXlx31BDnYH6r4c58zKw6BKrf02HKB1EwicgaIXpb w==;
IronPort-SDR: JtqQtY2FUXqPWQna0tAeVSecWi5C+YsfupTiW9ssLKOC4OYbPtZAYbH+xRyOmqfo8yLUNfdPcV
 0rc6WiS2Ad0OqGkxTkUbQYOdYUBDdeUJlboX9aC8h7ytCiocpcZ/q3xH587rZ1L5w8urPp9WpG
 LM1Kd9VsNyz3JurGDP6SVbf/cekaFoT8ndhFxatrDUas6RX+kgBDgRLPCdOIgFK93AHNTcnl7Y
 5tuYGX2+RuJoqTvd9RbEoY2zwPoiQZnVTxkp0ac9cCn4EkuUBtxasuohveslNsvR7cokcl/Tct
 t+c=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="146783415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:31:42 +0800
IronPort-SDR: 9I081KcQL/pTsSEXtxSJwYYe+5+b5vRZL7++MUq6fg/zazPlVwDgh5qD3tihVBmRxkUOk9hp3i
 ddFJre1sEpWp0pVNxPPrgsQWziWaVFJ+Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:20:08 -0700
IronPort-SDR: DNoBp9V4eDFZbsvpG3RaqqnR2wsyC13hhGJ3GJNzZS7FzU41gFhJ24k94soPwHBUTFgF1POWDj
 GTOPQABJId/w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 03/10] nvme: centralize queue action nvme_kill_queues()
Date: Tue, 14 Jul 2020 16:30:50 -0700
Message-Id: <20200714233057.10915-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193143_425499_702D4CAE 
X-CRM114-Status: GOOD (  14.85  )
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
c3ltYm9sLgoKVGhpcyBwYXRjaCBtZXJnZXMgbnZtZV9raWxsX3F1ZXVlKCkgaW50byBuZXdseSBp
bnRyb2R1Y2VkCm52bWVfcXVldWVfYWN0KCkgd2hpY2ggaGFuZGxlcyB0aGUgcXVldWUgbWFuYWdl
bWVudC4KClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGth
cm5pQHdkYy5jb20+Ci0tLQogZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMzcgKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwg
IDYgKysrKystCiBkcml2ZXJzL252bWUvaG9zdC9wY2kuYyAgfCAgNCArKy0tCiAzIGZpbGVzIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCAy
OTc4MzViZGE5OTYuLmIzOWFhZmNiZGRlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtNDEwNyw3ICs0MTA3LDcg
QEAgdm9pZCBudm1lX3JlbW92ZV9uYW1lc3BhY2VzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiAJ
ICogcG90ZW50aWFsbHkgaGF2aW5nIHRvIGNsZWFuIHVwIHRoZSBmYWlsZWQgc3luYyBsYXRlci4K
IAkgKi8KIAlpZiAoY3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0RFQUQpCi0JCW52bWVfa2lsbF9x
dWV1ZXMoY3RybCk7CisJCW52bWVfcXVldWVfYWN0KGN0cmwsIE5WTUVfS0lMTF9RVUVVRVMpOwog
CiAJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7CiAJeGFfZm9yX2VhY2goJmN0cmwtPm5hbWVz
cGFjZXMsIGlkeCwgbnMpIHsKQEAgLTQ0NTIsMjYgKzQ0NTIsMzMgQEAgaW50IG52bWVfaW5pdF9j
dHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBkZXZpY2UgKmRldiwKIH0KIEVYUE9S
VF9TWU1CT0xfR1BMKG52bWVfaW5pdF9jdHJsKTsKIAotLyoqCi0gKiBudm1lX2tpbGxfcXVldWVz
KCk6IEVuZHMgYWxsIG5hbWVzcGFjZSBxdWV1ZXMKLSAqIEBjdHJsOiB0aGUgZGVhZCBjb250cm9s
bGVyIHRoYXQgbmVlZHMgdG8gZW5kCi0gKgotICogQ2FsbCB0aGlzIGZ1bmN0aW9uIHdoZW4gdGhl
IGRyaXZlciBkZXRlcm1pbmVzIGl0IGlzIHVuYWJsZSB0byBnZXQgdGhlCi0gKiBjb250cm9sbGVy
IGluIGEgc3RhdGUgY2FwYWJsZSBvZiBzZXJ2aWNpbmcgSU8uCi0gKi8KLXZvaWQgbnZtZV9raWxs
X3F1ZXVlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQordm9pZCBudm1lX3F1ZXVlX2FjdChzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLCBlbnVtIG52bWVfcXVldWVfYWN0IG9wKQogewogCXN0cnVjdCBu
dm1lX25zICpuczsKIAl1bnNpZ25lZCBsb25nIGlkeDsKIAotCS8qIEZvcmNpYmx5IHVucXVpZXNj
ZSBxdWV1ZXMgdG8gYXZvaWQgYmxvY2tpbmcgZGlzcGF0Y2ggKi8KLQlpZiAoY3RybC0+YWRtaW5f
cSAmJiAhYmxrX3F1ZXVlX2R5aW5nKGN0cmwtPmFkbWluX3EpKQotCQlibGtfbXFfdW5xdWllc2Nl
X3F1ZXVlKGN0cmwtPmFkbWluX3EpOworCXN3aXRjaCAob3ApIHsKKwljYXNlIE5WTUVfS0lMTF9R
VUVVRVM6CisJCS8qIEZvcmNpYmx5IHVucXVpZXNjZSBxdWV1ZXMgdG8gYXZvaWQgYmxvY2tpbmcg
ZGlzcGF0Y2ggKi8KKwkJaWYgKGN0cmwtPmFkbWluX3EgJiYgIWJsa19xdWV1ZV9keWluZyhjdHJs
LT5hZG1pbl9xKSkKKwkJCWJsa19tcV91bnF1aWVzY2VfcXVldWUoY3RybC0+YWRtaW5fcSk7CisJ
CWJyZWFrOworCWRlZmF1bHQ6CisJCWJyZWFrOworCX0KIAotCXhhX2Zvcl9lYWNoKCZjdHJsLT5u
YW1lc3BhY2VzLCBpZHgsIG5zKQotCQludm1lX3NldF9xdWV1ZV9keWluZyhucyk7CisJeGFfZm9y
X2VhY2goJmN0cmwtPm5hbWVzcGFjZXMsIGlkeCwgbnMpIHsKKwkJc3dpdGNoIChvcCkgeworCQlj
YXNlIE5WTUVfS0lMTF9RVUVVRVM6CisJCQludm1lX3NldF9xdWV1ZV9keWluZyhucyk7CisJCQli
cmVhazsKKwkJZGVmYXVsdDoKKwkJCXByX3dhcm4oImludmFsaWQgJXMgb3AgMHgleFxuIiwgX19m
dW5jX18sIG9wKTsKKwkJCWJyZWFrOworCQl9CisJfQogfQotRVhQT1JUX1NZTUJPTF9HUEwobnZt
ZV9raWxsX3F1ZXVlcyk7CitFWFBPUlRfU1lNQk9MX0dQTChudm1lX3F1ZXVlX2FjdCk7CiAKIHZv
aWQgbnZtZV91bmZyZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQogewpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCmluZGV4
IDFlOGRlZGVlNzRkZi4uYjFjZGU4NWU5YTg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCkBAIC01NDUsOSArNTQ1LDEz
IEBAIGludCBudm1lX3NlY19zdWJtaXQodm9pZCAqZGF0YSwgdTE2IHNwc3AsIHU4IHNlY3AsIHZv
aWQgKmJ1ZmZlciwgc2l6ZV90IGxlbiwKIHZvaWQgbnZtZV9jb21wbGV0ZV9hc3luY19ldmVudChz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBfX2xlMTYgc3RhdHVzLAogCQl2b2xhdGlsZSB1bmlvbiBu
dm1lX3Jlc3VsdCAqcmVzKTsKIAorZW51bSBudm1lX3F1ZXVlX2FjdCB7CisJTlZNRV9LSUxMX1FV
RVVFUyA9IDEsCit9OworCit2b2lkIG52bWVfcXVldWVfYWN0KHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwsIGVudW0gbnZtZV9xdWV1ZV9hY3Qgb3ApOwogdm9pZCBudm1lX3N0b3BfcXVldWVzKHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwpOwogdm9pZCBudm1lX3N0YXJ0X3F1ZXVlcyhzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsKTsKLXZvaWQgbnZtZV9raWxsX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
KTsKIHZvaWQgbnZtZV9zeW5jX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIHZvaWQg
bnZtZV91bmZyZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIHZvaWQgbnZtZV93YWl0X2Zy
ZWV6ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKaW5kZXggMTllMjdkZDE3MTA4Li5j
ZTA0YTc2YTQ4YWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jCkBAIC0yNTA5LDcgKzI1MDksNyBAQCBzdGF0aWMgdm9pZCBu
dm1lX3JlbW92ZV9kZWFkX2N0cmwoc3RydWN0IG52bWVfZGV2ICpkZXYpCiAJbnZtZV9jaGFuZ2Vf
Y3RybF9zdGF0ZSgmZGV2LT5jdHJsLCBOVk1FX0NUUkxfREVMRVRJTkcpOwogCW52bWVfZ2V0X2N0
cmwoJmRldi0+Y3RybCk7CiAJbnZtZV9kZXZfZGlzYWJsZShkZXYsIGZhbHNlKTsKLQludm1lX2tp
bGxfcXVldWVzKCZkZXYtPmN0cmwpOworCW52bWVfcXVldWVfYWN0KCZkZXYtPmN0cmwsIE5WTUVf
S0lMTF9RVUVVRVMpOwogCWlmICghcXVldWVfd29yayhudm1lX3dxLCAmZGV2LT5yZW1vdmVfd29y
aykpCiAJCW52bWVfcHV0X2N0cmwoJmRldi0+Y3RybCk7CiB9CkBAIC0yNjE3LDcgKzI2MTcsNyBA
QCBzdGF0aWMgdm9pZCBudm1lX3Jlc2V0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQog
CSAqLwogCWlmIChkZXYtPm9ubGluZV9xdWV1ZXMgPCAyKSB7CiAJCWRldl93YXJuKGRldi0+Y3Ry
bC5kZXZpY2UsICJJTyBxdWV1ZXMgbm90IGNyZWF0ZWRcbiIpOwotCQludm1lX2tpbGxfcXVldWVz
KCZkZXYtPmN0cmwpOworCQludm1lX3F1ZXVlX2FjdCgmZGV2LT5jdHJsLCBOVk1FX0tJTExfUVVF
VUVTKTsKIAkJbnZtZV9yZW1vdmVfbmFtZXNwYWNlcygmZGV2LT5jdHJsKTsKIAkJbnZtZV9mcmVl
X3RhZ3NldChkZXYpOwogCX0gZWxzZSB7Ci0tIAoyLjI2LjAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
