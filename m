Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73959C79FB7
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=; b=YrA6HC9B9szAlHIeAjfjrYB20V
	rEz83oKzNb+ZVfBn7VM+GrLm0VC/lXE9s1y7uRjQONyhU5ijRzYi0n/b8VyZXzx2G4GZkdTld9azC
	0gYrc200vzXlqyrB6BQhjTef4VxmX3jhEfNn3RSfdBoBtUfwCgMo70oz8f0j822Ojyw5yXFMTf1wq
	whuY6JN6+MgP2Tz9Pm2RjYNnpJKrcPj2cNA91wWoyl+Z/zBfuQTAUlRsoJzmIz8jRl//6ZugDDwvP
	n9COuFgc85TyvTKfgdeG8lg/6i95k6sWOHRq7fqSnhqaxTzbYaF1stjatMM8QyNA2yzG9UYNWH1YP
	MnxY3W/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qn2-0000000D0od-3kv9;
	Wed, 09 Sep 2026 22:29:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qn0-0000000D0m4-2C3u
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 22:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=; b=UVNUfdNEY67m4Uh0pZRMCUdm4O
	eKZFF8l0URm4uMWEqczD4ATIyanIQZ1oRsg5KuFB0RshM8Q7XKckiUS7OzSLMKcAEcQv2tMkg0wzm
	ys49ci+/hPrDqMyIJ0Rv7nj5dFnsAtyf0laGn2Dy3bCwQPtozkFdmkbd60MW8GX8UJOj1jg+y5P2n
	xmOfUWbedZ+xyxpeXNhGEzvQb9f4sjt0r1PnpfWJygPR51nh6kmkDeTCZl2dZwclXTSY5JA1pmvpl
	NXD060XwHtoN/pNJ7DOQvIbiGZ0h9Y68AobkMtx7JzQ6BlEUwAOsCQAzCilM9LvY6SnjqFC6FGTc/
	7d2WT+3Q==;
Received: from mail-oa1-x63.google.com ([2001:4860:4864:20::63])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Qmw-00000001kxa-3Z7v
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:09 +0000
Received: by mail-oa1-x63.google.com with SMTP id 586e51a60fabf-468116f78a7so157036fac.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=;
        b=RLecHzvn+8fGFMSLhgkKQbpo/o1g6VXiXhCtXhB4eUaIVsLTZJGYWK+m9DXfttAYLN
         DW0J/SRhEBv1D57vJxr2Opi97boZC+/gqT7HhhWVm0PhG9x+2zkBva15r+ewnj1xcCnk
         go91kqIOXwtrPWdC+MYpAJU+XiNV0J+q9/SJrlTaAKSVienvnXFVrVj8+Rq18NoTe2fH
         jrVt6UTPClE5AB72UJaRm6i8w3+kY4UsfPMcKk1Cp/YV5mlIHB2W3ZYUdcX7Fl+YKYiG
         3LmSfVzgwHzVF0BPjPiuBWIUzKOc6B9BM6n3y/NZehKiFR8MF+CQ5BSkcJ1MHSSgMD33
         oX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImWYQroYLYn1yUntaG3yDyG9poZ7C84uz/cQieFkqu0=;
        b=JF0IXIOUQFaNIxPK1ZjVzuCEsa6m8/lypbEU1CSqoYy/T/4kgbvg5rZSAtLP8/Uasw
         BbxJ+2BfsiRD92V95r/En3r2bO6m7XyBMkNECpI5CxVuDYi2upU1RKlUeAB2GjtKGYCK
         PjGu3vRVf3KNHYtqHNdFUIIxoLQiBEXa5CqCoQO9EZgXLZ5JhFoJr6LLmKS/FcCXXG38
         j/+3pjiSjMM3SVIDRWT9DfhmTsjzw3r4RrS8NlgLYNLRqIoHD4pW6Ln05D4fuVmPnhLd
         jTK2piNg0xgX4A1IX4NvLp1U4VZrWcne+3J1U4XwU1vkCYiFDPzgD181NCw0bHEgxSmO
         DCmw==
X-Forwarded-Encrypted: i=1; AKwUvBxh5MHWXfw6zIp10IBwvRwApf4bDUpOvbM1t+wL2u5vsR/YBhS1QuagHklYrkP8oWGYIleSstB5br96@lists.infradead.org
X-Gm-Message-State: AFuF++mTPPGNMe1JZMXvVZC0HHe0nl8FkrIE7q4GwcU3OrBQ44hQnq1+
	4GC1m+AwZq7UP+a9JkKEkNgYgggsjffMwOYuy7unBHRaAPmvd9yTbdXxUkT+L9q9u5tTagAHbBl
	GH2AlntAkn5IR09CFmqC+dS+20uUtlUYd+yV1
