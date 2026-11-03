Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E2606D838
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eNW36mST;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrSLFXNh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wShB5NenMA4HXCkQchC2MjrtgX+ziK40QL7hnaqdPSk=; b=eNW36mSTXbngqKjO0C3xUB6H/N
	fkN7+krp/u+9ySP/sCYd54Gp0Gp57DYklU7xOLLp3wyV+GM2lB/+0lWJ3BnOZHNjR3d6D08mzWA4C
	4/Pf1HqwuwEUeID1+lenXh3mFQ9OtkXc1rcny/kPKfjQrN9QBmM7Tb6Kx2/22TAUd60s+cdv4Sz8x
	4Uw5QhCh1ZunVh0/bJX6BC/uy3dCy/QLTjuva/KrUN3+U98Fdp/BxTiNBpoazpi74VHJBZVVVZN29
	grnvv8iP7NLB7julzNb46/krmRJrIR9ZHUcPPNF9TXxfNLZZ5/1alPbkxYG8ZpB21Fmna/D1JDK01
	xIjIxpJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHCV-000000035lF-0cAf;
	Tue, 03 Nov 2026 16:17:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHCT-000000035l8-1ltm
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 16:17:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CEA914035C;
	Tue,  3 Nov 2026 16:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1B51F0093A;
	Tue,  3 Nov 2026 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722648;
	bh=wShB5NenMA4HXCkQchC2MjrtgX+ziK40QL7hnaqdPSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WrSLFXNhROlcBCxx24dosL/wCR6GLwL38M1hTr569iliU7Aqon4MCkjC1SIRQsKMH
	 fBT4oN4o265b+jHNz89fuR8EayDE4ZPi+a21WFP5i1zjINMrMtNcOE9yiE89YPLdhq
	 0tQ+yJ9bQBYV5GmJl9tWp0c0h0a5/TC5YZBBBw796gXQwxBu0g+oT5If/uMeQI7WkX
	 QUpfik43S8AqqyBcAMif4pbm/FAGQM2uhb2n0WzKmFIniVvT8Dm9hXlAsQmoVoHNIO
	 9ZhGVuXV+wypWiS+6x/tDpEQSL+8o1MoeRYKBkZOA/CiFTMboCOO0skRUjIC/e+Wdk
	 Gg/ywnbD4YFIg==
Date: Tue, 3 Nov 2026 09:17:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Duc Anh Luu <luuducanh0505@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix use-after-free when TLS handshake
 completes before timeout is armed
Message-ID: <auoJF43ujPQ62SAt@kbusch-mbp>
References: <50227b10-d1fc-4746-b156-5b9eed00eb18@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50227b10-d1fc-4746-b156-5b9eed00eb18@gmail.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:05:18PM +0700, Duc Anh Luu wrote:
> nvmet_tcp_tls_handshake() takes a queue reference for the handshake
> completion callback, submits the handshake with tls_server_hello_psk(),
> and only afterwards arms tls_handshake_tmo_work.
> 
> Once tls_server_hello_psk() has queued the request and notified the
> handshake agent, nvmet_tcp_tls_handshake_done() can run before the
> submitter reaches queue_delayed_work(). On failure the callback calls
> nvmet_tcp_schedule_release_queue() and then drops its own reference,
> which drops the last reference and queues release_work. nvmet_wq is
> not ordered, so nvmet_tcp_release_queue_work() can run concurrently:
> its cancel_delayed_work_sync() finds no pending timeout work, and it
> frees the queue. The submitter then arms the delayed work inside the
> freed queue, and the timer fires on freed memory tls_handshake_timeout
> seconds later.
> 
> Reproduced on mainline during the v7.4 merge window on an NVMe/TCP
> port with addr_tsas=tls1.3, with clients whose handshakes tlshd
> rejects. It reproduces both with stock tlshd and with a minimal test
> agent that fails every request; a non-debug kernel panics in
> __run_timers. With KASAN, the unmodified kernel hit:
> 
> BUG: KASAN: slab-use-after-free in __run_timers+0x72a/0x8e0
> Write of size 8 at addr ffff88800317a1d0 by task swapper/3/0
> __run_timers
> run_timer_softirq
> Allocated by task 12: nvmet_tcp_accept_work
> Freed by task 132: kfree <- process_one_work (nvmet_tcp_release_queue_work)
> Last potentially related work creation:
> queue_work_on <- handshake_complete <- handshake_nl_done_doit
> 
> The queue was freed 4ms after allocation and the timer fired 10s later.
> With an msleep() inserted between tls_server_hello_psk() and
> queue_delayed_work() the report is deterministic and points at the
> write in queue_delayed_work_on() from nvmet_tcp_accept_work().
> 
> Hold an extra queue reference across the submission and the arming of
> the timeout work. If the completion callback has already released the
> queue, the final put queues release_work, which cancels the timeout
> work that was just armed.

This is a rather long commit message for a simple problem. Just the
first two paragraphs and the KASAN splat are sufficient for this
changelog.
 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org
> XXX-ADD-YOUR-OWN-Signed-off-by-LINE-HERE-AND-DELETE-THIS-LINE-XXX

Umm...

> @@ -1910,6 +1910,14 @@ static int nvmet_tcp_tls_handshake(struct
> nvmet_tcp_queue *queue)
> return -EINVAL;
> }
> + /* Reference owned by the handshake completion callback */
> + kref_get(&queue->kref);
> + /*
> + * The completion callback may run, and drop its reference and the
> + * queue reference, before tls_server_hello_psk() returns. Hold an
> + * extra reference until the timeout work is armed so the queue
> + * cannot be released underneath us.
> + */
> kref_get(&queue->kref);
> pr_debug("queue %d: TLS ServerHello\n", queue->idx);
> memset(&args, 0, sizeof(args));
> @@ -1927,6 +1935,7 @@ static int nvmet_tcp_tls_handshake(struct
> nvmet_tcp_queue *queue)
> queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
> tls_handshake_timeout * HZ);
> }
> + kref_put(&queue->kref, nvmet_tcp_release_queue);
> return ret;
> }
> #else

Your patch is white space damaged.

