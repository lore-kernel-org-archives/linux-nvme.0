Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205A7C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQYLcpX0GTB99vS8l3chTrWS9/qj1MLg/Dw8k/7Olow=; b=mmYrOddbJenozQfyXP+ES7ZM3D
	DMbVgJaJAXxlLI6sG40g9UuXjdX9FSzGUxVx72PKgiU7pXfKJj60n0dxOSdC3TLCzfsAIlhnj26pg
	a5I9J3+UE8YIKHnJA2KL3YsYrvTdItjuu2LYpS4hutxpxN3xld3E9Isdmfii41+6zK8XnUpYTWMdF
	fizGGvc03h+YoF7PTzDae8Y1NUWJVlS/KVm3wBYu8pCEX37qt6ZUn90e34a9YiDYkQ3THRd9p3EaX
	teToxB1ydxHDpYknI+MpWeQIOLmhyIimysAu/885P8kvYOJtPiP/GgAqPr5OsDFGx2sjBDY2th9cz
	MbkvgvMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQ0-0000000Ewvn-0fMa;
	Tue, 11 Aug 2026 20:49:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttPy-0000000Ewvh-3dAa
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 20:49:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 217B9600AF;
	Tue, 11 Aug 2026 20:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566F1F000E9;
	Tue, 11 Aug 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786481389;
	bh=VQYLcpX0GTB99vS8l3chTrWS9/qj1MLg/Dw8k/7Olow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JYDTWYpucU2yT0k/tmDG/xjbZyV5eUFuJslkdop2E0jMuChSlvFGB5iyp4oD0PkwK
	 iHm0rl/kpf4ZnLMTvgsNvJV3A+oHP3WsBP23HXozCfBcsrYXlsy9Q/bA02rA+KV4rY
	 Ii//Sm10ZXgK3qk7rwX3Gzo3uQhekyOA4P+v4qvsMxjMQXOMmZKgZqUtlx0mcvubMC
	 DLUU/aV+tD9yR73eKYmr0e9yKUPTBsnUS2/+4zKSG5igA0KYvy/TymkT78hrHrK3Pc
	 J6wRdBtKYfMnjIiJeooTawx65ieL/OJlRMlH5WGgz5H9lV3QJH231hQhAavVZ6xpYv
	 tSuluCq0KrzUg==
Date: Tue, 11 Aug 2026 14:49:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com,
	wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
Message-ID: <anuK7GONhd3scxb-@kbusch-mbp>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <ant0I66BcAugTyGX@kbusch-mbp>
 <07ba01ec9c9f54da7cf7b3b4096f1e7e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ba01ec9c9f54da7cf7b3b4096f1e7e@linux.ibm.com>
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

On Tue, Aug 11, 2026 at 03:33:19PM -0500, Wen Xiong wrote:
> On 2026-08-11 14:12, Keith Busch wrote:
> 
> 
> > The result of nvme_find_path() is just the current path at the moment,
> > so I don't think this is right.
> > 
> I thought:
> - if policy is NUMA, returns current caches path if optimized.
> - Otherwise scans other paths to find a new optimal path.

Let's say one path is rdma and the other is tcp. At the time you open,
the RDMA is the current optimal path, so you take a reference on the
nvme-rdma module. But while using this multipath device, the RDMA
connection is lost, so we failover to the TCP path. When you close the
multipath device, you find the TCP path, and then drop a reference on
the nvme-tcp module, leaking the RDMA reference, and underflowing TCP.
 
> > I think you need the head to hold a module reference on every path the
> > head has, so the module_get/put should be in nvme_mpath_add_disk and
> > nvme_mpath_remove_disk.
> I will check this.

Just a note, unlike I initially thought, nvme_mpath_remove_disk() is not
the mirror teardown function to nvme_mpath_add_disk(), so the path's
module reference put will have to be somewhere else, like
nvme_mpath_remove_sysfs_link().

