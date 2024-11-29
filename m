Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7123CD6EBFF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+R/gj+8Ig3LhHc+2uDX2oht5GogoUnCWhxn331C+erM=; b=4I0Y/rOiIQZCuk6ZB+3QKtH1uw
	ndf4ZZS1hZiys6Sv86FBpqMrsSy5ErZR9z0y+uZaDB08v/fx42DdgE3sZQ+t2MvqSd9ov15IgMTkn
	QRZgenI1n7u/YNjkFjzvdqpBqX2coo2ptcvPn1KV1ik1cU2rJBzDNpvadPAz4sZ9o97cU4iJtjQi7
	Dx/JGs6ZJ0iAlX4Df+iu9XYDwshBJEJnR/0j6V5UsmUZMPw7gWPvNbrwiYOIbyXjhSw4mye5hkR4E
	xZysL7kOBrenL2FdVS6Tyyg89Lc5mLPxA7+0VcNB9UJc6vef7DmoNK21An2zeINYFJuI5vIoOuqNo
	uXGWYOyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGysX-0000000HUx4-32Oo;
	Fri, 29 Nov 2024 11:09:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGysV-0000000HUw9-0hv5
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:09:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5222321194;
	Fri, 29 Nov 2024 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+R/gj+8Ig3LhHc+2uDX2oht5GogoUnCWhxn331C+erM=;
	b=zklkGarEHKYjMsu9k8Fjxe7vpdaG38+oB8NbE+hZ/XoCmJbhnR3L5+ifCp5m4nrZtLucp+
	6A//RpJAaA0/80bp5UEL3gzx6fLU5ihYIg1UdHtySxY7BU8cxQ1exNfG6dt9D9uQaRqQgB
	cntf6FqgtWrsSqJQpzlTVWEpjEbSLMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+R/gj+8Ig3LhHc+2uDX2oht5GogoUnCWhxn331C+erM=;
	b=vhUDdtkLVRMmd8DQleXoQCNyBSugt/KxtHjfwDUdOBMxgW1mPyXWnyP5YshojU2eDUkXJ7
	PK2cQxCgnZ6KjhBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zklkGarE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vhUDdtkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+R/gj+8Ig3LhHc+2uDX2oht5GogoUnCWhxn331C+erM=;
	b=zklkGarEHKYjMsu9k8Fjxe7vpdaG38+oB8NbE+hZ/XoCmJbhnR3L5+ifCp5m4nrZtLucp+
	6A//RpJAaA0/80bp5UEL3gzx6fLU5ihYIg1UdHtySxY7BU8cxQ1exNfG6dt9D9uQaRqQgB
	cntf6FqgtWrsSqJQpzlTVWEpjEbSLMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+R/gj+8Ig3LhHc+2uDX2oht5GogoUnCWhxn331C+erM=;
	b=vhUDdtkLVRMmd8DQleXoQCNyBSugt/KxtHjfwDUdOBMxgW1mPyXWnyP5YshojU2eDUkXJ7
	PK2cQxCgnZ6KjhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ABD5139AA;
	Fri, 29 Nov 2024 11:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ghMBPGgSWe5cQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:09:37 +0000
Message-ID: <751faf4b-7c43-47a0-95f7-e5d2887600f5@suse.de>
Date: Fri, 29 Nov 2024 12:09:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5222321194
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_030939_365696_97AFC5F9 
X-CRM114-Status: GOOD (  29.97  )
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

On 11/29/24 10:28, Daniel Wagner wrote:
> nvme_keep_alive_work setups a keep alive command and uses
> blk_execute_rq_nowait to send out the command in an asynchronously
> manner. Eventually, nvme_keep_alive_end_io is called. If the status
> argument is 0, a new keep alive is send out. When the status argument is
> not 0, only an error is logged. The keep alive machinery does not
> trigger the error recovery.
> 
> The FC driver is relying on the keep alive machinery to trigger recovery
> when an error is detected. Whenever an error happens during the creation
> of the association the idea is that the operation is aborted and retried
> later. Though there is a window where an error happens and
> nvme_fc_create_assocation can't detect the error.
> 
>           1) nvme nvme10: NVME-FC{10}: create association : ...
>           2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
>              nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>           3) nvme nvme10: Could not set queue count (880)
>              nvme nvme10: Failed to configure AEN (cfg 900)
>           4) nvme nvme10: NVME-FC{10}: controller connect complete
>           5) nvme nvme10: failed nvme_keep_alive_end_io error=4
> 
> A connection attempt starts 1) and the ctrl is in state CONNECTING.
> Shortly after the LLDD driver detects a connection lost event and calls
> nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
> state, this event is ignored.
> 
> nvme_fc_create_association continues to run in parallel and tries to
> communicate with the controller and those commands fail. Though these
> errors are filtered out, e.g in 3) setting the I/O queues numbers fails
> which leads to an early exit in nvme_fc_create_io_queues. Because the
> number of IO queues is 0 at this point, there is nothing left in
> nvme_fc_create_association which could detected the connection drop.
> Thus the ctrl enters LIVE state 4).
> 
> The keep alive timer fires and a keep alive command is send off but
> gets rejected by nvme_fc_queue_rq and the rq status is set to
> NVME_SC_HOST_PATH_ERROR. The nvme status is then mapped to a block layer
> status BLK_STS_TRANSPORT/4 in nvme_end_req. Eventually,
> nvme_keep_alive_end_io sees the status != 0 and just logs an error 5).
> 
> We should obviously detect the problem in 3) and abort there (will
> address this later), but that still leaves a race window open. There is
> a race window open in nvme_fc_create_association after starting the IO
> queues and setting the ctrl state to LIVE.
> 
> Thus trigger a reset from the keep alive handler when an error is
> reported.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   		dev_err(ctrl->device,
>   			"failed nvme_keep_alive_end_io error=%d\n",
>   				status);
> +		/*
> +		 * The driver reports that we lost the connection,
> +		 * trigger a recovery.
> +		 */
> +		if (status == BLK_STS_TRANSPORT)
> +			nvme_reset_ctrl(ctrl);
>   		return RQ_END_IO_NONE;
>   	}
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

