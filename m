Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CB0606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j+fRCLa7;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iDaBE67g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FcTK30d240S4zhhw3oVXNxxE1L96bmC2Nbm6MJXaCKk=; b=j+fRCLa7WAcukZ
	QhDKqcm0CUFhN0HdqcjTTpoBhEPy/p5VxRi6iae1Y1+ax7J4gc0zvxFs/H9m2u6Z+sxq9l/vEyR5e
	ILYDaFbrZkM1DNjVMtT9LM/XpqAajKgJdO3ao14KCYngZ+Gh3YqnrZ0Rovt6O7vZNFXvkr1p8Pf9q
	gZ2sLpOgu65bsHhy2Gn2xULyb6s8gRjggPngtcnWL//4mCV23cyq4NhKR3WWQh0joZm1UoGFHzTbx
	tFWP3LrWkWnMI+JbuMj1bUv/RjtRE2pEratimxChsV2rXvEjUiCUlEfm+W6cE5EQXOtiBO2hhP1HG
	AmyTT8nbkzZ6xBAL46UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMcU5-0000000AfaN-2qz0;
	Fri, 30 Oct 2026 02:36:49 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMcU1-0000000Afa2-1s78
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 02:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793327801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FcTK30d240S4zhhw3oVXNxxE1L96bmC2Nbm6MJXaCKk=;
	b=iDaBE67gEf8NnQRzztwSHCu2fviHiDRtWZD28PZSwMZ+ozHYbvP/kK2zKsCX4squKPbWHcKIRoKUFYBFCiv3f132LfDD9bea8NvUuqeJ876yOEPTVQLdcHQ0AVA19A2NcTSlHz3RDDfut6kFLt3U7+GO+w9nW4QiCUhPSWHIIZs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDklHg7_1793327799;
Received: from 30.178.68.140(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDklHg7_1793327799 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Oct 2026 10:36:40 +0800
Message-ID: <6d28ec32-b6af-425c-9cbc-ac1172baf979@linux.alibaba.com>
Date: Fri, 30 Oct 2026 10:36:39 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: Handle a NULL admin queue in
 nvmet_queue_tls_keyid()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261029034306.3626274-1-kanie@linux.alibaba.com>
 <20261029121552.GC24375@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20261029121552.GC24375@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_193646_119700_A33961CE 
X-CRM114-Status: GOOD (  17.42  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/29 20:15, Christoph Hellwig 写道:
> On Thu, Oct 29, 2026 at 11:43:06AM +0800, Guixin Liu wrote:
>> The admin queue is not necessarily installed when the tls_key debugfs
>> entry is read: it may not have been created yet, or it may have been
>> destroyed already.  nvmet_queue_tls_keyid() then dereferences a NULL
>> sq.
>>
>> Guard the helper and return 0 instead, which also covers the read
>> racing with admin queue teardown.
> The patch itself looks obviously fine, but do we have any synchronization
> that ensure it does not go away while we're looking at the submission
> queue?
The nvmet_sq has percpu_ref, but it can keep nvmet_sq_destroy() from
freeing sq only, it can't keep nvmet_tcp_release_queue_work() from
setting tls_key to NULL, so we need serialize with nvmet_sq_put_tls_key():

"""""
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..cc451e25ea1d 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -136,8 +136,19 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
 static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
 {
        struct nvmet_ctrl *ctrl = m->private;
-       key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
-
+       struct nvmet_sq *sq = ctrl->sqs[0];
+       key_serial_t keyid = 0;
+
+       /*
+        * Pin the admin queue against teardown, and serialize with
+        * nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
+        */
+       if (sq && percpu_ref_tryget_live(&sq->ref)) {
+               mutex_lock(&ctrl->lock);
+               keyid = nvmet_queue_tls_keyid(sq);
+               mutex_unlock(&ctrl->lock);
+               percpu_ref_put(&sq->ref);
+       }
        seq_printf(m, "%08x\n", keyid);
        return 0;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e315f1c24e73..24df9e4a1e1c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -957,13 +957,17 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
 {
+       if (!sq)
+               return 0;
        return sq->tls_key ? key_serial(sq->tls_key) : 0;
 }
 static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
 {
        if (sq->tls_key) {
+               mutex_lock(&sq->ctrl->lock);
                key_put(sq->tls_key);
                sq->tls_key = NULL;
+               mutex_unlock(&sq->ctrl->lock);
        }
 }
""""

Best Regards,
Guixin Liu




