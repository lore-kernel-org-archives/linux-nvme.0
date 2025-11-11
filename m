Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA664CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZRHAUY22f4DMZXjGNy9kKErIJtv/qXFs3nnNzhiEiMY=; b=PWYdfeewU3gGlbgcNYhdZ2Q4M+
	ngFX3J4spA/pS6UxvXOyoVCdEiklknKDsEt3zCNvhb4kxFlQ1oQ/vjB6H/+t9CiYc/LrrEuK0Jlxe
	Y3J2QUsCv+1tLtYGlJ000KHp0XnApPaROHeaVRk5JtqETo1kjIq4MRytZEbz57mXy+3pDwD43ZI7j
	xTBxnFEkvcdLwiES0Mg6zz546LkALoJ6WTUacRIsrYAaNOBAKy4AVZIgPK5QM9RCeJr/vyqdAtvc8
	ujVQvq/TASW3NiW5v0zb1YGniUCUXfK/zNgRBOAhdoSog91fAz++tW2FABH9D3k6+BZ0GqiKEE127
	VWlgsCeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vInBJ-000000078r8-0mA8;
	Tue, 11 Nov 2025 12:09:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vInBG-000000078qd-1T1C
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 12:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762862941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRHAUY22f4DMZXjGNy9kKErIJtv/qXFs3nnNzhiEiMY=;
	b=NGScRacArtyI+cgA2XlhFQcuseHP4w6nzaZF87M1vTkI2P2/5UtkY5W06FKdTKpvz45IcM
	/cdErvMIK2WFqNo4Onac74vi7B7z5P7MFG+omNLYHG8nZecUQSaQTMiuKFjl870aafO8DP
	qBxhyVH6hduzLyQQqAVrSOQ0MqeRV/Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-v5kAbdCLOKGzNWrqMNMF5A-1; Tue,
 11 Nov 2025 07:08:57 -0500
X-MC-Unique: v5kAbdCLOKGzNWrqMNMF5A-1
X-Mimecast-MFC-AGG-ID: v5kAbdCLOKGzNWrqMNMF5A_1762862935
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA3371955D48;
	Tue, 11 Nov 2025 12:08:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BA411800451;
	Tue, 11 Nov 2025 12:08:44 +0000 (UTC)
Date: Tue, 11 Nov 2025 20:08:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRMnR5DRdsU8lGtU@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_040902_463691_0B20282C 
X-CRM114-Status: GOOD (  18.10  )
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

On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> On 11/11/2025 11:25 AM, Ming Lei wrote:
> > On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> > > As CPU core counts increase, the number of NVMe IRQs may be smaller than
> > > the total number of CPUs. This forces multiple CPUs to share the same
> > > IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> > > performance penalty can be observed on some platforms.
> > 
> > Can you add details why/how CPU cluster isn't aligned with IRQ
> > affinity? And how performance penalty is caused?
> 
> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
> CPU31, it will have cross L2 memory access.


CPUs sharing L2 usually have small number, and it is common to see one queue
mapping includes CPUs from different L2.

So how much does crossing L2 hurt IO perf?

They still should share same L3 cache, and cpus_share_cache() should be
true when the IO completes on the CPU which belong to different L2 with the
submission CPU, and remote completion via IPI won't be triggered.

From my observation, remote completion does hurt NVMe IO perf very much,
for example, AMD's crossing L3 mapping.


Thanks,
Ming


