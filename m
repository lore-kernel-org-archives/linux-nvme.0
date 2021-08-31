Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E50C432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 02:38:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE4660FC0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 02:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DE4660FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sanz2yr5wvh9oZNjCAwTOO5GUxKPAaDJInfs/vhGz+I=; b=nGSae7G/AfW8/0
	YPZ/vykH/p5mTXh6d3cCOUfePcKWlFIlOrTKv3Mz5WOnIPrRm6AruDJmmWkYYFCu81NoFYNxa2AyL
	kKlNvQbSaVyOagHjI+ZR2GvsHR6rBS7ekSVlNpqD0F0NLw1s4+mqu73GX16Iq4gXVhE6R8GBVq+8J
	EsAQ25XennKTVa/gtFCZUNYfPosRMURU0ZqivNvnBC9DKo1szSEsfAHNAOYRUEhbIE+69UgrTSyq4
	V1i51pDq2ST6JGMVG8SpefFUOHwfqbROWTjG+lTtbLFZvn9Sjhha5dLNX+B8qkY2wfvehlTv8XRWJ
	aZ3H1r0iBdlUOrDelb2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKteJ-0010iT-El; Tue, 31 Aug 2021 02:37:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKteF-0010hk-TB
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 02:37:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D4E60FC0;
 Tue, 31 Aug 2021 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630377435;
 bh=rTbdASWQwApMWwxpySMPE3c4KvMiNeqNOHAnJGmKmJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lEVw0UBRkb+1K9741qe4W2M43Y9/3+W76IpjjlFZK3GF0oFiPToPOwkn+pWSMQKoD
 VdeWjUl3gXc5eRlEBWPbcLgkMdBwn36feXdKZt+1mhYScqgror5lWYQOjL//Hp9yJp
 48yeg0xQBRwTuPlq9mghMAy7Igo2ZIebaVLqFJ+O2iZ3Bdv9/AKbTnRflFlBJXk/+E
 14bpxjCr53aZojmAbRKzuQPecyC432i950OYChhadjBfzISl6tZ9L5QUhh6ySDVTJp
 SOKd52xsABvZ4/gTSZSak/K6dQG6hLbvjyKYbkgZpPfYAt6Vy/bpD3MgRricUHQAXJ
 5aBqhcGjjnlHQ==
Date: Mon, 30 Aug 2021 19:37:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Samuel Jones <sjones@kalrayinc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Command timeouts with NVMe TCP kernel driver
Message-ID: <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_193716_018769_CCDE587C 
X-CRM114-Status: GOOD (  31.21  )
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

On Mon, Aug 30, 2021 at 03:30:29PM +0200, Samuel Jones wrote:
> Hi all, 
> 
> I'm experiencing command timeouts with recent versions of nvme-tcp driver. I have set up with a VM running 5.8 which is ok, but the same test load (100%RD 16K blocks) on a VM 5.11 or later, including 5.14-rc7, shows the same issue. The initatior complains as follows: 
> 
> Aug 30 14:58:05 centos7 kernel: nvme nvme0: queue 7: timeout request 0x10 type 4 
> Aug 30 14:58:05 centos7 kernel: nvme nvme0: starting error recovery 
> 
> My target is a Kalray target, but I have no trace of any outstanding commands when this situation occurs. Quite the opposite: The Kalray board observes that the initiator stops sending new requests on the queue some time before this command times out. 
> 
> I don't have any similar issues using SPDK as an initiator. I made the following modification to nvme-tcp code and my problem has disappeared: 
> 
> --- a/drivers/nvme/host/tcp.c 
> +++ b/drivers/nvme/host/tcp.c 
> @@ -287,6 +287,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req, 
> * directly, otherwise queue io_work. Also, only do that if we 
> * are on the same cpu, so we don't introduce contention. 
> */ 
> +#if 0 
> if (queue->io_cpu == raw_smp_processor_id() && 
> sync && empty && mutex_trylock(&queue->send_mutex)) { 
> queue->more_requests = !last; 
> @@ -296,6 +297,9 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req, 
> } else if (last) { 
> queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work); 
> } 
> +#else 
> + queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work); 
> +#endif 
> } 
> 
> To be honest, this bit of code has always bothered me: I don't understand how we can guarantee that the thread doesn't change CPU between the call to raw_smp_processor_id() and the trylock. I assume that even if this does occur, the fact that we hold queue->send_mutex() is supposed to make sure that there are no atomicity issues, but I'm concerned about the logic that tries to determine if there is any more pending work and reschedule io_work if and only if there is something to do. I can't pinpoint an issue from just reading the code though.. 
> 
> Does anyone have any thoughts on this? Is my patch proof that there is an issue in this code, or am I likely to be changing the program flow so significantly that we can't conclude? Are there any open issues wrt command timeouts at the moment? 

I've seen similar, but I thought we'd fixed all those issues. Your poc
patch indicates to me that there is still at least another condition
that's not being considered. I don't think the possibility of CPU
rescheduling is the culprit, though.

One thing that looks problematic is if 'bd.last' is true but
nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
sequence. That could cause the io_work to never kick. There should have
been something else in dmesg indicating that error, though, so I'll look
for some other possibility.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
