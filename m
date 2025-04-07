Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF1C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 06:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+XjjzMkfjeVbxb9FPIyy1N94OzAvhANwAGCeDQ5DdI=; b=cpChpjMbaHyt6IFqQyMbIswM+b
	LqZC8tpeeOl0ZkFl9iUNqXUKoOv4FjHDoSyKbDC/zso1jJ9zwQp7/UMZfHzPv1sITufWNNU3LcK8z
	DdXEB7unvyjRam2c7y2p07EFSopwZ2xk0WD3Y2MjUV7iVwwkToPELfNC39R5IpDxVCQQcuXo1exPX
	Qd2nxtsSqAhjcSPyZcHnhRVgwtEkI7Jeztzxc1hlOvM5H9MhT6oqQ3NWxEfz1I24B7Ntkb14hqmf4
	7wG9keGWfoGE5YlAVkfSVr6eZ/3lQ/RQAjSjSvg1qYUNUYMVqE85pazDgKiDvpQe6EO7dfMAhhQff
	FRN+Rdjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1fhy-0000000GXDn-11HF;
	Mon, 07 Apr 2025 06:11:46 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1fhv-0000000GXD6-0oLR
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 06:11:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F01BC1F38D;
	Mon,  7 Apr 2025 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744006300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+XjjzMkfjeVbxb9FPIyy1N94OzAvhANwAGCeDQ5DdI=;
	b=tX5EWpnJEhcdTU0nMkiCT3i+6wF/EETTNAV2/u+SkGiX+rAsmAaZiecYp8MJsfWM8rT44u
	6JYdHq3k9/eu5187DomiXHSWfjYEw3ap6ghNcRgeB2xqLLmmDKaFBazZ0SDI1iei+1P9Jl
	5XUNCeysKHsBjO9f8i3lDg8uH5VqNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744006300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+XjjzMkfjeVbxb9FPIyy1N94OzAvhANwAGCeDQ5DdI=;
	b=D2OQjzqwkSvC4CAP119bwJchTrJ/m/W4Tzj4ntOFpAzruh1NsNXycellDG1NrYwqVStyyh
	gDko6WVjMndM8wCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EIZQd6Ww;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tPmgoaK3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744006299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+XjjzMkfjeVbxb9FPIyy1N94OzAvhANwAGCeDQ5DdI=;
	b=EIZQd6Ww8dThax+So+kpJ6eIVPI8e4lXUgHqehNqX1l54zBLbYr4AcPxQWWgWs7ad2xhni
	HRtnSAsr4UF5tGkZnCT0Alkwi3rIjYfCmS7aGqYPeTN8mgjOauuLwMEa4zb+NO76NBR7Vk
	AD6prF45BcopZIgsl/efMjlnyP0FOFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744006299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+XjjzMkfjeVbxb9FPIyy1N94OzAvhANwAGCeDQ5DdI=;
	b=tPmgoaK3F4VNF1ad6v+ip3yeO5aSk2UMtCJSvv3VWNQVhuFjZ2CGtwSNW6rxA/ETdbmm9r
	Il9VQMz2ppV+jfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A9C613691;
	Mon,  7 Apr 2025 06:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T8roI5ts82ddAQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Apr 2025 06:11:39 +0000
Message-ID: <3a8c6bea-231d-42ac-a980-d1e959aaaeed@suse.de>
Date: Mon, 7 Apr 2025 08:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 mlombard@bsdbackstore.eu, zhang.guanghui@cestc.cn, loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250404082801.1614252-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F01BC1F38D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250406_231143_398344_86B96112 
X-CRM114-Status: GOOD (  17.17  )
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

On 4/4/25 10:28, Maurizio Lombardi wrote:
> There is a potential race condition that can occur if
> the target closes the socket while the host is in the CONNECTING state.
> 
> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
> function is invoked. However, nvme_tcp_error_recovery() is unable
> to transition the controller state to NVME_CTRL_RESETTING because
> the controller is still in the CONNECTING state. As a result, error
> recovery is bypassed, and the controller incorrectly transitions
> to the LIVE state with closed sockets.
> 
> Subsequent attempts by the host to communicate with the target
> will result in an infinite loop.
> 
> Fix the bug by initiating the error recovery process to correctly
> handle the disconnection in case we missed this event
> while transitioning from CONNECTING to LIVE.
> 
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 26c459f0198d..f1e2b0417b39 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1329,6 +1329,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   			"failed to send request %d\n", ret);
>   		nvme_tcp_fail_request(queue->request);
>   		nvme_tcp_done_send_req(queue);
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   	}
>   out:
>   	memalloc_noreclaim_restore(noreclaim_flag);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

