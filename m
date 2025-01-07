Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41166E77199
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGXF1wB8bCUUJIaQSNFm49+CDkJxWr9k9FYfBPdkhp0=; b=eEFz7fTkxA7NO8Wl6vPCDlv3x8
	re+PEBbAKDExTBE7WUSVg639PAHJOAO1BShDl4+5iNsKoz91nnRecEWBm2q/WHN3OJS7waBjJHJVW
	shcgDwpTt/SLnhtmPsyPYOjfEwf9/EA3pKjxhNpI/NS+H00OR6yQNMle1wJ3PHT6lr2cJOziJuvb4
	ruwb1Ys+rCO1SN5/yKxrKLJgX3VHQ34nsvb/gJTvS7DSR5tOU1SIbMvHJQEPmSH7K1Umb7+s4Wiar
	pYQuyBzu9oIljqUzlTOw+xfpdmn/CULEiRFXz095Nwzrl7HEdzb18FEZLaVKYRVJHh7D2DtCdTpkm
	HMRwxMdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVD98-00000005ncs-3ErD;
	Tue, 07 Jan 2025 17:13:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCle-00000005hyZ-1ofv
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:49:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D189A5C45DC;
	Tue,  7 Jan 2025 16:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABDC4CEDD;
	Tue,  7 Jan 2025 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268561;
	bh=HSi6q34ynOZd3HYBqDj2cs/lz3W1trBdQH/UeX9MPH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oONQfQz54Y9eMo9SAjDcLG4W/LUsM/iI0VV1wCVuYLO7cEwBwUg7YGnNrOnHzAMQ5
	 9qF6WNkuzdsB22g0uyfgENfbYxC018qDtHikWDhBMEltN0MTAsvt0Roxbo3pTiezGS
	 1hfx5Q+tygTUUojLgJCZH2Sac0BZpHWzLwwmc8dneMEDEnDkz/zyzlye2MIkXeTzs5
	 5db7p9bYjnu0dvU52rOIofTYvJ8u0+jwKATkiKC8Y3RXEkZ2wMsUL7VwHAXm8v2E0u
	 X4/+u3URGyUtgM6IGm3esnmQXTH0QcV8v1i2sRMhcXLYgYs8AYMdBYUh04VOF4hGDA
	 KHyh6CRq1SJWA==
Date: Tue, 7 Jan 2025 09:49:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: handle rw's limited retry flag
Message-ID: <Z31bD-0YK-V9S5eS@kbusch-mbp>
References: <20241209015344.60861-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209015344.60861-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_084922_512508_2309C3E0 
X-CRM114-Status: GOOD (  13.25  )
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

On Mon, Dec 09, 2024 at 09:53:44AM +0800, Guixin Liu wrote:
> In some scenarios, some multipath software setup places the
> REQ_FAILFAST_DEV flag on I/O to prevent retries and immediately
> switch to other paths for issuing I/O commands. This will reflect
> on the NVMe read and write commands with the limited retry flag.
> 
> However, the current NVMe target side does not handle the limited
> retry flag, and the target's underlying driver still retries the
> I/O. This will result in the I/O not being quickly switched to
> other paths, ultimately leading to increased I/O latency.
> 
> When the nvme target receive an rw command with limited retry flag,
> handle it in block backend by setting the REQ_FAILFAST_DEV flag to
> bio.

Thanks, applied to nvme-6.14.

