Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21FCCD4851
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0zgCrTWQ8Ikf4kdYgqMBqJ69y6dU30Bl10MYv8Rx3aI=; b=v5cTLsbDn0CB8fO8LkEVJSPR2o
	E8hyDzr0KPfXL+290gaurcul7CPIFPFT7609/9PQoojrgyvN2BhlczutveRan9aEGr6z6PJw+aoO1
	iz8u7bZYczkZCuhh4x6XgNyBJcF/wm82k8w9OREBgNUT4HlrOkzqjrEH8vkKMsXEOfdFg8Wok/Dwi
	uNNT/jpWr1FN2Bh0pRUE9Z7t0qwEeOWBEIYhLIAAW1HcTMt53NB2wCRU1hSNiomXbEbzIaueppZfa
	+fypLKDeFf6YCBHU+BVLyHm/C1MAhRgA7BOs+ZXsIu2GY7ecfl5qeJP9QI0JSocRoYjMP7AJksuv9
	wbcrUSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNmjD-00000007b23-1X0S;
	Fri, 15 May 2026 07:12:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNmjB-00000007b1n-2gkW
	for linux-nvme@bombadil.infradead.org;
	Fri, 15 May 2026 07:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0zgCrTWQ8Ikf4kdYgqMBqJ69y6dU30Bl10MYv8Rx3aI=; b=F+yjTBJMcKvbbjyjtJEnMNoxJ2
	sSPEB93Ofyp+xAK+HwfYULfr6M6POqOFLV0s8kOcU67NtHRglmuq9BTzREqtwZ+juQfjqgIgZe8bW
	NbKgXbz6yoGBh6/GO2TItcQGA0pqZeXXpC1/7n00ppYbsERu2+Av2xY2pu8XGhw6F8jvTXVzlnF4W
	/2krvBzd4RHw/IfCSEyydnRv4E8jqY7kY777Npr5WDACN15zqqN5DVfRMjtrEPglQSIg4mM8szD9f
	6t0MiDMErGqlxxMZaF92JcfvRcOBBRbviszWUSRadQV8npfdwrVjIK10CA7CTPzeJqr80cvM9G3Wt
	pDQxbDVQ==;
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNmj7-00000001ANt-3yct
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 07:12:56 +0000
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-95695190911so2275035241.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778829170; x=1779433970; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zgCrTWQ8Ikf4kdYgqMBqJ69y6dU30Bl10MYv8Rx3aI=;
        b=aqPJ3NJ0P8WIk9DpNcqdp5ORE/niBj1OkJUqf8D0mpWA5R6eWX/zTOxxbFeafQ2eez
         gnHpZ+kymIR+b8/hSAjf6h8JMEzGeGL4PrVPHtif2NVfDwi2fCoaDD/gSi3wRZaR+/05
         tdpOFvknHhG8mfuMvQGJX8JDTfMoVeYdkaEJDCBMa3cXXjkUUiXG/s8khAsNAmTWtBma
         qzFM984g7dEvmO0VvaUz9DOlZfMtJu8Zalrw7i0FfHT3M/LY7sOQlCdcHeQ/1JuWJyPf
         QDpI0q/sP+Sw29Wf5gE198ouw9QZLZyz5wDVUBEmoGMub+GTNABTsiyt5CvmpxObSPAB
         JD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829170; x=1779433970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zgCrTWQ8Ikf4kdYgqMBqJ69y6dU30Bl10MYv8Rx3aI=;
        b=EqLWd2HvXG2aXzzg6zOrudC9QzEVRojah29JBqhg4iGCKHPO+jaiRiVzU+BXYWGSH5
         gRkAcp71a81JGNd0hNe4T0t5DnXPM4Hk189I+ZF0/h886xjb94LyFATGp5nC1VarqW7m
         laxUeHdbUy2epANSkPUem/6XiybIrYGT/8Bx3GDtpJ8mup6B5LVR24agP8oPXo8l4WQY
         4UOACLbd3GcI8u8nYExDzgLMYX6plwOzjNNZ8gcr+yKdEJNQq9TvsMen9Hj9bbpQLkPG
         CEcieXtCjaD7UwpAfvzfkYM/r6FHyGaPeljBkdPS13eGMu4CPYkiCk5U+UmoE/0g87BV
         NGFA==
X-Gm-Message-State: AOJu0YwtT4u+4LVydcxrwsZ6MnRaKFcdzhnHDtbpFrUOU0mGylhxt3w9
	AcKRLPk7Hfz2c7TFgC8V/ta/kIFN7OK00dPfvv3Rxlw+wALaMrxIh8M5BAa9A0fL3NE=
