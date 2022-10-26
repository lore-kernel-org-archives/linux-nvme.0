Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B3BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ggfne02CrrnXW0Q50m6ZZlOnYpDFTAb/Fr5+NDUToMw=; b=T4XewBgnoNQhaTpVoezJHMiv0f
	yGsgMsVPxWQmdN+8TVFkpy4OfFnsQXRsmo06bu/xfdE2uaWL+JL+YwoFct+Fc5JB7ultJ3xEEu0nO
	gvmgWlS9Go8MKh/1QhhWrHtnv53UshRrwekDCOzgbzaG6C6+oh+ueEuK2Qgpe+CQCamdoFYWLHcRj
	m2hPcgOBtGN6YwobbBRwUXCllkpMp8gQ0V9dGNhVXoNyMxB6UNVlPJtD/BZcsT4uNthTjs9rmpyUK
	1JFLVh4dP1R0X7ipVfMK0Gc5brGoUrnylmf/XzhueRWddrCxEQT4oIN23AAMeyIU6ojSCZ6CvG5lx
	T6uwH/EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfgS-009CCL-Oi; Wed, 26 Oct 2022 12:39:00 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfgQ-009CBC-6K
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:38:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id 14-20020a05600c228e00b003cf4eaef74eso176313wmf.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggfne02CrrnXW0Q50m6ZZlOnYpDFTAb/Fr5+NDUToMw=;
        b=k7Djc9abUqBGWXqivF+1FJ9hf540OSOOc5hnVPL7MKUg0A7GW1oUamizVYjUoauOXW
         kvVkxr5/PtvktBpuBBUZWQERidc3ElMZW0pp3whHnqtecXVNmuau6QtWnmVpgjzPLH7Y
         doAh3CKK7RAK5udB4qabZtSUPlkOD+Am1VxGZaajxJTk0xeRl+nX965tJi4kGlHqHdAl
         vFi/LSGranQG/gCnmVJfk4M7x7m+tEv717peP+wC9a1A3+P4gPcn9qeLmqwb6Sk6j3Vl
         zP2mGPj5EXB37zr3I19HLzJ3cojNEISr09ui6zK6UrUydfriSR95TSP/scX1SxLmPqtC
         xLlQ==
X-Gm-Message-State: ACrzQf1ggNdB4eHT5YTWAAprFySKi23nRoiRa25755XKVJrF4IUUuQIX
	pbmjtbC7FPShsfZKUIrsPkU=
X-Google-Smtp-Source: AMsMyM5JJdm4FxhN+3JK5Xp9tSivMOfE8x67SZJhjHksM7APHra9rVENyx6Ub0gKTxVz3ZDjJxyDrg==
X-Received: by 2002:a05:600c:548a:b0:3c6:fb49:4f84 with SMTP id iv10-20020a05600c548a00b003c6fb494f84mr2375132wmb.153.1666787935309;
        Wed, 26 Oct 2022 05:38:55 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c3b0800b003c6edc05159sm1750825wms.1.2022.10.26.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:38:54 -0700 (PDT)
Message-ID: <dfcff06c-f645-a80e-f96d-41bdfb81afa3@grimberg.me>
Date: Wed, 26 Oct 2022 15:38:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: bad unlock balance WARNING at nvme/045
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
 <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
 <20221026120150.luck4dinfvhrw7se@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221026120150.luck4dinfvhrw7se@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_053858_248812_B8D3C7F0 
X-CRM114-Status: GOOD (  23.82  )
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


>>>> Hello Hannes,
>>>>
>>>> I observed "WARNING: bad unlock balance detected!" at nvme/045 [1].
>>>> As the Call
>>>> Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
>>>>
>>>>      mutex_lock(&ctrl->dhchap_auth_mutex);
>>>>      list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
>>>>          mutex_unlock(&ctrl->dhchap_auth_mutex);
>>>>          flush_work(&chap->auth_work);
>>>>          __nvme_auth_reset(chap);
>>>>      }
>>>>      mutex_unlock(&ctrl->dhchap_auth_mutex);
>>>>
>>>> I tried to remove the mutex_unlock in the list iteration with a
>>>> patch [2], but
>>>> it resulted in another "WARNING: possible recursive locking
>>>> detected" [3]. I'm
>>>> not sure but cause of this WARN could be __nvme_auth_work and
>>>> nvme_dhchap_auth_work in same nvme_wq.
>>>>
>>>> Could you take a look for fix?
>>>
>>> I'm looking at the code and I think that the way the concurrent
>>> negotiations and how dhchap_auth_mutex is handled is very fragile,
>>> also why should the per-queue auth_work hold the controller-wide
>>> dhchap_auth_mutex? The only reason I see is because nvme_auth_negotiate
>>> is checking if the chap context is already queued? Why should we
>>> allow that?
>>>
>> Well; that's partially due to the internal design of linux-nvme.
>> The controller structure itself doesn't have 'queues' per se; there just is
>> a general 'ctrl' structure. So while I would have loved to have a per-queue
>> structure to hook the chap authentication into, all I have is the controller
>> structure.
>> Hence we have a controller-wide list holding all 'chap' structures for the
>> individual queues.
>> Hence the controller-wide mutex to gate list modifications.
>>
>>> I'd suggest to splice dhchap_auth_list, to a local list and then just
>>> flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.
>>> And we should prevent for the double-queuing of chap negotiations to
>>> begin with, instead of handling them (I still don't understand why this
>>> is permitted, but perhaps just return EBUSY in this case?)
>>
>> We don't double queue; we're re-using the existing entries.
> 
> Hannes, thanks for the explanations.
> 
>>
>> Can you check if this fix works?
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index c8a6db7c4498..4e824aab30eb 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
>>
>>          mutex_lock(&ctrl->dhchap_auth_mutex);
>>          list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
>> -               mutex_unlock(&ctrl->dhchap_auth_mutex);
>>                  flush_work(&chap->auth_work);
>>                  __nvme_auth_reset(chap);
>>          }
> 
> I confirmed this hunk avoids the "WARNING: bad unlock balance detected!". As far
> as I ran blktests with this change, I observe no failure in other test cases.
> 
> However, I observed another new WARN at nvme/045: "WARNING: possible recursive
> locking detected". I think it was caused by nvme_dhchap_auth_work in nvme_wq
> tried to flush another work __nvme_auth_work in the same workqueue. I created a
> patch below which creates another workqueue nvme_auth_wq for __nvme_auth_work.
> Do you think this fix approach is acceptable?

It is fine to flush work on the same workqueue, the problem is that they
share the same lock.

I think what we should do is:
1. have chap contexts in an array and not a list so we don't need
to traverse to locate a context.
2. omit the dhchap_auth_mutex as I don't see a need to protect the
array.
3. synchronize only the chap context itself, either with a lock, or
a flag, or a state (atomic).
4. get rid of long lived allocations, it is not optimizing a whole lot
imho, and right now we are reserving something like 5k per queue.
5. add one more synchronization between chap and ctrl accessing the keys

