Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE8DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2TJfwJxVH9pxJRpJoYkzQT/UWIx7orj3fphRfol+Mo=; b=pw69j+RrXoOoqbOwmMEcstosk5
	+A9scG6VvFNZA6MTDprKsIzx75sD7UddquwwPVymn16iD9aynlJh2sG4zhCoCSkgwPRRhDMeGTnXi
	c4SBCRc/Verq4Hrr/770DD/znH67EvRVVja4Rr42VY25QFmm9Avi6s2Kp8x6k3bOrHDC5Oy8EBsbE
	UyF2jx4eAfKxq7ytFGTow+liVouaI0cWD0KFKyvNb4fiShAWliRm3Fzb57WIqHUPnnQtX8tRWw37f
	UlFLL74Q/X/eN1ImxbiMe45Xmv1YwTeLZAeNwxdnTVuGq/ZlMEmOcu2qBQhGD2n0/f7Fz8rs7gfq+
	/gZOnyFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1E-00AOSG-TN; Wed, 09 Nov 2022 03:44:52 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0o-00AOIZ-F2
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:27 +0000
Received: by mail-pj1-f41.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso719114pjc.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2TJfwJxVH9pxJRpJoYkzQT/UWIx7orj3fphRfol+Mo=;
        b=O9Gx3RcPqgifnFhYEn7cMrVgYkQUfacSJ7AQPrSoOrvqoG8291180dkMWFVsCSv2Zu
         Q1m4Bg07yWttRh3lIGBLRVyqCFvugc40CaoF6wMddBbLKArIb8PwsiwtZZseg/r7MVa0
         tjgCcuv/04ZJGBU+0tRCP1t8zM5N4ZZZKTBtNHHu7slcciZfUk8Iv1HmM8C+IiJztqi+
         A/PwnEtLlStTggn5J/4LUBPHb89OWtdh++aGi0bkcX+GqcjrX7OIF6xzWlIke8AT0LiQ
         dpzPtdAMO+fB3mO/nnBTIGkwIoll3zHL7k2jIiHPdHpInn/XbHsFdhf5Jyj5dlLTSHRB
         5rig==
X-Gm-Message-State: ACrzQf2tCrqwTO+bFh9HGGb9MexGFGrTOh58szhpYwqhZg8HZdXHelbF
	zMnvbvUZeiFBiugmXCH+waNI8SWeKcqNnyb8
X-Google-Smtp-Source: AMsMyM6GTWF5iLpsZo5sQarO5GUjfixrUYa6r3rsUzNQf0cGEeSqN077IFffSxLYHAvFxmu72re45A==
X-Received: by 2002:a17:902:ea09:b0:187:3274:2460 with SMTP id s9-20020a170902ea0900b0018732742460mr44864169plg.153.1667965465648;
        Tue, 08 Nov 2022 19:44:25 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:25 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 02/16] nvme-auth: remove symbol export from nvme_auth_reset
Date: Wed,  9 Nov 2022 05:44:05 +0200
Message-Id: <20221109034420.1000086-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194426_517529_7F130B3A 
X-CRM114-Status: GOOD (  11.27  )
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

Only the nvme module calls it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d45333268fcf..734928282d3e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -932,7 +932,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
-EXPORT_SYMBOL_GPL(nvme_auth_reset);
 
 static void nvme_dhchap_auth_work(struct work_struct *work)
 {
-- 
2.34.1


