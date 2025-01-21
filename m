Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE53C0218B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2025 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DY90jSXcyxLfm4gtMP2aLHnoUJHJGLxa/ZaH2+1/D78=; b=mi2byfGAq5c4HEHtcmxN6fy5mh
	PbbqeLA6R96uFoO3+3IYwCh6hxLsZi/LXlw5B6Fm67UWvTPp5yTWQ/Lphx8FNksCpcS2DpN5Qq+Bk
	B2UldHcCX5HCj6dFxVkJootbJwPzSNilwilM+TuPRAhKX1RpiJZGkPblno7VhYOF4TMgJNMF0+537
	cX2ZasWwkDRrIONy83+CkdtYL8sGEulWvnK0Yn+Np0L5G7o8q+EVH7YbYulZA8DiOLqbNj2O2owcH
	t6OhmsrfLGOpGsZHj8qX3SAuPs0IOka8ffcbYoal1+DNDd6kzCD/wY7lPgur+uE85cwFAv9S52jLL
	2xr4F/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taEyX-000000082Ct-13uO;
	Tue, 21 Jan 2025 14:11:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taEyU-000000082C2-2Cd7
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jan 2025 14:11:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 554931F747;
	Tue, 21 Jan 2025 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737468683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY90jSXcyxLfm4gtMP2aLHnoUJHJGLxa/ZaH2+1/D78=;
	b=pIWpCV/J29SR4h6tpc9eTkWZc8N72o8vsBeZ815SDPfc0DtOrEAy/axN40BR73YBqapCqY
	4/0jsp9lslOKAuxgnTKufd/d1hu0BcbYZXVWbD0tZ9BcSv/ihl9Z4e6p+iC7m609Lt4RDC
	SR1a14C9XCzALpiQWTcXRFXO2MIEYDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737468683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY90jSXcyxLfm4gtMP2aLHnoUJHJGLxa/ZaH2+1/D78=;
	b=Je4GltItDMzx0bBzMW9fdLXc/ii4Xwh8gom7cWul51ugFxorQDVHJ75u7eOWTBLSw9d4gp
	H3dS7LClQGpQKzDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pIWpCV/J";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Je4GltIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737468683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY90jSXcyxLfm4gtMP2aLHnoUJHJGLxa/ZaH2+1/D78=;
	b=pIWpCV/J29SR4h6tpc9eTkWZc8N72o8vsBeZ815SDPfc0DtOrEAy/axN40BR73YBqapCqY
	4/0jsp9lslOKAuxgnTKufd/d1hu0BcbYZXVWbD0tZ9BcSv/ihl9Z4e6p+iC7m609Lt4RDC
	SR1a14C9XCzALpiQWTcXRFXO2MIEYDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737468683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY90jSXcyxLfm4gtMP2aLHnoUJHJGLxa/ZaH2+1/D78=;
	b=Je4GltItDMzx0bBzMW9fdLXc/ii4Xwh8gom7cWul51ugFxorQDVHJ75u7eOWTBLSw9d4gp
	H3dS7LClQGpQKzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EAF613963;
	Tue, 21 Jan 2025 14:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DjqlDgurj2dhcQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 Jan 2025 14:11:23 +0000
Message-ID: <8238ff93-573a-41df-a6a8-3daaf46c56d8@suse.de>
Date: Tue, 21 Jan 2025 15:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Prevent infinite loop if socket closes during
 CONNECTING state
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20250121134540.1280828-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250121134540.1280828-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 554931F747
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_061126_717000_CF239FAA 
X-CRM114-Status: GOOD (  20.52  )
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

On 1/21/25 14:45, Maurizio Lombardi wrote:
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
> Fix the bug by checking for the -EPIPE error code, which indicates
> that the connection was closed by the target. If this condition
> is detected, ensure the error recovery process is initiated to correctly
> handle the disconnection.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 841238f38fdd..d0bb225dca23 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1261,6 +1261,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   			"failed to send request %d\n", ret);
>   		nvme_tcp_fail_request(queue->request);
>   		nvme_tcp_done_send_req(queue);
> +		if (ret == -EPIPE)
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   	}
>   out:
>   	memalloc_noreclaim_restore(noreclaim_flag);

This feels a bit weird; wouldn't it be better to allow transitions
from 'CONNECTING' to 'RESETTING'? Wouldn't the fix the issue, too?
But yeah, this is a real issue; I've seen it in my tests occasionally,
too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

