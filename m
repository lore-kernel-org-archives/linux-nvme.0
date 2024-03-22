Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9A4C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/2YYVXn2kfWKolM9ajqNa3HuIdZxpNP5R8h33BM15g=; b=K9tlsFg7Aj/cVyjutlaOf2Bqzt
	bZ+Ixlv1kIwzj7LxIBsaQXTEJacrSRzrHxeTdFoHPtNHw2NrtBFhMD7GJ/KMDIktPBAYIyRiv+Dad
	F7Pyl+p9z+5MvSi89vHNGccJuxSOTIN4tYhnBJBq9oa8zOjofjk08QgB3PpXvQtARDY4zgupSyMSJ
	lgaAgbEiolQuvO3+jpaotursY/NzueiFcFoQtTrdDz6eE+P6DiKT+NNRQ2KosRfxzJbdZQCU3PYre
	gFhbZRzt4Docclp22Dt3U1YmcLYQNt3XYL28N5JTCQ3KuBomiodRXA0/dezDKn51msGlP/CYXJG3l
	0pCXTG6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbeG-00000006gqw-1aS4;
	Fri, 22 Mar 2024 09:57:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnbe9-00000006gmd-3ZDb
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 09:57:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BF455FC55;
	Fri, 22 Mar 2024 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711101426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2YYVXn2kfWKolM9ajqNa3HuIdZxpNP5R8h33BM15g=;
	b=KXKqwzgYj/Qw9SRbQq9wTONbUYHbEB25Pz7PRSoWiliw5cUdns25NQJwvGseW5FtNBYWiR
	zGYgluntrMdfqkZFXdr0ZFL3khzggegW0boix7diajip2fVytrAxMa/s6zuY6m9azaf4Li
	e3NeJbwsnFmljzaN+abAnp5F03dHvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711101426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2YYVXn2kfWKolM9ajqNa3HuIdZxpNP5R8h33BM15g=;
	b=WVgTH1m0y9t+DG9gzp3L3Ydi8YoLRFPBJTsviqFy35wITBP/DGw9/q4lWfVIXnouma3V2D
	xv9cUIT379hm19Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711101426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2YYVXn2kfWKolM9ajqNa3HuIdZxpNP5R8h33BM15g=;
	b=KXKqwzgYj/Qw9SRbQq9wTONbUYHbEB25Pz7PRSoWiliw5cUdns25NQJwvGseW5FtNBYWiR
	zGYgluntrMdfqkZFXdr0ZFL3khzggegW0boix7diajip2fVytrAxMa/s6zuY6m9azaf4Li
	e3NeJbwsnFmljzaN+abAnp5F03dHvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711101426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2YYVXn2kfWKolM9ajqNa3HuIdZxpNP5R8h33BM15g=;
	b=WVgTH1m0y9t+DG9gzp3L3Ydi8YoLRFPBJTsviqFy35wITBP/DGw9/q4lWfVIXnouma3V2D
	xv9cUIT379hm19Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AC1E13688;
	Fri, 22 Mar 2024 09:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H46KGfJV/WVtUAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Mar 2024 09:57:06 +0000
Message-ID: <400deab2-2b15-4ff1-ba38-8d970e1ef648@suse.de>
Date: Fri, 22 Mar 2024 10:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] nvmet: implement unique discovery NQN
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240322070927.30454-1-hare@kernel.org>
 <dc120432-e759-44bb-8667-78e381be61ee@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <dc120432-e759-44bb-8667-78e381be61ee@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KXKqwzgY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WVgTH1m0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 8BF455FC55
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_025710_204000_A7EACB83 
X-CRM114-Status: GOOD (  17.49  )
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

On 3/22/24 10:43, Chaitanya Kulkarni wrote:
> On 3/22/2024 12:09 AM, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Unique discovery NQNs allow to differentiate between discovery
>> services from (typically physically separate) NVMe-oF subsystems.
>> This is required for establishing secured connections as otherwise
>> the credentials won't be unique and the integrity of the connection
>> cannot be guaranteed.
>> This patch adda a configfs attribute 'discovery_nqn' in the 'nvmet'
>> configfs directory to specify the unique discovery NQN.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
> 
> umm change log ?
> 
Just a rebase to latest head and modified the commit message slightly.
Not sure if that warranted a change log.

>>    drivers/nvme/target/configfs.c | 46 ++++++++++++++++++++++++++++++++++
>>    drivers/nvme/target/core.c     |  7 ++++++
>>    2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 77a6e817b315..e8ead4ab35aa 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1613,6 +1613,11 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>>    		return ERR_PTR(-EINVAL);
>>    	}
>>    
>> +	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
>> +		pr_err("can't create subsystem using unique discovery NQN\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>    	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
>>    	if (IS_ERR(subsys))
>>    		return ERR_CAST(subsys);
>> @@ -2159,7 +2164,48 @@ static const struct config_item_type nvmet_hosts_type = {
>>    
>>    static struct config_group nvmet_hosts_group;
>>    
>> +static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
>> +					     char *page)
>> +{
>> +	return sprintf(page, "%s\n", nvmet_disc_subsys->subsysnqn);
>> +}
>> +
> 
> snprintf() with PAGE_SIZE ?
> 
Ok.

>> +static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct list_head *entry;
>> +	size_t len;
>> +
>> +	len = strcspn(page, "\n");
>> +	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
>> +		return -EINVAL;
>> +
>> +	down_write(&nvmet_config_sem);
>> +	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
>> +		struct config_item *item =
>> +			container_of(entry, struct config_item, ci_entry);
> 
> newline here ?
> 
Blasted configfs always eats into the line length limitation.
I see what I can do.

Thanks for the review.

Cheers,

Hannes


