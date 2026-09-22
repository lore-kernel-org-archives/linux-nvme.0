Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65A3C98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnqNTO+qf2rQpgu0xRZfaRVcdc87gpRUdjQ7jZicuFk=; b=pS99VjWEqTBRcGxFh+yrETPLue
	6YriK6/Ia/VQHzAbq1bhnB24wOto/ugP/qis26w4QkRz/67FKj3om5ZgiiBPrcZl+HxOhXMZhXQuO
	pHOfgDVB03GBISv7EJNz8aaCukpyZ1q7dCrLHyrZn3i/5Ni8RACrIAL1abxF1fkOhpaDDNSHFKoc3
	2rK7sjxY1Sc+Dquld2tpSLbq1vJpVa/LukA8AtTTCVuI7Jq/Fw4t0ebt2hGaD/5oJGhbQukoL6+sz
	3AEd8dNB657C37aZBCJ/vx/gxQ4WrzLXxcZujKFmQz+wQBJ9xdJvaONtdnPzgFvaWSO+xtCek9Xwh
	WeQMIOLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mE-00000006VZt-1xsI;
	Tue, 22 Sep 2026 20:07:42 +0000
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mC-00000006VZ3-2GqV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 20:07:41 +0000
Received: by mail-ot1-x361.google.com with SMTP id 46e09a7af769-8016ab5f277so75977a34.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790107659; x=1790712459; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnqNTO+qf2rQpgu0xRZfaRVcdc87gpRUdjQ7jZicuFk=;
        b=UGIGTwjV0rAgEmju0SfrdF9bjc+Or0qw2JEjfsJdTM60z0zTSl5AhBDocHQQUkUULb
         WIidFAaYiPNJ4j/RviKTUj2NA9gS8IZJ1ZwzMLILTPtpB7NJ5L9Xi3CSotzxHAmjxyVF
         KYpvad6yqIyU075uo4n0hie1XTR0tnnamUaVIkt6vCPK93uCJaVPFdOpEuU7hZwoV/K7
         7huKPVcFMl2eNndHrqj4RezPpEVpPHtegRifN+dVTVlu8fvVZQLLZFIMFDd8KhCIDt9W
         3Yamo+oj8k5utH+2yKaU8qfFBIrUcP2dpO1lvfR1eY+dB8wXUdpE8vtsgUkkStst2xse
         UWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107659; x=1790712459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnqNTO+qf2rQpgu0xRZfaRVcdc87gpRUdjQ7jZicuFk=;
        b=akMY5FaUt26ez2CTS3yW+hYis50bz5+Wnjz4uNkk341FWviVjnvXsJSzTZ9MbNxAJ1
         mrjb/P5/tHyvf4qfspMdQlDdXEV6a/eQXvoz3Z5h1iWEFwmhZqScwD+UMOAYHQXBtWfE
         8GYt3ruhfSnjWi4uhzlCNQn68UDo7JgPdUKp21b0Vg+W2zQ0ZITP/hgc/72izcCq1cG6
         shbX4pJ9cOo06rn9DcdfkW0zGpTka42NI8p9YMAnGzV+f/NUrLGcLt6fZxmsuZ2CrVDS
         OOC6lKeUNZQIM+L6co/8NCBfNZQuFFBDjdCkSSawUew6DJ53ppPNdZ+T/IDOx/1wa2LN
         B4yw==
X-Gm-Message-State: AFuF++kzyam2s1CoiTEcFnD+tZAsIgD78bGggSakIBlBUYTg/Fva25R+
	N+EHkPfhNDfJrHuNjKuE3PwYm8oTMj61vSypbDa7zUeEe2ac/bVuCqOxZ6uYirO2iC6S4jQCqeV
	dTjpu4mIHmY3rzVXvftnMlzYcqNV2MUvG4M4P
X-Gm-Gg: AYBFou1pkOjOWWzRMWKvaKQdelK/qy9yBi4ECPk1wV93whN7Yn0uMmlfwIVwcJbNC8u
	x0R8ExfQOPDb/cURmXIfpZBHQ3dCnLjXsvnoKJlwikIbUSnT7rq8zFJQDN3kDkERtZWQFdbRwcp
	Pd3kN0eZesXMpcs6gqkel/vYDf3X9aTQ8mo/ZLCUfQ2kHYUlXXoFe0dDd2VjelqLAYg6wzT8ybj
	3SQQu6uamHob/M//TaOrZWnUHjsAIVPmTmMItP31y6/dHLb30BkNbUbYtQC2/FF4bZJNK2JBeHY
	Cdds3LwERPJ0TAP3Z9boM4M2kCcUJZIxwE5TGvegvO7jcKA3p6XpiCQBRBJkoAo2HFxzaecPcs8
	zVdB4Sda8xavbB3cs4Ua8KtVWZSHYHzo=
X-Received: by 2002:a05:6830:310c:b0:7fa:5c49:524f with SMTP id 46e09a7af769-815f37ecd7emr730236a34.22.1790107659525;
        Tue, 22 Sep 2026 13:07:39 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81603fc9137sm164400a34.6.2026.09.22.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:07:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id EACE04014B;
	Tue, 22 Sep 2026 14:07:38 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id E7CA23F9F5; Tue, 22 Sep 2026 14:07:38 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v4 1/3] nvme-tcp: store and use the caller's network namespace
Date: Tue, 22 Sep 2026 14:07:16 -0600
Message-ID: <20260922200718.3941465-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922200718.3941465-1-sgogte@purestorage.com>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_130740_628777_03CB5DE9 
X-CRM114-Status: GOOD (  16.10  )
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

nvme_tcp_alloc_queue() creates each socket using
current->nsproxy->net_ns, which is correct for the initial connect that
runs in userspace context. However, the reconnect and error recovery
paths run from a workqueue where current netns is a kernel thread in
init_net, so sockets created during reconnect end up in a different
namespace than the one the controller was originally connected from.

Fix this by capturing the caller's network namespace at controller
allocation time. Use ctrl->net for all socket creation so that every
queue, on initial connect, reset, or reconnect, is created in the same
namespace.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..f916bcca304f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	struct net		*net;
 };
 
 static struct workqueue_struct *nvme_tcp_wq;
@@ -1858,7 +1859,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create_kern(current->nsproxy->net_ns,
+	ret = sock_create_kern(ctrl->net,
 			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
@@ -2650,6 +2651,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	put_net(ctrl->net);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3048,12 +3050,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	ctrl->net = get_net(current->nsproxy->net_ns);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
 
 	return ctrl;
 out_kfree_queues:
+	put_net(ctrl->net);
 	kfree(ctrl->queues);
 out_free_ctrl:
 	kfree(ctrl);
-- 
2.55.0


