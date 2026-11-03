Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7773606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a6Q9oLf3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bo4KnVfl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=NaPp4Peej2BCZG+WegsY5W8E2E6lnmgbaSwB55nY4Mg=; b=a6Q9oLf37PuM6WCW0n2alBco15
	DNfMevgm0aE4/evVixKB1N/+QLTfCZ2XWR5v/q1Cri22dBbFgBdErIHePo+WJVfFaEtw+gMAnQIfF
	5VFKn+QYOh6bhOw2XqjFf+c3Ga1YAgjZepn/DWJX+3lcHZCFmoT7HAyqTZ2ci2YI2h+rm15JmWyhO
	9/QCetD87bCRI3gB2xogtVGXCCDqcQ7fNkIxqGX+gBbTUxjRXYFNOoRRHfo8guC2Y9FnFXJVFOdHA
	YCaefX9hQIPS/3s7prMO3wdvXF3m7mR4RC710QSLuo5jsYwfWKV0SQOmhV8gJy5Sr3khOvrvcQSyV
	cf8/ymTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOH0p-000000033ie-0V2I;
	Tue, 03 Nov 2026 16:05:27 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOH0k-000000033hm-1dX2
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 16:05:25 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so3412452a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721921; x=1794326721; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NaPp4Peej2BCZG+WegsY5W8E2E6lnmgbaSwB55nY4Mg=;
        b=Bo4KnVflTzMZH+zj1XXBznp9wDTjC/urBibZTG355QmoMiwB4tob1OMeS2CuQRcDZH
         pvKtIuUJ8Csw217XY67nSxInTSUJTY/wSCci0+4EpXShr7XQRlT1gdCAY0m+Rwp/K9+d
         XN2ynrpcHejtm/xrgiv+QfY/wCV+e4K3rvlq9WFiXh0la+F5Cb4JQSo/7zHNm9gk4yJC
         RpOAO9LyW3OH40b87A6eulF7z3coC+ABB/BLTI2lRkb854biJEmWLoN+CNMWLbtE325c
         3dp8jk528w37TLC5DiUFza/QiQXBRnYKOe9M24DQ3CtDUOYcgJWwBBgQAfTGFZAwRJof
         1etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721921; x=1794326721;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaPp4Peej2BCZG+WegsY5W8E2E6lnmgbaSwB55nY4Mg=;
        b=bWpDgDGk8Eq5c0myJUBs+eNJClxo4Xsk4sfC00f2xrFJYRdq7RxGbLe6b8BcK1X6O2
         qO1yamvdVQcaLjGhwjCb/Pf+qeIu+z3Qa5vIXNUBkJeu3EsBxp4IFxDTZcfCdVVzUiku
         1f9TDFuFdlshowpJHylg7Hdv2MCdrNInZjailVlODCxdz/cENNcr9FH3/hTfoBkiS3DQ
         a7NulkpimCmVDjcRRXsrYLGzHyP7of4B9DdbGoCOQ0ueB9I3jV5gnhpFvovJJh2X6uwb
         /CQ63I+6qD4tCqLp4b9yyQgSIq2Vt6xcDpp4zlYoyUS8L4+BzIj5TTpJ5DAy6S5mnJVK
         yB+Q==
X-Gm-Message-State: APuU4Z8S1GmoNpEkhG4kWSEQpYszKPwyfZbbsd6qr4NLnUELtlcr9j3i
	5WJxOscPmTkiy0nerlsD7ZRML7p6dqyveN7ODAW6OlRJCXdRLc9ka4xt
X-Gm-Gg: AYBFou0Enrd4d3rMT3YKu+4O3VqMGWyJqoG5i93UUhDfm1wHZj9f0fmN3kCPI9tt7p9
	ij+pSAdnsdqnL3nZy7G8sBsq9lDYuju1egEn/aBr4xMT6YsAEHGUMmm+xDwl/yWZcMfTZPs+JvU
	DA09e6kZVHrkmoxgwCEMahidH17P5IU7yz5E4LuxlHdSRryQvbGKUKaQ7kLhqbE5u98w3/TsvOg
	IzUCFFKWqroMmf5knK6PvSV1TUi+DGSPcVs0ZChqf1I7Uld2H032DZvc2nUhGUFcHYMVpod5OYe
	TZotIZ4Qk2hBEJ/MFtQG4tWnGB938CV4PCkTJhyVFMblP6oSGuOMqNM8o/ZpPTtm8tVSbLkbVFS
	91gS6BkVk2OhAOE+LKL5pYY3CJGCpQtDHvsIATSdxwCQHYND9za105n4IF0ZumpQ+KMs8fBXu95
	CTxvle/MDB4gP7xaKnWLc+06tWvvlyNBVu+1jIcURqzFe5aM315e3BPMB9f3kfvVriYKUOjJeM8
	JkS8jCHi0y7NC9/3cZreNhf5vdVN4Cq5faDnH2fyNO8idOuT6EQ0zGpZRRskqZeW3GGj4o/ORez
	J8Aq71XxPAYy31tuNKS4WE6wMM3ZCH0m+itY4g==
