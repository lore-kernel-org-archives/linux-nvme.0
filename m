Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6DDE7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMCQSOX1uo6qNSIkIuDnMg3sFAMfn/oPf9iHmN+dSF8=; b=SaRXHSKYaMUstzZqYGBvx1hDJS
	KUQHatbrw/y51wp/1wrBCBMkzj4xNRdFa4x6Xq/5iWPlDlDbBHMHL9FU/eA+1Bhs5FE0ndT0KBiJT
	aPGZohWuhC5hcU0hbQxmZCdqgXo2CrAoyoz6G2Vbp6ZhQnZXOjbd0On8AqcHF0b0BDHpfDF+icGWc
	cvTYsV/Bpxl789eT8XRfVglB+Nwk5zRxJEGklSb3nxY56GLS7U3is0zAPiYZLjkPgIBq5lTED5kRw
	X11S+VhYZDcDWbZRVOC49o1kHStaxuIX7xpshox4Vc24a4dSfEzoIpfefv69oGqaBVvX85/NCyUac
	UosCzong==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEdQ-00000004DDR-1NcM;
	Mon, 13 Jan 2025 07:13:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEdN-00000004DD0-1nzN
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:13:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95D0A1F365;
	Mon, 13 Jan 2025 07:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCQSOX1uo6qNSIkIuDnMg3sFAMfn/oPf9iHmN+dSF8=;
	b=FQgsBOt3PQ+0L7ZIaJMrgvclhvXixwpCSd5t9GOkznmy6UJxiPnA+9cfmeurhtNIzvnKLF
	X8ZW7aUxkvQ4vVzmh79Bh8+3kcbXFQz3be5XBbDImtVV3MNIXNuGCvpba1+ipy4nJa6hjD
	XYEuVWHQHNfJSrkAydOnc7PMA0pTCwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCQSOX1uo6qNSIkIuDnMg3sFAMfn/oPf9iHmN+dSF8=;
	b=pPCelx9hM2bir/xoh/9pTo1LTyDd1AaPfAMAbLcptg9EAXKoRjTMtkmf/2PMmTybHaM8M/
	LaOXoITBwFqu53Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCQSOX1uo6qNSIkIuDnMg3sFAMfn/oPf9iHmN+dSF8=;
	b=FQgsBOt3PQ+0L7ZIaJMrgvclhvXixwpCSd5t9GOkznmy6UJxiPnA+9cfmeurhtNIzvnKLF
	X8ZW7aUxkvQ4vVzmh79Bh8+3kcbXFQz3be5XBbDImtVV3MNIXNuGCvpba1+ipy4nJa6hjD
	XYEuVWHQHNfJSrkAydOnc7PMA0pTCwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCQSOX1uo6qNSIkIuDnMg3sFAMfn/oPf9iHmN+dSF8=;
	b=pPCelx9hM2bir/xoh/9pTo1LTyDd1AaPfAMAbLcptg9EAXKoRjTMtkmf/2PMmTybHaM8M/
	LaOXoITBwFqu53Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B17C813876;
	Mon, 13 Jan 2025 07:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0aaKQa9hGcRKwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:13:10 +0000
Message-ID: <7beae89f-182d-4d88-a6a5-fffd4324dcda@suse.de>
Date: Mon, 13 Jan 2025 08:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] blk-mq: use hk cpus only when isolcpus=managed_irq
 is enabled
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
 <20250110-isolcpus-io-queues-v5-7-0e4f118680b0@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250110-isolcpus-io-queues-v5-7-0e4f118680b0@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_231313_617243_C0AD6672 
X-CRM114-Status: GOOD (  15.84  )
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

On 1/10/25 17:26, Daniel Wagner wrote:
> When isolcpus=managed_irq is enabled all hardware queues should run on
> the housekeeping CPUs only. Thus ignore the affinity mask provided by
> the driver. Also we can't use blk_mq_map_queues because it will map all
> CPUs to first hctx unless, the CPU is the same as the hctx has the
> affinity set to, e.g. 8 CPUs with isolcpus=managed_irq,2-3,6-7 config
> 
>    queue mapping for /dev/nvme0n1
>          hctx0: default 2 3 4 6 7
>          hctx1: default 5
>          hctx2: default 0
>          hctx3: default 1
> 
>    PCI name is 00:05.0: nvme0n1
>          irq 57 affinity 0-1 effective 1 is_managed:0 nvme0q0
>          irq 58 affinity 4 effective 4 is_managed:1 nvme0q1
>          irq 59 affinity 5 effective 5 is_managed:1 nvme0q2
>          irq 60 affinity 0 effective 0 is_managed:1 nvme0q3
>          irq 61 affinity 1 effective 1 is_managed:1 nvme0q4
> 
> where as with blk_mq_hk_map_queues we get
> 
>    queue mapping for /dev/nvme0n1
>          hctx0: default 2 4
>          hctx1: default 3 5
>          hctx2: default 0 6
>          hctx3: default 1 7
> 
>    PCI name is 00:05.0: nvme0n1
>          irq 56 affinity 0-1 effective 1 is_managed:0 nvme0q0
>          irq 61 affinity 4 effective 4 is_managed:1 nvme0q1
>          irq 62 affinity 5 effective 5 is_managed:1 nvme0q2
>          irq 63 affinity 0 effective 0 is_managed:1 nvme0q3
>          irq 64 affinity 1 effective 1 is_managed:1 nvme0q4
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/blk-mq-cpumap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

