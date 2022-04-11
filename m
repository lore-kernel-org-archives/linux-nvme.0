Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD0C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dmCKkqqYZQOHvGRKWOv5gYdENl77zyewC3chxXfn1E=; b=gzsfIuDaPmRalAqzfFzcOUiCTH
	PjiB/lYlZtqVpFopobB6eLopDgPkM7F7Nf10HMbyOUM53pNGcFC/3ihLtf3PLgYuhmGOdfXNB0o/u
	DTYZs3uYPCIrYS0G5TtmYjTfstdUdHVP0dnWgbo1QCFowzZWcQBG9pl7KzTMxNEudxDhJaka8CuBc
	zjdR6iK/pK4tkaZ1SWF8vhYCzhHaCmKmvozvoU6+xfuCbOyJMaZ8eO+x3aulbnaFe3OJfKOttaN2n
	LEs+iqnbtWL1zABu4AVzMoiB0NH96ZrGDfsjDj1OjNRW4mamn5vIF4eKYjEW5ao+pw5O/DBOp1PEr
	BHfDzt1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndspM-008sE8-DX; Mon, 11 Apr 2022 12:07:28 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndspF-008s8u-0a
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 12:07:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B794521604;
 Mon, 11 Apr 2022 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649678837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dmCKkqqYZQOHvGRKWOv5gYdENl77zyewC3chxXfn1E=;
 b=O5oGFJJZoj+UMXpY2vc9VEAD2M3GR/OBwgfYxNDuzvtW0+X6Igoq5utkcYVJXUNf+Ue2tP
 y9tzdHXGshKGNKr8k034g7C+DGtsFDMSsn2TkUa8TjRnDw9mQDqCD0Ke9v7D3QS1eapsYF
 L5y9Bg4dXXAqKchrN65YW2ZeG82q1IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649678837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dmCKkqqYZQOHvGRKWOv5gYdENl77zyewC3chxXfn1E=;
 b=rEo/yp2Rd6UDkLM9xdPMYLwWS21aOOu2F48aTmhY3DMUHCSYBn1f/xyGCcx7uhiXX+Ik5h
 ggJ7uSUoDIc5IqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8BA713A93;
 Mon, 11 Apr 2022 12:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VPbVKPUZVGIuCwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 11 Apr 2022 12:07:17 +0000
Message-ID: <43e81dcb-78c4-861a-4b13-39722b760ae6@suse.de>
Date: Mon, 11 Apr 2022 14:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-3-hare@suse.de>
 <4a9ccecc-a382-e467-30d9-c06adf0e5329@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
In-Reply-To: <4a9ccecc-a382-e467-30d9-c06adf0e5329@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_050721_266433_1AE42EBF 
X-CRM114-Status: GOOD (  35.10  )
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

On 4/11/22 12:45, Sagi Grimberg wrote:
> 
>> Add a 'disc_subsys' pointer to each port to specify which discovery
>> subsystem to use.
>> The pointer is set when a discovery subsystem is linked into a port,
>> and reset if that link is removed.
> 
> Why not make discovery_subsystems/ subdir in a port? We can restrict
> it to have only one element if needed.
> 

Because that would make the discovery subsystems 'special'.
My idea was to treat discovery subsystems just like 'normal' subsystems,
ie being part of the subsystem list per port, and able to be created 
like other subsystems.

