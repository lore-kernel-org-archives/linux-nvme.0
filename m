Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371DCCCFA06
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Xp9ctdrJTnuepb7+nDjK/iDuYp1r6PztWGWHY6lgNk=; b=UauXl5fdKI+UvvBL1YmurY2zsA
	OZnTUsro4DT8A4eftfSqAO8GGMaotWJf3j7JHkU1a3TMVw+Csd2OpcDKQx/zAdxpWo1TopiuZiK74
	CPG4LCU702LtMnDmFjPbr7WxR+j2XYZEilzkoekXj3LJ0SMKBZovcQXS8ewFs2MRAcQx4PLQxoMVd
	YAeQkXyPWTR43nS+r08M1Aci1apz2SZqnu0AssLJoDlKbnyI6dzFqlzc51TS/yuiCsIX7yYEyFp4R
	65+GnYiwqM/nnuhXgbeaJO1tcahD/sviEHOVXdWcHV4NW2wkzVZtyYaLNfDHZq6PXBAoWFvuhJtpQ
	NiHWL6NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAa-0000000Bhrq-1w9p;
	Tue, 04 Nov 2025 11:25:48 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAX-0000000Bhqb-3kPv
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 11:25:47 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b7200568b13so170998366b.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 03:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255544; x=1762860344; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xp9ctdrJTnuepb7+nDjK/iDuYp1r6PztWGWHY6lgNk=;
        b=NOOuez9o7f7Qbr128BiSEREIVVfvo+skQEuRhenHiEF2XuYGGk0nAt8As0Nxa22cwU
         yH5rvVX4h4vEyr/ubUnrtYw18csG6KSCv6+h5AwSFVbBB0AQO0lFlW4zp+2rfqiDmudi
         My0dBXj25m9ZCV9lD/5FsyyqHM5vqqDFW/kuPOp6ZzDJI4P7Jtdav+W9ACxsTg9DEpLV
         0w0ApZsbUJuYl5yIREmwl7KqcEw5ppAcRxz/4+lzevTVlEAZdjLGtoh80pBMRyTkwkMi
         OFpeBLjlho3cJyv9QVLWLljaWHjL30FZkltT/l17s3QTP6HFIXx6UhW4M4uPOMFxZjnS
         G9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255544; x=1762860344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Xp9ctdrJTnuepb7+nDjK/iDuYp1r6PztWGWHY6lgNk=;
        b=YPzFzyM2R83t+aeTq2JfgNBRAjnnCi+4IyEtR8iCfC4FAZFlj3hY3+qgEH94bvFJ8T
         h0aHexRQ1GA5ZkzKghDKAc1StwopucCc3JHE0DtZJc436mJ+6nVtAClkSV+WRyy1Hfns
         2BM+4LbX56RiHwFBO7bTdbMa2m+MqL/MIkryBco16rTIdhTJF5bqJ868ItkYYZCacxiM
         hL4DCPysxeRzLeZkX0mqzXWDQQm4ufIt6CnrZuzJ+4EF33ar/Gg/YpJ2Ty14V4g28B53
         UrG6a7I6Wnoa6i6ztwMYgEahSd9LBpZktTed+EYwH6IT+azaGN6i4Tbj9z3JcX3us7/H
         mfWw==
X-Forwarded-Encrypted: i=1; AJvYcCUMO/1mg673jVZ+mgOGOd4k8EdKhQuP8H1igWLYCA5VxjYZWRvMXUCoeo7DVLRc45ywH8He/lfdW/Jb@lists.infradead.org
X-Gm-Message-State: AOJu0YxwHi/miALcaCh16droN+UZs8WzM0Bp9Zm6OkyY7bjH6sFbBktW
	UEW42y5OcMni5XyCLQE4Eh9wHBOZtJMe61qFT84TM/lQnlqCGw5IPNKhwh8ZzX6mwIc=
X-Gm-Gg: ASbGncvnlgy7EK0Fl0Lw0GIgM308Sk1Q4SmED3yuKiKrlvVw9ZdksSQxa+ZRp7GaCWl
	8uTUlKc+WzIYcZFN5bVmfuR3ZD7SFZmwualoEOfqm/AdpTw36SaJLUIMFb1D0UUkmn7MSUlYorz
	ztO0qS7on2kCE96oXHPuKXncvIV1NQGcZ8PQspYiPCKJ32hMPTBHd3K0/jYxzcK3uMkoUxDRGpB
	ujxiLLMniBLXuMQXpqzkrQc/7wBvd7Q5m5QZeyfy01FEOz82pyMgkbY8fYDZNvYndAzM684y/qN
	3q1tHwmWQnctloZ1GgGHZQWOBJ6tJpFUFj8VEKpBJoOkhHstTkLqjQ259QfcTNskUK/3Dfy1KS9
	nVM2D8DighEeaT7lH56/caWOiDc1FJf5A187/Z/oZNaL1wvpIrTTc7Hay7vRJlKV0qy2DtbfL64
	pNbtE=
X-Google-Smtp-Source: AGHT+IF47+Ru16HFhBx79SrCPlvL4Uj9m+E95mkhvrJKGKHzgU0wubBE57igwdej7VLsMe3wY5redQ==
X-Received: by 2002:a17:907:2d89:b0:b71:c2be:3dd7 with SMTP id a640c23a62f3a-b71c2be49dcmr454970866b.25.1762255544042;
        Tue, 04 Nov 2025 03:25:44 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:43 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH 0/3] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Tue,  4 Nov 2025 12:25:25 +0100
Message-ID: <20251104112535.139450-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_032545_967198_4CE4AC51 
X-CRM114-Status: GOOD (  16.31  )
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

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1] Replace uses of system_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    Because of that, system_wq has been replaced with system_percpu_wq.

2) [P 2-3] add WQ_PERCPU to all relevant alloc_workqueue() users

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

Marco Crivellari (3):
  nvmet: replace use of system_wq with system_percpu_wq
  nvme: add WQ_PERCPU to alloc_workqueue users
  nvmet-fc: add WQ_PERCPU to alloc_workqueue users

 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/core.c             | 5 +++--
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 drivers/nvme/target/fc.c               | 6 +++---
 drivers/nvme/target/tcp.c              | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.51.1


