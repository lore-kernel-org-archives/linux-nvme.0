Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083AEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rneSrZ4RSFtzjxwsYuhmemWyKt686ZBbYklbTgRmyBc=; b=0cqFpZFSUbXZ7vH0+ANrCKr7WL
	6E9roMfikKgg+CYTskfRTmrl8TiisZ2aonV2IeYPmGJvImsBsDJlJfmAiAM/I+24lMqsLUPqaeZj/
	HZnDGTwy9kwmMcsW+6T4J2H0MT53NkI5mM4fioR22doqK8RianBSpzj+CgzPP/nII5HhZSavRO6J/
	mI1LHu48jssIjWUckK5KxP4hioGHvSZs3QVDlSNIWKko/457YjPYW+HFLi0+hejw1TaJHtY9DLWWN
	XZnz/QhaMOMP1JEAlgKL3913NLkLyD9z525dIdUUj6miKLL4fdVu225Cp0qFqk0FjYI8H+9ZrXUbn
	/HWoCXxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX6K8-00EgXm-A0; Wed, 23 Mar 2022 19:07:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX6K5-00EgX1-RN
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 19:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648062428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rneSrZ4RSFtzjxwsYuhmemWyKt686ZBbYklbTgRmyBc=;
 b=T47jJjAVPLyycMMAYCmRNPnQ5qhK14jBlE5AQLS990voLGqWkQmy8w0OD6fa0Vm+IqSQKc
 KHBQetfakhvJdUR/M2Mblgq/OsfSyPAR8noaz21hwf3QbH/Hl5bFJeWNfvZ/H5qyDPf1hs
 YjEJMXARhVRbb81LKavKgoOor0AdDSw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-S6tDs-O8Nl6ZeFgr5harMQ-1; Wed, 23 Mar 2022 15:07:07 -0400
X-MC-Unique: S6tDs-O8Nl6ZeFgr5harMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 614E828078F6;
 Wed, 23 Mar 2022 19:07:07 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 850272166B4F;
 Wed, 23 Mar 2022 19:07:04 +0000 (UTC)
Message-ID: <98469a28-a2da-65f9-2719-c568eea94b26@redhat.com>
Date: Wed, 23 Mar 2022 15:07:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH] nvme: fix RCU hole that allowed for endless looping
 in multipath round robin
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, lengchao@huawei.com, dwagner@suse.de,
 hare@suse.de, mlombard@redhat.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-4-cleech@redhat.com>
 <7d9771f2-d86c-25e5-5bee-504e33c5aae7@grimberg.me>
 <20220323153414.GA440@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220323153414.GA440@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_120709_992846_1702D8D1 
X-CRM114-Status: GOOD (  20.20  )
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

This is good. I'm glad everyone agrees.

Chris, please ask our partner to test this patch in their testbed and verify that
this fixes the soft-lockup problem they are seeing. I believe they have the ability
to reproduce this problem on their 8.6 testbed.

If that works then please re-post a patch so people can consider this for v5.18.

/John


On 3/23/22 11:34, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 04:54:26PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 3/22/22 00:43, Chris Leech wrote:
>>> Make nvme_ns_remove match the assumptions elsewhere.
>>>
>>> 1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
>>>      running in __nvme_find_path or nvme_round_robin_path that will
>>>      re-assign this ns to current_path.
>>>
>>> 2) Any matching current_path entries need to be cleared before removing
>>>      from the siblings list, to prevent calling nvme_round_robin_path with
>>>      an "old" ns that's off list.
>>>
>>> 3) Finally the list_del_rcu can happen, and then synchronize again
>>>      before releasing any reference counts.
>>> ---
>>>    drivers/nvme/host/core.c | 13 +++++++++----
>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index fd4720d37cc0..20778dc9224c 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>    	set_capacity(ns->disk, 0);
>>>    	nvme_fault_inject_fini(&ns->fault_inject);
>>>    +	/* ensure that !NVME_NS_READY is seen
>>> +	 * to prevent this ns going back in current_path
>>> +	 */
>>> +	synchronize_srcu(&ns->head->srcu);
>>> +
>>> +	/* wait for concurrent submissions */
>>> +	if (nvme_mpath_clear_current_path(ns))
>>> +		synchronize_srcu(&ns->head->srcu);
>>
>> Nothing prevents it from being reselected again.
>> This is what drove the placement of this after the
>> ns is removed from the head->list. But that was before
>> the selection looked into NVME_NS_READY flag...
>>
>> This looks legit to me...
> 
> Yes, this looks pretty sensible.  I'm tempted to just queue it up
> for 5.18.
> 


