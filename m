Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EDC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 05:58:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6915B20792
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 05:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wafs5eIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6915B20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MF1Es0YCSmwhYlrO/Ac8qzoWvZgU9t3M6rPUQNuPzkk=; b=Wafs5eItLPpNVm8/8oEWejAUu4
	L2mU+2BLPF1+10GoWrmd/EG0Zgq5HCa1qScYx5hsx5Z2uPEyds0afsC6IYff+lU9g6/evK1OdbiE2
	EdQi2yL3gW6h9mSh+RdPIFySiegrkQENnGeciOBCzo7uzsiszrIEDRgNBZwatPim432hyp3kSDITK
	S4oQuk8zVwnTqWEMIliMff9B5RfHG0ZWlKRAG7SS3aQaCRw5xKnzwDuC86VcXuLTz3W7X2w6ei5wJ
	LLT+kDfkGMOlBbyWFu0F+nFmSe0r5J0bT/YuvHM2WyPbPIdQodhWwH4aRdyMTA3VauGYPUNY+4PGX
	L1RffT8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzw9f-0006dy-En; Mon, 27 Jul 2020 05:58:31 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzw9c-0006dL-7w
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 05:58:29 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 55A029A484572AFCDA86;
 Mon, 27 Jul 2020 13:58:26 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 13:58:19 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Date: Mon, 27 Jul 2020 13:58:18 +0800
Message-ID: <20200727055818.21430-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_015828_538819_5B4BDCBB 
X-CRM114-Status: UNSURE (   8.01  )
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
bS1tdWx0aXBhaCB3aWxsIHJldHVybiBlcnJvciB0byBhcHBsaWNhdGlvbi4gU28gaWYgdGFyZ2V0
IHJldHVybiBlcnJvcgpjb2RlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVELCBpbyB3aWxsIGludGVy
cnVwdC4gTlZNRV9TQ19DTURfSU5URVJSVVBURUQKc2hvdWxkIHRyYW5zbGF0ZSB0byBCTEtfU1RT
X0lPRVJSIGJ5IGRlZmF1bHQsIGRtLW11bHRpcGF0aCB3aWxsIGZhaWwKb3ZlciB0byBvdGhlciBw
YXRoIHJldHJ5IHRoZSBpby4KClNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVh
d2VpLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxIC0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IGMyYzViYzRmYjcwMi4uMWExYWQ1ZTUy
MTJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCkBAIC0yMTEsNyArMjExLDYgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBu
dm1lX2Vycm9yX3N0YXR1cyh1MTYgc3RhdHVzKQogCWNhc2UgTlZNRV9TQ19DQVBfRVhDRUVERUQ6
CiAJCXJldHVybiBCTEtfU1RTX05PU1BDOwogCWNhc2UgTlZNRV9TQ19MQkFfUkFOR0U6Ci0JY2Fz
ZSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRDoKIAljYXNlIE5WTUVfU0NfTlNfTk9UX1JFQURZOgog
CQlyZXR1cm4gQkxLX1NUU19UQVJHRVQ7CiAJY2FzZSBOVk1FX1NDX0JBRF9BVFRSSUJVVEVTOgot
LSAKMi4xNi40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
