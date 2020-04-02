Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67960C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B9120719
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eawrWvlO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK/x1nFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B9120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bsqFZExye/PtWs7/tcuxM1rmzMw6zST7RRV/K7nboCE=; b=eaw
	rWvlOg2Jbt2IoWu4imo+M4awQxuvWUGIDdVBcbq2vdBAhR/Vut038sA2O0JewIzD2/p4vN/nVGdVM
	1ZAqqtvYE2DN0HGyLf3NJlloe9dGODttjjkFy9miaLCeo0OWnd0rRZRYtzhSiY1ZBIjTM+B5tbjP/
	59PH0fJBWW3SIc8+LQ8rS8+BHcpY2gX+Mqjgky2Bf95mMBegRrQytULgzaJsvfF5h7SbRNPegxPb0
	G0SnuivhrpajxQSViRanz6XavgafTiUVXSwd8d4SMucsKHg0H+sbdLWCw2i+KYplyGpBvTqyx17sM
	sqhAFHM2hScZwuJ3R4CbK4avvtjUL4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK5BK-0004kI-3Q; Thu, 02 Apr 2020 19:07:14 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK5BH-0004jj-I9
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 19:07:13 +0000
Received: by mail-wm1-x343.google.com with SMTP id e9so4917464wme.4
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=1/tM/QWwWwAW8oTSHIjd9lVEMMjm04LSx3ao3PWzEEA=;
 b=lK/x1nFdPg8zft+k30pfGC8o9mCqxkNztUe56eGK2iGv1j+NfPOQv6ZoGP5rHp5jdq
 f0CnIoN26gbnl4g7rNguh1b5vTcdZv7U8SxH1BFssX30Ud0XpTf1Hx2Tmz8eQiEhtaJ1
 3xtusXA+s3weOoY9VjBDRudxh68Z0GCc7zftHL9/gcTTM56+kzPviiq/rxZP/xCozvuZ
 7FfkoyCei+SMZ4N8UZ7Nd0k5rwsrmCf8+N/OeE0Z2Vb+hEhcEPTx9JH/5OEvuQMegmtT
 nB1KjNNYFn51j6m3H1UBxhQB7+Upwu5SjYWZKQpfg83L+7UmGgWQUabb6FD2fVb8+DBd
 qfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1/tM/QWwWwAW8oTSHIjd9lVEMMjm04LSx3ao3PWzEEA=;
 b=bf+EUYXqSbtEVSaeyjTy6ZIQo/gEbxo/zg7p5T/tCsO4KhhUjFRydjpqihFbqNOXv5
 ycw7h53yOPVIGd5ARpbCE3jygMBbZKnlt43c+mjZMUl7MnH6zQWIM4EzkJj77DvuQ1pP
 Ma1mwBpTMFFjXqLzGrbmADe0rp4cAsjYJ67wC+X7E+scwoPL8l3t4yqvUPhFIHRd8fX7
 34LsyYgV4FOKnuTHtQdltAg3oaXwEQFnOSm4kXVoJmAvmO2CV8YmllUDdHGr7GK2R82R
 8ibqlwppw4dXIVv03Ccq9UUZM47D/kJ5zLCY/HMLpYcSiZM/H1VpYCDM/a0LPwZRJod4
 wJAg==
X-Gm-Message-State: AGi0PuZofJMHHF6DFaDEXsjlWIhWlddTscc1v7w3wrGbQjKMXwD2i9YQ
 zo00Uy68Hj15Ch4YeCRH/7A5LGLU
X-Google-Smtp-Source: APiQypJ914Gt7UeiZANbmwrd/B3h72xEqyQb/Dx5X7pKPepWIzdxRWDfvYVH1Ryr4x3uGobAtn1wEg==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr5036112wme.49.1585854428347; 
 Thu, 02 Apr 2020 12:07:08 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 25sm3379433wmf.13.2020.04.02.12.07.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 12:07:07 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [REPOST][PATCH] nvme-fc: revert controller references on lldd module
Date: Thu,  2 Apr 2020 12:07:00 -0700
Message-Id: <20200402190700.100198-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_120711_623424_B2307AE6 
X-CRM114-Status: GOOD (  19.69  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <jsmart2021@gmail.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch partially reverts the commit for
  nvme_fc: add module to ops template to allow module references

The original patch:
  Added an ops parameter of "module" to be set by the lldd, and the
    lldds were updated to provide their value.
  Used the parameter to take module references when a controller was
    created or terminated.

The original patch was to resolve the lldd being able to be unloaded
while being used to talk to the boot device of the system. However, the
end result of the original patch is that any driver unload while a nvme
controller is live via the lldd is now being prohibited. Given the module
reference, the module teardown routine can't be called, thus there's no
way, other than manual actions to terminate the controllers.

This patch reverts the portion of the patch that takes module references
on controller creation. It leaves the module parameter so that it could
be used in the future.

As such, there will still remain the issue of detaching from the boot
device, yet needing boot device access to load a new module to replace
the lldd that was unloaded. A solution will be looked for later.

-- james

Fixes: 863fbae929c7 ("nvme_fc: add module to ops template to allow module  references")
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: James Smart <jsmart2021@gmail.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>

---
fix typo in description "not"->"now"
---
 drivers/nvme/host/fc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a8bf2fb1287b..1419c8c41fd8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2016,7 +2016,6 @@ nvme_fc_ctrl_free(struct kref *ref)
 {
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
-	struct nvme_fc_lport *lport = ctrl->lport;
 	unsigned long flags;
 
 	if (ctrl->ctrl.tagset) {
@@ -2043,7 +2042,6 @@ nvme_fc_ctrl_free(struct kref *ref)
 	if (ctrl->ctrl.opts)
 		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
-	module_put(lport->ops->module);
 }
 
 static void
@@ -3074,15 +3072,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
-	if (!try_module_get(lport->ops->module)) {
-		ret = -EUNATCH;
-		goto out_free_ctrl;
-	}
-
 	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
-		goto out_mod_put;
+		goto out_free_ctrl;
 	}
 
 	ctrl->ctrl.opts = opts;
@@ -3232,8 +3225,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ida:
 	put_device(ctrl->dev);
 	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
-out_mod_put:
-	module_put(lport->ops->module);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
