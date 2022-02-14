Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52649C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tqKUm7hZW2/PvEpquztjuPK5vJA0yjLqqEvZ5nVPkbg=; b=zSiL/sLrWiSD3SsiJqZiNn8woL
	qfSDyYN/3bYT7C0mMCyvaCX36GDQ/ucEheJ0dXezVSnwPUK19c9bMLHBlShRSQ53SkyLQdHvg6j8e
	Z3YNQP3LVRVES2Lt/cTlT39wJkSEQvJzCaNjY03F2GvpOjpR7Tud6gnKVSp2eEbcbzTGsDhP+o5fU
	/pgCPUr0dmjjmw7QMU7eUhG8J5AFc8VN4Shk9FlrdBvOSav7S1Kl0jR2UwBbLly1eXdECAt6Xqs5Q
	II0A6LsUvsbX/5jGUlm3hlebwqknm73hinSaKAp0LU3gm8mM/Q68mM+hd9Vq2xXK89bGVW6WrWBic
	E181CZhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXW4-00EDCr-T5; Mon, 14 Feb 2022 09:19:28 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKd-00EAJS-4t
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id j26so14799266wrb.7
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tqKUm7hZW2/PvEpquztjuPK5vJA0yjLqqEvZ5nVPkbg=;
 b=brdDs+HXBEk7p5T3yLdhORMAx2+P/6Y99cLk5x43PKnr+0ec+v8TpAsxmnWxu+pjtI
 cMXLV54CPpqXZ/zFKT88DDJ2UohXmazL8j/RCk9ugi8pCzWAAl6yC5jhoBBXHj1irOBe
 sRrp8UZ7tdr6mw2aEflXy6R6PO0ZIFxp7wkODCxRqXLeRmY38/lshvAfq0uxS9ZVavV/
 OPZbLIdejEVXUTv6sFcGveqZlQlYR08Da3DsvVg/vP2YU9wjOD/raZLKVhcO92droGE5
 L8Be7j1y7X1+uNgZ0dPd48zKVRq7lVxiLeyi6fZz4pvAgHz1R7BVQI2WVTV7cY3kd4L+
 WCTA==
X-Gm-Message-State: AOAM532f/ODCb+B+eZUOLGvOimSW43XCv+n4G/Gum0VPHtmwP9egIL1H
 fLA18on03VBpygU45yhgbPwXzy/T9Jo=
X-Google-Smtp-Source: ABdhPJwjOpDFrB1lcS6ZCC7k7JxQKT3GRr3Agkb20Te8ZvPegsnc2Mph5ShOQq9hD4xYhaR/Gsb2zQ==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr9870529wrd.320.1644829656984; 
 Mon, 14 Feb 2022 01:07:36 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:36 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 3/7] nvme-fc: replace ida_simple[get|remove] with the simler
 ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:28 +0200
Message-Id: <20220214090732.479193-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010739_230368_6996023F 
X-CRM114-Status: GOOD (  11.43  )
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

ida_simple_[get|remove] are wrappers anyways.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 71b3108c22f0..96a5d7fc36f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -259,7 +259,7 @@ nvme_fc_free_lport(struct kref *ref)
 		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
-	ida_simple_remove(&nvme_fc_local_port_cnt, lport->localport.port_num);
+	ida_free(&nvme_fc_local_port_cnt, lport->localport.port_num);
 	ida_destroy(&lport->endp_cnt);
 
 	put_device(lport->dev);
@@ -399,7 +399,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 		goto out_reghost_failed;
 	}
 
-	idx = ida_simple_get(&nvme_fc_local_port_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvme_fc_local_port_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_fail_kfree;
@@ -439,7 +439,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	return 0;
 
 out_ida_put:
-	ida_simple_remove(&nvme_fc_local_port_cnt, idx);
+	ida_free(&nvme_fc_local_port_cnt, idx);
 out_fail_kfree:
 	kfree(newrec);
 out_reghost_failed:
@@ -535,7 +535,7 @@ nvme_fc_free_rport(struct kref *ref)
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	WARN_ON(!list_empty(&rport->disc_list));
-	ida_simple_remove(&lport->endp_cnt, rport->remoteport.port_num);
+	ida_free(&lport->endp_cnt, rport->remoteport.port_num);
 
 	kfree(rport);
 
@@ -713,7 +713,7 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 		goto out_lport_put;
 	}
 
-	idx = ida_simple_get(&lport->endp_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&lport->endp_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_kfree_rport;
@@ -2393,7 +2393,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	put_device(ctrl->dev);
 	nvme_fc_rport_put(ctrl->rport);
 
-	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
 	if (ctrl->ctrl.opts)
 		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
@@ -3472,7 +3472,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
-	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvme_fc_ctrl_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_free_ctrl;
@@ -3635,7 +3635,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kfree(ctrl->queues);
 out_free_ida:
 	put_device(ctrl->dev);
-	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
-- 
2.30.2


