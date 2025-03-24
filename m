Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E2C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CpwiXx+3j/1WEPJW+AKBYzx8RqMcUJOY5F1DR05E61M=; b=XuT9X5ki/UinG1
	eAq4YqE2tkkmETTT17I9pvVXqhw4Kd4L/wHFIU9SLV4W9RLJEvaJBulF4ZmnBsxYuTP9H0205+Q/3
	pJQSkTdeBrS/m7eXWmliLhZF1EsWsQRNHlDpWQM+RXklXCn9hlaI+HFTNAsHP8qzLBhamK+vkgHmY
	C49HQTcjKfwpU77MbyTV5aw8swe2V9G/SsfE3kApwUd0E/HIURwGMjghNdUVF8V+S1ectsEYELGN7
	Jwfivx3DB07omrD7FQ5AYUCMd4EWVz904cFlVTirVjLbAoREb4Oa/ypiw4lntJMCWUkJ8/Gl23or9
	pGdkQzJAnxXMJsjaGsiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbF-000000031RN-3B6j;
	Mon, 24 Mar 2025 12:08:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbC-000000031Pu-1o0a
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 12:08:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 052DFA4928B;
	Mon, 24 Mar 2025 12:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC7C4CEDD;
	Mon, 24 Mar 2025 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818088;
	bh=OlvIgwG9o9Mgg5UfvrGptadl8cs3cxfK4MQPyE15xoA=;
	h=From:Subject:Date:To:Cc:From;
	b=R/AdqPnFbsDQDqxKjarxWEYEiifG+1lWk02leRhHokxzVCul72FIwPob0bDqlJK3n
	 /NHf06mMN5ElLSv1zcdOTUvNTbMGCiGVjWl6wKM4F+Qj3hOB7t0hA4UNZGVelQp7NM
	 2k1gGiCmqS4hWxEfYnLqVORqgaJ8W+lEWYXzDuQaKfkpXQOXw4kNn8y7z3jUuefiy1
	 mI2I5vBX1uusPzR8+xzw6YNX3N5q5VrnZrxRzfJvL3eZ1G6BxLfKFtgu/V0KPQOw6W
	 bymxIgMkFQAIuGFD3HfRxjWKgrEAMy6fyZplZv4Au7ALpkU6BAUb5Ofx1lMxxv28Pz
	 JbgQ2yLUfqVig==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH RFC 0/3] nvme: add support for command quiesce timeout
Date: Mon, 24 Mar 2025 13:07:55 +0100
Message-Id: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxL4WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3ZICE0MjS91EE9MkS0uLJCOD5CQloOKCotS0zAqwQdFKQW7OSrG
 1tQCt/a88XQAAAA==
X-Change-ID: 20241128-tp4129-a45b998b20cb
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_050810_536373_E17A0C2D 
X-CRM114-Status: GOOD (  10.89  )
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

This is thought just as discussion input for the KATO session during
LSFMM.

The last patch is the interesting part. When commands is failed over to
the next path, it delays the requeuing on ctrl level. The implemention is
on purpose not implementing all the details. Just the very basics so it's
easy to understand what the main idea is.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      nvmet: add command quiesce time
      nvme: store cqt value into nvme ctrl object
      nvme: delay failover by command quiesce timeout

 drivers/nvme/host/core.c        | 20 ++++++++++++++++
 drivers/nvme/host/fc.c          |  4 ++++
 drivers/nvme/host/multipath.c   | 52 ++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h        | 16 +++++++++++++
 drivers/nvme/host/rdma.c        |  2 ++
 drivers/nvme/host/tcp.c         |  1 +
 drivers/nvme/target/admin-cmd.c |  6 +++++
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  4 +++-
 9 files changed, 102 insertions(+), 4 deletions(-)
---
base-commit: 25462bccac81486c2fff0fa4b4c2b1e56751b8de
change-id: 20241128-tp4129-a45b998b20cb

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


