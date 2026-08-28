Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE6AC61DCB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w5YEgwBz/daywwMQ/sIV3Y54o6ngA3GwC0jiF687Iio=; b=PVEbD6F0isBriz6vFldzRR3mMU
	VrPw39d23C8ggXZbpA+fvXXuSQSDh1T/1LngC4I+myClhpLqNGAWGPDHQsj1+qW/5pTvLutiPKmmK
	ZqgF4f78NSf5oSJDia4LUzLBlxPu3vqVwqIn72xhQ/myeW1kpXBTMklckTMbyDZzm5UptJprqoAHB
	5soXDuYotoatQ3L9ufHAjlhux7a8PfXRML8aAE2Xptql/AzCo8QQZZY3yXXL+eRQufbuae1EtwMv4
	aCdrrpATss9Tw6aUobYFrCEPj/c991D7oL0LDF6hLa6GxBhwy3zlBQaNl8AubaCCOXa7SY4tSv9GQ
	JJUobaVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x04zy-00000006T61-3Na3;
	Fri, 28 Aug 2026 22:24:34 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x04zm-00000006T5G-3wYG
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 22:24:33 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-779d18ef706so838514137.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2026 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=idkmanager.com; s=google; t=1787955861; x=1788560661; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5YEgwBz/daywwMQ/sIV3Y54o6ngA3GwC0jiF687Iio=;
        b=c48bSnw2QypA9+Izo3LNYrTn20uc98Ig7J0lCQGPt/okmRPVQdDISCs1W6+e6nwj5E
         NwhImilQQ6CsoEe8VjMBd9qWIUqiMUnaB9+lfXP6aVI938g3v+BO63TPTNzirfYPiP63
         RxgXpAI994S3Jd4pZg70/dh9Km1JkWVaqr7/dgtc977qch6jfBc/FeT6njJGVZs6wpmm
         9Odg4IPglP/96MsflVPj9qDnKvg8cbUKeREav4FiAAEfOOZN5EEnEdT0s8VfjY04U6IC
         kFie2jRz8qyggdI4JHW1DZE333uS98Io/dN5XyXh97rNrke2270sGFnxILZ1YU840z6v
         Lgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955861; x=1788560661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5YEgwBz/daywwMQ/sIV3Y54o6ngA3GwC0jiF687Iio=;
        b=C/EfOcQZo5AsuQyDrAr/vAZa47swlzQWtCEUv6uNw8pLZnOFr9XNdQfBi9WhCMdQM4
         8LskB1gda7D5NkhRaqyI7brhldAI8llyxS5+jIdX2JRq+jXZsGbiHgNcV7MplbMfF/+6
         JDItj9JeIu8ylSn6+OnXwdnJFPPA4Fk9kIwen4UjyrpAVLF8XWLhsh/O68UXlvkPnKBx
         SbQHo2lmVtZxBVZU9TxwXFcwHQ8QB5rtVrya290WpIvB2Yw4etinaSMaYHBGJdWCMtf/
         rsM7H3RDDoplHajI1PcIk13rVp88zXZST1qiuC3tY3sguo00VqFMClcd9SAd4fSUXFKs
         nYUw==
X-Gm-Message-State: AFuF++n58QCAvPBd0owXPegolDI8ym2KViGcP80xsuDsDD9cpbrHDJWs
	JTgncnL7SeuaCu0HxZZ0EOn/7aRMi0XR6e0TqcuprsSDEx/wo+g67H0uolHWQap14Pxm/pyt/Rk
	6fsvD72A=
