Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E30E6C60F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=; b=d3zWSDNkuCWDkBejNEeMRI1n4i
	c6yg+c0cPuwKYWmztXh3wtIaPLJzqnUkQgIFG5gk4j5mNIkahCz2sj7xlvqgQBZltlyOKQihKGfO2
	SAWqtRY8GGOCWcgNueYW4b35fHz9WEW6gFVFV7Rlb8MVZP6yC3dtdwPxi1T27g4tG0pEdy6KMUSMK
	y4y/g2w47mJlOkQzYKcMBhEMZ7xVH6eWTwjEFkpJF/UP2jsR3Vo+uwVoQ+Cc6MZJOviIRIkUII22o
	fZGYb1vsaOTWcUzj6jFDVpcbca30iV7RwSJ2B6eKXZQyQG1ReU1N2Ooexlyti6Efgd6iGcSTl038L
	ZE4r2ccw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tINBv-00000008UY4-38CA;
	Tue, 03 Dec 2024 07:19:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tINBt-00000008UWD-39Mw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 07:19:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3281E1F445;
	Tue,  3 Dec 2024 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733210362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=sTFlhZC61pLD+EdeHkxsxirk8UqojISVEuqXHcKKzxgQo3WNw5WDIyOf7sRGTy0mSVZ0lT
	nmxk+RFGfaOzHAyOIEI+DTSXOXE4VmIOztdb6zyFLu8Iq6llOQAzgaYyTpijBESt9OGhYo
	bwq5PcYUL3fE1z7EQLCMebLbFs+2gek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733210362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=zbdjAzaACmnBIVdehhDY/7ZCam9b84JPTxuG2+nkZ5H1DyUnWOzd2dCWt7xNGDjHDTIbTw
	6SX3z9ZvLhDXthAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733210362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=sTFlhZC61pLD+EdeHkxsxirk8UqojISVEuqXHcKKzxgQo3WNw5WDIyOf7sRGTy0mSVZ0lT
	nmxk+RFGfaOzHAyOIEI+DTSXOXE4VmIOztdb6zyFLu8Iq6llOQAzgaYyTpijBESt9OGhYo
	bwq5PcYUL3fE1z7EQLCMebLbFs+2gek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733210362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=zbdjAzaACmnBIVdehhDY/7ZCam9b84JPTxuG2+nkZ5H1DyUnWOzd2dCWt7xNGDjHDTIbTw
	6SX3z9ZvLhDXthAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB8DE13A15;
	Tue,  3 Dec 2024 07:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z9jiM/mwTmdpKAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Dec 2024 07:19:21 +0000
Message-ID: <d1b103bb-fc9b-45dc-b637-75ce9fdb320c@suse.de>
Date: Tue, 3 Dec 2024 08:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] nvme-tcp: fix the memleak while create new ctrl
 failed
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: lengchao@huawei.com
References: <cover.1733196360.git.chunguang.xu@shopee.com>
 <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_231925_932757_FCA06337 
X-CRM114-Status: GOOD (  15.59  )
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

On 12/3/24 04:34, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now while we create new ctrl failed, we have not free the
> tagset occupied by admin_q, here try to fix it.
> 
> Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e416af2659f..55abfe5e1d25 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   	}
>   destroy_admin:
>   	nvme_stop_keep_alive(ctrl);
> -	nvme_tcp_teardown_admin_queue(ctrl, false);
> +	nvme_tcp_teardown_admin_queue(ctrl, new);
>   	return ret;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

