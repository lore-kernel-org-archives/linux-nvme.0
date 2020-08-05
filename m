Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0194C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:35:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5622245C
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQNd7DZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5622245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e4oQd1hlY3FKCBvxlMYFBNlW51LI43pt5SJDxXGHwpw=; b=bQNd7DZwkdVtRwwkEHCGPy/DV
	YPy8AXTAS25ceKR2q3xmvvtGBboopW4S8FWLG0f3L/eMDa27wbTIcLqNLhdMtyiRYMs3GEwza1hq2
	rVZIF69TKggwEdnS4xhiShk8C/xXpK3rRX3pb3Zsh/4fHssNvStBcrF8SrLD1o76AgAk2DP0AkwBW
	ev3FhPHI0DqQY9owPcoIg3TkkqyZnTY4quvRLHpMEli8vrO136uz3TRoI0mS/nlwpSLNRPDqlToU4
	Geu85XimepCE5svK14IHuto/mVMk0Ma14MYy6B+3T5CYQqWT/oYzbeL1ENWLR3PrsZzNmZwkEJ6gA
	T9PNbA7yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Dxd-00025D-2j; Wed, 05 Aug 2020 07:35:41 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Dxa-00023g-0T
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:35:38 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9B2418884F1F741EF698;
 Wed,  5 Aug 2020 15:35:31 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 5 Aug 2020 15:35:28 +0800
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, James Smart
 <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
 <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
 <7250e072-c0f8-430e-3afe-d0837efe14ad@grimberg.me>
 <7a05ff5c-9ad6-786a-b1a6-9556d520f436@huawei.com>
 <ae787cff-f1a3-b464-f471-18b3d736c381@grimberg.me>
 <537c387f-61e2-77f4-a7ee-55689270bdfd@huawei.com>
 <77794f62-2d4a-d2c9-f474-4ddbb361a308@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <60ced5bb-3169-d9fc-4505-6032107d45a3@huawei.com>
Date: Wed, 5 Aug 2020 15:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <77794f62-2d4a-d2c9-f474-4ddbb361a308@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_033538_327528_40982B28 
X-CRM114-Status: GOOD (  15.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/5 15:19, Sagi Grimberg wrote:
> 
>>>>> The request being timed out cannot be completed after the queue is
>>>>> stopped, that is the point of nvme_rdma_stop_queue. if it is only
>>>>> ALLOCATED, we did not yet connect hence there is zero chance for
>>>>> any command to complete.
>>>> The request may already complete before stop queue, it is in the cq, but
>>>> is not treated by software.
>>>
>>> Not possible, ib_drain_cq completion guarantees that all cqes were
>>> reaped and handled by SW.
>>>
>>>> If nvme_rdma_stop_queue concurrent
>>>
>>> Before we complete we make sure the queue is stopped (and drained and
>>> reaped).
>>>
>>> , for
>>>> example:
>>>> The error recovery run first, it will clear the flag:NVME_RDMA_Q_LIVE,
>>>> and then wait drain cq. At the same time nvme_rdma_timeout
>>>> call nvme_rdma_stop_queue will return immediately, and then may call
>>>> blk_mq_complete_request. but error recovery may drain cq at the same
>>>> time, and may also treat the same request.
>>>
>>> We flush the err_work before running nvme_rdma_stop_queue exactly
>>> because of that. your example cannot happen.
>> Flush work is not safe. See my previous email.
> 
> How is it not safe? when flush_work returns, the work is guaranteed
> to have finished execution, and we only do that for states
> RESETTING/CONNECTING which means that it either has already started
> or already finished.

Though the state is NVME_CTRL_RESETTING, but it does not mean the work
is already queued(started) or finished. There is a hole between Change state
and queue work.

Like this:
static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
{
     if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
         return;
--------------------------------
may interrupt by hard interrupt, and then timeout progress flush work
at this time. Thus error recovery and nvme_rdma_complete_timed_out may
concurrent to stop queue. will cause: error recovery may cancel request
or nvme_rdma_complete_timed_out may complete request, but the queue may
not be stoped. Thus will cause abnormal.
--------------------------------
     queue_work(nvme_reset_wq, &ctrl->err_work);
}

Another, although the probability of occurrence is very low, reset work
and nvme_rdma_complete_timed_out may also concurrent to stop queue, may
also cause abnormal.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
