Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FFFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVO054SGsvKiD+Q5M+kKfD89wob/gupb8KLJLe3vgdg=; b=IcQtjWINB4y7CjRbcCbW5BUPHn
	lLagZsOvVx9R5/AX1AQRd7JzV/6r//u1E1l85nJhU3cXFXa6JYmD27o10L0KjL9bs908597gc17jm
	dmMTVWhB1KZQAKJ2ArmQQS7xgH2gkk2fLQuEbdlgAWfugD2+FRPk+MmGGCNBY8tPmA+HiO2wE+VQr
	lSPpoUQ6FYi49gJ7Cw9BDe2T5e0NkttIRysTiieglCy27dT3iOaKlHLrstj/uxEr1pYXid8Og9pIM
	rrryIhBoRyLojcIZ+aQ9+Rlm89VNx2xC47FnrC5B2ssUcuGcnxNJlChSYsJutxdm/z/mQurYog0b/
	97G8jTGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVPn-00DETj-PC; Thu, 07 Apr 2022 16:55:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncVPh-00DEQm-Or
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 16:55:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB8EE212CA;
 Thu,  7 Apr 2022 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649350510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVO054SGsvKiD+Q5M+kKfD89wob/gupb8KLJLe3vgdg=;
 b=rXLF75NfZYg0AN8N+xC9kY8yQyNRgCyLXSRqj9wC7weBC1hNOYMl/8t1qXrinyxJgfHmLx
 xFbwH/DkiP8sIcw9H3XW3ntX0aNQP1D7SZH3IGE+MOqhMF6mZ5UpfzQPWmd6A2sRmPQUPa
 ym+5roFALI/DGz8kfatCXEyPHHSVyJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649350510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVO054SGsvKiD+Q5M+kKfD89wob/gupb8KLJLe3vgdg=;
 b=SWtYV5i0Y7ooefZh9ZGIVZsjnDvpwLXU5Ets2kwLrBzu4moKWq2dUuEOYhXOSvykSIGyTT
 urMDmIFvoyZSsWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 936A713485;
 Thu,  7 Apr 2022 16:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I7YrI24XT2JJGgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 16:55:10 +0000
Message-ID: <e2f2a304-0886-606c-a24f-7b7d08663421@suse.de>
Date: Thu, 7 Apr 2022 18:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-2-hare@suse.de> <20220407154417.GC15988@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220407154417.GC15988@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_095518_029855_44C529C1 
X-CRM114-Status: GOOD (  20.02  )
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

On 4/7/22 17:44, Christoph Hellwig wrote:
> On Thu, Apr 07, 2022 at 12:48:06PM +0200, Hannes Reinecke wrote:
>> +static ssize_t nvmet_subsys_attr_type_store(struct config_item *item,
>> +					    const char *page, size_t count)
>> +{
>> +	struct nvmet_subsys *subsys = to_subsys(item);
>> +	struct nvmet_port *p;
>> +	struct nvmet_subsys_link *s;
>> +	int i;
>> +
>> +	if (subsys->subsys_discovered)
>> +		return -EACCES;
>> +
>> +	/*
>> +	 * Do not allow to change the subsystem type if it's
>> +	 * already linked to ports; the user should unlink it first.
>> +	 */
>> +	down_read(&nvmet_config_sem);
>> +	list_for_each_entry(p, &nvmet_ports_list, global_entry) {
>> +		list_for_each_entry(s, &p->subsystems, entry) {
>> +			if (s->subsys == subsys) {
>> +				up_read(&nvmet_config_sem);
>> +				return -EACCES;
>> +			}
>> +		}
>> +	}
>> +	up_read(&nvmet_config_sem);
> 
> Does this scale?  Do we want a flag in the subsystem instead?
> 
Hmm. Seeing that it's a synchronous userspace operation I don't really 
care; worst case the 'ln -s' call takes a bit longer.
But okay, I'll have a look.

>> +	for (i = 0; i < ARRAY_SIZE(nvmet_subsys_type_map); i++) {
>> +		if (sysfs_streq(page, nvmet_subsys_type_map[i].name))
>> +			goto found;
>> +	}
>> +
>> +	pr_err("Invalid value '%s' for subsystem type\n", page);
>> +	return -EINVAL;
>> +
>> +found:
>> +	down_write(&nvmet_config_sem);
>> +	if (nvmet_subsys_type_map[i].type == NVME_NQN_CURR) {
>> +		if (!xa_empty(&subsys->namespaces)) {
>> +			pr_err("discovery subsystem cannot have namespaces\n");
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> We can probably just check this unconditionally, as something that was
> a discovery subsystem before by definition can't have namespaces.

Right.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

