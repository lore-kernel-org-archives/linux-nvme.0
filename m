Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F11BC55179
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:16:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7D24199
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3KGQPWYf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="xq0/h44N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7D24199
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7THWTz5+ij9T9qVN2LKfp11dx4t4OmPDYPR4X+60zqw=; b=3KGQPWYfUFYIQSSt/gCKQevG45
	fO9D3lT3sqa8dO3BgzEqhUJ/7dy64Li2J5fzM7rN2xEwvTQNE1BAmyk/jz8fWf+/uH8yaSdmIfQdO
	P6Z41heG0Fyk1+mnOg+EwIAlKCoO3zVEBH2TqQYS2ukQxYZgMIUaqL+J9C+8b9Z4HW/HhLk1IMCqE
	JxO+sJj++zF36E/jAr68iWPXaBc7mP2PhPHtyvrSFA3setMOPgIyOlDGO1BCqlvhtXzrsySQ/pnXA
	KfEwBjdhxyxYNBprMIHnNvDakbUFhYmGYQQgerrqzrTNTztAUFkHR/LMaEpnk0u/nuPIDXcnGJJT3
	6TYfbsLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXNth-0005bV-Ui; Tue, 27 Oct 2020 12:16:18 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXNtY-0005YW-Qj
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 12:16:13 +0000
Received: by mail-pg1-x541.google.com with SMTP id o3so669077pgr.11
 for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2020 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pWBtIzMURnNZwf5E6ccAuvdeCFLhHS4uNoSrzuo7TUI=;
 b=xq0/h44NIR8g0JJ9TXGYR727SOWgGvc1tbK6rZs7CpX5BoTd2JY+quQgOEhFjBL1C1
 2ykJGVGT03IKjtWZHlHqSNz3totASLl9NiZYU2dydOdWGCxU879QUAE4xQbkAYN3x0hi
 AflfDsx2MV4GGA8Rn7iyDI9Rh5SIPZjh3x5iaR8Adra24ZHSP7YEM4nMrvyYpKHqQGxE
 /27wHrYHZKbOHBy6M9o/47YhS/eqpWdUtsal/UHODsGpYNNvxfCHW2ab8l7kJzp4fffX
 TKrjzDeoTX0I3nuhxYwdiveTrYIMf5P/p+C7YZvDiQIdWZT8yRilFyxrCraahOeGJ9/l
 pweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pWBtIzMURnNZwf5E6ccAuvdeCFLhHS4uNoSrzuo7TUI=;
 b=rpy0mhD/SgpxKj1nqGflKgXdYq3sP+2X9GsiD3PccDwwjJzofiuAwNWkUpVCkfD1EH
 gn50F5LM1eZkwY7wWXrB+34hi58yySXdvoJZHutBqF+rgEmeVSmg29APj56fRDIg7Rwa
 6U9BNTM1uoEkT8y46bCk39ebqPJjYDUVfygqdMXcsBoM96KOd4V/M7U3Tow5rOm64/WK
 Ds4TV5mbLEp9PDr2mP+tF+EM9XS0jQnR1ChSkeAuZopNh1popFlRnkJ6690SUQcjtdMi
 pfT4as+ZUh2jbY4kWmO+O1AUAHdzLflur//6wSetV4nytZztsP2zWL6W8/t0P7wccnKI
 F8Pw==
X-Gm-Message-State: AOAM530ZywtNiGEyxPqxe3Ia9ibS0f+58UHVVVIk7ennlIcS8pzQ9tdL
 TLI47OsP9RR9I2leR83jwhw/Aw==
X-Google-Smtp-Source: ABdhPJzn8ICZbnjfRaw2e1HyNEy8kpjZJMmNlFcbjHwcsU8Mor/10oPQmIQYKPFdxNJk9Wec7Fx8xw==
X-Received: by 2002:a63:2c93:: with SMTP id s141mr1675186pgs.169.1603800967192; 
 Tue, 27 Oct 2020 05:16:07 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id t12sm1820747pji.26.2020.10.27.05.16.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 05:16:06 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH 2/2] nvmet-tcp: add keep-alive
Date: Tue, 27 Oct 2020 20:15:46 +0800
Message-Id: <20201027121546.1776104-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201027121546.1776104-1-pizhenwei@bytedance.com>
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_081608_948188_3D8C379B 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: linux-nvme@lists.infradead.org, pizhenwei@bytedance.com,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add tcp keep-alive to detect dead connections for zero KATO case.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..58800e914e61 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1714,6 +1714,30 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static int nvmet_tcp_keep_alive(struct nvmet_req *req)
+{
+	struct nvmet_tcp_cmd *cmd = container_of(req, struct nvmet_tcp_cmd, req);
+	struct nvmet_tcp_queue *queue = cmd->queue;
+	struct socket *sock = queue->sock;
+	int ret;
+
+	/* TCP Keepalive options, max 5+1*3 = 8s */
+	sock_set_keepalive(sock->sk);
+	ret = tcp_sock_set_keepidle(sock->sk, 5);
+	if (ret)
+		return ret;
+
+	ret = tcp_sock_set_keepintvl(sock->sk, 1);
+	if (ret)
+		return ret;
+
+	ret = tcp_sock_set_keepcnt(sock->sk, 3);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -1724,6 +1748,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.keep_alive		= nvmet_tcp_keep_alive,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
