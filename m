Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61809CF886F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DEgJYe/8xhIq8UmfVPruq8Mzfowx67XC9fBTq7EZmUU=; b=w4ShAVu1X7NwUiOa8UBym3SXJs
	81Ft2Waul+jGwf65MFCP/k7b0j2pBzGry9XbBktood5s6NuF48BtKPYJVVcLl5JgHG5p2ayw54scF
	OmtbIV+Wn2tsuiygKVs8duBlRm3tFZkMJLn2gWE0kXuOmqCpLxg2ixzhuckUwycYd8eaMH+DO9L5Q
	VJtHF0tnR6GUGbfgrYvOT78t5wO7j3zo/uKodfHozCfWnVvdfIzGn8Pb3A24XsVXtTpjSqPuJGUTo
	Xz8h3oU6X1oj57aaMisFWZ4iDm7V6Ah28XtHvUwSSHi07T68e329YXyWewprLQqOPOLkGEHdcBsXQ
	giiMDmhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2vs-0000000FGrL-2trn;
	Sat, 05 Oct 2024 11:26:44 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2vp-0000000FGqm-3DHh
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 11:26:43 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20b7259be6fso33714985ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Oct 2024 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728127600; x=1728732400; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEgJYe/8xhIq8UmfVPruq8Mzfowx67XC9fBTq7EZmUU=;
        b=GZR8Yf9xLm+ByCPtTvRN5DL6NO3UkZBP//1EQC0dYn7fdiQih62eViNyZVVXWv3ZpL
         lCRdZxuydWNCox+nKFiF5/WnuDpUtH/QVto7yDdDVwt2M6luScdbPosE2sGuSIHXw6vd
         7xeMg679xNbYqy0ZcyhbEaI7xXvke9bVl4kjixxBqVR0n4wIMNC0oPgRNCBiI1e9IF5y
         NFSNXS9GTi6m6WL/137G7SpEw2P/b+x4sZvZNU49gQSg+nIcW4I0JE49bo6GmVm88laf
         rOatHSRIlz2TEsqwfXTeSx7HThvnqDr35BZJ+FCIrrA7SJGaz58p04sEtoeSBU3mCLNl
         CEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127600; x=1728732400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEgJYe/8xhIq8UmfVPruq8Mzfowx67XC9fBTq7EZmUU=;
        b=jky7wxhNuBoxL7hXxdxDwm4iqrlf/m495G1uDaUXzfv5DRaP1OXj8lD3d2jETjIOwv
         KBqKZh+AKE/bb0r3Pc84EzGPqj9YVP+pHTiBmgyokctX02WeuHndYjiiIGpCe1B/sUgy
         Ka24LPcF7vhOatw8eKDLA0Inm5JQ3Zqc7ZgA+UEC3IBXqMV4ZVKqcXdl0/P6WyEguP+L
         PiFaOlp7LIsXTI+MGipb0Wc8/5YgoLw0S5M1zyVraSU8FAxspqsbh7NzK7l4RVdkWnUp
         YJ+uNESuYaC5wl8s+JP0DHd7PSBAuPHUZemizyQif07XXucPkCcMU1ReEjTjd5dQ3GBE
         a4qw==
X-Gm-Message-State: AOJu0YyZoKOuOOEyKlimyFHOgkIrNNmPsDTaH8UciPlzaHKNIPcv28N9
	NIRnCuMMfr/dZ2AxQUTzm+/ureWqiFJsJA2KI32hxXyd47bH5BWeNlwweA==
X-Google-Smtp-Source: AGHT+IFkgQBN8QwOQ1k/qbFvFh25lzl1FFjatPGWPEua+tFYV6iqmJKkjUIvHzhFZGbKzT5m5ZIKuA==
X-Received: by 2002:a17:902:e746:b0:20b:59ae:fe08 with SMTP id d9443c01a7336-20bfe2a4489mr80820255ad.42.1728127600222;
        Sat, 05 Oct 2024 04:26:40 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:475c:a654:1ae:2a0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afc65sm11722995ad.38.2024.10.05.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 04:26:39 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: fix spell checking errors
Date: Sat,  5 Oct 2024 20:26:04 +0900
Message-ID: <20241005112634.11848-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_042641_830292_91D8490C 
X-CRM114-Status: GOOD (  12.34  )
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

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43d73d31c66f..0b33173a750a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -993,7 +993,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	if (ns->head->ms) {
 		/*
-		 * If formated with metadata, the block layer always provides a
+		 * If formatted with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
 		 * we enable the PRACT bit for protection information or set the
 		 * namespace capacity to zero to prevent any I/O.
@@ -2506,7 +2506,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, NVME_CSTS_RDY,
-			       (timeout + 1) / 2, "initialisation");
+			       (timeout + 1) / 2, "initialization");
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
@@ -4007,7 +4007,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 
 	/*
-	 * If available try to use the Command Set Idependent Identify Namespace
+	 * If available try to use the Command Set Independent Identify Namespace
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-- 
2.43.0


