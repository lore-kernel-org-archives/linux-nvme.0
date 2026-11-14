Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01610606A8A1
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xsuR8awC;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=XKeHRqGM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T4r4BFW190mgVXMSF3sZHq0lg2jwYYGxl88uoGK7Nb8=; b=xsuR8awC3o7FTk
	Lq+kc15buwuJSfDe9rZVqpYYmdCxvPDhBjZOeqTBXQ/H+5B9A6KE3KUWpq8DBYv5o0wNne2UXuNrA
	073kTGdJca1NmUJUZ65zC5I0LV2lykqcVXTK5BhMQRUxNEkBLkHj57s9AB/s38yEgDC29WJQeIItI
	l4lOLEh33EKh4ihwja5eYOXhjjw501mwKfVnOe069/eeItAVtXCE8TkhTKlBwfB5GyC4sNBSRfZAR
	b2Cp95d27FpdluR14mje3fur68x+KTjWlNEw1V0bkUXN+0yMApf6WOpDwU/VfwS+hWF+apVWhfVQ7
	Pcgkpubr3Iq8JS7jaJkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45S-0000000F9l4-06Uu;
	Sat, 14 Nov 2026 03:05:54 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45P-0000000F9gK-0C1Q
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:52 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1861270c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625550; x=1795230350; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4r4BFW190mgVXMSF3sZHq0lg2jwYYGxl88uoGK7Nb8=;
        b=XKeHRqGMTRB9IgMvF/nb/aRtrTpf/F+FmcVP7OFwQ/lmipa3hw/HAMPm6GIX180qdj
         eXUdYGWCh/agYPUgSy3ZdqQadbWc2evk9hA8YYzXM3hd+VlwnxUAlFrhrvHFiMRuLCce
         rlYlZOckD/oEsdBsEoQP/+9S6kJcT2j5oKnqsWioUHePZTPr7YOMZa19vTaHaUzKFttd
         xdu/rWE8dDL/AE6+4sgKUZJ1bwZ0Vf6LPT35uTQwwVZEt92+NaodPexre8a/NAnKo4Pw
         kJvUoHXt6cZ2X4yuJrBOawMyjy3L9upue2d77L+fCGt72vKm+16jy5ZAosMZYtuWalsH
         EljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625550; x=1795230350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4r4BFW190mgVXMSF3sZHq0lg2jwYYGxl88uoGK7Nb8=;
        b=W0M/ciglT7scAMPKI9UMBTistOTOJE/TcPGNcQlwMAOl/fNrmCMRgDsxp7/CprOlUL
         lBF4y31l4Rahz7jwKE8tnAgpOjs3bsPD6za2pk7jO/GZiMQvSueW5XQerT9W2JeB/nud
         kuKPfjqyoFSatmUL7/6rz2P2FKw58rBsSoL6Afy0u5eCSUdhTVmktlIbDYkL2pnQKcS9
         SgNfOrmI7fvup2i1Ndul3gsPPa6oMkObCSO48WKW6lFEmT7GP91ecZcO/Vq0XONCejps
         F7TQi48DJsTXOBAW7KZEYIoosPfk8NLi8hPxcM+DYheX5lKnQ+NvdGlwSDvwJjVm9ftO
         Sj0w==
X-Forwarded-Encrypted: i=1; AL+hErHzzkzKRlvbP4rs2iyMFtNUoGfMDu7Tbmmn+ix3RQhcyAXJjf2P+kFYjNR+9IfMEYenafIb0STJtg+t@lists.infradead.org
X-Gm-Message-State: APuU4Z9mT4xJN2t/+mWY0itsssEIiSj22tNn5V1Neu5s3mNpqPsFM9k5
	N1KqhHLLFqWf14E4r9LieVCsPiw2FQjqtxeYNeGiU2/3ZOdPGiPopBwckO53Vbq3yWR0oCMEcfL
	hZxIr
X-Gm-Gg: AYBFou31rwj9acg9ekademqzEB0DoHV7nGBsDVz9b9vbTPqVMjGDrbgEDcafIrMP3Ph
	WqITgeby0CD4eJmBf+Olx4ppnmOmc80kIkCGSbNpYyPQGG2q3DGq1u+g7rIM8bQFlYwMo4Uz02a
	zoxU0NtDd9QT6DLcMkWeQTQgb9sk7SJ11NVlt2BAT2M2i8mJEQIqFZGeC1S33PzQnX0BhaR6rWP
	vegY+Np1HEeIt9gb5RuebMQ5BTq3IwGwvu9cpEFv/a0bas5yl9bzNUZZXOgtCLipLxnOkiZJ6QY
	djfZi9ovrh3vfKAmJbn3TeJInf9YYFcMgc+cuCf3yh/jxHKQrcuf20PKMS1qL+aUbmowPtJxG2w
	ahnI1/dnFVV9TpwAPp9/x88Lhpj5HBJ8kRAj/nRMHN2a71bSiafAL2uasKJzUTEy6VLr/1sYCjc
	SnMoLSX66RfjET4FU7qm7dbHdFFxAfdemNL/ZfUbLDTC71mEPRDoHWE3yJIYpfXi3btC35VmCyU
	lpAmyQMz2cbsp6Fv/YwKBwlyabyVu+O+atrcnADnXpCKPnb+PP8c3vs2MY09rfPgZUBUbGPY1+v
	BHx3bK0A2c4lv/3FUBhPj904o4c6TZN4i5TVCDvbW2TE9AykhhBH
X-Received: by 2002:a05:7022:7f0c:b0:143:297c:276c with SMTP id a92af1059eb24-1b503136bd5mr3705670c88.33.1794625549801;
        Fri, 13 Nov 2026 19:05:49 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:49 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 02/17] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Fri, 13 Nov 2026 19:04:16 -0800
Message-ID: <20261114030454.2836543-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190551_155039_EF1DE8B6 
X-CRM114-Status: GOOD (  12.03  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export ctrl->ciu and ctrl->cirn as debugfs files under controller
debugfs directory. The values are useful in matching host controller
with the corresponding target controller.

While tools like nvme-cli can parse and dump these values during normal
operation via identify commands, having these attributes exported in
debugfs is essential when a controller is stuck in a state where it
cannot process standard admin commands. Exposing these values directly
ensures administrators and diagnostic scripts can always retrieve CIU
and CIRN for manual Cross-Controller Reset (CCR) operations or path
correlations.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/debugfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..221fa81e124f 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -153,6 +153,24 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
 
+static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x\n", ctrl->ciu);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
+
+static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%016llx\n", ctrl->cirn);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
+
 static const char *const nvmet_pr_type_names[] = {
 	[NVME_PR_WRITE_EXCLUSIVE]		= "write_exclusive",
 	[NVME_PR_EXCLUSIVE_ACCESS]		= "exclusive_access",
@@ -287,6 +305,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
 #endif
+	debugfs_create_file("ciu", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_ciu_fops);
+	debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_cirn_fops);
 	return 0;
 }
 
-- 
2.56.0


