Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480A5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfGcheVQJq034QK4Mu6PwRESb2+MteuI/vqDl+m45k8=; b=0ERQgrcqMVfN2WXMP1KBusZkVO
	ecvNO+efIhYWB6jgv1JA1LUdC8Q3UtI1xWzjHmZrBJS3YQ8n4edH+uVj/nBv4qePoJVQMAdXqwJV4
	If1ulznLQNlRg4lXi1l7eeJFPjxHvjNEpyAoNJ0C5SnVbkACWWzGgfwsi1v+ukcWg2saePpuNmrwW
	RYIm6pHFE3onfHfP1h7jtAuL4pMBpWMDRhVjb0eBHE/1mM26cWO8WGw/+wgtRiShhJciAwwX7obSD
	kyn0xlRR64E7LvoHSU1g+Mw9KmTZE+6FtgyAQUK7/H4O1FZpK9uCJb6+Qq8ti4Y0yPGdxPdErbboi
	VHsQetYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neFkQ-00EBfH-6l; Tue, 12 Apr 2022 12:35:54 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neFWA-00E4e7-Lk
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 12:21:12 +0000
Received: by mail-wr1-f45.google.com with SMTP id i20so14344348wrb.13
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 05:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HfGcheVQJq034QK4Mu6PwRESb2+MteuI/vqDl+m45k8=;
 b=i21RZyziejA2N8D6qvwfb4AbqeJc2QfxqwwzEo6u1ep83mCuJ9DyWLKVqdGaASdlB1
 3e8WM7UwLrH2903TiV0Ams7VEpVpI8xCPmUBhmx8t1zSenlDJm/Ckvl/MuMosp3xPJaR
 +eVuepNfsYJXwqyzZ2PuAdQHJaPQ3uTdug1XZKzvQ9F1+REdeHONpZFmpM5O0VbC3Sq+
 IAt4ZsE1bJsvZ7xzLU0OvauRxnHNTi76eKO/2AYNrCKiAPVJiUg8RMu6LlVE3Ugx/WbM
 Me7sezpjNIzx2kmgLnQObAhKqmkuRWo9HHLDnTqev9yYzQzSHkj7fvsarqI/wR7cZyzK
 GqZg==
X-Gm-Message-State: AOAM533jWzDx8B5EEcDBMcF6rtkceaAsM3q22xhL5tDOvyXBoAQU7T7C
 b+XEY3jp2o9fVQ/AWexQJaQ=
X-Google-Smtp-Source: ABdhPJyE0TSZOwpCGu0XUYuve/vhcORCePP3V5RpAcaxv0B4Wf/IjIjmxPL0FwJnoUG+IygkIz3y2w==
X-Received: by 2002:a5d:6da5:0:b0:207:9112:3fce with SMTP id
 u5-20020a5d6da5000000b0020791123fcemr17248233wrs.210.1649766067259; 
 Tue, 12 Apr 2022 05:21:07 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c4ed000b0038ceb0b21b4sm2786848wmq.24.2022.04.12.05.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 05:21:06 -0700 (PDT)
Message-ID: <7c29b202-6d93-77c1-8fdc-be006a09a9fe@grimberg.me>
Date: Tue, 12 Apr 2022 15:21:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-3-hare@suse.de>
 <4a9ccecc-a382-e467-30d9-c06adf0e5329@grimberg.me>
 <43e81dcb-78c4-861a-4b13-39722b760ae6@suse.de>
 <706ca158-b05d-e825-b5cf-51b7572f52a6@grimberg.me>
 <72da49de-1262-dd47-18df-173df5a3e923@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <72da49de-1262-dd47-18df-173df5a3e923@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_052110_789179_D822C0F9 
X-CRM114-Status: GOOD (  38.43  )
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


