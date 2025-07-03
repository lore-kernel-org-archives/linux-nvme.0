Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF03C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2nuxUpn8jv3inoeprClL8agFagvekP2Pndo4rPNDD8=; b=K8RE9VcPhDw9id20QDvx/Joywx
	pqhdzeqov3hT7CKsi8JyZ2K9BFK4VJtFdh1GT060A+sPEn5nF5zpzr3SJ8LYH29m+PlEBUOamYIk0
	YewEs54GQoG4qKEHZK9dJjGQVGk24qExc0Kcc4r6h9WG6kGmSrmeEQuDKA4M0YQTO3dsoLhoqywrr
	KZKBB3sp/T2lnj/+WA1YGBWFZAomnkyfK+KeOWHU9NEfmPXdpU0PF6uscF6k4cAXFgRS8dQxwPImd
	Euf7UMPIJFe4U+EieBD0bffg+YHb3IGI6Qpd+VQKqF8b3oX5Duna6et5xP4Ir7P+At1oyNoy0XgPF
	HiZoSM7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGpi-0000000AvuK-3aEN;
	Thu, 03 Jul 2025 10:06:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFpd-0000000Alfl-0kHI
	for linux-nvme@bombadil.infradead.org;
	Thu, 03 Jul 2025 09:02:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O2nuxUpn8jv3inoeprClL8agFagvekP2Pndo4rPNDD8=; b=THKyAJR9j/F7GwaDho9dxVRQnZ
	ni0CtItpEWSjzrGgTSJ3eC/6r/kz/NU/SH4U+5X+UceIRJZE3FeRZgx5Nm+7RuZllbokDiziOzs23
	MlDwuzzqZlVZ90eqbVoM0gDO/m4Fns9WjRL3JTD0j3dj5w96aGqLKmRk8kPtVHYqgiokgeDJiri2A
	9xxcHBoCK3HYohMgQZCmbVbIxOSCAacP4oKf4IMgPIajNEdVkHdJsuRv2zaaC8JgpmqNR57D3lDXG
	GXvzm0jtA45IsfUnFNvAvRA+KrggnqwOQZq2sgeVz0PnPWX14GbEyTpM8RN+nTs8Hb5ZsugylnFKk
	mAnzTpyw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFpa-00000007eJb-0II9
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:02:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD66168B05; Thu,  3 Jul 2025 11:01:58 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
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
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when
 isolcpus=io_queue is enabled
Message-ID: <20250703090158.GA4757@lst.de>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org> <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_100210_293531_FA6A508E 
X-CRM114-Status: GOOD (  14.13  )
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

On Wed, Jul 02, 2025 at 06:33:58PM +0200, Daniel Wagner wrote:
>  const struct cpumask *blk_mq_possible_queue_affinity(void)
>  {
> +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
> +		return housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +
>  	return cpu_possible_mask;
>  }

I'm no expert on the housekeeping stuff, but why isn't the
housekeeping_enabled check done in housekeeping_cpumask directly so
that the drivers could use housekeeping_cpumask without a blk-mq
wrapper?


