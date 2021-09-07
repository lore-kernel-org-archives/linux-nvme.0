Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9B5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E688A6108D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E688A6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=phx7wb0uGkkiFTgXwtlQ214M4SqauiBTar919j4dIXc=; b=P8T0Mf4Oi5Xv4buGbGBtcFaGV1
	3h73kyr6h+DEXDLd5zBwA55BH/YTU5FeIsRLV81RZZ7qK7NrzxRBL9cQKQAcWlIK/MJytv83L7qpX
	7EFzoBPwPZn8TsCFhEcHYBIM/yxyB7Mv75/xnMCKgwjNn0gQ5yCucx3GOluyckdO7Ewu8NP8kxLJ1
	A4jNYZZLnjrMDQ8enaTJcVbAPWTdHIAHIFktVEJHCv7G+tx3vdb63/jRqPINyH98kI7LvGuTUkl0A
	kcWom0yuA73RI3rS54/K5R4d4mSjCUBiFo1RjHm0tC9MAoz1tKFJx7Um1yS4FvT0qtmkPV7iiiFmG
	P+3nQ0Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNX3U-0034uz-2V; Tue, 07 Sep 2021 09:06:12 +0000
Received: from smtpout30.security-mail.net ([85.31.212.37]
 helo=fx306.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNX3N-0034og-Hr
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 09:06:08 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx306.security-mail.net (Postfix) with ESMTP id DD29A3994BC
 for <linux-nvme@lists.infradead.org>; Tue,  7 Sep 2021 11:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1631005558;
 bh=a6iE5k1w+qhOBOZASB8znmJbh483i59qp0XfrPqryNk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=GQQLZ4NBiK0DG46aZvnfPIoWk5UeN+tUAKTIMFdxqIDtgF0okB1AguRnsbmHUbNxy
 bWiF/2G3UuUW6zWl5pNyrkATOVSUUd5o62PdbXmn9ZaLpw4mdLAnY0gZJ1z3/D7MKS
 inuqB+PYmsFDp7niynSZqbsxuhBOpfoI9EiGwxfo=
Received: from fx306 (localhost [127.0.0.1]) by fx306.security-mail.net
 (Postfix) with ESMTP id 9B5A939967D; Tue,  7 Sep 2021 11:05:57 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id A75AD3994EE; Tue,  7 Sep
 2021 11:05:53 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 86AA427E02DB; Tue,  7 Sep 2021
 11:05:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 6CABA27E02DA; Tue,  7 Sep 2021 11:05:53 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 U4dU53kSj4eI; Tue,  7 Sep 2021 11:05:53 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id 5344427E02D8; Tue,  7 Sep 2021
 11:05:53 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <11c4d.61372b71.a5fd2.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6CABA27E02DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1631005553;
 bh=fccvFBYQlwhtBNoDmnY+9abxlO0KCRQBFn8OvQgXx8A=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Q5RO70+ohn6OrvCm8I7fMsk+ybg/BjgwRKt1aqjdutR9grclOUeq5RiwRM/yhONf9
 VtfP1rQy21EQ54L/kpsCjFUddHUvfM/97ZhL6ZAIzgqKa/i+QPuXMyRiU4bsHRy+hY
 iet9OL9TFGxvsdTxscFX4H4kZKt58F8dFNsIirkMuvfuGNF7aNBnMhRNUikLwL+s3C
 pqcJQNCtKTAcmV+iMK+1NbzIYbuBaqadjZuo+mM+EWXJH9naMYNlZOTnEsa8lUbeeO
 aZxpJUTekBNrEYyCf4lQ1NrTa8W4B/wiZ3zsaqNqUK0L4jpqRl6qJEc2Bsf73rM+4M
 mXDufu3uzupkQ==
Date: Tue, 7 Sep 2021 11:05:53 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme
 <linux-nvme@lists.infradead.org>
Message-ID: <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
In-Reply-To: <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
Subject: Re: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Topic: Command timeouts with NVMe TCP kernel driver
Thread-Index: N0szmbk9ZmnlhcFKLXO7jCaYNd12mA==
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_020605_958424_D519B90B 
X-CRM114-Status: GOOD (  57.01  )
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

>>>> Hi all,
>>>>
>>>> I'm experiencing command timeouts with recent versions of nvme-tcp driver. I
>>>> have set up with a VM running 5.8 which is ok, but the same test load (100%RD
>>>> 16K blocks) on a VM 5.11 or later, including 5.14-rc7, shows the same issue.
>>>> The initatior complains as follows:
>>>>
>>>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: queue 7: timeout request 0x10 type 4
>>>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: starting error recovery
>>>>
>>>> My target is a Kalray target, but I have no trace of any outstanding commands
>>>> when this situation occurs. Quite the opposite: The Kalray board observes that
>>>> the initiator stops sending new requests on the queue some time before this
>>>> command times out.
>>>>
>>>> I don't have any similar issues using SPDK as an initiator. I made the following
>>>> modification to nvme-tcp code and my problem has disappeared:
>>>>
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -287,6 +287,7 @@ static inline void nvme_tcp_queue_request(struct
>>>> nvme_tcp_request *req,
>>>> * directly, otherwise queue io_work. Also, only do that if we
>>>> * are on the same cpu, so we don't introduce contention.
>>>> */
>>>> +#if 0
>>>> if (queue->io_cpu == raw_smp_processor_id() &&
>>>> sync && empty && mutex_trylock(&queue->send_mutex)) {
>>>> queue->more_requests = !last;
>>>> @@ -296,6 +297,9 @@ static inline void nvme_tcp_queue_request(struct
>>>> nvme_tcp_request *req,
>>>> } else if (last) {
>>>> queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>> }
>>>> +#else
>>>> + queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>> +#endif
>>>> }
>>>>
>>>> To be honest, this bit of code has always bothered me: I don't understand how we
>>>> can guarantee that the thread doesn't change CPU between the call to
>>>> raw_smp_processor_id() and the trylock. I assume that even if this does occur,
>>>> the fact that we hold queue->send_mutex() is supposed to make sure that there
>>>> are no atomicity issues, but I'm concerned about the logic that tries to
>>>> determine if there is any more pending work and reschedule io_work if and only
>>>> if there is something to do. I can't pinpoint an issue from just reading the
>>>> code though..
>>>>
>>>> Does anyone have any thoughts on this? Is my patch proof that there is an issue
>>>> in this code, or am I likely to be changing the program flow so significantly
>>>> that we can't conclude? Are there any open issues wrt command timeouts at the
>>>> moment?
>>>
>>> I've seen similar, but I thought we'd fixed all those issues. Your poc
>>> patch indicates to me that there is still at least another condition
>>> that's not being considered. I don't think the possibility of CPU
>>> rescheduling is the culprit, though.
>>>
>>> One thing that looks problematic is if 'bd.last' is true but
>>> nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
>>> sequence. That could cause the io_work to never kick. There should have
>>> been something else in dmesg indicating that error, though, so I'll look
>>> for some other possibility.
>>>
>> 
>> Thanks for your help on this Keith. I think I have a better idea about what is
>> happening now. First of all, I have a large number of devices exposed over
>> NVMe-TCP: I'm connecting to 4 remote NVMe devices each of which is
>> multi-namespace, so I have a total of 37 block devices at once.
> 
> That shouldn't matter really, what matters is the number of controllers
> that you have. you have 4 controllers, and how many queues are there
> per-controller? and how many cores does the VM have?
> 
>> Then I run a userspace benchmark that's running 8 threads per block device and
>> generating IO to each of them. I'm not sure how the multi queue block devices
>> are layered over the X NVMe queues per device, but however it works my system
>> is on its knees. I have been timestamping the time spent by NVMe-TCP threads
>> inside kernel_sendpage() within nvme_tcp_try_send_cmd_pdu() when called from
>> nvme_tcp_queue_rq() and I'm getting some ridiculous outliers : up to 60
>> seconds. I am confident this is what is responsible for my timeouts. If I
>> increase the nvme_io_timeout to 300 seconds, my test case passes.
> 
> That is strange indeed. what are you taking the timing on? just
> kernel_sendpage?
> 
>> What's interesting is my quick patch that removed the direct call to
>> kernel_sendpage via queue_rq() makes the system behave much better: no more
>> outliers and no timeouts. I don't know much about the kernel network stack or
>> the block device layer but I imagine that the difference is due to the number
>> of calls into the network stack that can happen in parallel. Is queue_rq
>> executed from the context of the userspace caller? In this case I will have
>> close to 300 threads active on this code path. Whereas when we go through the
>> workqueue, I guess we have only N max calls into the network stack at once,
>> where N = the number of CPUs on the system?
>> 
>> What do you think? Does my analysis make any sense?
> 
> I don't think this is related to the number of contexts you have running
> against the namespaces.
> 
> However, the difference between the submission from queue_rq and the
> workqueue is that queue_rq may happen concurrently and hence may be
> blocked by the socket mutex as the io_work does RX. Now I guess that
> if RX is intensive (and it sounds like it is in your test) that the
> TX path would be potentially starved...
> 
> But if the RX is so intensive, then I'd expect you to have timeouts
> regardless as the context is not performing sends anyways, but maybe
> this needs a bit more thought...
> 
> If this theory is correct, then a possible reason for the big delay
> inside kernel_sendpage is due to the fact that io_work just ingest as
> much as the stack gives it (which can be a lot). If we were to break
> the recvs into fixed chunks, it would allow to send between recvs and
> avoid this potential starvation.
> 
> Will it be possible to tryout this untested patch?
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 032e8d582e6d..ec05b26cee38 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -837,6 +837,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t
> *desc, struct sk_buff *skb,
>                 }
>         }
> 
> +       desc->count -= consumed;
>         return consumed;
>  }
> 
> @@ -1107,7 +1108,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue
> *queue)
>         int consumed;
> 
>         rd_desc.arg.data = queue;
> -       rd_desc.count = 1;
> +       rd_desc.count = 0x4000; /* 16k */
>         lock_sock(sk);
>         queue->nr_cqe = 0;
>         consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> --

Hi Sagi, Keith, all,

I think I have a better idea about what is happening now. First of all, answers to Sagi's questions: I have 4 controllers with 8 queues each, the VM has 16 CPUs. I was timing on kernel_sendpage. I tried your patch Sagi but it didn't make any difference. Indeed, given that the queue stops transmitting requests, I guess the RX path gets very quiet very fast.

After a lot of time spent timing various functions in kernel_sendpage, the only thing I was able to observe was that my thread is descheduled and not rescheduled again for a LONG time. I think what is happening is the following.:

1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
2. Userspace context is descheduled.
3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.

This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:

1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread

Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?

Thanks for your help
Sam





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
