Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F3FC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZJNSlafJ4o4E8VaKaQNC/3ukD3OJ5/CiUClEs4o5Pw=; b=1HqhIRm95QqykZal8b5ir+y6sR
	hUq/lKyUJrE98auWiwAvv6j81vtCZdkS6GC9tCLsVl3ahyLR9pn6eOUvn0PpsmbVRNXl1mLew6RY+
	slZ+qOG+5b8yb07y8sQHOiX0ykznCn9qCw3nWYWJIbY9gDJOjhCbbw5VoZpTdYBmZtypUW1OUkY6H
	GunKujZ1Hb1bpLieBkvYIgVbgrTXkaGCD2kkr7QGJHxRbiqWoRHrUb/liFg1MvV+EqkkrgT7zQue7
	kg+5HP2nTC8Pu6geDuJD95X2nmCLZknRmFUKsggtp+HR8WFLApydNJm7cHz9xRPPWG5gaBDSaxUPw
	w95TYFHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzcPv-00000004Cyh-17hR;
	Wed, 24 Apr 2024 13:12:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzcPq-00000004CuV-07P1
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 13:12:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50E7B5D6A7;
	Wed, 24 Apr 2024 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713964313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZJNSlafJ4o4E8VaKaQNC/3ukD3OJ5/CiUClEs4o5Pw=;
	b=FcxDURwgR+aEZvdeKIW7/Ta6JDA8Im/FMTFODxBHe3bwqfxi0kZOnYB8MwY9xIi/pD6Uq9
	RBv3C0fgaEP4dXeCzrphxVbaomNNWL8MprtIwV5GbP9NCPibVFrLUDNG+NB0vxDd2YYe2G
	h/MshgvaZo2FOtB/c8ZDj8CaHMQaHQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713964313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZJNSlafJ4o4E8VaKaQNC/3ukD3OJ5/CiUClEs4o5Pw=;
	b=4/EvjaNJkaqaBgQEuXg7wEipTv8BVTn2fwZIIX2AYfc9O7gIK67K4gkLQUwjENJb+gUTqU
	sNr0rS8/N2YQIeDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FcxDURwg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4/EvjaNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713964313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZJNSlafJ4o4E8VaKaQNC/3ukD3OJ5/CiUClEs4o5Pw=;
	b=FcxDURwgR+aEZvdeKIW7/Ta6JDA8Im/FMTFODxBHe3bwqfxi0kZOnYB8MwY9xIi/pD6Uq9
	RBv3C0fgaEP4dXeCzrphxVbaomNNWL8MprtIwV5GbP9NCPibVFrLUDNG+NB0vxDd2YYe2G
	h/MshgvaZo2FOtB/c8ZDj8CaHMQaHQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713964313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZJNSlafJ4o4E8VaKaQNC/3ukD3OJ5/CiUClEs4o5Pw=;
	b=4/EvjaNJkaqaBgQEuXg7wEipTv8BVTn2fwZIIX2AYfc9O7gIK67K4gkLQUwjENJb+gUTqU
	sNr0rS8/N2YQIeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D61813690;
	Wed, 24 Apr 2024 13:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jy0ABRkFKWbQewAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Apr 2024 13:11:53 +0000
Message-ID: <ad6a989c-4362-4811-b78b-fba7e186feb4@suse.de>
Date: Wed, 24 Apr 2024 15:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: print an error message if the auth timeout
 expires
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: sagi@grimberg.me, dwagner@suse.de, linux-nvme@lists.infradead.org
References: <20240424102428.1298052-1-mlombard@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240424102428.1298052-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 50E7B5D6A7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_061202_243710_9F7A4D93 
X-CRM114-Status: GOOD (  15.54  )
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

On 4/24/24 12:24, Maurizio Lombardi wrote:
> When the auth_expired_work fires, an error message should be printed
> to inform the user that the authentication is failing because of
> a timeout, so he doesn't get misleaded into thinking there is a bug
> in the auth code when seeing messages like the following:
> 
> nvmet: nvmet_execute_auth_send: ctrl 1 qid 2 step mismatch (2 != 0)
> nvmet: nvmet_execute_auth_send: failure incorrect message.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index eb7785be0ca7..7436ebda9f70 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -17,8 +17,8 @@ static void nvmet_auth_expired_work(struct work_struct *work)
>   	struct nvmet_sq *sq = container_of(to_delayed_work(work),
>   			struct nvmet_sq, auth_expired_work);
>   
> -	pr_debug("%s: ctrl %d qid %d transaction %u expired, resetting\n",
> -		 __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
> +	pr_err("%s: ctrl %d qid %d transaction %u expired, resetting\n",
> +		__func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
>   	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>   	sq->dhchap_tid = -1;
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


