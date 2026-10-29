Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC91606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jp2m+hN1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPG0UA/Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zyA3iw7vRBiW/8dxOxmKwNt7dPmzhxcw/8ba0GWIcts=; b=jp2m+hN1XukA7qyyz6MsXKvpvo
	x5O3lSB9cyTf9ly8dCr49r7m/NJMCLW+9GOtxWXqFWH44bVpUsyGIGMo/eiv0K+gpqlja/OcRmiGy
	uxf5dswf6Y6Ih1whVGLKTiDliV2UPwbvpcsGI84YH9T4Nr4sq2gPyq+MXXDy40M6JWmj0zuaxY4qW
	PHJ/NTSEdR59zPsA97S9eQt6F+2f3/2ftrG6ogYlO+ysr6DpKS5qE/bpd1AaOpor2H1V11Cimwdwf
	F8gE9qAUnv8gh9awCy+KIxyII7xXGCcG4hb+i2NKZI0H5qXhhq/kR00GJn9uPOCgd81p8joNNKC3z
	i8tKLJOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRY4-00000009anu-2sRm;
	Thu, 29 Oct 2026 14:56:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRY2-00000009anZ-3kdo
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 14:56:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6B28605CA;
	Thu, 29 Oct 2026 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EB71F01825;
	Thu, 29 Oct 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793285769;
	bh=zyA3iw7vRBiW/8dxOxmKwNt7dPmzhxcw/8ba0GWIcts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HPG0UA/QjdJzTxckeitFMHIY+3aykyodUO5UCIZGtw2H9oZztJjT0f6wfIRM4QRfC
	 G3VVcfxjlkPB0vIHTd0yKe/PJeZIBorLaYO9Yx73Mmh2dbgn+jSfu4HnIxv3vRMfms
	 72ecCvKM4ljcTwZkBpJ0ITQAQHBHFWg6MZ1l1zPYbVGF51e7bgrpII1shrATzlqeOt
	 0HV7HPolg91LBeD4HZoZDDTbJb6bOI7okZI+ngKVloa07LgQc3vH7cVhTFl7hr9sm0
	 Ezl3Ry1r3kWxaqFC92hCOJZyE1CuEAKKK1jhJhtxHp4LmMf+RE4htX26SnTl2TQs4M
	 HZQhCsr1ko6xw==
Date: Thu, 29 Oct 2026 08:56:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [GIT PULL] nvme updates for Linux 7.4
Message-ID: <auNeh_l4fSxzxeUW@kbusch-mbp>
References: <auNZdZx2COp-NCyI@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNZdZx2COp-NCyI@kbusch-mbp>
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:34:29AM -0600, Keith Busch wrote:
> The following changes since commit 40d070cbb1906896d6fd65c39722d2411830ed9f:
> 
>   block: restore the iterator when rejecting a misaligned bio (2026-10-20 11:11:45 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.4-2026-10-28
> 
> for you to fetch changes up to 89480d137bf0d943a82c64f86ae2407a15276b5e:
> 
>   nvmet: don't clear sq->ctrl for a Connect with sqsize 0 (2026-10-28 11:41:43 -0700)

Oh, just fyi, there were some late fixes in nvme-7.3 that are causing a
conflict. Here is my remerge-diff resolution:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
remerge CONFLICT (content): Merge conflict in drivers/nvme/host/multipath.c
index 97e5c41e5e2a4..9e0a0fd77c56e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -874,12 +874,8 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		u32 nr_nsids;
 		size_t nsid_buf_size;
 
-<<<<<<< aa977f5d96745 (block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c)
 		if (WARN_ON_ONCE(offset > ctrl->ana_log_size ||
 				 sizeof(*desc) > ctrl->ana_log_size - offset))
-=======
-		if (WARN_ON_ONCE(ctrl->ana_log_size - offset < sizeof(*desc)))
->>>>>>> 89480d137bf0d (nvmet: don't clear sq->ctrl for a Connect with sqsize 0)
 			return -EINVAL;
 
 		nr_nsids = le32_to_cpu(desc->nnsids);
@@ -895,11 +891,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-<<<<<<< aa977f5d96745 (block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c)
 		if (WARN_ON_ONCE(nsid_buf_size > ctrl->ana_log_size - offset))
-=======
-		if (WARN_ON_ONCE(ctrl->ana_log_size - offset < nsid_buf_size))
->>>>>>> 89480d137bf0d (nvmet: don't clear sq->ctrl for a Connect with sqsize 0)
 			return -EINVAL;
 
 		error = cb(ctrl, desc, data);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
remerge CONFLICT (content): Merge conflict in drivers/nvme/host/tcp.c
index 4874d6c5b32e5..bc46e5f3eaa79 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1582,17 +1582,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
-<<<<<<< aa977f5d96745 (block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c)
-	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
-	mutex_destroy(&queue->pf_cache_lock);
-=======
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
->>>>>>> 89480d137bf0d (nvmet: don't clear sq->ctrl for a Connect with sqsize 0)
 }
 
 static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
@@ -2173,17 +2162,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Use sync variant - see nvme_tcp_free_queue() for explanation */
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
-<<<<<<< aa977f5d96745 (block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c)
-err_destroy_mutex:
-	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
-	mutex_destroy(&queue->pf_cache_lock);
-=======
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
->>>>>>> 89480d137bf0d (nvmet: don't clear sq->ctrl for a Connect with sqsize 0)
 	return ret;
 }
 
--

