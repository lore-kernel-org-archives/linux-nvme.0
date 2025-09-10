Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C2CA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2T4aqUgHvLcSKFo47uo0/3bwhjnXDkWTKJFGbbBmjQ=; b=2iA+gjaYzXRF7bYlyFOvJpP52u
	dYoMgj9HUy83uMDfF6B4o0XNUeY8Mh2ssJEBXThgxabEviU7i8ZOq0NW1jEftmxJcwyjBDY/teg5v
	P4sVcF5qrcePKmIfc3Qk/0ydocCLWCyAztAchARHNQMf6SdsV+A59xzVZb+2kcI3j0u+okTb3wTXB
	tqsNJmua8Yk06kLDBuJz0LMlwqtkJjX9i8uVus8jdnWzUluBTeyT8lpqSyhntn/BHdaEikqffS9GN
	6DE2epYDu7BKsMxPOLi1cnYaSSPfVJ9e55Bh2jJOpdDfp7aYJnzDEDyGiyZzBRduoJM8A+GOQW5eA
	WDtC/XVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwKP3-0000000EGAs-2iLD;
	Wed, 10 Sep 2025 12:58:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwKP1-0000000EG9Y-1i8g
	for linux-nvme@lists.infradead.org;
	Wed, 10 Sep 2025 12:58:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E6BC5F7AA;
	Wed, 10 Sep 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2T4aqUgHvLcSKFo47uo0/3bwhjnXDkWTKJFGbbBmjQ=;
	b=UHBYZeI+DggCd0DCBZ3oPOlSBYnZ4Rr09H9+q+a7oEWE01LPAc8YMp2Lf2U+fm9FLcWqlb
	yvyNvz0EovN4Azk5V7ta/lqadQwG5fRqSbTW+IgOG+0Jz2jXFP0IBa0Br+Cv4bHB0UXpg3
	FTrl6qr7ov/1/QauP+r70lAWvLC5Qss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2T4aqUgHvLcSKFo47uo0/3bwhjnXDkWTKJFGbbBmjQ=;
	b=cKZzJTwq9LWMiBrbNGC0o0spv2JY+m7MYSKYXFDw5O5pTpodXMSb0CqnPodpIkDDKBwvUX
	ZxEVJ0YHS0YM1PCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2T4aqUgHvLcSKFo47uo0/3bwhjnXDkWTKJFGbbBmjQ=;
	b=UHBYZeI+DggCd0DCBZ3oPOlSBYnZ4Rr09H9+q+a7oEWE01LPAc8YMp2Lf2U+fm9FLcWqlb
	yvyNvz0EovN4Azk5V7ta/lqadQwG5fRqSbTW+IgOG+0Jz2jXFP0IBa0Br+Cv4bHB0UXpg3
	FTrl6qr7ov/1/QauP+r70lAWvLC5Qss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2T4aqUgHvLcSKFo47uo0/3bwhjnXDkWTKJFGbbBmjQ=;
	b=cKZzJTwq9LWMiBrbNGC0o0spv2JY+m7MYSKYXFDw5O5pTpodXMSb0CqnPodpIkDDKBwvUX
	ZxEVJ0YHS0YM1PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C9D13301;
	Wed, 10 Sep 2025 12:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XftbGet1wWhKBQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Sep 2025 12:58:19 +0000
Message-ID: <1f7cd5e4-45f0-40cb-ab6a-6936a5062ae0@suse.de>
Date: Wed, 10 Sep 2025 14:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: send only permitted commands for secure concat
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org,
 Martin George <marting@netapp.com>
References: <20250909103509.10343-1-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250909103509.10343-1-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_055823_596769_A2296CF5 
X-CRM114-Status: GOOD (  19.54  )
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

On 9/9/25 12:35, Martin George wrote:
> In addition to sending permitted commands such as connect/auth
> over the initial unencrypted admin connection as part of secure
> channel concatenation, the host also sends commands such as
> Property Get and Identify on the same. This is a spec violation
> leading to secure concat failures. Fix this by ensuring these
> additional commands are avoided on this connection.
> 
> Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure concatenation")
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c0fe8cfb7229..1413788ca7d5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2250,6 +2250,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   	if (error)
>   		goto out_cleanup_tagset;
>   
> +	if (ctrl->opts->concat && !ctrl->tls_pskid)
> +		return 0;
> +
>   	error = nvme_enable_ctrl(ctrl);
>   	if (error)
>   		goto out_stop_queue;

Hmm. Not sure. While section 8.3.4.3 'NVMe In-band Authentication' states:

  If one or more of the bits in the AUTHREQ field are set to ‘1’, then
  the controller requires that the host authenticate on that queue in
  order to proceed with Fabrics, Admin, and I/O commands.

 From which one could assume that none of the commands are allowed.
But it then goes on to state:

  The state of an in-progress authentication transaction is soft-state.
  If the subsequent command in an authentication transaction is not
  received by the controller within a timeout equal to:
   * the Keep Alive Timeout value (refer to Figure 546), if the Keep
     Alive Timer is enabled; or
   * the default Keep Alive Timeout value (i.e., two minutes), if the
     Keep Alive Timer is disabled;

one can imply that KATO is running during authentication transactions.
But that might require additional commands, so really I'm not sure.
Let me ask FMDS for clarification.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

