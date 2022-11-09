Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB41C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Km7kvZryGfzgtWyO6R0fkU01naooGzypE9SyIJrzOm8=; b=FzFcPBzxx1ytZJ+8XI/Ra+33y5
	dj11VDTo7PXHRXFE/M1gzgcFuBgMXeQ/5XSqp6ZOtMnBghBNF0EaXWm8F4LlgRLeH8DCwnIr9tCQo
	SrTY3Eorm0UU5s4z1TcVqCg7/hYN35Lur9XEjcWkJtqT63KobPK9ZrEuLx7UzXPkXp3hhtsOseKBW
	nvnwLRulu7zPtKAmhRtACADmTpRt+6EWqZniULjLHstINPj6Z5l0w9TedD0Jdy2heZA20YeciiLPt
	H800R8scVeYIcfTXjnl3mMVhH2pyvq/kRlSpcnVVw7Bj2xu0ZqhEzEIUBgHoWUNgdAKdshF18gWRj
	Yy8dHnYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc5R-00AQQK-Qn; Wed, 09 Nov 2022 03:49:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1H-00AOUX-T9
	for linux-nvme@bombadil.infradead.org; Wed, 09 Nov 2022 03:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Km7kvZryGfzgtWyO6R0fkU01naooGzypE9SyIJrzOm8=; b=RgruiSGF16SrtVFrwAY0EsCC6R
	9fTcAICCOoioBqPE0HQ0hLnsJhuvv8vQa+2I2t+CShTl7izYhyqDdomUR0GSkVKuM0PGnB+b/FWyx
	1kkRSPyUTwsjDXURpSh6ldMI4zegesE7KL8F/BVSdg/RORv2XUiF1L4BWlxi25yBQo4srFF0DrJDw
	ICl/ydgzBDl76G9w7P6WFYPwWryr58M4xI+Bt91b4J5/Orq/tHGx5wnyZOGFDqmpgXxTlE2nudAd2
	4ea+PCM5DrpZYvj/AJb5sKP7MF1Y6sq+GqNeMbx1d4PHpf8x4p7X3beUuMz6VIZCX1pQwYg1L1UVU
	UiqhjAcA==;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1J-00Ar0k-GI
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:59 +0000
Received: by mail-pl1-f173.google.com with SMTP id io19so15936230plb.8
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km7kvZryGfzgtWyO6R0fkU01naooGzypE9SyIJrzOm8=;
        b=SoIWcUGpOXJCPCEKojtCfRezbNRC5V1oTFDowXc4uXrULxzyd+B0V1oCU8i6AyhsOD
         9Uh3QFnel1gW2CSjHQURXTd6rsfdWVZGApWdxeG7fyn/op118VAoTpbRa4mv8od6ud/x
         yXlRLa5tWZHPiwnvj+KEzkf98GcyYNJ6hHM8Bzc1hlq4+6uWCbVYKTY9nT2gtCCztm84
         M9BBy6mJA1GTWuieZtTjcaygVe/C+WYZcovNg91RmvHcQmcjbvCA7RpS+fTi/7oueUGk
         6BkQ28u6Q3VbhYbrXyJCP/ypSW8bs1flD2V2dUQcunfdVxkZsgKaUlbN0c+lHZVLVm/p
         lIZA==
X-Gm-Message-State: ACrzQf1wBgNdIshHbV6+hrmRm4JfrcdzD2iKAUjhBLhmEKjARN8UplFy
	Di4afV9XVcbFUk6nTJEdg5aKfBRMGF8tT4Dj
X-Google-Smtp-Source: AMsMyM7TZafK2m2iWT7mokufHk5BGM/QVsGtN3Y0mLNbs6bMk3kue/gcamWLE+jeeLTbmxqpfp7hAw==
X-Received: by 2002:a17:903:41c3:b0:186:dfe6:f25 with SMTP id u3-20020a17090341c300b00186dfe60f25mr57875421ple.47.1667965484634;
        Tue, 08 Nov 2022 19:44:44 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:44 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 16/16] nvme-rdma: stop auth work after tearing down queues in error recovery
Date: Wed,  9 Nov 2022 05:44:19 +0200
Message-Id: <20221109034420.1000086-17-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_034457_577339_7CBBBE74 
X-CRM114-Status: GOOD (  13.57  )
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

when starting error recovery there might be a authentication work
running, and it involves I/O commands. Given the controller is tearing
down there is no chance for the I/O to complete other than timing out
which may unnecessarily take a full io timeout.

So first tear down the queues, fail/cancel all inflight I/O (including
potentially authentication) and only then stop authentication. This
ensures that failover is not stalled due to blocked authentication I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e079abb22ee..ff1a6924f339 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1153,13 +1153,13 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_auth_stop(&ctrl->ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
 	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_auth_stop(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-- 
2.34.1


