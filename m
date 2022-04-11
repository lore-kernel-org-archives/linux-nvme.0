Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DDBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blOg3LuuolMmoL6LKX6eCoB7tIQxsijI0WWKJo095eE=; b=QW7nOq58no8ZASydZsmlqVyijk
	ALwspuH8F9adaKMIhSp0Gl7EWJr2K5DlM4mnCZkh4eTx2hZlOX/FDDVEYKF7ysfpYLvSq3EEl9NXH
	hYAaMJV+enZtncYiWXzaDi4a6N2AzeIWd28GkYmlDbToqKCBhoQDZJ/jwi8JUW/fdaTxcNn64e+ae
	an0vKrHy5k7se1Lt6EKiXyTjAdIrpgusHjVrGhHPNHzx/jMbdXrLjXK/vpm73QKhXI0azPABLGJ8D
	ehiA7gA+OHyCQAwlBycfPv035Wh2GW1IEaUopvCtPpf7n0OhcQsDLIizFyDxhTyX+QetVjzTICsHV
	bHYuUYZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndree-008VpA-CM; Mon, 11 Apr 2022 10:52:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndreY-008VlR-UN
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:52:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA8A2215FC;
 Mon, 11 Apr 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649674329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blOg3LuuolMmoL6LKX6eCoB7tIQxsijI0WWKJo095eE=;
 b=udJMzZx9ZJW6znEWVxttPHS6chFfq66OH6C03G9X1fkWXQFRBUA6ypuWZe8uo+G4dXY3g3
 Kw9+xR6kE+3ccDzgGSQ/SxuH9zDDkKO3Hmhhyl1Hwc1RquAT9eaJgfwto9ZxSdNRSXER23
 NYPVSazt7opNn4Xj3kHlKk5txEIStEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649674329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blOg3LuuolMmoL6LKX6eCoB7tIQxsijI0WWKJo095eE=;
 b=g26wDBybmdU6pn2DOCTdgwYDKFb593tbHVJC8Mp/IoAm0288tZ7UcubgdFUq5eTJ1VjMtU
 +3id073x2lnYVmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AEC913AB5;
 Mon, 11 Apr 2022 10:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rlkfIVkIVGICagAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 11 Apr 2022 10:52:09 +0000
Message-ID: <10de435d-e672-d3e5-1374-b2c8c520a058@suse.de>
Date: Mon, 11 Apr 2022 12:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-2-hare@suse.de>
 <ba21622a-9a81-867b-91e0-3a8d4bf13e70@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ba21622a-9a81-867b-91e0-3a8d4bf13e70@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_035215_195575_DC2F50D4 
X-CRM114-Status: GOOD (  16.37  )
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

On 4/11/22 12:32, Sagi Grimberg wrote:
> 
> 
> On 4/8/22 09:59, Hannes Reinecke wrote:
>> Make the subsystem type configurable to allow for unique
>> discovery subsystems by changing the subsystem type to
>> 'discovery'.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c  | 60 +++++++++++++++++++++++++++++++++
>>   drivers/nvme/target/discovery.c |  2 +-
>>   drivers/nvme/target/nvmet.h     |  1 +
>>   3 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index e44b2988759e..38b0ab9fb721 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -834,6 +834,7 @@ static int nvmet_port_subsys_allow_link(struct 
>> config_item *parent,
>>       }
>>       list_add_tail(&link->entry, &port->subsystems);
>> +    subsys->port_count++;
>>       nvmet_port_disc_changed(port, subsys);
>>       up_write(&nvmet_config_sem);
>> @@ -862,6 +863,7 @@ static void nvmet_port_subsys_drop_link(struct 
>> config_item *parent,
>>   found:
>>       list_del(&p->entry);
>> +    subsys->port_count--;
> 
> minor nit, the decrement should go before the list deletion (although
> it's safe this way as well).
> 
Well, it's changed while nvmet_config_sem is held.
But anyway, will be adjusting it for the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

