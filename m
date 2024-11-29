Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF8CD6EC00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=; b=qHCheeM5FfkwfxbjGhhqIVF04Q
	dJJLFYNkIr+uASDepqfzA+oA4XfV977enBLDfYxeE3JmY8gTeNaqGv166+JxWL43saRj8VcPKyoRP
	wF0j2lrB8TegLR0rRmY10jL+4xHarCNX+8dSRpgeuywSm9S8XAxnEiYQajwd7jP69UpQfczGED9s6
	6DMqu7FOl7fg/Rod96b38r+CpNwwx/0ZzTvzNqA7GGpLo42/ORNR0qfyv0XHeRD4Zq4E7bg5u1Gwt
	vrGxJW+w8VOoeEU6szlDyeGrA4pZ5vECXLAclIS82snN0YESlrDwm3WRwKGYKFkwtC/Iul98WK6XX
	8MJNHEHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz4y-0000000HXAh-1tOS;
	Fri, 29 Nov 2024 11:22:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz4w-0000000HXAH-050g
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:22:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7055821194;
	Fri, 29 Nov 2024 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=wo1TciVRtXy44E3NEdIwMLQ64DOtETKtbvsaDD6oWQ+oSGolwmIh5RQOfk3SV9kRK54Xm2
	9yJU+Q+bV4rmg3PQk0kvssmHE5MtNOyYtJ7nzkQcUgk/B1MpVkZfzcBIeCMZ2xzFjzxeRt
	MfUw39rnG20nfJasFvR324RnHKnnWwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=lFIssojt/4OBLFPtdEkL66mLUi4jfunj5jo3aoVAw9hID7oEmPsBZkTdVIyMZPl4a4D2bl
	bpRKVkiRY7ZlkbCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wo1TciVR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lFIssojt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=wo1TciVRtXy44E3NEdIwMLQ64DOtETKtbvsaDD6oWQ+oSGolwmIh5RQOfk3SV9kRK54Xm2
	9yJU+Q+bV4rmg3PQk0kvssmHE5MtNOyYtJ7nzkQcUgk/B1MpVkZfzcBIeCMZ2xzFjzxeRt
	MfUw39rnG20nfJasFvR324RnHKnnWwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=lFIssojt/4OBLFPtdEkL66mLUi4jfunj5jo3aoVAw9hID7oEmPsBZkTdVIyMZPl4a4D2bl
	bpRKVkiRY7ZlkbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26967139AA;
	Fri, 29 Nov 2024 11:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tXP3CPSjSWfVdQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:22:28 +0000
Message-ID: <b8aea2c6-1bc3-4033-9d42-19d90377f4e5@suse.de>
Date: Fri, 29 Nov 2024 12:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7055821194
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,brookxu.cn:url,shopee.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_032230_228667_6256526C 
X-CRM114-Status: GOOD (  16.94  )
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

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> the code and avoid unnecessary call of nvme_tcp_stop_io_queues().
> 
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 45cbaa7523e6..57f0f0290cc8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return __nvme_tcp_alloc_io_queues(ctrl);
>   }
>   
> -static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
> -{
> -	nvme_tcp_stop_io_queues(ctrl);
> -	if (remove)
> -		nvme_remove_io_tag_set(ctrl);
> -	nvme_tcp_free_io_queues(ctrl);
> -}
> -
>   static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   {
>   	int ret, nr_queues;
> @@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>   static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   		bool remove)
>   {
> -	if (ctrl->queue_count <= 1)
> -		return;
> -	nvme_quiesce_io_queues(ctrl);
> -	nvme_sync_io_queues(ctrl);
> -	nvme_tcp_stop_io_queues(ctrl);
> -	nvme_cancel_tagset(ctrl);
> -	if (remove)
> -		nvme_unquiesce_io_queues(ctrl);
> -	nvme_tcp_destroy_io_queues(ctrl, remove);
> +	if (ctrl->queue_count > 1) {
> +		nvme_quiesce_io_queues(ctrl);
> +		nvme_sync_io_queues(ctrl);
> +		nvme_tcp_stop_io_queues(ctrl);
> +		nvme_cancel_tagset(ctrl);
> +		if (remove) {
> +			nvme_unquiesce_io_queues(ctrl);
> +			nvme_remove_io_tag_set(ctrl);
> +		}
> +		nvme_tcp_free_io_queues(ctrl);
> +	}
>   }
>   
Please don't reorder the function; if you keep
the first 'if (ctrl->queue_count <= 1)' condition
you'll incur less churn and the patch is easier to read.

>   static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
> @@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		nvme_sync_io_queues(ctrl);
>   		nvme_tcp_stop_io_queues(ctrl);
>   		nvme_cancel_tagset(ctrl);
> -		nvme_tcp_destroy_io_queues(ctrl, new);
> +		if (new)
> +			nvme_remove_io_tag_set(ctrl);
> +		nvme_tcp_free_io_queues(ctrl);
>   	}
>   destroy_admin:
>   	nvme_stop_keep_alive(ctrl);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

