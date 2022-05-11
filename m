Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE1DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 05:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdHoIju6h2LRFQumf4X4b8m7n43ExMKWc5CtNB0xLdE=; b=uiIjcfRGLmmGtjl3OjJjhjS0F3
	TeA0215Q2iolkzahlIUyJfKUVnkC9oiPaXGatD3MugIi7ih7BxSiGb0wOH4/GFI3huHrrdFhLH+ep
	tiIQeO8TXJzH+/pQmlLcCr7V3VRrZUsLDf/hQ+Qqf423t7sILSuANaXDaMV40elCsowdBZBagZEAO
	kYqvk0VS/6QIyaY3rFhRXRcHgyCi2Tm0tSWJmUX5zcx+29fu9jCA7otJJquTyoej8ELBcx9rWIM2g
	1cGWFmvdfiw30lG+kUE/Og57JPuiTe8II5g4fh/5RueD5fuv365I4lHEicibaagaOUy4lgxaHFXCI
	aCN7iUTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nof3F-005IY6-93; Wed, 11 May 2022 05:38:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nof3B-005IXX-5a
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 05:38:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6361F8E6;
 Wed, 11 May 2022 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652247492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdHoIju6h2LRFQumf4X4b8m7n43ExMKWc5CtNB0xLdE=;
 b=uKmE0GUjo00wD1W91jPLPivbN2KykOmaTZdJ3R4N3/1178lqVVxtiloefLY7dTUUKHm3hT
 gqKd9SEksudLO03T8WKVCkxfuQe5cUDCTBcIJ1xhGEMoQhQ14uWxd6cxJSeP+CjzwDLU6T
 YF7VRlm6NBK4bC01+V56Y/zTz7pu4nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652247492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdHoIju6h2LRFQumf4X4b8m7n43ExMKWc5CtNB0xLdE=;
 b=K6n1o1kpdQSNG3L5v1aI37bt1W6l+eDNUxk/i2wMwhbRPVxIJwKg61sw7M100UwQGRanyC
 MFHuSHZqk0dEZEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2307E13AA5;
 Wed, 11 May 2022 05:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nhi1B8RLe2J2JgAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 11 May 2022 05:38:12 +0000
Message-ID: <090db7fe-79d5-a763-3876-5c88c6b50fa3@suse.de>
Date: Wed, 11 May 2022 07:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-2-hare@suse.de>
 <63c7d338-8b03-a753-2dbd-31394335c798@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <63c7d338-8b03-a753-2dbd-31394335c798@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_223817_405005_C54AE9D3 
X-CRM114-Status: GOOD (  18.39  )
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

On 5/10/22 11:36, Sagi Grimberg wrote:
> 
> 
> On 4/20/22 12:27, Hannes Reinecke wrote:
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
>>       nvmet_port_del_ctrls(port, subsys);
>>       nvmet_port_disc_changed(port, subsys);
>> @@ -1234,6 +1236,63 @@ static ssize_t 
>> nvmet_subsys_attr_model_store(struct config_item *item,
>>   }
>>   CONFIGFS_ATTR(nvmet_subsys_, attr_model);
>> +static const struct nvmet_type_name_map nvmet_subsys_type_map[] = {
>> +    { NVME_NQN_DISC,    "referral" },
>> +    { NVME_NQN_NVME,    "nvme" },
>> +    { NVME_NQN_CURR,    "discovery" },
> 
> Didn't we agree that the internal enumeration would be different
> than the content of the log page? It is just confusing reading it this
> way...

And so we did. Will be changing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

