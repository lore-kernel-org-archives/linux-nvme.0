Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3214C61DE2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ba4TYNQwJkIIEP9Ptfm6U3S+ptJAfpuHjbRlL4XIV28=; b=BtWQ9V4s2J/K/+8vIyr5fllkmD
	aNP/Ysl5zDUgZFTRyDt4MHZhVto9tVhJR9hfm3GGUq5gZOep97bb75goVudhJ0BVpc4UOpEzUw+AN
	mApp+dGvKTuiJkQOgBJ3D0O3+jsN3INkcBQ53T9+Fg/v6ilG/l8Nn7Ne/BaZ/20pDdYYKwmjhMZx0
	7IWT4mBf1jsRQPjGp4dU1p8u4p4WsXncl1WPZczE0AtcWP7kRagDqzF2mUrxPnfoOgcPELQaJZG5r
	dwy5pcUKny27IMp8/qNwtzNvSnTwOxVSbsf1mrfXtHoROy3/g425EXIYMYr2JTOoVB2pY08jr875I
	O1aksGfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0qFM-00000008Inc-0D9C;
	Mon, 31 Aug 2026 00:51:36 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0qFI-00000008InH-3o6X
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 00:51:34 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-97ea7f0d417so152817241.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=idkmanager.com; s=google; t=1788137491; x=1788742291; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ba4TYNQwJkIIEP9Ptfm6U3S+ptJAfpuHjbRlL4XIV28=;
        b=HWqHv8V7JJ6ZqvJY+HBla0kzXTlrfPIAIqIbamt8Vg8QQ60a8mGhkqd+1DydJhKA90
         K7ho97MLszuNBw0DdUXGb7pEovHU4iYEP4dm1PaR8G8dvVj59p7FqYNWLsAa26y/hqm3
         Vy8paj/8P81MOtNQeNzZ3P6+DuZYmVyV3NAx6Qooiy0IEBKGV+HB/sxDfIzgnb5P/K6g
         Hr7EiCvR5zCRcIRzVwY82hIhu3l4MucqNblOJpvI/PwltVX5hL93Hfy4wxJL+XmHePLx
         vA6if54jQVAa4fuMH5FL697zQ9JQd6Zqne8LNsZgW+O9pNnF3b5l3CdLXqHIxVISE2HC
         Gw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788137491; x=1788742291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ba4TYNQwJkIIEP9Ptfm6U3S+ptJAfpuHjbRlL4XIV28=;
        b=CU3X1Davx66ZhGCy6oFaQQboQnfme30XY3nYIGocND2Jpj2GX42nKkGRRhDT2eG+bh
         m8HPqiGZVWT3Jh/FjYVamBnR9xI+rPdXgEHo8nSvn9yEvpoeiocx1xUj3IhjcaMWCukZ
         S1gZQ5NZGL8nHEY680lTMF0f4b0VLJw6D5ixpW/Y4V3KgoGnpxyPcbSq4xvJBVXLuurU
         3Wjfthn08TyWWjLuwlR0mzGuDBgb6Qg/xV1Mr5rBtptc7uUDSa4XG0bY8Hp7NOsXtBOw
         iw/h7vQRdtT4A949HvqPmrS2F5RTqFLRI5CYs1ZCLdCsR93JCRs5VDEL3CqMWXJLHxcr
         5vJg==
X-Gm-Message-State: AFuF++lQ4o6rkY7UVEEIPf86bRlPlrJN6aaFoOndk4qWgNvQSoO6B4dM
	XB6LCf7a07nmga000pJP2sQMQljzlmbpn0Gdwry2ll2MzbMJB58L3PnoGOsrWcrugj4=
X-Gm-Gg: AR+sD106/MHErYGzbeztcW0lixRY6Cjg5Bn9HGazqmuLAkP1kETepUS3BSEKmI1iQ1R
	mciMTjYZm/YvBx9vWAjwbZavmnxLdZ8JjAv9WOdqHSLTUd6C++l3DZAZ/Xckf9GrIZAhNm1KPAR
	D3R54GKNZUKigD/S8ojzXA37O2k2DCkcJr2Mj/+N4UMYZPEJmMuyLNJzklO8NQV4Cf1kVZRqbW+
	Iu7xFibPFXeihsMc5EaEGYY3ePnq3mtWTyLRxeK+Wb4RsBX8imkhjE7c3Wx0nQuDhLh2oLpysTi
	vNHFjmjqb6RA8akkxJCXOmwjJmbIMvqfunskuRXL5PS1ZgAudOntX+tGsP3H6qtBBcgYEpcK71C
	uZBn/LCSW3JZhUGMHpOI9f1ccFRXtBzSecihfrqNJFq5SHFabdTyVbzGhiuOxofOuzgELtUGd0i
	Y1EDyvoCTdKBOHuH/2svgpCdb/+s7jMFSAUu5+B1c10S6iXNeg/Ay3t+NlCYRUkefaXtP5xaka+
	7SxlelZmJ2xYUQnceBqnEmju6zff6ClOjrQdaNwzi65WLz3LJYtC32Z
