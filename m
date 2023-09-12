Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9568BCA0EDD
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vASbwleZs08It2X70ojRc3jvYUthBmdmjLjm1L7p+8U=; b=C8mCP4DV5Hhzv0E2oIXzzfCOFW
	0XjszL+d+Nb/ryy6/HKd+soUzL/H+a4m52Z/2QIwMscf/KmtAhbnb0pr8Xqh3ORy058vLNcemSW8P
	Owv3wwawhy7Ky13DI8VhRKUq+sWpIPjg8+ZUmiozZNZ307sXmReGRq2ZV9oWKh0FKEFZyg27FJAqq
	thMqviqKGqcGbSeH+d2Xy0AIl944hiyo93Svponooagt1TSt9/wJGiZF0rGrPArAbJNK826Zp1dnQ
	xfksfz7mvBEyHJWS/NNIRin7aGqkSl1hz400k8J04enpXLKwXdAJXCdg0+e0fbrrVAI3Q6AjQiNf2
	IiDJUH4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg40a-003Uhc-0c;
	Tue, 12 Sep 2023 14:04:52 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg40X-003UhA-1e
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 14:04:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB52E21220;
	Tue, 12 Sep 2023 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694527483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vASbwleZs08It2X70ojRc3jvYUthBmdmjLjm1L7p+8U=;
	b=eZLJo5jCoZtMb1QIo0LRe2vwlcDj98Ehy3EAW1GgLftXFpEM11ZdxsJDHTiv1X1+l1IMvx
	IqZLO3Xu+Z7NKX2/jt4fHSbTH9pQ/dFxwHdjnjDhlx11FuZSuQpui5JNju22nZFeXqwDdA
	GnXhvzaQNQWFN9xxlNywxQsMPquSk3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694527483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vASbwleZs08It2X70ojRc3jvYUthBmdmjLjm1L7p+8U=;
	b=wXeLPb+6Bg9o029RckkADC4BEana1L49Ld7mLn8BRHt0TsDTXL81YkfjNbTmP/Z/QsKf4u
	hS13TAb4JZZXsRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC158139DB;
	Tue, 12 Sep 2023 14:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8+BUNftvAGXuSgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 14:04:43 +0000
Message-ID: <31a44658-4a3a-43db-a99c-451c655dfb4a@suse.de>
Date: Tue, 12 Sep 2023 16:04:43 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <44f7eb6a-2dd5-b487-afeb-88b7e64d8a12@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_070449_714966_F1573B80 
X-CRM114-Status: GOOD (  17.88  )
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

On 9/12/23 14:55, Sagi Grimberg wrote:
> 
>>>> It is really annoying to always have to loop through the entire
>>>> /sys/block directory just to find the namespace path links for
>>>> a single namespace in libnvme/nvme-cli.
>>>> So provide links to the namespace paths for efficient lookup.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/core.c      |  3 +++
>>>>   drivers/nvme/host/multipath.c | 10 ++++++++++
>>>>   2 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 37b6fa746662..88933838e067 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>       if (!nvme_ns_head_multipath(ns->head))
>>>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>> +    else
>>>> +        sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
>>>> +                  ns->disk->disk_name);
>>>>       del_gendisk(ns->disk);
>>>>       down_write(&ns->ctrl->namespaces_rwsem);
>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>> b/drivers/nvme/host/multipath.c
>>>> index 0a88d7bdc5e3..9dd0be645dad 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, 
>>>> __le32 anagrpid)
>>>>       if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>>>           ns->head->disk->nr_zones = ns->disk->nr_zones;
>>>>   #endif
>>>> +    if (ns->head->disk) {
>>>
>>> Why are the two conditions not identical?
>>>
>> Which two?
> 
> ns->head->disk and nvme_ns_head_multipath()
> 
How can we have one without the other? I thought that both are mutually 
dependent .. but yeah, we should be using 'nvme_ns_head_multipath()' here.

>>
>>>> +        int ret;
>>>> +
>>>> +        ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
>>>> +                    &disk_to_dev(ns->disk)->kobj,
>>>> +                    ns->disk->disk_name);
>>>> +        if (ret)
>>>> +            dev_warn(ns->ctrl->device,
>>>> +                 "failed to create namespace path link\n");
>>>> +    }
>>>>   }
>>>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>
>>> What will these links be used for?
>>
>> Mapping for nvme-cli, as explained in the description.
>> Clearly it doesn't do it _now_, but once the patch is in we can
>> simplify nvme-cli to take advantage of it.
> 
> you mean for nvme list -v ?
> 
> Don't really mind having it, but would want to hear from others as
> well.

Ok.

Cheers,

Hannes


