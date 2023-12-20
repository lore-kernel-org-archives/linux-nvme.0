Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADEDC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FObB8fR3EM9F4se0fXYkRyYO7OvwllCYpdaOxO4iNA=; b=UnywUiTqLxuCBVCdww5wEH7Ekj
	x8VLo6rQR5lz+xVW8EquvrJfCBfCUesGM5rYWik/JfdP/fq+kFEWuJPIsiU4dUK3Euj90CRHAv+Cb
	2oAGQlbz3jgY45KZvgsyl6rRaSZhMUzFf+X00zA71qSQTE1O5yVzC0u3vaNcs+X2m2N7G9kOc2vL8
	wlhxD1bTkVqs/13Cd5ix0yoEWGi0X6i2HLwYaC7kG8Ihr+nwo1gjHCCjVMGQi+pBuq6d8eNRHJnWx
	OIwd2/ahfN+isMlaeqLCw/dAIf7wMcwH8aEc7SoXkXw/lBJXcn2t9x3e4uhNLV9dRd7HlcPEqe4iJ
	5S0jemNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2EH-000lDM-0X;
	Wed, 20 Dec 2023 19:27:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2EE-000lCt-1E
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 19:27:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 10199CE1CB4;
	Wed, 20 Dec 2023 19:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C33C433C8;
	Wed, 20 Dec 2023 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703100454;
	bh=lHysH20vd/0lRahQdftRE483HyKLGhzV9FbeRYqGt1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e++EZAcvMJE/nZBNE9N+css5v641aztsv54Bsve5Ry5R60SiNEprefKEA4mBqtm/S
	 dW3nQayzONtHEwV0k4kghwUNrrf560m6k855gAme1+2Aag41RVzP0c9cWCX+UUEcd8
	 VPGEjumP6e5vniqtWOgfuOmxv6VcsDluV1wcC0xDz3hBhwggXT8u3RU2MQKlYdJn5E
	 18kPCKkoZLjPB995mrexOGiTFzUbvZvM7wphLnmJ6f+HWblmXx/F+zM3Y9wHEu0zij
	 OOz+jGtqycsekvSFt4mzhDAjoeWS48ORURVqeCIrjYV76HPbLV9ScRMW0OzQhCvRIU
	 KCMc5Dk52gHYA==
Date: Wed, 20 Dec 2023 12:27:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sridhar Balaraman <sbalaraman@parallelwireless.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] configurable NVME IO queue count
Message-ID: <ZYNAI7hJFGXA_9ep@kbusch-mbp>
References: <SJ1PR19MB6257DF963B8EC038DBA9111CB296A@SJ1PR19MB6257.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR19MB6257DF963B8EC038DBA9111CB296A@SJ1PR19MB6257.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_112738_675714_2DD1D956 
X-CRM114-Status: GOOD (  13.01  )
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

On Wed, Dec 20, 2023 at 05:53:16PM +0000, Sridhar Balaraman wrote:
> Some NVME products are providing more number of IO queues,
> so driver is allocating queue based on number of CPU or
> maximum number of queues by device, whichever is least.
> At the same time, corresponding queues would be mapped to IRQs.
> But in case of RT Linux, where we need isolated CPU and free from IRQ.
> Unfortunately NVME IRQ couldn't be reduced due to more number of CPUs.
> After making IO queues as configurable parameters,
> we can reduce number of IO queues which inturn reduces number of IRQs.
> 
> Before configuring queue count:
> [    4.384566] nvme nvme0: pci function 0000:05:00.0
> [    4.450307] nvme nvme0: 32/0/0 default/read/poll queues
> [    4.457427]  nvme0n1: p1 p2
> 
> After configuring queue count to 2:
> [    5.920776] nvme nvme0: pci function 0000:05:00.0
> [    5.939455] nvme nvme0: 2/0/0 default/read/poll queues
> [    5.941487]  nvme0n1: p1 p2

This sounds okay to me. It aligns with existing io queue parameters and
it's not unreasonable to limit driver resources. I think this should be
enforced in nvme_set_queue_count() with a nvme_core module parameter
instead of a PCIe specific one, though.

The effective nvme irq affinity will spread out to the unused CPUs with
each additional nvme device. And maybe that's okay, but just wanted to
mention that this patch can't guarantee nvme irq handlers won't be
affined to every CPU if you have a sufficient number of nvme pcie
controllers in the system.

