Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F9EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVfurw2AtXiXpwmS57o9bO4QnC6z3cupWBQs7p5S5PI=; b=b4hnNPwtF31CeXV3tOz1FXr09u
	peDNMMByg7otDs0PnYSMqqSp1WZtUXkF/C52jcs+4Jv16UdlJCo1Ded1BDIvDDWXChXJFhBmUmhVj
	fnjlIgnYVC5kYTUVXPnC/GP7A2QiQVjy+RALh9HiEScJXp+9HhocNL93EezrekjfCD2g5rsVgHGk4
	/hlKpzx4AR2jAB81ryQ6Elc+M5FTEtB13NdkkkxqX3FY75/KoRfhADPrZ9P5uYKG6IpveN9PcSf6y
	YkEbFOKMofUuE8k/8FsgvMgUmIe49x/jQKvUxyj9CKRe0AuYtfOGPevX++I2Mps+eE8CSgeJmFTeb
	p/Ou6yKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neE1j-00DP9I-7b; Tue, 12 Apr 2022 10:45:39 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neDx5-00DMfU-1F
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:40:53 +0000
Received: by mail-wr1-f49.google.com with SMTP id m14so2685391wrb.6
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 03:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eVfurw2AtXiXpwmS57o9bO4QnC6z3cupWBQs7p5S5PI=;
 b=EUyeJj/prKXUwdxRznTpWjJhqiZTDn10m5p0gjPDXkd5nFSclEA0n0/s1YY9SuT62z
 voz5o3cv0I5M6c3xVKyAbILmVbrf2/EoP6cTccWwU+M8L3mG5DV+fnZMrZDW2ucsLeRX
 yF+Ouw8SFaQdp3m/SfLwp/o+mh7ZXEJsefeAgppAj+KUV1lY7+CP2XnSKS5riY/WSJ4X
 WxsJm6ooPSBhT6owkbcQkjybjXhQ6jWMVdWnKtZXAYI0+6rNAoCXc3Tq+cFhPLPVN4CK
 UTjvdak2MwXjoc1gKy++pXcNYdhGswgpDGgTDuZkj93TM0YHM2AayDgzFYtUzRmMLlwj
 JABg==
X-Gm-Message-State: AOAM531gD9j/JNruu8FCXxZF5/qwcaiYwV7EfrNtrDumsFPgVEm4lfm2
 cINp8T/rCMbZHp769Y71Bfw4Ez/LFmc=
X-Google-Smtp-Source: ABdhPJy/aBTRoCGbg7SnC1GPbB+D/9xAvisyMO/F7u4LKSmuqQq5cwvxJpWAOyl0RoDDJkDWoVqYBg==
X-Received: by 2002:a05:6000:10cd:b0:207:9ac2:d020 with SMTP id
 b13-20020a05600010cd00b002079ac2d020mr14295774wrx.288.1649760048238; 
 Tue, 12 Apr 2022 03:40:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f186-20020a1c38c3000000b0038ea84ab7desm2094945wma.45.2022.04.12.03.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:40:47 -0700 (PDT)
Message-ID: <706ca158-b05d-e825-b5cf-51b7572f52a6@grimberg.me>
Date: Tue, 12 Apr 2022 13:40:46 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <43e81dcb-78c4-861a-4b13-39722b760ae6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_034051_136160_405201B7 
X-CRM114-Status: GOOD (  42.93  )
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



On 4/11/22 15:07, Hannes Reinecke wrote:
> On 4/11/22 12:45, Sagi Grimberg wrote:
>>
>>> Add a 'disc_subsys' pointer to each port to specify which discovery
>>> subsystem to use.
>>> The pointer is set when a discovery subsystem is linked into a port,
>>> and reset if that link is removed.
>>
>> Why not make discovery_subsystems/ subdir in a port? We can restrict
>> it to have only one element if needed.
>>
> 
> Because that would make the discovery subsystems 'special'.
> My idea was to treat discovery subsystems just like 'normal' subsystems,
> ie being part of the subsystem list per port, and able to be created 
> like other subsystems.

They are obviously special.

> And using a 'discovery_subsys' subdir does raise issues with handling 
> the default discovery subsystem.
> If it's not listed one would assume that this port doesn't have a 
> discovery subsystem.
> If it's listed we cannot make it a default entry, as then we can't 
> remove it.

