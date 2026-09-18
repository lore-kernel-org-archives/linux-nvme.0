Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26AFC982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=; b=BOw9uilS694Zjtq4LxrsuxdwVp
	bBIxvc5HKCNn45mmAR7Fqk9fYK8o0ajHhANLVlewFQ+rX5lBFw0cqEjlNdhtvdAqwolBCkipF2SqQ
	Cl2G6QuCiMIohovPyxr1jKlrgQ69KKlfWqI5gWbHM2vWRSDILjMopXslyJTQjxRRsRUBUAVLMcfkQ
	Ti1jT5xPisJ0q8P8cj6auS6gsw9V/4hLtzRIZFsN50CK6sEtElMGL0TTlARSphRpjkfmktl4BWqqI
	cjxfT7OpsB4RCgJDk6fsUAoamCE60AsUYuSl0nvBfrCD53QvsBGbDq7VO6AGakwa36/dL1nUxHoyk
	A6VEAegA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8y-0000000FGy8-3n8Q;
	Fri, 18 Sep 2026 18:17:04 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8w-0000000FGwr-1X82
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:03 +0000
Received: by mail-pj2-x0e.google.com with SMTP id d9443c01a7336-2ddb44ad1c1so11231165ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755422; x=1790360222; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=;
        b=dwU7y4V4dhdk9To6GYxCDqGLYIdhP64EGA3Fay+/MqM+bu2lwVan35Mb1EVQImHIxA
         IQg6wIJ/jEmtAdu4s80Mm2kQHmkr37e60t8ujUqUvpp0evFGbdv9pM51eYW4Ewg9JpVP
         A/6BYSDp2ovhWnacZojHKY1F7njkezWWgaQMBUplS2i3YiG7u5EM8VAnFz/e9WUsf6PQ
         VzK0OV++4yuHeEum5HmgjdrfIiI3MGTp5SkVi/aGqc6eoWHN0u+uZwXCrOcViIlocP6p
         Lc7yPtNWDxPdH1f8X7bEOBhMfrDF6AuN+qgQYoxUaFQHXYkrX76W3BmBEQ38/uLC/Lic
         svOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755422; x=1790360222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dVQz5nhnRw3JFcVZi/bpaRY30mlHvfzPq9aZRP4f2wk=;
        b=RAEGdJmUdKdaflCdj3jC2gKPZVLmO0dUOkQZpqaOjCXQCdvj7PPoBUspfbPRX73dv7
         TCIkdEtgXD/iODCHCpA8s6w0amsHd92RkBOG+pK01E6Z01+olK1ZolpOyq10mGbh8i4v
         6haDJ7hfuINSQbS6+/2eCjdFGGR+tXiMeOs+tLduh+kbNKJ9UP5xuASVtYncTLF7VY+O
         kCT71vxlvIVAbClZ57E9y9Enk26m/fW6dRCcAbXAghHzRbISMXFrXZ5I+MB8etPMXmHW
         82tLaf5dHzAgxodCjsd9Vq2pjBLL3Kq+WfyKv8Po+wb4AAJvryNk5CZl3QtjgLi0r9py
         dmBQ==
X-Forwarded-Encrypted: i=1; AKwUvByNoXHbePpPi8AAm4eHfPhmPOEQTyDDuP2Ihf4kSfGxfHUFKMgD070XWwrU8HD/30Y2pbE1wKM/y73j@lists.infradead.org
X-Gm-Message-State: AFuF++nHNibLSlnmrN2fjAUAkXeRHGi6jFBiYBFG23aI1EPWXAistKjO
	Xmbo220ijJVvdQdTJES90+dwTDkXiCTe5jZRm0MjL5rN0jmY2L9TwMVjfu6iSzLxlt3DHI4pqbr
	2Ovapx/4=
X-Gm-Gg: AYBFou13Rrw+Ui4j/sDx5jo/5uP9oFXAL1JCEiHrCBLNshU4pwMFkdV4vU2I3bDwR+X
	8Wfg4zHc0t9MyAL9DtpIadsPMlmFgWneStsbIsZaPIxttxsklfuRHSc4+VOXEB0FGlMNcw0r6sj
	m4uARNjWCv27JqReOBaV2Ld9AENqpABfGISeI7hJhxI4cbmSATJ3fvbBHQw/f/WhPSysWCMrHu4
	BjAlStbb+g3kylEod1HktEOGpzThvWR4LCeY6feUgs9zdPnQtUtY7IsBhrYmdfyoXLhQaII0U2x
	7MxDmy6CYFPCHBD+YnGksYd9tOBW5o1mMXf8leGrQd3tUHsGtL/2jnr9ZvKxgZs7eXDESVnBCmL
	X8Q9IJZzV4gGBvpXs3LC8JFDbEOrgfTPpnmOOBUW01iMJc0varYouZv4HzPbtgoMu5C6cXP+Lgz
	L/TJ4099FkoasBgppWv3KBLZfEgiHjJqG4giKk5vR+dJNr67CL/PERvbwZ1vJmdD1/g+Y2BZqLQ
	oXm0JXz1A7MUrJzBnucUtZW07tN86TI
X-Received: by 2002:a17:902:d2d0:b0:2dd:c0ff:e72c with SMTP id d9443c01a7336-2ddc0ffea23mr6053395ad.62.1789755421554;
        Fri, 18 Sep 2026 11:17:01 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:01 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/18] nvmet/debugfs: Export controller CIU and CIRN via debugfs
Date: Fri, 18 Sep 2026 11:14:02 -0700
Message-ID: <20260918181614.3947933-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111702_404976_11F5CEF5 
X-CRM114-Status: GOOD (  11.98  )
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

Export ctrl->ciu and ctrl->cirn as debugfs files under controller
debugfs directory.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..4de460879d0b 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 }
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
 
 static const char *const nvmet_pr_type_names[] = {
 	[NVME_PR_WRITE_EXCLUSIVE]		= "write_exclusive",
@@ -287,6 +304,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
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
2.55.0


