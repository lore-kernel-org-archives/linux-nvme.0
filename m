Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA124CD342F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJY0XH46FnKbqBjxUWV0RGCsDLluhmI04meViUmt0WE=; b=No/mZ+X3zbw4ucIlqzDLSNHeb8
	PQ+ZnqOgDv7g2C0c+nFaa8Ya5fRK1DeDjZ6ZM9B1Lz2A4r9wSxuhnyWblV168kBAIvrI000MOAgtE
	4X1VvZTk9Ch1lNhaB+S0TnZYOrWbPkrS5z1LtF/wLWCFCrmP5z1BCT8zmfcACK+HQ/x71mePiRMZ8
	awR96Zur7BmPbj3VNZsR1bH1kesk/Xpyesrgx6nAtRg60VS0uhm/x/rtWBKVDIndCfOLU0pblaNAz
	kItW1KkpxPdyIrYZarrUP9dZDigm50eG3J3lUyJthcL7waLgWFeJ1bEVbGVeZgW5svRo27YRvUG2A
	zN8xVagw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLRz3-00000007TiU-3YS8;
	Fri, 08 May 2026 20:39:41 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLRz2-00000007The-0DUw
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 20:39:41 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso22804301cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 May 2026 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272778; x=1778877578; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJY0XH46FnKbqBjxUWV0RGCsDLluhmI04meViUmt0WE=;
        b=DWre6OVvKwkblWg1sEp05gQ7KmEPl7E1uGjZrlDTzfj8nnWfAn6dnd8H5BP0e8VKBI
         b1prmADwfoIiEjxHgHXDKAY5f2J4rwDgJXOBOs8DdhNbmOILayWR71HoJMFj4Ss9kns5
         TSQkAwZKVDXRDn3Fuijm31Qdlu5v/KGlmkVxW8XV7Rjgqzwq29gmhHMg465q9bcZOGV/
         RsPWcMSpveH+Y38/37H+F/urUN9qpiVIunj5g/0IZX7z7VYgRNBjaheK7RpLB1d30MpX
         s9OkQ0ub4Wl/gPHyKFlEBTUFlLLBSkvC4d6FpCUXERyMaLiBU9ixS4URTnWhWGrvHnfg
         /oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272778; x=1778877578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJY0XH46FnKbqBjxUWV0RGCsDLluhmI04meViUmt0WE=;
        b=d7254x27B8tAODlSS8MEmH9HcGqnfz7z24taaAQYK8yet22+yh3iK/sfmEZfvjDwuT
         CzRsPg38CG7r16qx/ZloDc5hv++PFbmdYIzSQpLuD5jrFoaU0/RudAXI7rXQXA2TCsD1
         J5EBXT3OK1tHLOEyieqC67I5l2qp1vqqiMApjQuOG1WchJaPuTKRfDcHIf2pqqD8U9aw
         cDTKs0X/rcNGfo+WfXWhv2clQfxFR/ulqSb6/YANQys+aAEEJoxhAAS6Fa/OYvLXZqRT
         PEDhkBP/oxpbDVoIYoLivAeFJ3iOG+Y56EAWjk/lDjs11eNlyHHdXnKtc/yWF62C57qK
         52kA==
X-Forwarded-Encrypted: i=1; AFNElJ8sj3UungajRyy9+0WE56Tm1yOh+lYaObi5pf9bCuTaHSJLJtSDXYxBKzFDpvdyrk2qRrlZuCf8Dvtx@lists.infradead.org
X-Gm-Message-State: AOJu0YyGEQR3hFWZrnF4Qq9R2JHFbxyphyeoouYIgSe7C7jWshKEL11A
	BWPgTGA0pONomvMc6hlGNx4ZZxVr8iwtSKslL8dtPT0ztQkeXarnU/Wf
X-Gm-Gg: AeBDievwqjkG1mKXWBITmapHY4Z67qVBz9EhL8AOB2CTnrDEVqyTuHdoGUlvlw5cVxa
	+L5EltTT9yo5PKwZYFJMQ3+HeBhIMWIl7Ak20Du2MuxHPEhyYCfdGhsvBswrhyloMhcXVy1Gfbd
	se4X9hdsjiVX9VxLlwAD3ZkaZ/EGcpBlzo7mJGtVYcBjB1h5VIlISxC7zkJbSEs/gBYcQaPNyl2
	I5JNClsPpbV4qholMe+47wEPKdzLeVc3RFYa92bGf/GWnYhwLh6Y+Zr9lLASmojuioN27owfnnU
	1QXQFD7akOa/zRCkpyVNPSu+TAwYlqUDlOtsFLssyeGk59QMH8G54sEHAwcTerZItLqV7lJtU6d
	vLo9o3uMwt8a/hX6A/M/LEeZWUdyqQqRdypvBln5c64jXPcC3DiyWW3P0ivzJcvg2NDQmUh3LKL
	bgd+fJ+LJ4evDnokr9QBpRRKSUSF42B+ZJ5TMBDPu4ik9+deA1bfZ/Jlrva2j5wSbPkz6EQNSu9
	qTNq2nEQTtKBAdYNHNk
X-Received: by 2002:ac8:5ccd:0:b0:50e:5b04:810b with SMTP id d75a77b69052e-51461f9ddc1mr208775591cf.32.1778272777936;
        Fri, 08 May 2026 13:39:37 -0700 (PDT)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0fa5sm29137021cf.16.2026.05.08.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:39:36 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: hch@lst.de
Cc: mlombard@arkamax.eu,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	gregkh@linuxfoundation.org,
	security@kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH v3] nvmet-tcp: set and enforce a default MDTS for TCP transport
Date: Fri,  8 May 2026 16:39:12 -0400
Message-Id: <20260508203912.320938-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
References: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_133940_102574_457BD799 
X-CRM114-Status: GOOD (  13.66  )
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

Unlike other fabrics transports, the TCP target does not set a default
Maximum Data Transfer Size. With the configfs MDTS entry defaulting to 0
(no limit), a remote attacker can send a CapsuleCmd with an arbitrarily
large SGL length, causing sgl_alloc() in nvmet_tcp_map_data() to attempt
an excessive kernel allocation that triggers the OOM killer.

Set a default MDTS of 9 (2 MiB) for TCP. Enforce the limit server-side
in nvmet_tcp_map_data() by rejecting commands whose SGL length exceeds
the configured MDTS, returning NVME_SC_INVALID_FIELD as required by the
NVMe specification. Admins can still adjust via the configfs mdts
attribute if needed.

Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..098cf877c358 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -25,6 +25,7 @@
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
 #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 #define NVMET_TCP_BACKLOG 128
+#define NVMET_TCP_DEF_MDTS		9 /* 2 MiB (2^(12+9)) */
 
 static int param_store_val(const char *str, int *val, int min, int max)
 {
@@ -422,6 +423,13 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (!len)
 		return 0;
 
+	/* Enforce MDTS: abort commands exceeding the advertised limit */
+	if (cmd->req.port->mdts) {
+		u8 mdts = cmd->req.port->mdts;
+		if (mdts < 20 && len > (1U << (12 + mdts)))
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
@@ -2077,6 +2085,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	INIT_WORK(&port->accept_work, nvmet_tcp_accept_work);
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
+	if (nport->mdts < 0)
+		nport->mdts = NVMET_TCP_DEF_MDTS;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
 				IPPROTO_TCP, &port->sock);
-- 
2.34.1


