Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067ACD2F006
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKwfLRb6Qrx8NVhRUNrOzMLoJ9uNt8Xns28Im+bRFCI=; b=RB+HZZcd6E/m1EJVOIponyxcEU
	onI4Z/cLEcVLcBksjDL2SPrqWJakimh6MdW+1QQY8XaIJK8GKOxUR511P2yrYOZkcQo4FqcA6SuJB
	hDTBSAtA8NZaIM643ZXzsckwNu0wMsEz+23pLo0323nDp7xqXDBbShnX6ybYCtMkc89crZ41OQewb
	Px+6gNqMvxgGOtA0qYsF/+VwkKHafFKtwn9Ik8I1MHqka/IpHqOMxOkkTZN9GV6PXRHSvqp/nHYsq
	JW07do++ipJahJbwijkqLNVv3xfHhikCNDkClcgmDD+jxFvxLv8lASEvsfwXeM++BaQ78Rz2YXCa1
	/PPr6gvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vktd8-0000000FDoH-38Pp;
	Wed, 28 Jan 2026 00:41:58 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vktd2-0000000FDnP-2ETT
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 00:41:57 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8230f2140beso177616b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jan 2026 16:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769560911; x=1770165711; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKwfLRb6Qrx8NVhRUNrOzMLoJ9uNt8Xns28Im+bRFCI=;
        b=Bx6l8cvmHqiULPeDR87GIRyeFizFPbG2ujfpdE0t6jH3Niju6DnrGyk39nyZ748V35
         DbWKPVXHFQ2JRriGHVomA/Xn2xrA+FJwOkR3lUGAURYLmLBeb2a4pIX0jdh9FVZoNO6m
         ZboE8ht/poPgeG/VGrauo9oQutYaS7yHr9ilcA7bqo3GYDsJ79dCERr3zYGWQNNAubvN
         uoHHHqqPAmX/ovcq1TT7vLROudeGOJP6imxfsitgyJ93ln5uUFdTF4SbV8ec0OlPH2Ll
         j2IY7HjE5qMLLrqnrllOhnRkAmXtnPDdZhwlOElthS2YvtSNofz5jH4NzwLgZAMn7HXR
         gt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560911; x=1770165711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKwfLRb6Qrx8NVhRUNrOzMLoJ9uNt8Xns28Im+bRFCI=;
        b=SO5DxeLU5Qgxpxw8lXwpt+tGeqWVM2LH+LsvI9tKJA2cvVxFqgt+WN/eIqYy1fZls+
         /3FAC4TOsP7tK24x9ZyRLRBsooi+Xacjr2aVmL355Z3KHxN2H5nxJiARrWfoODJlaDwD
         NCRas7HZTDIB+annxKWHQe2MkgUrSn2xNPKZL6p4P6h7TJS8p7UgR/Svvh4dJxSpMU/B
         rmMWfJGN9Lj23f+DQQtcGO/XyG1hfzJ5wEbGLLq3MKX4Ylmw2e9qP/1MTYmcIZhrrX7t
         9ukXFJGARKohByplLjAWnI8u1huBpC3vr1PvLjkOTkbHlHSk7HyrHAEFhf/LvYnvjsZt
         +PXg==
X-Gm-Message-State: AOJu0Yy8mRyNu7n7cqasdicmXcU2EKA3e6dsdYXY4Wr48EMT8O+bHy/3
	IAQ8MMUHADNqsjxqeklqaM/CTJ+ysQgra7IjJgC7PesgoGLOMgfZs5KjfDivQw==
X-Gm-Gg: AZuq6aJBo8G8B8HgPFctPb2QdGG3Na8Id46rFZ8cTyUQDIwcxlob1mRfMdat1rvHf9b
	rei03n7cUJfGaOGtQM138Oaq3dzuWS4D5fN6l5Qg5EhzNLjpYGadjX5h6ilHKyKosHgzDeC/9Dw
	g6nY1P0M1Xk/ZCaJkPbkqASK0FgzqVJZ1VYo8nZKK4nGZVSRxESGZ4HDNF366hbs/k6+eH9EQkO
	qs2sV5cteJiI3G3vJ4ZInf8XP2l/C7aVV1O2sgsRvNbO0NyfP5R9xdfOrzad4nHX71TqR7qT3DT
	Y9C5MJnzTKkaueObnMZpLER8Va+pGXZhUzwNc/CUcA1Ujg9iP2TvYyY3K2HhLAUxZwbf5teXbRV
	e/q13FPPmeUGu8GfKveHEwfsh2U/uJYCcfVyjFVAsRNTTQ4QWeRd7UOjPMS3Xwv4JV5KUbMjHHR
	j7+RZykzj6BL2DoeLBh5fATppYC5jYfKQbvjFXi2n7kRA=
X-Received: by 2002:a05:6300:8045:b0:38e:cac8:f997 with SMTP id adf61e73a8af0-38ecac92343mr1984118637.25.1769560911615;
        Tue, 27 Jan 2026 16:41:51 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642add55adsm509268a12.32.2026.01.27.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 16:41:51 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>,
	security@kernel.org,
	sagi@grimberg.me,
	YunJe Shin <ioerts@kookmin.ac.kr>,
	joonkyoj@yonsei.ac.kr
Subject: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
Date: Wed, 28 Jan 2026 09:41:07 +0900
Message-ID: <20260128004136.946596-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_164152_606869_81C85C77 
X-CRM114-Status: GOOD (  11.99  )
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

nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
length or offset exceeds sg_cnt and then use bogus sg->length/offset
values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
entries, and sg->length/offset before building the bvec.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
---
 drivers/nvme/target/tcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..1a62b405d8e6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 	cmd->req.sg = NULL;
 }
 
+static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
+
 static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
 	u32 length, offset, sg_offset;
+	unsigned int sg_remaining;
 	int nr_pages;
 
 	length = cmd->pdu_len;
@@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
+	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt) {
+		nvmet_tcp_fatal_error(cmd->queue);
+		return;
+	}
 	sg = &cmd->req.sg[cmd->sg_idx];
+	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
+		if (!sg_remaining) {
+			nvmet_tcp_fatal_error(cmd->queue);
+			return;
+		}
+		if (!sg->length || sg->length <= sg_offset) {
+			nvmet_tcp_fatal_error(cmd->queue);
+			return;
+		}
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
 		bvec_set_page(iov, sg_page(sg), iov_len,
@@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 		length -= iov_len;
 		sg = sg_next(sg);
+		sg_remaining--;
 		iov++;
 		sg_offset = 0;
 	}
-- 
2.43.0


