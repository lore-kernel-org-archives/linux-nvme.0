Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76161D19509
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QBZETQDbqnS6AvKXW9wPkVxMd1Yp80cK7EzpJHaLw8I=; b=FnoOjoFKcn16lV37sonYtcUD85
	bpLRV9CuFoOB2El1Oi4RlJ6i0wIkWG/IlAGvA/6oDCdUfrVnv9ra0RZSuro8iRhYMdoO70DzurPpv
	yOo9IuZxOVB0gEu+2AmtPV/BUv1e64xu0Sx3mb06PTKMESlvGHQv4s7P6wRWwXeMDSFeAb+ekriFc
	+pwmV7fhxBsQt4SifoFdfbEX0Y9KPMuo2GWjqjGT+sh6kw7EUwNYHXChzAgySx0Qijz+jCkFwKkeh
	cKmNVIigbCLnkuDbe24GSdIaEdy05/t7BoWqaONtXvT41d1X//NYo4goEsKVVHABBYBMllWh5Udcl
	cxsv79xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkQ4N-0000000CvDE-0H7Z;
	Mon, 26 Jan 2026 17:08:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkQ4L-0000000CvD8-3lyk
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 17:08:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 07C4F60097;
	Mon, 26 Jan 2026 17:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76757C116C6;
	Mon, 26 Jan 2026 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447284;
	bh=OAWhyYVhQDKW9uekngFgAb5qs2H60gD2XG/KZ5LVlFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSP3eiWQk+suIF6mvMyUmf7TkJw0yen3E4UmnYN2cunNUJolepLFgm5M3z/Tz0ZvU
	 Q6OcnekSWA1jCEeTTkjqPtkUG2cbfBtKHECiu1ASmyYJnaas0krSkOtmQlam+31YXj
	 gNQj42dpKNCrxD1IgqVSd+S5beQFtImuibXsI15ZEioQVMHPD19T6xxrHuOHAijjxL
	 YqdU1v2jHWMO0UgQSgHp5bCE3+Wr2IuTc9gN/NMK7WtpdUNhsePpzCHmkfpXEfFYVx
	 2rED6ZhECHNmzDGp1BA+YE2mdH7DDw9qIDR7xj0Q1nl8Mqn63FCcQHL296mGl4iK2D
	 ZHeyDoSnFEffQ==
Date: Mon, 26 Jan 2026 10:08:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH] nvme: use NS head lock to serialize access to NS list
Message-ID: <aXefchA1e5ShuVnz@kbusch-mbp>
References: <20260126164552.3379194-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126164552.3379194-1-john.g.garry@oracle.com>
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

On Mon, Jan 26, 2026 at 04:45:52PM +0000, John Garry wrote:
> @@ -702,12 +702,12 @@ static void nvme_remove_head_work(struct work_struct *work)
>  			struct nvme_ns_head, remove_work);
>  	bool remove = false;
>  
> -	mutex_lock(&head->subsys->lock);
> +	mutex_lock(&head->lock);
>  	if (list_empty(&head->list)) {
>  		list_del_init(&head->entry);

The head->entry is linked into the subsystem's "nsheads" list, so at
least access to that still needs to happen under the subsys->lock.

The other lock changes constrained to the head->list usage look fine.

