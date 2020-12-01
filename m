Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37BC64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EAF2085B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WRzdKOMK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Jj8HXdR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EAF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/7OhNtUbjaVqpGO5dhxQW8NUdTgdnANyx7qacWWUyRE=; b=WRzdKOMK09QaDcc5yfR1VStv6
	DqPv14GogHowMftvE6/zud7lvqUwBtSxXg/eiSQhCErnRyIq11qF/vZOfjfe7CvauIzJQpzqBsqbH
	TDCR5AD79srngkopPkXdVLk2C83f1HThAyta5YMNjISaL8xndMmcw9fwYBQFacBDDtt0HGa3TGR8p
	/mxuN8a5Yj+p5SGtpwSusumU0Rp3KjEOcnRUp+YNrumOa3zXp6RMC2HEdu3GUNiuEVrMDYDB7AVPK
	xHHLGM/ERDRliyppULsccxQlyG349DDo5A0PTQJ6m3c9Z/TAJndCddTqOQhVCIJdKt307PhMj/XDQ
	AF7GQrq/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk5Cf-0005S6-BH; Tue, 01 Dec 2020 12:56:21 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk5Cc-0005QZ-8E
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:56:19 +0000
Received: by mail-ed1-x544.google.com with SMTP id y22so3102982edv.1
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jVlFL/BwK+4pEy5h5pG2lUmBjku30Q9HUhNaXsgLU5k=;
 b=Jj8HXdR5H/mhKYMc/5WyObSK3cPEr9hW9cIupB+JtNxLHEet5G0+IdZep+hhxm09nc
 k6j2qgP1O44P4um+ewz40Vj/OmlceAO7hIYj9Yiwpo7TP6oRIutbVzbBnZuRmL20Frry
 SKaEGFn0dCihFyADELwQlagM1Is+j7Vo7gZfvYHEgJoFjP4HpKyfR7Vg4JbEGnLEmRgr
 PGjd3n6Oe/mp0IKM2Z9ul9Q/lEzZp/KiGcTBZS0nJzNUskrVWNCOOOIG1Y/feP6AJWKW
 XV4TG2/sgZUnsoorFTI4etgmrV6V9LDCIIZxfoUh1o5tQ2UBsE2cIW4X1ZSjUrOCIpKl
 DdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jVlFL/BwK+4pEy5h5pG2lUmBjku30Q9HUhNaXsgLU5k=;
 b=oPFV7YQ+xUkweBnaV3/XTDN/6Mry4VfGiDEHz8AgqkkpdrTY9xl1myqvGgLMqdLoGK
 LU14KtmsekTLX4+Kc/lv6OrxstEsQJ7ahR5Q3DT9yoh7RANBn/nQI3J+VN0siqKjQ+U7
 WqmehZTdOVLq+0G3e3VoaprHY/DYV1Yi+hYqjj+bb+xYmBN0icPQSBodz0y1QaLT1dE2
 x/v+RaaGDf1zcrzLrTHStpLllaWEE0+wgqhmZ8HHh+2UiR+bs/zhRw0MqLVNo5CjX+DR
 4S13rflQN4+5N+pcRdebivSsi2DAk9TCnQencPvN3qNG4BRfTBrkAEcWnADz6UvROxh2
 Mo5A==
X-Gm-Message-State: AOAM533wbNswLW0IK4Il5CJuBKFCa67hCTJk0CI9rmVIx5stdZB/JujD
 CJcoQ8eeQ4aQ71pa8YsQl6Qhp5UUNfg+9w0b4RY=
X-Google-Smtp-Source: ABdhPJwzwZgyhL2sV7A/5LmOrY88AXJK0UEXkWkHePO4ZiBsOgzSJVtAk1E8CEaDaw2TM1VxZA2I6g==
X-Received: by 2002:a05:6402:144f:: with SMTP id
 d15mr2917791edx.300.1606827376284; 
 Tue, 01 Dec 2020 04:56:16 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:56:15 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: rename controller base dev_t char device
