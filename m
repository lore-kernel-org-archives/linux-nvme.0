Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6A6EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39m/rji67x8U7Ur472GRShIkuF8vP3R2qcCqvPRlJ0M=; b=NtDtmoWx8+H9JSXcX1ZdFWTKtz
	W5Zd9zCGD3IjJ2siA3MZ8MUXGVk/ZtBao48D4Pg8QoT1f/gEtqO7rprXiyCG5dApz6nb0JmgtMrrx
	TD0F2ow3YuwKptN3lbc5SDN4YzqgUTepLTlj1ANjm+SVxfSEsdKxN4gFGij01G1UqWjamS1Ft4rTY
	7wYo5E+lwdcktKl5IOVfViAd45MmF5YDsKTJiCvzobjbz1HaqKWOJdm5u4Kocqfnyg0Do8O9M32XQ
	Mixuqkhvqa4Iaak1qV07hYh5Vq5kIyQHPoiiUxxKsCiXd2Nsdcm6QSjRAWJ1LYTYkbRLelvbJo4KV
	0C3oJU5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lK1-00EjRD-0Z;
	Thu, 15 Jun 2023 11:39:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lJs-00EjNU-24
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 11:39:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 141D1639CF;
	Thu, 15 Jun 2023 11:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA71C433C0;
	Thu, 15 Jun 2023 11:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829155;
	bh=OgHqwIY8rGq/HHn1hD0yYLlYuhNWRn90S1CNL2qy43w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxhtFtL0wRywsVP2PVk1nAcbKLsxVIHHaboRYoCQFgN7TvnaF4kvUyv4k06wykd5A
	 tU7MTMQkbb9YUx4QtmxbhJXa8eZxhapLM3s4Eizg/lufb5JOfanlNRexJKOHbKmuHc
	 Fv7I1+bQLn6BSrOE601tjzBjKpBDK+EIHEpTUC/pVf4tR4QliUHFqq+lGTLNYozFEU
	 oSyoIXrbLpwq9I0JvAFx28ACeSCqK4zpv/eYRvLYseCCJ1qiBnWlUNq4m0Io57f0iF
	 UNa6AG32bKsn/FZFgYTRUsr6nw4+6aCsfpnpmEdxqMoKurMa9A6ZlPKwQ5o9U6yHxZ
	 2J/9d43RhN2aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 09/10] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Thu, 15 Jun 2023 07:38:53 -0400
Message-Id: <20230615113854.649370-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113854.649370-1-sashal@kernel.org>
References: <20230615113854.649370-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_043916_795038_745E89E9 
X-CRM114-Status: GOOD (  16.34  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit ea4d453b9ec9ea279c39744cd0ecb47ef48ede35 ]

With TBKAS on, the completion of one command can defer sending a
keep alive for up to twice the delay between successive runs of
nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
possible for one command to defer sending a keep alive for up to
KATO, which can result in the controller detecting a KATO. The following
trace demonstrates the issue, taking KATO = 8 for simplicity:

1. t = 0: run nvme_keep_alive_work, no keep-alive sent
2. t = ε: I/O completion seen, set comp_seen = true
3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
          skip sending keep-alive, set comp_seen = false
4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
          send a keep-alive command.

Here, there is a delay of 8 - ε between receiving a command completion
and sending the next command. With ε small, the controller is likely to
detect a keep alive timeout.

Fix this by running nvme_keep_alive_work with a delay of KATO / 4
whenever TBKAS is on. Going through the above trace now gives us a
worst-case delay of 4 - ε, which is in line with the recommendation of
sending a command every KATO / 2 in the NVMe specification.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e5318b38c6624..98a7649a0f061 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1247,9 +1247,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
-- 
2.39.2


