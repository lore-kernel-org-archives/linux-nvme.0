Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D98606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PTqVx8o9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwdVdDtC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=; b=PTqVx8o9NT2z55
	ZskIKTmdnfgDhrRF7ihGjQWyR1WaeHw/m2vhfQR82SQo0owbouXwhS7FwZ28xTEJB8aMU1M93PGtM
	VhFBI7aBGZnuU6rq+jJP3C8mGWZoBiaXhUwFJc6SD4vQtGNsKZBhp3+mDP4JaeNtsk//U2/UDxEmY
	HEeA+CnZayanfS9jrJEeL74jtGeV0LHw+7Jtw1LDatd/mG8Qv7jPQc97Vp1R9Ii/HF8tIdK9L1ZVD
	P5uuAPe8DmXGwMvyNNtMKx+qB4/JoMret2dFxAdNQacFCIBLgxHCWcz68goDdF5nSVs969k7QuRXH
	FFTi1bOPI9sIJrqiwYww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYN-0000000E8w0-20Jw;
	Thu, 22 Oct 2026 13:09:55 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYL-0000000E8td-0TfA
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:09:54 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so10919195e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674591; x=1793279391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=;
        b=BwdVdDtCQcbBfdSuFoi81I718DNln1a64WQOg2HsW0mwtRt+yYFHOozyUeG+Bi8xs7
         jnxVZq0ny2Ap/oVcYU+RyQLxUVJEY6Z6XRcLmSpiIAjQIoN6dqFNoj1lyB5PDktB9Gr9
         dT8Tee/u8Yd8uEnQpd/bQ6CslCyCnGwkPqHWwQhFtA47PPoJd9+K26noZodxu4xTrI8D
         dfkIWHEXSz6d3gdOmUrHJkXmx1ZsNvLxY55e8Uhfz454SfrxjFAtmySIL6h2TzguQa6E
         tDCZCMNgW+YvcNEQpUvOxfosrYWVK4AOKs83S9OOlL16pGhVVF8N807VTxF4hR/rU4up
         7lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674591; x=1793279391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=;
        b=YU5j622jBZ/gqJ4KYjhwvlI6wsCF96k6KFr8FOS809IBuq0yUwTGS9pl/pUycqLRcw
         +XrsIYgIRo8zNj0duKzpoIsyGTHEpec9E+Dte6y8ACvTLd8D9ZnxzrM9TYNnJokjDS3L
         4fyBXlzN48H+yLa2ZKmwyfDwA2GS459PNCNk3Mbgz1Eym+p3v86iFH7RlE/qi/tyx27b
         KDM81+WPYZcW6GBJsk6gMhlUxwneX/wz5l4Wco1tkjzhBeLZJwBkmjAw0jctTLeYQEqA
         mYnlu3rztMx1UgOowA79ZXogdNwH7PMnUoRA0Qh9MHVAyILwlXqMu8IOLVCSM5VZvjn2
         Itmg==
X-Forwarded-Encrypted: i=1; AKwUvBxS8/TPxsOWrfeAJcMZWc7Q9fXffvBZDZkY6jLsc497LcbnQmQQosxnIqYJYn5wjW0I7xPKBIcZjsX7@lists.infradead.org
X-Gm-Message-State: AFq9FYIGmNfhygl5qCFdDxr/lxfJGfDhvGJIYdjS6VEbXuA7IU82ZupV
	iskvckwJhCCOsSfisphG8qcXAhqgNzg8gQGmh+lcnCyOwm6XLg9/gL74
X-Gm-Gg: AYBFou3JUbFdK4jgYjmy6hZ65Tux8JQScUCFvDK8l8JGSRBtRtcSnDRFl50jQIoNXE0
	qXoVnpfaJZKVTF0Xo6ffKkdlwfqvDV/iNfLWjfI+knDdaC9WFcpZKxIgwfxuABi67JoRz+lmuoH
	JySOClBH4Akc2tUx9VOXmVCVM5dWgF35VV1o4/scUF+dsxXGaO7sD3SKJ8UydpO4269jStx0KDf
	mP7wb+P9+FkZkCXjZWmUXj0e3Yu4376SB/8ihSDPmgQXZjgNhDZalOKwfR5bhzNZK05q1n+uTCq
	IJW/nTWLEyT3U8kV/2riXjPXSO27wdJaI6VYdkqf6ktsp1i9fImIdmnUAgmmm0Np4LiEKVV6iiU
	GVJBRdif7VcVHnotqBtZK1X7xf9KxwxeCMtqVWHHFYt/5XZB3jb+5o6Wp1L/sD3ovMtpYvoN7pQ
	P+jM7dnJrkwJ4fKXOM3uc4YvkZEMZLCG0tcenzOUEIUW9scHo2K78JusA8tSqSoRSHvyAI4sak4
	iAievzxBBMBr0tRSfCLl+adpAItm8r5UVIlyKfARwreTn33W90uDc7vrio1pAOvZ45E5IGa5NSt
	A65p9102BsoSRFUGBTgndPdbSh73iIiwdivOYYoQ7Z0oLg==
X-Received: by 2002:a05:600c:4513:b0:4a2:1a:a11c with SMTP id 5b1f17b1804b1-4a2047df0damr47749905e9.0.1792674591239;
        Thu, 22 Oct 2026 06:09:51 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:50 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2 4/4] nvme/074: test that nvmet rejects a zone report NUMD that wraps
Date: Thu, 22 Oct 2026 15:09:24 +0200
Message-ID: <20261022130927.3583166-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_060953_171997_5D65667F 
X-CRM114-Status: GOOD (  15.23  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Verify that Zone Management Receive rejects a NUMD whose byte count
wraps a 32-bit calculation, while accepting an ordinary request. The
test runs on every configured transport.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/074     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/074.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/nvme/074
 create mode 100644 tests/nvme/074.out

diff --git a/tests/nvme/074 b/tests/nvme/074
new file mode 100755
index 0000000000000..3ecd3ffcb6894
--- /dev/null
+++ b/tests/nvme/074
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target rejects a zone report NUMD whose byte count
+# overflows a 32-bit value.
+#
+# Regression test for patch "nvmet: zns: reject a NUMD whose byte count wraps".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="reject an NVMe target zone report NUMD that wraps"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_null_blk
+	_have_kernel_options BLK_DEV_ZONED
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	_check_zone_report "$dev" 64 15 0
+	_check_zone_report "$dev" 64 0x4000000f 2
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/074.out b/tests/nvme/074.out
new file mode 100644
index 0000000000000..9c940dda4486a
--- /dev/null
+++ b/tests/nvme/074.out
@@ -0,0 +1,2 @@
+Running nvme/074
+Test complete
-- 
2.53.0


