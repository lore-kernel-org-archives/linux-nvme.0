Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E8C9832F
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:References:In-Reply-To:
	Subject:Cc:To:From:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XhgrofmQAGQvZgR98O4k+vp88XndiOafP36SFSUFMyM=; b=RmMazG9md2tH9zW3lQKrVW3oGS
	z4UPkb/8U16Vy7dsuxmXio+KZSF/1rdmIjKsWy2dina3B4OlTOTtQ9Qct9jDIfUkvjLLTGWY/Kj8l
	d5Nb0Zme6gBOMhy7I9Ba79gy5MVvEldzwfEGWyZw+Wa5xPaA623cqxO7FiC9AmojKGkgShQtF+3hp
	VK654wTf+wb82nzy5YsDfPYLSz43Eb/Zl7/oN9N4cN3njTWQeHyvhDjvkPTDncYvBMUenaew40ViF
	Zijjd5gNVm8MNzERwmilPeKSj9jYWcmNms3QmVmSWvTqxMcPyomx/otfimzS2TOEZg+6kStj+x3gQ
	VjjM6yVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAWNN-0000000FgdG-0E5n;
	Sat, 26 Sep 2026 17:39:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAWNL-0000000FgdA-0mpw
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 17:39:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D9726020C;
	Sat, 26 Sep 2026 17:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA061F000FF;
	Sat, 26 Sep 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444390;
	bh=XhgrofmQAGQvZgR98O4k+vp88XndiOafP36SFSUFMyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mkZGht7x3yNd3LS6HcTIumQBc4oHtTr5FsserxdVmDrHPqDgV8QzPEWdXhecPQEVC
	 zerj8jXPhpNaPkGzeBDimp4zBwy5xgzypxKNEccZaw0bOqUBWM9LbygLoHxKNDvttw
	 /l1lvQHtq/7eFI85v9XQBaT5s6PRIDG7FOT9/4S7vzAMeP4uSg/Ua67JbX5O8nAiWf
	 fvUinYlzmmXHVvzrD6twYYzeMHf0DZCUjEJfFYI75FeqNDyUkVDWWdPOqn88LreKCc
	 orZhLzHyPBAV5agnTHP7+Nncgro8gykxG4ezRsaMwbqPxeIKXgnWIUugzh0Mv8nDRx
	 gBV+bw0LVQYIg==
Message-ID: <2edc9a06c00cc96958723d0e09803104@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] cgroup: export cgroup_e_css()
In-Reply-To: <20260926063328.257023-2-yupeng0921@gmail.com>
References: <20260926063328.257023-1-yupeng0921@gmail.com>
 <20260926063328.257023-2-yupeng0921@gmail.com>
Date: Sat, 26 Sep 2026 07:38:12 -1000
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

Hello, Peng.

On Fri, Sep 25, 2026 at 11:33:27PM -0700, Peng Yu wrote:
> The nvmet invokes the cgroup_e_css for each bio and under
> the rcu protection.

cgroup_e_css() walks up the hierarchy to find the effective css, and I
don't think we want to do that on every IO. Can you update cgroup core to
track the effective css in each cgroup and make cgroup_e_css() use that
instead?

Thanks.

-- 
tejun

