Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF91C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hB44jEoNckFCuyEM1NsGtowIzM2T9RXtZ2BqaZ5qjGY=; b=cXi1clpKOslXoydS/vWVgT5Sw1
	cffue+wmbXqyC0gWJIqxvK9TGYYm2sv3fZ7tSUh1vF6Kp5mFz6+ztWwK2qOMlq82rnIs8Juy/kRHC
	PfryBAMWIL3hep+o6dCT52N/eorh5XhG14eh8XM0SqCAGoMnQO9qkqbe7Vz16wxKleqXKkZBjswy5
	IAaDearg0pSp2pZqIKfnzrBou67I9KGJH6uoUCt2GsOLSVlGx/h9xrG2C2tXzaIyu4JhCFUedCaJ/
	+MdiW+ITnBg2W6NP7zZVP2v+VHN/pfh+UZergZHdenz6yy0oLbMLLPCamr4GZmWOpP1ac1Ey6OdXp
	UI5zZUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9ol1-00000003WPq-21oV;
	Wed, 22 May 2024 16:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oky-00000003WNy-1E0P
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 16:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716395038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB44jEoNckFCuyEM1NsGtowIzM2T9RXtZ2BqaZ5qjGY=;
	b=MpUW4hC2iWeLvipwP947yeIESEdLCdKdJewL4t1LgN+DuGuxDU8RjnPtQIZStO0RAZjubi
	agLEOuspFu9GhbWorX8aZo1xVedCTNvSo3CuGvxWLjdFMTJ77Hz2+ruGW0T7PvMHU1QoWb
	r6bhfHI4DcB5qNrzCLHbgawhr7rSaZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-uwP77EvXMSml3iGLmDurqQ-1; Wed,
 22 May 2024 12:23:52 -0400
X-MC-Unique: uwP77EvXMSml3iGLmDurqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C423C025D2;
	Wed, 22 May 2024 16:23:52 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C970492BC6;
	Wed, 22 May 2024 16:23:51 +0000 (UTC)
Message-ID: <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
Date: Wed, 22 May 2024 12:23:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_092400_443555_6CE117A1 
X-CRM114-Status: GOOD (  23.84  )
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

On 5/22/24 11:56, Keith Busch wrote:
> On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		atomic_set(&ctrl->nr_active, 0);
> 
> Can you me understand why this is a desirable feature? Unless you
> quiesce everything at some point, you'll always have more unaccounted
> requests on whichever path has higher latency. That sounds like it
> defeats the goals of this io policy.

This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.

If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but that's not going to solve the problem of inaccurate 
counters when users start flipping io policies around. with IO inflight. There is no synchronization between io submission 
across controllers and changing the policy so I expect changing between round-robin and queue-depth with IO inflight suffers 
from the same problem... though not as badly.

I'd rather take this patch now and figure out how to fix the problem with another patch in the future.  Maybe we can check the 
io stats and refuse to change the policy of they are not zero....

>> @@ -1061,6 +1066,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>>   {
>>   	return false;
>>   }
>> +static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +}
>>   #endif /* CONFIG_NVME_MULTIPATH */
> 
> You can remove this stub function since the only caller resides in a
> CONFIG_NVME_MULTIPATH file.
> 

I can do that.  Since I have to spin a version 5 patch, do you want me to make the change above?

Is there anything else?

/John


