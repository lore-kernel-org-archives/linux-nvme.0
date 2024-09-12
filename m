Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F2DEE6451
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UH/bYbwi5sRzp99x+U9s/tcrzDf7TCeFBHWOW4jPO6g=; b=4IrmW+dUORs3yrbRGmtOgcdCuA
	Yq88K3MlqD89Quc86J5KYwSZ9hbG5oO1HkM8KEN7BqVHAX+pxn/he3KGwj6ZuWx9VvLmCXtzc9Vam
	NkgmnXAC2K25F7fzXuQ49pYFwXB6HqZtrN/VNocNi/M6EdK3xM0OFdVmo9mN+HWAplN7XNGjrEowq
	vME59R04tqEG4NgERJfmhy08LTJUMKlMss0SECAjnY01s5LSMs4SJFeDemgNqAw3ZNT2WnrMCYMqC
	ML+cg40nQ4rq6c7O8bM3r3HvFOPlVimp3gaUB2FAGqn+9v6nsyikRTu5LL2GA2Hs0iRZZiBO8eZE1
	cV4VhprA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYZ-0000000C3Ki-3a5N;
	Thu, 12 Sep 2024 06:43:55 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYW-0000000C3J1-3JPO
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:54 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 70077C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123431; bh=UH/bYbwi5sRzp99x+U9s/tcrzDf7TCeFBHWOW4jPO6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PtHWF4OaMv5FJdnJskN4DNQm0/9qtWp+4BVG6kinJBzQtx7OM1KsOyrQIBdSchke3
	 en7Pvs/kvD1j/G/l9T6WOa/XtXiLledeqwTO/z1fSlTgSvMGv6J9b+2Zv1pHe1oYbz
	 hmt9W+fzC12bTtI5Uw2hWO+jbFpm1XCs0wxnAA9cdfEODDUd87hevpaII+ET4ArBuK
	 46OtHaQfom3hnSqcpbpnuf6Xbk8u+fkHDandZym5zireMgX+p7+9cRChKf5Xxhzzbj
	 wMzfT7G85HJr8bPH53qOOSxUaV5GHXkDvwQMQuW0SKRKuDYzPSeZI9ix34oOfg3RCN
	 ljCFHIrsWiMiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123431; bh=UH/bYbwi5sRzp99x+U9s/tcrzDf7TCeFBHWOW4jPO6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SMJ5H00WmhlnsdvjKpw3fZOw4DD0GTJVDMH4lYvv8WahdT+3D+1HuXjrerSH7pm3R
	 ABc4KRbqVhEYRTYJ5zelt6JX9REMx7c8onChf15TPNATSRKxNCPI8Siy09twrqzUhb
	 9P9VyH8x1woxhVYm95OCKIpDftSACOX+FzaYGeaml96usPFKgzzh6FJtbl8EEnSkTA
	 Q+qUrsGuTvEiLS/wsZv5cNxg6XD/qSKEvoopMe5RiBApkMAiq54P9ZAseVc1UuA4+R
	 hjM/qe5PKOPn2UDincR+YoCgs9JYU7p3wPAB9v+iO+5Dli3UrXbWwlVhFiF/hPiGty
	 bt/gm0awhm/vg==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 3/7] nvmet: file: add support of Compare command
Date: Thu, 12 Sep 2024 09:42:55 +0300
Message-ID: <20240912064259.5228-4-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234353_035228_7EC3E302 
X-CRM114-Status: GOOD (  10.20  )
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

Add handling of Compare command in file backend.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..27ceb1120d6a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -114,6 +114,15 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 
 	if (unlikely(ret != req->transfer_len))
 		status = errno_to_nvme_status(req, ret);
+
+	if (req->cmd->rw.opcode == nvme_cmd_compare) {
+		if (likely(!status))
+			status = nvmet_compare_sg(req);
+
+		sgl_free(req->sg);
+		req->sg = req->cmp_sg;
+	}
+
 	nvmet_req_complete(req, status);
 }
 
@@ -227,6 +236,17 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		return;
 	}
 
+	if (req->cmd->rw.opcode == nvme_cmd_compare) {
+		req->cmp_sg = req->sg;
+		req->sg = sgl_alloc(nvmet_rw_data_len(req), GFP_KERNEL,
+					&req->sg_cnt);
+
+		if (unlikely(!req->sg || WARN_ON(nr_bvec != req->sg_cnt))) {
+			nvmet_req_complete(req, NVME_SC_INTERNAL);
+			return;
+		}
+	}
+
 	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
 		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				GFP_KERNEL);
@@ -365,6 +385,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	switch (req->cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+	case nvme_cmd_compare:
 		req->execute = nvmet_file_execute_rw;
 		return 0;
 	case nvme_cmd_flush:
-- 
2.25.1


