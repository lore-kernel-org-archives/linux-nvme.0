Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D5BC43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eGrEVfWuiUn1zMfbU97MILYLtaNj3YKDdmISgqE0YpQ=; b=PR+d03ny9YM2H+DSGmiKa17nJu
	k7U2zpClk37fv31DwVjBONMQC0TkvRNmUmQMNNdT/NztDES5PQ9f0iaftzmmqIi3kdG8x/b71OQAf
	0xATlXunh+dKEYApnTrWM/xRhLFEcZFxiekwfDhu/nUnEXgctIGOQUWuhrGILB0e4sEGv494XNGao
	wgE9ppP5C/hHsYGXtLUuCKQ6TB8nEefrCzZ6MThIPzFXWAYdmcQgGUNoAPcOm/M+cGrlw6Mh3pzIq
	MYu1OcqctMNQLurkixw8RDzCSnXxhTpE2QICS4+FyPWfCfEhrE8AN11n7fmLnUanh3W414mSWLQFJ
	BBUydaiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdSgc-0000000CUJC-0q4R;
	Sat, 27 Jun 2026 13:03:06 +0000
Received: from mail-m10154.netease.com ([154.81.10.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdSgY-0000000CUIG-3XKy
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 13:03:05 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44003fbc4;
	Sat, 27 Jun 2026 21:02:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [RFC] nvmet: clarify RCU-list traversal contract for PR registrants
Date: Sat, 27 Jun 2026 21:02:39 +0800
Message-Id: <20260627130239.3365628-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f092ce45803a1kunmf5f758e9d04aa
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0tOVk4aSRgZGBhOTUgZGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=h494R+VULXmTAxZenTAPF+vcZazeujRN2kDd0Vg3t7fGE54I1v0/k8L1hZp06oDvDd6L/O25anbND0OO0UkvTUg/SMy+Xf9dtYfn/RxfNcSPjGcV0aHZ3miNn4rybQnP8vIFl6vK8BBVD9hhkwCwfoG6qVOtpzY/2vuzZAhKZYU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=eGrEVfWuiUn1zMfbU97MILYLtaNj3YKDdmISgqE0YpQ=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_060303_511076_CB9D4F22 
X-CRM114-Status: UNSURE (   5.56  )
X-CRM114-Notice: Please train this message.
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

Hi NVMe target maintainers,

This question comes from a candidate found by our static analysis tool
and then manually reviewed against the current tree. The audit used
CONFIG_PROVE_RCU_LIST as target-matched triage evidence; I am asking
for maintainer guidance because the source-level review did not prove
a use-after-free.

A CONFIG_PROVE_RCU_LIST audit flags several persistent-reservation
writer-side scans of pr->registrant_list:

  drivers/nvme/target/pr.c:299 nvmet_pr_unregister()
  drivers/nvme/target/pr.c:362 nvmet_pr_replace()
  drivers/nvme/target/pr.c:677 nvmet_execute_pr_acquire()
  drivers/nvme/target/pr.c:788 nvmet_execute_pr_release()

These paths hold pr->pr_sem while walking the list with
list_for_each_entry_rcu().  Removals/replacements use list_del_rcu() or
list_replace_rcu() and release objects with kfree_rcu(), while true
read-side paths such as PR report/access checks use rcu_read_lock().

The audit did not prove a use-after-free.  The question is about
expressing the intended API contract: pr->pr_sem is a struct semaphore,
so adding a naive lockdep_is_held() condition is not an obvious or
necessarily valid fix.

Would you prefer one of these directions?

  1. split helper usage so PR writer paths under pr->pr_sem use ordinary
     list_for_each_entry(), leaving list_for_each_entry_rcu() for true
     RCU readers;

  2. keep the current RCU iterator but add a small explicit RCU read-side
     section around the writer-side scans;

  3. document that the current semaphore-protected writer traversal is
     intentional and leave it as-is despite CONFIG_PROVE_RCU_LIST noise;

  4. use a different lock/annotation pattern that fits nvmet PR locking
     better.

I am intentionally sending this as a maintainer question rather than a
patch because the current code appears lifetime-safe: registrants
removed from the RCU list are freed with kfree_rcu(), and the writer-side
operations are serialized by pr->pr_sem.

Thanks.

