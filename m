Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2AAC5AC82
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whOyP59gGxXY3rGXvl9g1bOLjr6Sz4/JwRWv+ibl5PU=; b=hN5+i0tGLsJUp2Q1AVD330Ak6h
	Ra0SwyxhHSn7uDIgarlw7H/hQeQlCZeE36b5/FI/q+Pb90bKQOChLy2BTS0jtQXkal/PWkbz90Udn
	6UPOtdVDdLTnqBkcm/+QDitEZ1W3RJW8BnXM4GrxEKyz4KY/eT3ZyyMSGxPxxU5vWCIQGsZizQATQ
	LC9t6kNam0ZH36iBJYiR9E8VhnP3cznhRaRhSSAS/QUJ+4xtP9nf9M9z5zVzwQLNFRO6++6PPn/Pp
	HEllhS2yZ8kSN2524eT9uPrcR+/alpKdBQS6UzGqbdII4j4tvTjK12F/F2I5vZ8+afUmYKem611iA
	nihThUGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtJkf-0000000B8qc-24U5;
	Mon, 10 Aug 2026 06:44:49 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtJkc-0000000B8q6-1xjP
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 06:44:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12F0242EE;
	Mon, 10 Aug 2026 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786344279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whOyP59gGxXY3rGXvl9g1bOLjr6Sz4/JwRWv+ibl5PU=;
	b=SBZpdJKtQtVMdyogzF1vjzc5TfRwHM0UY/PyfgkryR01pUMaH73uFrU1XkZv45ELjRH4aQ
	82guMBEN+zwZEhTLrXVjQMKXm6S/VRwQRy4P74AKUIuTefftpcfx90bu15xbfHgI+6spGr
	MztWLVJVBPi1TibRl5j+isCrY/MhHxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786344279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whOyP59gGxXY3rGXvl9g1bOLjr6Sz4/JwRWv+ibl5PU=;
	b=oQZV/DlkiSUC0EDP0reQL+r6CsX2ZWcfeCxYfKRMHTVwXN4GKB+UIy9HMmcqdtxNBlf1j0
	Ww+W1nv+mSwXd9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786344275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whOyP59gGxXY3rGXvl9g1bOLjr6Sz4/JwRWv+ibl5PU=;
	b=MUm/Tk0X1hMWMLwnTfha0OqhAuK1uXk88zs7kp8I2mN3/q9rAnc7qNnSIpVnxVFHX/CCbe
	3IcW+bEIpfkvEuZYE22QKKNGYcVvkHcqwlZJ2jpNN3Ed75nhlz/GejOGjie2Q4NG6rPx2z
	wAT+vua88dRyZ6S5VmGfvLxmOpYzZUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786344275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whOyP59gGxXY3rGXvl9g1bOLjr6Sz4/JwRWv+ibl5PU=;
	b=eBXGpSyP9nUpK7qR6BFSCsJLKMvTPn8AabZ9TJEPyqn8amX5n91VELmFtH7MyQgBczVb6l
	uU/NFX+y1x28MVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC27779B2;
	Mon, 10 Aug 2026 06:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QjH9K1JzeWr7EAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 10 Aug 2026 06:44:34 +0000
Message-ID: <04a808a3-fcf3-4626-9d35-7e56c14dc394@suse.de>
Date: Mon, 10 Aug 2026 08:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] block: record I/O request start time for passthru
 request
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260809100825.2014133-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_234446_686355_A5CFF8C6 
X-CRM114-Status: GOOD (  16.31  )
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

On 8/9/26 12:07 PM, Nilay Shroff wrote:
> While starting an I/O request, blk_mq_start_request() records the
> request start timestamp only for non-passthrough requests when
> QUEUE_FLAG_STATS is enabled.
> 
> However, the latency based multipath policy uses request completion
> latency to evaluate path performance, and I/O is issued as passthrough
> requests. Since passthru requests never initialize rq->io_start_time_ns,
> their latency cannot be computed.
> 
> Record io_start_time_ns for all requests whenever QUEUE_FLAG_STATS is
> enabled.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c850330a32b..38922209a24f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1340,12 +1340,14 @@ void blk_mq_start_request(struct request *rq)
>   
>   	trace_block_rq_issue(rq);
>   
> -	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags) &&
> -	    !blk_rq_is_passthrough(rq)) {
> +	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>   		rq->io_start_time_ns = blk_time_get_ns();
> -		rq->stats_sectors = blk_rq_sectors(rq);
> -		rq->rq_flags |= RQF_STATS;
> -		rq_qos_issue(q, rq);
> +
> +		if (!blk_rq_is_passthrough(rq)) {
> +			rq->stats_sectors = blk_rq_sectors(rq);
> +			rq->rq_flags |= RQF_STATS;
> +			rq_qos_issue(q, rq);
> +		}
>   	}
>   
>   	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

