Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42925D3517B
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pz9yqm2xW/wCQ4BGxlKJbUUSrjAgVJCbne2YOojl5Rw=; b=O7Eo8zCHRtLjhfjA9CyJSRwdwr
	OJuo5SPgSnf5CDsQB5n86RdF+PZzri0YvO+MyBilfBmci5YBhZxIVky2hk/7dn29YIKiluMKPB+og
	eQBJVVj9Rt52KqFQOUEOHE2AujfAXe3oKVbusgRcFf1BN/6d/DWhzXTcCFihEignwfSKiUgoMo/0z
	X0kc2pjNmPAG59LOsDiwn6nrjKG4eYicOdZBPMCHk9yMShKU0zwyEcLikoaKGRZ6VHk/3nWhBd3QF
	F9WSMp7LJUzeXYK//8ix06Glsa6Dw7S8InKtVJZPc5f4yXfS/oDGg5GuC89tjI3Q+hjNQ+4gbRs1J
	XyLQ46HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7uxw-0000000FFLi-3lhh;
	Wed, 01 Apr 2026 12:46:36 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7uh8-0000000F66I-0BjX
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 12:29:15 +0000
Date: Wed, 1 Apr 2026 14:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775046550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz9yqm2xW/wCQ4BGxlKJbUUSrjAgVJCbne2YOojl5Rw=;
	b=ow5ot4/7H/V7sxugopOVzfq11RiQLgEIk56AtHOX8C9k31weT2EEv8mH8fvgN6XwYwTQqZ
	tdJI0PSbur5wNsxwwoc6yijnh24YFaQv8uIxVAKyEwSnQEWHH6l0giXU8QkfojzVYXXVqu
	v2KZBOOZFLZ6wrdW0zffbyoO2S9QMlAyMxmOUFcJCi1MXikAtg86Zrb9LaUMzpD/CsUh6l
	cD3dMQ+SsLhhXvq3TCeq1lI9B/827qksmzgVsCvkcpwssOiEkUj4uSBuuQmee/AiBPD0fs
	84szdnT0eeoe4HOWtjS56WEmQsRSlTkhaKTxK0ecWHlqA4R53xIx+ybnBi6gtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775046550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz9yqm2xW/wCQ4BGxlKJbUUSrjAgVJCbne2YOojl5Rw=;
	b=qOp4tiVPsDEo2clqFhCTqobVu13lAnk+NbJ72USET8+2h2SlZW/GB06+cnnw27aZZhJtqQ
	3AXCmSfon7P8jrCw==
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
	kch@nvidia.com, ming.lei@redhat.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 02/13] lib/group_cpus: remove dead !SMP code
Message-ID: <20260401122908.hxUnR63u@linutronix.de>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-3-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330221047.630206-3-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_052914_226114_68815A57 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 01 Apr 2026 05:46:29 -0700
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

On 2026-03-30 18:10:36 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> The support for the !SMP configuration has been removed from the core by
> commit cac5cefbade9 ("sched/smp: Make SMP unconditional").

!SMP is not dead code here. You can very much compile a !SMP kernel at
which point the code below will be used. It is more that the sched
department decided that scheduler's maintenance will be easier since we
don't have to deal with !SMP case anymore.

If you wish to remove the !SMP case here you need to argue as such.

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

The previous patch, this one and probably the following lack a
Signed-off-by line with your name.

Sebastian

