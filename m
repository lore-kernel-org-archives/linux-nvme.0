Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446ACF887E
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8I7mmv54y6JvknsZlXmakN7LmWd4QLACuWeWjDe8c0=; b=T59pEIQUJV9atvWfH39sCrVFNB
	/wICGuRgQGyeeHijGtqfAUCP498b2McKom7n7wjyAqPEqStXNJh2tXon1Bq9UwSfxoAMZf+Q8ifkZ
	f3iGxjF7ugXxGrG1aoojFPpU35zTlYWHPXG3mwebnLinBz3Q8UHhT/LLhEVrtkOoGIIBhD2+0NAPY
	CqO55nPrrq5Lix5Yym8b/vgCZWGwDYYxgP1Bm5OS+tSu+3fkMQIWLPRqPTTqyTOcSiS+usLfnuIzl
	FOR8AlNnzd3roV4cSt6T1n7bPjARQitvJqCF/M5pbPlVBHuIclkrODPZoNTzPvtZKezoj0RlxXjji
	5A6FNydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx6PV-0000000FVjA-2Vaf;
	Sat, 05 Oct 2024 15:09:33 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx6PQ-0000000FVhj-3D4R
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 15:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728140964; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C8I7mmv54y6JvknsZlXmakN7LmWd4QLACuWeWjDe8c0=;
	b=FHLGkWT/1mJYldiDvAbwg1BAjKidxKAj4pBnGa8/GJIWDqONk6Ncp6JGWzU5rnAelzFCXKMPls6a/1DaXZDR//sTBol6IOPwVLSQ9yNMo/GTpaKGIndPk0hxsn4ZvaDNGNaYnLllSBrdCDCYUqAKxtBY+bFaN3bHL+dqX5Mx55M=
Received: from 30.13.166.245(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGHjmy2_1728140960)
          by smtp.aliyun-inc.com;
          Sat, 05 Oct 2024 23:09:21 +0800
Message-ID: <3fedef45-0714-4d5e-b256-60c5b7a65914@linux.alibaba.com>
Date: Sat, 5 Oct 2024 23:09:20 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20240929031410.31281-1-kanie@linux.alibaba.com>
 <20240929031410.31281-2-kanie@linux.alibaba.com>
 <20241002080943.GA21262@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241002080943.GA21262@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_080930_298089_B15F8212 
X-CRM114-Status: GOOD (  26.25  )
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


在 2024/10/2 16:09, Christoph Hellwig 写道:
> On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
>> This patch implements the reservation feature, includes:
>> 1. reservation register(register, unregister and replace).
>> 2. reservation acquire(acquire, preempt, preempt and abort).
>> 3. reservation release(release and clear).
>> 4. reservation report.
>> 5. set feature and get feature of reservation notify mask.
>> 6. get log page of reservation event.
>>
>> And also make reservation configurable, one can set ns to support
>> reservation before enable ns. The default of resv_enable is false.
> The explanation feels a bit sparse.  It could also mentioned that
> no support for persistent reservation exists, and how this code
> was tested.
I will add more detail in commit in v12.
>
> Also, do you have a corresponding nvmetcli patch?
Sure, I think so.
>> +struct nvmet_pr_register_data {
>> +	__le64	crkey;
>> +	__le64	nrkey;
>> +};
>> +
>> +struct nvmet_pr_acquire_data {
>> +	__le64	crkey;
>> +	__le64	prkey;
>> +};
>> +
>> +struct nvmet_pr_release_data {
>> +	__le64	crkey;
>> +};
> Using little endian fields for purely in-memory data feels strange.
> Is there a good reason for this?
>
I use nvmet_copy_from_sgl to obtain the command's detail, just like

nvme_dsm_range, maybe I can put them in to include/linux/nvme.h.

>> +static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
>> +				    struct nvmet_pr_registrant *reg,
>> +				    void (*change_attr)(struct nvmet_pr_registrant *reg,
>> +					void *attr),
>> +				    void *attr)
> Please avoid the overly long line here.  That's easiest done by
> following the style used elsewhere in the nvme code using two
> tab continuations:
>
> static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
> 		struct nvmet_pr_registrant *reg,
> 		void (*change_attr)(struct nvmet_pr_registrant *reg,
> 				void *attr),
> 		void *attr)
OK.
>> +	change_attr(new, attr);
>> +	list_replace_rcu(&holder->entry, &new->entry);
>> +	rcu_assign_pointer(pr->holder, new);
>> +	synchronize_rcu();
>> +	kfree(holder);
> Does this really need a full blown expensive synchronize_rcu vs just a
> cheaper kfree_rcu_mightsleep or kfree_rcu?
Yes, I will use kfree_rcu instead.
>> +	bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing key, bit 03 */
> Overly long line.  This might also benefit from adding symbolic constants
> and/or extraction helpers.
OK.
>
> The explicit cast to bool should also not be needed.
>
OK.
>> +	struct nvmet_pr_registrant *reg, *tmp;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	LIST_HEAD(free_list);
>> +
>> +	lockdep_assert_held(&pr->pr_lock);
>> +
>> +	rcu_assign_pointer(pr->holder, NULL);
>> +
>> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +		list_del_rcu(&reg->entry);
>> +		if (!uuid_equal(&req->sq->ctrl->hostid, &reg->hostid))
>> +			nvmet_pr_resv_preempted(pr, &reg->hostid);
>> +		list_add(&reg->entry, &free_list);
>> +	}
>> +	synchronize_rcu();
>> +	list_for_each_entry_safe(reg, tmp, &free_list, entry) {
>> +		kfree(reg);
>> +	}
> No nee for the outer braces here.  But why do we we need the expensive
> synchronize_rcu and two-step operation here anyway vs just using
> kfree_rcu?
Sure.
>> +		/*
>> +		 * Dynamic controller, set cntlid to 0xffff.
>> +		 */
>> +		ctrl_eds->cntlid = 0xffff;
> NVME_CNTLID_DYNAMIC
>
OK, will be changed in v12.
>> +	req->pc_ref = xa_load(&req->ns->pr_per_ctrl_refs, req->sq->ctrl->cntlid);
> Overly long line.
Changed.
>
>> +	if (unlikely(!percpu_ref_tryget_live(&req->pc_ref->ref)))
>> +		return NVME_SC_INTERNAL;
>> +	return NVME_SC_SUCCESS;
>> +}
>> +
>> +void nvmet_pr_put_ns_pc_ref(struct nvmet_req *req)
>> +{
>> +	if (req->pc_ref)
>> +		percpu_ref_put(&req->pc_ref->ref);
>> +}
> It would be niceto have the NULL check inline to avoid the call for
> for namespaces without reservation support.
Understood, I will change nvmet_pr_put_ns_pc_ref to inline.
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 425573202295..b1be3d313bee 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
> Please split out adding the new code points to nvme.h to a separate
> prep patch.

OK, I will split it in v12.

Best regards,

Guixin Liu


