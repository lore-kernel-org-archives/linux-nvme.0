Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E20109C04A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIqxshH5v/kqlkka5Fys70biUG8RbxH1oZ71KulCzLQ=; b=U1/+7DE574sgJe8omKICMl1Uta
	H80KlBZixZaFg6kA12iAjIVslaE5uHZW7gca92xo9aIezOOg2JCXWA4Hnoir5Td3EaNTBV8jYFhwj
	Sc3jGzpFPnad6doJ0Vwj3QcYJaIOkY7lhbSLAYjyHb2canbMpr6r3RjO3+x3LRg4VF+BauHaxQfQ9
	5zee3/xWMUUvNLdCMC6jBnrc8b9wP5COmcAdbZ/q+yAZbRZZj8U1BW201X1q3d50HKyJoX3R30+Dv
	d4wg+2JdAp8KW/XsFi5n7PXiA7kXoZtIIcmHiaMusTDfddqzVZlpcsuS9EEK0bAjvg62u7Ca/TWJ8
	rlZo6B8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5SSq-000000041VH-2Ecx;
	Wed, 25 Mar 2026 17:56:20 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5SSn-000000041UD-1fnn
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 17:56:19 +0000
Date: Wed, 25 Mar 2026 18:56:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774461372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqxshH5v/kqlkka5Fys70biUG8RbxH1oZ71KulCzLQ=;
	b=YBpqKbshdPlJu3AcoWLnrzsRC6Ae0uS2dqj2hZm8sV6kAQm3/9diR/7/tSvamk/9Pkdoz/
	wlR2YU5NWAUDcQPIpkRnrAAfRuyzHYT4QsYzDJA8dLamlFNRPMZZMJkgsumccvDxFNZaMq
	cB98imsYRGVW8rE/9ZAxMHMlWVEZgxhJM11Tw8sb0A7gDjCt4HUnIjFl9yD8/WNlzncSJn
	jSyp8mt860DgWw4Tvmh6xil4RZ6uZFYWySQU4MDIUJJUgPVVkXteBRGkpyEZSAo1zTyopO
	bJy6d4+BFz8BGh/5ScpGP2u/eoqDGNxhzUZgw6SA1U5ZyKHR8k6cyvfnLRHCyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774461372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqxshH5v/kqlkka5Fys70biUG8RbxH1oZ71KulCzLQ=;
	b=qyY290+xc963pc4I0oYLTElTPEXP2NuJR8oeKQMMe8AFVQx8op8IjKmEt8+Qbck1ImR392
	W+6IV1teDdeXYVAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 00/12] blk: honor isolcpus configuration
Message-ID: <20260325175610.eY-VHHPS@linutronix.de>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_105617_600305_1643C350 
X-CRM114-Status: GOOD (  16.32  )
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

On 2025-09-05 16:59:46 [+0200], Daniel Wagner wrote:
> The main changes in this version are
>=20
>   - merged the mapping algorithm into the existing code
>   - dropping a bunch of SCSI drivers update
>=20
> With the merging of the isolcpus-aware mapping code, there is a change in
> how the resulting CPU=E2=80=93hctx mapping looks for systems with identic=
al CPUs
> (non-hyperthreaded CPUs). My understanding is that it shouldn't matter,
> but the devil is in the details.
=E2=80=A6

I have been just made aware of this. It is still not merged so let me
ask the questions before it is too late.
What is purpose of managed_irq? Doesn't this sort of aligns with this?
It was originally introduce to limit the number of nvme interrupts which
can have multiple interrupts but don't need to use all of them. virtio
is using it.  Yet I don't see an affect if I use isolcpus=3Dmanaged_irq,X.

I would expect that it limits the number of used interrupts as intended
by this series. The only affect I see is that once the CPU goes off/on
the assigned CPU mask is restored.

What do I miss?

Sebastian

