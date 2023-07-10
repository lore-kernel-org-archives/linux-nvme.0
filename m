Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC28EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 09:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+i6a+oHavZa+PsLQK+2pw+D8M7+9tF/7o7b0gNDpAs=; b=oX4rfO3UnfuojyVuKgy+Pfh00q
	vHhOIDFRuCtNHc1twGE/WTVqj23dXHBhyYyS9NCptV2z8XCA8pryBwb3ouD156SvWNp5/38tCd6dV
	B81Tl9md52VBtkPqVL7RPzAj5gbDQAzW7LBVWRNvkjNiCp///uhVdyhLcObWQW2B3i9LqFZPHseba
	UdY3uCTpTcgRg9tShXglScbnlN3ffQx8ZsYEuHYdIEVY3b/t7wCKbgkfliWwI6xDKqh8BNSve05pf
	r++nTflu/oiPAI635y+23m+gZm37qr/FvsQ2aSNTz77TWVK5byRBD7+zrJrG8E+F+Hutwm9ySR+01
	1m8dfw/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInBD-00B07Q-1N;
	Mon, 10 Jul 2023 09:27:39 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInBA-00B06I-0l
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 09:27:38 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso10386735e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 02:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981253; x=1691573253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+i6a+oHavZa+PsLQK+2pw+D8M7+9tF/7o7b0gNDpAs=;
        b=ZCWaXCCZ7DBVMS2TXTYq+gdWMu6J6lB4eCQG3OnpB2HhD6RonrRytWgCn3Iy9rZ4UG
         /1iUKXZuzYV7EHjWMy5O23uzRsC6rWmm/lpU5VDlFckQ+ynfusUUSm+TzFLJmSrn/G5g
         qCBcLRAB2QtGlniqLO0i5d1yaU2RY5fmtndYB8ZXFX8Fp3vNIRlw8ffRLNld/BB1cmbm
         uJKqpIhkBJDo0k8HxGtjEv85Tcz7wFYdr244oVodcbMcVS5y5bQ3XZ8N34glPTsqDa4M
         dEOtKj7fLRzzbLL60pcqQR+jDwXjbcePYFT/1+LYrC8UPdJHNDaOIYGhUa3Rf1wEom2G
         O5JA==
X-Gm-Message-State: ABy/qLYyx4t/eo9LatU9Poi0bGfwM+E5lWsXw5jn4DyZkMBh2Nu1pZuC
	nLrz+QldWDk4yW15/7Sr5cg=
X-Google-Smtp-Source: APBJJlELioq8M99i38IRzTh6fQ6NH2kEfqBStiEAcRTSiAObC1OcB0HKFfLHvrKMWvWq7CJpLBTW8w==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr11142215wmn.1.1688981253151;
        Mon, 10 Jul 2023 02:27:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a1ccc0d000000b003fbaa2903f4sm9682193wmb.19.2023.07.10.02.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:27:32 -0700 (PDT)
Message-ID: <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
Date: Mon, 10 Jul 2023 12:27:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_022736_279495_B3483B6C 
X-CRM114-Status: GOOD (  35.57  )
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


>>>>> I still want your patches for tcp/rdma that move the freeze.
>>>>> If you are not planning to send them, I swear I will :)
>>>>
>>>> Ming, can you please send the tcp/rdma patches that move the
>>>> freeze? As I said before, it addresses an existing issue with
>>>> requests unnecessarily blocked on a frozen queue instead of
>>>> failing over.
>>>
>>> Any chance to fix the current issue in one easy(backportable) way[1] first?
>>
>> There is, you suggested one. And I'm requesting you to send a patch for
>> it.
> 
> The patch is the one pointed by link [1], and it still can be applied on current
> linus tree.
> 
> https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/

This is separate from what I am talking about.

