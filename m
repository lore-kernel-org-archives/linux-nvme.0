Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BBC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 13:39:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253BA61077
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 13:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253BA61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qdDKJ+afmB2DYRbEED+Im2yVX/bQPJAtpNpuCUudgM8=; b=Wv+9W2bYYxKZlQjE5fs6DPUM9a
	L1hN/bFrzCASLuRqlMSSYt63Xm5vswQtOkwM2/66xq6jzkNRrmyn+gmuUnkCTzvp7RJn0JT9kwgCj
	WOntXBjanWt1ewlnpE0kQwDQmy2lWFxlOm6LWUlcHIiuv/sEXMxTS12hXjN9iheWg6zbdQUvaWAO7
	SWKKQxxxetGyXzamhz889OKKFx4SULLjVNvr/2iOOPwEASO1lMU461eGWmK+3el+Scp724shuUW/8
	RkGb+BoNPubcYYxBofGbC1yp0rW97XbggOZp65OcQGurh5EUKGrHDBteLuqpRdPG5zOx6pgpFVI+F
	Y5FQJ5Pg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZw1M-001a6s-6J; Fri, 23 Apr 2021 13:39:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZw1K-001a4s-2b
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 13:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=8ukLQRnaxWXtfXn3D3mLNPe9undWkhyXto88iC388HQ=; b=jhfU9pV0S6hre/ezcRoCaojEgS
 3hIWheJoo3dGd1f8uzrsw5VP1J5x91pHysjYkTwXQZaWouGTsRYEyjqF2yKcMCf6sZnDp4Lf9M34R
 MkDqe4jL68+JzDpZ0wp+bQftz7avL3Ss8qaq//bhuPkNh2GGb1W+UvsmkLedH7wI+V7EgTnMbo2Na
 ajy0x8onjZ1XHz25hZx+6CO81wvkuqTY7+S6X1Z4olkxNSGQpFzSXvQ5UR7Jy57t0vkj8hkIKQepu
 Nbuu0rON35yBGMDsrzJEMfgVPW+DL01c4mtthNbDHY9FMoqsoAsFZna7ByP3F90pi55lCXgMx4kWO
 C7DKHTNQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZw1E-00ERUA-H1
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 13:38:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619185129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8ukLQRnaxWXtfXn3D3mLNPe9undWkhyXto88iC388HQ=;
 b=WIS29oNBsAliJLadPIgur2fShDodIikH/PE098YJbJpNENoIFGbuXgXOvkuOBUmym+t8zm
 Bv39DdG9Ke3gVItErNhJLJxWkeazKcRYBUFjbC3UHq4xxUEBXxXXqpaiuawMGa5ohxXrFn
 m/BRozkjyhftPLuVP/FO9d8JgQufO6Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4B902AF03;
 Fri, 23 Apr 2021 13:38:49 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
Date: Fri, 23 Apr 2021 15:38:35 +0200
Message-Id: <20210423133835.25479-1-mwilck@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_063852_889569_E10A2CBA 
X-CRM114-Status: GOOD (  15.45  )
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
not the anatt timer.

I admit that the root cause analysis isn't rock solid yet. In particular, I
can't explain why we see LIST_POISON2 in the "next" pointer, which would
indicate that the timer has been detached before; yet we find it linked to
the timer base when the crash occurs.

OTOH, the anatt_timer is only touched in nvme_mpath_init() (see above) and
nvme_mpath_stop(), so the hypothesis that modifying active timers may cause
the issue isn't totally out of sight. I suspect that the LIST_POISON2 may
come to pass in multiple steps.

If anyone has better ideas, please advise. The issue occurs very
sporadically; verifying this by testing will be difficult.

Signed-off-by: Martin Wilck <mwilck@suse.com>

----
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
