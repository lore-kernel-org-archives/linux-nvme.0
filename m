Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF97C25B06
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 03:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s40vcZifCae32J7ieBgmh0tYiaBqJYU2fsCj73QJpuI=; b=K8jnT6BIRqwR3puIx+nQFMAJw8
	5Af36A8C311hGnIrLrox1FN9LE/qPH4WCGpOPaTMMUY0q4Dg5Cu3a25VF0h3W/nGZgr8k37NppTi2
	u2QW14eHA4UquHefcAlDIro2daRJ2TcfPlJpd5c4XmnGrORNHm1zv3hk/Gh80pzcidN6fOzd4O/FF
	uyvePLSRjIeLfgeSaMYgXiezdVgJ/u7f5GnCoFJSiPivOcF0vHhRM16hQpjOvLUci3v3Bxgy4YgaC
	yv0T9pAPxfIb3z6dAfsai8fOzrb5wbPn1Jdckg1Ft1/R6Z2c3YGHu1hFcVe/+yHzLx+akDNt0saiw
	1bb5JB8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oML6l-00BsIu-Us; Fri, 12 Aug 2022 03:13:11 +0000
Received: from out2.migadu.com ([188.165.223.204])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oML6i-00Brag-8Y
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 03:13:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1660273981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s40vcZifCae32J7ieBgmh0tYiaBqJYU2fsCj73QJpuI=;
	b=GDmn1CA9GGgwpDOnbC0pByGdbf4xNkwnplz7R+RW2JPLOBeSORJG2KcHRpoESBYMgygQcA
	RI2JXMhVmv7TcfCADgfXjokJikzw3xMtp8ZXFnWGFypSMb66BNEDYf9LMQnYpuUAU+qaHP
	3MeOtNeCgq2cKv5z4GrXWiRk4aTSgKY=
From: Jackie Liu <liu.yun@linux.dev>
To: sagi@grimberg.me
Cc: hch@lst.de,
	hare@suse.de,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	liu.yun@linux.dev
Subject: [PATCH 2/2] nvme-auth: remove the redundant req->cqe->result.u16 assignment operation
Date: Fri, 12 Aug 2022 11:12:31 +0800
Message-Id: <20220812031231.3386953-2-liu.yun@linux.dev>
In-Reply-To: <20220812031231.3386953-1-liu.yun@linux.dev>
References: <20220812031231.3386953-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_201309_361871_DFDEBE71 
X-CRM114-Status: UNSURE (   8.68  )
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

From: Jackie Liu <liuyun01@kylinos.cn>

req->cqe->result.u16 has already been assigned in the previous line, no
need to do it again.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/nvme/target/fabrics-cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index f91a56180d3d..c1dfdfb92ebf 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -332,7 +332,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 	if (nvmet_has_auth(ctrl))
 		nvmet_init_auth(ctrl, req);
 
-- 
2.25.1


