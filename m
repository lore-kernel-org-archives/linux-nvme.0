Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC8ECD3427
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hsNKCCd77pBLDk2f74sm80lbSDV9WsDhHYunD0s3dlM=; b=wY1AZO0/p1hyiUcB2B15gf+PNh
	JbN6cYMUZGobWMSt9QyRIO8VkeoRX27dJrRILPdnLvsDIgFcE1wX8qWPAnrcQ/DjCzqKPraw/BfED
	sv49CF70dlFVKobK1bU0r1oLjl2MZ+n712hFkr6ptdEBsgCuyNy0f/T/p/elSo4Dky5qTL/ebcOx0
	2MqDVrivXeRD1NCJuXO2vYVlmSq0eoGJiBuImd9KA3xsIALKG/OyJ8lTm6/OR77MCM+ixKpS4ZNhq
	PPdOVZ9BSOqg+YwRouciUbuNTKKqQlQXVtUkSF4ZEA/KAQSRJ8nJvSB1xmyrL0UxOb9q3kx5mBdoV
	XQCzfehw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNKY-0000000D15o-0qpS;
	Mon, 11 May 2026 09:53:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNKV-0000000D15A-2oIZ
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:53:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D69A6B81B;
	Mon, 11 May 2026 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsNKCCd77pBLDk2f74sm80lbSDV9WsDhHYunD0s3dlM=;
	b=s3AGPOK5/S7Q9Zhki5AF94a0TG4wc6ROxsscOlCPf7AqbvOUmwQH9LeesdO5S4IGgGJmMk
	flFHwb3qBK+vFb6/ki/2I/yl1PM3hzUCmE077yqO3dlyd9PUkeW5oXtRM4Hl74mFGwOPAX
	s+evqBWEkh/Pe6weyxHHCK3ghJxWO7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsNKCCd77pBLDk2f74sm80lbSDV9WsDhHYunD0s3dlM=;
	b=As0czRuds3Q7/XWjZV13YSsl4/APLlHBkyTEBE8X04cKBl2WNQ/M26soDRCmRYknx2z6Zg
	kDtJN+feGC3xhQAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OCE6bKq6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w5QqkR3K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsNKCCd77pBLDk2f74sm80lbSDV9WsDhHYunD0s3dlM=;
	b=OCE6bKq6XGb9nyhdaN2u5+Yw9cxfk4Q6T64XDL7RyNO6iRrB7g74GUM1LkP8nZr4UZS0ib
	yythmo86MWiXW5NOZa2UylAhZg25JgKX05PwWbQHCrDWU4gJ3NopUGdhQulS5nJCYdkkFS
	8LDOwy4YUGHxJvMXSvhjdmvrK6mbObw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsNKCCd77pBLDk2f74sm80lbSDV9WsDhHYunD0s3dlM=;
	b=w5QqkR3KymBH3ZltFUJGDxgEvc39R3/Dx0jzn0/O0T3iyGZE54lBh1fPq0/TdVoM8x3zzY
	8leAQ3ljtESC26AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01CA8593A3;
	Mon, 11 May 2026 09:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHQUOx+nAWrYRwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:53:35 +0000
Message-ID: <837128f8-bff3-41da-8960-f43ef79797eb@suse.de>
Date: Mon, 11 May 2026 11:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 7/9] nvme-core: align fabrics_q teardown with admin_q
 in nvme_free_ctrl
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-8-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-8-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D69A6B81B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_025339_853763_B28737F3 
X-CRM114-Status: GOOD (  15.83  )
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

On 5/8/26 15:33, Maurizio Lombardi wrote:
> Currently, the final reference for the fabrics admin queue (fabrics_q)
> is dropped inside nvme_remove_admin_tag_set(). However, the primary
> admin queue (admin_q) defers dropping its final reference until
> nvme_free_ctrl().
> 
> Move the blk_put_queue() call for fabrics_q from nvme_remove_admin_tag_set()
> to nvme_free_ctrl(). This aligns the lifecycle management of both admin
> queues, ensuring they are freed symmetrically when the controller is finally
> torn down.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5d3200a66f8e..73575d087a07 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4932,10 +4932,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_stop_keep_alive(ctrl);
>   	blk_mq_destroy_queue(ctrl->admin_q);
> -	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
>   		blk_mq_destroy_queue(ctrl->fabrics_q);
> -		blk_put_queue(ctrl->fabrics_q);
> -	}
>   	blk_mq_free_tag_set(ctrl->admin_tagset);
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
> @@ -5077,6 +5075,8 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (ctrl->admin_q)
>   		blk_put_queue(ctrl->admin_q);
> +	if (ctrl->fabrics_q)
> +		blk_put_queue(ctrl->fabrics_q);
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
>   	nvme_free_cels(ctrl);

One wonders why we check for 'flags' in the first hunk, but for the 
existence of 'fabrics_q' in the second hunk.
But anyway.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

