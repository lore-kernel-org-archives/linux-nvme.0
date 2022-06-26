Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964D2C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3EUdm7MsdC+HBu6GiXdQ955Rypdi12NlRq4KsipkUIs=; b=f9Ba3rX0LPMAWdIOHsiXD9tJ/M
	ybKta0owTeBBmJ+jsoYgSrMuvzxz8T1XAXml7kHqIN11Mahgc4yMOK4yppMZpVdkkY9SKxyRmaJFg
	+2bGUQ0CefoPtFOf5lEwdOZz0EGhzWHu3i+op9OJPNX59MrU6RVNl0Qdzlnq1f3oodtTkwBH5YrQv
	fMfbsM5KcHmnDw0DT5M4vItVse4FABBhtWR3WgiXPB436Kk+1BQ3cvkm1szA+VmRQ/WqdMcMGitK6
	ua42yM6yOkxTgimy/7KpgCwcPrw//Ivvl+Rmka261GFWbzU6Ba3x6LO2W9CXxOHRQ7wBFmef82Ccx
	JoxkRDIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5OVn-00AsP6-E9; Sun, 26 Jun 2022 09:24:59 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5OVk-00AsNA-BB
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 09:24:58 +0000
Received: by mail-wr1-f54.google.com with SMTP id w17so8943175wrg.7
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 02:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EUdm7MsdC+HBu6GiXdQ955Rypdi12NlRq4KsipkUIs=;
        b=yY+TAD+fn1MO4kyAx3onrq6UP3nl7Q6IdPf0xGcQwe7N/tGRVA35AIGD7BUnThNgoO
         YzDtfXTF3DQ6UZ7dGP4u87zQPkVyd2jKTc31V7CAIkqkoosPbcZjb+K220uGriucsWfD
         SAeU+TZOda3yvOBqqRNQ1AuCFWHmiT8Apoy0yiGdyRZ6ZS6FIriqjZk68KWl70leHYWE
         bLVLG4t0slPuQi5o7KP9xi05T8fvRjtDOXBByYPhvUmiHuviAQ6BrbquZgBxXmhnoDlV
         2Yp1uR6DhKA+VfhVePUwmgTvidr2qT7SaqMh+9bAbTOS7rRaU+zzGRXfmxbPjA3Uf7ko
         4mwg==
X-Gm-Message-State: AJIora+ZY1NNOBWw01GG78hAXy84onNTT/Uy9KGZUxSDRbTrrSQqFaNP
	ZUn7mhb/Aw58MGjrkTI5QJDlyCzCjbQ=
X-Google-Smtp-Source: AGRyM1txKz2PGzLfkX2QySN9wXEeBIq915ZojA6C/0q7bT1sEg2wpJyebjWNKr5miTSWLngmIqJktg==
X-Received: by 2002:a05:6000:1446:b0:218:5a5d:6cb5 with SMTP id v6-20020a056000144600b002185a5d6cb5mr7057571wrx.629.1656235493584;
        Sun, 26 Jun 2022 02:24:53 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b0039c798b2dc5sm12760389wmc.8.2022.06.26.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 02:24:53 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: always fail a request when sending it failed
Date: Sun, 26 Jun 2022 12:24:51 +0300
Message-Id: <20220626092451.32694-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_022456_423915_5E422953 
X-CRM114-Status: GOOD (  13.65  )
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

queue stoppage and inflight requests cancellation is fully fenced from
io_work and thus failing a request from this context. Hence we don't
need to try to guess from the socket retcode if this failure is because
the queue is about to be torn down or not.

We are perfectly safe to just fail it, the request will not be cancelled
later on.

This solves possible very long shutdown delays when the users issues a
'nvme disconnect-all'

Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d241b..009c2cf3f106 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1180,8 +1180,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		if (ret != -EPIPE && ret != -ECONNRESET)
-			nvme_tcp_fail_request(queue->request);
+		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}
 	return ret;
-- 
2.34.1


