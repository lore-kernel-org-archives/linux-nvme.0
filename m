Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB99D49C67
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8PyANzTtrT2xWhov1X2x7JVr0z6OuDiAP84R/ndncw=; b=BDZiunhRRo/zcPLVQsofWHtrzg
	YH17yNiUVlIjedKrUb8re7iCUxWfZCWfVEtY2BmMnd70CB9KgDgzCN9y/L/F/PrElOlCFM8kaU+0d
	V7H7uK9jGbikP7WOP1X25tOvT/F6xhCM8c1ShIfSn2WkWGxrbVRSb1HtYbBf80ro/W7XEDsb05zv/
	zAnhXj5rSr0Qjg7dwfPQeDU+f+DvBDxGVKHzaWp5HnCR/fXkWVtx1uhQdSTCNnbv1UUliKxIIp4ul
	9YHAseIb7I1I1oR2nBDccajsZdwWcDnCKumPppQtN0hiOmguZWnDsiwgJvaJGQMl0Sy/syPCXCtlK
	0Y3piYIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6L-000000022iE-1Wyy;
	Fri, 30 Jan 2026 22:36:29 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6I-000000022gA-2TzH
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:27 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-11f36012fb2so3385515c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812586; x=1770417386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8PyANzTtrT2xWhov1X2x7JVr0z6OuDiAP84R/ndncw=;
        b=CJ0T9X8UvcbVS34OK5ZxhHPkjpL+FoTkDpd+ePgzi0GDfSZxqd6jlWHQMyz+D30ajD
         p6bcjeS/vHKBgaWHwP9DoUJWgsqAshGN4zou8V8Jf9vB9FGbRDMLQh7u2NWoHIfkehB+
         D57vxXesytKHS3Hl5x9Ci/zzBf9Iy9Abrjs4t3qkNyiDO7xofaLgaWap1AGBrW21HGMY
         eYzP/lxgaoH73HBH/RDz+rrTMIiJwmz9PBSiPvsie+rtzienRIv+0USHNuNd5cgj3s6K
         w6oo0sc2Ypl1VagMpD9ThM8g3rQXRGwD4DXiwLk/PRVCXNbTfMYRtrmPHmREHlT/6XKl
         EfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812586; x=1770417386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8PyANzTtrT2xWhov1X2x7JVr0z6OuDiAP84R/ndncw=;
        b=DH9HaQXFd4uqoJEHJZQ51qdQFEmbOY433TZiLSdOs1th5xdBrAlCh/iYpTqpgxxwOo
         7mHYOcdI8dwW/kSVpEjCijJt8bu8brr5qBV4hbKHUPF5U2vd2LhxP+nMztv99XMp1ppB
         wxJ1JIYF8Ssz6T2ySX8cln3RxY9pqufbkxNoPETS0sOAho4/P/DN5VrsTTAAAp5dNoui
         z+Ah7RYjR1um99v2P8QRvyyTdNbABCLZXN7o3Qff3XpAuU/0qiKr0WT/k6NZAO/agfpx
         FMdmtmg9tRgnVbSL5ta8OocIZ28DHumHjPric6W4ilV0g1ICNi13pEBcgujAZcQYZOEE
         SdGw==
X-Forwarded-Encrypted: i=1; AJvYcCVRCXf70ZuIjEB1SI5o/u+mo0LGrM4RugU6caSSOTxi8MRqa7MDxniwDgqddfHqYHqqhGeYJ5p08HuK@lists.infradead.org
X-Gm-Message-State: AOJu0YwP6JQ19ok2wHBdxwrm+yNC3wf9rBs73ln2Jyd2+uu3nJ9wiKQn
	JJw0rQWJ10d/TaWOjcgh9kzn55d6naaIZT6d8wcQ6VEv71uy9VxOdgA9oYmaa+oLg70=
X-Gm-Gg: AZuq6aL9jnJsrUSrWzNgbhBeF0jKOeK7liPT/gN/z45gH1IjQ3fhFLkyKBCJPhHYQ3k
	iYLhNySiWhDJspTt82RgeGw4WJ2EZGxlHoO5TIi+CwvHzdyolL9Q+oNw5tbBJ8KQNqKLK+63pwM
	1eATO4IJuxCjnmkj7+c6tgsuIYcQlSAmXx1UOlL6UAlvO60zExvw0AqDZvxRgzje4OxOze3Qk7w
	GOYYFSar7NTpZB7wIP64AniQzDqJ/ehIU13uq46Abk0dl99TKVE30mTGbIiGJvzw/qzQrwW6fua
	b9J1a/5dTVUoyK9T/15Y5onf26kW1vEUMfVqB1/VwCQ12pgAxbIo+NdnPV7l+x5keciLbigJ9JI
	dI64nNBAMyouFvMkImxzkcbeMcOaHG9jEjQFlQupHS1AREhEYpoJW8DT9Q1PKLYBguPaUJNfHDj
	TJ0LfsPztyyUMaOZ6q6X/LPwum1ChJZkQPZu3vcNGVdIat
X-Received: by 2002:a05:7022:6b94:b0:11a:e610:ee32 with SMTP id a92af1059eb24-125c0fe0435mr1902226c88.25.1769812585515;
        Fri, 30 Jan 2026 14:36:25 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:25 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 02/14] nvmet/debugfs: Add ctrl uniquifier and random values
Date: Fri, 30 Jan 2026 14:34:06 -0800
Message-ID: <20260130223531.2478849-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143626_631456_CDADD002 
X-CRM114-Status: GOOD (  11.02  )
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

Export ctrl->random and ctrl->uniquifier as debugfs files under
controller debugfs directory.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 5dcbd5aa86e1..1300adf6c1fb 100644
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
 
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -184,6 +201,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
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
2.52.0


