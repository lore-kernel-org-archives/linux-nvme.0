Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92143C25B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CU/jGOufpQnw0cNSfqqLbGhClM26c0uKJV5LPzI13I0=; b=SHbyEwBxwJ2cYiIot1inncLYdb
	CsgIYG7tJRm/cZJq6ofpeol4QRlYGDy6V1sTrrE4+xAb/X67ZidpPJAE/41/BYYOFBHjr3Wkh5fal
	xMV5MYhSGbWy8KV8gm3IqXkf1EDT/UgleR+KOp4zHaYGxyWbi97BYoFtFpCaOgHYwDW29NliCAXfR
	i54n6qpN2kArMnPE5ETxNGsfthw81q7aYxobIsb4JMy3VoqXk+92GjkZGr3TtvdlSKBbGv1aQOwMR
	3pl48V/U4hoeUP8nTkpjP0Iik/f2SbR1P6awPeNi9A/3XAW4ovuxJMrt+G+uL5pICFJUpAs3sLvA4
	bRSpvp2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QMS-000000009N3-0QqJ;
	Tue, 21 May 2024 14:21:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QML-000000009JJ-09iD
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 14:20:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU/jGOufpQnw0cNSfqqLbGhClM26c0uKJV5LPzI13I0=;
	b=H3me0glMvL8XwJLjloj43qb/DD1mtLvw2EeX6uTsUFvjBFQUwkeDWINDEriCJTAMzSBEO2
	GB+8rNt66GEdQWCwRZjhWBVsjcT4GtSVzvjAAt02ssl/IUK0LCxQ3mVZOifx4Gm6w7LBBF
	ZwkiUeqQznb1v6jcu+pe7c+iy2vHrEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-dSeP8LStM02D5uAk-NaQcA-1; Tue,
 21 May 2024 10:20:54 -0400
X-MC-Unique: dSeP8LStM02D5uAk-NaQcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3657B380673B;
	Tue, 21 May 2024 14:20:54 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B4171C0654B;
	Tue, 21 May 2024 14:20:53 +0000 (UTC)
Message-ID: <19fa255b-a29c-42a9-b9aa-48422e6000b3@redhat.com>
Date: Tue, 21 May 2024 10:20:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com> <Zku3fBuauZQX6bEO@kbusch-mbp>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Zku3fBuauZQX6bEO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_072057_283746_2014AD89 
X-CRM114-Status: GOOD (  25.18  )
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

On 5/20/24 16:50, Keith Busch wrote:
>>   static LIST_HEAD(nvme_subsystems);
>> -static DEFINE_MUTEX(nvme_subsystems_lock);
>> +DEFINE_MUTEX(nvme_subsystems_lock);
> This seems odd. Why is this lock protecting both the global
> nvme_subsystems list, and also subsystem controllers? IOW, why isn't the
> subsys->ctrls list protected by the more fine grained 'subsys->lock'
> instead of this global lock?
> 
>> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>   	&iopolicy, 0644);
>>   MODULE_PARM_DESC(iopolicy,
>> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
>> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
 >
> Unnecessary space before the ','.

I'll fix this.

>> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
>> +		atomic_inc(&ns->ctrl->nr_active);
>> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>> +	}
>> +
>>   	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>>   		return;
>>   
>> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>>   {
>>   	struct nvme_ns *ns = rq->q->queuedata;
>>   
>> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
>> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
 >
> You can just do a atomic_dec() since your new flag has this tied to to
> the atomic_inc().

No, I don't think that would be correct because, for a number of reasons, this counter could go below zero. e.g. there is 
nothing to prevent the IO policy from changing between nvme_mpath_start_request and nvme_mpath_end_request, and there are code 
paths like the reset/cancel code path which could affect this counter.

Also, this code path has been extensively tested. Ewan has played with all kinds of different counting schemes, which didn't 
work. I'm happy to make non-functional changes, but a functional change like this would require completely retesting and 
re-verifying thing.

I'd like to keep this.

>> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>> +{
>> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
>> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
>> +	unsigned int depth;
>> +
>> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +		if (nvme_path_is_disabled(ns))
>> +			continue;
>> +
>> +		depth = atomic_read(&ns->ctrl->nr_active);
>> +
>> +		switch (ns->ana_state) {
>> +		case NVME_ANA_OPTIMIZED:
>> +			if (depth < min_depth_opt) {
>> +				min_depth_opt = depth;
>> +				best_opt = ns;
>> +			}
>> +			break;
>> +
>> +		case NVME_ANA_NONOPTIMIZED:
>> +			if (depth < min_depth_nonopt) {
>> +				min_depth_nonopt = depth;
>> +				best_nonopt = ns;
>> +			}
>> +			break;
>> +		default:
>> +			break;
>> +		}
 >
> Could we break out of this loop early if "min_depth_opt == 0"? We can't
> find a better path that that, so no need to read the rest of the paths.

I can do that... since we are keeping the atomic_dec_if_positive() above. ;-)

>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
> Let's add a check here:
> 
> 	if (old_iopolicy == iopolicy)
> 		return;

Actually, this is feature, not a bug.  I'd like to keep the ability to reset the nr_active counters.  It is an invaluable tool 
that I use during testing.  See my comments to Hannes.

>> @@ -935,6 +940,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
>>   void nvme_mpath_start_request(struct request *rq);
>>   void nvme_mpath_end_request(struct request *rq);
>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
 >
> This funciton isn't used outside multipath.c, so it should be static.

I'll fix this.

/John