X-Received: by 2002:a17:90b:53c7:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3ae897c7747mr10979311a91.15.1793721920802;
        Tue, 03 Nov 2026 08:05:20 -0800 (PST)
Received: from [192.168.31.200] ([183.81.0.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b6f91sm4955491a91.17.2026.11.03.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:05:20 -0800 (PST)
Message-ID: <50227b10-d1fc-4746-b156-5b9eed00eb18@gmail.com>
Date: Tue, 3 Nov 2026 23:05:18 +0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Duc Anh Luu <luuducanh0505@gmail.com>
Subject: [PATCH] nvmet-tcp: fix use-after-free when TLS handshake completes
 before timeout is armed
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_080522_439504_49C116EE 
X-CRM114-Status: GOOD (  12.27  )
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_tcp_tls_handshake() takes a queue reference for the handshake
completion callback, submits the handshake with tls_server_hello_psk(),
and only afterwards arms tls_handshake_tmo_work.

Once tls_server_hello_psk() has queued the request and notified the
handshake agent, nvmet_tcp_tls_handshake_done() can run before the
submitter reaches queue_delayed_work(). On failure the callback calls
nvmet_tcp_schedule_release_queue() and then drops its own reference,
which drops the last reference and queues release_work. nvmet_wq is
not ordered, so nvmet_tcp_release_queue_work() can run concurrently:
its cancel_delayed_work_sync() finds no pending timeout work, and it
frees the queue. The submitter then arms the delayed work inside the
freed queue, and the timer fires on freed memory tls_handshake_timeout
seconds later.

Reproduced on mainline during the v7.4 merge window on an NVMe/TCP
port with addr_tsas=tls1.3, with clients whose handshakes tlshd
rejects. It reproduces both with stock tlshd and with a minimal test
agent that fails every request; a non-debug kernel panics in
__run_timers. With KASAN, the unmodified kernel hit:

BUG: KASAN: slab-use-after-free in __run_timers+0x72a/0x8e0
Write of size 8 at addr ffff88800317a1d0 by task swapper/3/0
__run_timers
run_timer_softirq
Allocated by task 12: nvmet_tcp_accept_work
Freed by task 132: kfree <- process_one_work (nvmet_tcp_release_queue_work)
Last potentially related work creation:
queue_work_on <- handshake_complete <- handshake_nl_done_doit

The queue was freed 4ms after allocation and the timer fired 10s later.
With an msleep() inserted between tls_server_hello_psk() and
queue_delayed_work() the report is deterministic and points at the
write in queue_delayed_work_on() from nvmet_tcp_accept_work().

Hold an extra queue reference across the submission and the arming of
the timeout work. If the completion callback has already released the
queue, the final put queues release_work, which cancels the timeout
work that was just armed.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
XXX-ADD-YOUR-OWN-Signed-off-by-LINE-HERE-AND-DELETE-THIS-LINE-XXX
---
drivers/nvme/target/tcp.c | 9 +++++++++
1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e59810175262..e55a3b86f3f6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1910,6 +1910,14 @@ static int nvmet_tcp_tls_handshake(struct 
nvmet_tcp_queue *queue)
return -EINVAL;
}
+ /* Reference owned by the handshake completion callback */
+ kref_get(&queue->kref);
+ /*
+ * The completion callback may run, and drop its reference and the
+ * queue reference, before tls_server_hello_psk() returns. Hold an
+ * extra reference until the timeout work is armed so the queue
+ * cannot be released underneath us.
+ */
kref_get(&queue->kref);
pr_debug("queue %d: TLS ServerHello\n", queue->idx);
memset(&args, 0, sizeof(args));
@@ -1927,6 +1935,7 @@ static int nvmet_tcp_tls_handshake(struct 
nvmet_tcp_queue *queue)
queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
tls_handshake_timeout * HZ);
}
+ kref_put(&queue->kref, nvmet_tcp_release_queue);
return ret;
}
#else

