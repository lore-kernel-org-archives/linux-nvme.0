Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAD6C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v4IKXEmO+c9E9pDEhk5E1O+oHBC/X+a2xPdoU7xQ4LM=; b=qp1dbEJPbVeeD9WsZAqL3tecGx
	IlZzDWMBzHeSKrENxYwhsSfR7OWTh5gU064OIu4Ok6pZ3zNY/R8N1a8K/n61jGKO5ErpPNUI+zyuS
	k5nPo236nF5dZb3XLJirLt/lUWWGREbLuIiuJzPTVO8/35scorFCnrRcDjNVDwgw/ltBnu6Om1xzg
	gZ44odYMh3av+HqtKDGXwGpawTVKdtb5dIBSyvImcXAWygOyXhXeKRHkK5UaFKbdecrAa3iiCWWua
	/iRn6anVByh3sVr950bnrplIZmuldpt43r5fnu/BPxw8PudaVnO68Z52CmosVvM/pqZF1iH+kAxDl
	1FwMIf4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaMC-00FdoP-18;
	Fri, 08 Dec 2023 12:53:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaM9-00Fdo3-2R
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 12:53:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC85E623A2;
	Fri,  8 Dec 2023 12:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20447C433C7;
	Fri,  8 Dec 2023 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702040004;
	bh=7qUzub0kxQN1EP0csgYsne8KEvbiHf9s0wWZl7E4SX4=;
	h=From:To:Cc:Subject:Date:From;
	b=uIm3X5UwUL5O/SFGuBH9E7lJZPeqWQXoIZABzxkzVYFVzDAK2QGaHEKYVEG6i8FYN
	 P3mcWzGw+OH26hhEImNrQTO/tzbjZdllR6fMAh5ylna0OJmt+ggi5QubB42oOGd+sn
	 kgiA1wHiC7rvNeMHk9saVmclvTh0vzmdk9niZIiX6J2mVGd9DbqZoYdJ7J+JHs8tpe
	 YxGYy99d/wH9NmQuUOPQlVXlH0q77vuquYoAAB/apoEmVD328R8DnMf3FSavKYdiSW
	 8evrfj4+V2v8votR+4lVK2klMrYs3l6DJq8QPwtmvZxxglMM8C105ZyUbm+i4sREWp
	 l3iKgegJbmeXA==
From: hare@kernel.org
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/2] nvmet: avoid circular locking warning
Date: Fri,  8 Dec 2023 13:53:19 +0100
Message-Id: <20231208125321.165819-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_045325_857410_16DD948E 
X-CRM114-Status: GOOD (  10.37  )
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

From: Hannes Reinecke <hare@suse.de>

nvmet-rdma and nvmet-tcp trigger a circular locking warning when
tearing down; reason is a call to 'flush_workqueue' when creating
a new controller which tries to cover for the fact that old controller
instances might be in the process of tearing down.
However, this is pure speculation as we don't know (and don't check)
if there really _are_ controllers in shutdown.
And even if there were, that should be short-lived, and would have been
resolved by connecting just a tad later.
So this patch returns 'controller busy' if we really find ourselves in this
situation, allowing the caller to reconnect later.

Changes to v2:
- Implement backlog as suggested by Sagi

Changes to the original version:
- Update the rdma patch to implement 'install_queue()'
- Include suggestions from Jens Axboe

Hannes Reinecke (2):
  nvmet-tcp: avoid circular locking dependency on install_queue()
  nvmet-rdma: avoid circular locking dependency on install_queue()

 drivers/nvme/target/rdma.c | 19 ++++++++++++++++---
 drivers/nvme/target/tcp.c  | 18 +++++++++++++++---
 2 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.35.3


