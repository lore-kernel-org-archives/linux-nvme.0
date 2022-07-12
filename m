Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F5FC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 21:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0gxeavJWp1Gr+c8ruZqW2AN//vO/3QZqWjVPfEbis8=; b=nGhc6vhKMrqOMAJY+pJLm+IJyL
	IwHKENqjQIqBkHOBzEqQ4Gq3uMjHZUulEhrLfmIBm3ZCYfb4cjaKk3svhe4uIp30ZYH4dLJxukwrn
	r3uZOGWQbhTi+LjbYhJY/kqQ4uuKddMaPPHAdZRF87XlHMyO7eNy8SFOMBsnChW7naDo83AatUVYH
	Vzs8SPz97u0hB8+lYBecG9ghVxKv/g1FzONU3rnTTCpUCrioeItFleqr+swhf/WUZTbOiwTD0C8Rn
	JiaLwgcJbqLnh+VK7TRoZMkxFEnkbmCJjR2+JKo9dPU1QrltjmQ3H046rd2UiheMePwhUv/PyD1Js
	tfKfd+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBNOc-00EwBX-EO; Tue, 12 Jul 2022 21:26:18 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBNOZ-00Ew90-5j
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 21:26:17 +0000
Received: by mail-wm1-f54.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so133092wmb.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Jul 2022 14:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w0gxeavJWp1Gr+c8ruZqW2AN//vO/3QZqWjVPfEbis8=;
        b=VPQEbu+k1SwvKAS/ljVPiShTiQuhuWK9rUX5pdp5X2FbAPdAnkH8OnaR6CyzOSJSuR
         sPWON2xm5lgqo8pj6Qd3VhUI6RrqPdzdfEeEVj4zhFgmvF0trsdAr252EgLkil9QEtcS
         U68l8tRUQkXkXdaG5n0RxxaRWnvp8ylgYRbX+mgtUZhZnIAF6gCeV77PSChYZ/X7bQ54
         Fa8sLp3+oD8tPvE3jkeo9z26eqFXWMe7LIN5nKNdisJTlwokjxjEyfmfd2UdK85RuSaL
         KdKMS6OqSi0cQphp2374kSUcgkD6vAWTFHotPjTvFywZGv7yMNWt8OZCkHuIdVWNhOhK
         U3dA==
X-Gm-Message-State: AJIora+TdZst5IU3acMeV9raNIT2ssx5+KZ2s4GVzVwW23PA65mEhFQ7
	jFWuPZU8Gc3YZW3cn63N2sJiDQlS14E=
X-Google-Smtp-Source: AGRyM1uT1EiNYgwsqdciVUkFdeO1v8rIpvuKxq69PFBrCanIJYhGFKk4tDAv+gSgtFvJauJbJK9XRA==
X-Received: by 2002:a1c:2645:0:b0:3a2:e388:d883 with SMTP id m66-20020a1c2645000000b003a2e388d883mr49052wmm.36.1657661172026;
        Tue, 12 Jul 2022 14:26:12 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003a1a02c6d7bsm74473wmj.35.2022.07.12.14.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:26:11 -0700 (PDT)
Message-ID: <3a2b281b-793b-b8ad-6a27-138c89a46fac@grimberg.me>
Date: Wed, 13 Jul 2022 00:26:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
 <20220711183746.GA20562@test-zns>
 <5f30c7de-03b1-768a-d44f-594ed2d1dc75@grimberg.me>
 <20220712042332.GA14780@test-zns>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220712042332.GA14780@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_142615_244621_D1DF02EF 
X-CRM114-Status: GOOD (  54.69  )
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


