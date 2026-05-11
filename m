Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0DCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgee1qxr9pSgU5VjXP79XClZKo2ChTTSM4UphCnOk8s=; b=pBE36zor8f2ulPUXnK895OGRaW
	JwAxu1n6rfgQPgcVn+AGmFoDdUVDAMKO9Iyo0MPZL11ZFEPJIOzS0bEI4eDZTJKN/yKEFplzhODA2
	KiJrai4XT4JfOFoGTzgXIkFo5RHAf4M2VnalruPEJgPM+KRsW7GEZ/lFkFNyoI75K0pIAUF6NJuz1
	yZc0nFRxPCyN69BUgiNJy9YDY+Wm6uVXXnL8QuRn9x+Oyap30E2IDy94BJpln4tvCDRyKLShKqwUA
	4OLt5XSt0bAoGXm+/RxHw0P8y4D7qEYEBRSh4cnpdn1J4y1nWF7J6ckyasSANIkcEuRYNJdAOlRNQ
	ZPhVLkrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNEd-0000000CzfM-2E03;
	Mon, 11 May 2026 09:47:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNEb-0000000Czef-15sQ
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:47:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41F6168566;
	Mon, 11 May 2026 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgee1qxr9pSgU5VjXP79XClZKo2ChTTSM4UphCnOk8s=;
	b=bVwZa+gZ07O03BKDyBUmusu8f0Fli6pRME3it9y9bIJUq/zzMLKyFiVJyElJhDt76d4j+P
	wDt6Iv1mU/EV+d9Fr8Rn0HypipsVlFqEXFCtCFZEo7R/8p5iNi4WKMXAeYAd0Gt7iWQBVP
	rq2KSkwqA4ihl17oXEqVgd5q5mFTDPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgee1qxr9pSgU5VjXP79XClZKo2ChTTSM4UphCnOk8s=;
	b=AqPm4+rcaD2jGdpv04RWEFoJ5T3R6Fu8RXffMADlWIGnArPf3NSb77q0ixf9t0Vwo5sULu
	kpHWabFCLnAH+kBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bVwZa+gZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AqPm4+rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgee1qxr9pSgU5VjXP79XClZKo2ChTTSM4UphCnOk8s=;
	b=bVwZa+gZ07O03BKDyBUmusu8f0Fli6pRME3it9y9bIJUq/zzMLKyFiVJyElJhDt76d4j+P
	wDt6Iv1mU/EV+d9Fr8Rn0HypipsVlFqEXFCtCFZEo7R/8p5iNi4WKMXAeYAd0Gt7iWQBVP
	rq2KSkwqA4ihl17oXEqVgd5q5mFTDPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgee1qxr9pSgU5VjXP79XClZKo2ChTTSM4UphCnOk8s=;
	b=AqPm4+rcaD2jGdpv04RWEFoJ5T3R6Fu8RXffMADlWIGnArPf3NSb77q0ixf9t0Vwo5sULu
	kpHWabFCLnAH+kBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 181F4593A3;
	Mon, 11 May 2026 09:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i+NLBbOlAWo8QQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:47:31 +0000
Message-ID: <f36abb90-e6e3-490d-9c0d-c0920b25b326@suse.de>
Date: Mon, 11 May 2026 11:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-4-mlombard@redhat.com>
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
X-Rspamd-Queue-Id: 41F6168566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_024733_445719_362C2418 
X-CRM114-Status: GOOD (  16.52  )
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
> When a controller connects, nvme_start_ctrl() emits the
> "NVME_EVENT=connected" uevent and sets the NVME_CTRL_STARTED_ONCE flag.
> Currently, the uevent is emitted before the flag is set.
> 
> This creates a race condition for userspace tools (like udev rules)
> that might rely on the "connected" event to configure sysfs attributes.
> Specifically, if a udev rule attempts to set the newly introduced
> `admin_timeout` attribute immediately after receiving the uevent,
> the sysfs store function might evaluate the NVME_CTRL_STARTED_ONCE
> bit before it is actually set, resulting in spurious -EBUSY error.
> 
> Swap the order of operations in nvme_start_ctrl() so that the
> NVME_CTRL_STARTED_ONCE flag is set before the uevent is sent.
> This guarantees that the admin_timeout can already be changed
> when userspace is notified.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b1bfcd0a0e5b..22be8cf5e982 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5039,8 +5039,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   		nvme_mpath_update(ctrl);
>   	}
>   
> -	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
>   	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
> +	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

