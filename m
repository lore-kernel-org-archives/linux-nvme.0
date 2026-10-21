Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A46606A31B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=26GhWfXf;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=dm7QhWa/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NbYVhDAgDjCXLKt6OUsnbPdCRFgrXF84XGBkdNmv0Q=; b=26GhWfXfpDEBxcaYuhKKfqdUCy
	Cn8zDUXmVv2TJbfYfVUijox8l0BevVKZQ/ipEThR8pLw/WVrF1t/aoN5Ru4QErXqBPAXLXZaP6GiZ
	eoS67VAg6dbudK4NGEUS7Dov/0ExH21Pl7ZrwjnYeYe+WhdZBfWgb6HLP8uJKAzVePpDwHOWlKe84
	cQz990kQv7FWPksw9HBeLuslqWroUQ1bTC4gquhuqNJt3Vcpp/suPFhpnYWiy1Aq+L3VopFPtSOeK
	c34JlbW+amrFYtCd4qHO6UvmIzVly6UhRSVQ7vcDrCe3j8ahH/EWe1xDU93mO2DYG6A0JbeMkaNoe
	LLQXVQKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJStI-0000000BWTn-0gQq;
	Wed, 21 Oct 2026 09:45:48 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJStF-0000000BWSh-0L4K
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 09:45:46 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-3535a54bed9so674766eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792575944; x=1793180744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NbYVhDAgDjCXLKt6OUsnbPdCRFgrXF84XGBkdNmv0Q=;
        b=dm7QhWa/TjeG93hv4KBxJMOfmLlLKPZglcJq7dqGLbMKn4Sd5JFhdF7+US273+raTr
         PkZKeTA6y453m5wD/6sFFNwunOzLZmRTuThZc0r7SqqHG3Dr72DC9eGlN7RJoMnYlBCc
         v9+ewdPk6gftVb5do3tJTUsx1Q628oVtbVGhaKljzbyiPk6YT1mI+cN0e8fqy38zvPOr
         sBPfaUl9GIxXUK7mEIoytw6QjVt7uUxlNq9q9+n6v+cERDGeDM9iuZ+j5StK4fNUIueU
         JEiRDJSk5E3w4i7lYKdIyw2clQI5FAEPV47GkLy1JyaSxKm37PCvxDWRh6A1ymeq8kJ7
         024Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575944; x=1793180744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NbYVhDAgDjCXLKt6OUsnbPdCRFgrXF84XGBkdNmv0Q=;
        b=xaTe1eG7gsm3BojscTOzAyyIh1wJw3Nlv9BZL/VFYXHzT8TuOaM8TJS5ssXkzCIPUN
         BS2vpWNncDoXokDNGsgWmP+ucvIVVROee028nIftlteqYmIm9kbgOzSVvuVNPQBzgwLs
         EK08EdwcvJsNv0fenLFdeADoYv/pzAXXNt/jg6UI7/ywPV2Bqs0DGtFJM0vrZMMRC5t3
         AtkvsG2INWGKNiyJEZcfgoYG3h3Y2xVTHgSiu+Lon90sOhW2/i21sCvF7AGLMQb6gYG5
         b6EmDX65t2gtOlXpf09jqm8X0Dqj9LxO6ALu3KuZ0LevGbrYHrv4yLL+kxYUwgNOVaFO
         /jzg==
X-Forwarded-Encrypted: i=1; AKwUvBzsRJS1f3IPxo9MSgHoMCY93i2oeCpUVIUGLnu5zcGpA8R/f97cyUt9DB4xO8Vuq3uS4gmly9Y/5vbB@lists.infradead.org
X-Gm-Message-State: AFq9FYITr9XQvB8s1MXQL28X8DJBHtRNXsYGTvB/b4WXaWrJngcW39ck
	jNNNiUPpPeJWu65AVB9nARBSRlUqb83yhcrnfz9PDitbb1s3ArtueYt3KSpw41svOmg=
