Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEC606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jVvPYhdW;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=BSPwbgP0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=89dq3IDlIOzn8djResfo9bjk5NhtKhFtGgw4OwKNXuU=; b=jVvPYhdWNhBzWIqhkSSCK1dFSw
	AxP80hws74AYvV8W9XzkWO1LAzXDhCTNDuI9G797GUTVqN3iybMWbe2KGenUTD5HzpCO67G56cRM2
	kB4jDQeZzbC7ZlhEwY6y1BL5syeymk0W0+da/WzdcXgTDbDj0CUAaofn3YbY079RPN7HuEZW+xrCW
	viRN5ioH3/6BIL5ckQugMAhIUSukb+K4cjviJs25sYoDX0a2U4LYQDf+yAgJM9K5ASoAgD0pJXnYG
	fIORrfpzl9MfCN/Eze7Ze2m9oTZpOPiP7fHrNmnxDvMNBBH7erIg1klHG/O8b+JLboySgr41ydQOU
	JaUE0I0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObdg-00000005Z65-0cQQ;
	Wed, 04 Nov 2026 14:06:56 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObdd-00000005Z34-2Gi0
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:06:54 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so729512c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793801212; x=1794406012; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=89dq3IDlIOzn8djResfo9bjk5NhtKhFtGgw4OwKNXuU=;
        b=BSPwbgP0ckh+sHUmitEjjy0mJnjuHyTAE5NV6/KtrF+VZoGO6wtlWdnA5fI9tBokqS
         dAxxfvNPVj7n9ZjFSSTIzZNUW520t/fHn1mH/ihF50MVBUUMRBlcLCKkLiJZEvqDKkF7
         Os8uqvDSeuu6aLJu1I6MRYON9kWwd+lIR4RQNVISfRiA9iM9sKDXuQXJ8feSlokm3lgj
         NQ3Bx2p6UqOenBWq4MQQ71TQyilo3081Q7YdfhkqIp6Dm5ovnsxjgrqMZHPPJOpdkR9C
         qoBvQjR6sq++lK8ytd7/xKxGxk2tlvmVLT3ffIaW6Rg1Udv4uaQIIiKhAiLQKtLTM9o2
         HeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801212; x=1794406012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89dq3IDlIOzn8djResfo9bjk5NhtKhFtGgw4OwKNXuU=;
        b=vbfBQIgcwsFpRY2qDZ8BObjpSsLJi25KztyQgymkRlztP9Qeotmtm8Q6caswLnnOgF
         oD3Hr+TjRl+sGjwF08fAtpHUb5ysTMal5XOwK7Fv7ZQi63QG47uCJ1ww/7Toe+M8whQf
         eOXHuUf+RKwzDAjCmRBszEcZ1lsDPXQb6wHfqn5IjzTcST+Ha3zWNxHIEqQeOH0cSWyd
         iHOQXjGj+cz5FxdyYe0RVzP/5ozS81+uV0EV5DZ8+iOyJlkaa38IIYi9EXbRe9j1XgkC
         IUcDnPl+9uJfFDDd1QOg5Sw35JaaZvUHku1j0XxFyaqx+wcVkN93vDLJsqaBmOLmhAMM
         9Brg==
X-Gm-Message-State: APuU4Z/HSpNQ66dz71BKF1RYNIYxXnO58u1Uyqs2FQixEbI0ovkr5Xae
	Z84t84E/YcTWXmKMS90aSp05rRPmuGGlFRILumEO0I2Olhh9FVX577oZ0kVbPmqwuXo/cac1Ru7
	kd/AyV7U=
X-Gm-Gg: AYBFou11XRA4WUsMmYO1LdJyIvzda4OYvxOn+eUwkLrE+AYYayAEiQp1PogkAQMTv0/
	uRD7cV3PJySe49g+Zj6I8ThrNfgytvFP+M9zp2AxW8ONbttch/Er11K/RnzteWqVcowyDjNLe03
	CGJrfRK1YM4ZonErMDcTohEhLSAdrNmQswFeriJBEfM5g8VXIlCc9M2ek2pTm367MfXOYbr5xmJ
	+lcvbiZOdXAGbbd4R1AMIsNyfF6B6dBqDDS9Fcw8gTXO4GTdfCEiYM9qx2lrEl/GuXzOfzbLqNK
	QVx7vs0p2XWH930WsxbeVp2Zq33Cgy5Kd+DCHAUjVHAMf/3KwiVrPq/8CMdXKsNGdJ4R9a9xCZT
	L0jM252DW+i/uyf+1T/qbH3OGQUR7WIrTI6l7JOzdIvF7SR3gqBuZjnIwsa43qIc/1MCiTTwWSU
	ef/JC1IMDC2cXbnJI27YKLv+IPzDrRyNGdFT7Pa0qw0IgjVoyWokIRQsMLloEe1WOxekozht1XQ
	9t0khtPY5Tz6zinZ0hvdefuYqVzZe8VllYJ5EcREmSMoytAvDZSzDAi0504nDoTqskYN+HCOQ3s
	yO5EXrfa2ozOtRr51AHcPbFMyhSY5IV4PZDp+DmgXxQWg1HgDp22A6bQSlQGa14pmB7Tapy9Dg=
	=
X-Received: by 2002:a05:7022:120c:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1ac609808c6mr21925883c88.47.1793801212374;
        Wed, 04 Nov 2026 06:06:52 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm7938399c88.23.2026.11.04.06.06.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 06:06:51 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v7 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed,  4 Nov 2026 06:06:28 -0800
Message-ID: <cover.1793800758.git.saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_060653_592292_FFD9B4F3 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On hosts that partition their CPUs after connect time, the connect
time io_cpu selection can place a queue's socket work on CPUs owned by
another workload. This series lets a control plane set each queue's
io_cpu through /sys/class/nvme/nvmeX/queues/<qid>/. Patch 1 adds the
core helpers, patch 2 the nvme-tcp attributes.

Changes since v6 [1]:
- nvme-core now owns the queues directory. A transport lists its queue
  attributes in the new queue_attr_groups member of struct
  nvme_ctrl_ops, nvme_add_ctrl() creates the directory for it, and
  nvme_uninit_ctrl() removes it through the new
  nvme_queue_dir_destroy() helper (Nilay).
- Rebased onto the current nvme-7.4.

A blktests patch, nvme/077, covers the interface and follows in this
thread.

[1] https://lore.kernel.org/linux-nvme/20261023230426.6425-1-saravanand@crusoe.ai/

Saravanan D (2):
  nvme: add per-queue sysfs directories
  nvme-tcp: allow setting per-queue io_cpu through sysfs

 Documentation/ABI/stable/sysfs-nvme |  31 ++++++
 drivers/nvme/host/core.c            |  12 ++
 drivers/nvme/host/nvme.h            |  25 +++++
 drivers/nvme/host/sysfs.c           |  88 +++++++++++++++
 drivers/nvme/host/tcp.c             | 167 ++++++++++++++++++++++++----
 5 files changed, 303 insertions(+), 20 deletions(-)


base-commit: ca7e6a9a693240f059a0b47726f64a3f0573011a
-- 
2.56.0