X-Received: by 2002:a05:6102:80a3:b0:789:3f43:645b with SMTP id ada2fe7eead31-789ef7277f6mr175545137.2.1788137490503;
        Sun, 30 Aug 2026 17:51:30 -0700 (PDT)
Received: from localhost.localdomain (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm5757890137.0.2026.08.30.17.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 17:51:30 -0700 (PDT)
From: Alfonso Kuen <gerencia@idkmanager.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alfonso Kuen <gerencia@idkmanager.com>
Subject: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no limit"
Date: Sun, 30 Aug 2026 19:51:16 -0500
Message-ID: <20260831005117.142713-1-gerencia@idkmanager.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260829013900.10392-1-gerencia@idkmanager.com>
References: <20260829013900.10392-1-gerencia@idkmanager.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_175132_990574_66862556 
X-CRM114-Status: GOOD (  19.16  )
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
to the port value (0 by default) and identify-controller advertises "no
maximum data transfer size". The initiator believes it:
nvme_init_ctrl_finish() sets max_hw_sectors to UINT_MAX.

What the initiator then issues is decided by the block layer. The
generic cap is 4 MiB (BLK_DEF_MAX_SECTORS_CAP), but a namespace that
advertises a large NOWS raises it: blk_validate_limits() takes
max_sectors from io_opt once io_opt exceeds that cap. On the array we
measured, NOWS is 65535, so io_opt is 32 MiB and the initiator emitted
32 MiB commands -- from a controller that advertised no MDTS at all.

The target cannot serve those, in one of two ways depending on the
kernel.

Since commit 4a3f00262a04 ("nvmet-tcp: bound SGL data length before
allocating command buffers"), nvmet_tcp_map_data() rejects any len above
NVMET_TCP_MAXH2CDATA (4 MiB) with NVME_SC_SGL_INVALID_DATA | DNR, so the
command fails hard and deterministically. That is the right response to
an oversized command, but the initiator had no way to avoid sending it:
nothing advertised the limit it was exceeding.

Before that commit the command reached sgl_alloc(), which for 32 MiB
needs 8192 scatterlist entries -- 256 KiB, an order-6 kmalloc. Under
fragmentation that fails, and it surfaces as NVME_SC_INTERNAL, a generic
status, so NVMe multipath does not fail the command over to another
path. A 1 MiB command needs 256 entries, 8 KiB, served from the
kmalloc-8k slab, which does not fail. That failure mode is intermittent
and load-dependent rather than deterministic; on a vendor kernel
predating the bound it cost us roughly 98 GiB of a 2 TiB image copy,
with the copy tool exiting 0.

Commit ec6d20e16c2d ("nvmet-rdma: Implement get_mdts controller op")
left the other transports untouched. Do the same for TCP, using the
same 1 MiB value, so initiators size their commands to something the
target accepts instead of discovering the limit by failing.

Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes in v3:
- Cite the RDMA change as commit ec6d20e16c2d ("nvmet-rdma: Implement
  get_mdts controller op") rather than by patch title, per Sagi's review.
- Pick up Sagi's Reviewed-by.
- No functional change: the diff is byte-identical to v1 and v2.

Changes in v2:
- Rewrite the rationale. v1 described the sgl_alloc() order-6 failure as
  current behaviour; since 4a3f00262a04 that path is unreachable and an
  oversized command is rejected earlier with SGL_INVALID_DATA | DNR. Both
  failure modes are now described, and which kernels see which.
- v1 attributed the 32 MiB command size to a "generic 32 MiB ceiling" in
  the block layer. The generic cap is 4 MiB; the 32 MiB came from the
  target's own NOWS raising io_opt. Corrected -- and it sharpens the
  point, since the same controller advertises an optimal I/O size it
  cannot serve.
- v1 called the 1 MiB SGL an order-0 allocation; it is 8 KiB.
- No functional change: the diff is byte-identical to v1.

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


