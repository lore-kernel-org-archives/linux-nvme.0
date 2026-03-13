Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F391106FD98
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iwacc6XFJ9P5R0DqR50k4Zh3wnteu/FQaUY2UTr0XHU=; b=T2T5ZGuKzMUl655k1BjMQFYJpi
	FurKAY1+uyxJjF+wFXRmVrVt5jd/jZMKXFoKJQAEvmbajObjHQ4zbobFUJounHBozokJ6fEdfrT9j
	nEGNePQQVJblBX4l6m+skvJmqZeWLvubXV7frxPdrZYncSaD+gboc4NT+lkt6fBfOLnM6hv/tD6ON
	Jd2jAG4oxUMM5bVIJszLXqzMd/4Aoc0crAQ+xIJhadR17f+nEQQWU+sk19Oqff28Gk4maCAYDwgI8
	NcZgj5Tj5hRxFlO9an1HN275+g9jK7pW52C+IxJ8+JnewmTgw523w640fc4vjAcP2kqBIZ4ENkTQl
	lcV3ttDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0wp0-0000000H1zz-22G1;
	Fri, 13 Mar 2026 07:20:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0wox-0000000H1yu-1lnL
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 07:20:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D299C5CEFB;
	Fri, 13 Mar 2026 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773386429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwacc6XFJ9P5R0DqR50k4Zh3wnteu/FQaUY2UTr0XHU=;
	b=xF9D7vIYCr2vkSciWLHccrNQQXUCJRUtZPKlzcCmVNm5ERm0K82IMA7lzeEVllF6pa6Xw9
	r3iEn5Mi92letiTjUTA7fqQg690TvtB6WnQ56lwFJrUvtZtRlXB9R7DuYqavyBxGHxWUxu
	U8Qba8p+mZySn2KEdwcG1Mm5SVuKgK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773386429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwacc6XFJ9P5R0DqR50k4Zh3wnteu/FQaUY2UTr0XHU=;
	b=OxcjoXPJZJ1PoD0rATytVSKc8hei/d1D2km4SZegmpIxgluNzmRe/3gVHCb0K1jYge358D
	5LYk438vGlGFevAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dqhOyWSX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VjWDsCFt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773386428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwacc6XFJ9P5R0DqR50k4Zh3wnteu/FQaUY2UTr0XHU=;
	b=dqhOyWSX3XJrReZ0VmXRQ6q9+IBNZ9z1A2xBlr3bQ1fsdj2FT2BAnqL5QJs9tzk/VOd4MH
	ftO8m2WcxEomMFQXgi3VcvqH6of0Rd1RmZqIxze7DXDhK+5p+r00DKPrdNtfSfknw9iShR
	c6gL++LFedut80YCGN26TwFR9ySdJ0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773386428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwacc6XFJ9P5R0DqR50k4Zh3wnteu/FQaUY2UTr0XHU=;
	b=VjWDsCFtpbwslSMhyFcuUe2oMnAJlm6ySYSaDJnJDC4ab460EDJP/5Itpzz0cdWJDvy5r7
	sgYA83hddagywvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79A08403DA;
	Fri, 13 Mar 2026 07:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S0PgG7y6s2mxegAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Mar 2026 07:20:28 +0000
Message-ID: <5accbc4b-42c3-4d47-a8c5-51b0a7180f11@suse.de>
Date: Fri, 13 Mar 2026 08:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] nvmet-tcp: remove redundant calls to
 nvmet_tcp_fatal_error()
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
 sagi@grimberg.me, chaitanyak@nvidia.com, mlombard@arkamax.eu
References: <20260312134057.110274-1-mlombard@redhat.com>
 <20260312134057.110274-3-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260312134057.110274-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,suse.de,gmail.com,grimberg.me,nvidia.com,arkamax.eu];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D299C5CEFB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_002032_110922_60C75A4F 
X-CRM114-Status: GOOD (  17.33  )
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

