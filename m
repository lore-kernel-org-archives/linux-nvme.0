Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754CC433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 08:14:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46D620748
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 08:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNcVnE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46D620748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VHLF124Lu8RVwjwi6XJeshQ0YJ4jm6gtzsNqmFlLKHM=; b=lNcVnE2tFGmHnralHuTcmnuSNQ
	Ig0s8HLujXlVDMollQCNXeUHzY9cZ0mCO6re1sw05gdGzskzMUvlzckS0/i50gZhl9IrBkmJkcDcg
	ZtBzhMznZhMib6TyLnhBS7ErtszKOk+wp9hXhE8YqiSfJ73mOvTbHBUOG1+369f36c1XHucvafRQy
	ycxiXBzpl7gRmQsndH/mIEKMFrgATJo94pNNt+esuyVjuN94dxQxUaISKm1IPPKmWt6Wj93mpY/+y
	gWqGvNzX0cWzy+O7y9mK1f8VYtsxamsR7JceLNsi6wI+oyhG68Rwfd2uMIpQ7WKkL//hXSFgqufQj
	1F7KTK0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jysqg-00053c-HI; Fri, 24 Jul 2020 08:14:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jysqc-00050b-Sd
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 08:14:32 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 21D9A7170E8EE2967AE4;
 Fri, 24 Jul 2020 16:14:17 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 16:14:08 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-core: optimize process for error status
 NVME_SC_CMD_INTERRUPTED
