Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD3BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 05:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VM719RO3hYboOfDIWBP77a3nGKT4hGWsdzvlxbLACwk=; b=S6I063GkEmBCCSzo/ri9OJHnw8
	efoRsRMOSxJ+2ES+ur+d6DNLvLbWqtTEfOeGbjl0edZedSWyZeNrBU4W1fQTxOmeZBTv2M3NBhgf1
	VjN+wwkL2xzI39VkzVFBVgWrebyJrVPh5T5EPgjlTxrOXcj2bMJb8zOGPbMDSiqyvowmrIDgRyjK5
	uJQmVzK8g87t0oxiLJo/bWqC4edGkaRAadXEWHwR/HVfdn0ZqEH2DMGQaWQqAxvu2fW4U5HGFigLA
	sMmgys1kVDhAKf9PJoV1Ma7qhoQdcj/l0sSf5Tukg0c28bIb0hj8YEgRbqwo7qpoiSZu+NlcLUjzz
	vgMpzKzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nof62-005IrN-6z; Wed, 11 May 2022 05:41:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nof5x-005IpX-AC
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 05:41:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E755E1F8F7;
 Wed, 11 May 2022 05:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652247667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VM719RO3hYboOfDIWBP77a3nGKT4hGWsdzvlxbLACwk=;
 b=FeXpjn7KRA3jleGLx2c1Jff+e0ATMkydUprbKUmLr2nIBdLNO5GGZMsu/j7heBHfLSHxO6
 wWApWI927J3IdpTw/NgIb13QAq9AoEMuhxsF0sFtqyvBRIiDr9Db3S/O09jNKoNCubXOTU
 EWUb8ZdGMgbl3OdjcWmIgoel5qyEOAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652247667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VM719RO3hYboOfDIWBP77a3nGKT4hGWsdzvlxbLACwk=;
 b=pX9apxcCX9NdV9EC9pEUACAAgggmsJCbc1tar58GMZGuaSjK42vxWezwYdvBihLQ6kMQsh
 mqz4y7NdR+eBPHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7CCB13AA5;
 Wed, 11 May 2022 05:41:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Do3UL3NMe2JjJwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 11 May 2022 05:41:07 +0000
Message-ID: <816168a1-827a-18cd-af76-a9162a6bd016@suse.de>
Date: Wed, 11 May 2022 07:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-4-hare@suse.de>
 <21c3b2b9-3d66-66cc-2216-d027f4b0885f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <21c3b2b9-3d66-66cc-2216-d027f4b0885f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_224109_537883_A99D92D0 
X-CRM114-Status: GOOD (  22.92  )
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

On 5/10/22 11:43, Sagi Grimberg wrote:
> 
> 
> On 4/20/22 12:27, Hannes Reinecke wrote:
>> When a per-port discovery subsystem is used we should include
>> all configured ports in the discovery log page, not just that one
>> through which the controller was connected.
>>
>> - /
>>    o- ports
>>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>>    | | o- subsystems
>>    | |   o- nqn.discovery
>>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>>    | | o- subsystems
>>    | |   o- nqn.discovery
>>    | |   o- nqn.io-1
>>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>>    |   o- subsystems
>>    |     o- nqn.io-2
>>    o- subsystems
>>      o- nqn.discovery
>>      o- nqn.io-1
>>      | o- namespaces
>>      o- nqn.io-2
>>        o- namespaces
>>
>> A discovery on port 8009 will return information about
>> - nqn.discovery at port 8009
>> - nqn.discovery at port 4420
>> - nqn.io-1 at port 4420
>> A discovery on port 4420 will return the same information.
>> A discovery on port 4421 will return information about
>> - standard discovery subsystem on port 4421
>> - nqn.io-2 on port 4421
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/discovery.c | 53 +++++++++++++++++++++++++++------
>>   1 file changed, 44 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/target/discovery.c 
>> b/drivers/nvme/target/discovery.c
>> index 6b8aa6c4e752..ea8fce538342 100644
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -149,6 +149,30 @@ static void nvmet_set_disc_traddr(struct 
>> nvmet_req *req, struct nvmet_port *port
>>           memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
>>   }
>> +/*
>> + * discovery_port_match - filter eligible ports for discovery log page
>> + *
>> + * If the port through which the controller is connected has no 
>> discovery
>> + * subsystem linked, use the original behaviour of just including 
>> information
>> + * about that port in the discovery log page.
>> + * Otherwise include information about all ports into which the 
>> specified
>> + * discovery subsystem is linked.
>> + */
>> +
>> +static bool discovery_port_match(struct nvmet_req *req, struct 
>> nvmet_port *r)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +
>> +    if (!req->port->disc_subsys) {
>> +        if (r != req->port)
>> +            return false;
>> +    } else {
>> +        if (ctrl->subsys != r->disc_subsys)
>> +            return false;
> 
> What is this condition for? What is this filtering out?

This filters out all ports into which the discovery subsystem
is _not_ linked (ie the statement 'Otherwise ...' in the function
description).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

