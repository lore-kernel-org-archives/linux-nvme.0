Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B2DC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+RZ4tz/NQxqhCuedSvkAbV3vjR3z1XIeVY6D0OSurA=; b=1mTivmFftBVJkaAjUpZJPVXkzX
	VlApq0z73EQspPJWh9xNyNu1F4vaOEIRk2l7edxOCgEtV9GVSvEfI+psBJyszdQy0W0Ge7kS/gIrn
	8J7fN1qRWWIj7RLhWCOhCvFVyjAW/33EmLhmyyqGvdUEw1mP4joEhvaTAHTTMf5MI0FONNnV1KA8N
	p2jQXu42WIDQkCD+odUwBI7Cl1WMdie97gxjkfJl6T8rydZ6y52KeUqZwrcv9EUxevntYrUR4cKy+
	gP0e1ZMQjL/RyowVoDXMXTXKO/yBJ61ogWGVYL2GIiLWi/VCZ0sU9hE92n5b5BLoUzvkhjPkIR5Pr
	0UkMEL+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps8UV-007UG8-0b;
	Thu, 27 Apr 2023 20:45:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps8US-007UFH-0G
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 20:45:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9420F63FB7;
	Thu, 27 Apr 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE783C433D2;
	Thu, 27 Apr 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682628318;
	bh=+CHMJmPoe4lf9a+mPTqk43TA5PhL+q4e3P7D0SmTMhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcE12SqJ+H9BcABqL0rrb0+AmO3HXDWiK+vy1YnMXFw341szdt2fm+wyqnFAGTlyj
	 ujetLG2zZ3b+ub8RzG/b/DfXjFP8lUE7CpCVL5AoUkrQR0kA7DpNhmdUVeLjcMlhNn
	 OU//MlLFNPtGpL0mHFoNe0VyN/y1tl4HMD/SXh4PwF+c0qWWe9frpIzaWSTJF8Cd6q
	 a7wfYDfMthMdZJzrhCw6o+ZdMw0KwFtNpf8p4JOL69PgGdxOXjNL3ydY1pH4eth7WJ
	 CvrQbgCc6DJiZIwIPIv18FZNJF+elkdjVMa4n+m580tG0sQbA1NOWuvyTIzmwBa4D5
	 et51gUwcJKdPA==
Date: Thu, 27 Apr 2023 14:45:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wang Yicheng <wangyicheng1209@gmail.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Seeking for help with NVMe arbitration questions
Message-ID: <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
 <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_134520_179625_8D16B82F 
X-CRM114-Status: GOOD (  22.57  )
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

On Thu, Apr 27, 2023 at 12:03:05PM -0700, Wang Yicheng wrote:
> Thanks Chaitanya for confirming!
> 
> Given that the kernel module doesn't support configuring device-level
> arbitration,

You can't configure the arbitration method. The only thing you can
change is the arbitration burst size.

> I'm now trying to leverage the I/O queues to achieve the
> same goal. If you could kindly help with the following questions it
> will be much appreciated!
> 
> 1. Is there a way to query the type of each I/O queue and which CPU it
> resides on?

The type of I/O queue selected depends on what you submit. If you
have read queues configured, then reads go on the read queues. If
you have poll queues, hipri io goes on those. Everything else goes
on default.

> 2. Is there a way to control which queue a submitted I/O goes into?

The queues are assigned to specific CPUs. If you want a specific
queue to handle your command, then submit your request from one of
the CPUs that map to the queue.

If you want to know which queues map to which CPUs, consult sysfs,
example: /sys/block/nvme0n1/mq/.

That will show each queue as a unique number (not necessarily aligned
to the nvme sq/cq id's), and each number will have a cpu_list that
tells you which CPUs can dispatch to that queue. sysfs doesn't tell
you the type (read/write/poll), but all queues are accounted for,
and each type's queues will cover all cpus.
 
> 3. Say I have only 1 default queue and I submit an I/O from some CPU,
> then there can be a chance that the I/O would need to cross CPUs, if
> the default queue happens not to be on the same core right?

If you only have one queue of a particular type, then the sysfs mq
directory for that queue should show cpu_list having all CPU's set,
so no CPU crossing necessary for dispatch. In fact, for any queue
count and CPU topo, dispatch should never need to reschedule to
another core (that was the point of the design). Completions on the
other hand are typically affinitized to a single specific CPU, so
the complete may happen on a different core than your submit in
this scenario.

