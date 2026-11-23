Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E65606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SERGdCH9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f3bqRmOH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9v8vDez;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f3bqRmOH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9v8vDez
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=od2QNNJaBE+eH/3c4lKMTO/ymggoTGgcp6461vHpT6I=; b=SERGdCH9WRBI5h
	jsgbfGuvd1fYBsbFkyMT9z2ptHWMxJraSks2j7wFUZBGOd2e3oFbjuLcLCQAyLNTqW+iibD3O356e
	bBidwcJPWj+hCiE+hReZh8xUUZgDJkBx9hOIx1ptwtrJsx2L7F56sOD6uBDPr7iKHB8n76vuDG7h7
	yOnrqzsjRpQUea6GtsJnkcOcQiX6D2pwyARlgieMClMcqS+j3TToTB90WFXrlmuV6ARcrP9L2OZqP
	0Jj+EOPJRHDnGeuNMXY+z/kZUBXFUQzPgahWxTCGwLReiNNtFmwAWitQkze0VrSIVT5D45Sl7Qg7S
	iSt95VBqLAqx3HEmPvCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPHt-00000002YY4-3b9Q;
	Mon, 23 Nov 2026 08:20:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPHZ-00000002YWs-1lY2
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 08:20:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32B522206F;
	Mon, 23 Nov 2026 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795422011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od2QNNJaBE+eH/3c4lKMTO/ymggoTGgcp6461vHpT6I=;
	b=f3bqRmOHm+UpUSqQ7Ws3mYVIc66qqYk4ZbF7dY4lrapohUcNad5tyI1sj4Dk9geREUPdtR
	YA2zzcquryd/u3fNN7SMcoxYBRbmMqXRDacNUFmMgJxE767nAVXBC0ICywyNABIjAlI8gw
	MZc2rFIwIaSKJolH64GsXIEmtrFjwQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795422011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od2QNNJaBE+eH/3c4lKMTO/ymggoTGgcp6461vHpT6I=;
	b=d9v8vDezd1HgGUi0sK8LwzjZS6b+gCVg+Iw9c/BAednKX6l1BR3h7uaK7Iet1Isv0vwaD7
	E9No1eoXQ4h8nuAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f3bqRmOH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d9v8vDez
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795422011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od2QNNJaBE+eH/3c4lKMTO/ymggoTGgcp6461vHpT6I=;
	b=f3bqRmOHm+UpUSqQ7Ws3mYVIc66qqYk4ZbF7dY4lrapohUcNad5tyI1sj4Dk9geREUPdtR
	YA2zzcquryd/u3fNN7SMcoxYBRbmMqXRDacNUFmMgJxE767nAVXBC0ICywyNABIjAlI8gw
	MZc2rFIwIaSKJolH64GsXIEmtrFjwQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795422011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od2QNNJaBE+eH/3c4lKMTO/ymggoTGgcp6461vHpT6I=;
	b=d9v8vDezd1HgGUi0sK8LwzjZS6b+gCVg+Iw9c/BAednKX6l1BR3h7uaK7Iet1Isv0vwaD7
	E9No1eoXQ4h8nuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCF913510;
	Mon, 23 Nov 2026 08:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8jE1HTr3A2sfXAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 08:20:10 +0000
Message-ID: <91e827c1-2b79-41a8-999e-18eaa88338da@suse.de>
Date: Mon, 23 Nov 2026 09:20:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-tcp: remove the direct send path
To: Seiji Nishikawa <snishika@redhat.com>, sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>
References: <sashiko-outbox-227628@kernel.org>
 <20261122043732.2002424-1-snishika@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261122043732.2002424-1-snishika@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32B522206F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_002013_617011_4A01A2E1 
X-CRM114-Status: GOOD (  18.58  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 5:37 AM, Seiji Nishikawa wrote:
> On Sun, Nov 22, 2026 at 10:49 AM <sashiko-bot@kernel.org> wrote:
>> [Severity: Medium]
>> Does removing the inline send from nvme_tcp_queue_request() break polled
>> I/O on HCTX_TYPE_POLL queues?
> [ ... ]
>> For SCHED_NORMAL tasks on queue->io_cpu, waking
>> the WQ_HIGHPRI worker sets TIF_NEED_RESCHED, causing blk_hctx_poll() and
>> io_iopoll_check() to abort polling on need_resched() or forcing two
>> context switches per polled I/O.
> 
> This is right. I ran the test with poll queues on the same two machines.
> The host connects with --nr-poll-queues=4, and fio runs with io_uring and
> --hipri, 4k random I/O at queue depth 1, on the io_cpu of a poll queue.
> Average of 3 runs of 60 seconds, latency in usec, ctx is the number of
> context switches of fio in one run:
> 
>                       IOPS   slat    clat     lat      ctx
> randread   base      5017   4.72  193.95  198.67      553
>             patched   4179   9.35  229.70  239.05  251,318
> randwrite  base      3619   5.60  269.94  275.54      542
>             patched   3621  10.62  264.53  275.16  217,806
> 
> For randread, lat goes up by 40 usec (20%) and IOPS goes down by 17%.
> ctx shows why. Without the direct send path, fio is switched out for the
> io_work kworker once per I/O. With it, fio stays on the CPU and keeps
> polling. randwrite shows no difference.
> 
> So removing the direct send path costs about 20% for polled reads at
> queue depth 1 on this setup. One way to avoid this is to keep the direct
> send path only for poll queues. Poll queues then still have 2 senders,
> so send_mutex stays and patch 2 goes away.
> 
> I will send a v2 that does this, unless the list prefers to remove the
> direct send path for all queues and take this cost.
> 
No, that is perfectly fine, and indeed the confirmation I was looking
for. For polling queues it makes perfect sense to keep the 'direct'
submission path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

