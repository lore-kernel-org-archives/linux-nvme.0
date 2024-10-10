Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F039CF07AA
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfjBchlkRwGMofrxGcYQNuhhVYDNWQUmm1VFBDMcesM=; b=ETuIBVd3FCsBBxQOSuqw6rW74w
	EO5f+sFJ0NvmTUyVGmMFoocnAqZ71He+KM/wWwMPfIx+2FNrhUlhXpOQ8GDewUFhVbaNZOcIj3PSm
	kK8ekaEYvzWh2L2Um8qJYudZuCHVAC1FXQQMD9R6ZR4l6Ghq/GZnFCMtVpLVTyzJLsQoAZmNE9kNR
	AmSgU07wY1wZsWM+p11KA+Q8a9xaRrcCysJosaUhn2hvE9JySkbz8KtkcxIvi+Wm7UFCcTvk25uFH
	Uejwu35JVNE7rHgXkyjUjf+3qx8LPhQ70ExgsHgaDsyTga9cSGK3Owz8z12fApyzWPvpJQtOiaEWt
	69h6hcqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1symTF-0000000Bdz2-42y9;
	Thu, 10 Oct 2024 06:16:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1symTA-0000000BdxF-0tzG
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 06:16:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1D751FE26;
	Thu, 10 Oct 2024 06:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728540974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfjBchlkRwGMofrxGcYQNuhhVYDNWQUmm1VFBDMcesM=;
	b=CQqZ9T5tNYlYZcrj55Nly8qfmnakZyAzBcjU2Yh0AFI8BN3RXLiDuDvK/04s4Iia2FvD6K
	fAVbZc1CXPnMlfw/xEEGK4An2UnKkzoZT0zFN9oWwUB8cl4Y0eOuEY0cQIbN8WdQbSCtUs
	qfXsUG5LpjmvMdOroIeqD0qb60CtzM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728540974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfjBchlkRwGMofrxGcYQNuhhVYDNWQUmm1VFBDMcesM=;
	b=Zom+5GX59vvvjLzuO/dLpbokGpEVBFnVfcjrci3lNDNN3gYwBTkHSoVVfkhy6hNR+4KRv1
	wiqMOwqzGG2ujtAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728540972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfjBchlkRwGMofrxGcYQNuhhVYDNWQUmm1VFBDMcesM=;
	b=sfouOfC7hcO3Y8MBH1tg1Inc1QM2L3tCQ8WYkKRnvdpXuqZY+klNd55jsU+sLBpa0MbQoB
	n+hwdtYbHn2DxWBdKHmkIEGX4cpk/b03nPlx055ZcOcWW2e3DlLV+Cwz2lIOIqPEscqn6t
	/Fl7coITPTEkfra1eG9UAgQE1hniRsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728540972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfjBchlkRwGMofrxGcYQNuhhVYDNWQUmm1VFBDMcesM=;
	b=bOWW4GqT6lJUqeEcgBJsmwrYvbcFk+a0EhEYod9RHdfpfLn47t/eVq4645uflMafeLqGzV
	o8k0XZ7+HJJjyiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDBE21370C;
	Thu, 10 Oct 2024 06:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id liCpLCxxB2ebRQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Oct 2024 06:16:12 +0000
Message-ID: <879de5db-8f09-4c03-9bca-56e17536e211@suse.de>
Date: Thu, 10 Oct 2024 08:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de> <Zwa-MBS6wn_dGxge@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zwa-MBS6wn_dGxge@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_231616_426079_CB849E5B 
X-CRM114-Status: GOOD (  14.60  )
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

On 10/9/24 19:32, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
>> With my testcase _all_ paths return NS_NOT_READY during partition scan, so
>> I/O is constantly bounced between paths, and partition scan never returns.
>> Doesn't matter where you call it, it's stuck.
> 
> Assuming you mean a differet status, like NVME_SC_INTERNAL_PATH_ERROR, I
> can recreate a stuck scan. Let me get one more shot at fixing this by
> suppressing the scan to another context. This one is successful in my
> tests:
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 48e7a8906d012..e1fd53ff2c0ca 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -580,6 +580,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>   	return ret;
[ .. ]

Piling workqueues on workqueues ... but anyway, I'll give it a spin.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