Date: Fri, 24 Jul 2020 16:14:07 +0800
Message-ID: <20200724081407.19346-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_041431_674239_D7DFBD8F 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlIHByb3RvY29sIE5WTS1FeHByZXNzLTEuNCBkZWZpbmU6CkNvbW1hbmQgSW50ZXJydXB0ZWQ6
IENvbW1hbmQgcHJvY2Vzc2luZyB3YXMgaW50ZXJydXB0ZWQgYW5kIHRoZQpjb250cm9sbGVyIGlz
IHVuYWJsZSB0byBzdWNjZXNzZnVsbHkgY29tcGxldGUgdGhlIGNvbW1hbmQuIFRoZSBob3N0CnNo
b3VsZCByZXRyeSB0aGUgY29tbWFuZC4gSWYgdGhpcyBzdGF0dXMgY29kZSBpcyByZXR1cm5lZCwg
dGhlbgp0aGUgY29udHJvbGxlciBzaGFsbCBjbGVhciB0aGUgRG8gTm90IFJldHJ5IGJpdCB0byDi
gJgw4oCZIGluIHRoZSBTdGF0dXMKZmllbGQgb2YgdGhlIENRRSAocmVmZXIgdG8gRmlndXJlIDEy
NCkuIFRoZSBjb250cm9sbGVyIHNoYWxsIG5vdCByZXR1cm4KdGhpcyBzdGF0dXMgY29kZSB1bmxl
c3MgdGhlIGhvc3QgaGFzIHNldCB0aGUgQWR2YW5jZWQgQ29tbWFuZCBSZXRyeQpFbmFibGUgKEFD
UkUpIGZpZWxkIHRvIDFoIGluIHRoZSBIb3N0IEJlaGF2aW9yIFN1cHBvcnQgZmVhdHVyZShyZWZl
ciB0bwpzZWN0aW9uIDUuMjEuMS4yMikuCgpBY2NvcmRpbmcgdGhlIHByb3RvY29sIGRlZmluZSwg
TlZNRV9TQ19DTURfSU5URVJSVVBURUQgbmVlZCByZXRyeS4KVGhlIGVycm9yIGNvZGUgTlZNRV9T
Q19DTURfSU5URVJSVVBURUQgc2hvdWxkIG5vdCB0cmFuc2xhdGUgdG8KQkxLX1NUU19UQVJHRVQs
IGJlY2F1c2UgaWYgdGhlIGVycm9yIGNvZGUgdHJhbnNsYXRlIHRvIEJMS19TVFNfVEFSR0VULApk
bS1tdWx0aXBhaCB3aWxsIHJldHVybiBlcnJvciB0byBhcHBsaWNhdGlvbi4gTlZNRV9TQ19DTURf
SU5URVJSVVBURUQKc2hvdWxkIHRyYW5zbGF0ZSB0byBCTEtfU1RTX0lPRVJSIGJ5IGRlZmF1bHQs
IGRtLW11bHRpcGF0aCB3aWxsIGZhaWwKb3ZlciB0byBvdGhlciBwYXRoIHJldHJ5IHRoZSBpby4K
CldlIG5lZWQgYSBtZWNoYW5pc20gZm9yIHJldHJ5IGluIHRoZSBjdXJyZW50IHBhdGggZmlyc3Qg
aW4gc29tZQpzY2VuYXJpb3Mgc3VjaCBhcyB0aGUgdGFyZ2V0IGlzIGRlYWxpbmcgd2l0aCBhbiBp
bXBvcnRhbnQgZW1lcmdlbmN5IGFuZApuZWVkIGhvc3QgcmV0cnkgdGhlIGlvIGFmdGVyIGEgZGVm
aW5lZCB0aW1lLCBiZWNhdXNlIGRtLW11bHRpcGF0aCBjYW4Kbm90IGdldCBDb21tYW5kIFJldHJ5
IERlbGF5IChDUkQpIHRvIGNvbnRyb2wgcmV0cnkgZGVsYXkgdGltZS4KYWNjb3JkaW5nIHRoZSBw
cm90b2NvbCBkZWZpbmUsIHRoZSBlcnJvciBjb2RlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVECmlz
IGEgZ29vZCBjaG9pY2UuCgpTaWduZWQtb2ZmLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdl
aS5jb20+Ci0tLQogZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMyArLS0KIGRyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaCB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggNjZlNmY3Y2E4OTQ3Li5iMzMwN2UzMTdl
Y2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKQEAgLTIxMSw3ICsyMTEsNiBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52
bWVfZXJyb3Jfc3RhdHVzKHUxNiBzdGF0dXMpCiAJY2FzZSBOVk1FX1NDX0NBUF9FWENFRURFRDoK
IAkJcmV0dXJuIEJMS19TVFNfTk9TUEM7CiAJY2FzZSBOVk1FX1NDX0xCQV9SQU5HRToKLQljYXNl
IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEOgogCWNhc2UgTlZNRV9TQ19OU19OT1RfUkVBRFk6CiAJ
CXJldHVybiBCTEtfU1RTX1RBUkdFVDsKIAljYXNlIE5WTUVfU0NfQkFEX0FUVFJJQlVURVM6CkBA
IC0yNDMsNyArMjQyLDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX2Vycm9yX3N0YXR1cyh1
MTYgc3RhdHVzKQogCiBzdGF0aWMgaW5saW5lIGJvb2wgbnZtZV9yZXFfbmVlZHNfcmV0cnkoc3Ry
dWN0IHJlcXVlc3QgKnJlcSkKIHsKLQlpZiAoYmxrX25vcmV0cnlfcmVxdWVzdChyZXEpKQorCWlm
ICghbnZtZV9yZXFfbG9jYWxfcmV0cnkocmVxKSAmJiBibGtfbm9yZXRyeV9yZXF1ZXN0KHJlcSkp
CiAJCXJldHVybiBmYWxzZTsKIAlpZiAobnZtZV9yZXEocmVxKS0+c3RhdHVzICYgTlZNRV9TQ19E
TlIpCiAJCXJldHVybiBmYWxzZTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUu
aCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAppbmRleCAxZGUzZjliODI3YWEuLjMyMTNhYWU4
OTg1YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCisrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaApAQCAtNzI1LDQgKzcyNSwxMCBAQCB2b2lkIG52bWVfaHdtb25faW5p
dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2h3bW9u
X2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkgeyB9CiAjZW5kaWYKIAorc3RhdGljIGlubGlu
ZSBib29sIG52bWVfcmVxX2xvY2FsX3JldHJ5KHN0cnVjdCByZXF1ZXN0ICpyZXEpCit7CisJaWYg
KG52bWVfcmVxKHJlcSktPnN0YXR1cyA9PSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCkKKwkJcmV0
dXJuIHRydWU7CisJcmV0dXJuIGZhbHNlOworfQogI2VuZGlmIC8qIF9OVk1FX0ggKi8KLS0gCjIu
MTYuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