And using a 'discovery_subsys' subdir does raise issues with handling 
the default discovery subsystem.
If it's not listed one would assume that this port doesn't have a 
discovery subsystem.
If it's listed we cannot make it a default entry, as then we can't 
remove it.
And I've yet to find a way how to create dynamic entries from kernel 
space. If you have a way, please tell.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c  | 10 +++++++++
>>   drivers/nvme/target/core.c      | 15 ++++++++++---
>>   drivers/nvme/target/discovery.c | 39 ++++++++++++++++++++++-----------
>>   drivers/nvme/target/nvmet.h     |  1 +
>>   4 files changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 38b0ab9fb721..44573fe0dfe4 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct 
>> config_item *parent,
>>       link->subsys = subsys;
>>       down_write(&nvmet_config_sem);
>> +    if (subsys->type == NVME_NQN_CURR &&
>> +        port->disc_subsys) {
> 
> The CURR is really confusing to me...
> Can you explain the NQN types mapping here?
> 

TPAR 8014 changed the meaning of the original 'discovery subsystem' type 
to 'discovery subsystem referral' (as this was the actual meaning of the 
original spec), and added a new entry 'current discovery subsystem' to 
return information about the current subsystem (ie that one where the 
controller is attached to).

>> +        pr_err("discovery subsystem already present\n");
>> +        ret = -EAGAIN;
>> +        goto out_free_link;
>> +    }
>>       ret = -EEXIST;
>>       list_for_each_entry(p, &port->subsystems, entry) {
>>           if (p->subsys == subsys)
>> @@ -835,6 +841,8 @@ static int nvmet_port_subsys_allow_link(struct 
>> config_item *parent,
>>       list_add_tail(&link->entry, &port->subsystems);
>>       subsys->port_count++;
>> +    if (subsys->type == NVME_NQN_CURR)
>> +        port->disc_subsys = subsys;
>>       nvmet_port_disc_changed(port, subsys);
>>       up_write(&nvmet_config_sem);
>> @@ -866,6 +874,8 @@ static void nvmet_port_subsys_drop_link(struct 
>> config_item *parent,
>>       subsys->port_count--;
>>       nvmet_port_del_ctrls(port, subsys);
>>       nvmet_port_disc_changed(port, subsys);
>> +    if (port->disc_subsys == subsys)
>> +        port->disc_subsys = NULL;
>>       if (list_empty(&port->subsystems))
>>           nvmet_disable_port(port);
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 90e75324dae0..afd80999a335 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -1495,10 +1495,19 @@ static struct nvmet_subsys 
>> *nvmet_find_get_subsys(struct nvmet_port *port,
>>       if (!port)
>>           return NULL;
>> +    /*
>> +     * As per spec discovery subsystems with a unique NQN
>> +     * have to respond to both NQNs, the unique NQN and the
>> +     * standard discovery NQN.
>> +     */
>>       if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
>> -        if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
>> -            return NULL;
>> -        return nvmet_disc_subsys;
>> +        struct nvmet_subsys *disc_subsys;
>> +
>> +        disc_subsys = port->disc_subsys ?
>> +            port->disc_subsys : nvmet_disc_subsys;
>> +        if (!kref_get_unless_zero(&disc_subsys->ref))
>> +                return NULL;
>> +        return disc_subsys;
>>       }
> 
> Why use the port discovery subsys? why not just use the standard
> discovery subsys?
> 

Because (due to TPAR8014) we have to return information about the 
current discovery subsystem, including all port details.

>>       down_read(&nvmet_config_sem);
>> diff --git a/drivers/nvme/target/discovery.c 
>> b/drivers/nvme/target/discovery.c
>> index b5012df790d5..6b8aa6c4e752 100644
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -29,18 +29,22 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>>                    struct nvmet_subsys *subsys)
>>   {
>>       struct nvmet_ctrl *ctrl;
>> +    struct nvmet_subsys *disc_subsys;
>>       lockdep_assert_held(&nvmet_config_sem);
>>       nvmet_genctr++;
>> -    mutex_lock(&nvmet_disc_subsys->lock);
>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
>> +    disc_subsys = port->disc_subsys ?
>> +        port->disc_subsys : nvmet_disc_subsys;
>> +
>> +    mutex_lock(&disc_subsys->lock);
>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>           if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
>>               continue;
>>           __nvmet_disc_changed(port, ctrl);
>>       }
>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>> +    mutex_unlock(&disc_subsys->lock);
>>       /* If transport can signal change, notify transport */
>>       if (port->tr_ops && port->tr_ops->discovery_chg)
>> @@ -48,19 +52,23 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>>   }
>>   static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
>> -                    struct nvmet_subsys *subsys,
>>                       struct nvmet_host *host)
>>   {
>>       struct nvmet_ctrl *ctrl;
>> +    struct nvmet_subsys *disc_subsys;
>> +
>> +    disc_subsys = port->disc_subsys ?
>> +        port->disc_subsys : nvmet_disc_subsys;
>> -    mutex_lock(&nvmet_disc_subsys->lock);
>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
>> +    mutex_lock(&disc_subsys->lock);
>> +
>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>           if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
>>               continue;
>>           __nvmet_disc_changed(port, ctrl);
>>       }
>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>> +    mutex_unlock(&disc_subsys->lock);
> 
> Why remove the subsys argument from this function?
> 

Because it's not needed?
But I can make it a separate patch if you prefer.

>>   }
>>   void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>> @@ -76,7 +84,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
>> *subsys,
>>           list_for_each_entry(s, &port->subsystems, entry) {
>>               if (s->subsys != subsys)
>>                   continue;
>> -            __nvmet_subsys_disc_changed(port, subsys, host);
>> +            __nvmet_subsys_disc_changed(port, host);
>>           }
>>   }
>> @@ -146,7 +154,10 @@ static size_t discovery_log_entries(struct 
>> nvmet_req *req)
>>       struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>       struct nvmet_subsys_link *p;
>>       struct nvmet_port *r;
>> -    size_t entries = 1;
>> +    size_t entries = 0;
>> +
>> +    if (!req->port->disc_subsys)
>> +        entries++;
>>       list_for_each_entry(p, &req->port->subsystems, entry) {
>>           if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
>> @@ -208,10 +219,12 @@ static void 
>> nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>>       nvmet_set_disc_traddr(req, req->port, traddr);
>> -    nvmet_format_discovery_entry(hdr, req->port,
>> -                     nvmet_disc_subsys->subsysnqn,
>> -                     traddr, NVME_NQN_CURR, numrec);
>> -    numrec++;
>> +    if (!req->port->disc_subsys) {
>> +        nvmet_format_discovery_entry(hdr, req->port,
>> +                nvmet_disc_subsys->subsysnqn,
>> +                traddr, NVME_NQN_CURR, numrec);
>> +        numrec++;
>> +    }
> 
> For the unique discovery you don't need this?
> 
No.
As mentioned above, unique discovery subsystems are handled identically 
to 'normal' subsystems, which in this case means that they will be part 
of the list of subsystems linked to a port.
So we'll get information about the discovery subsystem with the loop a 
few lines below that code.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

