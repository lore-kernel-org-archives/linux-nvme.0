Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73430606A329
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PfGm9Zua;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ojW9sl/M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pJi67xQUk/n9jZxeZYS78g6IZ3p0w15eso0BhISoxwg=; b=PfGm9ZuaySx/Ir
	WqDhI5v0rHlnZIqrV4mPwHDCuHLT7pReIzBED0o0HiBaNyqmWaShVO5EOsQJ47wyfiBGq1Ww2XjdH
	NBsa7UTN41KgXCXrHkQKtt7N23AzTQVw8F2y56zooOwmluMTW997/eHA1j7FxNS4Fib4swuOo5z/3
	bjd1WooTMM+aYKKxOwHge16/zoeuZrNqAYclN0jJwyCW9bENMQjHqAD+tj0TVS1MrtygvLMKEddYW
	tQGERNqicnWnDpPUwlgLoeemL+Zccn440rrKDVdxEMEwtUV/4Ptr6d01LF3DaHE/6H/Kil464qrSV
	2KTZLIvROTvVU+hULfvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gF-0000000B3yP-0Rnw;
	Fri, 06 Nov 2026 02:27:51 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gC-0000000B3ui-0mrY
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932066; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pJi67xQUk/n9jZxeZYS78g6IZ3p0w15eso0BhISoxwg=;
	b=ojW9sl/MroZxBCAN5a9AhYuh2kHQqP2cDXMnaxaeNVjONBn733Y3QM0CA2w2TdJToSDGTXZrrdx6ZfnwKaxqTf9Q4D3vxEuYPAHUmhgASzvJNZYZAilVGeV2wGsCikt9qkshoh0m6MvjsoENkjZAJNLqswEu4dcpRS6le9k4n74=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA90D7_1793932065;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA90D7_1793932065 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:46 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 5/9] nvme: drop unreachable "off" case in reconnect_delay_show()
Date: Fri,  6 Nov 2026 10:27:32 +0800
Message-ID: <20261106022736.3582824-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182748_384521_4AAFC6AA 
X-CRM114-Status: GOOD (  11.89  )
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
through sysfs, which is not a meaningful delay. Drop the case and
the matching sentence in the ABI documentation.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/ABI/stable/sysfs-nvme | 3 +--
 drivers/nvme/host/sysfs.c           | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 9291595f8102..1826df9161d2 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -70,8 +70,7 @@ Description:
 		fabrics controller.
 
 		reconnect_delay: Shows or sets the reconnect delay in
-		seconds. Reading returns the delay value, or "off" if
-		disabled.
+		seconds. Reading returns the delay value.
 
 		ctrl_loss_tmo: Shows or sets the controller loss timeout in
 		seconds. Reading returns the timeout value, or "off" if
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


