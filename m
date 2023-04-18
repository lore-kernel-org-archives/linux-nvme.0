Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB504C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 04:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjrEaIQXqVsunJ5bNiex+uKn78VZTL6vESBmq0QnT2w=; b=TVQfwNygsNCOg8PzhYo9X5tOoz
	Sbzm/Ee4GP7hyMe3bOGJgtYA5gKo1X9xcxGpCwXTUBw1rcDAvRmrQTEWG4sRQRMhEYwPa398UyeS/
	2/fJ4a/oSwNC149VyrAeQS/Sj+C5rn6BINpzY/7biBsXTFbRZf7ct7SMRYOkUXFwLjsCpqw9l234a
	GtJZJTan84zhJqCOh+rzv7VfOLvVzv7pPi4ave/KVwdMPBUUL695r3p0F3EFeeHUkM1rL3A71PDp0
	5cbtIUDP1n3mKH0hm5wkynHnyjPuSSTjjmNnPXrhQP5ZjDa2aNA4/MlrMp0dcGgQlBg5G51tbwIxW
	6fouMyFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pod2e-000pcL-2p;
	Tue, 18 Apr 2023 04:34:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pod2b-000pbb-0c
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 04:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681792437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjrEaIQXqVsunJ5bNiex+uKn78VZTL6vESBmq0QnT2w=;
	b=Cst/ACWgRkiVxqeWyLvX0d/6LDMHB8Wn2jLNKiaG1flixfjpCri8yUJu06qfrwPWX2Kv7S
	+9DiO5m1dEx90WC/5x5VgiRTM23oBXh25i8rQ3GT6waFWGjKfnb3jkfHBebBhegIpHDzIS
	Jsoqjek2GGDzk2Uimp277RDWgsaoNHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-4euyCoDaMoaOA4NDyWVB1w-1; Tue, 18 Apr 2023 00:33:53 -0400
X-MC-Unique: 4euyCoDaMoaOA4NDyWVB1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6722A8314E8;
	Tue, 18 Apr 2023 04:33:51 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE34640CFD40;
	Tue, 18 Apr 2023 04:33:44 +0000 (UTC)
Date: Tue, 18 Apr 2023 12:33:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Li Feng <lifeng1519@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Message-ID: <ZD4doq5Ko49wLvQK@ovpn-8-16.pek2.redhat.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
 <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
 <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_213405_328074_6212D85D 
X-CRM114-Status: GOOD (  45.79  )
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

Hi Sagi,

On Mon, Apr 17, 2023 at 04:33:40PM +0300, Sagi Grimberg wrote:
> 
> > > > On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
> > > > > The default worker affinity policy is using all online cpus, e.g. from 0
> > > > > to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> > > > > have a bad performance.
> > > > 
> > > > Can you explain in detail how nvme-tcp performs worse in this situation?
> > > > 
> > > > If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
> > > > on other non-busy CPUs via taskset, or scheduler is supposed to choose
> > > > proper CPUs for you. And usually nvme-tcp device should be saturated
> > > > with limited io depth or jobs/cpus.
> > > > 
> > > > 
> > > > Thanks,
> > > > Ming
> > > > 
> > > 
> > > Taskset can’t work on nvme-tcp io-queues, because the worker cpu has decided at the nvme-tcp ‘connect’ stage,
> > > not the sending io stage. Assume there is only one io-queue, the binding cpu is CPU0, no matter io jobs
> > > run other cpus.
> > 
> > OK, looks the problem is on queue->io_cpu, see nvme_tcp_queue_request().
> > 
> > But I am wondering why nvme-tcp doesn't queue the io work on the current
> > cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
> > affinities for each hw queue, driver is supposed to submit IO request
> > to hardware on the local CPU.
> > 
> > Sagi and Guys, any ideas about introducing queue->io_cpu?
> 
> Hey Ming,
> 
> I have some vague memories wrt to this, but from what I recall:
> 
> - The number of queues is dependent on both the controller and
> the user (Not a reason/motivation on its own, just clarifying).
> 
> - It simply matches what pci does (to some extent, outside of rx side
> entropy that may exist), it just happens to take more cpu cycles due to
> the network stack overhead.
> 
> - I didn't want io threads to change CPUs because of RFS/aRFS
> optimizations that people use, which allows the NIC to steer interrupts
> (and napi context) to where the io thread is running, and thus minimize
> latency due to improved locality. that on its own was shown to be worth
> over 30% reduction.

OK, sounds like one per-queue kthread model may work for this case, and
the kthread cpu affinity can be wired with hw queue's cpu affinity, and
scheduler may figure out perfect time to migrate kthread to proper CPUs,
and task migration is supposed to happen much less frequently.

> 
> - At some point nvme-tcp rx context used to run in softirq, and having
> to synchronize different cores (on different numa nodes maybe, depends
> on what RSS decided) when processing the socket resulted in high
> latency as well. This is not the case today (due to some nics back then
> that surfaced various issues with this) but it may be come back in
> the future again (if shown to provide value).
> 
> - Also today when there is a sync network send from .queue_rq path,
> it is only executed when the running cpu == queue->io_cpu, to avoid high
> contention. My concern is that if the io context is not bound to

This one looks one optimization for send? But this way actually causes
contention with nvme_tcp_io_work().

> a specific cpu, it may create heavier contention on queue serialization.
> Today there are at most 2 contexts that compete, io context (triggered from
> network rx or scheduled in the submission path) and .queue_rq sync
> network send path. I'd prefer to not have to introduce more contention with
> increasing number of threads accessing an nvme controller.

I understand contention doesn't have to require one fixed cpu bound with wq or
kthread. Using single per-queue work or kthread can avoid contention completely.

Here one tcp queue needs to handle both send & recv, and I guess all tcp sends
need to be serialized, same with tcp recvs. Maybe two wq/kthreads, one
is for send, the other is for recv? Or single wq/kthread is fine too if
the two can be done in async style.

Then the send_mutex can be saved, maybe nvme/tcp blocking can be removed.

> 
> Having said that, I don't think there is a fundamental issue with
> using queue_work, or queue_work_node(cur_cpu) or
> queue_work_node(netdev_home_cpu), if that does not introduce
> additional latency in the common cases. Although having io threads
> bounce around is going to regress users that use RFS/aRFS...

IMO, here the fundamental issue is that one fixed cpu(queue->io_cpu) is selected
for handling IO submission aiming at same queue, which can't scale, because
we can't expect userspace or scheduler to reserve this fixed cpu for
nvme_tcp queue.


Thanks, 
Ming


