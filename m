Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A4606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SHX90qE4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pHsNKiVm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hGRhRvri5RD8Q3dYNBF9nbwsKBlQUd9Lj9QWckhNeYY=; b=SHX90qE40xnz43vHcSdBSsyyUT
	CZXzbOpasqr8a4MoJQDJNbqPtpvre8rmhqLO0C+Ux1ldCC5j6/1y2Qvvc3RWxslRwNGkq/GToEfkH
	IZWTjHmHKjmaErN5qRYDtgbKq4RP20zv0+f2pSfLwd9uBpwPBa4zlKfKpZ+mQay4PuUgW93UvD4VQ
	WarsDkeo5yr1w/FLQlWIj6kfVnUtHS9lQQgxlOAXY74CzIgY2y8vyI3KqtwTrEKHWNh5bNETgll4P
	tuTP4X8rTdgK0eqtQ0f3wHZcTBO9xI8A7uh/A9ncAvZXgNVY2hhZUsduj3pmKLK9Xh38A/IkoHKoI
	RtL6cxag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJksy-0000000DLXu-1e1k;
	Thu, 22 Oct 2026 04:58:40 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJksv-0000000DLXU-24Tv
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 04:58:38 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-535179e995bso15703941cf.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645115; x=1793249915; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGRhRvri5RD8Q3dYNBF9nbwsKBlQUd9Lj9QWckhNeYY=;
        b=pHsNKiVmO7XnX9LaL9m/AkdwjA4pQs2cbeMzJpqAl0Z2a1xRRb/I/YXYbzP5hW6GGz
         DMGyKxCiF4pVZNBt96XZhdgxSTaDf6dW/akL6Ad6eNE1fsQd0SrcKRnLM5wgn8tOH8Rv
         HwsCAe2pyS+Bct99SIlnYXeeg+Q4MgeAVo56VDgpiWd6KjqzpX+dKNqW1ojrHv43iA7t
         E4NlMSilegKKHaRcMBxYGjd4GIwYdTzKD9ptps8z4KjQUiKzaLToWSMX9y2zXtwzn/9K
         /LNgAMhXNQtRgYF9jXUaZoUt3d+8ey/5yIuwxp4tTeylnk1Cx9cH2BUyRQNi38kEG5S2
         11lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645115; x=1793249915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGRhRvri5RD8Q3dYNBF9nbwsKBlQUd9Lj9QWckhNeYY=;
        b=zxayABn34IzDW2GnpMC94lqRxJFUZSgorOTLWtiwSvS35JizrcWu8/kTbSAb7O2nqt
         0FgxH2gj3xxHoN4+3O49/McuifML13S+/yDB7hRdALSbJ/Mupzxwm1eaLaazJCe6fM2z
         11e8GKg1ei3TgTcmWODZVcLxfPwsU6VGTmnGi1PqE18Pc1KvSJcxvIfn1YeeMQ2bB9l0
         Hfx3z32izrcX8nmVlnTJUymX2MjlXQiOkOumuBRrNX3kiTsRQsj5CZqKF3O6mAmZjc+6
         kIuC74+UdKbFzmfcVOYPUkeM1o5fKFAGYBKeRIOOw4teDDtrphsENrHSy51/BhN9uGvA
         K/MQ==
X-Gm-Message-State: AFq9FYKDJgoCoCR8D+B1ak3y+ma/mLjWEpi77KJbZm6YtaL8E9Tqaqjd
	i/r3Cx57aobr8/rmw7RafptOuLvvymb3qOPIq+bufyYikTVfCSKjotWf
X-Gm-Gg: AYBFou3S644t0EmAb1hpz0B4gtVzgd5zs1UF5U/wpIIntyxYmmMmTDESNw/K/ZvesGU
	r+3fvGsTH2C0fWJDKZhWNPREquM2REBv4Y/Vdn6Gz0IDpluc+mh5nHVB0u+fGf08r3pc03Xl0Qp
	jIlb20ktH3zSA/+9deMRvVex3kA+mx/vNom/shHq284NmkKC4kMAXu45lBI0cxNexx5V7fJMFOS
	smKKArTTvrxvphWFbb/6hz7domTJAK7lY6gMqQj5y+U3wsNddx+dclt9+C1pgsG2HOBRWvwY/Ys
	7jBoSwzRoIh71b5lVzPpOx5du+8hSlUod/vkJhY9ybPugO+yHX3HpU+m53gbXpejHPJnERK4LeP
	O8DM4tDq7h07g1RoJJOC2p2Uu2OgbpMHcCRo5Kkdw86Z7yR5eDnPAxydZiKw5XRpKvbX2ke/Z1j
	pnYGr/9Vun3dN44ViU08LQwI+6CQW2U4faLk7r5WnPQL+OtSZTLhkAgWrCxxOyKVBOOE81UJxRJ
	3t+cOe9WEkY85nnpKIZqv7/TRdn7GXfg5ss0oIw9rs4z6wW2te4qyGE+8ROZmGeg7lhasld6kLh
	c/w=
X-Received: by 2002:ac8:5d41:0:b0:536:5783:43ac with SMTP id d75a77b69052e-5369b826136mr64421541cf.35.1792645115375;
        Wed, 21 Oct 2026 21:58:35 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab729156sm17857071cf.14.2026.10.21.21.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 21:58:34 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] nvme-pci: shut down the controller if disabling the HMB fails on suspend
Date: Thu, 22 Oct 2026 00:58:18 -0400
Message-ID: <20261022045828.1392332-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_215837_543688_70854E19 
X-CRM114-Status: GOOD (  18.80  )
X-Spam-Score: -1.1 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_suspend() disables the host memory buffer before it moves the
controller to a non-operational power state, as host memory access may
not work in a system suspend state. It only treats a negative return
from nvme_set_host_mem() as a failure, though. If the controller fails
the Set Features command with an NVMe status, the HMB stays enabled and
the controller is suspended with it in use.

On resume, nvme_setup_host_mem() then tries to enable the buffer again.
If the controller rejects that, the buffer is freed while the controller
can still access it, and the reset that nvme_resume() falls back to is
not scheduled, as the controller is still LIVE.

Handle a positive status like the power state change below does: shut
the controller down, so that it no longer accesses the buffer and is
reset on resume.

Fixes: e5ad96f388b7 ("nvme-pci: disable hmb on idle suspend")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found by code inspection as part of ongoing, not yet
published research. It has not been reproduced on hardware.
Compile-tested only (x86_64 defconfig with BLK_DEV_NVME=y, W=1).

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..268d8fe0ac90 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3997,6 +3997,14 @@ static int nvme_suspend(struct device *dev)
 		ret = nvme_set_host_mem(ndev, 0);
 		if (ret < 0)
 			goto unfreeze;
+		if (ret) {
+			/*
+			 * The controller may still access the HMB. Shut it
+			 * down instead, which forces a reset on resume.
+			 */
+			ret = nvme_disable_prepare_reset(ndev, true);
+			goto unfreeze;
+		}
 	}
 
 	ret = nvme_get_power_state(ctrl, &ndev->last_ps);

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0


