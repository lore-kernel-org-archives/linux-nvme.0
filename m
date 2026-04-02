Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF814D39434
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ds3u4+6LAQIo5JXRSrJAOTU+FbNVAjarQWEAuaA6KI=; b=eim8WtE5KUEsdAlVqq/VQKAj+Y
	NRc8uB4Sdl7qWGIIeyrldrtO/FGB3fE1dXrfN78di9s8cNDkmyTTuoD1BS0/jtVmY0unAp4HopVX5
	muQ7Wxbp5fBvgAtBxqxSi4+itLlOnarImhjvv/YLNxrVQIx0Cb9Wrab7Sa8vQzkJZPfunDhw1D+yK
	Zgk/bEEiTKj4T3AmIs4OWdwKsAmMh7hVsEoOwy25ZHtx8urSTg37eV8HsclSV624l3C28qcTjS5gf
	mpsEkuG/OtdaEKLljZHj5WMyNY3E2q4iWJyvn531OkQWitiUj+5hNraiyUYUwcxkszfELYNShdEpf
	v1UVoaEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Ios-00000000GTS-3aJD;
	Thu, 02 Apr 2026 14:14:50 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8CwS-0000000H80o-1aao
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 07:58:17 +0000
Date: Thu, 2 Apr 2026 09:58:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775116692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ds3u4+6LAQIo5JXRSrJAOTU+FbNVAjarQWEAuaA6KI=;
	b=2VGbfWPiuvIl7w8Nm7Vgl/McrfOt8PG119L5zLfE6KMnhE2hHWKESbQsFDcFTHLjuYKwQS
	Wi1quhUFsXmA4k/me9cksXxi4JcuROmE6HgQDaBYkaqnq0Wb1wJZsxYt4qjmJ1hGTZJ8I7
	8jpOs1/qSDlEVPLNCtXPo3bEM33sh4phWlQMT44Hcq3W6TyjRH5pOpeWOTdLYAhOK0zcNy
	k+1v8X7OjaUweZYskkitoDEBSEPqj52PBfX6Xlh1DV1LziwRpHiyHBa8uWdfkyXvjb4/fJ
	e0RUpvyouMdKCc93cNwUHYKHlGIgHDtjMpicuVtsTfY1BIxq8Y97/kuZAonMrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775116692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ds3u4+6LAQIo5JXRSrJAOTU+FbNVAjarQWEAuaA6KI=;
	b=RCSzIAOvGwKMDpOL3oHmxXQbRFkbngSE2GOk9Z6lL7gUflAeNOI03DkohbZb4f4Y/KLJvz
	vCwwY7N6gwweLsDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
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
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com,
	ming.lei@redhat.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 09/13] isolation: Introduce io_queue isolcpus type
Message-ID: <20260402075810.w0GVbX0Z@linutronix.de>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-10-atomlin@atomlin.com>
 <20260401124947.-d4D5Cr-@linutronix.de>
 <5e6aa61e-0ad0-4027-bba9-cd906ab0d7e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e6aa61e-0ad0-4027-bba9-cd906ab0d7e8@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_005816_558288_5F031760 
X-CRM114-Status: GOOD (  14.85  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

On 2026-04-01 15:05:21 [-0400], Waiman Long wrote:
> > Could we please clarify whether we want to keep it and this
> > additionally or if managed_irq could be used instead. This adds another
> > bit. If networking folks jump in on managed_irqs, would they need to
> > duplicate this with their net sub flag?
> 
> Yes, I will very much prefer to reuse an existing HK cpumask like
> managed_irqs for this purpose, if possible, rather than adding another
> cpumask that we need to manage. Note that we are in the process of making
> these housekeeping cpumasks modifiable at run time in the near future.

Now if you want to change it at run time, it would mean to reconfigure
the interrupts, device and so on. Not sure if this useful _or_ if it
would be "easier" to just the tell upper layer (block in case of I/O)
not to perform any request on this CPU. Then we would have an interrupt
on that CPU but it wouldn't do anything.
It would only become a problem if you would have less queues than CPUs
and you would like to migrate things.

> Cheers,
> Longman

Sebastian