On 3/12/26 14:40, Maurizio Lombardi wrote:
> Executing nvmet_tcp_fatal_error() is generally the responsibility
> of the caller (nvmet_tcp_try_recv); all other functions should
> just return the error code.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 1fbf12df1183..b250b13854b4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -885,7 +885,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>   	if (le32_to_cpu(icreq->hdr.plen) != sizeof(struct nvme_tcp_icreq_pdu)) {
>   		pr_err("bad nvme-tcp pdu length (%d)\n",
>   			le32_to_cpu(icreq->hdr.plen));
> -		nvmet_tcp_fatal_error(queue);
>   		return -EPROTO;
>   	}
>   
> @@ -951,7 +950,6 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>   	ret = nvmet_tcp_map_data(cmd);
>   	if (unlikely(ret)) {
>   		pr_err("queue %d: failed to map data\n", queue->idx);
> -		nvmet_tcp_fatal_error(queue);
>   		return -EPROTO;
>   	}
>   
> @@ -1024,7 +1022,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   
>   err_proto:
>   	/* FIXME: use proper transport errors */
> -	nvmet_tcp_fatal_error(queue);
>   	return -EPROTO;
>   }
>   
> @@ -1039,7 +1036,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   		if (hdr->type != nvme_tcp_icreq) {
>   			pr_err("unexpected pdu type (%d) before icreq\n",
>   				hdr->type);
> -			nvmet_tcp_fatal_error(queue);
>   			return -EPROTO;
>   		}
>   		return nvmet_tcp_handle_icreq(queue);
> @@ -1048,7 +1044,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   	if (unlikely(hdr->type == nvme_tcp_icreq)) {
>   		pr_err("queue %d: received icreq pdu in state %d\n",
>   			queue->idx, queue->state);
> -		nvmet_tcp_fatal_error(queue);
>   		return -EPROTO;
>   	}
>   
> @@ -1065,7 +1060,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
>   			queue->idx, queue->nr_cmds, queue->send_list_len,
>   			nvme_cmd->common.opcode);
> -		nvmet_tcp_fatal_error(queue);
>   		return -ENOMEM;
>   	}
>   
> @@ -1086,9 +1080,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   	if (unlikely(ret)) {
>   		pr_err("queue %d: failed to map data\n", queue->idx);
>   		if (nvmet_tcp_has_inline_data(queue->cmd))
> -			nvmet_tcp_fatal_error(queue);
> -		else
> -			nvmet_req_complete(req, ret);
> +			return -EPROTO;
> +
> +		nvmet_req_complete(req, ret);
>   		ret = -EAGAIN;
>   		goto out;
>   	}
> @@ -1211,7 +1205,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   
>   		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
>   			pr_err("unexpected pdu type %d\n", hdr->type);
> -			nvmet_tcp_fatal_error(queue);
>   			return -EIO;
>   		}
>   
> @@ -1225,16 +1218,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   	}
>   
>   	if (queue->hdr_digest &&
> -	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
> -		nvmet_tcp_fatal_error(queue); /* fatal */
> +	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen))
>   		return -EPROTO;
> -	}
>   
>   	if (queue->data_digest &&
> -	    nvmet_tcp_check_ddgst(queue, &queue->pdu)) {
> -		nvmet_tcp_fatal_error(queue); /* fatal */
> +	    nvmet_tcp_check_ddgst(queue, &queue->pdu))
>   		return -EPROTO;
> -	}
>   
>   	return nvmet_tcp_done_recv_pdu(queue);
>   }
> @@ -1319,7 +1308,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>   			le32_to_cpu(cmd->exp_ddgst));
>   		nvmet_req_uninit(&cmd->req);
>   		nvmet_tcp_free_cmd_buffers(cmd);
> -		nvmet_tcp_fatal_error(queue);
>   		ret = -EPROTO;
>   		goto out;
>   	}

I seem to be missing something crucial here. But after applying this
patch _all_ invocations to nvmet_tcp_fatal_error() are gone.
(Applying the patches on top of linus tree with topmost commit 
0257f64bdac7fdca30fa3cae0df8b9ecbec7733a)

I must be missing something crucial here ...

Cheers,

Hannes_
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