X-Gm-Gg: AYBFou1ycyhv66x63f7DXe4vaPjmwpztZ2TLZI6ipGmizUNTNmF5IjC6AmixsbUwpNV
	ZLnAOtEV9STSpz4c1yHKSd/PupgcAWmtZfB19O7hJ72z1tcwLMWp9KKe9C95z3L1Wy6UAToUc5o
	LT5AxHpjJwxe6y98BLFQp5Qbiawa2wSQQiyY7saIK3t0dkOkIE7+lCBYMKwcOAc8tAkPNbUuPkh
	7kbBjaf6aqGnW8bRj7e9hQKhnkGVSUiXxgb5t2p1VeVaxy5OfnFzq9H4T6I5LwSXJAH75OqQcpr
	TsDiwb0kzynx1xbpCendEVnB/acRqvME+gm0eMtsId4lbnQYYZW8OaKWxzYJIHVNe3MfT0mCAKf
	XzeyJTVaNp/OBdE88AaSx1ay9yRIyIwku
X-Received: by 2002:a05:6830:f89:b0:7ee:363d:ce16 with SMTP id 46e09a7af769-7fb76e3cd73mr16877278a34.0.1788992944121;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f9f6aa689fsm2773280a34.5.2026.09.09.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id AFA1C402BE;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AD682E40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/6] nvme/ioctl: support fixed buffer for metadata
Date: Wed,  9 Sep 2026 16:28:36 -0600
Message-ID: <20260909222836.2475352-7-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_232907_516252_861418A2 
X-CRM114-Status: GOOD (  19.00  )
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

io_uring NVMe passthrough supports using a "fixed" (registered) buffer
for data, but not metadata. On high-IOPS workloads, the pinning and
unpinning overhead for the metadata pages is significant and could be
avoided if fixed metadata buffers were supported.

Define a NVME_URING_CMD_FIXED_METADATA bit for the nvme_uring_cmd's
flags field (which is currently required to be 0) to indicate that the
metadata buffer belongs to a fixed buffer registered with the io_uring.
The metadata fixed buffer index is specified in a metadata_buf_index
field replacing the existing rsvd1 in nvme_uring_cmd.

If NVME_URING_CMD_FIXED_METADATA is set, the metadata iov_iter is
obtained from io_uring_cmd_import_fixed_metadata() instead of
iov_iter_ubuf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c       | 21 ++++++++++++++++-----
 include/uapi/linux/nvme_ioctl.h |  5 ++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8e722184ecf1..4da8cf92c2e0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -488,21 +488,22 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct iov_iter iter, meta_iter;
 	struct iov_iter *map_iter = NULL, *map_meta_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
+	u8 flags = READ_ONCE(cmd->flags);
 	u32 metadata_len, data_len;
 	u64 metadata, addr;
 	u32 timeout_ms;
 	int ddir;
 	int ret;
 
-	c.common.opcode = READ_ONCE(cmd->opcode);
-	c.common.flags = READ_ONCE(cmd->flags);
-	if (c.common.flags)
+	if (flags & ~NVME_URING_CMD_FIXED_METADATA)
 		return -EINVAL;
 
+	c.common.opcode = READ_ONCE(cmd->opcode);
+	c.common.flags = 0;
 	c.common.command_id = 0;
 	c.common.nsid = cpu_to_le32(cmd->nsid);
 	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
 		return -EINVAL;
 
@@ -539,12 +540,22 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return ret;
 
 		map_iter = &iter;
 	}
 	if (data_len && metadata && metadata_len) {
-		iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
-			      metadata_len);
+		if (flags & NVME_URING_CMD_FIXED_METADATA) {
+			u16 buf_index = READ_ONCE(cmd->metadata_buf_index);
+
+			ret = io_uring_cmd_import_fixed_metadata(
+				ioucmd, buf_index, metadata, metadata_len, ddir,
+				&meta_iter, issue_flags);
+			if (ret < 0)
+				return ret;
+		} else {
+			iov_iter_ubuf(&meta_iter, ddir, nvme_to_user_ptr(metadata),
+				      metadata_len);
+		}
 		map_meta_iter = &meta_iter;
 	}
 
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba67166..93973f636b48 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -68,15 +68,18 @@ struct nvme_passthru_cmd64 {
 	__u32	timeout_ms;
 	__u32   rsvd2;
 	__u64	result;
 };
 
+/* struct nvme_uring_cmd flags field bits */
+#define NVME_URING_CMD_FIXED_METADATA (1U << 0)
+
 /* same as struct nvme_passthru_cmd64, minus the 8b result field */
 struct nvme_uring_cmd {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
+	__u16	metadata_buf_index;
 	__u32	nsid;
 	__u32	cdw2;
 	__u32	cdw3;
 	__u64	metadata;
 	__u64	addr;
-- 
2.55.0


