Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D501C54798
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zS+gNwRIiItnshgzMqHZa7wz7JiyU0jmSYAlgJA0ViM=; b=aiCylIUjx8o2p484f8O+Qz9i2Z
	+EjBD/g8koU5pFZVmsG5gTzDF2s4THx7AOKkLtbRVS3meVTqbbUkoDYOZzKmKkRp+7Cx5yusC090D
	ztFJ6At7J+jjG6paVKWgTAI4wBwHmzYwY2botdzqyZA5QlRyuUVuAdK/Ro2X923CUpy2WPJIN4/mk
	D6FFmUTigakSb+uJl8Dcpb26xfD/6t+Zheo4qzP4dq70LgFAbx6NqfLJCcFrfwUtmnxZV3ZxTp5ws
	+KuO2l7QDIFr6M2yq+Dr6Ur6F5di7OqUjobvaYKjx+wQsboJZVlv6gwcNV9D49IEIUlW3kbO9DQ+G
	ryHH9SiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9pj-00000007jSK-25Op;
	Wed, 28 Feb 2024 02:38:11 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9pg-00000007jR9-1sVF
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zS+gNwRIiItnshgzMqHZa7wz7JiyU0jmSYAlgJA0ViM=;
	b=gRoA6cFE/5FLUDh4l7UDp0zIvUgF9Nb/93NPCzziCo0jmLCX38zF/QDf0P3p+Me/uS02dYF6DFbH9kvFXEm9cbPvpiTGlWh4XOeFTPeYEQugV0jktvWYutJzP0boMpU6RGvx7lgai9aNDQRx2TI0gmYnB9LaqaGmuuHaMS+DH8g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1OIKe9_1709087879;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1OIKe9_1709087879)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:38:04 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-fabrics: check max outstanding commands
Date: Wed, 28 Feb 2024 10:37:59 +0800
Message-ID: <20240228023759.99111-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_183808_683361_16077EB2 
X-CRM114-Status: UNSURE (   8.32  )
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

Maxcmd is mandatory for fabrics, check it early to identify the root
cause instead of waiting for it to propagate to "sqsize" and "allocing
queue".

By the way, change nvme_check_ctrl_fabric_info() to
nvmf_validate_identify_ctrl().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v1 to v2:
- Revert nvme_check_ctrl_fabric_info() function name change.

 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..7c247b849bbb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3117,6 +3117,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
 
+	if (!ctrl->maxcmd) {
+		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


