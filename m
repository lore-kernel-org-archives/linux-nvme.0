Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C99C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:32:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C1B6100B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C1B6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OosxTkd2lu7HqPv7eZiJg5C/l4lbsLVT+GcyumOxMVM=; b=NTe3R1/i6gKcEJ7sCgSmSCO50G
	j7qcTQnbE8IRQeNNVzT8FAGHMoYx5Ng4VU8XbzCGHb5rwvsXYZATR16ZGhngBRbreG9zL9MGbz1ss
	XBOZRBf/Jiho0Jvhz0PaqdrR924yqeyKog2mvYxkcRWC1xthn3LFlhX8BpSqBuA3g5yXKSmRqUXmJ
	wZVt/75H/pU2t/QUOHDov0NJHW/jMwx05NVmE5aMlj1S1NYem41h65zFZ3U3nDAXK0ogulNpqsVa0
	ig0mjWDLeR6TKaCXIgl2nRGf+CI0gy1t4etOsg0i3wxqk6GVN1w1fW2Nhs62dAC/z/m/TYyl1foup
	u/mKD6KQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbK4N-001EAZ-6u; Tue, 27 Apr 2021 09:31:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbK4K-001EAG-C7
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 09:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=dq8xvoiQYVgM3UOKENRARpfRaj5alyyZsdLug8PnLwM=; b=LE7pyg58nsb4qCLEmMkjvpLiFB
 Ue0vyRzShGJJKMYS7BtHaTccwV0I2pP9gTfHahI5irRlk1NEsr0hLge2TXS7+GAj87PXTratY1XRb
 lmQ5ee9nF6ZYSMxHtPZSChRYkIMw4Sc9p3Vs+wZioxA+VxRGmv4hY611RMY1oJhPCWo6qFfiaQjXl
 qgD0v7wx7Bxyud1maUrQBO8fKqEbSXexP3bFLWJnkKfTbhnqfr0f8Vq2GXg76zC9uQvJOfbXVKXhc
 nZ86ONd50LpLK2QDgVCI6Z26nVIFbwcRsZT2u7Teq8WsgEkis8WhFBzSe4FlGSvJV+hH+Vmt0D6Rp
 1x2BCC/w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbK4H-00GaFP-3D
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 09:31:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619515903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dq8xvoiQYVgM3UOKENRARpfRaj5alyyZsdLug8PnLwM=;
 b=MueakfsLqRY/FwzbUVHI9oJIGEJkbTILkwBiKfvtB7ha2Es+t4afybOJ8+P6FFbtilTmyR
 iaKFVE3p8LgYH+fOXoUPxVMR8nSWrO6xKnplnQy0jY4iDYCkymWAWI9uvaOCEJbccpEadU
 feVD7shGcn+xUjrOmn4bCFCY6wlpGvU=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 25F89B124;
 Tue, 27 Apr 2021 09:31:43 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 stable@vger.kernel.org
Subject: [PATCH v4] nvme: rdma/tcp: fix list corruption with anatt timer
Date: Tue, 27 Apr 2021 11:31:10 +0200
Message-Id: <20210427093110.16461-1-mwilck@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_023145_455829_694D7629 
X-CRM114-Status: GOOD (  14.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

We have observed a few crashes run_timer_softirq(), where a broken
timer_list struct belonging to an anatt_timer was encountered. The broken
structures look like this, and we see actually multiple ones attached to
the same timer base:

crash> struct timer_list 0xffff92471bcfdc90
struct timer_list {
  entry = {
    next = 0xdead000000000122,  // LIST_POISON2
    pprev = 0x0
  },
  expires = 4296022933,
  function = 0xffffffffc06de5e0 <nvme_anatt_timeout>,
  flags = 20
}

If such a timer is encountered in run_timer_softirq(), the kernel
crashes. The test scenario was an I/O load test with lots of NVMe
controllers, some of which were removed and re-added on the storage side.

I think this may happen if the rdma recovery_work starts, in this call
chain:

nvme_rdma_error_recovery_work()
  /* this stops all sorts of activity for the controller, but not
     the multipath-related work queue and timer */
  nvme_rdma_reconnect_or_remove(ctrl)
    => kicks reconnect_work

work queue: reconnect_work

nvme_rdma_reconnect_ctrl_work()
  nvme_rdma_setup_ctrl()
    nvme_rdma_configure_admin_queue()
       nvme_init_identify()
          nvme_mpath_init()
	     # this sets some fields of the timer_list without taking a lock
             timer_setup()
             nvme_read_ana_log()
	         mod_timer() or del_timer_sync()

Similar for TCP. The idea for the patch is based on the observation that
nvme_rdma_reset_ctrl_work() calls nvme_stop_ctrl()->nvme_mpath_stop(),
whereas nvme_rdma_error_recovery_work() stops only the keepalive timer, but
not the anatt timer. Also, nvme_mpath_init() is the only place where
the anatt_timer structure is accessed without locking.

[The following paragraph was contributed by Chao Leng <lengchao@huawei.com>]

The process maybe:1.ana_work add the timer;2.error recovery occurs,
in reconnecting, reinitialize the timer and call nvme_read_ana_log,
nvme_read_ana_log may add the timer again.
The same timer is added twice, crash will happens later.

This situation has actually been observed in a crash dump, where we
found an anatt timer pending that had been started ~80s ago, despite a
log message telling that the anatt timer for the same controller had
timed out a few seconds ago. This could only be explained by the same
timer having been attached multiple times.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Cc: stable@vger.kernel.org

----
Changes in v4: Updated commit message with Chao Leng's analysis, as
suggested by Daniel Wagner.

Changes in v3: Changed the subject line, as suggested by Sagi Grimberg

Changes in v2: Moved call to nvme_mpath_stop() further down, directly before
the call of nvme_rdma_reconnect_or_remove() (Chao Leng)
---
 drivers/nvme/host/multipath.c | 1 +
 drivers/nvme/host/rdma.c      | 1 +
 drivers/nvme/host/tcp.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..c63dd5dfa7ff 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 	del_timer_sync(&ctrl->anatt_timer);
 	cancel_work_sync(&ctrl->ana_work);
 }
+EXPORT_SYMBOL_GPL(nvme_mpath_stop);
 
 #define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
 	struct device_attribute subsys_attr_##_name =	\
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index be905d4fdb47..fc07a7b0dc1d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1202,6 +1202,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
+	nvme_mpath_stop(&ctrl->ctrl);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a0f00cb8f9f3..46287b4f4d10 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2068,6 +2068,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
+	nvme_mpath_stop(ctrl);
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
