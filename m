Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A5CC77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64LjpVCxLV+TLB4DlA7ht7RGBF6FWgyYq2+ZXjoxFPQ=; b=hVhIoT2IXYFwNEZnm2wiKuG5C9
	611oB4Lxjz1Ve2mNZDjzjzskyXH/hHtXZmFG8wbJShqn7PxNveELfbg6LUTsgSnsI6aAT5LdX8CJM
	A0llXIiHwalIoU7Vx+sZpE24AYRecPR/Plns/Rx9rHhUxt5rMy8CI9l9HnabAVNINVeVm+OscfEzK
	UqpQQbrCWiTj3noKZLyjvyLdQMQMMHgc6t166vd6IcrbsHdDimcmlHbHpeQoesO80+s+7TDg5C2QX
	n8ws7Ur40YPOlbC0fr8iid3zgk5ZpW+sIrPN8/B/j5tKCsXnwRj3yidI5+TDZbCKM2NPd5u9cQ5x0
	SpuBlWCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poJrk-00FKFs-0z;
	Mon, 17 Apr 2023 08:05:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poJrh-00FKF4-2B
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 08:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681718732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64LjpVCxLV+TLB4DlA7ht7RGBF6FWgyYq2+ZXjoxFPQ=;
	b=NKunzAAJTdqKFgxzCN7J9mB+EzUfkn89YpnY+5hechNsTYFhbrBM+BXRu3CLepTVr25TyE
	HAI6uNpOWU1VL0VNXWAVktUO98g5W5W+nc/jTfgu4Cgk8sk07dkThP/VNUGvEQkb2KXxZZ
	pu7D7j6fv38lve7jnDOwyV4G+6Bq0d0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-iqveTSncMZGVonA7d7IEsw-1; Mon, 17 Apr 2023 04:05:30 -0400
X-MC-Unique: iqveTSncMZGVonA7d7IEsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40DF985A5B1;
	Mon, 17 Apr 2023 08:05:30 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CFBD14152F6;
	Mon, 17 Apr 2023 08:05:23 +0000 (UTC)
Date: Mon, 17 Apr 2023 16:05:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Feng <lifeng1519@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Message-ID: <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_010533_786653_5FA1490C 
X-CRM114-Status: GOOD (  20.39  )
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

On Mon, Apr 17, 2023 at 03:50:46PM +0800, Li Feng wrote:
> 
> 
> > 2023年4月17日 下午3:37，Ming Lei <ming.lei@redhat.com> 写道：
> > 
> > On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
> >> The default worker affinity policy is using all online cpus, e.g. from 0
> >> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> >> have a bad performance.
> > 
> > Can you explain in detail how nvme-tcp performs worse in this situation?
> > 
> > If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
> > on other non-busy CPUs via taskset, or scheduler is supposed to choose
> > proper CPUs for you. And usually nvme-tcp device should be saturated
> > with limited io depth or jobs/cpus.
> > 
> > 
> > Thanks, 
> > Ming
> > 
> 
> Taskset can’t work on nvme-tcp io-queues, because the worker cpu has decided at the nvme-tcp ‘connect’ stage,
> not the sending io stage. Assume there is only one io-queue, the binding cpu is CPU0, no matter io jobs
> run other cpus.

OK, looks the problem is on queue->io_cpu, see nvme_tcp_queue_request().

But I am wondering why nvme-tcp doesn't queue the io work on the current
cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
affinities for each hw queue, driver is supposed to submit IO request
to hardware on the local CPU.

Sagi and Guys, any ideas about introducing queue->io_cpu?


Thanks,
Ming


