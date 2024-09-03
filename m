Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0507CD342F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WjRRdbmvDncRZETa9MOch7XZ2s2HrrJfahUHtJSD5Y=; b=j0/VJc8LdjWeFJHpvKPFhoSPqI
	MWipVMgbDylDoWwLd4TeXFxpybigRFPW+mQf9lkzt/eNUpD++bh3874f5TM3s8Uu3M9tFYVkdFjjr
	DU7c9jg6GYeDnE/a5GljHFf+h0O6qLv3O0lcvGSIt2e/qQ0uD1QXNJdtvVPEmt9eXBZ4xNRIyugT7
	zTnJTIDYv6brpP9kBK4o6aTU0OvvBNFaSJj7SvFUVZ2+Ul05/pbnLN82kmr3DJwlf45EHmhI/7VKF
	QGld4y1NBDEps19iCq8qagenB6ESXPTy9UFqRXPlT/hS2DwcPG593R2pKLaE53GmXJkKdDbYD17Dd
	vaH4QRgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slMyc-0000000GSQr-3JyQ;
	Tue, 03 Sep 2024 06:25:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slMyV-0000000GSPF-2BOT
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 06:25:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD9221B74;
	Tue,  3 Sep 2024 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725344709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WjRRdbmvDncRZETa9MOch7XZ2s2HrrJfahUHtJSD5Y=;
	b=SuTLKhPzGsrs5pEiHyO4BJDf30tpxJ7nmq///C0lM7N4ehBZ7By4ZEjx9746ORQ3QbGZ6Q
	ybDOwr09dt2ykW79RNV3nGiZD6AYGUuX4tdFv/9vct86d0mtIp2DEriUYqqotsNeQH+T3C
	mFmETnBQfsy8MoKt3MSPVStpaNTDf30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725344709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WjRRdbmvDncRZETa9MOch7XZ2s2HrrJfahUHtJSD5Y=;
	b=L/oezrlLA+UuWOdX7uPkgJuXQ2Obj9nQSiD9D5+277j0cEJcDDizuPAwHMWVxYH4Bk/qaQ
	tk7AD2w5a72EoNBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725344709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WjRRdbmvDncRZETa9MOch7XZ2s2HrrJfahUHtJSD5Y=;
	b=SuTLKhPzGsrs5pEiHyO4BJDf30tpxJ7nmq///C0lM7N4ehBZ7By4ZEjx9746ORQ3QbGZ6Q
	ybDOwr09dt2ykW79RNV3nGiZD6AYGUuX4tdFv/9vct86d0mtIp2DEriUYqqotsNeQH+T3C
	mFmETnBQfsy8MoKt3MSPVStpaNTDf30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725344709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WjRRdbmvDncRZETa9MOch7XZ2s2HrrJfahUHtJSD5Y=;
	b=L/oezrlLA+UuWOdX7uPkgJuXQ2Obj9nQSiD9D5+277j0cEJcDDizuPAwHMWVxYH4Bk/qaQ
	tk7AD2w5a72EoNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10EE213A80;
	Tue,  3 Sep 2024 06:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7QNAAsWr1mZmPAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Sep 2024 06:25:09 +0000
Message-ID: <93dbb39f-3c5f-4631-aabf-1f4222781b06@suse.de>
Date: Tue, 3 Sep 2024 08:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: check for valid request when polling for
 completions
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902130728.1999-1-hare@kernel.org>
 <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_232511_739408_E873861E 
X-CRM114-Status: GOOD (  13.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/2/24 19:04, Sagi Grimberg wrote:
> 
> 
> 
> On 02/09/2024 16:07, Hannes Reinecke wrote:
>> When polling for completions from the timeout handler we traverse
>> over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
>> Unfortunately that function will always return a request, even if
>> that request is already completed.
>> So we need to check if the command is still in flight before
>> attempting to complete it.
> 
> Hannes, are you able to trigger a use-after-free here? That is the
> inevitable outcome of completing an already completed request.
> So, why are you not calling it as it is?
> 
Okay, will do.

> Was this seen in practice? do you have a stack trace?
> I ask for this because it makes the review a lot clearer.

Here it is:

crash> bt
PID: 183      TASK: ffff8d3d06150000  CPU: 3    COMMAND: "kworker/3:1H"
  #0 [ffff9e83c0427930] machine_kexec at ffffffff9de840f3
  #1 [ffff9e83c0427988] __crash_kexec at ffffffff9df8736a
  #2 [ffff9e83c0427a48] crash_kexec at ffffffff9df88264
  #3 [ffff9e83c0427a58] oops_end at ffffffff9de42068
  #4 [ffff9e83c0427a78] do_trap at ffffffff9de3e53a
  #5 [ffff9e83c0427ac0] do_error_trap at ffffffff9de3e744
  #6 [ffff9e83c0427b00] exc_invalid_op at ffffffff9e869bb3
  #7 [ffff9e83c0427b20] asm_exc_invalid_op at ffffffff9ea00e4d
     [exception RIP: __slab_free+698]
     RIP: ffffffff9e124e2a  RSP: ffff9e83c0427bd0  RFLAGS: 00010246
     RAX: ffff8d3f51141800  RBX: 0000000000080006  RCX: ffff8d3f51141000
     RDX: ffff8d3f51141000  RSI: fffffb0f4d445000  RDI: ffff8d3d00042d00
     RBP: ffff9e83c0427c80   R8: 0000000000000001   R9: ffffffffc04ff496
     R10: 0000000000000000  R11: ffff8d3f51141000  R12: fffffb0f4d445000
     R13: ffff8d3f51141000  R14: ffff8d3d00042d00  R15: ffff8d3f51141000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  #8 [ffff9e83c0427bf8] dev_printk_emit at ffffffff9e867920
  #9 [ffff9e83c0427c88] nvme_pci_complete_rq at ffffffffc04ff496 [nvme]
#10 [ffff9e83c0427cb0] nvme_poll_irqdisable at ffffffffc0501496 [nvme]
#11 [ffff9e83c0427ce8] nvme_timeout at ffffffffc0503306 [nvme]
#12 [ffff9e83c0427d68] blk_mq_check_expired at ffffffff9e2faa8a
#13 [ffff9e83c0427d78] bt_iter at ffffffff9e301349
#14 [ffff9e83c0427db0] blk_mq_queue_tag_busy_iter at ffffffff9e301f35
#15 [ffff9e83c0427e60] blk_mq_timeout_work at ffffffff9e2fbe6e
#16 [ffff9e83c0427e98] process_one_work at ffffffff9ded1f64
#17 [ffff9e83c0427ed8] worker_thread at ffffffff9ded216d
#18 [ffff9e83c0427f10] kthread at ffffffff9ded9b54

The panic was triggered at:

# mm/slub.c
  374 static inline void set_freepointer(struct kmem_cache *s, void 
*object, void *fp)
  375 { 

  376         unsigned long freeptr_addr = (unsigned long)object + 
s->offset;
  377 

  378 #ifdef CONFIG_SLAB_FREELIST_HARDENED 

  379         BUG_ON(object == fp); /* naive detection of double free or 
corruption */
  380 #endif

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


