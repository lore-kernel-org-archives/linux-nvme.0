Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B9C2BB41
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yLyhAxfPhn0pjsjApPHzY96ofvWjLk6KVM/XSWQZNcE=; b=BO61rSmUawxvqk5DEx0bqywC0A
	VGx6RNdJQD8YVgh7O6JoK4I9VUEpepZhv5IfJnjE5FqN3Cd3ai8GB+olwdSY07m4veHcDgG8W3QvM
	1eTiAOKq/SSt9Qarfc4xKiTZk/pflJufeAvI0Hyd3oIfQhsa4z72UxugfBMuXQjBzmr/wiyytUyGi
	exxxjxQYL8gnj2S3A/VGFnUjOWDZpqa9lXiPUs4g79BPWqqUbYkSmTf4yZXqvZ/ehbsJo/Xzze8DC
	pXWr460U5NtSL8zHfaY76u4kZpXR4ibQP2j1AAlRB597jYLIumeh39veXD2c7qX6D9anMKlR+t3yX
	Rqh1whDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNsiK-0004WA-OE; Tue, 16 Aug 2022 09:18:20 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNsiH-0004AJ-64
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 09:18:18 +0000
Received: by mail-ej1-x630.google.com with SMTP id gb36so17743043ejc.10
        for <linux-nvme@lists.infradead.org>; Tue, 16 Aug 2022 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yLyhAxfPhn0pjsjApPHzY96ofvWjLk6KVM/XSWQZNcE=;
        b=XeUBH7pD9sd+emsMQ8BQj5AHludj77Hauad0yCJlXdQK5LNP+K2+zXP+z3BuDEnNCC
         bisNrg7iu8xIksLwVOTZfxukO6ohn+sNyxeUlls5rwF4JoCKq4EhYOExVdzz6v+ZlUqw
         mixDreL62nawWpDRMU/ZKe6ToA2LJNCZusj9I3GnZieE7vSAcUZyIcOui6RSe45m//hy
         96kTIhq71OBsDYbunG/J4u/hw2AXIiTPMPtA0pITLv7sAUPFy7Q2/sB7Lcv/sY3guzky
         tsh2K/LPe+s/88GS3PxU4noDUdc69zguvHRVyyJ1swyMCinuS8ifyb2nn1KA0XScGvzA
         FfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yLyhAxfPhn0pjsjApPHzY96ofvWjLk6KVM/XSWQZNcE=;
        b=o4U6HG5rctqQRDM+zrGmzKiO+fLzpd2ndaQMYExvldFksfTMmW6LlhzOuaUlTlzYlg
         XNv3nyEr4Bjn9B9aSKqXqIgIraEMmNDydhEbmixeoGCKtGI/tWa6+ZyexqCnOQXArGcY
         7hurHinYP8ID9JFWSXZ2zC6qfQ/6jxcEfgrFSQ5/RSYf/h+rcYpdjtSQvW/3Lid/ofM9
         ohyTTI8cpUYECJChHtLqThEKjSPcgJTaZZlNVPc1oHZ67xP6zpMPKhaowlEPLbLRfat4
         DMBdenLh9IGEpc18excwE8egq+wUBHQunOmpBfTFTpJtd6g6vf6yUyKnOA2Rxexi2x+M
         GcaA==
X-Gm-Message-State: ACgBeo1ZbF2Wc/wuO51llRSc4HONofQ2m0Tn4aq90zWNckNkHo48WCRl
	OGZgRvzE207eiZT3su87sRQ=
X-Google-Smtp-Source: AA6agR4cZoBrTh/lM0Bv9U1JS89LH/ywlYdoYDA/KcQc/eSjr7a6JwypWEb7gCtc0PIfqJhjBUffqA==
X-Received: by 2002:a17:906:9be1:b0:730:957f:34a3 with SMTP id de33-20020a1709069be100b00730957f34a3mr12846754ejc.47.1660641493317;
        Tue, 16 Aug 2022 02:18:13 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-56.retail.telecomitalia.it. [95.250.231.56])
        by smtp.gmail.com with ESMTPSA id hy1-20020a1709068a6100b00726298147b1sm5005980ejc.161.2022.08.16.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:18:11 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Tue, 16 Aug 2022 11:18:08 +0200
Message-Id: <20220816091808.23236-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_021817_264953_359A3F5B 
X-CRM114-Status: GOOD (  22.44  )
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

However, there is a huge constraint which might block some conversions
to kmap_local_page(): the kernel virtual address cannot be handed across
different threads. Ira made me notice that the kmap() and kunmap() in this
driver happen in two different workqueues. Therefore, kunmap_local() will
try to unmap an invalid address.

Let me explain why I'm sending an RFC. When I hit the above mentioned
issues I tried to refactor the code in ways where mapping and unmapping
happen in a single thread (to not break the rules of threads locality).

However, while reading this code again I think I noticed an important
prerequisite which may lead to a simpler solution... If I'm not wrong, it
looks like the pages are allocated in nvmet_tcp_map_data(), using the
GFP_KERNEL flag.

This would assure that those pages _cannot_ come from HIGHMEM. If I'm not
missing something (again!), a plain page_address() could replace the kmap()
of sg_page(sg); furthermore, we shouldn't need the unmappings any longer.

Unfortunately, I don't know this protocol and I'm not so experienced with
kernel development to be able to understand this code properly.

Therefore, I have two questions: am I right about thinking that the pages
mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL? If so,
can anyone with more knowledge than mine please say if my changes make any
sense?

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/nvme/target/tcp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..affba6d862fc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -167,7 +167,6 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -309,19 +308,6 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 	cmd->req.sg = NULL;
 }
 
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
-{
-	struct scatterlist *sg;
-	int i;
-
-	sg = &cmd->req.sg[cmd->sg_idx];
-
-	for (i = 0; i < cmd->nr_mapped; i++)
-		kunmap(sg_page(&sg[i]));
-
-	cmd->nr_mapped = 0;
-}
-
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct kvec *iov = cmd->iov;
@@ -338,7 +324,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -1141,7 +1127,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1396,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1408,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.1


