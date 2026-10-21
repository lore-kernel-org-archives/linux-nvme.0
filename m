Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242C606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bROJRRUJ;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QeLO9phJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PEBAildY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gU/yZ4WF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oqA1xkyY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XBGbe1fjhl2G4dWmCvm5WY73lY8FjYTa40xqu6xvKw=; b=bROJRRUJ56BKSJwN7tr1fPBnLp
	PjoF6yGKSg0ptwlK7fpYAcDoRNEAlFa8K8d/W53XCoopgDRYf/eQq7fGJNbF/WBIX0f5KsG6v+8e6
	hZ0eLXQLvg6PXS+QAawDrdVLHviMcxpcQMXzxCs636HSlrqQ3IY8O+8wEX4I9dOfETGmDP5N/SBkp
	ld5moyZbEKmeqvESPSr9vnOoafUJRact937qetEEPPysk8DJV70E7dbOI5JGQ6ohomfFxt1JIq9iE
	stOp1XS0gfNVXf6OAxX2ql8KbAcC+Y9Q+MsMFnSEN3QII5KXklBUFeMASM7VyQkf+ebPyflZS3SOv
	vjD6Megw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTqn-0000000Bdof-0t1C;
	Wed, 21 Oct 2026 10:47:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTqk-0000000Bdo1-3DDa
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 10:47:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D0F921DC4;
	Wed, 21 Oct 2026 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792579632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XBGbe1fjhl2G4dWmCvm5WY73lY8FjYTa40xqu6xvKw=;
	b=QeLO9phJce6W5FH6g+WymPeQp3INaGsdihNySDQMwGG71kGlWrg8bHwEewolVkFAChKFEX
	0RhG+y859LT+kxwXmWPqNAVyfB7hKthATpbKRXbBBasyp0axZG2MbMUWQMOsCfhsBH1MhZ
	Bq1CfP2SRXT8Fi9BGorNh+5xJ1RbIp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792579632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XBGbe1fjhl2G4dWmCvm5WY73lY8FjYTa40xqu6xvKw=;
	b=PEBAildYbnBsLPkvFu0q4biKh+5Hs+qar+L+Q62xWuGaqKD0yNWIgVsQH/hTdZk3TuNqPP
	HDUPqL2KewU76QCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="gU/yZ4WF";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oqA1xkyY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792579630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XBGbe1fjhl2G4dWmCvm5WY73lY8FjYTa40xqu6xvKw=;
	b=gU/yZ4WFGwdZg0Bj2OzqhiN21M09NWgczdHqU/AwdTqkn+VpbEazjOR9QHaCl/smgYzuZ4
	pEUKWy2wh3UiR5wAGMH3E32brPaO5LvQYIirqgPT4pzDezikScgorAy1Ff6GyZE8OOw7y8
	sQ+NZvEoA+/nJXBHYgG7eXhyxnbd6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792579630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XBGbe1fjhl2G4dWmCvm5WY73lY8FjYTa40xqu6xvKw=;
	b=oqA1xkyYalCQ4Iipc9AwUJT+M3X6vHWhXygA+pJixYnGuGkAd3VZK5dZrSOifQdxOMVt8D
	anPR32v2/sRh1yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C331134A5;
	Wed, 21 Oct 2026 10:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V+1TCi6Y2Gr4ZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 10:47:10 +0000
Message-ID: <3f1c8036-3db7-48ac-9e6c-b5ee7a30aa82@suse.de>
Date: Wed, 21 Oct 2026 12:47:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: update error log in nvme_auth_submit()
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Martin George <marting@netapp.com>
References: <20261021083647.8519-1-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261021083647.8519-1-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D0F921DC4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_034714_950311_67DDD21C 
X-CRM114-Status: GOOD (  13.89  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 10:36 AM, Martin George wrote:
> nvme_auth_submit() issues both AUTH Send and AUTH Receive commands,
> but the failure messages are hardcoded to "auth_send failed", which
> can be misleading when an AUTH Receive fails. So print the correct
> direction instead.
> 
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>   drivers/nvme/host/auth.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index cbb38935fa22..85f005a5efd0 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -85,10 +85,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>   				     qid == 0 ? NVME_QID_ANY : qid, flags);
>   	if (ret > 0)
>   		dev_warn(ctrl->device,
> -			"qid %d auth_send failed with status %d\n", qid, ret);
> +			"qid %d auth_%s failed with status %d\n",
> +			qid, auth_send ? "send" : "receive", ret);
>   	else if (ret < 0)
>   		dev_err(ctrl->device,
> -			"qid %d auth_send failed with error %d\n", qid, ret);
> +			"qid %d auth_%s failed with error %d\n",
> +			qid, auth_send ? "send" : "receive", ret);
>   	return ret;
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

