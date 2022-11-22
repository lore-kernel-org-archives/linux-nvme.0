Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1585DC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=su4lExLppv6Rxu//8H+gMwaH+VUYLFFC4wdHiMQwUBQ=; b=VKT8Frgv6Oq12molQyWIKWxUt0
	3qsdAKeB0BLFUDD1g1Hvc/oP+9sGyvqd8WTeBLNmJ+HUJcVggUZeyK9D7rGKRhAyOmW0pWrn2kHnU
	pW6pnZh+YrWES1aD6L8qrGRm+gDeFwQAj3onTtYxGBi2xxuR50fhmPHWNJg5X9JqFgo8vmang5V+G
	bk0EmNL8GA2zxc8jMrcKiebu1hKiJHiDC+8qnsu936xAcLZ2miEaVGA5jcP3FXdHBqdHjhpGsYWxZ
	rxmVLBBZgDfX+mpDlZjtrZwexiKgK+AToNSEry6hhKACfacXmR6g/0U9XBZJjXBQwfe0v3SRidWG+
	wNHU57Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxZuz-00BokH-Gc; Tue, 22 Nov 2022 20:30:57 +0000
Received: from out2.migadu.com ([188.165.223.204])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxZuu-00Boh5-G2
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 20:30:55 +0000
Message-ID: <4f3c32a5-54cf-dcba-afe2-1f08b3f48b16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1669149047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=su4lExLppv6Rxu//8H+gMwaH+VUYLFFC4wdHiMQwUBQ=;
	b=aC5vDIEsyoiFi9pCRocHFiWqyEh3pbkUkpAOEqKDkcF4fcAMu6mrQtBi52fBs0dmb4Cp++
	hzt46IjzkwWnE6Q1IdlNRRhiSqeWhk2FZcss/C7foCl3PjjXAWpwbbDQSB2XMu98dpFf/D
	DGf0V6BfPjLr6mBxLAm4UoscVXzQdlc=
Date: Tue, 22 Nov 2022 13:30:43 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
 <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
 <Y3wED5m5JHOFMMg2@kbusch-mbp> <Y3yHvg27tKo11YCF@cormorant.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <Y3yHvg27tKo11YCF@cormorant.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_123053_589602_0319A111 
X-CRM114-Status: GOOD (  18.08  )
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



On 11/22/2022 1:26 AM, Klaus Jensen wrote:
> On Nov 21 16:04, Keith Busch wrote:
>> [cc'ing Klaus]
>>
>> On Mon, Nov 21, 2022 at 03:49:45PM -0700, Jonathan Derrick wrote:
>>> On 11/21/2022 3:34 PM, Jonathan Derrick wrote:
>>>> On 11/21/2022 1:55 PM, Keith Busch wrote:
>>>>> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
>>>>>> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
>>>>>> reliably segfaults my QEMU instance (something else to look into) and I don't
>>>>>> have any 'real' hardware to test this on at the moment. It looks like several
>>>>>> passthru commands are able to enqueue prior/during/after resetting/connecting.
>>>>>
>>>>> I'm not seeing any problem with the latest nvme-qemu after several dozen
>>>>> iterations of this test case. In that environment, the formats and
>>>>> resets complete practically synchronously with the call, so everything
>>>>> proceeds quickly. Is there anything special I need to change?
>>>>>  
>>>> I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
>>> Here's a backtrace:
>>>
>>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>>> [Switching to Thread 0x7ffff7554400 (LWP 531154)]
>>> 0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
>>> 540         return sq->ctrl;
>>> (gdb) backtrace
>>> #0  0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
>>> #1  0x0000555555994360 in nvme_format_bh (opaque=0x5555579dd000) at ../hw/nvme/ctrl.c:5852
>>
>> Thanks, looks like a race between the admin queue format's bottom half,
>> and the controller reset tearing down that queue. I'll work with Klaus
>> on that qemu side (looks like a well placed qemu_bh_cancel() should do
>> it).
>>
> 
> Yuck. Bug located and quelched I think.
> 
> Jonathan, please try
> 
>   https://lore.kernel.org/qemu-devel/20221122081348.49963-2-its@irrelevant.dk/
> 
> This fixes the qemu crash, but I still see a "nvme still not live after
> 42 seconds!" resulting from the test. I'm seeing A LOT of invalid
> submission queue doorbell writes:
> 
>   pci_nvme_ub_db_wr_invalid_sq in nvme_process_db: submission queue doorbell write for nonexistent queue, sqid=0, ignoring
> 
> Tested on a 6.1-rc4.

Good change, just defers it a bit for me:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff7554400 (LWP 559269)]
0x000055555598922e in nvme_enqueue_req_completion (cq=0x0, req=0x7fffec141310) at ../hw/nvme/ctrl.c:1390
1390        assert(cq->cqid == req->sq->cqid);
(gdb) backtrace
#0  0x000055555598922e in nvme_enqueue_req_completion (cq=0x0, req=0x7fffec141310) at ../hw/nvme/ctrl.c:1390
#1  0x000055555598a7a7 in nvme_misc_cb (opaque=0x7fffec141310, ret=0) at ../hw/nvme/ctrl.c:2002
#2  0x000055555599448a in nvme_do_format (iocb=0x55555770ccd0) at ../hw/nvme/ctrl.c:5891
#3  0x00005555559942a9 in nvme_format_ns_cb (opaque=0x55555770ccd0, ret=0) at ../hw/nvme/ctrl.c:5828
#4  0x0000555555dda018 in blk_aio_complete (acb=0x7fffec1fccd0) at ../block/block-backend.c:1501
#5  0x0000555555dda2fc in blk_aio_write_entry (opaque=0x7fffec1fccd0) at ../block/block-backend.c:1568
#6  0x0000555555f506b9 in coroutine_trampoline (i0=-331119632, i1=32767) at ../util/coroutine-ucontext.c:177
#7  0x00007ffff77c84e0 in __start_context () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:91
#8  0x00007ffff4ff2bd0 in  ()
#9  0x0000000000000000 in  ()


