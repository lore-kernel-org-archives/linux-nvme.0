Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F657C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B076820720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HrSD/uTz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IsMeJ1IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B076820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FiJjOGgu69nKYWQ3DSTYn0SozEo3GbPpLj1tXbnU4BY=; b=HrSD/uTz5dCaxzS0T7I0gS/Di
	ZVfegJaMJCZq0HQnOEqhtOWf/0J2ffvpgO4TPGmm4Klnj2laK+C32G6zO1bMk7FtkuWT9+oFI9ude
	raEEHFUC4Jc5/RxHftHoh5JP1s6LoqHAnvJ47R3SzrLbtYZrbA7i5wKKJd4WFa8ZLCiSaNJ+Fpr1k
	iwnEMGvujE7KbXBepj7YAS6smRRGK6y6KignEtDBbSD7u0dNjwV+6oeGd2fPr+ZjFdm21UigSIqVK
	B8DaINCeGQ7o6Iq1Lky95OWqFvzL9yvndbbJZm1wPngdb6gLI9myCNbXYWhluau6KEynnDnOCFwHN
	a0RvyDe1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeO-0000EI-LH; Thu, 29 Oct 2020 23:48:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHeL-0000Cs-Lq
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604015289; x=1635551289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wD0nXdzoZGCqncahkM+IkBJvfBVCogZeC72JEvLtCu8=;
 b=IsMeJ1IPTf5A8q7IEvZNcTZBZpZkhhCOa7Fxxe8HWQoJ5vf8FW0qBVTR
 eqV5fQd0a67EzhVfTn9mYis162BFeN1WUokY5aW8ewYknjg2eXX9PzXiT
 50u9Czm46FQv66K8FIBmtBo4V+pVj+K8i9ORsRLFb5fl8+Mh9tCObSzct
 nDTExbTNIm9nzathAaVl6Bl+ASaxbH6Cg8coZuibhrU8/ZMhJyKfzqMMy
 3hugG+fUW9h0x59NQGI8BrtGJRc+Vez3bcUseE5bg/4retquIzym5MPiV
 n4DhT+6d23XpxjeLQR09XDCLfvaEexeVdQ0lApidZts6vCwRW6DO5k4Os w==;
IronPort-SDR: Nf0JRo3lIzou6pDTrS97JharmB0njYTEw2T0ccfTOeFoEH0YwaN4Xf2aXLmDt4avEV77dmXSbl
 mdz92/qD7RV+KeRgkvrB+TdKUezwGs7UF73cZND6ciOY1igSHyUa6oEYYXliI/ZrhCsgeMP0Mv
 RqcQCVOpeI6Bdux3iZbeH4xoX1HkxABuUyV34WaesgnG6S+oQlndrT8YBKOqPfhaGIk4QZKfkG
 /3mwX4y+WjO00+cF1jgi45FSNtoXkcluVXsVzM3dkUR+LtKoHr73d5kxv8zsa/7bY0IjdUQ0SF
 8w8=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155731997"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 07:48:05 +0800
IronPort-SDR: hDgvv8Z+uyGmtWPCFemC4s1qhj+3QRF5Pex2SJde/+whHkSN3j0AaSJpyrWH9rG9CBMQOY3VUj
 ocde0PwaGZw4vJghxnfBm6qRzP5lHKgUSwxJBL5/DjbOp/q63+Yp/mP5XjF0BHQWFvDtSvhVq/
 yhu2LzikyJmdAG7SasTb1ZxIdZvC2UoSExOj8xOLz4FkT4huSUWgGxfruCD58Xj1JDg1fJA8/V
 5zrBBacAIsgxTakVALu/hVF+MUdEnnNHx2YLPvjmR2G9PuR2lpZWGK3TNl4uGrqznO32/ivkzs
 N5DJjy9I+Fox8/k3Ir9t4RBl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:33:09 -0700
IronPort-SDR: FB2v2kKEonlu5FBBlJRkZ44GlblGYgOIfdYW2Qzw694Df5l8TJhzOOVtz+XgsfKsnTnEIaRUWQ
 5uaIhg6m0RqOPcZrHDL2ZZCoaTrkkef4oR17TBBkFkNukQdJXyQLjxQ1IIMtP56HTA81BU7j+h
 q7eCZ1S8tNruPCKi5/WQGuAntrMjkBA5SZcLmzIwL2Rx5JYnDCSsbsFIhwRzZrIRBo35QeGgnA
 L8Po8omTWYch52Mlef8KgrURHCSX5UMpwl9BgGzl+31vCYw6t4emDz59B/Zb81fEWcn5DVObks
 25Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:48:04 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 3/7] lightnvm: use I/O timeout in nvm submit user cmd
Date: Thu, 29 Oct 2020 16:47:35 -0700
Message-Id: <20201029234739.21266-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194809_866665_A70EA2AB 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_nvm_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value which sets the appropriate I/O or
Admin timeout values when caller doesn't specify the timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/lightnvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..784be80ee2f9 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,8 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!rq->timeout)
+		nvme_req_set_default_timeout(rq);
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
