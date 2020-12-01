Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5AC71156
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0C207FF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NlgdW3PB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iObn40qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0C207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xDPeT79sVIkjxB6HzUEuvwMNFfUV6hbAZh8o7VWf1Qg=; b=NlgdW3PBNYif+5mrmao8GCQHW
	lDpx1utiC0IepQxYbhcc1HzU5/RPwIx5O20otga5qurylmGLmdDs+dQST4H8aYjUfDn0RK7XbgiwB
	9oJf8EOT9j2CYThxM2bXbR66mNg3m+iSShq+ugXmreFhqqIe0/Ez1gm62tHsh8k3Y1v252u3j+6Nh
	+ooxMsLXNFtyJYtK1uYgjyCXIDqBXLRsNsdWyQbTfIo54wSX/ZxT+6/LRYxSKbUzaAPJ55v3lWTyH
	HucMk1nUbCYkZF4r2ClTIV+LZnvtZKzyafxo0fjSTWssXHJUqE+i7KdVT2F9dd/rYphZ56dJryWZB
	mAxFbA64A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk5Cd-0005RU-Bz; Tue, 01 Dec 2020 12:56:19 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk5Ca-0005QG-SB
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:56:17 +0000
Received: by mail-ed1-x543.google.com with SMTP id j14so93218edy.3
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jlx5ljuoha5y8gLnWfck0WODBeR/256Mld210jR/EFk=;
 b=iObn40qEZn/sKbA/Df7xy7osUqamwET0bD7BELJ4D/9DcGiJAzNR77nwvw3DLx/xHF
 Zi8peOOCGzmtzsi1IxevIGJopixNEBqIV1Mb/BrccYSSxeG4T6zcOPZvVo0f+w+FU/oN
 EMMOitKOCQ8O9dpg74HUJ1iwby6Wo4zi2hp1reqRymWTJdIVJgrw1aK/b6iIhx5A9NKn
 8cQuGckD0Coo+WSs2q1I0VUXCcC1OyQQArCJAjSuy/TGNAnoRwjiNbR/ftOko3GYSGWu
 7ZbvJ9G9Yn2UUhPCbqzs/RSnIrJ4Y5za0mCQJ6FwEZTZRnyhZD23vFua18QAOo2D0KcL
 J+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jlx5ljuoha5y8gLnWfck0WODBeR/256Mld210jR/EFk=;
 b=hcWB6KtY7Phyw87lVBYLpPFKpEN/3Z+NdCgB1HKK6i3tBr+ZjDySEm0SGzCzHNwNr7
 FvdGM0Dc0kY6bYmMw+/09GivWQq6JtXXGmQrkFPiuhX709Mjgscsr9ejqjoCvFpoAWlE
 MLM2LcQMlyPqeuYvWl03DCO2CkNEzESkSjO2Q4S7WIhQ3DMW/UZu5m/yAtH8f2Wi3HbX
 76ur8eIEQmRy+Sg4fVaxJ36fL6aV4S3mQK8LMxbw5AzxfX2+Gw9zpuolnreuYu1Ijmyl
 clo1Oio3FRldxGKk0eVt8Vx0wZEQqg+RS1sefo94e603HLAfQ/B6/k9BpAAeZgLel536
 RITw==
X-Gm-Message-State: AOAM533viFUWqARmflqgz2e/MMX4M9I4b2luSAhCCKRhnv4pk+ecg99X
 g+NQoqC00EwlEnyM4b5tf3v+pvv0QyfCsxSxCPU=
X-Google-Smtp-Source: ABdhPJzMggpJFAnW8X/NAlgFZv92Xj0V7ijaNdIE7uJuNFXybN+5B+NYTEVUqe5xyZDelYWo627zEg==
X-Received: by 2002:a50:e8c4:: with SMTP id l4mr2936307edn.105.1606827375048; 
 Tue, 01 Dec 2020 04:56:15 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:56:14 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme: remove unnecessary return values
Date: Tue,  1 Dec 2020 13:56:07 +0100
Message-Id: <20201201125610.17138-2-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_075616_946938_EA2C593B 
X-CRM114-Status: GOOD (  13.74  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpDbGVhbnVw
IHVubmVjZXNzYXJ5IHJldCB2YWx1ZXMgdGhhdCBhcmUgbm90IGNoZWNrZWQgb3IgdXNlZCBpbgpu
dm1lX2FsbG9jX25zKCkuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIu
Z29uekBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA4ICsrKy0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYwppbmRleCAxNzA3NDVkNGEzNGIuLmE5NjVhOGQyOGJhMCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMzgz
MSw3ICszODMxLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsLCB1bnNpZ25lZCBuc2lkLAogCXN0cnVjdCBnZW5kaXNrICpkaXNrOwogCXN0cnVjdCBu
dm1lX2lkX25zICppZDsKIAljaGFyIGRpc2tfbmFtZVtESVNLX05BTUVfTEVOXTsKLQlpbnQgbm9k
ZSA9IGN0cmwtPm51bWFfbm9kZSwgZmxhZ3MgPSBHRU5IRF9GTF9FWFRfREVWVCwgcmV0OworCWlu
dCBub2RlID0gY3RybC0+bnVtYV9ub2RlLCBmbGFncyA9IEdFTkhEX0ZMX0VYVF9ERVZUOwogCiAJ
aWYgKG52bWVfaWRlbnRpZnlfbnMoY3RybCwgbnNpZCwgaWRzLCAmaWQpKQogCQlyZXR1cm47CkBA
IC0zODU1LDggKzM4NTUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2FsbG9jX25zKHN0cnVjdCBudm1l
X2N0cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQsCiAJbnMtPmN0cmwgPSBjdHJsOwogCWtyZWZfaW5p
dCgmbnMtPmtyZWYpOwogCi0JcmV0ID0gbnZtZV9pbml0X25zX2hlYWQobnMsIG5zaWQsIGlkcywg
aWQtPm5taWMgJiBOVk1FX05TX05NSUNfU0hBUkVEKTsKLQlpZiAocmV0KQorCWlmIChudm1lX2lu
aXRfbnNfaGVhZChucywgbnNpZCwgaWRzLCBpZC0+bm1pYyAmIE5WTUVfTlNfTk1JQ19TSEFSRUQp
KQogCQlnb3RvIG91dF9mcmVlX3F1ZXVlOwogCW52bWVfc2V0X2Rpc2tfbmFtZShkaXNrX25hbWUs
IG5zLCBjdHJsLCAmZmxhZ3MpOwogCkBAIC0zODc1LDggKzM4NzQsNyBAQCBzdGF0aWMgdm9pZCBu
dm1lX2FsbG9jX25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQsCiAJCWdv
dG8gb3V0X3B1dF9kaXNrOwogCiAJaWYgKChjdHJsLT5xdWlya3MgJiBOVk1FX1FVSVJLX0xJR0hU
TlZNKSAmJiBpZC0+dnNbMF0gPT0gMHgxKSB7Ci0JCXJldCA9IG52bWVfbnZtX3JlZ2lzdGVyKG5z
LCBkaXNrX25hbWUsIG5vZGUpOwotCQlpZiAocmV0KSB7CisJCWlmIChudm1lX252bV9yZWdpc3Rl
cihucywgZGlza19uYW1lLCBub2RlKSkgewogCQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAiTGln
aHROVk0gaW5pdCBmYWlsdXJlXG4iKTsKIAkJCWdvdG8gb3V0X3B1dF9kaXNrOwogCQl9Ci0tIAoy
LjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
