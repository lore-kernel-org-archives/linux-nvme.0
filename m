Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC03FF8867
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLa6eYHbGlETXhdKZQov353z3h7xOJzxZI3VwyPyfVI=; b=xmtYKlhMGzi/DCfkEE+e05JE5W
	wVKMxHVb+n5vd0b9B7d19wa8yJRVJp6G7fWLeiFtV9Cif+2TWGcN/msdV75QpfI0pyLkBK56OkAlj
	QDgiMzFQIo2OdEvL6cwux1i94pHyhqZoMj+L/HR2knGo1illGHHRfWEgI+HJKCuk000iY4xKUpZ2x
	cr56CwHeJDGmd8zwuc9MzQERt2EGEQhSdTi6qJEAZwbQPlW+56E+kcbyYOGEDV8Uk4wyKaOdTodSB
	JxXdip8QgfRRN72KFaDO94IGwe05vpYeZUBdDELZxYUnttNyWsmYfTyFfIPc4H8/o7ve9pF5CCxHC
	FBK8DSDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHS81-0000000059Y-0wwH;
	Mon, 27 Apr 2026 20:00:25 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHNyW-0000000HCKv-3kA7
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 15:34:22 +0000
Date: Mon, 27 Apr 2026 17:34:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777304058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLa6eYHbGlETXhdKZQov353z3h7xOJzxZI3VwyPyfVI=;
	b=RRNMynj1Qa0/ZFxqoprrF+lV+59v57PURMlHWXd5zVKQ/++xbkIPxKBPjeEs8yH6/38KK3
	t9BTF92ohu2bpe7aiZh7Y02xPEG8gBZtQsTNa95rtMtb9z1rGNWO4RNTOmBfqDrmP4RbS7
	F4gucu6e/dQh0V3DJWL0rg1aP1taN51+lmDOG+CaWQp+io9qKXLZ7Zxk4AGZVvW3XvfMzk
	wYKkbHSGRljgM5sXqXCUCQv5DYoBhATNtlDCupF/OVXjX9f18HkkaEGSKAh2NgGAvuOXgD
	ANAb4BjEBVZMhG/LsmITYW7vyL4LxHaLjROA+oF/LBESKOQIGCp3jMeRb8QFUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777304058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLa6eYHbGlETXhdKZQov353z3h7xOJzxZI3VwyPyfVI=;
	b=aUDQhXJ3cDmA67FdQhP07NpAltG1Pvtpl4MeIYhK8VnCGsvxRPIVhTmJ/QINy4t75BK9B4
	OwA4EIuBM99DVGAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com,
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com,
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v12 05/13] blk-mq: add
 blk_mq_{online|possible}_queue_affinity
Message-ID: <20260427153416.MeVS8yxF@linutronix.de>
References: <20260422185215.100929-1-atomlin@atomlin.com>
 <20260422185215.100929-6-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422185215.100929-6-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_083421_074767_0EB1CB6D 
X-CRM114-Status: GOOD (  11.53  )
X-Mailman-Approved-At: Mon, 27 Apr 2026 13:00:22 -0700
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

On 2026-04-22 14:52:07 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Introduce blk_mq_{online|possible}_queue_affinity, which returns the
> queue-to-CPU mapping constraints defined by the block layer. This allows
> other subsystems (e.g., IRQ affinity setup) to respect block layer
> requirements.
> 
> It is necessary to provide versions for both the online and possible CPU
> masks because some drivers want to spread their I/O queues only across
> online CPUs, while others prefer to use all possible CPUs. And the mask
> used needs to match with the number of queues requested
> (see blk_num_{online|possible}_queues).

Which driver uses cpu_possible_mask? This mask is assigned at boot time
once the kernel figured how many CPUs are possible based on ACPI or
whatever the system uses. This mask does not change.

I only see drivers/scsi/lpfc/lpfc_init.c using it. Looking at
cpu_possible_mask might not be the right thing. It is usually the same
thing as "online" except on system where ACPI thinks that something
could be added via hotplug _or_ if the admin shuts down a CPU via
cpuhotplug _or_ boots with less (there a command line option for that). 

In case cpu_possible_mask != cpu_online_mask the intention is to
allocate memory and setup irqs for the offline CPUs?

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sebastian

