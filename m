Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AEEC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 20:19:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B47A61151
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 20:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B47A61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flawful.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RhZZ/hg413Bun6Bs/09iIrctX3FXa4KTiKWyO0NFaPI=; b=kmRAUIL91N9gQ/ps7zWNhmiNrO
	xdRXI7uSULj4FOZLCnLfN4ym5Tafbzv9bzrwjtQgECrnAm2DaRGDka5eDEpYPboPqqbhevXHWRwBw
	ezJs7DBG4IvPFlUrpvmDYka/Kl3wzxbgBKuvt75uZgfZrePdz58GVp3MbqYnIJK0u+yPcjhxH16Si
	4HYKC6vaB+HSDoOb/ZuKLczEt9vus7e/GVLRDSYhp7ZWR6jn6CyCmsPb/tw1tfIi+9cdmPt2T7j8D
	DrnfHjzVMc8ejweu8/rJmO21p2pn01H7OynqK8vTLquaHf/deHGyoivI2fGtTfltJoOZwYYdKmXMg
	e6IRcoVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSQFp-00DnIG-BN; Fri, 02 Apr 2021 20:18:53 +0000
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSQFk-00DnGz-Mm
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 20:18:51 +0000
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 453F93FC44;
 Fri,  2 Apr 2021 22:18:42 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=flawful.org header.i=@flawful.org header.b="FX11u6qA"; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_yO88S5N50N; Fri,  2 Apr 2021 22:18:41 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9BC823F735;
 Fri,  2 Apr 2021 22:18:38 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 1001)
 id 7076414BC; Fri,  2 Apr 2021 22:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
 t=1617394717; bh=vpKvFQbGdigWLDUL0qg1CLF78XoNpFYhqw/S6OoC9+g=;
 h=From:To:Cc:Subject:Date:From;
 b=FX11u6qAi3wJU0uoJklPU5sH89JHNd8rZI+gOpAAMXLXJwwr7SfWehZ2UYuu6wgGp
 oFdqxdQQZ3Qcn6xEE5uZzl9NjPRsTfe4kHsd8eUCYKr7jXYRiGACQwmLj+m1ZUlr78
 5UBQunp/raXNNZGGtzC27VgDmzjd7g3VqlzvC0Bw=
From: Niklas Cassel <nks@flawful.org>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: niklas.cassel@wdc.com, joshi.k@samsung.com, javier@javigon.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme: disallow passthru cmd from targeting a nsid != nsid
 of the block dev
Date: Fri,  2 Apr 2021 22:18:08 +0200
Message-Id: <20210402201808.31979-1-nks@flawful.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_211849_063642_C11339C3 
X-CRM114-Status: GOOD (  13.42  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPgoKV2hlbiBhIHBhc3N0
aHJ1IGNvbW1hbmQgdGFyZ2V0cyBhIHNwZWNpZmljIG5hbWVzcGFjZSwgdGhlIG5zIHBhcmFtZXRl
ciB0bwpudm1lX3VzZXJfY21kKCkvbnZtZV91c2VyX2NtZDY0KCkgaXMgc2V0LiBIb3dldmVyLCB0
aGVyZSBpcyBjdXJyZW50bHkgbm8KdmFsaWRhdGlvbiB0aGF0IHRoZSBuc2lkIHNwZWNpZmllZCBp
biB0aGUgcGFzc3RocnUgY29tbWFuZCB0YXJnZXRzIHRoZQpuYW1lc3BhY2UvbnNpZCByZXByZXNl
bnRlZCBieSB0aGUgYmxvY2sgZGV2aWNlIHRoYXQgdGhlIGlvY3RsIHdhcwpwZXJmb3JtZWQgb24u
CgpBZGQgYSBjaGVjayB0aGF0IHZhbGlkYXRlcyB0aGF0IHRoZSBuc2lkIGluIHRoZSBwYXNzdGhy
dSBjb21tYW5kIG1hdGNoZXMKdGhhdCBvZiB0aGUgc3VwcGxpZWQgbmFtZXNwYWNlLgoKU2lnbmVk
LW9mZi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPgpSZXZpZXdlZC1i
eTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KUmV2aWV3ZWQtYnk6IEthbmNoYW4g
Sm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5jb20+ClJldmlld2VkLWJ5OiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXJAamF2aWdvbi5jb20+Ci0tLQpDaGFuZ2VzIHNpbmNlIHYyOgotUGlja2VkIHVwIFJl
dmlld2VkLWJ5LXRhZ3MuCi1TZW5kIGZyb20gYSBtYWlsIHNlcnZlciB0aGF0IGRvZXNuJ3QgbWFu
Z2xlIHRoZSBtYWlsLgoKIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDEyICsrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZjEzZWI0
ZGVkOTVmLi5hNTAzNTJlYTNmN2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTE1OTksNiArMTU5OSwxMiBAQCBz
dGF0aWMgaW50IG52bWVfdXNlcl9jbWQoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52
bWVfbnMgKm5zLAogCQlyZXR1cm4gLUVGQVVMVDsKIAlpZiAoY21kLmZsYWdzKQogCQlyZXR1cm4g
LUVJTlZBTDsKKwlpZiAobnMgJiYgY21kLm5zaWQgIT0gbnMtPmhlYWQtPm5zX2lkKSB7CisJCWRl
dl9lcnIoY3RybC0+ZGV2aWNlLAorCQkJIiVzOiBuc2lkICgldSkgaW4gY21kIGRvZXMgbm90IG1h
dGNoIG5zaWQgKCV1KSBvZiBuYW1lc3BhY2VcbiIsCisJCQljdXJyZW50LT5jb21tLCBjbWQubnNp
ZCwgbnMtPmhlYWQtPm5zX2lkKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQogCiAJbWVtc2V0KCZj
LCAwLCBzaXplb2YoYykpOwogCWMuY29tbW9uLm9wY29kZSA9IGNtZC5vcGNvZGU7CkBAIC0xNjQz
LDYgKzE2NDksMTIgQEAgc3RhdGljIGludCBudm1lX3VzZXJfY21kNjQoc3RydWN0IG52bWVfY3Ry
bCAqY3RybCwgc3RydWN0IG52bWVfbnMgKm5zLAogCQlyZXR1cm4gLUVGQVVMVDsKIAlpZiAoY21k
LmZsYWdzKQogCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAobnMgJiYgY21kLm5zaWQgIT0gbnMtPmhl
YWQtPm5zX2lkKSB7CisJCWRldl9lcnIoY3RybC0+ZGV2aWNlLAorCQkJIiVzOiBuc2lkICgldSkg
aW4gY21kIGRvZXMgbm90IG1hdGNoIG5zaWQgKCV1KSBvZiBuYW1lc3BhY2VcbiIsCisJCQljdXJy
ZW50LT5jb21tLCBjbWQubnNpZCwgbnMtPmhlYWQtPm5zX2lkKTsKKwkJcmV0dXJuIC1FSU5WQUw7
CisJfQogCiAJbWVtc2V0KCZjLCAwLCBzaXplb2YoYykpOwogCWMuY29tbW9uLm9wY29kZSA9IGNt
ZC5vcGNvZGU7Ci0tIAoyLjMwLjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
