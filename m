Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D0606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PFSc+W2X;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LrDfFC6G;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LhU2iDvu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=11FW+dR+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PgKju0FE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5B9ES4Cuga5d46FA/ZJ9kE82qZN2VgEmNEjHqLKKDfU=; b=PFSc+W2XXrqebCbJ69CKgNl2aT
	fv9AmphwYTKXE+CUGLS8SIe2E90Ic/iyQwK6k1SGAdWGvDgm/UMqsV/yEx4XIAx3m90UtkukmI7fY
	/Pgd8p1xmUy9y8Otiv3V8ijn+WXdNDjUP4Em68Y8oeb1w5Hz1rciqASlHZCje3M9ie1oyTWqypuBu
	khoTLyAsxfQkC0WS+AnTb3HusPk0nNYW74XdxmJHKL7vqHAcLzz/91Av5vQAC2yKPjtiH71UJE26I
	IEUCIBeO2qKOihS8shGaKGn4IBZ17m5p19BPd15PBlktDc7E09mrjOVFwHVDXw9EQe2sVqioAoHu5
	uarPjDmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQkW-0000000BFv6-1y8i;
	Wed, 21 Oct 2026 07:28:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQkU-0000000BFuM-15st
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 07:28:35 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3501C1F461;
	Wed, 21 Oct 2026 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792567712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5B9ES4Cuga5d46FA/ZJ9kE82qZN2VgEmNEjHqLKKDfU=;
	b=LrDfFC6GIqvEXpDrEoIQ3KvRqGlxLzxswE+yRI4PwkPBg20wvWYWNQDxuyfTwfLG6Gt+5q
	tYqtchb8qqUNgD8UwV/RZYxqAGzGscMu4sckq/F9C+cdgvZ8RxMFH3roB2SRm7JAl/UKCJ
	55dxirGdzMIEDB9ALkLG53q3avNjgxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792567712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5B9ES4Cuga5d46FA/ZJ9kE82qZN2VgEmNEjHqLKKDfU=;
	b=LhU2iDvu7UAVGO6zLjYd1QyCVR/aJyo2Nk+IVqvNnEB36cJ0KYsB1c7IrMM5bQC19TY83Z
	tvIVusXE+Wn62RBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792567711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5B9ES4Cuga5d46FA/ZJ9kE82qZN2VgEmNEjHqLKKDfU=;
	b=11FW+dR+Dt76i6nWWELictlfogsecOo6BEjRu2AFvwbLCd5t1P08GMx0bDP6bhmnmOal3t
	bMz3RbLKNiVY1Dh3+40okms3sra2xraIozoDDuFg0AnNynU50ccprEuSsRSkuZWtozxc63
	Mhci80XPBJpI9bqLprvfjrqLC9SOhZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792567711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5B9ES4Cuga5d46FA/ZJ9kE82qZN2VgEmNEjHqLKKDfU=;
	b=PgKju0FEv8Ec4+Hxc6/Q7FAXOu52akbdd2Iijvcp1iS+kTfQMd+1FouImjMMcCem9VqO9R
	a20anfRfAfzhkUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6047134A5;
	Wed, 21 Oct 2026 07:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lPxMIp5p2GrMFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 07:28:30 +0000
Message-ID: <378a9456-35ac-4a18-8c1e-80cc754dcbfc@suse.de>
Date: Wed, 21 Oct 2026 09:28:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 nilay@linux.ibm.com, dwagner@suse.de, sgogte@purestorage.com,
 hare@kernel.org, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
 kiyer@crusoe.ai, ganbalagane@crusoe.ai, sjpark@crusoe.ai
References: <20261018010059.83120-1-saravanand@crusoe.ai>
 <20261018010059.83120-3-saravanand@crusoe.ai>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261018010059.83120-3-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crusoe.ai:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_002834_467417_AC08E66C 
X-CRM114-Status: GOOD (  22.85  )
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/26 3:00 AM, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
> 
> Expose the io_cpu in each I/O queue's directory
> 
>    /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
> 
> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. The attribute accepts a decimal
> cpu number, -1 or "unbound". A user assignment, unbound included, is
> marked in the queue flags, persists across reconnects and is never
> reselected by the driver. The read-only managed attribute reports 1
> while io_cpu is driver managed and 0 once the user assigned it. The
> accounting of nvme_tcp_cpu_queues applies regardless of who set the
> io_cpu.
> 
> A queue's directory is added when the queue is allocated and removed
> when it is freed, before the queue is torn down, so a sysfs store
> never runs on a freed queue. The queues directory is created before
> the I/O queues are set up in parallel. All io_cpu writes, from sysfs
> and from the driver, serialize with the accounting under
> nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
> The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since
> a sysfs store may move io_cpu in between.
> 
> nvme_tcp_free_queue() now clears NVME_TCP_Q_IO_CPU_SET and drops its
> count, because a queue can still be counted when it is freed. A sysfs
> store may have run after the queue stop, or the connect may have
> failed, and the setup error path frees such a queue without calling
> nvme_tcp_stop_queue(), where the count is normally dropped.
> 
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>
> ---
>   Documentation/ABI/stable/sysfs-nvme |  29 +++++
>   drivers/nvme/host/tcp.c             | 173 ++++++++++++++++++++++++----
>   2 files changed, 182 insertions(+), 20 deletions(-)
> 
I think the 'managed' sysfs attribute needs to be per controller, as it
would be extremely awkward to allow some queues to be managed from the
admin and some queues automatically placed.

And I think you need to check for interactions with the existing 
'wq_unbound' module option; both claim to do similar things so we
would need to clarify the details here.

And should be we able to specify a cpu _set_ here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

