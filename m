Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE05C432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 22:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D6060FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 22:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08D6060FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QLntMKwY1az90n9Hxx+WiXRtUJ7njXKI/w9SOYaQl78=; b=QEdVW1fzYjejDi/u2yta/tAh1f
	IZF+39z4qsp18jiMzPrJi6Qw4quk//I4oG4PXiUCMKj3D6lQgVlMlAdDmYBmT5d+pmreU8x/R7Gr+
	NJE6SraqSD+Uyx9OK2Fwdi2d4zGwhkQDohEm4UZKx1dJreUpmUpoDgGzdlINJ/gjVkaKIaNTd9N6V
	iHwzSpU0qF/x8iC3db4gReqKKNUBAbRw5jgdkUOY09g2LrlXCwAEXwHwxSz+VtA/15V7BnGrQeoYQ
	UbPYeW5b4JJVuJQTokuq5cMRuTpfFH66u3+7PcmZyIdq7Y5x7vJ1iFq8ZV6y+qEQaCBdgmZj50yoT
	gcrn/Lvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLCX7-003K9c-DU; Tue, 31 Aug 2021 22:47:09 +0000
Received: from mxout.security-mail.net ([85.31.212.42]
 helo=fx302.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLCWy-003K9A-Uz
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 22:47:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx302.security-mail.net (Postfix) with ESMTP id D82C43D3B06B
 for <linux-nvme@lists.infradead.org>; Wed,  1 Sep 2021 00:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1630450013;
 bh=iyK5M5udoLjZjqyEs23TkPTYvCmj6tf08b4skpzkM/o=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=Pcsd5rnaBtZIK+LGF9SUM/hj8k+ictN913DiFG5bwwmjSC/y5ZBGPWnFy60NPtU2I
 62cKBOUhoySAfgEUKryNvcA4yT2MFQQ6P7jW5VO+iTyVv2NnmtlYYlMOcPLjUb4Jr3
 Rhi2a8A9uII53QP3J7WnEIXwe11dv/GkAQ7K3lHc=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 883813D3B078; Wed,  1 Sep 2021 00:46:53 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 0FA4D3D3B06B; Wed,  1 Sep
 2021 00:46:53 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id E99F827E02EE; Wed,  1 Sep 2021
 00:46:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id CE28E27E02EB; Wed,  1 Sep 2021 00:46:52 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 66SsGszYwN3X; Wed,  1 Sep 2021 00:46:52 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id B80BA27E02E8; Wed,  1 Sep 2021
 00:46:52 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <b18d.612eb15d.ef05.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu CE28E27E02EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1630450012;
 bh=8JUpniNTfUlM8pcogh9iTFdkNu8DgpWZLf8q6CJ2Xzc=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=s7oTj8AeB0YEYBXHNVh3mh5SLiUgo0B/rVcF2c0hgHLClzijJO0rVtX2xwK3BGnIp
 LHc6FYRdvlx5ktwo2N6lEARXVYYKFCn485tgQjDdxMIIS3p3K1AjxZ8HCyC5XLToH6
 nQw4guLs2HmqEFCh7H7YDJBqc/nV4ZjMJ+BZcVWAITu2+Yth4/iL56NXInOGq+Cv9w
 ImOpA98ph49RZ7NY39M9x0qOYFEsPcDjtKLa8ueOzju7DNxKdabe7m2oEFFz/xltsU
 upNIZHuPISR8yj9KWLAMMBj5GlmtcHEjzdDg/FhBnp9TLX1kyubibVRGzbIZDRCMQ2
 YOUpsZzibgBQA==
Date: Wed, 1 Sep 2021 00:46:52 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
Subject: Re: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Topic: Command timeouts with NVMe TCP kernel driver
Thread-Index: AbCnsJ1Ok+6SmkUOJZoQxTrOr7vU6Q==
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210831_154701_250356_8B181A12 
X-CRM114-Status: GOOD (  36.19  )
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

> On Mon, Aug 30, 2021 at 03:30:29PM +0200, Samuel Jones wrote:
>> Hi all,
>> 
>> I'm experiencing command timeouts with recent versions of nvme-tcp driver. I
>> have set up with a VM running 5.8 which is ok, but the same test load (100%RD
>> 16K blocks) on a VM 5.11 or later, including 5.14-rc7, shows the same issue.
>> The initatior complains as follows:
>> 
>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: queue 7: timeout request 0x10 type 4
>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: starting error recovery
>> 
>> My target is a Kalray target, but I have no trace of any outstanding commands
>> when this situation occurs. Quite the opposite: The Kalray board observes that
>> the initiator stops sending new requests on the queue some time before this
>> command times out.
>> 
>> I don't have any similar issues using SPDK as an initiator. I made the following
>> modification to nvme-tcp code and my problem has disappeared:
>> 
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -287,6 +287,7 @@ static inline void nvme_tcp_queue_request(struct
>> nvme_tcp_request *req,
>> * directly, otherwise queue io_work. Also, only do that if we
>> * are on the same cpu, so we don't introduce contention.
>> */
>> +#if 0
>> if (queue->io_cpu == raw_smp_processor_id() &&
>> sync && empty && mutex_trylock(&queue->send_mutex)) {
>> queue->more_requests = !last;
>> @@ -296,6 +297,9 @@ static inline void nvme_tcp_queue_request(struct
>> nvme_tcp_request *req,
>> } else if (last) {
>> queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> }
>> +#else
>> + queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> +#endif
>> }
>> 
>> To be honest, this bit of code has always bothered me: I don't understand how we
>> can guarantee that the thread doesn't change CPU between the call to
>> raw_smp_processor_id() and the trylock. I assume that even if this does occur,
>> the fact that we hold queue->send_mutex() is supposed to make sure that there
>> are no atomicity issues, but I'm concerned about the logic that tries to
>> determine if there is any more pending work and reschedule io_work if and only
>> if there is something to do. I can't pinpoint an issue from just reading the
>> code though..
>> 
>> Does anyone have any thoughts on this? Is my patch proof that there is an issue
>> in this code, or am I likely to be changing the program flow so significantly
>> that we can't conclude? Are there any open issues wrt command timeouts at the
>> moment?
> 
> I've seen similar, but I thought we'd fixed all those issues. Your poc
> patch indicates to me that there is still at least another condition
> that's not being considered. I don't think the possibility of CPU
> rescheduling is the culprit, though.
> 
> One thing that looks problematic is if 'bd.last' is true but
> nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
> sequence. That could cause the io_work to never kick. There should have
> been something else in dmesg indicating that error, though, so I'll look
> for some other possibility.
> 

Thanks for your help on this Keith. I think I have a better idea about what is happening now. First of all, I have a large number of devices exposed over NVMe-TCP: I'm connecting to 4 remote NVMe devices each of which is multi-namespace, so I have a total of 37 block devices at once. Then I run a userspace benchmark that's running 8 threads per block device and generating IO to each of them. I'm not sure how the multi queue block devices are layered over the X NVMe queues per device, but however it works my system is on its knees. I have been timestamping the time spent by NVMe-TCP threads inside kernel_sendpage() within nvme_tcp_try_send_cmd_pdu() when called from nvme_tcp_queue_rq() and I'm getting some ridiculous outliers : up to 60 seconds. I am confident this is what is responsible for my timeouts. If I increase the nvme_io_timeout to 300 seconds, my test case passes.

What's interesting is my quick patch that removed the direct call to kernel_sendpage via queue_rq() makes the system behave much better: no more outliers and no timeouts. I don't know much about the kernel network stack or the block device layer but I imagine that the difference is due to the number of calls into the network stack that can happen in parallel. Is queue_rq executed from the context of the userspace caller? In this case I will have close to 300 threads active on this code path. Whereas when we go through the workqueue, I guess we have only N max calls into the network stack at once, where N = the number of CPUs on the system? 

What do you think? Does my analysis make any sense?
Thanks
Sam





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
