Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9224AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKGjpAQVpy4yStD/Tmb+3xjugdXyt8rULKPwkSzj+pk=; b=oHg0rBFMWnFIRcsJzbclp0nnK6
	4yDuMbdEA+LfPF3sbrUefi92M0J+ovQ+6+9wPamDOyWlAAj7dZLDeC9LcpVUOeilXKghlZfVP58gN
	u1976jxS9rTBwf4VI0kBaopdSxSTk1UrNvLILDBQQKRE+FS2Lff8RLV8dY1vDJOFwdCh+JerYw/7V
	0ns2FoK4ZM6TPyJMLs0qPrKVIzZW0G5XGm0dguGODSUdNnQSWPm89qdHVsxNFDl7VP7if5GSfAy0o
	HUXnvHO8M8zr9WgYF6GwYGcFBjTqf3h1kMPW9zJvyxfZlrbWwXnkiOKPAVkdRDrrrOGb0XQFFjjHq
	qaRN5iUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGhHZ-008Cna-FG; Sun, 06 Feb 2022 13:08:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGhHR-008Clo-VK
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 13:08:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C6A21F386;
 Sun,  6 Feb 2022 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644152914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKGjpAQVpy4yStD/Tmb+3xjugdXyt8rULKPwkSzj+pk=;
 b=oY5aLASfYGspRJ6oQNtH4t49Wut1GwzQEqmFhKhLX7AiHAk5iqO9DUudtMQVmwvQkoaFu1
 90tMte0BIL2+uRU7qvfpt+gs/k/0LD+Q84/4Mjn+iYkdYQ6Nj7lSfUan7LsEQpIVex2lXQ
 /tKF4ItPpa2cpzS6EFXt27w6fsYAXwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644152914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKGjpAQVpy4yStD/Tmb+3xjugdXyt8rULKPwkSzj+pk=;
 b=JQC//vky479Iii1/dAmbFCOaD0W72eN0ib18xY7AFLO6/80Js+5v0s/klr5BcAcPYk5Pd0
 p7KoBH/3uoWrnOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D184C139EF;
 Sun,  6 Feb 2022 13:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9pYPMFHI/2FwPwAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 06 Feb 2022 13:08:33 +0000
Message-ID: <17c95ce8-49f2-da6f-ff6c-71dfbb57cb66@suse.de>
Date: Sun, 6 Feb 2022 14:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Greg KH <gregkh@linuxfoundation.org>,
 Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, rafael@kernel.org, charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_050838_209073_1BCFF737 
X-CRM114-Status: GOOD (  21.01  )
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

On 2/6/22 09:54, Sagi Grimberg wrote:
> Hey Greg,
> 
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index b5e452aa3c0e..4e3db5ec3924 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl 
>>> *ctrl)
>>>       ctrl->max_namespaces = le32_to_cpu(id->mnan);
>>>       ctrl->ctratt = le32_to_cpu(id->ctratt);
>>> +    ctrl->cntrltype = id->cntrltype;
>>> +    ctrl->dctype = id->dctype;
>>> +
>>>       if (id->rtd3e) {
>>>           /* us -> s */
>>>           u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
>>> @@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>>               return ret;
>>>       }
>>> +    ret = device_update_groups(ctrl->device);
>>> +    if (ret)
>>> +        return ret;
>>
>> Why is this needed here?  How did the class or type just change?  That
>> should never change over the lifespan of a device.  If it does, you need
>> to tear down the old device and create a new one as something really
>> wrong just happened.
> 
> The class and type do not change. The fundamental need here is to update
> visible attributes of the device.
> 
> In nvme, we create the device node with its sysfs attributes and next
> comes a process where we interrogate it for capabilities/personality.
> In this example, the attributes cntrltype and dctype are learned from
> the device identification, and the desire is that dctype will only be
> visible for specific cntrltype (i.e. cntrltype is I/O controllers vs.
> discovery controllers and dctype is the discovery controller type).
> 
> So perhaps a more narrowed interface to update attributes
> visibility of the controller would be more appropriate instead?
> 
> Something like:
> -- 
>      ret = device_update_visibility(ctrl->device->groups);
> -- 

I guess it can be even simpler; to my reading the prime objection is 
that we change attributes (and attribute visibility) without informing 
userspace that we did so, thus udev and the device configuration driven 
by uevents won't work as expected.

Which means that everything should be okay if we issue an KOBJ_CHANGE 
uevent after we modify the visibility of attributes, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