X-Gm-Gg: AYBFou3p35lWxper7bUq0TSDQe3CXPKOsX/beTk8yhaZlfRDb4iVOQSsT/Nswe6ZH2m
	4SMveRD6SJVUdHEfEvY1zfSx1TftVS3HoH0VAtjH7+EiMeAxUSN+ho0FeiLn9L6SHRcSr0h+mYg
	XY8+Drir3b0ml0cAzz8xQN81ejCtyYL67x7cbsdJr18T/IodGh7ySHp5ue0BZWp0eCXyAaEwVMw
	4WS32qUQbiU0dHVJxTVqGXmag1PcJNL9YtRUWSZIl1SJjzYHmJZre2Q44UroB+Rt3TTX4jHx9/b
	SPIebd5tDHTk19YV04xPAJVQC5XYMeWXmpTjkvB/Mn1QGTFKWhlJ1xUVHMnn3tYyT53moDi3gly
	VvJXeSqajUeHV9LP+gsLbHw76V4abJYXVTkvWbaHuBHWyNS7+tZB951rEOG8cLl7J30neybq8s+
	sb0r+/6SdvtGuDI0B6tw4XV1eLg0rJQhBGEXbf/WYV83AFd47yNJ+QMGVzetnQHMfZpyGUfDGH3
	wWu1opWidmtH+nN4BdVQAEFXOgech0IO3H5kDgG577XgMHK9AQpTNGK61X6NcriuQtj4fm3fUH3
	RruoFFiPbKUzMI0XjsJjDm5US0LvxTDAag==
X-Received: by 2002:a05:7301:c004:b0:35c:ceb0:8bf9 with SMTP id 5a478bee46e88-3674de50911mr2681358eec.38.1792575943810;
        Wed, 21 Oct 2026 02:45:43 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4381:36fd:9c31:126:4a90:466f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411b4145sm6750326eec.15.2026.10.21.02.45.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 02:45:43 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: sashiko-bot@kernel.org
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed, 21 Oct 2026 02:45:12 -0700
Message-ID: <20261021094521.80335-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <sashiko-outbox-175868@kernel.org>
References: <20261018010059.83120-1-saravanand@crusoe.ai> <20261018010059.83120-3-saravanand@crusoe.ai> <sashiko-outbox-175868@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_024545_130578_D8353CB4 
X-CRM114-Status: GOOD (  14.09  )
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 01:15:14AM +0000, sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> In nvme_tcp_setup_queue_async(), nvme_tcp_alloc_queue() runs before
> nvme_tcp_start_queue(), where nvme_tcp_set_queue_io_cpu() is called:
>
> nvme_tcp_setup_queue_async()
>   nvme_tcp_alloc_queue()
>     if (!test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags))
>       nvme_tcp_queue_change_io_cpu(queue, WORK_CPU_UNBOUND);
>     ...
>     nvme_tcp_add_queue_sysfs(queue);
>   nvme_tcp_start_queue()
>     if (idx) {
>       nvme_tcp_set_queue_io_cpu(queue);
>       ret = nvmf_connect_io_queue(nctrl, idx);
>     }
>
> Because nvme_tcp_add_queue_sysfs() publishes the sysfs attributes in
> nvme_tcp_alloc_queue() before nvme_tcp_set_queue_io_cpu() runs in
> nvme_tcp_start_queue(), can a userspace control plane reading io_cpu and
> managed as soon as the queue directory appears observe io_cpu as -1
> (unbound) with managed=1 even when wq_unbound is false?

Agreed. v6 adds the queue directory in nvme_tcp_start_queue(), right
after nvme_tcp_set_queue_io_cpu(), instead of at the end of
nvme_tcp_alloc_queue(), so io_cpu and managed only become visible once
the selection has run. The directory is still removed in
nvme_tcp_free_queue(), which the setup error path calls for every
allocated queue, so a failed connect does not leave it behind.

> Also, during parallel reconnects in nvme_tcp_setup_io_queues(), a queue
> with NVME_TCP_Q_IO_CPU_USER set does not re-increment
> nvme_tcp_cpu_queues[io_cpu] until it reaches nvme_tcp_set_queue_io_cpu()
> after completing the blocking TCP, TLS, and ICReq handshakes in
> nvme_tcp_alloc_queue(). If a driver-managed queue finishes its handshake
> first, could nvme_tcp_set_queue_io_cpu() pick a CPU without accounting for
> the user-assigned queue's load?

This window exists for every queue, not only user assigned ones,
since a queue is counted only once its handshakes complete and it
reaches its own selection. The selection is best effort, and the user
assigned queue keeps its io_cpu regardless, so I'd rather not add
accounting to nvme_tcp_alloc_queue() and its error path for it.

Thanks,
Saravanan D.