>>> All previous discussions on delay freeze[2] are generic, which apply on all
>>> nvme drivers, not mention this error handling difference causes extra maintain
>>> burden. I still suggest to convert all drivers in same way, and will work
>>> along the approach[1] aiming for v6.6.
>>
>> But we obviously hit a difference in expectations from different
>> drivers. In tcp/rdma there is currently an _existing_ bug, where
>> we freeze the queue on error recovery, and unfreeze only after we
>> reconnect. In the meantime, requests can be blocked on the frozen
>> request queue and not failover like they should.
>>
>> In fabrics the delta between error recovery and reconnect can (and
>> often will be) minutes or more. Hence I request that we solve _this_
>> issue which is addressed by moving the freeze to the reconnect path.
>>
>> I personally think that pci should do this as well, and at least
>> dual-ported multipath pci devices would prefer instant failover
>> than after a full reset cycle. But Keith disagrees and I am not going to
>> push for it.
>>
>> Regardless of anything we do in pci, the tcp/rdma transport
>> freeze-blocking-failover _must_ be addressed.
> 
> It is one generic issue, freeze/unfreeze has to be paired strictly
> for every driver.
> 
> For any nvme driver, the inbalance can happen when error handling
> is involved, that is why I suggest to fix the issue in one generic
> way.

Ming, you are ignoring what I'm saying. I don't care if the
freeze/unfreeze is 100% balanced or not (for the sake of this
discussion).

I'm talking about a _separate_ issue where a queue
is frozen for potentially many minutes blocking requests that
could otherwise failover.

>> So can you please submit a patch for each? Please phrase it as what
>> it is, a bug fix, so stable kernels can pick it up. And try to keep
>> it isolated to _only_ the freeze change so that it is easily
>> backportable.
> 
> The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
> recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.

Ming, this is completely separate from what I'm talking about. This one
is addressing when the controller is removed, while I'm talking about
the error-recovery and failover, which is ages before the controller is
removed.

> But as we discussed, we still want to call freeze/unfreeze in pair, and
> I also suggest the following approach[2], which isn't good to backport:
> 
> 	1) moving freeze into reset
> 	
> 	2) during resetting
> 	
> 	- freeze NS queues
> 	- unquiesce NS queues
> 	- nvme_wait_freeze()
> 	- update_nr_hw_queues
> 	- unfreeze NS queues
> 	
> 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> 	
> 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
> 	
> 	- otherwise, fail the request
> 
> 
> [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc

Ming, please read again what my concern is. I'm talking about error 
recovery freezing a queue, and unfreezing only after we reconnect,
blocking requests that should failover.

The controller removal when the request queue is frozen is a separate
issue, which we should address, but separately.

What I am requesting is that you send two patches, one for tcp and
one for rdma that are identical to what you did in:
[PATCH 2/2] nvme: don't freeze/unfreeze queues from different contexts

rdma.c patch:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..354cce8853c1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct 
nvme_rdma_ctrl *ctrl, bool new)
  		goto out_cleanup_tagset;

  	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
  		nvme_unquiesce_io_queues(&ctrl->ctrl);
  		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
  			/*
@@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct 
nvme_rdma_ctrl *ctrl, bool new)
  			 * to be safe.
  			 */
  			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
  			goto out_wait_freeze_timed_out;
  		}
  		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct 
nvme_rdma_ctrl *ctrl,
  		bool remove)
  {
  	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
  		nvme_quiesce_io_queues(&ctrl->ctrl);
  		nvme_sync_io_queues(&ctrl->ctrl);
  		nvme_rdma_stop_io_queues(ctrl);
--

tcp.c patch:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..5ae08e9cb16d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
  		goto out_cleanup_connect_q;

  	if (!new) {
+		nvme_start_freeze(ctrl);
  		nvme_unquiesce_io_queues(ctrl);
  		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
  			/*
@@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
  			 * to be safe.
  			 */
  			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
  			goto out_wait_freeze_timed_out;
  		}
  		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct 
nvme_ctrl *ctrl,
  	if (ctrl->queue_count <= 1)
  		return;
  	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
  	nvme_quiesce_io_queues(ctrl);
  	nvme_sync_io_queues(ctrl);
  	nvme_tcp_stop_io_queues(ctrl);
--

Nothing more.