Date: Tue,  1 Dec 2020 13:56:08 +0100
Message-Id: <20201201125610.17138-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_075618_337725_B6C163B0 
X-CRM114-Status: GOOD (  13.48  )
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

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpSZW5hbWUg
Y29udHJvbGxlciBiYXNlIGRldl90IGNoYXIgZGV2aWNlIGluIHByZXBhcmF0aW9uIGZvciBhZGRp
bmcgYQpuYW1lc3BhY2UgY2hhciBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOh
bGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCAxMiArKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IGE5NjVhOGQyOGJhMC4uYzIzYzg5MWE4ZmI4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCkBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyBMSVNUX0hFQUQobnZtZV9zdWJzeXN0
ZW1zKTsKIHN0YXRpYyBERUZJTkVfTVVURVgobnZtZV9zdWJzeXN0ZW1zX2xvY2spOwogCiBzdGF0
aWMgREVGSU5FX0lEQShudm1lX2luc3RhbmNlX2lkYSk7Ci1zdGF0aWMgZGV2X3QgbnZtZV9jaHJf
ZGV2dDsKK3N0YXRpYyBkZXZfdCBudm1lX2N0cmxfYmFzZV9jaHJfZGV2dDsKIHN0YXRpYyBzdHJ1
Y3QgY2xhc3MgKm52bWVfY2xhc3M7CiBzdGF0aWMgc3RydWN0IGNsYXNzICpudm1lX3N1YnN5c19j
bGFzczsKIApAQCAtNDQ3MCw3ICs0NDcwLDggQEAgaW50IG52bWVfaW5pdF9jdHJsKHN0cnVjdCBu
dm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBkZXZpY2UgKmRldiwKIAogCWRldmljZV9pbml0aWFsaXpl
KCZjdHJsLT5jdHJsX2RldmljZSk7CiAJY3RybC0+ZGV2aWNlID0gJmN0cmwtPmN0cmxfZGV2aWNl
OwotCWN0cmwtPmRldmljZS0+ZGV2dCA9IE1LREVWKE1BSk9SKG52bWVfY2hyX2RldnQpLCBjdHJs
LT5pbnN0YW5jZSk7CisJY3RybC0+ZGV2aWNlLT5kZXZ0ID0gTUtERVYoTUFKT1IobnZtZV9jdHJs
X2Jhc2VfY2hyX2RldnQpLAorCQkJY3RybC0+aW5zdGFuY2UpOwogCWN0cmwtPmRldmljZS0+Y2xh
c3MgPSBudm1lX2NsYXNzOwogCWN0cmwtPmRldmljZS0+cGFyZW50ID0gY3RybC0+ZGV2OwogCWN0
cmwtPmRldmljZS0+Z3JvdXBzID0gbnZtZV9kZXZfYXR0cl9ncm91cHM7CkBAIC00Njc5LDcgKzQ2
ODAsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBudm1lX2NvcmVfaW5pdCh2b2lkKQogCWlmICghbnZt
ZV9kZWxldGVfd3EpCiAJCWdvdG8gZGVzdHJveV9yZXNldF93cTsKIAotCXJlc3VsdCA9IGFsbG9j
X2NocmRldl9yZWdpb24oJm52bWVfY2hyX2RldnQsIDAsIE5WTUVfTUlOT1JTLCAibnZtZSIpOwor
CXJlc3VsdCA9IGFsbG9jX2NocmRldl9yZWdpb24oJm52bWVfY3RybF9iYXNlX2Nocl9kZXZ0LCAw
LAorCQkJTlZNRV9NSU5PUlMsICJudm1lIik7CiAJaWYgKHJlc3VsdCA8IDApCiAJCWdvdG8gZGVz
dHJveV9kZWxldGVfd3E7CiAKQEAgLTQ3MDAsNyArNDcwMiw3IEBAIHN0YXRpYyBpbnQgX19pbml0
IG52bWVfY29yZV9pbml0KHZvaWQpCiBkZXN0cm95X2NsYXNzOgogCWNsYXNzX2Rlc3Ryb3kobnZt
ZV9jbGFzcyk7CiB1bnJlZ2lzdGVyX2NocmRldjoKLQl1bnJlZ2lzdGVyX2NocmRldl9yZWdpb24o
bnZtZV9jaHJfZGV2dCwgTlZNRV9NSU5PUlMpOworCXVucmVnaXN0ZXJfY2hyZGV2X3JlZ2lvbihu
dm1lX2N0cmxfYmFzZV9jaHJfZGV2dCwgTlZNRV9NSU5PUlMpOwogZGVzdHJveV9kZWxldGVfd3E6
CiAJZGVzdHJveV93b3JrcXVldWUobnZtZV9kZWxldGVfd3EpOwogZGVzdHJveV9yZXNldF93cToK
QEAgLTQ3MTUsNyArNDcxNyw3IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBudm1lX2NvcmVfZXhpdCh2
b2lkKQogewogCWNsYXNzX2Rlc3Ryb3kobnZtZV9zdWJzeXNfY2xhc3MpOwogCWNsYXNzX2Rlc3Ry
b3kobnZtZV9jbGFzcyk7Ci0JdW5yZWdpc3Rlcl9jaHJkZXZfcmVnaW9uKG52bWVfY2hyX2RldnQs
IE5WTUVfTUlOT1JTKTsKKwl1bnJlZ2lzdGVyX2NocmRldl9yZWdpb24obnZtZV9jdHJsX2Jhc2Vf
Y2hyX2RldnQsIE5WTUVfTUlOT1JTKTsKIAlkZXN0cm95X3dvcmtxdWV1ZShudm1lX2RlbGV0ZV93
cSk7CiAJZGVzdHJveV93b3JrcXVldWUobnZtZV9yZXNldF93cSk7CiAJZGVzdHJveV93b3JrcXVl
dWUobnZtZV93cSk7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
