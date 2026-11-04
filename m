Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49553606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sKUG8P+Y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1JZJK5M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=; b=sKUG8P+Yv/86Fd
	4pfOV9CHRsmqESHcHdnNNZBgWkg54eQwnUTJaKRghfT0NmmVrCHWrdCCedsmo4xqq2XwcYlQYQSVC
	yDF8vgvpftRCrJ46r5jqIdZ8Hd13yi0DNAzP7YswlWbqVSxsPQ06PYxLI7lA/YocXiopfV9K4A3zh
	h1TIPFJtEGpxtqfH7ti0sDmJ4RF6FP4bxIWwRoOKAH4YLKFu+AenVGiNoK79PjbT+chH5ICfQv2hT
	13OZ7x0qcS5XsbOJR4h6uquCgapiHNdSHalyuWciH5uD/xJZV5Driw+tObaRp8zy0hO2zKMz0B9ch
	EB1jF9xcEMVTfYRP0lGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUXE-00000004QPo-3zsf;
	Wed, 04 Nov 2026 06:31:48 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUXA-00000004QO3-45tW
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 06:31:47 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1adbf62dd31so579485c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773904; x=1794378704; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=c1JZJK5MGwP1KVTv1PpDC9JGqXgKBIZJwzKI4XTsA6lwPvB0kTkYtDSaMmJvgHvAs1
         PO0MNbGds9uNngiwpjkC/3fSCaEt/ccKv1ErvX0Yo5V28xOdOiWxmT0E08TjhHQnkEYJ
         Rgn1kCIA50CKvkZr2P0tdzRsWFRJMCvDybIw8iAqVOizM8o5LrqoPxmTaFkjlVHOOj/i
         BTzoCXqn+Y/cl+NZSLekp7aMqkz5rVR1DYxyu3boDwYkivlg9ygdMuRXq8G1jIN7YukY
         yxnlkg/FGJt01yvaXutJVgfiWzgCzjRf9YPHFbBUmIc359gyikzpQRvXaBbUnRAylxpE
         n5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773904; x=1794378704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=emPfSNgv6NVw4yf/rnUjMo6VfPzOhf2I3/83NkQiSyaR6VzGHJX75Gz5oSd7P7KR7d
         aKy8hwpeTOj+JbDtpZ3+oP62s3awRGzVO9dxb0ey/dHRZAAhVesDWGJyetQFNSi3ErJi
         6+tqvyCBR7JsR0UYbqHsbNiUI+CvNeyCjb5Rf4nlKSVibZH7ArAlX4LiaYOkgah3XKGL
         WXz/NIjTfFPFO72qKdrTO60kR2Xw/RclroLGZRQbmyZEJdspHa51AiQFm2gUmsMLMWi4
         mBKQqEKQgmJ0LYO5Vtk6GByrfkEugL09pkZPQ114CirlJuoVrW11l9LtcPrkSDiN7vk5
         oQ1g==
X-Gm-Message-State: APuU4Z+QCrnaBWj2eroWUOkF9/hbuJev8vucJjlcDE6onc5uDEUJdDNj
	TcqTpLw/XbtW7zErPck8Udwbik9qW8dgasM14JpkK1ItmILJ5vqMI6QN
X-Gm-Gg: AYBFou1hA6NvAG2LioFsgwta8LhMB015KsMoHTJj7C5g6oWbdrOZ+PUzsKfWmS6jDFM
	l+OjcHTdjrteEiaPTbVNrYnOeOJOaCYqx+MsWxFCRfSKkOaW1Ct6TPXy5uQotk8lhy3fSPkmqYT
	6zn8EXQV0SVkv0Qtv+kYGTzW44ykH6f+7iDcBzrAzPgT7nztxO0lrQVm1yPayfn1mLid7r6caW8
	Q1Ytoze5IMiesUEU6xwXXgrc/TldCVaF2zjUdkRhHSLqZW/ZrJCrH+eV22uMpcUZxlU2+g9UvoK
	doZ2Zlt8789kMKx+2FD1vOZ5kPg98Y29yLX4kKLA0Ufxk0Cgjo185/n6tNWw/IVUUi375enhhzh
	74uSCtcEVPuQjJQkgSipk0XRy69npFNJQspyfoJpkxQ3AJMr+dQHCqj6TDE4NLkvxmkNCsvCyr3
	5M5tgWYSPyFzr+MvAMPREDZesQ3CqDRV55tJxJlKoGswcqnWnYGEg3X6dWn4Y8US7qvK/+w5aFy
	t5eCRiElkIXCqUo0Fi8K3zM+jy9ePHRSw0kesK1baB7LIMM65pibFWcRXIlx64skV5Vr8LranQU
	MCSHY88FXv070pLw/PNcyRI6
X-Received: by 2002:a05:7022:ea46:20b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1ac5d4b2ad9mr25380347c88.27.1793773903877;
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:40 -0500
Subject: [PATCH v2 2/2] nvme: wait for SRCU readers before splicing the
 namespace list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-2-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_223145_022550_A1883D2E 
X-CRM114-Status: GOOD (  14.22  )
X-Spam-Score: -2.1 (--)
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

Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
there, e.g. nvme_wait_freeze() waiting for I/O to drain.

nvme_remove_namespaces() moves the list onto its on-stack ns_list with
list_splice_init_rcu(), which only waits for RCU readers before
relinking the entries. A reader still on the last namespace then follows
its next pointer to ns_list instead of ctrl->namespaces and treats the
stack as a namespace. Deleting a controller while a Format NVM
passthrough waits for a delayed read on the last namespace gives:

  BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
  Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
  Call Trace:
   nvme_wait_freeze
   nvme_passthru_start
   nvme_submit_user_cmd
   nvme_user_cmd
   nvme_dev_ioctl
  BUG: unable to handle page fault for address: ffffffff8af04850

Use list_splice_init_srcu() instead, which waits for the SRCU readers.
This also takes the RCU grace period out of every controller deletion.
Deleting 64 tcp controllers with one namespace each, median of 3 runs on
each of two boots per kernel:

                                      before        after
  nvme disconnect-all (ms)            3491 / 3509   2996 / 3165
  nvme_remove_namespaces() avg (ms)   39.0 / 40.5   31.9 / 34.7

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..cdb576db23809 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4755,9 +4755,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	list_splice_init_srcu(&ctrl->namespaces, &ns_list, &ctrl->srcu);
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);

-- 
2.43.0


