Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CC7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7QF2fltir2fRkqEYKBzvER7PZkgfd4Kk4AMZ7Q4F2E=; b=prCAKiEWDMVZeTSwSqePvzx1gW
	SORcINmL0Rx1f3EfTV8abu+4Mas21I4mF8jUqlzaN/qVsM3NEmvDZMltVEV8yUw+EuyH+JfKX5SQA
	z9BydeCqkKhnHsiVJyFHeUUJzQFyqMUzVdtwf9YxLtH4edfU0fjYB+DHWoFhcHf1WmJ72OqF+mtpv
	lbpU4Dk9QDAv49cb1m5pxIDJM7owqFYPmwgkc765xMk6hwVcBzp7bh4T9PmbhU07dYLzcPTgormWa
	R7rx2wtCFEXNAQFDorhL+p0e2mR1a7R7PJ6VebmXEfucvuPRSkRO4xz13Avvp4nbjwtaujQdcOyeS
	XEWkBbsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5A3X-00FSul-VP; Wed, 05 Jan 2022 17:26:36 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5A3S-00FSt9-CX
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 17:26:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2501AB81113;
 Wed,  5 Jan 2022 17:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CCC36AE0;
 Wed,  5 Jan 2022 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641403588;
 bh=Ai4ap2rjhXc3aSeFFnC+xdaqAJOln+8Hj+m+Ez8mvY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YTpfpFmiZ6Czfq7bJ8BGZWk/n4qb6lV3wjyn9GVIRtvYt3HDdgB3a4A3nKP1jxBQv
 pTUFG6RkONLcdhQ9VIzncMQcP5TE/C4Y41Px0U3wMt8Sukgb3iIQ6bdF5h4X07klca
 vft+NKXAQhmv91QDGhEcdGC7mZtQXa+lSzdQ/URb0AGD+sZjqQzlyVcBS1nyzduqZx
 gm/KaIdWb5hDXh0VPGfulM86oFA8cuijKVn1ivg6Ml+K+QpPkjRS0/Hnwh1SCPAxsu
 f7fCtAQudtjvYYPSxcMKg9BuZM3UmR3uo3wMkBuu45pZBT6HocopZByMxPbh2AHj8g
 8IEPyvuu+XBHA==
Date: Wed, 5 Jan 2022 09:26:25 -0800
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20220105172625.GA3181467@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
 <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
 <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_092630_727403_6DF944CA 
X-CRM114-Status: GOOD (  20.45  )
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

On Tue, Jan 04, 2022 at 02:15:58PM +0200, Max Gurtovoy wrote:
> 
> This patch worked for me with 2 namespaces for NVMe PCI.
> 
> I'll check it later on with my RDMA queue_rqs patches as well. There we have
> also a tagset sharing with the connect_q (and not only with multiple
> namespaces).
> 
> But the connect_q is using a reserved tags only (for the connect commands).
> 
> I saw some strange things that I couldn't understand:
> 
> 1. running randread fio with libaio ioengine didn't call nvme_queue_rqs -
> expected
> 
> *2. running randwrite fio with libaio ioengine did call nvme_queue_rqs - Not
> expected !!*
> 
> *3. running randread fio with io_uring ioengine (and --iodepth_batch=32)
> didn't call nvme_queue_rqs - Not expected !!*
> 
> 4. running randwrite fio with io_uring ioengine (and --iodepth_batch=32) did
> call nvme_queue_rqs - expected
> 
> 5. *running randread fio with io_uring ioengine (and --iodepth_batch=32
> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
> expected !!*
> 
> *debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
> seconds, it appears to be stuck. Doing forceful exit of this job.
> *
> 
> *6. ***running randwrite fio with io_uring ioengine (and  --iodepth_batch=32
> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
> expected !!**
> 
> ***debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
> seconds, it appears to be stuck. Doing forceful exit of this job.***
> 
> 
> any idea what could cause these unexpected scenarios ? at least unexpected
> for me :)

Not sure about all the scenarios. I believe it should call queue_rqs
anytime we finish a plugged list of requests as long as the requests
come from the same request_queue, and it's not being flushed from
io_schedule().

The stuck fio job might be a lost request, which is what this series
should address. It would be unusual to see such an error happen in
normal operation, though. I had to synthesize errors to verify the bug
and fix.

In any case, I'll run more multi-namespace tests to see if I can find
any other issues with shared tags.

