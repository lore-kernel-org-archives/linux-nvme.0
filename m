Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A1606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F0zOGAw8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJGnj7YZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZQ+gIadNjTLlM4rxUOB9ck7wi55dKYVbWaSLBzndbXo=; b=F0zOGAw8d6W1za
	wDWgIl826f7PYqQ2/FwlTakFFgy6S9R/Dw38cPO+4e4iZQ6sQ+BAXjbyaKL082xMvlc5EQfLS488D
	kmA5xGfQUIDbSzxMAebmVYPohrP5rfX6WFCWlXUdE40QlrTZoG5+jN+64KM46ktVIJOD4VhOC/3Oq
	OiLMIAiVcg2x5oYcuLa7vkuqCBinqhCcH1asq2FDOQl5Q9ra0jR7il7nHpntfLznXjLlyxb/sqLOu
	sgRFf1tQOmYMA+XSU51oA2yUovHL5K435wzuEC4qAOO0gONpiq1Wgy5/W7axslrNoCdUVlBynI6H3
	ftxP3KxKsUCGaEyd72xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWRqY-0000000C7AE-177h;
	Thu, 26 Nov 2026 05:16:38 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWRqT-0000000C79r-47DR
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 05:16:35 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1b5786e099cso5138998c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670193; x=1796274993; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQ+gIadNjTLlM4rxUOB9ck7wi55dKYVbWaSLBzndbXo=;
        b=QJGnj7YZXqU0fj1SU9YSGVcxoFM7BofWcHEqkVnh1LFHNFRgpkWXEsX4mIUxosR7DE
         qLv+pCB06pZ63+y8f7WliKF91BwnCOzVhKNGKcTvm3Dk1xC66eqr9OTTLxxi6YzSc3eB
         u2aYVy7yHJ2/iCOwwRtxh7xEMWSTLyaH5WNyyIAqCrrP74z31ftiRXXdls9DV28ihyKK
         ScvUsHMz/5YzXgpGmadG43kU/6ru97K6uQxKPz/Jvogl6msErpbOG5X1MyaChV19MWab
         2mn47YpjouxB5kc/55GvIzjCw9/IYT93CfT2vYrRc9AiMvcznif1bQz8WNNQ7H4fkPO0
         Bw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670193; x=1796274993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQ+gIadNjTLlM4rxUOB9ck7wi55dKYVbWaSLBzndbXo=;
        b=c/78hjhYj+LSvCdPLUSFRfPstY5p2HNlvE6/qVXVQ5EFtkv2JtzNQ4yugWyLjuc+5I
         ENNyEXmt5iGBElFDiEIFqZtbq2VvBn9etLDUaryg0ej9SOTMcambFZrRGPEHP5Tc3lFc
         xSObgrJMRJJnhnQF6pPB3PUwTvNpQXcalszTmA2Xa2chwp2/vU9Y5b85ZuGX9e6qQb3s
         S3Q8lTsura/9X1IyAxZXNtEfDbVPqXT23q7Pfh+X91+c1hvLpzySyvL1nFNyWXiRp96j
         T0+Qxk40Gn5GvdfZNXgiSKSU/ZJeeWOyQDkUdajF5V/KnJ0+UR8iUnhjJZbSXcBXUxFZ
         uDGw==
X-Gm-Message-State: APuU4Z9mwYNVAaA9h3Y0IM7YlAz7LvFsVUo2yDctcE9wY9p0ycqvS62c
	TtXyuoYIYVWsJ5zwcvWCi1FbCL1QQiPScOLUOwQwx/FGNZZm1WiQzDBq5U85i6VsOrmQeSoi
X-Gm-Gg: AZFdTZfjp1eSE8ZzqktV/NyngPKusEZe8acrVefY/gstzxOTH8slzkknJrolAM4fLVn
	VUwMBOg2Mm9BVn9g+lRlH6/QIghP8eRW2DjaiO0+OaTan4jH6iN9EQolS5DqT7//yJiFBVVT+xQ
	GU+g+2bEqKLxxRXsTLZOj7webbCWfMhL+1Xp0LsWqPZ3+bpoGmyiEimKy1OTpu2zIdxoHLNIo4r
	InhzPDrrstcc/d1Pw8OQ4S3w/o9y1JSYTLONiXhKJZiyZwWXcRwV6Dy3cfXbtVh0n5QC74tofht
	Z5eZOuaFtbzErLqcvrCj9+QhKX4hOT1Wm0ZJl4sqR+57DQnbBEXFpMdldQlDMI6DfIPKzpMfIwl
	EFxRW2DnknGWNSgrzrNc4YU9rQQYi11z+aQYVeECpV99vyK7ggun32zpOykjsE2u1Kwp/oEuJEU
	4O3Bygbw6CgKguAniqXxsdU1qgUWKtQAYpYiwCzVpx/GQ06rmRocUjClsgBkjQvqZwTWe0WsmzS
	JEx0RL1TYDRNPnwrtNNeZgUDsXobIa8X52BHQHpQPZvZBUYCoqoj/0HlsF0Wcp0aC+4e71AfnCF
	Q69ufOeZEWaWxJLD9PwW6fI1QKzlkh2MBqcvcpa2JyVJSyUUMHFQYnjb52Wp7vTdl0kZ5o75GY7
	urD+v60A9aJs2CMfJHJbNb11jOWHRYL2KYzWpEm1r1CuhSfhquoB36DyA9K44iTA9lV0WZfIG83
	R+J0rlhk1sH71O0EGZhSDgcTDJuQa4hm3acl4=
