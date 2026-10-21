Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AD606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rnHii8OM;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=; b=rnHii8OMoWMFceGsh0hNPTQ7v/
	2Va6taBcSDhxJLakLYZgCp/GkqeCAWVNELqrBboTMxqJbQZFN7948t5T1p9Ocbsf2RtsC0/h33u4e
	XgnlzYnRpf8gQC6Z3e9Fxw5q+XDteqZvKZTvXrK8Er3fqLD2uvHDIW4nkyG674vSWTSwL9u3pvN5w
	oLIvY88RnORkWPug7cXigk1HDsR4yUjs1kIC8DBAh/zYqMXJlTFbahFrYM0EEJz6dAO35lClhARG+
	M9+eZHRQng45UT+lWe/zdyqcut/6BeBK/llzWB9ayHxr8K9gjcjN89/lgNoZrQG9nvZZlWaYPQPhz
	2VkpKNBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUF7-0000000BhwW-3H3G;
	Wed, 21 Oct 2026 11:12:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUF4-0000000Bhw1-1DyI
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 11:12:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42A8D21DF0;
	Wed, 21 Oct 2026 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=EKjY5bkGpoRBx4VVHesxzwNxbXTQh6XPdRp0olwx9cU8cEFsZ9PI2VIDMgBaKOP1XFwwI5
	IglO1jRW0akEjEob42xZ030rkBscXSCj3wBcmKqZWr3lqvwO5I1jHGPlA7GYZ0o7hDG81B
	NrC9To4Cq2DicOVvV5wanyKMKQGLFQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=1HtUq+x6/hZp5RVPDBFwKe9bIP41E/4etr41n7TRg7GwWEAu8pmXpvmMDuMybLZyz8fTW/
	ZhKetV9bbnVrMEDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=EKjY5bkGpoRBx4VVHesxzwNxbXTQh6XPdRp0olwx9cU8cEFsZ9PI2VIDMgBaKOP1XFwwI5
	IglO1jRW0akEjEob42xZ030rkBscXSCj3wBcmKqZWr3lqvwO5I1jHGPlA7GYZ0o7hDG81B
	NrC9To4Cq2DicOVvV5wanyKMKQGLFQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=1HtUq+x6/hZp5RVPDBFwKe9bIP41E/4etr41n7TRg7GwWEAu8pmXpvmMDuMybLZyz8fTW/
	ZhKetV9bbnVrMEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3932134A5;
	Wed, 21 Oct 2026 11:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqCuMhOe2GpuAgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:12:19 +0000
Message-ID: <451bea60-3c75-4edd-88c1-415ff7657595@suse.de>
Date: Wed, 21 Oct 2026 13:12:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme-fabrics: limit each queue type to the number of
 online CPUs
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_041222_509537_8EA8CA67 
X-CRM114-Status: GOOD (  14.63  )
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> nvmf_nr_io_queues limits each queue type to the number of online CPUs
> when asking for I/O queues, but nvmf_set_io_queues hands out the
> granted queues without these limits, and only nr_io_queues is clamped
> when parsing the options.
> 
> E.g. with 2 CPUs, nr_io_queues=2, nr_write_queues=10 and
> nr_poll_queues=10, 2 + 2 + 2 = 6 queues are requested, but handed out
> as 4 default, 2 read and 0 poll queues.  blk_mq_map_queues can't create
> more CPU masks than there are CPUs, so default queues 2 and 3 take over
> the CPUs of default queues 0 and 1, and connecting the I/O queue of
> default queue 1 fails with -EXDEV.
> 
> Apply the same limits in nvmf_set_io_queues.  A queue type with more
> queues than online CPUs always has a hardware context without an online
> CPU, so no working setup changes.  The options are not modified, so the
> limits follow CPU hotplug on reconnect.
> 
> Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
> Fixes: a249d3066de6 ("nvme-fabrics: add queue setup helpers")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

