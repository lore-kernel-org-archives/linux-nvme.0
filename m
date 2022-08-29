Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D645ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ZQbSIsprE03487lAD31MmeAFY1RsNZL8nmax2eWXLA=; b=XvqMz6F0EED20fRNApF1pmtANh
	v5NdkFvwhuUEUmiIfwQmAwnredp0olRFS1lZeBop+CL+ZEjMmRgNVvRoHyp740QBzV1NeGfv+pYne
	7990ZzLkGEoM5EJhvXJt1zLZAGoC2tttQ1iESWbJRy28AhYFe2VTYjXdkUpNTrVYIRdVP8AzixJuI
	ANqteQz90rbeGskBU/MjemciJa6LoK/35YU2y9GSL7dx5LplbUIr0xsd+55D7vrCWgaf/D/PHYfJv
	mu0Oi7eoiGijxm+pe67IdXoMVTYd3O+Fng1sEXOc6a6AOTLTtiiCyBxk145aEYlJx4msGqW7ul5zo
	Bbxz7NKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaJH-006IYM-5D; Mon, 29 Aug 2022 08:39:55 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaFm-006G9N-Oj
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 08:36:21 +0000
Received: by mail-wr1-f41.google.com with SMTP id e13so8307007wrm.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 01:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0ZQbSIsprE03487lAD31MmeAFY1RsNZL8nmax2eWXLA=;
        b=FGRA0tLzbMfd8I6rVy9MIYALxWjsQB4EpIq5Jeuc+W36mQ5sgqfaLeLB8B5XlO5Gfm
         EbUC8R83zBZ0ZHmxllJoJwu53Jd86sVaeX0uMHebDTjQvF8O8pHeDHORiVtlN0Aiqqo1
         l/2aKeo+lS3fi3pSFFd33HhFfvxfUGbgSFjIJriml6//Qqd4Jg8SQ6k4XoFiaSTyiFzH
         zWe1xdr9jltLKWjFsWI8yB4eKDvJkZ62KwGvvSA5+bEjW8IxbQP3GoqBVZqDMnJApUsR
         /gg+4CjZvwQr2HjaBhotWMIoiLiFVWVUsRV7ODUrbtiE4vGzIClB/XZghfwjn4P2ySaL
         Y4kg==
X-Gm-Message-State: ACgBeo11g9PaSZhysaZsiMgKxEWmo6P5LwnkDFoWhGKtfKBvUi4W0FgE
	DyUYMcYyIIzU4+CkW6YB4s9XMB0xWug=
X-Google-Smtp-Source: AA6agR5/20gTWtc8lQJooG49YIjcQRyLGZnAyvagYX+Lc5zfuiiCSx/QZyE2RqJNyhyiFVCvuyqRIw==
X-Received: by 2002:a5d:47c9:0:b0:225:5a4f:8f82 with SMTP id o9-20020a5d47c9000000b002255a4f8f82mr5977615wrc.0.1661762176435;
        Mon, 29 Aug 2022 01:36:16 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0021e13efa17esm6553341wro.70.2022.08.29.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 01:36:15 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH blktests] nvme: add dh module requirement for tests that involve dh groups
Date: Mon, 29 Aug 2022 11:36:14 +0300
Message-Id: <20220829083614.874878-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_013618_849010_1821D6F3 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/043 | 1 +
 tests/nvme/044 | 1 +
 tests/nvme/045 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index 381ae755f140..87273e5b414d 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 046553198ce3..13019659b951 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index b60f18fc9f87..264f21053921 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
-- 
2.34.1