X-Gm-Gg: AR+sD10ieI1DGuLcxh8H5T6L3tMCrNLgKDMUsmmNCiiLI9rtHyMIcoStgiE4hE5MI/2
	x477+boolMPjDNHJH1+Knq+6AuDKEibUGlHOnXFxfF+PPpsdZSfVRgQe0DuUPcPIk8lKm5W3wNM
	aiYX4xpbHA3DHCq0HT+G4ONaJ0x3A0c4RRVAJ4m9NsGhXzM8MzingG5oT7orcfT2np7Wqvc6u3U
	v/BNmTCj9NOrRe7ruleEGvOzmEHXfnpbs9XLXbaRlxunDHBaBCTewTRETYnbA3aeACLsCTdRc+E
	d1sGXyybC/CWugPafCLAyLyIaHuRwY9A3Nkam4JLoDxAkTpxIKblprSXIXWs63WNcGPadFROWxn
	s2TQAHukUkuhlD/J9iIR0nq8TEHr4q6B/u2J0Oq69UvS8FI4fP5yF6rxQ3y23psHbElRDb7T5Iw
	lFv6qmOOPr0xsK6v/syWpjIjzLKfxCbhJL1rkurcEYhSw40jx2W1aesz1mprZ7x+4D73UXvlDsl
	zqmVIW6Zem5ms4YYWxrQJxhqezeBA2zEBvz1pfHhZCLmsS3jjNzVpkBjvzMUFqyngY=
X-Received: by 2002:a05:6102:580f:b0:786:c86c:4f5e with SMTP id ada2fe7eead31-786c86c569emr1400782137.3.1787955860913;
        Fri, 28 Aug 2026 15:24:20 -0700 (PDT)
Received: from localhost.localdomain (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e84bd6b3bsm2305936241.11.2026.08.28.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:24:20 -0700 (PDT)
From: Alfonso Kuen <gerencia@idkmanager.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alfonso Kuen <gerencia@idkmanager.com>
Subject: [PATCH] nvmet-tcp: report a bounded MDTS instead of "no limit"
Date: Fri, 28 Aug 2026 17:24:07 -0500
Message-ID: <20260828222407.1280-1-gerencia@idkmanager.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_152423_007809_2D3D570A 
X-CRM114-Status: GOOD (  15.64  )
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

nvmet-tcp does not implement .get_mdts, so nvmet_ctrl_mdts() falls back
to 0 and identify-controller advertises "no maximum data transfer size".
The initiator takes that literally: max_hw_sectors becomes UINT_MAX, and
the block layer then merges requests up to its generic ceiling -- 32 MiB
on the hosts we measured.

The target cannot actually serve those. nvmet_tcp_map_data() allocates
the command scatterlist with

	cmd->req.sg = sgl_alloc(len, GFP_KERNEL | __GFP_NOWARN,
				&cmd->req.sg_cnt);
	if (!cmd->req.sg)
		return NVME_SC_INTERNAL;

For a 32 MiB command that is 8192 scatterlist entries, so
sgl_alloc_order() asks kmalloc for an order-5/6 block. Under memory
fragmentation that fails, and because of __GFP_NOWARN it fails silently
-- nothing is logged on the target side. The initiator gets
NVME_SC_INTERNAL, which is a generic status, so NVMe multipath does not
fail the command over to another path. A 1 MiB command needs 256
entries, an order-0 allocation, which does not fail. This is why the
failure is intermittent and load-dependent rather than deterministic.

nvmet-rdma has advertised a bounded MDTS since the series "nvmet: Add
mdts setting op for controllers" (Max Gurtovoy, Mar 2020), which
deliberately left other transports untouched. Do the same for TCP, using
the same 1 MiB value, so initiators size their requests to something the
target can allocate.

Measured against a Linux nvmet TCP target with three initiators: of
~1040 failed I/O commands, 980 were exactly 65536 blocks (32 MiB).
Capping the initiator side with max_sectors_kb=1024 removed them
entirely. With the failures reaching a page-cached writer, a 2 TiB image
copy lost roughly 98 GiB while the copy tool exited 0.

Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>
---
 drivers/nvme/target/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e4f603b2a..414ba896e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -23,6 +23,9 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
+
+/* Assume mpsmin == device_page_size == 4KB */
+#define NVMET_TCP_MAX_MDTS		8
 #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 #define NVMET_TCP_BACKLOG 128
 
@@ -2243,6 +2246,11 @@ static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
 			(struct sockaddr *)&queue->sockaddr_peer);
 }
 
+static u8 nvmet_tcp_get_mdts(const struct nvmet_ctrl *ctrl)
+{
+	return NVMET_TCP_MAX_MDTS;
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -2254,6 +2262,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
 	.host_traddr		= nvmet_tcp_host_port_addr,
+	.get_mdts		= nvmet_tcp_get_mdts,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.47.3


