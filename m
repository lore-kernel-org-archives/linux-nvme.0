Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C21EC7115B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVHpla3RiPidyui0fiG8jyQnFMAfdIKH7MWtfQy57gI=; b=vgwg34M1Tp5ROQV62iMxuzXIhi
	U41bCpJ5rJaJSy2oGIhL6PY/nEsTmh80er6uHtPzoLv3rkV5/L6a6jheiWAJBHVvJ9nTNotZApMQF
	PjKIh0JU7BygyYnNLvLLGw328FQabGZSy2dVWv7fWbfiShR4fsPEJCDkkjdyI4DZaQSZnouxOuADf
	YEIWrOD/SyqukGSKoUspnpdKHUrytvj9jbmGT2g8jgH/FMN/nrnsVeDtu0uiQDRhr/leWQOgyf13R
	qn9Km3wMiD5gNgS3mhSLqLCm2wBnWC3ynCCu/vRlJk5Lv6+IkfQbP5CKtvMjkZ92pNQZhApvzlkhF
	4ObTzhjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTcNb-00000001zgs-0a6O;
	Mon, 23 Jun 2025 08:18:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTcNZ-00000001zes-0ZPP
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 08:18:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0633121181;
	Mon, 23 Jun 2025 08:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750666690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVHpla3RiPidyui0fiG8jyQnFMAfdIKH7MWtfQy57gI=;
	b=t+R20bvVxKK1J0a9ZLL1cRMqaaRYY+5AN/xgK7jeAQDscdphm/WMrpQmtz1IJbk/8J7be6
	JHYupiiX4esxqHH01fbg7aG+B0kF62W+pAMwsh8Sbz6wUpa/CVFHiBo/Vp93njulIFqrRQ
	L+9D3OxdQvifUmJg18XqcPRlzKFGiWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750666690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVHpla3RiPidyui0fiG8jyQnFMAfdIKH7MWtfQy57gI=;
	b=fUsD7jb5GL5w3YvsuCdi7DcRf5wVd2/ypqbDD/FEjCeRHYAN+tuPIpzF3Eez4Eg8dts8b+
	3kgAIXSs2rs/plAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t+R20bvV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fUsD7jb5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750666690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVHpla3RiPidyui0fiG8jyQnFMAfdIKH7MWtfQy57gI=;
	b=t+R20bvVxKK1J0a9ZLL1cRMqaaRYY+5AN/xgK7jeAQDscdphm/WMrpQmtz1IJbk/8J7be6
	JHYupiiX4esxqHH01fbg7aG+B0kF62W+pAMwsh8Sbz6wUpa/CVFHiBo/Vp93njulIFqrRQ
	L+9D3OxdQvifUmJg18XqcPRlzKFGiWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750666690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVHpla3RiPidyui0fiG8jyQnFMAfdIKH7MWtfQy57gI=;
	b=fUsD7jb5GL5w3YvsuCdi7DcRf5wVd2/ypqbDD/FEjCeRHYAN+tuPIpzF3Eez4Eg8dts8b+
	3kgAIXSs2rs/plAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD92913485;
	Mon, 23 Jun 2025 08:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6hjZM8ENWWjRcQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 23 Jun 2025 08:18:09 +0000
Date: Mon, 23 Jun 2025 10:18:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, hare@suse.de, axboe@kernel.dk, shinichiro.kawasaki@wdc.com, 
	gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head reference
 counter
Message-ID: <e0da70ca-ba39-4511-ab77-ca8b3a6a6c39@flourine.local>
References: <20250620080257.27993-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620080257.27993-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0633121181
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_011813_321668_012A186A 
X-CRM114-Status: GOOD (  10.96  )
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

Hi Nilay,

On Fri, Jun 20, 2025 at 01:32:43PM +0530, Nilay Shroff wrote:
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4089,6 +4089,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  	struct nvme_ns *ns;
>  	struct gendisk *disk;
>  	int node = ctrl->numa_node;
> +	bool last_path = false;
>  
>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>  	if (!ns)
> @@ -4181,9 +4182,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   out_unlink_ns:
>  	mutex_lock(&ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> +	if (list_empty(&ns->head->list)) {
>  		list_del_init(&ns->head->entry);
> +		last_path = true;
> +	}
>  	mutex_unlock(&ctrl->subsys->lock);
> +	if (last_path)
> +		nvme_put_ns_head(ns->head);
>  	nvme_put_ns_head(ns->head);

Could the put moved in front of 'goto out_unlink_ns'?

Thanks,
Daniel

