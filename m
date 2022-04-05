Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44110C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ag9WWxDgAZiKiM6yAi30OJCVxW2J+Zw5EEVVsi5SnRo=; b=10D0abAmiSfFMOimcUMPX9HASd
	N81MJAAKd6K4Cgfkf3a56F//9Wv7j9aymKJs3dyxuwJ2Vevfl2RDN/dwkDJSnLgGXsNp6gZrZW1fT
	dUXinTuPA/6DhdSgFGDI27xrXNGysoNsoBbhEk10hnj7J1O67cn/fDLinCSmRQ4lp3gacSPN6smgZ
	D13Gq8tJvYb8YAonDFzMCU6JkTbSDIdYZ4Z/w1CwP6dxawlJMdY1G7AEGpVa5rEzN9q30kGfxL2nn
	wrQlo83+HhnV4nuyUQQstvvvJDce/h0bi6tv936qVZiuT6yLd1NaVdRShPl65IREgfnfsEAvVwrNc
	/E61J7Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbj0q-001624-Is; Tue, 05 Apr 2022 13:14:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbj0o-00160n-JG
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 13:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649164459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ag9WWxDgAZiKiM6yAi30OJCVxW2J+Zw5EEVVsi5SnRo=;
 b=SL64EsL4nqvt0Qs/v9mq1enh86LV52pIxdGwXMl/SUZwaFe0FvptXVO4OwTfkWQ2yl5vUI
 EgUcKKmSTAFFdv3fQ0q2vthMjbNA9G5/ldZ+cqt54+vIOlW1ypVVkKHI4EcVaYXRMr1Ci/
 kXiaHfwlD3lqgSEHM3LzwWg9lbO6e5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-OLotAZ9TOWCvqVkUCdBEgA-1; Tue, 05 Apr 2022 09:14:18 -0400
X-MC-Unique: OLotAZ9TOWCvqVkUCdBEgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8BD6804183;
 Tue,  5 Apr 2022 13:14:17 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F62D20239F4;
 Tue,  5 Apr 2022 13:14:16 +0000 (UTC)
Message-ID: <0d9045f4-a901-8110-c6ed-89805d8e6558@redhat.com>
Date: Tue, 5 Apr 2022 09:14:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH] nvme: fix RCU hole that allowed for endless looping
 in multipath round robin
From: John Meneghini <jmeneghi@redhat.com>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, lengchao@huawei.com, dwagner@suse.de,
 hare@suse.de, mlombard@redhat.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-4-cleech@redhat.com>
 <7d9771f2-d86c-25e5-5bee-504e33c5aae7@grimberg.me>
 <20220323153414.GA440@lst.de>
 <98469a28-a2da-65f9-2719-c568eea94b26@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <98469a28-a2da-65f9-2719-c568eea94b26@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_061422_741869_1B3ED51C 
X-CRM114-Status: GOOD (  22.37  )
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

I just want to report back that our partner has tested this patch and verified that it fixes the soft-lockup problems.

They are unable to reproduce the problem when running the same tests on the same testbed when using this patch.

/John

On 3/23/22 15:07, John Meneghini wrote:
> This is good. I'm glad everyone agrees.
> 
> Chris, please ask our partner to test this patch in their testbed and verify that
> this fixes the soft-lockup problem they are seeing. I believe they have the ability
> to reproduce this problem on their 8.6 testbed.
> 
> If that works then please re-post a patch so people can consider this for v5.18.
> 
> /John
> 
> 
> On 3/23/22 11:34, Christoph Hellwig wrote:
>> On Wed, Mar 23, 2022 at 04:54:26PM +0200, Sagi Grimberg wrote:
>>>
>>>
>>> On 3/22/22 00:43, Chris Leech wrote:
>>>> Make nvme_ns_remove match the assumptions elsewhere.
>>>>
>>>> 1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
>>>>      running in __nvme_find_path or nvme_round_robin_path that will
>>>>      re-assign this ns to current_path.
>>>>
>>>> 2) Any matching current_path entries need to be cleared before removing
>>>>      from the siblings list, to prevent calling nvme_round_robin_path with
>>>>      an "old" ns that's off list.
>>>>
>>>> 3) Finally the list_del_rcu can happen, and then synchronize again
>>>>      before releasing any reference counts.
>>>> ---
>>>>    drivers/nvme/host/core.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index fd4720d37cc0..20778dc9224c 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>        set_capacity(ns->disk, 0);
>>>>        nvme_fault_inject_fini(&ns->fault_inject);
>>>>    +    /* ensure that !NVME_NS_READY is seen
>>>> +     * to prevent this ns going back in current_path
>>>> +     */
>>>> +    synchronize_srcu(&ns->head->srcu);
>>>> +
>>>> +    /* wait for concurrent submissions */
>>>> +    if (nvme_mpath_clear_current_path(ns))
>>>> +        synchronize_srcu(&ns->head->srcu);
>>>
>>> Nothing prevents it from being reselected again.
>>> This is what drove the placement of this after the
>>> ns is removed from the head->list. But that was before
>>> the selection looked into NVME_NS_READY flag...
>>>
>>> This looks legit to me...
>>
>> Yes, this looks pretty sensible.  I'm tempted to just queue it up
>> for 5.18.
>>
> 


