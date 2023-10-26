Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F5DC25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qg8xenpWV+v5VQuCTbPy80HRMo47tpWqPdmDb0kVSN8=; b=FW7lsXPNo2wthv27xHx/mtShEV
	Je2FnOWifpNDybZs1RmK9bE8I35ALJr9cFjkPQVyKFMDUxD9tN2/XeHcHTDbE0Xw7XAE2G9uz9wzD
	PbQdE2SNZlwj+ieYCuUQLoEj95e4xVQsDHlm+t2XK3ygWhu1xFL27BTeXnLfiLMKXp0xAf5s2G+Ys
	YQ4MaCq6ZNyXfVxa8ZDHn/2ciR6zTfz9YVYrF+p+tF+/15dPsY8yvCf/hEVc2gtnI5NNBnfPpcLKY
	/Ckr59tPC6Q/I9auKeGH7zr+8D4x3E5QMD5hVChAxFASc+8zhiXRI/eJgEmKMiXJxPWGWbk3VgDga
	h6HgAdMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw2IL-00Eo0P-0x;
	Thu, 26 Oct 2023 15:29:13 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw2II-00Enzi-2r
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 15:29:12 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 88EFD24002A
	for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 17:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698334146; bh=H64qUyJiele93axV3rB3BVXjSk5GIMWyc2Mutlt6LLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=PpyfEGVH22Gu+tpAxSQXOPSj556OPsPQV3DIadsQDbDG226YkoPexZurUNJIGzgHa
	 79vfltvsc6QBRvPLz+OPYpDLmXq4h7cFqFs5YZyrUyLAlHCf1YL513LRsEFApuUsWK
	 kXCp/+l4UdqS8/X9xpdwisxQsawxKSlyR7aylWYOxoQSh6jIFVKfKnFPVxxfzNyZjE
	 UCyKD2CGfyQIFV3KKjPbwgZcA2HBwsQPFxnh/Se3MnYxqxrBajiBITmhFbNsT8Cm6E
	 Uz2EY15Ki77Yqg+Ac0YgdCIURJIcidT+UxZKUHF1GZhjblNwysvkMdOc/rtYnrUVpM
	 +ym2OeADlpIPw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SGV800Z7cz9rxN;
	Thu, 26 Oct 2023 17:29:03 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] nvme: fine-tune sending of first keep-alive
Date: Thu, 26 Oct 2023 15:28:57 +0000
Message-Id: <20231026152857.176594-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_082911_100047_E38BC870 
X-CRM114-Status: GOOD (  11.63  )
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

Keep-alive commands are sent half-way through the kato period.
This normally works well but fails when the keep-alive system is
started when we are more than half way through the kato.
This can happen on larger setups or due to host delays.
With this change we now time the initial keep-alive command from
the controller initialisation time, rather than the keep-alive
mechanism activation time.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e..f3ca3e1d4a74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1192,8 +1192,16 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work,
-			   nvme_keep_alive_work_period(ctrl));
+	unsigned long now = jiffies;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	unsigned long ka_next_check_tm = ctrl->ka_last_check_time + delay;
+
+	if (time_after(now, ka_next_check_tm))
+		delay = 0;
+	else
+		delay = ka_next_check_tm - now;
+
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
@@ -4451,6 +4459,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+	ctrl->ka_last_check_time = jiffies;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);

base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
-- 
2.39.2


