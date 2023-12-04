Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FF1C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=unX34RTz8yQkfewglLolxRiW/Bzi6nSBSeVd6fBHu5I=; b=m+s4rm0dd90oMxJTKuRoUV401M
	CK+WQNeyaKANGqAhl17Uo97DUi4NgaR2V2Argy1My73e1V6ukBIAfH2QPUWm2hqvk6a4YnhHtgxrw
	KlDztRzUkfSC1wmmockHMYBBWI98gsITSHUluOnYJYD99dGgRHJXdA5J6T94uvtNRcatfAiTN+mAm
	BishgDAeUeH63xRZdc3Yi/GuoD6tilvO2VcLOVpI5qG5J1gXgRRrszg0hbBYDp352oLvrH/MG0rAa
	xfijzsBKmjj1EGSUWrJbWZU8tgUGW6nCKCFNi9TGBUfn5nU/FUtGCxwbkNjZcb1a8ydU2wKlCEDCH
	fOxRzWlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6z3-003dd8-2N;
	Mon, 04 Dec 2023 11:19:29 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6yy-003dbd-2p
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 11:19:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A52A6220A3;
	Mon,  4 Dec 2023 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701688761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unX34RTz8yQkfewglLolxRiW/Bzi6nSBSeVd6fBHu5I=;
	b=fJACGdzSQ+sAxuyDWD1VKzb8z9S3FZjFl/+1ved20AFcVdN7GzY99lTErDXoUHNinQmoJE
	i92wItPhFtXHq4BD8lAxJjoiRuvPsQF+VGmOextfHj2NMOqoqbXFCLFnwF2ykr26hjKSUZ
	50+3PS1BtEfMAxVCW+jbsCMYL1a2PBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701688761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unX34RTz8yQkfewglLolxRiW/Bzi6nSBSeVd6fBHu5I=;
	b=0lOfd7kQAgFTkXDBcigwgApFUkepJK3oxKSefncxXy6buLofFRm1hulGuBd3MxSd0+5WWm
	dM4aUaiORVWycXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 790FA1398A;
	Mon,  4 Dec 2023 11:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZqRG7m1bWVaawAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Dec 2023 11:19:21 +0000
Message-ID: <3095351b-f163-4b4c-8f37-145bab624a68@suse.de>
Date: Mon, 4 Dec 2023 12:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908065717.92207-1-hare@suse.de>
 <70d9fb1e-07f8-d130-4308-f279c36ddc24@grimberg.me>
 <dd985619-7486-4ef7-9904-36e1d056767b@suse.de>
 <44f7eb6a-2dd5-b487-afeb-88b7e64d8a12@grimberg.me>
 <31a44658-4a3a-43db-a99c-451c655dfb4a@suse.de>
 <ef031aaa-e89f-4a66-b85b-28515db0800e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ef031aaa-e89f-4a66-b85b-28515db0800e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.942];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_031925_086151_FB06ADD2 
X-CRM114-Status: GOOD (  16.39  )
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

On 12/4/23 11:25, Sagi Grimberg wrote:
> 
> 
> On 9/12/23 17:04, Hannes Reinecke wrote:
>> On 9/12/23 14:55, Sagi Grimberg wrote:
>>>
>>>>>> It is really annoying to always have to loop through the entire
>>>>>> /sys/block directory just to find the namespace path links for
>>>>>> a single namespace in libnvme/nvme-cli.
>>>>>> So provide links to the namespace paths for efficient lookup.
>>>>>>
>>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>>> ---
>>>>>>   drivers/nvme/host/core.c      |  3 +++
>>>>>>   drivers/nvme/host/multipath.c | 10 ++++++++++
>>>>>>   2 files changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index 37b6fa746662..88933838e067 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>>>       if (!nvme_ns_head_multipath(ns->head))
>>>>>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>>>> +    else
>>>>>> +        sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>>> +                  ns->disk->disk_name);
>>>>>>       del_gendisk(ns->disk);
>>>>>>       down_write(&ns->ctrl->namespaces_rwsem);
>>>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>>>> b/drivers/nvme/host/multipath.c
>>>>>> index 0a88d7bdc5e3..9dd0be645dad 100644
>>>>>> --- a/drivers/nvme/host/multipath.c
>>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>>> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, 
>>>>>> __le32 anagrpid)
>>>>>>       if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>>>>>           ns->head->disk->nr_zones = ns->disk->nr_zones;
>>>>>>   #endif
>>>>>> +    if (ns->head->disk) {
>>>>>
>>>>> Why are the two conditions not identical?
>>>>>
>>>> Which two?
>>>
>>> ns->head->disk and nvme_ns_head_multipath()
>>>
>> How can we have one without the other? I thought that both are 
>> mutually dependent .. but yeah, we should be using 
>> 'nvme_ns_head_multipath()' here.
>>
>>>>
>>>>>> +        int ret;
>>>>>> +
>>>>>> +        ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>>> +                    &disk_to_dev(ns->disk)->kobj,
>>>>>> +                    ns->disk->disk_name);
>>>>>> +        if (ret)
>>>>>> +            dev_warn(ns->ctrl->device,
>>>>>> +                 "failed to create namespace path link\n");
>>>>>> +    }
>>>>>>   }
>>>>>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>>>
>>>>> What will these links be used for?
>>>>
>>>> Mapping for nvme-cli, as explained in the description.
>>>> Clearly it doesn't do it _now_, but once the patch is in we can
>>>> simplify nvme-cli to take advantage of it.
>>>
>>> you mean for nvme list -v ?
>>>
>>> Don't really mind having it, but would want to hear from others as
>>> well.
>>
>> Ok.
> 
> Hey Hannes,
> Has this gone anywhere?

Sadly, no. Everyone said "Yeah, good idea, but let's wait for the 
others." I _dearly_ would love to have it as it will simplify the
logic in nvme-cli/libnvme drastically.
Shall I repost?

Cheers,

Hannes


