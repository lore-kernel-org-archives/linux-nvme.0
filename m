Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D76C531F9
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q14+SU3ApPQKeuQJQq5srmD2x1GZ50vyxARH6EmniXo=; b=HucfZHgDnxVmgcmrJnkGl5V4yn
	m1GGzAHmwdNpoAriSIxbraBsDfOYJrOXGl6lbK/Y8REPtk5mj+QPuJ4Fr0ihE+4zsih37JAKe0smN
	B8AxkDOBSdw6/JHIYZHBFyTeXqETqnNnUSw/yfOOAhVwpMv8coxAzIg/oyRNX+9PNqVJ63CyV1q1L
	a/qhvYr2d5rTfV+CfLS/9N7mteg2K8QBP506zlEbUacN66K0e6vrBQay3HXepQg8nh/LpLvcW31T3
	JM7sZDUVTgEyqbHrqkL5cYxTSxLPzXnLaKobfW4cckWkKjMMvnC88eotvWast+sNErYglgbZkCH/n
	W2W1dPDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6P-000000017Hl-0GOU;
	Sun, 26 Jul 2026 11:33:05 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6L-000000017Ax-166k
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:33:03 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so19407505e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065579; x=1785670379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q14+SU3ApPQKeuQJQq5srmD2x1GZ50vyxARH6EmniXo=;
        b=CUmCm3KFtU6owJvbC1rftieZYLtSQ/Fr1nBWVzT7JZLcVaJlrQlMRk8wGqmM2HsjVz
         U9MJj0KJiZFwqjyw4B3JQsNQvCi3PavsCIi5bVrYXKzXG8x3kvpt2BiYLCm2uKtdFqN/
         lKfg5OVbQ7Jr9+fImPVyyNC1dcIm5RqMfSM0PA3lP/glZ2t1gzQgk33r6057d3D6SMik
         8XFHvMjyXtXX2jPqMBn7bdGf0TgVMeohZvKThN4lFK3pB46nujps9kL7vP8PvECXmKqU
         PIN0Dc63c6p9gSV1MFD1mOduTBByNxnP16FIxTyyTPFXg0aw9E9LCAKFBuaii81b+v2I
         9H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065579; x=1785670379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q14+SU3ApPQKeuQJQq5srmD2x1GZ50vyxARH6EmniXo=;
        b=sobM+4FwwGkdWKN5YPPuprD0TOjausIqPLiblBnj/q55UJ3bvxI//YsG/V4kbf/Brh
         e6Yh2AvDtmgBxHjn0cEDnWked+Jzk9FRU/J5OxEmwgUbzYp+p4CuBQzwwZPwgcCAGKK2
         BP/bpJCI0stVw9YNqrtr4ki+wngDR95ZVFXcuojibVEjXWi1jnDsdwq7+6bi4ZcJ/ds+
         AjyjspwJYyCyh0aoqlcW6gvParuCWClNn8uu3ZDYNuoA9XNo5i4/PVFUU+3J3qRSbuIN
         HIOV4zf6mZ++oE9jV4QDG6OaPLrBEjFNQ5X0mZ3cowerfO+ZF/7ajHDJIJ52rvFvw97A
         SmgA==
X-Forwarded-Encrypted: i=1; AHgh+RrRndkKwCkqEk97Swxl0+8+ZXyE+VVPSILZFd6poLePxCVgWc+eIU1GjM804wj1MotnTAPW27gIUS0K@lists.infradead.org
X-Gm-Message-State: AOJu0YyN3rDIER9jAAsxHs1bYxHqBE+chngUV3mg9zqwRaJsZT0n7853
	CVcIArNWV6PFRa38Rd8Pvd71bZzeNvctdjO67FpyZdZSD8x6cZaw2ZPZ6ifSDwIkig==
X-Gm-Gg: AR+sD13oUNaUAhY8ry/TUhCYABe/ZUnWAPrH75puxQ+P5kcf3d4uitVr2FeN7Tkd6at
	sqTFmipLt98uIAYAD+X2tNIDi0R7btcuAskZpO213sJiPBdCdPlo5E4cSxBlltAOJwkrgPzoqVu
	1PWOdYceh2UnuTH7ZOQaVjyh/H6PzqPAAgCvcrKWUY86D54/D0Lvs5RZ6d8q+lfT8dLQxjXLzUd
	9mZNjzHi+wcfd0UIRRV+Dteo8cUHwudjfwlYg1biRnC3Ep8iXIelHR8Xa4NmupCXUGHXv03rku5
	3bkQ4ZTDiNfGSEh6MjR/KT8r74aHW9pU2mdE5t45Sl4x4L2NVrKKJ6tcKWxMbkdHpadXGmVEWgJ
	7jYEoSkjYdzmf+mxCjhuGw4F8JxKMOZJ5pq7awYTtB/3x0zYk7PDNSaIAZlD5VcK/ecVZUCdwFn
	fzABYJZ5sdmVywlpFGkDo5LoFDdhBtooVb3UWLb4YdA9oWGAy/7DPpLSP/AKqjEsP8ZAspovg2p
	5KJ9h8TMk5iVsalHVrBaH203IG/qySzJL9j+v/yDQ==
X-Received: by 2002:a05:600c:c87:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-496b56c58bfmr55527435e9.11.1785065579344;
        Sun, 26 Jul 2026 04:32:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:58 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 11/12] nvme-rdma: ratelimit the map-failure error message
Date: Sun, 26 Jul 2026 13:32:28 +0200
Message-ID: <20260726113229.2154269-12-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043301_340046_C151BCA4 
X-CRM114-Status: GOOD (  11.36  )
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

A mapping failure is per-request and, for an unroutable P2P transfer,
deterministic: a workload that keeps issuing one turns this into a
log line per I/O.  Ratelimit it, as nvme's per-I/O error logging
(nvme_log_error()) already is.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c38d949502b7..2f50509a7a61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2040,8 +2040,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
-		dev_err(queue->ctrl->ctrl.device,
-			     "Failed to map data (%d)\n", err);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "Failed to map data (%d)\n", err);
 		goto err;
 	}
 
-- 
2.52.0