>>>>> Add a 'disc_subsys' pointer to each port to specify which discovery
>>>>> subsystem to use.
>>>>> The pointer is set when a discovery subsystem is linked into a port,
>>>>> and reset if that link is removed.
>>>>
>>>> Why not make discovery_subsystems/ subdir in a port? We can restrict
>>>> it to have only one element if needed.
>>>>
>>>
>>> Because that would make the discovery subsystems 'special'.
>>> My idea was to treat discovery subsystems just like 'normal' subsystems,
>>> ie being part of the subsystem list per port, and able to be created 
>>> like other subsystems.
>>
>> They are obviously special.
>>
> Yes and no. Both are 'subsystems'. And I wanted to avoid having to 
> special-case things (like we do for referrals), as this would require 
> changes to nvmetcli.
> So aim was to make the necessary user interface changes as small as 
> possible.
> 
>>> And using a 'discovery_subsys' subdir does raise issues with handling 
>>> the default discovery subsystem.
>>> If it's not listed one would assume that this port doesn't have a 
>>> discovery subsystem.
>>> If it's listed we cannot make it a default entry, as then we can't 
>>> remove it.
>>
>> I think that the current interface is confusing as well.
>>
> Yes. And that's why I wanted to have the discovery subsystem showing up 
> in configfs.
> 
>>> And I've yet to find a way how to create dynamic entries from kernel 
>>> space. If you have a way, please tell.
>>>
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/target/configfs.c  | 10 +++++++++
>>>>>   drivers/nvme/target/core.c      | 15 ++++++++++---
>>>>>   drivers/nvme/target/discovery.c | 39 
>>>>> ++++++++++++++++++++++-----------
>>>>>   drivers/nvme/target/nvmet.h     |  1 +
>>>>>   4 files changed, 49 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/target/configfs.c 
>>>>> b/drivers/nvme/target/configfs.c
>>>>> index 38b0ab9fb721..44573fe0dfe4 100644
>>>>> --- a/drivers/nvme/target/configfs.c
>>>>> +++ b/drivers/nvme/target/configfs.c
>>>>> @@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct 
>>>>> config_item *parent,
>>>>>       link->subsys = subsys;
>>>>>       down_write(&nvmet_config_sem);
>>>>> +    if (subsys->type == NVME_NQN_CURR &&
>>>>> +        port->disc_subsys) {
>>>>
>>>> The CURR is really confusing to me...
>>>> Can you explain the NQN types mapping here?
>>>>
>>>
>>> TPAR 8014 changed the meaning of the original 'discovery subsystem' 
>>> type to 'discovery subsystem referral' (as this was the actual 
>>> meaning of the original spec), and added a new entry 'current 
>>> discovery subsystem' to return information about the current 
>>> subsystem (ie that one where the controller is attached to).
>>
>> Eh, at least the usage of CURR in the code is weird. I understand what
>> it means in the log page, but the usage here is strange. I suggest to
>> use a different enumeration naming in the code and leave CURR to the
>> log page, where it makes sense.
>>
> Okay, will be doing so.
> 
>>>
>>>>> +        pr_err("discovery subsystem already present\n");
>>>>> +        ret = -EAGAIN;
>>>>> +        goto out_free_link;
>>>>> +    }
>>>>>       ret = -EEXIST;
>>>>>       list_for_each_entry(p, &port->subsystems, entry) {
>>>>>           if (p->subsys == subsys)
>>>>> @@ -835,6 +841,8 @@ static int nvmet_port_subsys_allow_link(struct 
>>>>> config_item *parent,
>>>>>       list_add_tail(&link->entry, &port->subsystems);
>>>>>       subsys->port_count++;
>>>>> +    if (subsys->type == NVME_NQN_CURR)
>>>>> +        port->disc_subsys = subsys;
>>>>>       nvmet_port_disc_changed(port, subsys);
>>>>>       up_write(&nvmet_config_sem);
>>>>> @@ -866,6 +874,8 @@ static void nvmet_port_subsys_drop_link(struct 
>>>>> config_item *parent,
>>>>>       subsys->port_count--;
>>>>>       nvmet_port_del_ctrls(port, subsys);
>>>>>       nvmet_port_disc_changed(port, subsys);
>>>>> +    if (port->disc_subsys == subsys)
>>>>> +        port->disc_subsys = NULL;
>>>>>       if (list_empty(&port->subsystems))
>>>>>           nvmet_disable_port(port);
>>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>>>> index 90e75324dae0..afd80999a335 100644
>>>>> --- a/drivers/nvme/target/core.c
>>>>> +++ b/drivers/nvme/target/core.c
>>>>> @@ -1495,10 +1495,19 @@ static struct nvmet_subsys 
>>>>> *nvmet_find_get_subsys(struct nvmet_port *port,
>>>>>       if (!port)
>>>>>           return NULL;
>>>>> +    /*
>>>>> +     * As per spec discovery subsystems with a unique NQN
>>>>> +     * have to respond to both NQNs, the unique NQN and the
>>>>> +     * standard discovery NQN.
>>>>> +     */
>>>>>       if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
>>>>> -        if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
>>>>> -            return NULL;
>>>>> -        return nvmet_disc_subsys;
>>>>> +        struct nvmet_subsys *disc_subsys;
>>>>> +
>>>>> +        disc_subsys = port->disc_subsys ?
>>>>> +            port->disc_subsys : nvmet_disc_subsys;
>>>>> +        if (!kref_get_unless_zero(&disc_subsys->ref))
>>>>> +                return NULL;
>>>>> +        return disc_subsys;
>>>>>       }
>>>>
>>>> Why use the port discovery subsys? why not just use the standard
>>>> discovery subsys?
>>>>
>>>
>>> Because (due to TPAR8014) we have to return information about the 
>>> current discovery subsystem, including all port details.
>>
>> So you got a discovery log page request on the default discovery
>> subsys and you are filling the log page with content of the unique
>> discovery subsys? The current discovery subsystem is the default
>> discovery subsystem in this case, no?
>>
>> Maybe I'm missing something...
>>
> That's what TP8013 is all about.
> The unique discovery subsystem has to react to both subsystem NQNs, the 
> unique NQN _and_ the default discovery subsystem NQN.
> But there will be only _one_ discovery subsystem per port.

Not sure why the spec mandates that, but OK.
In essence the unique discovery subsystem "takes over" the port
and fills up whatever it has, regardless of the disc-subsys NQN
the host is accessing nor accessed in the past...

>>>>>       down_read(&nvmet_config_sem);
>>>>> diff --git a/drivers/nvme/target/discovery.c 
>>>>> b/drivers/nvme/target/discovery.c
>>>>> index b5012df790d5..6b8aa6c4e752 100644
>>>>> --- a/drivers/nvme/target/discovery.c
>>>>> +++ b/drivers/nvme/target/discovery.c
>>>>> @@ -29,18 +29,22 @@ void nvmet_port_disc_changed(struct nvmet_port 
>>>>> *port,
>>>>>                    struct nvmet_subsys *subsys)
>>>>>   {
>>>>>       struct nvmet_ctrl *ctrl;
>>>>> +    struct nvmet_subsys *disc_subsys;
>>>>>       lockdep_assert_held(&nvmet_config_sem);
>>>>>       nvmet_genctr++;
>>>>> -    mutex_lock(&nvmet_disc_subsys->lock);
>>>>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, 
>>>>> subsys_entry) {
>>>>> +    disc_subsys = port->disc_subsys ?
>>>>> +        port->disc_subsys : nvmet_disc_subsys;
>>>>> +
>>>>> +    mutex_lock(&disc_subsys->lock);
>>>>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>>>>           if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
>>>>>               continue;
>>>>>           __nvmet_disc_changed(port, ctrl);
>>>>>       }
>>>>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>>>>> +    mutex_unlock(&disc_subsys->lock);
>>>>>       /* If transport can signal change, notify transport */
>>>>>       if (port->tr_ops && port->tr_ops->discovery_chg)
>>>>> @@ -48,19 +52,23 @@ void nvmet_port_disc_changed(struct nvmet_port 
>>>>> *port,
>>>>>   }
>>>>>   static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
>>>>> -                    struct nvmet_subsys *subsys,
>>>>>                       struct nvmet_host *host)
>>>>>   {
>>>>>       struct nvmet_ctrl *ctrl;
>>>>> +    struct nvmet_subsys *disc_subsys;
>>>>> +
>>>>> +    disc_subsys = port->disc_subsys ?
>>>>> +        port->disc_subsys : nvmet_disc_subsys;
>>>>> -    mutex_lock(&nvmet_disc_subsys->lock);
>>>>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, 
>>>>> subsys_entry) {
>>>>> +    mutex_lock(&disc_subsys->lock);
>>>>> +
>>>>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>>>>           if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
>>>>>               continue;
>>>>>           __nvmet_disc_changed(port, ctrl);
>>>>>       }
>>>>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>>>>> +    mutex_unlock(&disc_subsys->lock);
>>>>
>>>> Why remove the subsys argument from this function?
>>>>
>>>
>>> Because it's not needed?
>>> But I can make it a separate patch if you prefer.
>>
>> But different hosts can be connected to different discovery subsystems.
>>
> 
> Sure. But the 'subsys' argument is unused even in the current code.
> 
>> Is the implementation intent is that you always use the unique
>> discovery subsystem also when hosts refer to the default discovery
>> subsystem?
>>
> Yes. That is what TPAR8013 mandates.

I wasn't aware of that. This makes a stronger case to why the unique
disc subsys should behave similar to the standard one.

