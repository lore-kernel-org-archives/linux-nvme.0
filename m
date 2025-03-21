Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0445C36007
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=; b=HVuL+5zweYwM/O/7JhCC7e+9Mu
	NFISbliHOmZPCQKThgYl4PWWH0g5YhnZT6YQ7/p32/qZTYwbzPBpjkMpGDXZXWKWffleb1QIYJBWH
	L9Ko41xZlWei/+gLZafcFZJGZt4flXlm9mtALksPhUUBeRDlp7AR3GudxSgngA6/dNXUGjze7N4RW
	VKMx4qR98QgMWIR6uJNwdLQ0t16tnPe2bB/qy64F4sWvP8OrPy55Dx5Vv5RcCWqRUtB0eR0m0hPue
	rKRNyC0jM34FWQDuRMshym52FknfqWm6OVvZ5T8CshZAb8fgn0UG/vw8MwD2AhGBYWU8bFbd15hyh
	Fr1KhazQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjQl-0000000GGvT-4B1e;
	Fri, 21 Mar 2025 20:57:27 +0000
Received: from mail-yw1-x1163.google.com ([2607:f8b0:4864:20::1163])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjQj-0000000GGtq-4Bhw
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:57:27 +0000
Received: by mail-yw1-x1163.google.com with SMTP id 00721157ae682-6fda19e90cfso1366597b3.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590645; x=1743195445; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=dEfzp5QLmoIoJCcgfpQuNq3xQZY5k7wyBRnzVanP2CBuiCZ0GAyKtYrUTLLHUrKpjl
         J05kUCe44FDjoxjR4jotLzT5WnQhu8xGIbddvtT4+Z2PSH0bej0sxOnugxOeLFVfpm3Z
         BfKDyBBVTNQq87h/Eeio2hLOPu1y/yOPdYMdANEk2u1aYT5LsTsXRUM87NuQxbCwUDvl
         2ONNoZt8CKQZw1MakEP8ZRscOtrbulSlrVqLBwtcD6v150o/jgbEfIUMiP1bq8uZk85d
         d4/spUHXrkAWmpC614+u0UNcf45HjbN4379NbagHBuAstfrHwdfm22LF/j6YbHc+eDhr
         Ir2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590645; x=1743195445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=WHrW1WZJHttiynJCeOWjqMF4eW4UHE4LPEcFi4kuvP5DARvQuvmAaY2eGAWfduqVhp
         Ba7/dF7faOOiP9TJkcORNoFCPSwd7vyyKpzjHOTccQzE8fAMoLXNWW4rk3fwTdDUJuQA
         v5w770jVY18pwJPWvH3IQ8aA1sbT8JPJnC47Wzd+zFKvyz4XXt8pi7AsKzZ6NcLZMyjD
         DViAcNMOT4wJn0yDCPAqA8IpzOsPY+hI1L2Z0A5jNyUItlFuCfIIQf/kZwPZKdb1tBZV
         MtwuB0zxEnYcIZMFO+e9H5ixQeo2+Tv2WkeOJ/S+/+Dg171gE8GCSjZKKCzVtg9Ek7Od
         fmoQ==
X-Gm-Message-State: AOJu0YzOg4peEUL9em9aKMRWMIL7Ep5h6qjhYSrhTPCS5kxalj7dxffH
	N8YZtGP+fUKrCqpb0QSqooIZ82CAOOFXEDXwD31AfzR8ARNOUD+W0sxMed/Z4NzRwRYP3AbSUlW
	PPpJtHAcARP+/PZ6/Tt5idyC72vVyLC+T
X-Gm-Gg: ASbGncvgYDMMBC3cQEkMvSReRUB3gyzbFzR2iBs9MOx+daP28h5yMFVAsYAaleBV2z2
	uaI/l76FqbkIIMGJs8FmgWa1uD5c/Gk6OOhtuUef/ShLrLrqI6ZsIhS9GwGdxFkDTjaaUeK62fm
	LBbR5J2WxXNN5NdxJjVbw4sKwmIwyoF3oAuRzSyjHLkeG0Mt1ZZSh1QuCucw+mji7Mu/KtkOfJR
	BQQ6zW8fDCGBKZ2HSqZa2JJn35kD9CUTOnYz4ZoRZHBErkFOCJGoiIfBJsMCYsM3fi19kAHeZqW
	85rxfpRTgc6NTO7OHNGCMnV+Qzw2Map6+9OPUrqqTMe2oBQq
X-Google-Smtp-Source: AGHT+IE3BtRl/WSh6iaNlwOEOXdQObIPCzquvtJGf00g7uu5DR/ectGIv8i7vMguwPF28H34WDvjPk15RDsW
X-Received: by 2002:a05:690c:92:b0:6fe:c2e6:bc66 with SMTP id 00721157ae682-700c7681fbfmr8416197b3.2.1742590644709;
        Fri, 21 Mar 2025 13:57:24 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba6da1bfsm1624207b3.13.2025.03.21.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:24 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B9A6C3400FE;
	Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B541AE4195A; Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Fri, 21 Mar 2025 14:57:20 -0600
Message-ID: <20250321205722.3947901-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321205722.3947901-1-csander@purestorage.com>
References: <20250321205722.3947901-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_135726_027914_179EF5F7 
X-CRM114-Status: GOOD (  14.33  )
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

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 41907b4e1869..6c27d72e8cee 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -139,11 +139,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
-- 
2.45.2


