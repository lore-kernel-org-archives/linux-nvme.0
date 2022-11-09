Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C9BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lkIzgjffzk+xts4KEqaqEsOW7axOcl1QZK2XOaayuk=; b=Euq0AJhyJBtS+26I8UNSS7r35d
	b4RwzLbhIMpTyZXVMhF//CSNZ93OoQJpqN4vlFowQgmuJENYIlX7PVV6qlwJEF+dCBLK4YdU6DzGM
	SdqlSDWrat1OlrkfX5FZkq+LEc/BKyFDUHJ5FinOYemwF0LogcEpxKjhRDSWTdT5r7kuPd0gkhUW+
	5/pP6qdK831xXUQuGE+Q2l1V1BUUymgy67MpGtrlFGNubmZp9sWCORkRh9cUntV2qMOUoOCTnjUlY
	6qkkAFUrRDYrcfgYhf9ybtSHmjhSQOhxepDWQbq+0IKC6zbPcs13ijPqsvLf8CgvH4eIjwFp9mleO
	C7xtvzRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc4l-00APzT-8v; Wed, 09 Nov 2022 03:48:31 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc16-00AOR6-Lu
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:45 +0000
Received: by mail-pj1-f47.google.com with SMTP id k5so15558257pjo.5
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lkIzgjffzk+xts4KEqaqEsOW7axOcl1QZK2XOaayuk=;
        b=zHnnnZZXV78Z/NMg4Yxfe5nSSpVgre4rWqa9BA6T3tLb9zwiN2B8Z3ludpVBTzo1Mv
         lZaIm6H8Y3axx/IXdQJtZX85Cw3h1j360nHjKEGR2T8900W0QLADWZHTVj1DrugTaCHJ
         /HHUP2WBSudENnGrTfZw+M9a2O9FZIlGFzwjsE6J9m8NDWBZF++LmxnP6GGzOk+I4wLO
         oN0s3fm/pCIX9GzYJLAzuYyS9tEXXh3Mc6dQKtNiFRrI84am/lO+U/s5CeQaomr/lCqR
         5GBJ+zDYqkSLV86g3G1HCgYc9jTjsEpD34GgwSwR5WKfNh8As7p+pTOuMVcStM571GLz
         zDow==
X-Gm-Message-State: ACrzQf1FzD9vLi+8HhQtwv5vc6zGGTQ3I8jyHXYEsCBVj/gqFKmiE31c
	n0AfefubXinvLHWfjPC6j/CMyWjFRAS9vDFs
X-Google-Smtp-Source: AMsMyM76t+VRD4e117gGJvt4SC82hKlWLn331LUpgMw41423OZ5lVh9WXi53qxJefzfzj5f3Qfv0TQ==
X-Received: by 2002:a17:902:8490:b0:186:a7f8:63b5 with SMTP id c16-20020a170902849000b00186a7f863b5mr59939266plo.57.1667965483245;
        Tue, 08 Nov 2022 19:44:43 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:42 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 15/16] nvme-tcp: stop auth work after tearing down queues in error recovery
Date: Wed,  9 Nov 2022 05:44:18 +0200
Message-Id: <20221109034420.1000086-16-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194444_729035_92B5AD6E 
X-CRM114-Status: GOOD (  13.74  )
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
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 339dc9e94f5c..d78fdfac635e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2128,7 +2128,6 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
-	nvme_auth_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
@@ -2136,6 +2135,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_start_admin_queue(ctrl);
+	nvme_auth_stop(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-- 
2.34.1