X-Received: by 2002:a05:701b:230b:b0:147:a685:9125 with SMTP id a92af1059eb24-1b5567c0421mr16170025c88.2.1795670192793;
        Wed, 25 Nov 2026 21:16:32 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-3-37-16-99.ap-northeast-2.compute.amazonaws.com. [3.37.16.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm45886007c88.1.2026.11.25.21.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:16:32 -0800 (PST)
From: Bin Luo <luob87709@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org
Subject: [PATCH v2] nvmet-fc: put queue ref after FCP IOD cleanup
Date: Thu, 26 Nov 2026 13:16:24 +0800
Message-ID: <20261126051624.601-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261125115444.783-1-luob87709@gmail.com>
References: <20261125115444.783-1-luob87709@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_211634_046514_8F87DB56 
X-CRM114-Status: GOOD (  14.08  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In nvmet_fc_free_fcp_iod(), the completing IO's queue lookup reference
is dropped before locking queue->qlock, checking queue->pending_cmd_list,
returning or reusing the embedded fod, and queuing defer_work on
queue->work_q.

Because nvmet_req_complete() releases the nvme_sq percpu reference as
soon as queue_response() submits the asynchronous LLDD fcp_op() for
READDATA or RSP, association teardown in nvmet_fc_delete_target_queue()
can drop the queue owner reference before the LLDD completion reaches
nvmet_fc_free_fcp_iod(). In that case, dropping the completing IO's
reference early frees the queue (and its embedded fod array) before the
subsequent queue->qlock and list accesses, causing a use-after-free.

Move nvmet_fc_tgt_q_put(queue) to the end of nvmet_fc_free_fcp_iod() so
both the fod-return and deferred-IO reuse paths finish all queue and fod
accesses before dropping the completing IO's queue reference. On the
deferred-IO reuse path, the deferred request's own lookup reference
taken in nvmet_fc_rcv_fcp_req() remains with the recycled fod.

Fixes: 619c62dcc62b ("nvmet-fc: correct ref counting error when deferred rcv used")
Signed-off-by: Bin Luo <luob87709@gmail.com>
---
Changes in v2:
- Drop the redundant kref_get()/nvmet_fc_tgt_q_put() pair and instead
  move the existing nvmet_fc_tgt_q_put(queue) to the exit path after all
  queue and fod accesses complete (Greg KH, Sashiko).
- Update the stale comment above queue_work() on the deferred-IO reuse
  path to clarify which queue reference remains with the recycled fod.
- Remove the invalid Tested: trailer and fix the Fixes:/Signed-off-by:
  trailer block formatting (Greg KH).
- Re-tested on v7.4-rc1 x86_64 KASAN_GENERIC QEMU with the owner-drop
  regression harness: both injected and control runs completed cleanly
  with no KASAN reports.

 drivers/nvme/target/fc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5d6c1c7..15f66ae 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -733,16 +733,13 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 
 	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
 
-	/* release the queue lookup reference on the completed IO */
-	nvmet_fc_tgt_q_put(queue);
-
 	spin_lock_irqsave(&queue->qlock, flags);
 	deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
 				struct nvmet_fc_defer_fcp_req, req_list);
 	if (!deferfcp) {
 		list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
 		spin_unlock_irqrestore(&queue->qlock, flags);
-		return;
+		goto out_put_queue;
 	}
 
 	/* Re-use the fod for the next pending cmd that was deferred */
@@ -769,11 +766,14 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 	tgtport->ops->defer_rcv(&tgtport->fc_target_port, fcpreq);
 
 	/*
-	 * Leave the queue lookup get reference taken when
-	 * fod was originally allocated.
+	 * Leave the queue lookup reference taken when the deferred IO was
+	 * received for the recycled fod.
 	 */
-
 	queue_work(queue->work_q, &fod->defer_work);
+
+out_put_queue:
+	/* release the queue lookup reference on the completed IO */
+	nvmet_fc_tgt_q_put(queue);
 }
 
 static struct nvmet_fc_tgt_queue *
-- 
2.51.0.windows.1


