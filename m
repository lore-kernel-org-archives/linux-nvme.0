Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45806C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4LiwNiWSUa/KtkRd5MOCIuhb5sAQwdUvQB60oFuHxSU=; b=aRIFirV2uG+HEzfNmfgmyjrOmp
	JQGf3asxnRufrPW0oDsPTcz/tOwYaRUaEyhQbGqDu4myb8ibuSVleUuOMxXNN9/hwx88KpalG7U0+
	6p29eVgjwTf75razL+c0R/8g9OBkYG8xiR7i39IKvvPN6QQx988LmnZo929IHtslJHCTSwdeT3pVK
	SX6z7T1P1ZB5g4aCqQ3hQNZvfqjG65ulfu7J6BBCJSFlQLBI0qUSOOyJQkCR6gGSpCLqi1EJPDS50
	7Z9lgYTjRmsEwAU9IA1Bli6nTAVd4rvi8zyyFnvv2JIWHa2LUQvXak/r+B1O/YVoPy+d6XDi1mKvD
	L7j8ozpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scQ7Q-0000000BQpz-2uPM;
	Fri, 09 Aug 2024 13:57:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scQ4v-0000000BQDh-3CoL
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 13:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723211685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LiwNiWSUa/KtkRd5MOCIuhb5sAQwdUvQB60oFuHxSU=;
	b=SupUi0dccmBxpUv1qVI0IKMAqlMGUhxY7x8OwnTKi6IzBAqIy5JlchKhXeQlyLoGmRJLZW
	rYKieoQgB9OY00XuknIMATZ22sajN4kgwUBbNsn5cgj00PSU3pJHLzeyFhsrPyTvYGZ39u
	ha2uARqF2EyM7YlqvOoAe0cD4FUqY+4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-_wHOGbm6OgiVrhUWLPn4fQ-1; Fri,
 09 Aug 2024 09:54:39 -0400
X-MC-Unique: _wHOGbm6OgiVrhUWLPn4fQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA8FA1944A83;
	Fri,  9 Aug 2024 13:54:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DA073000197;
	Fri,  9 Aug 2024 13:54:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Mark O'Donovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Date: Fri,  9 Aug 2024 21:54:27 +0800
Message-ID: <20240809135427.378953-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_065449_892357_0460944B 
X-CRM114-Status: GOOD (  12.94  )
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

Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
moves starting keep-alive from nvme_start_ctrl() into
nvme_init_ctrl_finish(), but don't move stopping keep-alive into
nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
after failing to start controller, finally use-after-free is triggered if
nvme host driver is unloaded.

This patch fixes kernel panic when running nvme/004 in case that connection
failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().

This way is reasonable because keep-alive is now started in
nvme_init_ctrl_finish().

Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Mark O'Donovan <shiftee@posteo.net>
Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cd..562afa71ea85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4612,7 +4612,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
-	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
@@ -4648,6 +4647,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(ctrl);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-- 
2.45.2


