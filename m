Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A419606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OaAukixE;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gPzOWJXd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q7xlBNqi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gPzOWJXd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q7xlBNqi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRrTXf5Nqnghn1xrdmRqxibSwbs3PkHvP8bBaT+3BbY=; b=OaAukixElNXH/f6z6rMa2+lFt8
	6VC1JVtVGXDfJmPsHOu35UOi1y+e6Yielnf3LCcwnyTXcid3aSbekB9FzszUS7TzGx+btEC30eh+i
	JNTyHz7o13PtcKmpEVk+KDo7TQlVcZgJ67yCsAeIMWPPeG13Fi18LhHBrJSXyHulMsieEIZ0JxfeG
	/m6/ezw9Olz9WNjBGV1FHwUw9spNTjQd110gHM9Kv/vap/tRl+icOtVyXalNqjj21Q9KgL4xYtFPt
	m0VMzsUF64VWS8DCkhHqxlsV4rGrMUi054ypK2X6hQG/ggM/AwhVc+Hdn4VKU8wT5vsmWqf4ZCHc2
	lERHk5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQdQ-0000000BFGK-48id;
	Wed, 21 Oct 2026 07:21:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQdO-0000000BFFP-0BfN
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 07:21:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF0321F7DE;
	Wed, 21 Oct 2026 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792567270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRrTXf5Nqnghn1xrdmRqxibSwbs3PkHvP8bBaT+3BbY=;
	b=gPzOWJXdGqyTCIk1beVbtL/ZNAXABuSHIzLqFo3xDjaVwWDf1qZg7Chk6QrtE/kD304K3H
	fCEdB9AoIPTusnbUnXrRnXLIWL3fBdcvLz4uwzUZRy0gpKZhtAoMMs8HsUbWB40fyApK2R
	j6N5KaYwvWSNmpAt8igClQwJFgRUhE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792567270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRrTXf5Nqnghn1xrdmRqxibSwbs3PkHvP8bBaT+3BbY=;
	b=Q7xlBNqisnTWjlFhEt07/e/NEihaS4vSyAsjEbXd80DFhMRiaka38csFz9ATWTI+CObgi4
	bilsZ8TtDbJVT+BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792567270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRrTXf5Nqnghn1xrdmRqxibSwbs3PkHvP8bBaT+3BbY=;
	b=gPzOWJXdGqyTCIk1beVbtL/ZNAXABuSHIzLqFo3xDjaVwWDf1qZg7Chk6QrtE/kD304K3H
	fCEdB9AoIPTusnbUnXrRnXLIWL3fBdcvLz4uwzUZRy0gpKZhtAoMMs8HsUbWB40fyApK2R
	j6N5KaYwvWSNmpAt8igClQwJFgRUhE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792567270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRrTXf5Nqnghn1xrdmRqxibSwbs3PkHvP8bBaT+3BbY=;
	b=Q7xlBNqisnTWjlFhEt07/e/NEihaS4vSyAsjEbXd80DFhMRiaka38csFz9ATWTI+CObgi4
	bilsZ8TtDbJVT+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6582C134A5;
	Wed, 21 Oct 2026 07:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ri5LB+Zn2GrwDAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 07:21:10 +0000
Message-ID: <72fce5bb-b256-42aa-8844-f970c4480ad3@suse.de>
Date: Wed, 21 Oct 2026 09:21:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Daniel Wagner <dwagner@suse.de>, Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, nilay@linux.ibm.com,
 sgogte@purestorage.com, hare@kernel.org, linux-kernel@vger.kernel.org,
 iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai, sjpark@crusoe.ai
References: <20261018010059.83120-1-saravanand@crusoe.ai>
 <20261018010059.83120-3-saravanand@crusoe.ai>
 <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.29 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
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
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -8.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_002114_552102_BD1F2CA5 
X-CRM114-Status: GOOD (  19.75  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 5:28 PM, Daniel Wagner wrote:
> On Sat, Oct 17, 2026 at 06:00:59PM -0700, Saravanan D wrote:
>> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
>> as the least loaded CPU in the queue's blk-mq map group, and all socket
>> work runs there for the connection's lifetime. This decision falls
>> short when the host partitions its CPUs after connect time. On a 384
>> cpu multi tenant host with 128 queue controllers, blk-mq folds three
>> CPUs into every map group, some groups straddle two tenants' cpusets,
>> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
>> cpuset, seen by the neighbor as steal time.
>>
>> Expose the io_cpu in each I/O queue's directory
>>
>>    /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
>>
>> so a control plane that owns CPU placement can set it directly instead
>> of relying on the driver's heuristic. The attribute accepts a decimal
>> cpu number, -1 or "unbound". A user assignment, unbound included, is
>> marked in the queue flags, persists across reconnects and is never
>> reselected by the driver. The read-only managed attribute reports 1
>> while io_cpu is driver managed and 0 once the user assigned it. The
>> accounting of nvme_tcp_cpu_queues applies regardless of who set the
>> io_cpu.
>>
>> A queue's directory is added when the queue is allocated and removed
>> when it is freed, before the queue is torn down, so a sysfs store
>> never runs on a freed queue. The queues directory is created before
>> the I/O queues are set up in parallel. All io_cpu writes, from sysfs
>> and from the driver, serialize with the accounting under
>> nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
>> The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since
>> a sysfs store may move io_cpu in between.
>>
>> nvme_tcp_free_queue() now clears NVME_TCP_Q_IO_CPU_SET and drops its
>> count, because a queue can still be counted when it is freed. A sysfs
>> store may have run after the queue stop, or the connect may have
>> failed, and the setup error path frees such a queue without calling
>> nvme_tcp_stop_queue(), where the count is normally dropped.
>   
> This looks good, just trying to wrap my head around with isolcpu (yeah,
> doing a bit of work in that area makes me a paranoid).
> 
> I think it make sense to allow that the user can change queue CPU
> pinning during runtime even with isolcpu enabled. And then the question
> is should this be connected to cgroups?

Not sure if cgroups is the right concept here; cgroups are user/
application centric whereas nvme-tcp is pretty much queue/cpu centric.
IE after all the cgroup calculations are done.
Don't think cgroups are a good fit here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

