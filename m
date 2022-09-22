Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A92DC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=adSoTd5PQILGShOmRTNAIfVgMacNjNuPK+PXvMa0Rho=; b=voRNIaIUSVCYKHeEeoTsEiZ6l8
	BB/Zdu4scfAJ6bvDFmgBxa7QfXLqb5U1RKAFQBSnYIWiJS5zilT8Y8jKH/RzPiM+rFcrB7nnCaDEd
	ZLrmgYrLGIncrqHaensasaJn3iXO+qsIOhbt43bQXPePVxClLbaXqSLwSvmw4NwB8h7nCu8AJSgHN
	RvaD6VyQq3aO6ImUQagDmHCAtLFi7LkyYqjonpzCLu0KI2jzKrpYHSG45Iqh2lge0Au76Cra1vhSo
	rLFhzMo94BWn3OWAhOYYGyTa4z2bJzn0faARJbpcHpWJH6QOXMBNPD+f6TwZG5o8oqhOQM80NPZ08
	8asah1yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGFD-00DhoP-JM; Thu, 22 Sep 2022 07:03:35 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGFA-00DhnE-1k
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:03:33 +0000
Received: by mail-pf1-x430.google.com with SMTP id b75so8380802pfb.7
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=adSoTd5PQILGShOmRTNAIfVgMacNjNuPK+PXvMa0Rho=;
        b=wOJqueuYceR32fuDLq2HZXcUOa65vmlZE/GoKpKqAsp7BZUnOLQY8EGE2eHRJ4UUZe
         8xZjI8ijNKZYvTFOCt4xK4gk+I1325q+4XyBkmRsmKCtoNHI4vWxxkEb/0wRZdLkqdsf
         I0hKKgrBIEY1ra0scoTo3+k6bZ59mj2Yl+UYeey1BhFCrNx2j01zIhgR3ioKhPo/y5DJ
         DaiAEsLBsTU5NchXzZV570MwvSneEtRQDG3DpPFxaaqB6NDE1LoTvbV2ysWR/Q4iGl7B
         si/fZBFIQ4Z9Y3sh6sHlEda35fcN+oNzxRyhwpdkUH17vabcAPo0aL+kPVosqCus/rRv
         pP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=adSoTd5PQILGShOmRTNAIfVgMacNjNuPK+PXvMa0Rho=;
        b=TDXvRZKaN4s8Y6wYVWnO6TvgvQo7+XrmAlYWGjLok89NAnVQhkVF7wiQFroMVsgcl2
         odHDIYYAGZb2EZFa/idxttIcEEw/N5KiKexKle0fTOQuBeprijp1T+H17amdOobDoxQS
         ESFv/Cj0NxHrSyDYF4o+0RoY32bzRipyY09MpMdoZ7Lmo5XD80Fae3QppPrwblmaKOZn
         nLYhQ6JtmbWAySyutRzPfjQUwbarly69410AhYGodY+3626WT3CL98fc2rGf0Cc4i4PE
         w4vCdywU+VQCJxIRysF7Dvz+tM58F30yK63dQsOrwc7DArnRpPAzCt4mL6/xYQ9nokzd
         3Jhg==
X-Gm-Message-State: ACrzQf1cgvbSciMAzpxDNrh5NUjtjYXCTmivs9Du7puSplgS9MJAuruX
	LtIhXMNH251X2MU69smHlJ/aQg==
X-Google-Smtp-Source: AMsMyM4dsMNhGbjT52gg3WcT0DmdYa75Kh7e3iaEH1k2m7BW0t5KiPz3EphCk64xia7FPyORd8X72g==
X-Received: by 2002:a63:778d:0:b0:438:5c5b:f2ac with SMTP id s135-20020a63778d000000b004385c5bf2acmr1784706pgc.401.1663830209592;
        Thu, 22 Sep 2022 00:03:29 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001782751833bsm3184261plg.223.2022.09.22.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 00:03:29 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Date: Thu, 22 Sep 2022 15:06:16 +0800
Message-Id: <20220922070616.41918-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_000332_344559_FDB5BB4F 
X-CRM114-Status: GOOD (  11.41  )
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

There is only a single call-site of nvmet_tcp_finish_cmd(), this
becomes redundant. Remove nvmet_tcp_finish_cmd() and use the original
function body instead.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 98e17ea184d6..63d72b9cb28d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -164,7 +164,6 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
-static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
@@ -1177,7 +1176,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		nvmet_tcp_finish_cmd(cmd);
+		nvmet_req_uninit(&cmd->req);
+		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
@@ -1406,12 +1406,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 }
 
-static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
-{
-	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_free_cmd_buffers(cmd);
-}
-
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
-- 
2.20.1


