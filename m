Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A713E98E16
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nV+jaHXZ5H0pVA9k4tp7HLdqRtif45/+z1Z7Bw2P8sc=; b=KjU/D3oefGETJejyRjadYH8tUF
	xKdqmh7O+6fbuGtaKjuaC4FsRlItOgGLkTwUv9CEN1vqJudcYkxjPNosDbnpZjUKphAqNcxITeAo3
	B3t16lojOTzAdizNiwMjVa2TXX1wKls5V/yJCYf4ajFn5hVr3bewEDgaXGvPa8woTNF60k0RJ2jlH
	mqYI/IBAZiXRMIF6OyBcEdzMZ4DRWeHxkthpjQ18CGmnFBCHNNccVDkJjPIzT7HOJBTnjT0KnfVWD
	gQRGiv9/XrhBaUiz5KRsukj6X80xLKnnFtp+lkqPwg7HsfzXxPPB8S1o/DTEOwaIfUbvCfNhT1L92
	EWj1uByA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6T-0000000030n-0rd8;
	Mon, 23 Feb 2026 10:23:49 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6Q-000000002zH-1pi4
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 10:23:48 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-48379a42f76so32085175e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 02:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771842224; x=1772447024; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV+jaHXZ5H0pVA9k4tp7HLdqRtif45/+z1Z7Bw2P8sc=;
        b=JLp80FMpY2ffJqBWQiiul7rWEpoqCCOe8myrohyJU58JTT+TDjzTc0Rqil7LcjQS1V
         wZaKHJawysv9MXStlgEe3AVQj0aZ4Fz6hT24fom1xR10AcaqF7k3lC5Gz+o9HFLTzQ9K
         1s9Tc/S+2PE5WTUUQPSU8MmZ1AvxDEkw2pPzzP/D1to5afrFW7kPwZlO21YIV0rFtqpZ
         VQar7mAKP5ps+rHzEamOuDa9lsYkOJtfo4JCWiuA8wu0unuTDzlNcWkXUcOKZNiyJ6wH
         f2sAeKppB71kjgen8QBNqCc6ZOol9IEHtAuAWYu8dGxRWW6Iekt15ZzmUtmKtFOgZ3i9
         9XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842224; x=1772447024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV+jaHXZ5H0pVA9k4tp7HLdqRtif45/+z1Z7Bw2P8sc=;
        b=XlVjIgg/zK3Rtc4zL3ZzFGAg30gq91tLEtGBbTYtYjhicyAA/uVQ6kF8epKMcYNaT7
         +IieOLI0UUNN3NvwSBfVzAytXvd6H43yECz95O56mTyxNmj3jgndhLJQoyfdOg37wSTw
         Pfbtt6HCpEQH/ofT51T4cGfzb0jWWQvpGKO2ElVBvTqxJy/f3vb56FKogY8F6ATfOhcc
         aaM6xEYiqzqg15RPaGfPj/u7i7SJWi8d5AE/YWQuAzijASolxifhtdgDTvI9gkZBrGAp
         OhFwW87p13TIr23GckSr6mKttdqP/3+4JVPztLE+xaoOjohhntvWWlqG21hnxleYoT8U
         qbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKZ7QUUFh6api5WnrB6AQTZcoxpsOunm/7bJ9rYHdu+1u1c6gyAkpphmmTAVCXKpcaVi93J27+3Nga@lists.infradead.org
X-Gm-Message-State: AOJu0YzBjrWh9cxzr4nacGXp81KtabXVHamuAXujhkBj4AqnB3dIa+lh
	ECh6KygRozSOFRpqG6wJvAWGDRt9fGeOBFAQC/jb5Vgna1u/+vCj55SBH39SCzZ7zCI=
X-Gm-Gg: AZuq6aIT86y08nTr+yp7/TlyStUS5z5fhrnNFRir9QLhHtoHslrgE3gtm3qiRhrOxit
	nAzRJCUuSYTt89rTvmLzkVT0TzMKuUDQtrGjj9A4zuhYDlPZl+EzBHWxCn+wHG1q0xPlzLfPZrg
	ivAPL+BLKtB1wU2BRxz5ofCZLMtwnMMiK0oTTI3WR5StgBWiMQErrdKgfthJTt9bMAx3xhn+NSD
	+R1oYytQTKUHufo0nLW5CQKAlpvPVp4oZBpm/2LaT4NOWaw4OOC1wKtLGpNBSjHU3qB7HswO1GV
	D2fWH1OMOTohYNbNWlXmG5x8JPlaxZde/rh9iak+W7zZHbbbscOoVTOBnY56ZHE1eHv/K43M5Hc
	2bjaGWdnNpU//7In0eZ3u9/hZKDr+yF5Nq+MqWrLBIcYQjrLQ/mAsjySSoO6MwgFa2tgDybTN6j
	BlZWHHEnPIm9THaRcYMXJKF5eAJdatRNMUycnp0kM6wStC
X-Received: by 2002:a05:600c:3d87:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-483a9635c34mr112627865e9.28.1771842223876;
        Mon, 23 Feb 2026 02:23:43 -0800 (PST)
Received: from linux.fritz.box.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm237342465e9.5.2026.02.23.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:23:43 -0800 (PST)
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
Subject: [PATCH v2 0/3] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Mon, 23 Feb 2026 11:23:26 +0100
Message-ID: <20260223102336.108512-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_022346_494959_48FC4035 
X-CRM114-Status: GOOD (  16.14  )
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

---
Changes in v2:
- improved commit logs

- rebased on v7.0-rc1

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