>>>>> @@ -448,6 +442,14 @@ static int nvme_uring_cmd_io(struct nvme_ctrl 
>>>>> *ctrl, struct nvme_ns *ns,
>>>>>      pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
>>>>>      pdu->meta_len = d.metadata_len;
>>>>> +    if (issue_flags & IO_URING_F_MPATH) {
>>>>> +        req->cmd_flags |= REQ_NVME_MPATH;
>>>>> +        /*
>>>>> +         * we would need the buffer address (d.addr field) if we have
>>>>> +         * to retry the command. Store it by repurposing ioucmd->cmd
>>>>> +         */
>>>>> +        ioucmd->cmd = (void *)d.addr;
>>>>
>>>> What does repurposing mean here?
>>>
>>> This field (ioucmd->cmd) was pointing to passthrough command (which
>>> is embedded in SQE of io_uring). At this point we have consumed
>>> passthrough command, so this field can be reused if we have to. And we
>>> have to beceause failover needs recreating passthrough command.
>>> Please see nvme_uring_cmd_io_retry to see how this helps in recreating
>>> the fields of passthrough command. And more on this below.
>>
>> so ioucmd->cmd starts as an nvme_uring_cmd pointer and continues as
>> an address of buffer for a later processing that may or may not
>> happen in its lifetime?
> 
> Yes. See this as a no-cost way to handle fast/common path. We manage by
> doing just this assignment.
> Otherwise this would have involved doing high-cost (allocate/copy/deferral)
> stuff for later processing that may or may not happen.

I see it as a hacky no-cost way...

> 
>> Sounds a bit of a backwards design to me.
>>
>>>>> +    }
>>>>>      blk_execute_rq_nowait(req, false);
>>>>>      return -EIOCBQUEUED;
>>>>>  }
>>>>> @@ -665,12 +667,135 @@ int nvme_ns_head_chr_uring_cmd(struct 
>>>>> io_uring_cmd *ioucmd,
>>>>>      int srcu_idx = srcu_read_lock(&head->srcu);
>>>>>      struct nvme_ns *ns = nvme_find_path(head);
>>>>>      int ret = -EINVAL;
>>>>> +    struct device *dev = &head->cdev_device;
>>>>> +
>>>>> +    if (likely(ns)) {
>>>>> +        ret = nvme_ns_uring_cmd(ns, ioucmd,
>>>>> +                issue_flags | IO_URING_F_MPATH);
>>>>> +    } else if (nvme_available_path(head)) {
>>>>> +        struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>>>>> +        struct nvme_uring_cmd *payload = NULL;
>>>>> +
>>>>> +        dev_warn_ratelimited(dev, "no usable path - requeuing 
>>>>> I/O\n");
>>>>> +        /*
>>>>> +         * We may requeue two kinds of uring commands:
>>>>> +         * 1. command failed post submission. pdu->req will be 
>>>>> non-null
>>>>> +         * for this
>>>>> +         * 2. command that could not be submitted because path was 
>>>>> not
>>>>> +         * available. For this pdu->req is set to NULL.
>>>>> +         */
>>>>> +        pdu->req = NULL;
>>>>
>>>> Relying on a pointer does not sound like a good idea to me.
>>>> But why do you care at all where did this command came from?
>>>> This code should not concern itself what happened prior to this
>>>> execution.
>>> Required, please see nvme_uring_cmd_io_retry. And this should be more
>>> clear as part of responses to your other questions.
>>
>> I think I understand. But it looks fragile to me.
>>
>>>
>>>>> +        /*
>>>>> +         * passthrough command will not be available during retry 
>>>>> as it
>>>>> +         * is embedded in io_uring's SQE. Hence we allocate/copy here
>>>>> +         */
>>>>
>>>> OK, that is a nice solution.
>>> Please note that prefered way is to recreate the passthrough command,
>>> and not to allocate it. We allocate it here because this happens very 
>>> early
>>> (i.e. before processing passthrough command and setting that up inside
>>> struct request). Recreating requires a populated 'struct request' .
>>
>> I think that once a driver consumes a command as queued, it needs a
>> stable copy of the command (could be in a percpu pool).
>>
>> The current design of nvme multipathing is that the request is stripped
>> from its bios and placed on a requeue_list, and if a request was not
>> formed yet (i.e. nvme available path exist but no usable) the bio is
>> placed on the requeue_list.
>>
>> So ideally we have something sufficient like a bio, that can be linked
>> on a requeue list, and is sufficient to build a request, at any point in
>> time...
> 
> we could be dealing with any passthrough command here. bio is not
> guranteed to exist in first place. It can very well be NULL.
> As I mentioned in cover letter, this was tested for such passthrough
> commands too.
> And bio is not a good fit for this interface. For block-path, entry
> function is nvme_ns_head_submit_bio() which speaks bio. Request is
> allocated afterwards. But since request formation can happen only after
> discovering a valid path, it may have to queue the bio if path does not
> exist.
> For passthrough, interface speaks/understands struct io_uring_cmd.
> Request is allocated after. And bio may (or may not) be attached with
> this request. It may have to queue the command even before request/bio
> gets formed. So cardinal structure (which is
> really available all the time) in this case is struct io_uring_cmd.
> Hence we use that as the object around which requeuing/failover is
> built.
> Conceptually io_uring_cmd is the bio of this interface.

I didn't say bio, I said something like a bio that holds stable
information that could be used for requeue purposes...

> 
>>>>> +        payload = kmalloc(sizeof(struct nvme_uring_cmd), GFP_KERNEL);
>>>>> +        if (!payload) {
>>>>> +            ret = -ENOMEM;
>>>>> +            goto out_unlock;
>>>>> +        }
>>>>> +        memcpy(payload, ioucmd->cmd, sizeof(struct nvme_uring_cmd));
>>>>> +        ioucmd->cmd = payload;
>>>>> -    if (ns)
>>>>> -        ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
>>>>> +        spin_lock_irq(&head->requeue_ioucmd_lock);
>>>>> +        ioucmd_list_add(&head->requeue_ioucmd_list, ioucmd);
>>>>> +        spin_unlock_irq(&head->requeue_ioucmd_lock);
>>>>> +        ret = -EIOCBQUEUED;
>>>>> +    } else {
>>>>> +        dev_warn_ratelimited(dev, "no available path - failing 
>>>>> I/O\n");
>>>>
>>>> ret=-EIO ?
>>> Did not do as it was initialized to -EINVAL. Do you prefer -EIO instead.
>>
>> It is not an invalid argument error here, it is essentially an IO error.
>> So yes, that would be my preference.
> 
> sure, will change.
> 
>>>>> +    }
>>>>> +out_unlock:
>>>>>      srcu_read_unlock(&head->srcu, srcu_idx);
>>>>>      return ret;
>>>>>  }
>>>>> +
>>>>> +int nvme_uring_cmd_io_retry(struct nvme_ns *ns, struct request *oreq,
>>>>> +        struct io_uring_cmd *ioucmd, struct nvme_uring_cmd_pdu *pdu)
>>>>> +{
>>>>> +    struct nvme_ctrl *ctrl = ns->ctrl;
>>>>> +    struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
>>>>> +    struct nvme_uring_data d;
>>>>> +    struct nvme_command c;
>>>>> +    struct request *req;
>>>>> +    struct bio *obio = oreq->bio;
>>>>> +    void *meta = NULL;
>>>>> +
>>>>> +    memcpy(&c, nvme_req(oreq)->cmd, sizeof(struct nvme_command));
>>>>> +    d.metadata = (__u64)pdu->meta_buffer;
>>>>> +    d.metadata_len = pdu->meta_len;
>>>>> +    d.timeout_ms = oreq->timeout;
>>>>> +    d.addr = (__u64)ioucmd->cmd;
>>>>> +    if (obio) {
>>>>> +        d.data_len = obio->bi_iter.bi_size;
>>>>> +        blk_rq_unmap_user(obio);
>>>>> +    } else {
>>>>> +        d.data_len = 0;
>>>>> +    }
>>>>> +    blk_mq_free_request(oreq);
>>>>
>>>> The way I would do this that in nvme_ioucmd_failover_req (or in the
>>>> retry driven from command retriable failure) I would do the above,
>>>> requeue it and kick the requeue work, to go over the requeue_list and
>>>> just execute them again. Not sure why you even need an explicit retry
>>>> code.
>>> During retry we need passthrough command. But passthrough command is not
>>> stable (i.e. valid only during first submission). We can make it stable
>>> either by:
>>> (a) allocating in nvme (b) return -EAGAIN to io_uring, and it will do 
>>> allocate + deferral
>>> Both add a cost. And since any command can potentially fail, that
>>> means taking that cost for every IO that we issue on mpath node. Even if
>>> no failure (initial or subsquent after IO) occcured.
>>
>> As mentioned, I think that if a driver consumes a command as queued,
>> it needs a stable copy for a later reformation of the request for
>> failover purposes.
> 
> So what do you propose to make that stable?
> As I mentioned earlier, stable copy requires allocating/copying in fast
> path. And for a condition (failover) that may not even occur.
> I really think currrent solution is much better as it does not try to make
> it stable. Rather it assembles pieces of passthrough command if retry
> (which is rare) happens.

Well, I can understand that io_uring_cmd is space constrained, otherwise
we wouldn't be having this discussion. However io_kiocb is less
constrained, and could be used as a context to hold such a space.

Even if it is undesired to have io_kiocb be passed to uring_cmd(), it
can still hold a driver specific space paired with a helper to obtain it
(i.e. something like io_uring_cmd_to_driver_ctx(ioucmd) ). Then if the
space is pre-allocated it is only a small memory copy for a stable copy
that would allow a saner failover design.

>>> So to avoid commmon-path cost, we go about doing nothing (no allocation,
>>> no deferral) in the outset and choose to recreate the passthrough
>>> command if failure occured. Hope this explains the purpose of
>>> nvme_uring_cmd_io_retry?
>>
>> I think it does, but I'm still having a hard time with it...
>>
> Maybe I am reiterating but few main differences that should help -
> 
> - io_uring_cmd is at the forefront, and bio/request as secondary
> objects. Former is persistent object across requeue attempts and the
> only thing available when we discover the path, while other two are
> created every time we retry.
> 
> - Receiving bio from upper layer is a luxury that we do not have for
>   passthrough. When we receive bio, pages are already mapped and we
>   do not have to deal with user-specific fields, so there is more
>   freedom in using arbitrary context (workers etc.). But passthrough
>   command continues to point to user-space fields/buffers, so we need
>   that task context.
> 
>>>
>>>>> +    req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(d.addr),
>>>>> +            d.data_len, nvme_to_user_ptr(d.metadata),
>>>>> +            d.metadata_len, 0, &meta, d.timeout_ms ?
>>>>> +            msecs_to_jiffies(d.timeout_ms) : 0,
>>>>> +            ioucmd->cmd_op == NVME_URING_CMD_IO_VEC, 0, 0);
>>>>> +    if (IS_ERR(req))
>>>>> +        return PTR_ERR(req);
>>>>> +
>>>>> +    req->end_io = nvme_uring_cmd_end_io;
>>>>> +    req->end_io_data = ioucmd;
>>>>> +    pdu->bio = req->bio;
>>>>> +    pdu->meta = meta;
>>>>> +    req->cmd_flags |= REQ_NVME_MPATH;
>>>>> +    blk_execute_rq_nowait(req, false);
>>>>> +    return -EIOCBQUEUED;
>>>>> +}
>>>>> +
>>>>> +void nvme_ioucmd_mpath_retry(struct io_uring_cmd *ioucmd)
>>>>> +{
>>>>> +    struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>>>> +    struct nvme_ns_head *head = container_of(cdev, struct 
>>>>> nvme_ns_head,
>>>>> +            cdev);
>>>>> +    int srcu_idx = srcu_read_lock(&head->srcu);
>>>>> +    struct nvme_ns *ns = nvme_find_path(head);
>>>>> +    unsigned int issue_flags = IO_URING_F_SQE128 | IO_URING_F_CQE32 |
>>>>> +        IO_URING_F_MPATH;
>>>>> +    struct device *dev = &head->cdev_device;
>>>>> +
>>>>> +    if (likely(ns)) {
>>>>> +        struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>>>>> +        struct request *oreq = pdu->req;
>>>>> +        int ret;
>>>>> +
>>>>> +        if (oreq == NULL) {
>>>>> +            /*
>>>>> +             * this was not submitted (to device) earlier. For this
>>>>> +             * ioucmd->cmd points to persistent memory. Free that
>>>>> +             * up post submission
>>>>> +             */
>>>>> +            const void *cmd = ioucmd->cmd;
>>>>> +
>>>>> +            ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
>>>>> +            kfree(cmd);
>>>>> +        } else {
>>>>> +            /*
>>>>> +             * this was submitted (to device) earlier. Use old
>>>>> +             * request, bio (if it exists) and nvme-pdu to recreate
>>>>> +             * the command for the discovered path
>>>>> +             */
>>>>> +            ret = nvme_uring_cmd_io_retry(ns, oreq, ioucmd, pdu);
>>>>
>>>> Why is this needed? Why is reuse important here? Why not always call
>>>> nvme_ns_uring_cmd?
>>>
>>> Please see the previous explanation.
>>> If condition is for the case when we made the passthrough command stable
>>> by allocating beforehand.
>>> Else is for the case when we avoided taking that cost.
>>
>> The current design of the multipath failover code is clean:
>> 1. extract bio(s) from request
>> 2. link in requeue_list
>> 3. schedule requeue_work that,
>> 3.1 takes bios 1-by-1, and submits them again (exactly the same way)
> 
> It is really clean, and fits really well with bio based entry interface.
> But as I said earlier, it does not go well with uring-cmd based entry
> interface, and bunch of of other things which needs to be done
> differently for generic passthrough command.
> 
>> I'd like us to try to follow the same design where retry is
>> literally "do the exact same thing, again". That would eliminate
>> two submission paths that do the same thing, but slightly different.
> 
> Exact same thing is possible if we make the common path slow i.e.
> allocate/copy passthrough command and keep it alive until completion.
> But that is really not the way to go I suppose.

I'm not sure. With Christoph's response, I'm not sure it is
universally desired to support failover (in my opinion it should). But
if we do in fact choose to support it, I think we need a better
solution. If fast-path allocation is your prime concern, then let's try
to address that with space pre-allocation.

