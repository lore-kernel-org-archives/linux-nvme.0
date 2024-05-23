Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3EBC25B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uryHqSo7J6emxdG0G3D06GB408oVW6DLwiUMV2hxBbo=; b=V67CDn5fC1OhNbTVwz6Quy4wOu
	sF6qtysPnVKAeFBUzSDmGIqaurc5zCtioegYG4S+Apj8FcP6Nx1P2J00Y1kwsYn6MZBWabiCyujn0
	Qg69/HwHEoIL9jhOUMcyHEl3z6NJZErw7DYqZXV5M67FgtK7d2x7CI75s4m7+398Bwr0ePKXCrBl7
	6W65wCyy/gN7xuHpGOVO50caFj3JxzUgvDitWmuQS56J7tir1/0AXlMYIdsdCz3NbBv6DMWGka0Lj
	TiEFD5ErNQFkPNZbR6SIoHIsvkt1TlFMaVGz9WXXiP2u9MVfUMxAK/sVcMbucLplxAXPr2h1ge3qZ
	V/8RYybQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA3t-00000006bTl-2gTI;
	Thu, 23 May 2024 15:08:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA3q-00000006bT9-2QO8
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:08:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uryHqSo7J6emxdG0G3D06GB408oVW6DLwiUMV2hxBbo=;
	b=ijiOajyYRjD0xnlsiaBJ5M/6YzzBlbC+VoEcqB1YCsRNf2VWRPtXq/taVGpwJa4kYoSEqi
	lLAhU6DClvkOwcjtxG6p3v+RTB9j6mLp89ZfVQaEFpldpRIIUFRIHRBGawtD0JfayCBwWO
	5aQeaTGv+6U3myynYBS6wSmctaEBVg8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-wtZUeLnaOWSKQ2SN78HIoQ-1; Thu,
 23 May 2024 11:08:49 -0400
X-MC-Unique: wtZUeLnaOWSKQ2SN78HIoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 258E93C025B9;
	Thu, 23 May 2024 15:08:48 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D036A2026D68;
	Thu, 23 May 2024 15:08:47 +0000 (UTC)
Message-ID: <40122d01-9e5b-4c85-9cf4-93f7abd2532b@redhat.com>
Date: Thu, 23 May 2024 11:08:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <20240523065257.GB28524@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523065257.GB28524@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_080854_724943_9C8E002C 
X-CRM114-Status: GOOD (  27.02  )
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

On 5/23/24 02:52, Christoph Hellwig wrote:
>> +	/*
>> +	 * queue-depth iopolicy does not need to reference ->current_path
>> +	 * but round-robin needs the last path used to advance to the
>> +	 * next one, and numa will continue to use the last path unless
>> +	 * it is or has become not optimized
>> +	 */
> 
> Can we please turn this into a full sentence?  I.e.:
> 
> 	/*
> 	 * The queue-depth iopolicy does not need to reference ->current_path,
> 	 * but the round-robin iopolicy needs the last path used to advance to
> 	 * the next one, and numa will continue to use the last path unless
> 	 * it is or has become non-optimized.
> 	 */
> 
> ?

I can do that.

>> +	if (iopolicy == NVME_IOPOLICY_QD)
>> +		return nvme_queue_depth_path(head);
>> +
>> +	node = numa_node_id();
>>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
>>   	if (unlikely(!ns))
>>   		return __nvme_find_path(head, node);
>>   
>> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
>> +	if (iopolicy == NVME_IOPOLICY_RR)
>>   		return nvme_round_robin_path(head, node, ns);
>> +
>>   	if (unlikely(!nvme_path_is_optimized(ns)))
>>   		return __nvme_find_path(head, node);
>>   	return ns;
> 
> Also this is growing into the kind of spaghetti code that is on the fast
> path to become unmaintainable.  I'd much rather see the
> srcu_dereference + __nvme_find_path duplicated and have a switch over
> the iopolicies with a separate helper for each of them here than the
> various ifs at different levels.


OK I will turn this into a switch statement.

>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> 
> Overly long line here.

I can fix this.

>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	if (old_iopolicy == iopolicy)
>> +		return;
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		atomic_set(&ctrl->nr_active, 0);
>> +		nvme_mpath_clear_ctrl_paths(ctrl);
>> +	}
>> +	mutex_unlock(&nvme_subsystems_lock);
> 
> You probably want to take the lock over the iopolicy assignment to
> serialize it.  And why do we need the atomic_set here?

Since we are targeting this to 6.11, I will work on refactoring this code.

I'll remove the atomic set here, but I may also add a WARN_ON_ONCE someplace just to be sure our assumptions about the nr_active 
counter state is correct. I agree with Keith that these counters need to be accurate in order for queue-depth to work.

>> +
>> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
>> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> 
> Pleae avoid the overly long line here as well.

Hmm... I thought I fixed this already.   Will do.

>>   	NVME_REQ_CANCELLED		= (1 << 0),
>>   	NVME_REQ_USERCMD		= (1 << 1),
>>   	NVME_MPATH_IO_STATS		= (1 << 2),
>> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
> 
> This does not match the indentation above.

I must have my tab stop set incorrectly in .vimrc or something.  I'll fix this.

/John


