Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472AC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qL0jhB6ki3j+8SDnQXFIj9AcVAQWHp6uZSnkRqznJEs=; b=fWs3r+xO6p/QzG+NfcNB7ryWjI
	UsmhjzinF4zYvNGgE/m3pZocdDVMPJAg2BHw9vfzozP7+7Aq4gKYbf0wtqoPs0Qv3zhjj88fcen5t
	BVWapkkMvh7RIwzmnFyBh4CABNGzIjGjN81Zf1JxS7ZW+h5Qf9hLSP58anjKh/VQT7B4Lh/pDwfh6
	L2hPiC0cUW6e/pn3WVMj6UTazsSnCD9kref5VlWSM64ui78Zf0aF9CnlE+fzkQ1of2eD82Mj1hnH/
	bnSKVMiYwJw0tB4HfwFl9rQ4+crjqKVi9rZyhQkkpREkTyhK64NDoBbRejXtz3jC5WMo9g4F2/GCU
	NwMa4Qhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Jau-0000000GYKU-2gON;
	Tue, 21 May 2024 07:07:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Jap-0000000GYJR-2xgw
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 07:07:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACEAB34580;
	Tue, 21 May 2024 07:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL0jhB6ki3j+8SDnQXFIj9AcVAQWHp6uZSnkRqznJEs=;
	b=MSxYHJace77WJIAILaUOK9xn/zgmqEMy6h97J5iyxhtqAmT0c4sGMJi+4MxF0JnsCtZxX2
	oLGwzzQZzDmUk683y0CaOKK38hH1oDkHizQHjagmf3BL4yVFqMp0TSVRUqbbhEWv7CTMwb
	SM9U6CJNn+4POQH+e+giGVETEFlHOYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL0jhB6ki3j+8SDnQXFIj9AcVAQWHp6uZSnkRqznJEs=;
	b=y/rS6S/43lQWXyps6ye8iPZyqZ8lGEwOAE274M4lxe9OOX1+NDuT7EnjLrlb08sFTNvTok
	6uNlDvQDPJgB2nDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MSxYHJac;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="y/rS6S/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL0jhB6ki3j+8SDnQXFIj9AcVAQWHp6uZSnkRqznJEs=;
	b=MSxYHJace77WJIAILaUOK9xn/zgmqEMy6h97J5iyxhtqAmT0c4sGMJi+4MxF0JnsCtZxX2
	oLGwzzQZzDmUk683y0CaOKK38hH1oDkHizQHjagmf3BL4yVFqMp0TSVRUqbbhEWv7CTMwb
	SM9U6CJNn+4POQH+e+giGVETEFlHOYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL0jhB6ki3j+8SDnQXFIj9AcVAQWHp6uZSnkRqznJEs=;
	b=y/rS6S/43lQWXyps6ye8iPZyqZ8lGEwOAE274M4lxe9OOX1+NDuT7EnjLrlb08sFTNvTok
	6uNlDvQDPJgB2nDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D19213A1E;
	Tue, 21 May 2024 07:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MBjWEytITGZpZgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 07:07:23 +0000
Message-ID: <93c16e7c-c64a-4077-9dbe-f40120848fd7@suse.de>
Date: Tue, 21 May 2024 09:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for block
 device.
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
 <20240520102033.9361-6-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240520102033.9361-6-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ACEAB34580
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLghztw5pzjjmtx4kirkcu9cad)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,samsung.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_000727_997950_DB6BC3A3 
X-CRM114-Status: GOOD (  18.06  )
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

On 5/20/24 12:20, Nitesh Shetty wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This is a prep patch. Allow copy_file_range to work for block devices.
> Relaxing generic_copy_file_checks allows us to reuse the existing infra,
> instead of adding a new user interface for block copy offload.
> Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> and inode_out. Allow block device in generic_file_rw_checks.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   fs/read_write.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ef6339391351..31645ca5ed58 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>   				    struct file *file_out, loff_t pos_out,
>   				    size_t *req_count, unsigned int flags)
>   {
> -	struct inode *inode_in = file_inode(file_in);
> -	struct inode *inode_out = file_inode(file_out);
> +	struct inode *inode_in = file_in->f_mapping->host;
> +	struct inode *inode_out = file_out->f_mapping->host;
>   	uint64_t count = *req_count;
>   	loff_t size_in;
>   	int ret;
> @@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>   	/* Don't copy dirs, pipes, sockets... */
>   	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>   		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
> +		return -EINVAL;
> +	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
>   		return -EINVAL;
>   
>   	if (!(file_in->f_mode & FMODE_READ) ||

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


