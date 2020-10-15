Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E92C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 01:52:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69E922255
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 01:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zEfCKBy5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="2OfDrONn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69E922255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rDLQjztXCORhoQtW8aqmPf9QL8b5M9zbodwT4k9fjdY=; b=zEfCKBy5gmNECxE9j9G6OkntTT
	9lbj/7dDkg6MOdN+BVL4NviArQkORXdjpYLc1WaFbyHacw/zcYx0u786sufCWACxLLMINuu1JRsZ9
	l1RTyT034+skcN6Y26ZKb27v/HzYx+GLeZt+0G3hvS5vW3lO97et9QsjrE18235soN4l8CX/E162M
	9jBFsUiOsR0Xl8MN5oCrzS/LyXNyfMvg4Nhlo2/a2EIlaZmqLSb0W35hHqh6b2YUhvikRKrGuG28E
	5OnpS/+9kDtk//Iz+Xga8Y28FpxoHJHMccjXlcvLVoG2pxmDRrJT+7UXjxgWfkzn9EiGwMusqIlc0
	UBjioH+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSsRR-0008OP-KL; Thu, 15 Oct 2020 01:52:29 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSsRN-0008NP-5e
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 01:52:27 +0000
Received: by mail-pj1-x1044.google.com with SMTP id j8so905674pjy.5
 for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2020 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=Ef3HnQQahVPNGpzniRVNSgNHLilFmnzUisJ433euhLE=;
 b=2OfDrONnaWuvb73Idi8of8nziQnBEO4nKhRgyFliSwV3I9RTEO5MoSro1gAzplA57c
 +Z8PbCizdEvVBDVj//dX0z9eD+npsdsWZbxohJnzuK5cw91GU6wToWoAV5w5pYgJVWab
 WJc1VwaayRA5KKtaNalifoXxrxerDvUTiE916PoY4Mc/iP21S2G0JwGdC5ZJzAEWymYQ
 tw8Rka4iRmV44MeIYs6yY9JBXfqPfoNVObyujhP+uwsx3UrrOVekVdmEF4uBTUAUnRvX
 lYTLKP2rfTKARe4qWN+yl/DpU6lOQLsdZ9IhHZVQNEh/WTQfbGMadhdLpkWloWHH8AWo
 qhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ef3HnQQahVPNGpzniRVNSgNHLilFmnzUisJ433euhLE=;
 b=CamEuu3dYDs/Hmv7fzvPj5AYC5ruKJb7FB2P2Jd49cen+j46mLp/8+B9ChxRmCmDH2
 S1HOoWvasgqQZTqO2u5RhSjMhxvD/SbtqNC6UkYaZkVgdU/DoeoPnO1VSv1M/LTl7CB0
 xE/3en4uZHYIg9anFv9FSdFR5Vxe8l0CoAMXvBqL4fAueVnsAYlHfHk5VNOHz1Uz+GXj
 ew1NU3KoaY6js11+wOP0yRr4xkfM+qF+qLyixS7Qd6MZpYxWM7fD7W5SLJJ3+gRgEpZh
 QM2tver+WeJJ6fZxOUvabwww369WlV+BlzrjXPNRPsHc+tL09rXUFcRyjcHK/w/DRs2D
 buwQ==
X-Gm-Message-State: AOAM532jHjrpalFFquwfan5Vpn1l8G+b/Xk5uV6O/zQzQYC37d59/Bpg
 olLT3LBBjixaN6D3ZE41IDiqog==
X-Google-Smtp-Source: ABdhPJyJDjtzgpgvCAIEqnrTv322gS69GtuqnRltoYel1FD3Ea5+kYrrKMLH8mYJarxPN7ABBUe/Jg==
X-Received: by 2002:a17:902:a983:b029:d5:a524:8710 with SMTP id
 bh3-20020a170902a983b02900d5a5248710mr1731041plb.28.1602726741015; 
 Wed, 14 Oct 2020 18:52:21 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id t15sm3308125pjq.3.2020.10.14.18.52.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Oct 2020 18:52:20 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH v3] nvmet: fix uninitialized work for zero kato
Date: Thu, 15 Oct 2020 09:51:40 +0800
Message-Id: <20201015015140.1061936-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201014_215225_307391_9D456A96 
X-CRM114-Status: GOOD (  13.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hit a warning:
WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
with trace:
  mod_delayed_work_on+0x59/0x90
  nvmet_update_cc+0xee/0x100 [nvmet]
  nvmet_execute_prop_set+0x72/0x80 [nvmet]
  nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
  nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
  ...

This could be reproduced easily with a keep alive time 0:
nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0

Starting an uninitialized work when initiator connects with zero
kato. Althrough keep-alive timer is disabled during allocating a ctrl
(fix in 0d3b6a8d213a), ka_work still has a chance to run
(called by nvmet_start_ctrl).

Fixes: 0d3b6a8d213a ("nvmet: Disable keep-alive timer when kato is cleared to 0h") 
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 25d62d867563..aafcbc424b7a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1126,7 +1126,8 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * in case a host died before it enabled the controller.  Hence, simply
 	 * reset the keep alive timer when the controller is enabled.
 	 */
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	if (ctrl->kato)
+		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
