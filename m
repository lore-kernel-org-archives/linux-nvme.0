Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53123FF8867
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 02:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FfY0M9BTIkhmdqr4tNftJeXOPdQ2SBTrOCmkvhOzg90=; b=39KBh5fI87Xkuk23LxiGKqrt4/
	Ma1fEn0hBGrza/vUET+sE8pJyZ5x+f2dYVWEQDVg7Tj5A4re2ulWFxM5b/EnksoRGNLigq5ukBIDk
	9XuY3PToomsfHtvMfHmaWw9DBr0D96IwYz2h8ef2KQaooqOSA/zVjU6AQrbh3t2pIfmtls55QauPh
	v+ynz215A21OUKQ9OZjKC9+rW93odzO5ORC3CwSd3iNxA8Envsfk+WTFRc8vqCFTWkAUXtETTZesA
	8pHDTzys5cedjRv5DEalG4p3l9p0VH2hiphl2zLvOFmg1qwVoP/eDJtNntjoXrhP5QGOlAjwulyzo
	UnHhXOFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHYCO-00000000Rpu-0z4d;
	Tue, 28 Apr 2026 02:29:20 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHYCL-00000000Row-3dAi
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 02:29:19 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-5674d8be45eso3345233e0c.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2026 19:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777343356; x=1777948156; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FfY0M9BTIkhmdqr4tNftJeXOPdQ2SBTrOCmkvhOzg90=;
        b=T5Ey0NI7DPVuatkBDG5gDI2VZ+GCh0aK4nCigQz3XOZ8LCVHl8ClMQtsnVS6FY3mUd
         mqP3tOvGWlkp651ZybLIKkv/MVFFOCTPm3u//S2ovaIDJvE2+nJdOPvEx3FcU0RcQHYB
         ZYTCHtfJ62aKoU/OOpuHlLGOEQn2d2z2PAB8KTc1gVLVoSqb62UARivGjPTXvyECRb09
         P0m+EtwHMr3gn9QtD/m7kkb8h8Gd1XHWlE7xTvcTLqlWctk1BVsdP55esA9lg2eR7pXE
         vgade56pS8wE4DIpeLwopjaprUG2lz8Fzg1+RiDOlxm4PMMpFkMh8rZ1ElCedMCCGLqd
         NySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343356; x=1777948156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfY0M9BTIkhmdqr4tNftJeXOPdQ2SBTrOCmkvhOzg90=;
        b=mG5CwW2zJg1g2kHL0VXwxmEW7VLmboRdY3SpBwiBDIeD2reG9+Sz+wXT/TRXMnVOSk
         CkU3dNVAFRaCG1VclWVCeqgCgBfIYW4KaLJ8XShkQk/nBSPn9e6MNudbpyLIP3jc3N2I
         C1Q6f8Gb0gkepgDxlQnGPke37xdlh+7ZsGepUqNalErt5hoEspSA6yI6/r4oSTjIB9KE
         kUOGMZxO2+JNC4x0dGtqj1PxVcg69aM/RcHCEEQSwcmL34R6ppPXrJjojD+tE11OTam3
         Lcj8lUQ9+/PD3oMkefaV2V2gOmCusQeVj8NiiAHDr9dybZce1jDfyxHlEYmBgpFxgz8F
         TkNw==
X-Gm-Message-State: AOJu0Yy7EchYxbGhbO2Vje3X0SVXZDS0ohkNXnQ4Evzy1PjgkkaIIm5T
	OfnTpV6XRk3DXbA5fz66dA9+RkRC8EmYs/9kwvXLg2cX5Kwjf7tU0IaJy/qmsOMR58w=
X-Gm-Gg: AeBDies9D4VajT8SzDW3ao15tDO7Hcjxj/kmAFCtjiXMXgevZg/HuYF4NKQiHn5k9XB
	Cp4SIiz4Vkjjb0Ll5W7L2cFbGAVxWPUlDT9lbY4Qdz1uCKbM40xt1Knl7ECr/jGF4fqf8IP+2w7
	fBr08w4ZV/whedphw526mufeWr1cc89QaG3+R7GDD4jghQjFiegUPYk2DJ72Jpwei4HpVPpnZBE
	ldm4h38oyjK1B/Vl5d7TVM/WXnXEfuXWxgXKCDDColIlhSoeTaTq5vWhGKsNDotXhvBVHoy8XZM
	WSEvKrOSJMgER7uVbBhjyqyfWdTDqycokBdIdMlKt+d4Ar4JvqPxq1g3903S+OGwYf1PcqR7Us+
	l8RbqCxUL89o1mTz0hUlKA9SvGTzM1jqiAHNmfKnvgpTCN0evJvh67WVTNpwtT97SSiw9CqBWHF
	n2lk09bLT8Pu3o85NrIlOxpkwDeMyBI6gsy+o33EMyASWEomP9SvUY
X-Received: by 2002:a05:6122:8cb:b0:56b:5e7e:d3fa with SMTP id 71dfb90a1353d-573a55dc4e6mr477509e0c.7.1777343355554;
        Mon, 27 Apr 2026 19:29:15 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573a4630970sm759341e0c.16.2026.04.27.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:29:12 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH] nvme: reserve a keep-alive admin tag for all transports
Date: Mon, 27 Apr 2026 22:29:11 -0400
Message-ID: <20260428022911.1288485-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_192917_908104_D8BEB201 
X-CRM114-Status: GOOD (  14.79  )
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
nvme_alloc_admin_tag_set() only sets reserved_tags for fabrics.  Since
commit b58da2d270db ("nvme: update keep alive interval when kato is
modified"), userspace can start keep-alive on any transport via Set
Features (KATO), after which the allocation trips WARN_ON_ONCE() in
blk_mq_get_tag() and fails with -EWOULDBLOCK:

  nvme nvme0: keep-alive failed: -11

Reserve one admin tag for keep-alive on all transports.  Fabrics keeps
two, the second being for the connect command.

Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

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


