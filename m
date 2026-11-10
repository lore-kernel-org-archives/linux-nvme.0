Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA0606BFCD
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gtXjlWkI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hbFZtOe8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q99gpGJZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F290I41H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VoW0kdOp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G0gFrTol3JHvOSBxRDipQZTJIRgF+SciwUJkiGxDaik=; b=gtXjlWkII/5xru
	Wrw8tACE5r0/NvLncgwquMjKNK4A18ksLOg6L4izDt8wf7FQz30kmUr7C417SE/FhEsnS4G3HmQ9T
	06xB+oel/EL0iagT2XkRg/LTDoWft1lXHt11jj3hP0dq2anmUKKXpoO/8znDmAdkww3AzgLpD3eIC
	2Ir/LiX4/iBK78FktKiZhsZPJMtsEbrikaMiwE/OsDJ6GoDm6TM9wp7Nd85ls6uI8TSN1f2LlJxFC
	/etWm/mVKRifYAJOmETumEiCSXtPtp8BDeG83iQ1f84wQjlnEJUj4141vOmxWd318K6F5/xLmzgEK
	Ls+Ww2gZ25IikDGIFuiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlYn-00000003yHh-1P37;
	Tue, 10 Nov 2026 13:06:49 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlYk-00000003yGi-2dn4
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:06:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6911F7DD;
	Tue, 10 Nov 2026 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794316004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0gFrTol3JHvOSBxRDipQZTJIRgF+SciwUJkiGxDaik=;
	b=hbFZtOe8SJy8FNXLt9bXvS/K3jrJhuRrdEHwmeg9wAabLvFMN4a3Hjggz/UET4OaMlBJol
	Vd/9CzsinlDBoLphrEhPXNQ+B5rNHkPbvaygwNRLXnlJG01jshusEgHz2fCcNEcYd3A48R
	sFb8MkHdTntD8IkDFlrHc0x1bNF/ca0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794316004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0gFrTol3JHvOSBxRDipQZTJIRgF+SciwUJkiGxDaik=;
	b=Q99gpGJZ//vFta9sXfYY+RtFkkf4Gt1pYfPCITD4K3GgymlOXP/k9sObOTCuv9WVSoCfS4
	UlkLll6kyNtN8hAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794316003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0gFrTol3JHvOSBxRDipQZTJIRgF+SciwUJkiGxDaik=;
	b=F290I41HBBaxuUMHcHl8pmgbhybuccfPTSd/nr2uqmwVyMP4opJHHQssJlJL2Ls0hytwh9
	cMnVDM8cXTdtyX0l4ka9+4V9e8Rln1s8+qy7md1x8JqYBipcu3/zJnjV5WE6h8qGPdgMak
	KEyZxK4I1KFxXIin2JYoXl0P7PSpxk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794316003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0gFrTol3JHvOSBxRDipQZTJIRgF+SciwUJkiGxDaik=;
	b=VoW0kdOpCxxLDz9umW8IpbG87bIyTf8YTYlfUpnTgfcPKHwGheDzBL5pc11+gNfQg+ErHF
	KtA3CL5NdxIivpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4892B1339F;
	Tue, 10 Nov 2026 13:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mD4mCeMW82oCTwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 13:06:43 +0000
Message-ID: <18db3394-8a02-4578-881c-aece94688c9c@suse.de>
Date: Tue, 10 Nov 2026 14:06:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] nvme: add per-queue sysfs directories
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 nilay@linux.ibm.com, dwagner@suse.de, sgogte@purestorage.com,
 hare@kernel.org, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
 kiyer@crusoe.ai, ganbalagane@crusoe.ai, sjpark@crusoe.ai, bchen@crusoe.ai
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <ce12f1742ea7f8699d85666e4d9d8a2a9d77c90e.1794015622.git.saravanand@crusoe.ai>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ce12f1742ea7f8699d85666e4d9d8a2a9d77c90e.1794015622.git.saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crusoe.ai:email,suse.de:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_050646_842252_0D8FDDC4 
X-CRM114-Status: GOOD (  16.10  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 10:53 AM, Saravanan D wrote:
> Per I/O queue transport state, such as the nvme-tcp io_cpu, has
> nowhere to live in sysfs, since the core has no directory for
> individual queues.
> 
> Add helpers that create the controller's queues directory and add or
> remove one directory per queue
> 
>    /sys/class/nvme/nvmeX/queues/<qid>/
> 
> carrying the attributes a transport sets in the new queue_attr_groups
> member of struct nvme_ctrl_ops. For such transports nvme_add_ctrl()
> creates the queues directory. It holds a reference on the controller
> device, so nvme_uninit_ctrl() deletes it before deleting the device,
> after the transport has removed the queue directories.
> 
> The transport adds a queue's directory when it sets the queue up and
> removes it when it frees the queue, so the directories follow the
> queues across reconnects and changes in the queue count. The core
> allocates each queue directory and its release frees only that
> allocation. Removal waits for running attribute callbacks, so the
> transport may tear the queue down once it returns.
> 
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>
> ---
>   drivers/nvme/host/core.c  | 12 ++++++
>   drivers/nvme/host/nvme.h  | 25 +++++++++++
>   drivers/nvme/host/sysfs.c | 90 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 127 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

