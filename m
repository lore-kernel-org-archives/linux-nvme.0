Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5A8C79FBB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+jY8D98dI3BJh9bGxWJLTam08cqOXeCPFw0Ktg9MgRA=; b=qm7u30aSCgru+JwUmASw60lOAg
	SFDsGLnpjt2XSLRN7ea7gnoqwwL0vGq3/YcExC9Z9s5JwxykjyisQWZbEHi6foR0jSiO22WGU6NOs
	silbzJdReAYS8Jp7tYdSGcvTTtOxE2NO9u6m6PMl23ElknkbHyLjPi6OMICqLSKKUsuhATcgsGr48
	U4e4hf/cpLPRZ3wlUHTOhKfdlLqdd+Ey/Zd9KfnQA+Lh+2AmAHXFyadreDabxuS9DyvwWlmtYZ6uu
	l38fWXK8IaT2GSnpDoIAqIEFlUOVsXlOM5cTdgxBs41kVziLt8YjQb4UE+EJiGkzgbT9MhZ1+aQWK
	Hpyki+Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOK-0000000FKlI-21Xn;
	Thu, 10 Sep 2026 20:29:04 +0000
Received: from mail-vk1-xa62.google.com ([2607:f8b0:4864:20::a62])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOI-0000000FKkg-1Jct
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:29:03 +0000
Received: by mail-vk1-xa62.google.com with SMTP id 71dfb90a1353d-5c82d057971so332565e0c.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789072141; x=1789676941; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jY8D98dI3BJh9bGxWJLTam08cqOXeCPFw0Ktg9MgRA=;
        b=LFStUdvCLq4b0vV8+lIw3zvkwSZCQVsup/suR6HJQ8Nt1Ly+Er2Uq3fL+uAYvYjc69
         qu9yr2CVWm+v3Spj7dFZ2n+k3o4l+tKIl22zeFdYsVoLGS3scgZ/DukViDWEQ36RG/iN
         czH1+4yBn3EH3aeCOgpYCA/VGaBB6YhvkbNsuJDWpN54B6kHJuzasX/7B3f+/7TFeJhd
         2wcHRtw+jc4MVlXo14G2zAdtyau1NU8ibOqHUcEJXFddjzLB0ubMMuiN9jSdcjEeniHm
         YMeo3S8hRM0c/kLrVMsibYxeFl6IxGUDPUj+q2cGCAa+Ko7eE106pTpxjKVBwAQdDTUY
         m9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072141; x=1789676941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jY8D98dI3BJh9bGxWJLTam08cqOXeCPFw0Ktg9MgRA=;
        b=p2j4JZhHZcHJxgCDJVnuiyLcRfSdOSIFwMejd/w2NTgfjRzcckP3b4pOY3EUccrxCU
         T/yEqz4KvobsBM+RkyumEi+vfWc7d2nFMAxTjZKVZQi7jURkuD8sgax8a9kr+Xl+Z1xW
         Fg2vcYpzl8RPTDM6lNKC6AmsY7YFgBXwm+WP2WJaPYE6RAONHeVxmWtfB9IP55mv/bOt
         62pGjfdL9QDc7LJIdw6qHNjoLthWo4R4m/Y2NesmQvgbgCow0a6mJ6HDyPqD89fQyrKb
         u1HTSXT2SCDbnUL3vUNm0TdVl6QednQRWGT+gxLQcDDRg+VdeLrS6HWqBKrJtfu/FzvD
         3aHg==
X-Forwarded-Encrypted: i=1; AKwUvBxptLmGFGC0ihQBtllDvwTq3RaZcOf1a8uaIc6JzXUIIYqJ72AhIEz+NatRvrvu3nwzRB13hOsnYU/K@lists.infradead.org
X-Gm-Message-State: AFuF++nDmthxitr6YJgOX+muLNiYEgv2fV1vGpga4AOAP5G3Rb4su9l1
	AD+Qya+d2yIOgPlns4fcdFO15NDsVFUQjenozWNPjvJMPCZA6i5IeaTbalp1HSSho0eMzgVv7r8
	IJDHSa+u6NRGGI4Iym9sgZUu5qR7VrwxfofAS
X-Gm-Gg: AYBFou06H2Oo2+NlvNJOob0sW3Zm0R0doIIpHI50SwOAtkwMGxG50rsI65GN++nMXPV
	7O8as5wihP6s8yXrgSt0ol8MFoUne2J9PZ6+mcme2OcYbA0lHNmFopnBj17wDJU6sfsAqyTU8w7
	bbKBG3NHTYSKi6xzPwdi+QWapLmNcJwe72VunaD+vtC4qY2FwFw3pRc5HLHr//UPNUmY8Qm8xlb
	tXGIrZ45e1XWQmqYY/pQOQBQTlzeP+jFO8xD4tWn84aq/Ic3UMGJu1/n7WajZKN/dKVYallZ2W3
	arLvL8mA6ZX4toWCpRqbB/0YwxASFcgPW/995aE8wqiWQjgS7ql1glZGXQdK9q64/6L7cXTxMjX
	nqtZt8Y67xwOjWTMqkG6QiDXewL/HDN0=
X-Received: by 2002:a05:6122:4894:b0:5c6:8480:35c8 with SMTP id 71dfb90a1353d-5c8462f5c71mr2417289e0c.8.1789072140729;
        Thu, 10 Sep 2026 13:29:00 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c846f624f2sm163189e0c.2.2026.09.10.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:29:00 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 24849400F1;
	Thu, 10 Sep 2026 14:29:00 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 20E1551EC2; Thu, 10 Sep 2026 14:29:00 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 1/3] nvme-tcp: store and use the caller's network namespace
Date: Thu, 10 Sep 2026 14:28:10 -0600
Message-ID: <20260910202812.1642832-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910202812.1642832-1-sgogte@purestorage.com>
References: <20260910202812.1642832-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_132902_362363_0B55DBA6 
X-CRM114-Status: GOOD (  15.85  )
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
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5fda9661bdb7..8e5e22febe2a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	struct net		*net;
 };
 
 static struct workqueue_struct *nvme_tcp_wq;
@@ -1846,7 +1847,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create_kern(current->nsproxy->net_ns,
+	ret = sock_create_kern(ctrl->net,
 			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
@@ -2638,6 +2639,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	put_net(ctrl->net);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3036,12 +3038,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
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


