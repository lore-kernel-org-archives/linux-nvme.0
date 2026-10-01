Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FA7CA5FCF
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8MODFbKIDDrvoDt04zQa5qco4SxCWWHkK7Oz4Y0sy4=; b=C6OvVN0gveQEQrAmHmONsAusBW
	8+pJpe5EsisxnQY6/7g9FfcVn+dmY+HjaHsatF/XEvlbkCn2P6LhrS/Yso2AsD8KuvbQxwsnwPQce
	5rRuN0JQA5bTW8opB6YJQ8BA77+KKpNNjulGbMNSIjr9mgUiNzqOlIE0E2Y0rMwDrtq112LXdZOut
	vLcu/uB4pdIEGSOge5EBDYS8u5Es98LV69klxV5ywBH0cYW1ixve/Knn3OeEAOAFGPuYVbNCFxxPG
	99JZUcDlySKELpdI+Msa98ZAg9V5mdR3WClmexUpaZLYjqadt1IhpvcPEoaN/EzPYkVv1hkO7MdrZ
	k469IKpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCL1D-00000009vQO-3PCl;
	Thu, 01 Oct 2026 17:56:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCL1B-00000009vPu-3Snt
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 17:56:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F65340920;
	Thu,  1 Oct 2026 17:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3171F000FF;
	Thu,  1 Oct 2026 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790877389;
	bh=Z8MODFbKIDDrvoDt04zQa5qco4SxCWWHkK7Oz4Y0sy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZUcRCyG91qi5u6jehSUNqqPIM4UU5FK+Oy57uQATRBt4BETrQpfEUmR28+n+8nN9Z
	 aZnEzP8BKrZQUXXCGKbwnn+UeJXNIlNWwg3FcHn0Has4Uqo8lQi65BkrL0DeFsTDKD
	 2UTB+9UY2XQU3tPy7BNih96V5Isbz5+K1xkV00VnpSoRABFRZDJB8Tz9LxT/8PfOlG
	 GT8L+SL2Th/STCxC4cfWOQubb9dQE90UmycrXO2pqMpsjbLWgIVrVVZq9UNtdPo9NM
	 ywIiQjm6vxtT8h9ji6ghGILeM6jfBON2FiN5qaXSc5vQgcUIPELfoI/NV9LRsTAPQK
	 w0pb+XHxyyM9A==
Date: Thu, 01 Oct 2026 07:56:28 -1000
Message-ID: <aa7f5ccd9fc7a7770336a48f458fee19@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] cgroup: track the effective css in each cgroup
In-Reply-To: <20260929232411.101087-2-yupeng0921@gmail.com>
References: <20260929232411.101087-1-yupeng0921@gmail.com>
 <20260929232411.101087-2-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

On Tue, Sep 29, 2026 at 04:24:10PM -0700, Peng Yu wrote:
> cgroup_e_css() and cgroup_get_e_css() find the effective css by walking
> up the hierarchy until they reach a cgroup that has the subsystem
> enabled. Per-I/O users such as nvmet need this lookup to be O(1).
>
> Track the effective css in each cgroup and make cgroup_e_css() and
> cgroup_get_e_css() use it. When a css is brought online or offline,
> update the effective css of its cgroup and of all descendants.

Applied to cgroup/for-7.4 with the subject capitalized.

Thanks.

--
tejun

