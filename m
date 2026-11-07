Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B224606A32C
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aNrrkeCR;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=e2u6TXQd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=0iRlvi+Z+F4TqdsB35h6njgSQLh3RUiQ2w01CN1aXJI=; b=aNrrkeCRGrNtCJJvH4/p8+pUOL
	qAGlD/b1OV0IeL5H8RwTf4obOXkVMUOp3gMXj4NqOQtX562xYz8CJk190/o8Wuy42jqCENqkrBl6Y
	Xl1wWZiN3nMHOfuyY5jbxIIvXhTiJAKIlkkHsD8nXnTB53S7BPR8v5zr0DYKti+9iNYyiBulMeNHw
	T8ihDHFbOGf9ikdRWXjR/XhxcTdhJNs0QVS4AdAhI96/gGQ2V8s2Hi/6slPvKbSYC65MRaqmjSxHm
	8JYkOntGF4cR8iaNria6A7PryWX4+GXoyd5nE28zEbugk8zZJuD9oMid3YXeOAkfcekWZ6lqVcCPd
	zVP/kVmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7X-0000000ERQ5-2En1;
	Sat, 07 Nov 2026 09:53:59 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7O-0000000EROu-4C0W
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 09:53:52 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so3443575e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2026 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794045228; x=1794650028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0iRlvi+Z+F4TqdsB35h6njgSQLh3RUiQ2w01CN1aXJI=;
        b=e2u6TXQduzokqqVg4otuDbrxi9K8GMK3t2Du362BkO6XKrxQhzYmDt22kBToN5AML1
         wRGdi88RMoXikVSuHd9lQQbbyBm3bVUH3v9r6mgAUxU3m76BcYv3CMktWfw2MAEIat5R
         chXqvgPK7XJxtvdkTpYEqspzu8Q6o0o9k7Eg3Usj68l+y/bz/+VK0DlOw5/RP19pKdNd
         778Iff52c0ZjRUeHdL1+dlmZ3PQlkHcAbE8OhZJFITL5ZaEjXWeKRjAy35XmwP7q42wY
         VM1AnA8EP69nPCJkHyXs5y4uYidKCodNYrDbbQESiYFd3om3O5lK/xVAEwc1yQ4p4Sgm
         twYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045228; x=1794650028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0iRlvi+Z+F4TqdsB35h6njgSQLh3RUiQ2w01CN1aXJI=;
        b=yomH6+56IA9P9zDs5LGX3HGTD3yF7sRMRLsYK2+3FIh3Z7KEWATVvH0lzT7XCo8p02
         vCUNmkYo67tcsl9eGH/OVMGq2oV3Jp0HYq3MGfpWWYKBLfaWBJNi2Cas/57NY83Ns8Zl
         xltj0WdLDK3k+MQ6bhp88ebrVNo4ijKi9q9aJT67XGbRjDhSU2oeT04Jrl9SwwORqp5o
         3d+oOSnCWode2+5nltGIGZlpok/pFLDyA+fCZFKEhY1ERCiH1PHzLdLlmpAWOyKNHCsw
         MygxnfCY7Z78W83OWuw1YEfdB6mvNhaK/9JIl88hMMKnzIa+gs1cAusVV71y0fJceCbm
         YniA==
X-Gm-Message-State: APuU4Z8vROUoePwtOmkFGYeq1iPaBRZuShR00Q/ysWZfNBbV+Njpj02v
	2s2jNIJyGh1VbpJqw0hvJP3Xh5STWWNWvNZ6tuaD28cCQqX+QJ+m/N7Lg6wfkEZRXCW92KgE9/z
	vPmKNEditsQ==
X-Gm-Gg: AYBFou2bjvCZLtCXVveF16snGcyQ0ti6nU7yneHB5456ehi9EvnnVi+dox7YhvEanbp
	YUrQa4U+xWXyyQF6mn8TdzqaaN7kNXef14t58wXQnWioXpF0HyHlQb0nHPHS66z3bnmJNjpAyKz
	QU1jifqVI1x2+xEd5CSgAb4aQScPYWJyTApSV6QNvzN3+pktCfOuVLHXmD75Jgh6WphwY5Ucmc9
	PdUCow5ZkhWF6UpCwGIf6TSerLpZLDwyMH1KjTvR8WXJtvwnqfPfeB/xKuNrs8Dr8L11RhzuWSE
	geNopGk7mAmqPl1kPaXK57pS7DnRwqdm+4hbsm9ntp8mysiyU8H2dv+GXQ9ZsOXpOA+/+5FI8J/
	lWk2epYoJp8CZjeKydlaBiudcfrd6LukSsofF24nrNkNddlQV3OKmC3cCVw648rWYUpjRNEcZQg
	hf6Uauhwhz+gz/S8JHoICWrHWFoMEoUMfZH+y9aEaJf9vc8t6iyhMKodXv5vQidLvrk+UsmR0Eo
	098UktKrwMOE1xUbScGDJibsFywpUPPR0fL6Df63fowk4DMRXvgy3B1ww1IYwo7EVmE9TPZxeao
	hqC3MEOilwCXYfd0jJqKJPO+HKReenCFvGz+PV/keaOGW/mNtKhdCEgi8zjJr/YK/qivoRjHpw=
	=
X-Received: by 2002:a05:600c:1908:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4b8190ec93fmr25969685e9.1.1794045228607;
        Sat, 07 Nov 2026 01:53:48 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([185.57.101.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm37607545e9.4.2026.11.07.01.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 01:53:48 -0800 (PST)
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
Subject: [PATCH v8 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sat,  7 Nov 2026 09:53:35 +0000
Message-ID: <cover.1794015622.git.saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_015351_150179_3DA6CD6E 
X-CRM114-Status: UNSURE (   8.60  )
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

Changes since v7 [1]:
- nvme_add_queue_info() now calls kobject_del() when
  sysfs_create_groups() fails, so the failed queue's <qid> directory
  is removed before the error returns (Sashiko, Daniel).
- Rebased onto the current nvme-7.4.

The blktests patch covering the interface follows in this thread. It
is now nvme/081, since other pending blktests patches use nvme/076 to
nvme/080.

[1] https://lore.kernel.org/linux-nvme/cover.1793800758.git.saravanand@crusoe.ai/

Saravanan D (2):
  nvme: add per-queue sysfs directories
  nvme-tcp: allow setting per-queue io_cpu through sysfs

 Documentation/ABI/stable/sysfs-nvme |  31 ++++++
 drivers/nvme/host/core.c            |  12 ++
 drivers/nvme/host/nvme.h            |  25 +++++
 drivers/nvme/host/sysfs.c           |  90 +++++++++++++++
 drivers/nvme/host/tcp.c             | 167 ++++++++++++++++++++++++----
 5 files changed, 305 insertions(+), 20 deletions(-)


base-commit: 687f3014afcd5826fa3d8f40b445f647b5a379b6
-- 
2.56.0


