Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C35E7719B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cfCN625NWPuLbrl66za1MyeaGUomRP4uUXlzRcMp7E=; b=AODv5Vy/CzmPV37s3lIbUd/Wpr
	DZ0FFrEDQk5btxj0AwPH/txo3uB+JfbXNBQGOoYVSQ/rmFBN2eOsPY/7W9+aQYXmbAQQTdpCLmq21
	EyCJM1P0j4F3r7C4D4bpyT2lseFLzrqHbWj9cYWihH5jQTupdA3Um1omxxT7UbOJflQNSBWO3YOWC
	eWgAf9HzSu5xwIZGfYzB7h1MYe0vFFv44ysxKec/uUgyp5IHEzaljQpbhjEQaUuA11l7BZdoyedsD
	3jrrkCgMeZNuyt10WJIZTJJcDBFcokru6DfM9xptEVKuUPsQhYZa/fyV6ennHgUE3UzFtJPmQSVkh
	8aD+NdwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVD98-00000005nbn-0O48;
	Tue, 07 Jan 2025 17:13:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVClL-00000005hsK-3T1u
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:49:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 243295C06A8;
	Tue,  7 Jan 2025 16:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81985C4CEDD;
	Tue,  7 Jan 2025 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268542;
	bh=rYSkPvX1QyacOdmAnf/iALya6LLlP5Y6yrRF3StdxvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHuD7PBw05k3o952xITputUvz/7C6oiEIB7l5SaFceyyY+jC/2BxclVOLo8gGS5KN
	 BprhmizBRbowVhkSshgwRW6aXd89+MObHWlMmYERmQF2KkAcxNh/hMt1pe+wkNoHtF
	 OQ0ec+TblRnFisS+9tzoW1lcdIvWBdS0yU5oVRTiQi49D7wGsqBB6oj1azH2jQN9Lp
	 QhosnMEIH8oGtBm2uoSRpoEsGF1qcXIU/qJV0GjA85R/6ytNbLWrwh8OLI218zh/lB
	 MoZombkvxboNiuW7sZIeJOH24xioOaJazLKvL7SnnQu7k8wBAmW512fbSctGWo/UI4
	 X/Zh9wwK0Gx1w==
Date: Tue, 7 Jan 2025 09:49:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: Fix I/O queue cpu spreading for multiple
 controllers
Message-ID: <Z31a_CNNcZrIu1x7@kbusch-mbp>
References: <20250104212711.37779-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104212711.37779-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_084903_906520_8EE05517 
X-CRM114-Status: GOOD (  17.26  )
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

On Sat, Jan 04, 2025 at 11:27:11PM +0200, Sagi Grimberg wrote:
> Since day-1 we are assigning the queue io_cpu very naively. We always
> base the queue id (controller scope) and assign it its matching cpu
> from the online mask. This works fine when the number of queues match
> the number of cpu cores.
> 
> The problem starts when we have less queues than cpu cores. First, we
> should take into account the mq_map and select a cpu within the cpus
> that are assigned to this queue by the mq_map in order to minimize cross
> numa cpu bouncing.
> 
> Second, even worse is that we don't take into account multiple
> controllers may have assigned queues to a given cpu. As a result we may
> simply compund more and more queues on the same set of cpus, which is
> suboptimal.
> 
> We fix this by introducing global per-cpu counters that tracks the
> number of queues assigned to each cpu, and we select the least used cpu
> based on the mq_map and the per-cpu counters, and assign it as the queue
> io_cpu.

Thanks, applied to nvme-6.14.

