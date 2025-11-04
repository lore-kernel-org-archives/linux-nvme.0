Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F93CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tdz/4wR73HFtjQW5WwR/FFiFRm6+MAmdqIiGPk4Ollw=; b=F5rryql6l11Z6T/QXvPTYiXfGg
	BS8CNwVpGX0eJd6ZsSeMRdxrhfyO76s+F4+izWnOXXsrxcT31q+n6yzUguOJfvQW9nqeSNZ/HlB1t
	PweU3XpCJLORI4wFB6WOysRK1vNz9cKD6qA9ThyOkW1mYvGiN8g2ag0LDlaMup9XMMv8UeISD2MEq
	MLM8nQixKfBZvkjFGveqzCmvZrI3rpnX+LymNEWUnkp40929p+6ldCMz3lhn4KWe5ABOcPHsiPLdr
	GgvYazz/s+KJ8BaS33mbLgBPnk8ZYszNR300kYiU4/0ISJz2jB0UWHb7rL7YrlphTx2OkfGTJtbxL
	XXCPgGnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEP3-0000000BcYw-0TL5;
	Tue, 04 Nov 2025 10:36:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEP1-0000000BcYE-0RFx
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:36:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41D912118B;
	Tue,  4 Nov 2025 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762252597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdz/4wR73HFtjQW5WwR/FFiFRm6+MAmdqIiGPk4Ollw=;
	b=FrEAfaKiA2IuBF/Dum4d+SISn/RaUPAJC/qjalJkrebBN1OlRvMa2ouLnGTQA1Q4l1qw9q
	WVABS3o/q1v/1PgCQP+C+wvVFSxImkL191aHCwzZ7sWOZea8q1KtLLXK9A8b4WX7Be//eC
	sOEubsRHGd5w+HdAUG/wviVxLcm7618=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762252597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdz/4wR73HFtjQW5WwR/FFiFRm6+MAmdqIiGPk4Ollw=;
	b=vYMPgkLTxnzmwmeyKhqteg+q5FcYBhoPrlct6zDYz1oqPAWCNh1mFXUUFzJrYETV6ldur7
	W3sHvbdb2S28/LDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762252597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdz/4wR73HFtjQW5WwR/FFiFRm6+MAmdqIiGPk4Ollw=;
	b=FrEAfaKiA2IuBF/Dum4d+SISn/RaUPAJC/qjalJkrebBN1OlRvMa2ouLnGTQA1Q4l1qw9q
	WVABS3o/q1v/1PgCQP+C+wvVFSxImkL191aHCwzZ7sWOZea8q1KtLLXK9A8b4WX7Be//eC
	sOEubsRHGd5w+HdAUG/wviVxLcm7618=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762252597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdz/4wR73HFtjQW5WwR/FFiFRm6+MAmdqIiGPk4Ollw=;
	b=vYMPgkLTxnzmwmeyKhqteg+q5FcYBhoPrlct6zDYz1oqPAWCNh1mFXUUFzJrYETV6ldur7
	W3sHvbdb2S28/LDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26789136D1;
	Tue,  4 Nov 2025 10:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h//tCDXXCWmvXgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:36:37 +0000
Message-ID: <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
Date: Tue, 4 Nov 2025 11:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_023639_291162_1ED54329 
X-CRM114-Status: GOOD (  14.62  )
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

On 11/4/25 09:06, Chaitanya Kulkarni wrote:
> Hi,
> 
> Add a new memory backend (io-cmd-mem.c) that provides RAM-backed storage
> for NVMe target namespaces, enabling high-performance volatile storage
> without requiring physical block devices or filesystem backing.
> 
> * Implementation Overview:
> ==========================
> The memory backend introduces a new namespace configuration option via
> configfs that allows users to create memory-backed namespaces by
> setting the 'mem_size' attribute instead of 'device_path'.
> 1. Lazy Page Allocation
>     - Uses xarray for sparse page storage
>     - Pages are allocated on first write (copy-on-write semantics)
> 2. Configfs Interface
>     New attribute: ${NVMET_CFGFS}/subsystems/<subsys>/namespaces/<ns>/mem_size
>     - Accepts size in bytes (e.g., "1073741824" for 1GB)
>     - Can only be set when namespace is disabled
>     - Mutually exclusive with device_path attribute
>     - Limited to 80% of total system memory for safety
> 3. I/O Command Support
>     - Read
>     - Write
>     - Flush
>     - Discard
>     - Write Zeroes
> 4. Backend Detection Logic
>     Namespace backend is selected based on configuration:
>     - If mem_size is set (no device_path): Use memory backend
>     - If device_path points to block device: Use bdev backend
>     - If device_path points to regular file: Use file backend
> 5. The implementation follows existing nvmet backend pattern with three
>     main entry points:
>     - nvmet_mem_ns_enable(): Initialize namespace with xarray storage
>     - nvmet_mem_ns_disable(): Release all pages and cleanup
>     - nvmet_mem_parse_io_cmd(): Dispatch I/O commands to handlers
> 
> I/O processing uses scatter-gather iteration similar to existing backends,
> with per-page operations that handle alignment and boundary cases.
> 
Question remains: why?
We already have at least two other memory-backed devices (brd, null_blk)
which should do the job just nicely.
Why do we need to add another one?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

