Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1ECCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qcwjQJ8aa0zxHItXZL2fWwikUo7JQNUfGhn5yOVqZc=; b=vUkdCbf2m3ZvPyFLHK4XfOuKZL
	wNjZwD1Z7fqzKOYxTOswjoqx1Dr/ASTTRDeobT02DYu67bnrXCe5NNKeiVCww8cRSn1aLdPRqn1sN
	5zrCL5coALEhlYrft8ogSU3M0EPkDSBb7F6+mB3VG0ZtLFIM51sd1Uu+cL6ITIkS8OT6MOq1obV95
	7XAGtZ3WZWTvY3iaWmfJ56N9cZ90IbQFSO434bicK5FmVnwJZP5baY2EyGqYM7hPPnRjVnCxwsNNw
	BWuxXA70DiG2C4qYTyvC9GKOUnS9jNaC86HId3X/0MUO3OsTynLmOIQHt/bJfxRgXuGfW84NmxVrH
	LgD1uhAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ1M-0000000CioL-3s7b;
	Tue, 04 Nov 2025 23:01:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ1K-0000000Cio0-4Bfa
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 23:00:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B586601ED;
	Tue,  4 Nov 2025 23:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F712C4CEF7;
	Tue,  4 Nov 2025 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762297257;
	bh=jvOGFBcZtmj0o/kU+NH12xbIbRwMWynb9wLsN8izqH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9tM7hqJMGeHJkPqSpduxY2zQ3wvrIixH16kvT/lGeNhFRkBAmWnVLdQJdW5XCIU+
	 YIYvrtaSxmrZf05CjdlmjzMtV988xSv5oN7xzHRuJGDOhfvchL4APfjS5/bmzWC4SX
	 p4JslFr0gbncr0JjrCsTWn7QxTe9l53bxoDkU684hCPwWWM2IYiNPy9Dq+V2SDxjQ1
	 heVhAjfdV+BlVU2zf30/NaksmC+jGB/GTzcrJ9eaWgSnzhh8yff46koX07nM491gRq
	 rtLBhm18GG80uvTRC4nri3WV+dpBAQ23iev5KgqquYdVKaa52vaRMKBwjr0THXM0Rn
	 28AXNXefi3row==
Date: Tue, 4 Nov 2025 16:00:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQqFpwNzCWcvHiKN@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
 <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
 <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
 <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>
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

On Tue, Nov 04, 2025 at 02:39:47PM -0800, Casey Chen wrote:
> Hi Keith,
> 
> Could you make a patch based on this ? So we can backport upstream
> patch instead of keeping our own patch. Thanks

Sure, just sent it out. Wasn't sure if you were planning to do a v2 or
just use what I proposed.

