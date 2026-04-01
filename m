Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4F4D2ED08
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heh8sartkKNgZ+WLyImAeywZBZ6rowJ27Jlk2mhT55Q=; b=zKyUzKEN0nzX/Al/13tw7BBxXn
	SuyHcAaEiK8fizfAhLxVLtwIjBBapJ9BkcYiEjgTRlFNEWYi1/7Egt5REHEfwtDKJrXPE9VZ/To2q
	4CQxw158T1LMY0djrTCz79ryhTWo1U8+uDaY3VxI+jjyobsM9mM0d8OVwd/DrVsHKhyW+6OAHd7mx
	ElVrBASNRqYcUg70rNrEZ6lg4J4elY37pee1SjVsfCzRR1CZit2IX8nozzzpxphEer7ywqn08wWOD
	QZpQcSn7gIzzXOI3ecPXzdlDP9DlpUlLk5wSNOI34BiOiCG5uAn1cNEBlhV/sAeOsoCcCyb6f6B8T
	plAJ8Xqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vlt-0000000FL9b-0dwq;
	Wed, 01 Apr 2026 13:38:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7v19-0000000FFgc-154j
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 12:49:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=heh8sartkKNgZ+WLyImAeywZBZ6rowJ27Jlk2mhT55Q=; b=RhE7+wDbtPWVzbMpOrhmFDoneb
	nqRLBHWsR6+gmYIB3CSG5Zlccg/m86CyI1XPA8IlyYX25aNVBHC7EI+C0X4d77FNElegg3+pLil9K
	xBhFm2wv2bZqWsDdXv5fYCq5lCmjvSx4Lws7MYqfFhbD4Yrrw1Ayox4wj32mSrElSRpbTkAar/oyq
	ZFAdQdBIFx9sI0zsr4uLm5MSIkaOoXT9NJtsr4mPBnicBPiwsHCXKGNoSOjaQyVLI/3qOP7d8dc8O
	+2XYGfis5eK2+ondDHQPZ7sSIp6zkJtQD6nQ++I/IQvec5bQFlqe+q+0A69wmUL1N+MA9whgxAmZN
	RN4q+RRg==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7v15-00000000O6I-1eha
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 12:49:53 +0000
Date: Wed, 1 Apr 2026 14:49:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775047789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heh8sartkKNgZ+WLyImAeywZBZ6rowJ27Jlk2mhT55Q=;
	b=tMGD0fM5BtkS7s8cjOH47FMWF3KkLGze4xZtLaWbeCpXHa2kqwWKWYOpKMw//zUuD2iAT2
	83uUeOH9zdrB5jBgSZUCQUgvFA4RQ/ggm0Oal5gSLaVGzrROt/qZO9slTh7wl5IiVDrHIP
	pXAnhsEbkR9qNnrUF6G1CWHLtRWjDeDFjsSdSbyFJSuV4IMmfu6KHN8JvWfX2iRI/SOMIE
	qHq5RU5e/fLzWnuBYCqo1sQjYCTuowGyazTt/s9pER8G866XYw5QouLhjCWXsmpYHn7on5
	JikL7RxLG/Bfw6TWurpZVUlR8ZXlOD1PGFWzkwFcfqezJvWCrHWQubGn78Lkig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775047789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heh8sartkKNgZ+WLyImAeywZBZ6rowJ27Jlk2mhT55Q=;
	b=7XrOgOoKRW9yP/eZHYEGzv9pb+kR/oqptIdAFt5MegErsbxzrViWbc6gCXoT8o43/1PW4F
	/EY01dHq/YdviTAQ==
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
Subject: Re: [PATCH v9 09/13] isolation: Introduce io_queue isolcpus type
Message-ID: <20260401124947.-d4D5Cr-@linutronix.de>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-10-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330221047.630206-10-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_134951_565516_DF51D45B 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 01 Apr 2026 06:38:10 -0700
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

On 2026-03-30 18:10:43 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Multiqueue drivers spread I/O queues across all CPUs for optimal
> performance. However, these drivers are not aware of CPU isolation
> requirements and will distribute queues without considering the isolcpus
> configuration.
> 
> Introduce a new isolcpus mask that allows users to define which CPUs
> should have I/O queues assigned. This is similar to managed_irq, but
> intended for drivers that do not use the managed IRQ infrastructure

I set down and documented the behaviour of managed_irq at
	https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/

Could we please clarify whether we want to keep it and this
additionally or if managed_irq could be used instead. This adds another
bit. If networking folks jump in on managed_irqs, would they need to
duplicate this with their net sub flag?

> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Sebastian

