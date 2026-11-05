Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAD606A329
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=axZr0kLN;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m4hGVX5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kOf4J0JnNjPoKxDxop2eS5luPo1Di6p+i0K8TtXJ34M=; b=axZr0kLNn3FOAW
	5gLiZyXEafh2+k5HtFo7Cuk6uwJ/6YTjK7+afMx8uU2o9rzfCKwX8/z+sI2woQI8LDv3yLRDF7ar8
	xGC8ZrV7gtT9Jm5p4QUci/jQNmUCzGrPHS8A/Zxh410FMfhEHf8HrXytOpvEZfYHGOX2nsjXKLadH
	nCPc1+djsy08qq5rikBR6EGxaHGlLH5jZl8sa96gSDYyIBb07SvGCIAH0UPqclkQnAxzJqOa5HwVv
	H9pTpNDzsaW8rG3+SmLX8oMqKDkGr9Ax9usk+GNnZyqGTEiMH5aQzvMgm/bbr4KX7+3ePTeiaA1dg
	sYGVUrTqFrbIKuQiShkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwb-00000007XU7-43zf;
	Thu, 05 Nov 2026 02:11:13 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwV-00000007XM6-30NB
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844663; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kOf4J0JnNjPoKxDxop2eS5luPo1Di6p+i0K8TtXJ34M=;
	b=m4hGVX5LyAEUuOpztifWXsfu3gVZ69MGdyxGmksVzD78hIo6URi5Z0/9FSdTDuLH8n8W8dsTou6fyPgO8Wl94i0nGO/sAGoXaTf9p2XPX/imkrXwrXcsu0jpqhLe1MK90Sw/Glf5PjdUQQjWADc6kDfx3i3D3wNCUvs2ALfyYgg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE7BnM8_1793844662;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE7BnM8_1793844662 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:11:03 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] nvme: drop unreachable "off" case in reconnect_delay_show()
Date: Thu,  5 Nov 2026 10:10:47 +0800
Message-ID: <20261105021051.1667222-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261105021051.1667222-1-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181107_964977_C8A32B1F 
X-CRM114-Status: GOOD (  10.08  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The "off" case was copied from fast_io_fail_tmo_show(), but unlike
fast_io_fail_tmo, reconnect_delay is an unsigned int that the option
parser bounds to positive values and that has no off state. The
comparison can only trigger when the raw value 4294967295 is written
through sysfs, which is not a meaningful delay. Drop the case.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..3724b5ce03a0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -618,8 +618,6 @@ static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (ctrl->opts->reconnect_delay == -1)
-		return sysfs_emit(buf, "off\n");
 	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
 }
 
-- 
2.43.7


