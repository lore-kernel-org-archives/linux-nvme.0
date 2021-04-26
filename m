Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F12C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:54:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B6A61009
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B6A61009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=synology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=INlL45ZANaynyNPhw4gV/jVlWuQWur1py/0wY+a5YCg=; b=DaQWyl3mMV+wXnv03nKJmjuU71
	E4dAETUrK6Cn4YpsfGw9es4OWtl5AttgJMRay0Jx0Cajje8VZ7bEDd6sOHq/JPzy/jNI9lnMF1Y7J
	ZUinbjTLmKudl/5g5ucDWm0hnwtZpD4qllJRED/lsajLY7K7Pg9uAWOMntFGSsck1AA5zTxmSXcz4
	oORmiHGS3zahESP61CXEGOm3dQ2Jr8QFqkL/T1Ev7eREszi+0fRoV7eI0QaspdE606b8z5FtDzxm8
	vvRyyPW1fLJ3DTUlXkLuQ1r4nEPIdLFosCz70JFwuw03a6/CXvUx9OqalJk4Mm8b4bJpPH8ywIes6
	byeZvIcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1larO4-006l1A-Mb; Mon, 26 Apr 2021 02:54:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1larO2-006l0v-2i
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 02:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Jf/stU7opYltJVVdIfvvQNnXIFHklvQS7/OwgDu8umU=; b=Trcf3StmgHmm5oNwQMs4hqTlN7
 g8uYGPfiWHPDw646U3zkSDpXfUVlp/vWT/hOwcxcGIIM/tXbUrsw1Bjf5lgFdNao9CYOzzN0zNAb7
 RIs8YtQu71WY4ILpnTAVKmytc7oZYxla1NTG5rlcJaiB/a4OdhvN3XY+KrlSFUJ8Eb8HpnwsLaBS4
 ZcQKnvTVZojysYjHR+BSWge4vXxDXxztuD31kz5yrDkaX4M6BTLqRzqCgRyrx50F/nFOx1VqSgSth
 UeXgJ+1VRL4fn5zOFTHjnfgh4zTkuFVCtswcrSlrZyhbFNtR5wEM1TvP0qPSGxG6+FipVdv1bx92Q
 J5KtGDpQ==;
Received: from mail.synology.com ([211.23.38.101] helo=synology.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1larNz-00FhRc-63
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 02:54:12 +0000
Received: from localhost.localdomain (unknown [10.17.32.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by synology.com (Postfix) with ESMTPSA id 1233BCE78097;
 Mon, 26 Apr 2021 10:54:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1619405650; bh=wAjRTvLic0pVgluNJL65go6oMZha3oZzIeK8QANysC4=;
 h=From:To:Cc:Subject:Date;
 b=HVU7dhS5eXLjgSVV4uJbEKQS+/OXWKYr+InX1Es01iDgQvIW8RxD9pzU9CqEcJiHf
 C0cwGOZMGdrXplfIP81HQu6i0+Bo5M4GLlXzrI+e8AqhSzLstWIcQvqLX0QXp7IFKi
 yfpmeTx6BNCbHtgf+cL4KaKmdr5iH7aYQZHNlK4U=
From: taochiu <taochiu@synology.com>
To: hch@lst.de, chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Tao Chiu <taochiu@synology.com>, Cody Wong <codywong@synology.com>,
 Leon Chien <leonchien@synology.com>
Subject: [PATCH v2 2/2] nvme-pci: fix controller reset hang when racing with
 nvme_timeout
Date: Mon, 26 Apr 2021 10:53:55 +0800
Message-Id: <20210426025355.3005949-1-taochiu@synology.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_195411_497677_3E519C28 
X-CRM114-Status: GOOD (  14.23  )
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

From: Tao Chiu <taochiu@synology.com>

reset_work() in nvme-pci may hang forever in the following scenario:
1) A reset caused by a command timeout occurs due to a controller being
   temporarily irresponsive.
2) nvme_reset_work() restarts admin queue at nvme_alloc_admin_tags(). At
   the same time, a user-submitted admin command is queued and waiting
   for completion. Then, reset_work() changes its state to CONNECTING,
   and submits an identify command.
3) However, the controller does still not respond to any command,
   causing a timeout being fired at the user-submitted command.
   Unfortunately, nvme_timeout() does not see the completion on cq, and
   any timeout that takes place under CONNECTING state causes a
   controller shutdown.
4) Normally, the identify command in reset_work() would be canceled with
   SC_HOST_ABORTED by nvme_dev_disable(), then reset_work can tear down
   the controller accordingly. But the controller happens to return
   online and respond the identify command before nvme_dev_disable()
   should have been reaped it off.
5) reset_work() continues to setup_io_queues() as it observes no error
   in init_identify(). However, the admin queue has already been
   quiesced in dev_disable(). Thus, any following commands would be
   blocked forever in blk_execute_rq().

This can be fixed by restricting usercmd commands when controller is not
in a LIVE state in nvme_queue_rq(), as what has been done previously in
fabrics.

```
nvme_reset_work():                     |
    nvme_alloc_admin_tags()            |
                                       | nvme_submit_user_cmd():
    nvme_init_identify():              |     ...
        __nvme_submit_sync_cmd():      |
            ...                        |     ...
---------------------------------------> nvme_timeout():
(Controller starts reponding commands) |     nvme_dev_disable(, true):
    nvme_setup_io_queues():            |
        __nvme_submit_sync_cmd():      |
            (hung in blk_execute_rq    |
             since run_hw_queue sees   |
             queue quiesced)           |

```

Signed-off-by: Tao Chiu <taochiu@synology.com>
Signed-off-by: Cody Wong <codywong@synology.com>
Reviewed-by: Leon Chien <leonchien@synology.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09d4c5f99fc3..a29b170701fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -933,6 +933,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
+	if (!nvme_check_ready(&dev->ctrl, req, true))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
