Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A23D10373
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hb0T1pFUt+Fg9H0rtoLbOEnAOIT/fDYuF7o1ImhrgBk=; b=pyB9laR9w49h3BMdX8dG5lGS8+
	O38OlCs93IlH4bF7ogUCrbNxqnZTKtcpNv0RiD8v5VVVwdtSqsLqz7f/QVB17alz9cM/XJqKE+3pu
	ODxIn5jW3v3YWkWb3uDhkP65lALTPaoK9UhNMZLcQAMhxi1WLDdFSxyBDDPEeJY1qcg3HgD/YG+B9
	uEKw6GrLXtP1ozzQNsJzjdpJCq/t88263rdzChbfuNp68uc0uc42UQXNftnVQm+xacLNES9c3Ppyw
	waibvXXcCjf/FdoWijS6li6xCWd4ak+xa4IdAXzneI4W7SPOt3x3ySD2SMlYhBtaltmC3Axk2Co1Y
	NmhxLMWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO526-0000000EDMc-41fg;
	Wed, 26 Nov 2025 02:13:26 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO524-0000000EDL7-1fwD
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:25 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso7184648b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123203; x=1764728003; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb0T1pFUt+Fg9H0rtoLbOEnAOIT/fDYuF7o1ImhrgBk=;
        b=Z7Ltt5xJlN4Y9AK3VzZ3rcbptZICWcgkAMCtaXo3Yw4NUmHJVS3Pxz7jXnvkiYFZrk
         RCH06yCejH75LBQxxEResmnYybKekNNzBs0bPv9MZ3ChX+IpYT8T0t8ubL7a++MDN1d5
         1cSIoTbFsSXxWq/wNqYvbT/hv1zzlzE2bymmfwlKmgS7pPqMeSvdoWHGMlwNkhoIPkAi
         dyJhALDXkqWFUqA7SDxwDu7OwlP9j23sZgoo0xeEIiqxgDwiqF6NB2MFfGzrROQeA/Kq
         /tJlWxY/WMkUZ+JumIlexMv8m1nUwAKYMurYfkkWMZTqlwSUtm/nQ0E6uUQ/EXHCxnh8
         7Tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123203; x=1764728003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hb0T1pFUt+Fg9H0rtoLbOEnAOIT/fDYuF7o1ImhrgBk=;
        b=fzd7pwY68ec52L8a3J91i2NhZenmq+1N+lpMVCW6GMwyjqtTXmjPxFhpcAqXR4f/Y6
         dT9Vi5KB/B7yzyRElJVNzV/3UXZlB6tot6PbMGfUgO5GfPKacKVSOly8U65WEOWCDoM6
         YangZRwvArgscMuydYs50YzvX7pyYYXTmZ+90OPNr8OArh0ajG495Zovokb0EB3VCC0d
         edfvLx09RuZgURPoXbqE2Hyx7iqPthebyzDCt2E5MShZ/MM3fOns0pQyP6Lh/sDMyLyf
         MNmCQObxeZ3nu78kJf9P5XWnwqsSBjpXJ3FM+/NG/gdJBbCI63aHWWLo4Y7UG87ReCuw
         wmeg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLfawyFSLUZ73PDPdqVWW+aJlxdpLQEGz/Sx5iX8Fw747uEOTV68K2AOuy5N16jNKS/7bYZ8+6QrK@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3K4SgB/GcldPfp21iozdBbVV0Loiyv0U/263yOZEiLakbqC+B
	AZ2iV5BsKZ4CXlZukXQl6UrT3wIhxbb16eoXzgB8VtCDqroZ90Q5gvqu3IFmTVzPOtE=
X-Gm-Gg: ASbGncueF6+aKPWs12xy3rKXU+IVrnapurwdkS/OCgINzNVTvvnBWH6lfvIKSalxgZz
	tKEKuAbGdCgcd/XuCEastCwl85fTLMKJnI7EHLNhs+nTFXlWQa1e4qBSoK+rrcPshAVOuP4Xyc6
	r0mn6k58MWmq2nKgSzCmXjLqKU0DDx2zNbmj7G+ZUZKUarwST91tcDgQ6IsCvEVaPXWQpdDigNY
	iDw5huYrSP7Or+vO8EFx0TXyOq4LBdx58yijkRuYyH9m7iPEtwGRmXWdV7ESg8T6AaSO5SvsoGY
	QHqZs/LwwshOK3IeiK9fDQkTCW6LZ1RS0GzQXabOCBWG8y67r9nMPxRfPVVrtT/kOyaxNyXVybO
	ylMJZ1/71YrH03970UQAUk56j+sD0FsbnIiTz4EjAU8XAMYfJWTHIp1pUrhkyt4N6W/zh06Nqtc
	lrGasm2cA7QvHsI2QKtqZi0argQb+Dfe44ag==
X-Google-Smtp-Source: AGHT+IGQTznDK4qX5kyXrrEYXRM0lRZjmQu4vbxK2XPJ2chF1SsUYfXs5xX8kyhOVg5GdCdI+Tb2vQ==
X-Received: by 2002:a05:7022:3898:b0:119:e569:fb9d with SMTP id a92af1059eb24-11c9d7178ccmr12382169c88.12.1764123203252;
        Tue, 25 Nov 2025 18:13:23 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:22 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 02/14] nvmet/debugfs: Add ctrl uniquifier and random values
Date: Tue, 25 Nov 2025 18:11:49 -0800
Message-ID: <20251126021250.2583630-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181324_438399_05434FF5 
X-CRM114-Status: GOOD (  11.64  )
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
index 5dcbd5aa86e1..c983b1776ab8 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
+static int nvmet_ctrl_instance_uniquifier_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%02x\n", ctrl->uniquifier);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_uniquifier);
+
+static int nvmet_ctrl_instance_random_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%016llx\n", ctrl->random);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_random);
 
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -184,6 +201,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_tls_key_fops);
 #endif
+	debugfs_create_file("uniquifier", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_uniquifier_fops);
+	debugfs_create_file("random", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_instance_random_fops);
 	return 0;
 }
 
-- 
2.51.2


