Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BB3C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3AscdKhlN/8Ram+vBmlsJDo9XmEdzplI1PWbp3SGr4=; b=3ldhLwMXP0mh5CHaref2NVdMCi
	u1+/ODgF9aki+jlxd2BJU3Dg3kINomN0ETq5Lr7jipNuFKKuQwCsTEUNvkITg2GAj14LCIN8nq7Fg
	E2oVTdPUX6cp7SeN6evV9zx9OrSeHUUJdNER9pzeDWpBlR/mbf9qLIj9DL/4bYcBkwJ/p7/wJ2seo
	zSqc7hIrWB0ViivWplMCMyORIEdc7CVNLqKWqM+bUW43SW0I2Hq51DgcW3bYDqEC1Os/t8R0xX7+b
	UpiwT4XVPfIH51EnFOi0VoU+4ZhzYYF5N5L1D3yhYeuTlI4IbZG0zegs8R5vyMXk6LlIFxPu4wm1H
	LpEqFR5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc2I-00AOwR-TX; Wed, 09 Nov 2022 03:45:58 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0y-00AOMI-G9
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:37 +0000
Received: by mail-pl1-f172.google.com with SMTP id 4so15991324pli.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3AscdKhlN/8Ram+vBmlsJDo9XmEdzplI1PWbp3SGr4=;
        b=jnHqgDR5zPPLEUI3j2BSQXLFkD1vJIBbdZK8mEBN6zaIZdGfPbD52pStsLJ4i4pz3v
         G7GKauR6XvNjEdtS/P3hjQdiyJ0poU09PqO0rQnt59YaEcCrSD63fBA6w0gdkTRnL1yw
         OaIvQUdHXGWpjeLRMquEC+Z8xYV+p7g2NK/l5CbXUTX8PbLc1ShuCyghTK3N/K8pA5DK
         V+dFaCKurwkZ6Z63K3IN0e/W5+uZteJMfki20+O3cHeXdfXYlpMCrg3REFBjAB2o8Nfy
         /Q4wgJMOCngEUpC+2y61GZtH3hQMs6U1JlPQZjo0WV1xrZVf9x2zka+/SuqrqhCKOcAq
         XvvQ==
X-Gm-Message-State: ACrzQf0ePAJMyegyxPEcrZnoToR0nIgpedF4XkuFwkzXhCVBE2go0UjO
	PPHIxKnXc5IcyEU2Zof9GDyPHXRQ3zgTu7Rk
X-Google-Smtp-Source: AMsMyM5MQNTdukms4XxBUVj7zbKsQVKHvt+Qin5SZEnWgNkRn5GsA3QlQcqtw2fKH1/7UTQpevZPrw==
X-Received: by 2002:a17:902:f68c:b0:186:dfca:a444 with SMTP id l12-20020a170902f68c00b00186dfcaa444mr58212423plg.151.1667965475136;
        Tue, 08 Nov 2022 19:44:35 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:34 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 09/16] nvme-auth: clear sensitive info right after authentication completes
Date: Wed,  9 Nov 2022 05:44:12 +0200
Message-Id: <20221109034420.1000086-10-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194436_577205_1DA9F246 
X-CRM114-Status: GOOD (  10.48  )
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

We don't want to keep authentication sensitive info in memory for unlimited
amount of time.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 201f25267685..484315efa0b2 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -908,6 +908,8 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		flush_work(&chap->auth_work);
 		ret = chap->error;
+		/* clear sensitive info */
+		nvme_auth_reset_dhchap(chap);
 		return ret;
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-- 
2.34.1


