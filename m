Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF48C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=; b=jYt4PdpZavD/vfGLYkI+g62Lz+
	qRFEu2k6cZFHXpTVz+6RnqulvaZiST1eMcYlDTzPp+OBrKiGFRbjwTbtcDf2f7Fi0xhnsdTpmOz1r
	owO8ZjxO58o04SPJmQPhjWUYE5NjHn5VdQAKlGCoiKLGyqzJxe3HzS8CcpNe/fkWU9Bti2mcAINmT
	EeF90Va9TKTgD3XqdrgFrkf835SHpRh9kpMd9MMppWf+YWSDn7SNWnwx9I+4SGwRwUB71MKGV3apx
	i8Rb/yomVLToegauIX9LaSBYy9BKQ/eXZgHjYjfi33oxUl+QY96N1QH2IrQszMlO2Dey/OtySgCXp
	c6hZ0jYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6p-0000000GCmb-1NvG;
	Fri, 21 Mar 2025 20:36:51 +0000
Received: from mail-pl1-x663.google.com ([2607:f8b0:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6n-0000000GClB-0ykY
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:36:50 +0000
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-225887c7265so5723075ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589409; x=1743194209; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=O+LN2R4EmTdyaJrVGgqcjSsTdmRROMhVb2f46en395Cn9mDIowDcO33rzBWF4AWJzu
         LfAe7BecfXLfUHEhFXC5L/OSRduG6fa8g5SdN500jEo1DySugmEZPnaFEiCzmBiWLANl
         1+i7sh+9kM1JjdAJs+ry+IZEDQi7KWSgHfECZhI1wPrJSfcifHFp6exjsX5h/astsa8z
         GV45qdX1yiw3kza4gV53LQJGVbeeYEwQGoMylEVFpNniReVvHotSjII3zv2etZILYqes
         /4zvWcEYNXQ7OUfnKi3NWfQ6LZjmHTkr+fw31vpy+Js5TqL32RMCqTSdRv+ejxtxqwj2
         lRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589409; x=1743194209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=ksjlUNB/5AdckuDEpyt6zuQ1kKBgcH9FdqfumEeuqrzBV78czQCsZuXEDHWn9axbfP
         OTj4C0wDZ+Va5kUoEYtxp3ZnqvANkDnCf9yD6W5JfE+8ImwkAfA/PWIag/mjWtxGNBmO
         H7yW3VWDXGTiWV0ji8cm3MN32Bx9unkMpNCqSPFL8O8mVP0Iu0JLTbQQp+IoOH5RtRN6
         EIMMlzY10OxWSc1Z3QYHpp/vCNMBYbi2V/f+qveL5+b9IZWz/06wRrabrbhZ69ooot6n
         mOQwZEmcw1M+zZ20WD5vBj1rolEDTR5MhCyPwIG374C+T+YBQ4zk9fARMpMjqXl/RsIy
         44jQ==
X-Gm-Message-State: AOJu0YxuLxfVhdSMQOC0+nBXy3YT8qyu9mtEecfFResDdTT3l5ch/VNy
	3A50LH2551wQxZ2sTY1c2FfDgOnCeo94LeBmUoj/qd8ag5NhT5XUeCsdniZwbAmiZngVGIOpswv
	KKpO99ptA7W0GDfhWaKx6FCgz3KaHTgnHT1Rok8eeFw2dOoQi
X-Gm-Gg: ASbGncsX8Ni8PSxQJv71IYg8zE38kRkFuSjc9ATYdPBsMl5P1juxmNMhKSGQWcQrHpD
	LtWuFX1I6fnwOC7HIMFBOb5WliVXcIJaU8xSytuQNcY4r4ru9xYb6hKDxptG68/Gn3VeqAvYCKp
	WcrMXG4chsc4e5oG7KuJ1RbduBch///OQkkL+xrvhUjakc/bTm70X/v/A78tSOspBl+c6JkDjpv
	OmP6ztFUmsbqCZpBlG5L+jctawe10quomIhrMvFJ6+5KhpoBau4pKSYe+un/LxRuBkXUJaY0MXJ
	cDIGo4K+r7ndUi0/9/nwD0cSjmzRQJIGLg==
X-Google-Smtp-Source: AGHT+IEBwTUZcvBZMFhkgIDcLlplm3myBfiqu+iU5CfAiTL0eJfnM+kmb1uKhIfNIQG1e0czBKqqLEKuonuM
X-Received: by 2002:a17:903:191:b0:224:88c:9255 with SMTP id d9443c01a7336-227912f607cmr12626355ad.3.1742589408570;
        Fri, 21 Mar 2025 13:36:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-227811cee54sm966935ad.84.2025.03.21.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BE7F3400FE;
	Fri, 21 Mar 2025 14:36:48 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00E0CE4195A; Fri, 21 Mar 2025 14:36:17 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Fri, 21 Mar 2025 14:36:02 -0600
Message-ID: <20250321203604.3911446-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321203604.3911446-1-csander@purestorage.com>
References: <20250321203604.3911446-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133649_270680_602DFC9D 
X-CRM114-Status: GOOD (  14.21  )
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