I think that the current interface is confusing as well.

> And I've yet to find a way how to create dynamic entries from kernel 
> space. If you have a way, please tell.
> 
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/configfs.c  | 10 +++++++++
>>>   drivers/nvme/target/core.c      | 15 ++++++++++---
>>>   drivers/nvme/target/discovery.c | 39 ++++++++++++++++++++++-----------
>>>   drivers/nvme/target/nvmet.h     |  1 +
>>>   4 files changed, 49 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/configfs.c 
>>> b/drivers/nvme/target/configfs.c
>>> index 38b0ab9fb721..44573fe0dfe4 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct 
>>> config_item *parent,
>>>       link->subsys = subsys;
>>>       down_write(&nvmet_config_sem);
>>> +    if (subsys->type == NVME_NQN_CURR &&
>>> +        port->disc_subsys) {
>>
>> The CURR is really confusing to me...
>> Can you explain the NQN types mapping here?
>>
> 
> TPAR 8014 changed the meaning of the original 'discovery subsystem' type 
> to 'discovery subsystem referral' (as this was the actual meaning of the 
> original spec), and added a new entry 'current discovery subsystem' to 
> return information about the current subsystem (ie that one where the 
> controller is attached to).

Eh, at least the usage of CURR in the code is weird. I understand what
it means in the log page, but the usage here is strange. I suggest to
use a different enumeration naming in the code and leave CURR to the
log page, where it makes sense.

> 
>>> +        pr_err("discovery subsystem already present\n");
>>> +        ret = -EAGAIN;
>>> +        goto out_free_link;
>>> +    }
>>>       ret = -EEXIST;
>>>       list_for_each_entry(p, &port->subsystems, entry) {
>>>           if (p->subsys == subsys)
>>> @@ -835,6 +841,8 @@ static int nvmet_port_subsys_allow_link(struct 
>>> config_item *parent,
>>>       list_add_tail(&link->entry, &port->subsystems);
>>>       subsys->port_count++;
>>> +    if (subsys->type == NVME_NQN_CURR)
>>> +        port->disc_subsys = subsys;
>>>       nvmet_port_disc_changed(port, subsys);
>>>       up_write(&nvmet_config_sem);
>>> @@ -866,6 +874,8 @@ static void nvmet_port_subsys_drop_link(struct 
>>> config_item *parent,
>>>       subsys->port_count--;
>>>       nvmet_port_del_ctrls(port, subsys);
>>>       nvmet_port_disc_changed(port, subsys);
>>> +    if (port->disc_subsys == subsys)
>>> +        port->disc_subsys = NULL;
>>>       if (list_empty(&port->subsystems))
>>>           nvmet_disable_port(port);
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 90e75324dae0..afd80999a335 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -1495,10 +1495,19 @@ static struct nvmet_subsys 
>>> *nvmet_find_get_subsys(struct nvmet_port *port,
>>>       if (!port)
>>>           return NULL;
>>> +    /*
>>> +     * As per spec discovery subsystems with a unique NQN
>>> +     * have to respond to both NQNs, the unique NQN and the
>>> +     * standard discovery NQN.
>>> +     */
>>>       if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
>>> -        if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
>>> -            return NULL;
>>> -        return nvmet_disc_subsys;
>>> +        struct nvmet_subsys *disc_subsys;
>>> +
>>> +        disc_subsys = port->disc_subsys ?
>>> +            port->disc_subsys : nvmet_disc_subsys;
>>> +        if (!kref_get_unless_zero(&disc_subsys->ref))
>>> +                return NULL;
>>> +        return disc_subsys;
>>>       }
>>
>> Why use the port discovery subsys? why not just use the standard
>> discovery subsys?
>>
> 
> Because (due to TPAR8014) we have to return information about the 
> current discovery subsystem, including all port details.

So you got a discovery log page request on the default discovery
subsys and you are filling the log page with content of the unique
discovery subsys? The current discovery subsystem is the default
discovery subsystem in this case, no?

Maybe I'm missing something...

> 
>>>       down_read(&nvmet_config_sem);
>>> diff --git a/drivers/nvme/target/discovery.c 
>>> b/drivers/nvme/target/discovery.c
>>> index b5012df790d5..6b8aa6c4e752 100644
>>> --- a/drivers/nvme/target/discovery.c
>>> +++ b/drivers/nvme/target/discovery.c
>>> @@ -29,18 +29,22 @@ void nvmet_port_disc_changed(struct nvmet_port 
>>> *port,
>>>                    struct nvmet_subsys *subsys)
>>>   {
>>>       struct nvmet_ctrl *ctrl;
>>> +    struct nvmet_subsys *disc_subsys;
>>>       lockdep_assert_held(&nvmet_config_sem);
>>>       nvmet_genctr++;
>>> -    mutex_lock(&nvmet_disc_subsys->lock);
>>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, 
>>> subsys_entry) {
>>> +    disc_subsys = port->disc_subsys ?
>>> +        port->disc_subsys : nvmet_disc_subsys;
>>> +
>>> +    mutex_lock(&disc_subsys->lock);
>>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>>           if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
>>>               continue;
>>>           __nvmet_disc_changed(port, ctrl);
>>>       }
>>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>>> +    mutex_unlock(&disc_subsys->lock);
>>>       /* If transport can signal change, notify transport */
>>>       if (port->tr_ops && port->tr_ops->discovery_chg)
>>> @@ -48,19 +52,23 @@ void nvmet_port_disc_changed(struct nvmet_port 
>>> *port,
>>>   }
>>>   static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
>>> -                    struct nvmet_subsys *subsys,
>>>                       struct nvmet_host *host)
>>>   {
>>>       struct nvmet_ctrl *ctrl;
>>> +    struct nvmet_subsys *disc_subsys;
>>> +
>>> +    disc_subsys = port->disc_subsys ?
>>> +        port->disc_subsys : nvmet_disc_subsys;
>>> -    mutex_lock(&nvmet_disc_subsys->lock);
>>> -    list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, 
>>> subsys_entry) {
>>> +    mutex_lock(&disc_subsys->lock);
>>> +
>>> +    list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>>>           if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
>>>               continue;
>>>           __nvmet_disc_changed(port, ctrl);
>>>       }
>>> -    mutex_unlock(&nvmet_disc_subsys->lock);
>>> +    mutex_unlock(&disc_subsys->lock);
>>
>> Why remove the subsys argument from this function?
>>
> 
> Because it's not needed?
> But I can make it a separate patch if you prefer.

But different hosts can be connected to different discovery subsystems.

Is the implementation intent is that you always use the unique
discovery subsystem also when hosts refer to the default discovery
subsystem?

If so, that behavior was not clear in the cover-letter/change-log at
all.

>>>   }
>>>   void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>>> @@ -76,7 +84,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys 
>>> *subsys,
>>>           list_for_each_entry(s, &port->subsystems, entry) {
>>>               if (s->subsys != subsys)
>>>                   continue;
>>> -            __nvmet_subsys_disc_changed(port, subsys, host);
>>> +            __nvmet_subsys_disc_changed(port, host);
>>>           }
>>>   }
>>> @@ -146,7 +154,10 @@ static size_t discovery_log_entries(struct 
>>> nvmet_req *req)
>>>       struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>       struct nvmet_subsys_link *p;
>>>       struct nvmet_port *r;
>>> -    size_t entries = 1;
>>> +    size_t entries = 0;
>>> +
>>> +    if (!req->port->disc_subsys)
>>> +        entries++;
>>>       list_for_each_entry(p, &req->port->subsystems, entry) {
>>>           if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
>>> @@ -208,10 +219,12 @@ static void 
>>> nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>>>       nvmet_set_disc_traddr(req, req->port, traddr);
>>> -    nvmet_format_discovery_entry(hdr, req->port,
>>> -                     nvmet_disc_subsys->subsysnqn,
>>> -                     traddr, NVME_NQN_CURR, numrec);
>>> -    numrec++;
>>> +    if (!req->port->disc_subsys) {
>>> +        nvmet_format_discovery_entry(hdr, req->port,
>>> +                nvmet_disc_subsys->subsysnqn,
>>> +                traddr, NVME_NQN_CURR, numrec);
>>> +        numrec++;
>>> +    }
>>
>> For the unique discovery you don't need this?
>>
> No.
> As mentioned above, unique discovery subsystems are handled identically 
> to 'normal' subsystems, which in this case means that they will be part 
> of the list of subsystems linked to a port.
> So we'll get information about the discovery subsystem with the loop a 
> few lines below that code.

I see. makes sense.

