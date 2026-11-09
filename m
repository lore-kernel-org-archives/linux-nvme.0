Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59765606A330
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=etnoOD3M;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Rsq/m1/Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u1ipky8YJM+eoKIymd4Uk2gvs400AQ3YsUr4XSGDwEE=; b=etnoOD3MCRpZ5N
	iQvqXqLUrzb75uXNPHbrnIckNn6MCPQQWgCexC1AbYeSBsB512yLM/4ZFPxmTbLY76TeEoO5OlIHQ
	E/VpGVncF5SYtZ7+frnSN6xZMdZQL7WTbmnlm+jF9efE9Q+4e01R1TNxAZXASr+NCt67qwpDIe2SJ
	bWrzKqd2EoOIEmchP+W0xQuMt0e+rrUAI0sAckaztIrF6VEv8BkbdN+OVGnWqKGNLke8UdFwVwg4O
	fxUEX8nRzGjUXPoQre/uKqrarLJHYbNXvqDnoxnfVpSBFLxQW65om01ItTD0VlngkwF84o0FXKEq+
	WO7EAi4A37oZLHpPWFGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF67-0000000H7fs-48DV;
	Mon, 09 Nov 2026 02:27:04 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF64-0000000H7d3-1fsa
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191214; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u1ipky8YJM+eoKIymd4Uk2gvs400AQ3YsUr4XSGDwEE=;
	b=Rsq/m1/ZpoDuQz6UWxlB6FxRbl2xkN2mNDe1Unj2VolA5WlOfXwid+bijTZ1L5kmgbZCiwmTzco41LOZKOcFDz/SF7AvcrTqTDSsR/ACJwCW1OwfzMW5QMKvoFN66DbmRzrHGr02cnMY2p36L5xkvggPPy/+eMSd5gToTITqUAc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEIBGfS_1794191212;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEIBGfS_1794191212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:52 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/5] nvme: reject a reconnect_delay of 0 through sysfs
Date: Mon,  9 Nov 2026 10:26:42 +0800
Message-ID: <20261109022646.290792-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182700_778469_4D56AD66 
X-CRM114-Status: GOOD (  11.68  )
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

nvme_ctrl_reconnect_delay_store() accepts any value the option parser
also accepts, except that it misses the lower bound: writing 0 is
rejected by nvmf_parse_options() but not by the sysfs attribute.
nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
crashes the kernel with a division by zero.

Reject 0 like the option parser does.

Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Reproduced on an unfixed 7.3.0-rc7 kernel in a VM with a fabrics
controller connected:

  echo 0 > /sys/class/nvme/nvme1/reconnect_delay
  echo 30 > /sys/class/nvme/nvme1/ctrl_loss_tmo

  Oops: divide error: 0000 [#1] SMP KASAN PTI
  CPU: 7 UID: 0 PID: 1542 Comm: bash Not tainted 7.3.0-rc7
  RIP: 0010:nvme_ctrl_loss_tmo_store+0xce/0x120 [nvme_core]
  Code: ... 8d 44 08 ff <f7> f1 ...
  RAX: 000000000000001d RCX: 0000000000000000

Verified on the patched kernel: writing 0 returns -EINVAL and the
ctrl_loss_tmo update succeeds without an oops.
---
 drivers/nvme/host/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..bae0d6258d01 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -634,6 +634,9 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
+	if (!v)
+		return -EINVAL;
+
 	ctrl->opts->reconnect_delay = v;
 	return count;
 }
-- 
2.43.7


