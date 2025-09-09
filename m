Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A1CA0FED
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=48L/dyWTY5YbetvqJkn3R+dpBL0hwkxyyCPEY7fL4uo=; b=TIBQnPOFr1xeB8V28QL74DzVC+
	Un47Ejgsn6b2mtZwe5ZXBVIHKBobfDMEQCA08mZaA+2DVvfyN5tiFEfCiLolEFsbQwoqnBRIKw4T5
	W55vd4+AbXA0TtxSs7SpzP58rGv2PLNgRqHXZR7BtcDwEdUm4yZQ+0l8i8GlIlyiSEr46B8Wh8SNB
	bAhoqI+5sBH4rCZ9u3+XzjK6ehMh3l4dOYAvy01gXnU6tpyU+QQvB3L+PDkU5bo8U/VzH0ggvy7vP
	5wifkUvXgejEuhxlCGce6sroIx3Ukqn9TVpbA/fXtpCsyZC/XpOptvh1I5fYQD+COLYplmTzaLo3Y
	zlhbd1Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1v6-00000008maA-1T5o;
	Tue, 09 Sep 2025 17:14:16 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvvhA-00000006RRj-1QUf
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 10:35:29 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2445806df50so47211945ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Sep 2025 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757414127; x=1758018927; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48L/dyWTY5YbetvqJkn3R+dpBL0hwkxyyCPEY7fL4uo=;
        b=DkyrKzC+q0plkqm3wbgmMdQZ4FDsApN/beOF9uD8plkfdMNrrdtyV2osYQA8HXReAE
         /mS/tEwcmDGsOk6xYcefW2VY9QZZPH6A3JBfPNtiE+oHcb2hEEH5Ov2OtZlCcPUvUnR2
         kLDHuaWliX4BtwRaW+pnnTgGzPPjIEIHceKTCET17tbAWfaK5MobHGWY4t6s8q0quLY3
         vC5BZ6T4Bi2EimxSZKiSzxSJlHKGM8oHhhH9LTh5RzrXmfGmIzHR4bSALzQ+iB2p653f
         mSoMyoJi7cdLz5F+1n9RPmaPmEcO2uUtHYy3KWJW+UCJvll8L+u48dp5AZ7uhcnrBg+I
         ba4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414127; x=1758018927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48L/dyWTY5YbetvqJkn3R+dpBL0hwkxyyCPEY7fL4uo=;
        b=vNMeTkoK69ZCyJPfrgkR1PdEEt7fzEk+WpvxicooKJAEHHJCdP79XHhMVTe3hqmFGz
         5c7vnp5QOJ518AzpHzWASNtSI7rD7VzznpGl4jgchaPQ4OFajrXO/Xj7KgvVrR5WgivO
         Ff0C/JEhOEydnHsp1tAHQFqndqPKB6xDyi5DScB5/zR6j5SRpq56Xo9oHGZ1WAzKFQBY
         bWnj6ZfVeMkQfw//ZhIhEYuM79uA3CBPVBNRvdWYcUMdbiiiSjy+HEXS6AqQD8mFeKO3
         4IvW7Lup9bANs2ig9eIgx2p288RtsaMg4+lPfbfbPBL4+n3zo8rNIwF7TZQWjQ1s6F5V
         q8YA==
X-Gm-Message-State: AOJu0YwEggYPquuNCz8lcKOgOt5zBVkHdKgl9qJCXDE4ZW8fnr4SQ/fM
	n99Jbs9Mn5bhfmdQiKWubjzZjQ8YaoqFpj2lEOnTO2X84wIjNnyDlqZk5ssRGA==
X-Gm-Gg: ASbGnctalAoykvvdcmSb8Qb0L8Vj2z4rLRnZvIudMUtcs4Jkm2FwbYbNDzmYAZY/QnV
	+LOw64DEUnAfUXmJeaEfX7vstZ942QiLWF4ZTZPOuNJZ5dtEe4nLxqio3H0mJffNeZ/ceX+VdvF
	6J05fEvmBuoPhdiIMDqEbYYVw1jIce9A5fwLgHUpYD+Hy41G7q9mo54StjyKGx8p/Dg18LSNlXA
	rvZf1bQabJWZc6jyb/bW9PUrw88vfUZV9RPMuMBRNlouRKdZPC1FsSJT4YXIeX2mPDqBmV0MnQN
	v+gVL8jzIueczC22m6OsYovXBRdoXBvtV12K3KEdCnt34L4kFMV13iPv64OmA3yD30HlJ4kWXuU
	AI8J4n+MWBeLrgBmw8OWXdTvAmvEZBvfnLmoOHzfqEivox36m8wqV0vo=
X-Google-Smtp-Source: AGHT+IFGDj8v9M4lxWPa8wexHBvULuLQPMqphkDFoYZ3Q0fld7Enh6YVt0Jny8u7JPkcxfWl9uH66A==
X-Received: by 2002:a17:902:8342:b0:24c:a22d:4c34 with SMTP id d9443c01a7336-25174373ed5mr103048635ad.41.1757414127128;
        Tue, 09 Sep 2025 03:35:27 -0700 (PDT)
Received: from gooner.vpn.netapp.com ([202.3.121.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cde5b6484sm130884625ad.19.2025.09.09.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:35:26 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-tcp: send only permitted commands for secure concat
Date: Tue,  9 Sep 2025 16:05:09 +0530
Message-ID: <20250909103509.10343-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_033528_377718_ECF182BF 
X-CRM114-Status: GOOD (  11.49  )
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

In addition to sending permitted commands such as connect/auth
over the initial unencrypted admin connection as part of secure
channel concatenation, the host also sends commands such as
Property Get and Identify on the same. This is a spec violation
leading to secure concat failures. Fix this by ensuring these
additional commands are avoided on this connection.

Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure concatenation")
Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229..1413788ca7d5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2250,6 +2250,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_tagset;
 
+	if (ctrl->opts->concat && !ctrl->tls_pskid)
+		return 0;
+
 	error = nvme_enable_ctrl(ctrl);
 	if (error)
 		goto out_stop_queue;
-- 
2.43.0