X-Gm-Gg: Acq92OGBMJccY0Wx+Id3BaStgXxUd8YyAlek4M6zaeMm+6BZ+ICjiaLpHbf3amsrWzI
	fg3tldNAuMCkjl+S8Q4AqyGG3/3xQQ7x3TyI+4q0OYe4N/xEScZ6WdBE3wkm7oPLxIbyP4YKd2g
	YsUOAmgg+U1QMjK2B044qlyMHUfb9ESPcwXFrlneWu+8Y5KssTo/zZK+XX1uEe9o4D/rmCb1HOC
	+VBEiIjazRNTesWoBtzXGJK3wtqlcFe0vSXmtfQfjSGZEmeflJj99moSTAcmVHGzxBzox2TqhkZ
	Oo8+Aqf6Qv4QNTqfR4FRRAehqRXxoP9IA7trfMs2spVXep/+HiUB67HnEb+nWzToCGss8enLH30
	ysKwk8/JHKGoHOKjQwmqfMaVrj5wbYkaSUMyJMLbgLsvaR0cEx+N7htH7veid4B5qiq6KWLs+gj
	bXKB3Q0CdXKUcy6ceNdM1jSuIbf2zr65eRBP36ZmLZIA==
X-Received: by 2002:a05:6102:2acc:b0:631:7781:fe8f with SMTP id ada2fe7eead31-63a3e67d0f0mr1206027137.16.1778829170359;
        Fri, 15 May 2026 00:12:50 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63ccf18cfc4sm390027137.2.2026.05.15.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 00:12:49 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2] nvme: reserve a keep-alive admin tag for all transports
Date: Fri, 15 May 2026 03:12:48 -0400
Message-ID: <20260515071248.2689513-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_081254_021568_22071350 
X-CRM114-Status: GOOD (  14.04  )
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

nvme_keep_alive_work() always allocates with BLK_MQ_REQ_RESERVED, but
nvme_alloc_admin_tag_set() only sets reserved_tags for fabrics. Since
commit b58da2d270db ("nvme: update keep alive interval when kato is
modified"), userspace can start keep-alive on any transport via Set
Features (KATO), after which the allocation trips WARN_ON_ONCE() in
blk_mq_get_tag() and fails with -EWOULDBLOCK:

  nvme nvme0: keep-alive failed: -11

Per NVMe 2.0a section 5.27.1.12 and the transport binding wording,
PCIe MAY support KATO. Reserve one admin tag on all transports so
the host is ready when a controller accepts the feature. Fabrics
keeps two, the second being for the connect command.

A quirk-based approach was considered but no PCIe controller
documented to declare KAS != 0 was found (two enterprise SSDs tested
locally report KAS=0), so an allowlist has no entries today.

Link: https://lore.kernel.org/linux-nvme/20260428022911.1288485-1-coshi036@gmail.com/

Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")

Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---

Reproducer (run as root on an unpatched kernel with a PCIe NVMe device):

    #include <fcntl.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/ioctl.h>
    #include <linux/nvme_ioctl.h>

    int main(void)
    {
            struct nvme_admin_cmd cmd = {0};
            int fd = open("/dev/nvme0", O_RDWR);
            if (fd < 0) { perror("open"); return 1; }
            cmd.opcode = 0x09;       /* SET_FEATURES */
            cmd.cdw10  = 0x0f;       /* Feature ID: KATO */
            cmd.cdw11  = 5;          /* KATO = 5 seconds */
            if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd) < 0) {
                    perror("ioctl");
                    return 1;
            }
            return 0;
    }

Within ~kato/2 seconds after the program exits, dmesg shows:

    nvme nvme0: keep alive interval updated from 0 ms to 5000 ms
    WARNING: CPU: 0 PID: ... at block/blk-mq-tag.c:148 blk_mq_get_tag+...
    nvme nvme0: keep-alive failed: -11

Changes since v1:
- Add spec citation (NVMe 2.0a 5.27.1.12 + transport binding wording)
  clarifying that PCIe MAY support KATO.
- Discuss the quirk-based alternative suggested in v1 review and
  note that no PCIe controller declaring KAS != 0 is documented
  today (two enterprise SSDs tested locally report KAS=0).
- Add Link: to v1 thread.

 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..6db02ecde6d1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4850,8 +4850,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	/*
+	 * Reserve one tag for keep-alive, which is allocated with
+	 * BLK_MQ_REQ_RESERVED and can be enabled on any transport via the
+	 * KATO feature.  Fabrics needs a second reserved tag for connect.
+	 */
+	set->reserved_tags = 1;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		/* Reserved for fabric connect and keep alive */
 		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.43.0


