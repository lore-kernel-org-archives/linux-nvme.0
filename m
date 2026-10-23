Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95509606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HozXRpvy;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=brxdJ76h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=doBOOM8Cs1fNLKQHQX6YPzDm/RUcBypchsyN9Gs0iOo=; b=HozXRpvysU6Yztem3xaFGabIqg
	WVVIUIZb+5eDgG/ytCssVHt7joZxl9J56/zZIbl3Gpp2Fv9bo37RVWqUtNAPw08Ur0/473VAFIPJP
	fPs2+kHz4c3lVmyY8t0igshPRL2PYEsVfFiVCY0tUCk+TE2wrwmGk8j+2p/rdGRoWSeChEcxwxiv7
	SsCLZcOSbwM7hqOTLcRdEYwJ99PL/6bCLya5MTClKX48/Q5qNNSFB9SVebXz2uvtlEXGKdcEAAwMQ
	HXkGT6aNIONVYDy+HqQzD1xNOgcw3LgWR00YKgdk7aneVzkfYI7BHup7loLlzRSDIDZkpVRXPCZBI
	kstJVISA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKOJW-0000000H8b3-13Kb;
	Fri, 23 Oct 2026 23:04:42 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKOJT-0000000H8a4-3NlM
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 23:04:41 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-353804b591eso2311935eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792796678; x=1793401478; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=doBOOM8Cs1fNLKQHQX6YPzDm/RUcBypchsyN9Gs0iOo=;
        b=brxdJ76hc9HVCA1ypYlcTtaARtIb3yusxNN9wds0Agid2ivuguk2bNn50KHIWzA6S5
         f+VW1x11CL6QrviM3/BmpNcC2KeYFug+HaCiGHE9+oYGfUegu2gEPJOyrn8CaM7tgTRN
         p9JKf8u/+tOSro5cLAVmLCUxthS7LgMbB3WhEHjkyItWMzG/nrW0+ZU/VJUgvlI48lp1
         +2V7B6GxFGRPD7k9YgKGa6o+18C1SBC+amGJtZJksC2OOztCn05IK3qPfFTMbvuctPm9
         JvOez+/aOr0ZEfxJE4d9AzrYWUqOAbMQyecJapNh9WaqAowf/B15G/5JhoBMgfWbpXS7
         WGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796678; x=1793401478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doBOOM8Cs1fNLKQHQX6YPzDm/RUcBypchsyN9Gs0iOo=;
        b=TKNYLibbz185hPZ1UhaXujWBSy1+pHZZ6bXBrPhV0BcUxzvQDchNeNXjroo85Q3wOv
         uz8HMi0mv+iuoNpsyn3acPtUEkXqTYspRnCnOBkrSUy1nw03eaueHVG5UWwzpDOD7Mat
         fZ2q5ixrXMUmndYzikvXDm15jP2HlEGv4S7rsv0VHe1Ak0XdOW+7Qe570H2un5f7RO89
         5zuOMBJO4fNC/0epLQi1ubE5Mgx3Ge4j3OqXYYRs2LOOMZusGJQ5F4Vat7OPoM5l2IfS
         sgLlWKyiMmBSCEoDcxnyUHeEObtD0770sgjrcjgGWwMa4Zc4rL5v0Px6UT7btgOidlMK
         dYwA==
X-Gm-Message-State: AFq9FYIKyQcW9KIiAcWNiqXaBsvP63LhjU1ot+uJHJSCVxKMBxfShJdE
	Y4nov2apIA4ugrfCthA/0tNA3X9+J9Sot2aMxTHCmf9LaUVEJgyVWooh4owrcd2sYi36vsoG7Zv
	sn3b0nIg=
X-Gm-Gg: AYBFou1mk9Wu3Cy4ClSjXhpOWCwPJk10nEJk9ceGTg8CRymSGKWTntsOat5m7QIDcK6
	CIr6NVxntqcy04fCNxm4c/IUQfQuqjvTSkvcnhbfKFyaCR4v0WrYNQi2+oGW4Myf89iE+eMafyw
	BCtR9aTgxOyAQP1Z0bZcXeWN/Blmqys5MjjV7aWbQ7RG/zeVCBOzTvgcsfiBoo1WGDBO/DR45aI
	ADaGDDflAe7kAP8VOojtbfAsdxYJfRY5k47LaG4fGo1Qg6JgvP9AsfAxGaQAmcjXLi5OX06vDaK
	806TAFEeN4azQMx5+oivZuhpCZI66pM79dS09WYmoQVQDDylQiw3Zpcc2+3ljOE8FptslQ0FjjZ
	oPhfYOIMKYisCcP7oMeg0Xehi8JHkWmTLPt73P92JzLrckorUoGX65bG7SoHnY2ifK//kQqrR0D
	9l3FTeIg8bO6HxuWy3R9Mxfnh7vfNdfly9wRZQ4rjYSXblUzlHxHM5Sfk9sllaIjt3cBVOt7JHK
	6j0UQdoBAEwq1QfI4YH9Z35B2C9PaWH9Q+XAbTsSXyXIAtBTEtl/9sxA9VGx2nOa3YyxS07b4Yl
	x36216vFNoI3xql/0rp9UziAwA==
X-Received: by 2002:a05:693c:41c8:20b0:366:cc5e:5b7a with SMTP id 5a478bee46e88-369e8621badmr832595eec.41.1792796678263;
        Fri, 23 Oct 2026 16:04:38 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm1356203eec.27.2026.10.23.16.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 16:04:37 -0700 (PDT)
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
Subject: [PATCH v6 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Fri, 23 Oct 2026 16:04:24 -0700
Message-ID: <20261023230426.6425-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_160439_853816_8B62E813 
X-CRM114-Status: UNSURE (   9.05  )
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v5 [1]:
- The queue directory is added once the io_cpu selection has run, so
  readers never see a placement that is about to change (Sashiko).
- Rebased onto nvme-7.4, and the ABI entry targets 7.5.

managed stays per queue, as discussed in [1]. A blktests patch,
nvme/075, covers the interface and follows in this thread.

[1] https://lore.kernel.org/linux-nvme/20261018010059.83120-1-saravanand@crusoe.ai/

Saravanan D (2):
  nvme: add per-queue sysfs directories
  nvme-tcp: allow setting per-queue io_cpu through sysfs

 Documentation/ABI/stable/sysfs-nvme |  31 +++++
 drivers/nvme/host/core.c            |   6 +
 drivers/nvme/host/nvme.h            |  23 ++++
 drivers/nvme/host/sysfs.c           |  88 ++++++++++++++
 drivers/nvme/host/tcp.c             | 172 ++++++++++++++++++++++++----
 5 files changed, 300 insertions(+), 20 deletions(-)


base-commit: aaedcff9014876387504a8b92d227766cb95015c
-- 
2.55.0


