Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38FC61DB9
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2026 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5slJd6WExDyikoMceEsk8sBohrxbGQ7bqx/Tq+katg=; b=Kg/mCS0x/X6n6nxmImW/LMwAEN
	pW8ORd1KDitzulibVpxT0dSbWNrAnAmT91ovUpLCE+6QlaiHticUSHDhlIThvEbqx1J1toU9OCI3D
	DdKG/sM5oOEGaWpzn2XZEXhEnjF4omuAJkQnKzVyzr6nJrr11YlOdlUilmos3Ob1TwUY52kbHAvRV
	2YS+raosUHg/hs1GwPz8T79QYDdngc5HXLqAjWH92N4cWVDvWGQD3FF89PEM/WAX2Zu3DD+aB7zKI
	i7BQvIUJt3m73bbA3/Jz/apU8N8HFqw7HsB4TZGGoqbLCboC3v1D3HfFLXVBVZ21hW/W7iGGK5Vah
	4HbSwJBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x082S-00000006aSE-1x08;
	Sat, 29 Aug 2026 01:39:20 +0000
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x082O-00000006aRt-46ai
	for linux-nvme@lists.infradead.org;
	Sat, 29 Aug 2026 01:39:18 +0000
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-97cc72fe0f3so2003054241.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2026 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=idkmanager.com; s=google; t=1787967556; x=1788572356; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O5slJd6WExDyikoMceEsk8sBohrxbGQ7bqx/Tq+katg=;
        b=cwKMop+gVJPbcXFu1kFKi5VhhOKWNb63blUsaRyKFBjTkeaRIGP0VTH035UEp+Askx
         zdcCcH4UpcATUx19OLAzeZNAxr9TWiUpODXZ5EW08031BV/3fknA1NBU1Jz1gLKAOlfQ
         Fa1+pLSw8zFL6pYl2lklhKlvCVpL/dDFXPQDNR8juduVxQl/W2eXHn7lIfA/SchzoVoL
         QzXQnZ0wUibgEoJ0cFOznGh+jtMY8dhx9s00lBfMlGPhE4oE8CxiDwBLLneJL26tgDVw
         bhVGbM45F3k2byfBRDmgKloZkUqC3AXeHuvbBKICo7ceJz7uFvgDUlbet89Hx5TyhAXI
         igTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787967556; x=1788572356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O5slJd6WExDyikoMceEsk8sBohrxbGQ7bqx/Tq+katg=;
        b=AcGfPSXy5734duNhpMjCT4RzQFumrpNwVdpt7WUSGEShrhJ9+YZs0lFkp1v71KBjJR
         UqONfNjnZvJv2cW9JJRHhlI385Uff1SJUV/DBICQvUk15wXYQk3xocHMB/PpGBJP9E9Q
         /UdMnzrtfvx0hLXT086rhfQuSeppAHt+8SvAaR0sedNbg1QOQA7XZ2jTpfMWnGXFR8HF
         gEAKqrlkdA4oPyi42DCPUBFSeV5QBQm7wqvHKy+gDqZMCL1FaxWSTNwroivMJVB83bL2
         TSNsMCv+pTEhrJeVRaw2xTYQ8aovbtPfdmAPHn2HCEK2l/Crw5mvsE1n4kjk5OaU7Jeh
         6MKg==
X-Gm-Message-State: AFuF++njttNooo9iBc8vGXOuxODoAEb7E+AeihmNEu+7LrlIpGL171zM
	7QwkRK1Oyh3Xed53cmlVI9Cb2h5jTxSmaDsCaEzr4AhK52gwEyym0Q+KCdPMMjaflXU=
X-Gm-Gg: AR+sD103GFJZDW/zrUJnHw//IMKNsfZFlHMDlgPWRf9A7Py5ahd6fFaOvBD6PZDHxb0
	NToyHEnt9v4eb4XZ7DUJ4EafCEUOz3n8ctWPLxsovalJH/SL4xR+bRtnGZOmDM6OWhlk7IT6yOE
	ovvVh/bJy/wn7b3yI00IDyFHySt+HhqbVqcjAphvsPMI1GHQce7Ac2r/BcZ4EH7+bHGtbE4Jtu8
	toxTA1LL0+zSWYBcseadqcmx1uJ5P4iH7/Y2gNsVZmdc0R1gqEFsl3sSBTdhdg6h82t0KRS0Erm
	/erQf4Pa7cUC7eY7+DngmDZhMA2ZZLfQZHKyOxVV2axM2jz4FwWjRZRYZJhyX4u78TeT5muQzU7
	FNgaUuvxzudE+6VDkHl7IjaVicdOwhQ3Y0o/5aMjFR1gTf4HZT4xq8Z1cLE5oCFLAY/5FwwJW5+
	nAz5Hff4G98MUzHnqDcuxkePFK6zFOYOKGjE3j6Il5uSY30brv6XyF0eXqr8xfi1JzxT31mHrNI
	XFbi1OVa8xMN6XUL9jjJn2iN+rHvia5QGVTJxrhPrai+q7/j2LnFvRi9VSHutdtb27c
X-Received: by 2002:a05:6102:3c0e:b0:787:ebf8:77ad with SMTP id ada2fe7eead31-787ebf89425mr295346137.18.1787967554199;
        Fri, 28 Aug 2026 18:39:14 -0700 (PDT)
Received: from localhost.localdomain (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm2414216137.0.2026.08.28.18.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 18:39:13 -0700 (PDT)
From: Alfonso Kuen <gerencia@idkmanager.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alfonso Kuen <gerencia@idkmanager.com>
Subject: [PATCH v2] nvmet-tcp: report a bounded MDTS instead of "no limit"
Date: Fri, 28 Aug 2026 20:39:00 -0500
Message-ID: <20260829013900.10392-1-gerencia@idkmanager.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260828222356.1264-1-gerencia@idkmanager.com>
References: <20260828222356.1264-1-gerencia@idkmanager.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_183917_061648_8F296D84 
X-CRM114-Status: GOOD (  18.62  )
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

Since 4a3f00262a04 ("nvmet-tcp: bound SGL data length before allocating
command buffers"), nvmet_tcp_map_data() rejects any len above
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

nvmet-rdma has advertised a bounded MDTS since "nvmet-rdma: Implement
get_mdts controller op" (Max Gurtovoy, Mar 2020), which left the other
transports untouched. Do the same for TCP, using the same 1 MiB value,
so initiators size their commands to something the target accepts
instead of discovering the limit by failing.

Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>
---
Changes in v2:
 - Rewrite the rationale. v1 described the sgl_alloc() order-6 failure as
   current behaviour; since 4a3f00262a04 that path is unreachable and an
   oversized command is rejected earlier with SGL_INVALID_DATA | DNR. Both
   failure modes are now described, and which kernels see which.
 - v1 attributed the 32 MiB command size to a "generic 32 MiB ceiling" in
   the block layer. The generic cap is 4 MiB; the 32 MiB came from the
   target's own NOWS raising io_opt. Corrected -- and it sharpens the point,
   since the same controller advertises an optimal I/O size it cannot serve.
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


