Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A2606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2LwRudDY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xp4Amijb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=WLiyauFtJhuMbP58y+JmNLKI5+Crt03dR88sII+z+Zc=; b=2LwRudDYSx+sc9boc91m1903If
	9nyTKsk321kaIDKxtVtxdGKBX7F+H7WrBnNp/Y+rjwy2QQUGVREvBSWRgCZeqz2PuzPWtx03Cte/V
	OoJDuRRYhBhH2OnX3IPKifPnWnURc5zHDVroEDVjiEs74iBBbV3HMBdj5yGBSl02hfy3DkbnfREPg
	I4s3pEPsslu9kUf0bpo0TExn8PA2cCG77IIt422deZ2ZbdP3QrPfhao9miF0hDvna6eFR2Oe0oKFo
	NBMnENqas8+JA+iwWzCnXZaWsdsMx4eLLmpLDAfDVVAMszxXQqq9gbG1g9Dw0R+brt99hmtJdrHUW
	g2g/Zm8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4Z1-0000000D4lo-2UeX;
	Sat, 31 Oct 2026 08:35:47 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4Yy-0000000D4l6-1K3H
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:35:45 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-14394530ec6so1924493c88.1
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793435743; x=1794040543; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLiyauFtJhuMbP58y+JmNLKI5+Crt03dR88sII+z+Zc=;
        b=Xp4AmijbjimH+rb7Fd6tfPOUtW+M+qfFQQRDJN5GsZp67uxf7qMwo/EfpQBNgnF8P2
         dKX+7DgaJkOoFidZs3ME3G5Tjco57awr1PwNTkBqQPo+Fl3boZCh1LMvJc51Si7BYoBN
         Wm98URchri3XlGtUOVKXlNdJ+vDXlLFfg7XHFfRdNCR6DTtNul+yvoo29f7f26t/6bjM
         /jbpr7s5lZxOnpQnvdox44yzr9xa7SZWk2Qy61Hti7sZlDgKSNKfFI7J3yCdtsrkKhat
         BVSKtCnFCZw64uw9h+4gZE3fc30nHn2evxtKy/4kcIK5KjozAqe9vNgk+fLT9OV67ksR
         reLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793435743; x=1794040543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLiyauFtJhuMbP58y+JmNLKI5+Crt03dR88sII+z+Zc=;
        b=xQq0cTmPg6av9Lo2RebGwrTh9gdJYwrlygxNH2W+zrABl3ss/IglcYoG3yzgSre1/j
         J+eQvTG98gmL3M9XGaA/NI2ScKtqrOTDNIqcaDVpwMjnUQaM5q9nwsqjRjvPF8Q+yBla
         7Ze6aW3hYgjDHZ6cNa9dmXPSoIZgMTWWaJU2xJpUAuINbGr6iNPKnM32sDV63dJU/UeE
         UZizQ1qWVZp1c2FBuYFcb2Ab03smsyX1T6Glj1pB2WdAPP1yCMWcGGoF0U9BWE+ciLZW
         hwRKqviWKn2zGx9HbCWCkDHzKDkLjM+58KLz5PAmbWJGxLCtwIk0Bq3scbHLEDzRCszK
         GIAg==
X-Gm-Message-State: AFq9FYLKAj1EbyhBzE7m5o+h79Rk9Fij5mHN4nM5c9/zwdLRbIo2TuLL
	JHY4Q07SazJ2jsE+rTT+0KF52cp5ti83c9E4mgfiffRC3t8L04AbqrDQ
X-Gm-Gg: AYBFou0puNGc4P9DqHLReE3nDqqwUbqRCAlRz7NsqQhZfXKonPGpghAq1JbBsi3Mn27
	7MhaVCLjrnn6ToGnwFPgxiLeqoVS4ovhZjEOKVdNzj8yJGa55cC4+/QwngKVbYJXi2ecyGvfe/K
	J9Ci7rsy95pGhwf7eKmxqrQPNa1UKqJxB2TnoDrETvPLogtxu7bGAuCO1p4S909m+tKmEXAI5bm
	NFkeKyUbPRkPG8N1PuGcI18HPhSkUj2Ehd9HJXnI/DpemJp+urojMM6Nwsd7/dXbHRGMPo3fsNM
	mJg3uvemYZna/854A8wjCN63KH2+dQMgaBahvrsp2VpRRS24efzBmarRiJMZI/ovPT8saN+xRIv
	n8li7a3vHWkzpm9xmqNMuijNBmtDzlugUpO7E3DM4CsrM0xIKqtMkr/8f7o1uEaHRmXFZMmc2kX
	OKWj9ry36vwe4L31VB6QAJ3fLnaG6wV4Q3wxqTXHNsVqZmSEFG/j820/otlRf3SQcSsB8yVEeWd
	YsdxymsqIwLXdkW7Ddmr1FpguNNalgHrDzoOqMYgu+J62D/sYxn1udFjJdJhpLu/faTtfXf3+aL
	8A4DGaawcC8jrIDIeXgn+3n59E3f0T85ZsZWBBzVfh5VAGBhKA==
X-Received: by 2002:a05:7022:7f17:b0:168:3243:c937 with SMTP id a92af1059eb24-1ac5cb1c8b3mr7522678c88.16.1793435743153;
        Sat, 31 Oct 2026 01:35:43 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm18910706c88.6.2026.10.31.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:35:42 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] nvmet: preserve ANA log page copy errors
Date: Sat, 31 Oct 2026 08:35:05 +0000
Message-ID: <20261031083505.4767-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_013544_379074_C2E60527 
X-CRM114-Status: GOOD (  12.75  )
X-Spam-Score: -1.9 (-)
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

Do not overwrite an error returned while copying ANA
group descriptors with the result of copying the ANA
log page header.

Initialize the status to success before processing
ANA groups and copy the header only if all group
descriptor copies succeed. This ensures that failures
during descriptor copying are correctly reported to
the host.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..2bcb6d3de9ec 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -543,7 +543,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	u16 ngrps = 0;
 	u16 status;
 
-	status = NVME_SC_INTERNAL;
+	status = NVME_SC_SUCCESS;
 	desc = kmalloc_flex(*desc, nsids, NVMET_MAX_NAMESPACES);
 	if (!desc)
 		goto out;
@@ -572,7 +572,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	kfree(desc);
 
 	/* copy the header last once we know the number of groups */
-	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.55.0


