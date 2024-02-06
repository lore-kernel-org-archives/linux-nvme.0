Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE929C48286
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=; b=RA+y5UjGhGrIoNTJtbqTHiN0W/
	zZvPSXxV7xr3DbWE7cVGMBt6gqz0GmwljK6QGU+ZgFoU2ZQwij7Zcfx/u419DNY80XKuRO+bvyDl0
	Nntly/SuCmX3vE9gkuTK3tkHUdu4uR1/zKdXmDINMmuq6ugH8LaysgkHBaTSV9H7KA5ErHVsQU7gb
	5lGdKzTIQR/AsF7NTc2/Y+rGPI6MBEkC6Py0/0WNcTFS6kTLyaUE+n745Jw9jtWZ8n+iPq8FzfBzM
	H3PFJ++0VXAUomBATWDT18+KSUdFB/40Xcaaikkvktgg1Oe1FB6j68qwStUTqgqRftYMRARvfJczT
	JjTTbrCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXEMq-000000069bX-1xNc;
	Tue, 06 Feb 2024 05:51:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXEMm-000000069aW-3Is6
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 05:51:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA8281F896;
	Tue,  6 Feb 2024 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707198690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=FigCCNTfoUkjysf0OLwgDlQ0LR+eXaH2WuOxWJRfhTxZNYm1LAST1bQhaeFpnjPni2x6WW
	PmG9LlZximPRIitvRU0RR3HIxrwK6jy4yKiSwF/1jckkw4ssaN3zkjPhHxRGMMrn/8dcwe
	o79+fNN6E9Kggh/L0T54asrmnqVrtvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707198690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=9lMbQusCAO+2V0qa5SBdltKQmDBJOy+PRsYz1kybIUKhBCbjsj93QsGTvql0t5Qc6U0rxw
	sKuUlbfQhS29GRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707198690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=FigCCNTfoUkjysf0OLwgDlQ0LR+eXaH2WuOxWJRfhTxZNYm1LAST1bQhaeFpnjPni2x6WW
	PmG9LlZximPRIitvRU0RR3HIxrwK6jy4yKiSwF/1jckkw4ssaN3zkjPhHxRGMMrn/8dcwe
	o79+fNN6E9Kggh/L0T54asrmnqVrtvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707198690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=9lMbQusCAO+2V0qa5SBdltKQmDBJOy+PRsYz1kybIUKhBCbjsj93QsGTvql0t5Qc6U0rxw
	sKuUlbfQhS29GRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EC3213A25;
	Tue,  6 Feb 2024 05:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFk3Kt/IwWXiOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 Feb 2024 05:51:27 +0000
Message-ID: <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
Date: Tue, 6 Feb 2024 14:51:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-13-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FigCCNTf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9lMbQusC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.16)[-0.789];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: AA8281F896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_215133_009139_D6A1AC0D 
X-CRM114-Status: GOOD (  20.34  )
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

On 1/31/24 16:51, Daniel Wagner wrote:
> The assoc_list is a RCU protected list, thus use the RCU flavor of list
> functions.
> 
> Let's use this opportunity and refactor this code and move the lookup
> into a helper and give it a descriptive name.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 671d096745a5..fd229f310c93 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1114,14 +1114,27 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   	queue_work(nvmet_wq, &assoc->del_work);
>   }
>   
> +static bool
> +nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
> +{
> +	struct nvmet_fc_tgt_assoc *a;
> +
> +	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
> +		if (association_id == a->association_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static struct nvmet_fc_tgt_assoc *
>   nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   {
> -	struct nvmet_fc_tgt_assoc *assoc, *tmpassoc;
> +	struct nvmet_fc_tgt_assoc *assoc;
>   	unsigned long flags;
> +	bool done;
>   	u64 ran;
>   	int idx;
> -	bool needrandom = true;
>   
>   	if (!tgtport->pe)
>   		return NULL;
> @@ -1145,24 +1158,21 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
>   	atomic_set(&assoc->terminating, 0);
>   
> -	while (needrandom) {
> +	done = false;
> +	do {
>   		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
>   		ran = ran << BYTES_FOR_QID_SHIFT;
>   
>   		spin_lock_irqsave(&tgtport->lock, flags);
> -		needrandom = false;
> -		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
> -			if (ran == tmpassoc->association_id) {
> -				needrandom = true;
> -				break;
> -			}
> -		}
> -		if (!needrandom) {
> +		rcu_read_lock();
> +		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
>   			assoc->association_id = ran;
>   			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
> +			done = true;
>   		}
> +		rcu_read_unlock();
>   		spin_unlock_irqrestore(&tgtport->lock, flags);

Odd. You already take the tgtport lock, so there really is no point in 
using rcu_read_lock() here.
Or does the tgtport lock not protect the assoc_list?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


