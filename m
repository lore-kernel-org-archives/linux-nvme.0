Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A4CD6EBEE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sIp8+ZbNOh6sg074YaI5HRo2rpbMpG1A9JbcjY5dtsg=; b=lMIAXlhHI00hqYFmfHY6qghYK/
	sp2Kb5lMTdI3zCSXEmRujkUYIXC3G9XSKG72qB72Ue4xetM+rGnY89VaesZLxPdRVr5v4Rm1h4HYy
	UjoM+Ot+lQmY726incNX8cCgq1O3dCkir3dLKAdONLukCWc/jwxYoKahX3UPJxVoqRFuV66gj0Cad
	iN9E/XMcxqZOACNzEpG2XLq/lPGP6dAeL6KM1Ww9Tx40FssLycqldGmhURGB9hw3TImTq+ypaK5iz
	WaBFX+nKPDPR+gpImiVPNduXbqq/RocKxh2ky8r0yy7+GnIAVrhQTWrFKfMTJrJ0Y8Eo9GCeb4neJ
	9LBVeRAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIj-0000000HKfN-2RSc;
	Fri, 29 Nov 2024 09:28:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIg-0000000HKcj-2UXL
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 09:28:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D9C1E5C5845;
	Fri, 29 Nov 2024 09:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB91C4CED3;
	Fri, 29 Nov 2024 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872513;
	bh=TgNLwVPj3jf02aA6QhpO9/SZFpU6FwXvEUCRi1VCNPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VYIU3kTc6tberHp+R6HuYsH0bg3ouyE6ML+V+ahKQwZ8EPCopRnZ/smfIEbnDOyUA
	 FOM95jDoVeqJkaCRAfFPA6k9jLnj5BWIOdZhcAjvNuxmIl/7qsBtUvjyT/MkTQaLY0
	 miTXq7H4EUk7uaJEHwlgINI6rs9cgsRVlQ3jZVeWgBI4YMhKYQK2G7DzHUYXI+rlco
	 RHrsff97JiG1LHD+1t2jYxJoM1rNy8jFWF55rk+XzosSSY0byPtCpoVk/tpsgm1eKL
	 /730dRG7hZJ2VVXDXb5yrJRZWvjKHR7zXqRhsdZn2u0vxhN0NLvtlatfNySvA1iMT8
	 JL4vtk9oK4YyA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:24 +0100
Subject: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_012834_721184_7F7917EC 
X-CRM114-Status: GOOD (  18.97  )
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

nvme_keep_alive_work setups a keep alive command and uses
blk_execute_rq_nowait to send out the command in an asynchronously
manner. Eventually, nvme_keep_alive_end_io is called. If the status
argument is 0, a new keep alive is send out. When the status argument is
not 0, only an error is logged. The keep alive machinery does not
trigger the error recovery.

The FC driver is relying on the keep alive machinery to trigger recovery
when an error is detected. Whenever an error happens during the creation
of the association the idea is that the operation is aborted and retried
later. Though there is a window where an error happens and
nvme_fc_create_assocation can't detect the error.

         1) nvme nvme10: NVME-FC{10}: create association : ...
         2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
            nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
         3) nvme nvme10: Could not set queue count (880)
            nvme nvme10: Failed to configure AEN (cfg 900)
         4) nvme nvme10: NVME-FC{10}: controller connect complete
         5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A connection attempt starts 1) and the ctrl is in state CONNECTING.
Shortly after the LLDD driver detects a connection lost event and calls
nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
state, this event is ignored.

nvme_fc_create_association continues to run in parallel and tries to
communicate with the controller and those commands fail. Though these
errors are filtered out, e.g in 3) setting the I/O queues numbers fails
which leads to an early exit in nvme_fc_create_io_queues. Because the
number of IO queues is 0 at this point, there is nothing left in
nvme_fc_create_association which could detected the connection drop.
Thus the ctrl enters LIVE state 4).

The keep alive timer fires and a keep alive command is send off but
gets rejected by nvme_fc_queue_rq and the rq status is set to
NVME_SC_HOST_PATH_ERROR. The nvme status is then mapped to a block layer
status BLK_STS_TRANSPORT/4 in nvme_end_req. Eventually,
nvme_keep_alive_end_io sees the status != 0 and just logs an error 5).

We should obviously detect the problem in 3) and abort there (will
address this later), but that still leaves a race window open. There is
a race window open in nvme_fc_create_association after starting the IO
queues and setting the ctrl state to LIVE.

Thus trigger a reset from the keep alive handler when an error is
reported.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
+		/*
+		 * The driver reports that we lost the connection,
+		 * trigger a recovery.
+		 */
+		if (status == BLK_STS_TRANSPORT)
+			nvme_reset_ctrl(ctrl);
 		return RQ_END_IO_NONE;
 	}
 

-- 
2.47.0


