Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3147ACA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uc7M9cwpj/769FWo/9YrJrpEe7SA7xSRS90z28j/gZA=; b=aNEAScp+MuAgzqJ2Maj3z1o6IT
	xa2gUltrQFehf39ZRDVvDA9HMGEQAF5zGixwWGG+brmkkKOGfEOIv5xv0MHrfEsX8l1+k+/eEFC9t
	E6t2rf9IiUa30bFlQ4fXPIKVb7xEBrmJxKNuuBlu8iLk79Ji92C/8bRtnL0eFNg/p0DJNhdGgRERK
	3rm5nYLTFmiD66K6WlOIBwiSOY4PuMI6Dt4lP2YQ2dDF4epOWfOZyaW9O5gClKzYJTVGXZbKnOjnr
	41itB0qer8VH4Ae366OnvrZA070jx4k9yP3yEao8KmUI8GXriw7HANmvD7yVms87sq1yrYbqwJtW1
	Qdx+WTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCZhD-0000000BAg6-13XX;
	Fri, 02 Oct 2026 09:36:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCZhB-0000000BAez-0OFe
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 09:36:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 996AD1FE33;
	Fri,  2 Oct 2026 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790933801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc7M9cwpj/769FWo/9YrJrpEe7SA7xSRS90z28j/gZA=;
	b=njoMS+OK4KjH44KD6o7n3AlfaZF1h36Vz8zvunkE7iMBjOOYD5owjHgtMw4T4M1tWXfNIX
	Z/236kbev1RfVNrQDN5Qr3TIeP0yoKPr5Qtmag+x/Vnhtbm1+9hJx827FzCiQhIYtNqVw3
	PCA+hqq+iI3s6Pk5jaQHS1LYUTsvH6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790933801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc7M9cwpj/769FWo/9YrJrpEe7SA7xSRS90z28j/gZA=;
	b=RBgkrjGff65OLSVuRTll7bQYl+aQt0OVR/w0n9XsNtJs0iZpBCr0eBLgUUVOvC0P640QAY
	ZoHZXGs2a8DompCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tMr46N1B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jV/WIWxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790933797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc7M9cwpj/769FWo/9YrJrpEe7SA7xSRS90z28j/gZA=;
	b=tMr46N1BuhdNk75zSnI7kPrZcAGnVVkpIcvgogrhZz/1CfQRrAOXgAICcLQm/nTC78xTZq
	Wce7T+jOfPK1abp7BfmP1V56TPpix9xaFnn+/Uz47hCzf6RYbNPFs8Rq8rMKglNRYEe6D9
	O0VQec04T3c5NKikyv/au9AonvreVBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790933797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc7M9cwpj/769FWo/9YrJrpEe7SA7xSRS90z28j/gZA=;
	b=jV/WIWxd67OjoXQ4nJIsY5FZJrtTezRi6EKY7yUAVvSTFLDE2y1pv7d+Trl5CeigQnbAKe
	HGkQYZz1Acx63BBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F51C13BEC;
	Fri,  2 Oct 2026 09:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u7OADiV7v2qvBAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 02 Oct 2026 09:36:37 +0000
Message-ID: <09c64ac0-8f05-4815-bb17-481614d2db91@suse.de>
Date: Fri, 2 Oct 2026 11:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme-multipath: fix path state evaluation for
 failfast and ANA
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com, saravanand@crusoe.ai, sjpark@crusoe.ai
References: <20261001094857.74567-1-kiyer@crusoe.ai>
 <20261001094857.74567-2-kiyer@crusoe.ai>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261001094857.74567-2-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,crusoe.ai:email,suse.de:dkim,suse.de:email,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 996AD1FE33
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_023649_288258_7DC58E8E 
X-CRM114-Status: GOOD (  27.68  )
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

On 10/1/26 11:48 AM, Krishna Iyer wrote:
> nvme_available_path() has two problems that keep I/O queued when it
> should be failed:
> 
> 1. When fast_io_fail_tmo expires, NVME_CTRL_FAILFAST_EXPIRED is set and
>     the path is skipped, but the function still falls through to
>     nvme_mpath_queue_if_no_path(). If delayed_removal_secs is configured
>     the I/O is requeued indefinitely, defeating fast_io_fail_tmo. Only
>     fall through to queue_if_no_path when there really are no paths;
>     if a path exists but its failfast timer has expired, fail instead.
> 
> 2. A LIVE controller counts as a usable path regardless of the namespace
>     ANA state. A path whose ANA state is inaccessible or persistent-loss
>     cannot serve I/O, so it should not count as available. ANA change is
>     transient and bounded by ANATT, so keep queueing while it resolves.
> 
> Also kick the requeue work from nvme_update_ns_ana_state() when a path
> does not transition to live, so parked I/O is re-evaluated when an ANA
> transition leaves the namespace inaccessible.
> 
> Move nvme_state_is_live() above nvme_available_path() so it can be used
> there.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
> ---
>   drivers/nvme/host/multipath.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 11871f5f18c2..0d6c05f0808b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -509,9 +509,15 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   	}
>   }
>   
> +static inline bool nvme_state_is_live(enum nvme_ana_state state)
> +{
> +	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
> +}
> +
>   static bool nvme_available_path(struct nvme_ns_head *head)
>   	__must_hold_shared(&head->srcu)
>   {
> +	bool failfast = false;
>   	struct nvme_ns *ns;
>   
>   	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> @@ -519,10 +525,16 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   
>   	list_for_each_entry_srcu(ns, &head->list, siblings,
>   				 srcu_read_lock_held(&head->srcu)) {
> -		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
> +		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags)) {
> +			failfast = true;
>   			continue;
> +		}
>   		switch (nvme_ctrl_state(ns->ctrl)) {
>   		case NVME_CTRL_LIVE:
> +			if (!nvme_state_is_live(ns->ana_state) &&
> +			    ns->ana_state != NVME_ANA_CHANGE)
> +				continue;
> +			return true;
>   		case NVME_CTRL_RESETTING:
>   		case NVME_CTRL_CONNECTING:
>   			return true;
> @@ -531,6 +543,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   		}
>   	}
>   
> +	if (failfast)
> +		return false;
> +
>   	/*
>   	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
>   	 * not immediately fail I/O. Instead, requeue the I/O for the configured
> @@ -887,11 +902,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
>   	return 0;
>   }
>   
> -static inline bool nvme_state_is_live(enum nvme_ana_state state)
> -{
> -	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
> -}
> -
>   static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   		struct nvme_ns *ns)
>   {
> @@ -926,8 +936,10 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   		 * is not live but still create the sysfs link to this path from
>   		 * head node if head node of the path has already come alive.
>   		 */
> -		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags))
> +		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags)) {
>   			nvme_mpath_add_sysfs_link(ns->head);
> +			kblockd_schedule_work(&ns->head->requeue_work);
> +		}
>   	}
>   }
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

