Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD8606A328
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SZAT84Z4;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xHql9Hty;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V44j6o+p;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xHql9Hty;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V44j6o+p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3994jbFlCcowXrDUPcDgqizuiaolmRhPNOhy3OS+VIo=; b=SZAT84Z4KCdHzE
	OXIpM8p0kHaM8VoB34ZTqsrXyMyBwYwFxdXnxnxhlSD7P2NcAMyso/v/o8qCFhEHVLx+t0epv23Hr
	m5/bL8gRC9R6YmTgb3gO5g+MUolWgzZYd0PyasMLpd1yoBZnHZNNXSMuZHQwgeiLhDEoFnkeBXF85
	6+JkfeEVxeN69R0/9B3rj7w0ewvY62wREihN/cypXxDdQEwyvON8vdcuiRqpuzgu3z+uFKHlk8XOl
	vS/TcLEz2UirI/4kab61JEVRL4h3EGyceAY1rO9fQIZhenl/czwbWk6lMjnxlDC43rWP31Q3sP05g
	Fsl6NJYqBtPRqECIx0BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEXi-0000000BTYM-2wyo;
	Fri, 06 Nov 2026 07:39:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEXg-0000000BTXX-1j2l
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:39:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2DF722202;
	Fri,  6 Nov 2026 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3994jbFlCcowXrDUPcDgqizuiaolmRhPNOhy3OS+VIo=;
	b=xHql9HtyM223xUR6dmhsk4Xco3fI82Nr4DL96ZWEO4A+QL4eZvuEKRxjOnNS4RYsqusvLO
	FJCICX1vxlclWrh3j23GF7qF2+RnXlVcP/k+XAkTGKlMKm5WFDu9rkAhwK2CO7XDEvXMsK
	HOeZu9LMkYx4R9HJCD9eMpu8splQxhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3994jbFlCcowXrDUPcDgqizuiaolmRhPNOhy3OS+VIo=;
	b=V44j6o+pRtDaBgoYC82nIO6zTFW7+yQGVLnd5QgLsdiYgkkNspnwDFf2jbrdwQ2M+LyQIe
	K94HyTPLKL9lKfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3994jbFlCcowXrDUPcDgqizuiaolmRhPNOhy3OS+VIo=;
	b=xHql9HtyM223xUR6dmhsk4Xco3fI82Nr4DL96ZWEO4A+QL4eZvuEKRxjOnNS4RYsqusvLO
	FJCICX1vxlclWrh3j23GF7qF2+RnXlVcP/k+XAkTGKlMKm5WFDu9rkAhwK2CO7XDEvXMsK
	HOeZu9LMkYx4R9HJCD9eMpu8splQxhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3994jbFlCcowXrDUPcDgqizuiaolmRhPNOhy3OS+VIo=;
	b=V44j6o+pRtDaBgoYC82nIO6zTFW7+yQGVLnd5QgLsdiYgkkNspnwDFf2jbrdwQ2M+LyQIe
	K94HyTPLKL9lKfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E820134E9;
	Fri,  6 Nov 2026 07:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X2PaDSaE7WqyRAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:39:18 +0000
Message-ID: <8c4393e3-7444-4355-9357-ff4299351f88@suse.de>
Date: Fri, 6 Nov 2026 08:39:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme: reject a reconnect_delay of 0 through sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_233920_607306_78C0C1A3 
X-CRM114-Status: GOOD (  18.09  )
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

On 11/6/26 2:58 AM, Guixin Liu wrote:
> nvme_ctrl_reconnect_delay_store() accepts any value the option parser
> also accepts, except that it misses the lower bound: writing 0 is
> rejected by nvmf_parse_options() but not by the sysfs attribute.
> nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
> DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
> crashes the kernel with a division by zero.
> 
> Reject 0 like the option parser does.
> 
> Fixes: 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> 
> Reproduced on an unfixed 7.3.0-rc7 kernel in a VM with a fabrics
> controller connected:
> 
>    echo 0 > /sys/class/nvme/nvme1/reconnect_delay
>    echo 30 > /sys/class/nvme/nvme1/ctrl_loss_tmo
> 
>    Oops: divide error: 0000 [#1] SMP KASAN PTI
>    CPU: 7 UID: 0 PID: 1542 Comm: bash Not tainted 7.3.0-rc7
>    RIP: 0010:nvme_ctrl_loss_tmo_store+0xce/0x120 [nvme_core]
>    Code: ... 8d 44 08 ff <f7> f1 ...
>    RAX: 000000000000001d RCX: 0000000000000000
> 
> Verified on the patched kernel: writing 0 returns -EINVAL and the
> ctrl_loss_tmo update succeeds without an oops.
> ---
>   drivers/nvme/host/sysfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 10018c6356b6..bae0d6258d01 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -634,6 +634,9 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
>   	if (err)
>   		return err;
>   
> +	if (!v)
> +		return -EINVAL;
> +
>   	ctrl->opts->reconnect_delay = v;
>   	return count;
>   }

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

