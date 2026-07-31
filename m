Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A6CC55174
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRyPq82Qz7kXYeMXwznAmoBG2BF0hv/waKNYLtjGwfY=; b=xzsoRT1ntW5U8KhoMMcQIj3SpO
	fu0cK/1C3398xXgpa7xaorOOr9IYzJT+zVNbAq6xI9ohoH/+Ly60c2wv4YYPmL3O8SGhNN1nQTd9R
	8OnZx5Ss2fC1glrfIwU1CZVHr/VjdFP4Kl9uf2To8ZlpgE3cLP5DinEY2UA9gc9XAJOStryiaYvaI
	AvQDdt3jAkM0DhwiiVkEiHwYQpurT64GdBHLQpY+c2eW12rZNVjoMXY7wiD6uY8eVrGoMd+uCLUiC
	9l8CVibaV52GOpQh20W2ZstmK2MYOB/jGvX97LtUR1zpUIiNg3psiRN+3eJYog+ej3/zsNjOn6i7Q
	s+IEWN8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnl-0000000BfhX-0QLq;
	Fri, 31 Jul 2026 03:20:49 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnf-0000000Bfeg-2ZQ4
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468039; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IRyPq82Qz7kXYeMXwznAmoBG2BF0hv/waKNYLtjGwfY=;
	b=HJinzUftxgwAB0R7n8WKkYgt3w6PXon0CupgEkSSfrPYB06pFA9QEta4GcRSxoKzkg/Z91/12AGb5/yDjnZsl8rsRZp0+mgOu5mpo8B8QqpjpvVV51zEqMp8ipn4uHKupajHU/MId58DetgrqeeINkP7NSFGWjHD+94lOqgcO2o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86jPl7_1785468037;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86jPl7_1785468037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:37 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/5] nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()
Date: Fri, 31 Jul 2026 11:20:27 +0800
Message-ID: <20260731032031.1090755-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260731032031.1090755-1-kanie@linux.alibaba.com>
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202044_118043_D3C30E53 
X-CRM114-Status: GOOD (  13.98  )
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

When a host issues an Identify command with CNS 07h (Active Namespace ID
List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
called with match_css set. The command-set filter dereferences req->ns,
but this handler never calls nvmet_req_find_ns(), so req->ns is always
NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
namespace with an NSID greater than the requested value exists,
req->ns->csi dereferences a NULL pointer and oopses:

  BUG: kernel NULL pointer dereference, address: 00000000000001c4
  #PF: supervisor read access in kernel mode
  CPU: 8 PID: 57928 Comm: kworker/u130:2
  RIP: 0010:nvmet_execute_identify_nslist+0x12b/0x1c0 [nvmet]
  Call Trace:
   <TASK>
   process_one_work+0x19e/0x370
   worker_thread+0x1a6/0x310
   kthread+0xe4/0x120
   </TASK>

Besides the crash, the comparison is logically wrong: to filter the list
by command set it must test the command set of the namespace being
iterated, not a single fixed value. Use the loop variable ns->csi.

Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..ab6a0a98dd5d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -958,7 +958,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
-- 
2.43.7


