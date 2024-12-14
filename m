Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A0E7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pmNGRxTDxjiPW7iWhUyGrdFX5BzrcEt0Ubfqr/8RSk=; b=0rXuTiLGxJH6gJHCQlX2E513aF
	Z6yPvxj4R0ddZfQYvdWfqwKQovp9AkGaSapdPiW0k0Y2R1X6UuGO+FjRnSFVPS9brz6oLJlmOME4v
	4XfiDWICIbwQSGPXafJXH2DVhh/y3c2Kw+AFHRJxNFUYio746WhQU0ozNtf3dm7JqNp7F4B/1FuN8
	xFldWlVG4ZrtiNokdZGoiHmxASMRR3ZaNuNZeaXGbH69UDTpp8nKJfDgo0DMxSw663A5aZBQvsxy0
	6jSnfhfHIN8ghj1KTINlDqAH48ONZpVcj+Al9yjSiOoqiPeY3hnjzTbnV1m8r5yulzfqlGHejCjP/
	gs4N75Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMOZn-000000067VL-07It;
	Sat, 14 Dec 2024 09:36:43 +0000
Received: from out-188.mta1.migadu.com ([95.215.58.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMOZj-000000067Uq-49cx
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 09:36:41 +0000
Message-ID: <3678e5fd-8441-4cb3-a5db-a7a0954732c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734168996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pmNGRxTDxjiPW7iWhUyGrdFX5BzrcEt0Ubfqr/8RSk=;
	b=o4XRTfAFrZxYGv98m7fdgpKsRPF7X0P5YEO8Tut3W01ACrNXqUk51H8ktXgUwZn4bCW1OF
	PsktxJ2MvVYibrOZqHjQgCKkzGxCUcP0FvifqrfBZ7cDbuyvIE/uO2HfHzGwJb8/e5fPix
	zSOnGjxbu1R64md00uO9T1td+z6CM2U=
Date: Sat, 14 Dec 2024 10:36:31 +0100
MIME-Version: 1.0
Subject: Re: workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker
 [irdma]
To: Honggang LI <honggangli@163.com>,
 "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
References: <Z1wBEgluXUDrDJmN@fc39>
 <d6067519-26ab-4851-ba58-3ebe254e88d1@linux.dev>
 <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev> <Z1zswha52zdJcEXp@fc39>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z1zswha52zdJcEXp@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241214_013640_340468_B1124036 
X-CRM114-Status: GOOD (  13.48  )
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

在 2024/12/14 3:26, Honggang LI 写道:
> On Fri, Dec 13, 2024 at 08:30:01PM +0100, Zhu Yanjun wrote:
>> I delved into this problem. It seems that it is a known problem.
>> Can you apply the following to make tests again?
>>
>> diff --git a/drivers/infiniband/hw/irdma/hw.c
>> b/drivers/infiniband/hw/irdma/hw.c
>> index ad50b77282f8..31501ff9f282 100644
>> --- a/drivers/infiniband/hw/irdma/hw.c
>> +++ b/drivers/infiniband/hw/irdma/hw.c
>> @@ -1872,7 +1872,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
>>                   * free cq bufs
>>                   */
>>                  iwdev->cleanup_wq = alloc_workqueue("irdma-cleanup-wq",
>> -                                       WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
>> +                                       WQ_UNBOUND|WQ_MEM_RECLAIM,
> 
> After add flag WQ_MEM_RECLAIM, the warning message is gone. However,
> it may raise similar issue fixed by commit 2cc7d150550 again.
> 
> thanks
> 
> commit 2cc7d150550cc981aceedf008f5459193282425c
> Author: Sindhu Devale <sindhu.devale@intel.com>
> Date:   Tue Apr 23 11:27:17 2024 -0700
> 
>      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

I read the commit log carefully. If I understand the commit log 
correctly, the flag WQ_MEM_RECLAIM is used in i40e while it is
not used in i40iw.
The fix is to remove the flag WQ_MEM_RECLAIM from i40e.

"
     Issue reported by customer during SRIOV testing, call trace:
     When both i40e and the i40iw driver are loaded, a warning
     in check_flush_dependency is being triggered. This seems
     to be because of the i40e driver workqueue is allocated with
     the WQ_MEM_RECLAIM flag, and the i40iw one is not.

     Similar error was encountered on ice too and it was fixed by
     removing the flag. Do the same for i40e too.
"
I do not have E810 device and i40e device and can not read the issue 
reported by customer during SRIOV testing.
Thus, let Intel engineers continue to handle this problem.
@Mustafa Ismail

Zhu Yanjun

> 


