Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F6FCD3427
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJ2WHFnP6HL3yasdFgy6UWvMenZX/DdqW79uquFSXMY=; b=cj31ca58NRnuuZXcsvz6Mmrc5n
	i8sU/bPP8t5UqnTmMRIGSVC6YETsjES5pLzADGuNwyIQn4H0dnE/b2fPp8ifcZ6IIhl5S3Be8mQkd
	KoEGeXh7a3tkyiiDak7EmZU7MBqja4tkofZ8CrPsGt65/rLmhGvjE2CBcZMmhGkxTiq/K24OcavQn
	53grpPlPlupCXAOlW3W42mkbHl82h92xI2jTO/anU45V8JlOD76zgZD79qqNjBUkpitGWAQNPWy1E
	XRArgS28dLDAgfMy/qKDlDsLIrj0JXAxAVhAYd1lZo8PP747gaH3kZ/73Cw0JyexxX+Id2olcFQYe
	GE8CanXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNFg-0000000D096-20w3;
	Mon, 11 May 2026 09:48:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNFe-0000000D07J-3ElO
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:48:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A5966179A;
	Mon, 11 May 2026 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ2WHFnP6HL3yasdFgy6UWvMenZX/DdqW79uquFSXMY=;
	b=a/Cl4aBwisrtPkp3h3MeDh759npp3ITgq2YHJmcUQxcrUObvuFADjt/ZJDt6jl/9q0tl6C
	w6rFCe9k80ZJ0JI9zR07ukeTMZlZsN63jdObWwtD3kQJRA6+6HUiAUWJl02hmsASv0NRUC
	RZy9CRNjuWIFlQYLP2bDMztvMqe3VnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ2WHFnP6HL3yasdFgy6UWvMenZX/DdqW79uquFSXMY=;
	b=H/Mvjjrksqrar4BEGdKJeYqL9CNKut/Xz01IKjW8/rufqF7XZMPwKeB1F06yq/YpiPj+uc
	XcSpeaN4lBs0GsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Phtco5gW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GoBgfw8y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778492916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ2WHFnP6HL3yasdFgy6UWvMenZX/DdqW79uquFSXMY=;
	b=Phtco5gWUbWnTTlk9LYgpIfPyQxiR5nb0cSBLDfbwhlmlxLW5Xmwh9D44hYaGrInkSGqL9
	eOVvI+jk8MMdgMT8GjGYYsVWzE19Rc09xk9Q6m9FIZlYqG7A2/cEsEJQL3Mr1qkr6jnamz
	DWg+nofs7s3OTeKKIy9qpEEmZGQfp8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778492916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ2WHFnP6HL3yasdFgy6UWvMenZX/DdqW79uquFSXMY=;
	b=GoBgfw8yXQfY1u7RONVP1/z4epXJxBaslHXwAimbOPhGDh4U1znG+BmZ05pymVOWDbEGdT
	y0mJ2Ln+M7wIceDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41F90593A3;
	Mon, 11 May 2026 09:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rNt0DPSlAWpcQgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:48:36 +0000
Message-ID: <82e295f9-0331-494d-88d0-1e56d0103082@suse.de>
Date: Mon, 11 May 2026 11:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/9] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-5-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-5-mlombard@redhat.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8A5966179A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_024838_955930_8FE7CF07 
X-CRM114-Status: GOOD (  13.44  )
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
> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
> timeout target. Instead, use the configured admin queue's timeout value
> to match the device's existing timeout setting.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9fd04cd7c5cb..dd1bc3807a2d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3094,7 +3094,7 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
>   	unsigned long timeout;
>   
>    retry:
> -	timeout = NVME_ADMIN_TIMEOUT;
> +	timeout = dev->ctrl.admin_timeout;
>   	while (nr_queues > 0) {
>   		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
>   			break;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

