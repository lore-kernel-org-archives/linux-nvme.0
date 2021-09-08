Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 21:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1779F60FDA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 21:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1779F60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8pzNeFbMYNI49mQP0pf5gcpxtFBd64aWRPIcDNFvxDY=; b=PDeIUtx+wBWPSB
	Almge9MxhuYhT/UsbDvRqdfFBbNkKxlY/HEpS0mKMSJ3zqBbJULyloSoSTLidRMMIvF8fB/2SBt01
	XrVkR7V1JVFySntR5xKPzh9jYxTBL3L2LehaxUda/hWWSa68e3YZgyCeDJpU6vOeUp+xWrNki09yY
	tZ2DolU6R0Thx51Ko4TV85pn7+IBsocBoyjGjI8Y3pnLaJfAgZHCeqrwL8KyajNGvJqa0luHqRpby
	Rtrz36h0Cpah/zYY6FsLxBGXiIjxx024/Ntv4G0ZYQKXeN9F5CHK7mdYoElgGqGD+kltudo95pqOe
	hnhNu2AA5nATCRo5c+yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mO5Sb-007dqk-A7; Wed, 08 Sep 2021 21:50:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mO5SX-007dqK-On
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 21:50:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F8C860698;
 Wed,  8 Sep 2021 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631137819;
 bh=HyPKPpZpKjrhDDjT1bd5cIc00v+S/9SCfxsRaKIZoRo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NmOAMdG7r0vHly1mwLVk6w3LIzgS0iKA4gPmhO1GmTd5kkDISQor4zKOipLRD/QUv
 bHWCfRsxAOnwwwVENrg/GUYLcib0WfhyqUdrqhV0S3GI3P8Vur+pt5qHS0vTctOGJ3
 b3FTccYF/PlpkzpZMIaF6FGvB9x2TpeYK2iurZLkeXa0xO81mlQMgJd4jA43RU9WaX
 ed4j9AjpyxiSMhJAM5zOGV130Tlsg1JZbW3I4EtngnrCTZiOYTkbencnhe74YsZElm
 LLM1aEb1lKU9b7GVW0kmKmcftfK51/o+k4tg/Y0vOm7BpRdnFwfg1/CtcbMIk7eTO5
 ogSKMmZoVcSjQ==
Date: Wed, 8 Sep 2021 14:50:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Samuel Jones <sjones@kalrayinc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Command timeouts with NVMe TCP kernel driver
Message-ID: <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_145021_919250_AC2FAC79 
X-CRM114-Status: GOOD (  44.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 08, 2021 at 11:55:59PM +0300, Sagi Grimberg wrote:
> 
> > > > 1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
> > > > 2. Userspace context is descheduled.
> > > > 3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
> > > > 4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
> > > > 5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.
> > > > 
> > > > This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:
> > > > 
> > > > 1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
> > > > 2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
> > > > 3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread
> > > > 
> > > > Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?
> > > 
> > > Sounds possible. The "pending" check on the req_list was to fix a race
> > > condition where the io_work could miss handling a request, resulting in
> > > a different command time out. It sounds like that could make the io_work
> > > spin without having anything to do, while starving the lower priority
> > > task. I'll try to think of another way to handle it.
> > 
> > Instead of relying on io_work to determine if there's pending requests,
> > the queuing action can try to re-schedule it only after the send_mutex
> > is released, and I think that should address the issue you've described
> > while still fixing the IO timeout the "pending" trick was addressing.
> > Can you try the below patch?
> > 
> > Sagi, does this look okay to you?
> 
> It looks OK to me, but on the other hand the former
> one looked perfectly fine to me. 

It's a priority inversion. The .queue_rq() task is holding onto the
'req_list' resource via send_mutex, but it can't schedule in because
io_work is higher priority and will remain in TASK_RUNNING while
'req_list' is non-empty.

I think the user must have pinned the .queue_rq task to that specific
CPU, otherwise I believe it would have scheduled somewhere else to
unblock forward progress.

> I'm trying to understand
> if we can have a race condition hiding here....
> 
> > ---
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index e2ab12f3f51c..e4249b7dc056 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -274,6 +274,12 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
> >   	} while (ret > 0);
> >   }
> > +static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> > +{
> > +	return !list_empty(&queue->send_list) ||
> > +		!llist_empty(&queue->req_list) || queue->more_requests;
> > +}
> > +
> >   static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
> >   		bool sync, bool last)
> >   {
> > @@ -294,9 +300,10 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
> >   		nvme_tcp_send_all(queue);
> >   		queue->more_requests = false;
> >   		mutex_unlock(&queue->send_mutex);
> > -	} else if (last) {
> > -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> >   	}
> > +
> > +	if (last && nvme_tcp_queue_more(queue))
> > +		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> 
> Basically now the last request in the batch will not trigger
> unconditionally (if the direct-send path was not taken), but only if it
> sees queued requests, which in theory could be reaped by a running
> io_work, that would result in an empty io_work invocation.  On one
> hand it is undesired, on the other hand should be harmless as it
> shouldn't miss an invocation... So it looks reasonable to me.

I can change the check to the same as .commit_rqs(), which just
consideres 'llist_empty(&queue->req_list))'.

That should be just as safe and have fewer unnecessary io_work
scheduling for the same reasoning commit_rqs() uses it. In any case, I
don't think an occasional unneeded work check is really that harmful.

 
> Sam, can you run some more extensive I/O testing with this (different
> patterns of r/w and block sizes)? Also Keith, can you ask the WD folks
> to also take it for a spin?

Sure, I'll request this patch for their next test cycle.

> All of these issues have a common theme, which is less I/O queues than
> CPUs for each controller which make RX/TX and queue_rq/io_work compete
> and usually controllers with smaller MDTS (that trigger multiple R2Ts
> per request and uncovered some races in this area). So testing those
> would be beneficial.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
