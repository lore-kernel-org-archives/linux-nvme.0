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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0925C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B241120719
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5NKgGl/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPKLoH8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B241120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uj5jhPtCZHj7rOq2FKQUtjDdoNWnAfskvdlTUlj4ayI=; b=c5N
	KgGl/sn/1CdKs1hD3sVV5saJYe6NuIQbZmH4ZDNH7BBPcUOeEE71HF7UicstwRNfkl/RlzAEUoRbk
	+bD2Qw7OQNtZf4eCPbaDyYQnb4q18nPWOozP5ixwxp8OZGMdnIUhlzlHxSaekuLmXedaE/69PGYdX
	pAxDYxLbAjG8rgORCuRlmaQ7pJ4Rq1o8UcEU/Hl1fXKgZ1fJDlDgMuoYBwzsWJ6GoJ+Awixd9+uGb
	tW6t2pgUJCe7qdRUQhyUF27ae3Lts1x5wqZslSXIjx0A+zpyHoGU7ltorTOJDao2IZcLi0haYEe1u
	HMOD3PYDOmsI18jHYHQhKuWewkLgj7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK57d-0001eT-V9; Thu, 02 Apr 2020 19:03:25 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK57b-0001e3-6A
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 19:03:24 +0000
Received: by mail-wm1-x342.google.com with SMTP id z14so319528wmf.0
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Xqfqaao4MLLH+J6dNDM8nik5DOhFY8K5BbIRbAOhXY4=;
 b=uPKLoH8rCamTkls3Qh7rB/N+6FIZ8E7X6N8oYyaHgYG+xdbu0e5aNyb2yA4meGLZ2n
 fveyoMrTi5v84FEBd8QSqYtXHSODVsc4KYS6uXKJm3oXUOEBdTPhO637vYDe/KODJ5ke
 Bq+lzppuAP9TB8ajiSCEyXt2majhx7X+ELl+UG8ELqJem/KO1Uh1rkX0YnUdUlr38pOI
 XBuZxgjPI63muISSzTVgVqFnYqF8K7v+TumuMURAU4HBFcIH0aPHfvfcYDTFF6KMCTHR
 dXZaOy+mYKye7zXWGhhA8ONkNBEihBiXQvLfKmgu2I6bzyCpNNkjSJeSWnCWWzvLcFUJ
 FQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Xqfqaao4MLLH+J6dNDM8nik5DOhFY8K5BbIRbAOhXY4=;
 b=qCR9nTmuVpQaLDGx9tqLSgIrdFMGd95TqdaUdPbXbw3/mWEP3IDNfT+1ATOV9apnRL
 ip2f74qadxXEEtrOlC4FfHFVe6HH2QUof20+qopjb5Tr0EFBXRVmXen/u2Z2BLF6QZXo
 T02a9e1iJ19kQ8UN9/AvVgAv1XrS1ob5hSlEZNkdRuoeF2CJdy0n2TmwRbn61WsvkjKb
 Equ/gtTRNHz9ym8zuR+0Tq9FiyRZ6UKfY9aRoHPQfB+l4mIRay6Wr03ALIZNpBrx+A0d
 L9d+mVuXB/jD0XL0VrEffVIacW43nmUmv/w1Ff0lNcQulevwkXHUZ8wxaLUyRJnzPfoO
 lijg==
X-Gm-Message-State: AGi0Puaiu4xTuT7/VZr5YGa9rLDHaQAt/lWJY3YpFrZLo13ahrRamkcF
 efBWx+JJSYOikmw3tnOMpIVtEnL+
X-Google-Smtp-Source: APiQypL2bysbkxyRiwXuddkacIKGHko4KuT2q4sEcBZ1mPMxhjYpzIJRB2WNikNLqb2WWs8u4Ly1rw==
X-Received: by 2002:a1c:4b19:: with SMTP id y25mr4713388wma.70.1585854199976; 
 Thu, 02 Apr 2020 12:03:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id n2sm8905315wro.25.2020.04.02.12.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 12:03:19 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: revert controller references on lldd module
Date: Thu,  2 Apr 2020 12:03:12 -0700
Message-Id: <20200402190312.88868-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_120323_225247_4CF3A306 
X-CRM114-Status: GOOD (  19.87  )
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
controller is live via the lldd is not being prohibited. Given the module
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
