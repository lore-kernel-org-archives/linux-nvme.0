Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087F2C072A2
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AfSxEQDATjSUIip2AJD/tW5xiF6MmuHKZ1c2CtwEdxA=; b=a6RgEzprFS6/Bt0DuQsG5/bUm/
	SqUBIxmb0CM4vBbZ3dvUYbadQEmLFt1vgF/vbiVy59hXYrU0Xat68CyWTGm8HTVOdImWjE639xZ31
	gz9xwVoacWqN/1y35WzrUhmu0bJM9hBw3JJNCAr0LQWWNJczPwl2oUke9sism+c1AbFqDVIxhPKKC
	/Lm8BH0beA/x8N2wBnnyYSZIrusfOgL443FnH0JnYX0gVNlgQcw57pnr0/UqpB2Mf8PEEAyzsjFgr
	nLX8JxM+APxmziyMbSF8f6yrsBA6NBvk20RdkPkyqW00ltfvzc/tnW/O2+9oYQBi+K6GbfFnRJLzp
	V5mDfyxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Lz6-001cn8-0w;
	Wed, 15 Nov 2023 19:55:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Lz3-001cmk-1G
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 19:55:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 96918B81BEE;
	Wed, 15 Nov 2023 19:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7071C43391;
	Wed, 15 Nov 2023 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700078131;
	bh=IOan1DViLVGL6648KKxdL6vpXPpwQ8TXSgTEa52BCw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtD7unuSS0BM5OxTbsi5PQ2oE9yibweiJQFHhx+95WoD1oZOw6+VGGm5uNa5RvI5T
	 Gip+8YO45FV1XbWkPc4Y4EHHg43w87aregHWAxP9+XJ7jfpB7ZOaw57oHOMzOmDbaj
	 5ZgwODMh3JPJ9ZS+P75rmNqdvuPvK21gJmTXEfyqas82F0PMqpQ3/Kbsn/0cogj7WF
	 lMUkGgFPp/mO0tI5GzVOtiV42Eplf4tdYYoLo8wknoFPHTjJfqKATT2YI1JMwWGZAn
	 CPVK+HYl7WkWKySRlAEvABXBDkYAkEi3N7bqKWxlXvapqoNt8xNutsOYvumgdHbXoT
	 hraZsf+aIK7bA==
Date: Wed, 15 Nov 2023 14:55:26 -0500
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_115533_583849_FFD0C1FD 
X-CRM114-Status: GOOD (  12.37  )
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

On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> On Wed, Nov 15, 2023 at 11:02 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
> Do you mean something like this? If not, can you please elaborate
> "when we need"?
> -               struct nvme_effects_log *cel = xa_load(&ctrl->cels, ns->head->ids.csi);
> +               struct nvme_effects_log *cel = (ns->head->ids.csi == NVME_CSI_NVM) ?
> +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.csi);
> Will it be good to change ctrl->effects to ctrl->effects[3] for
> already defined CSI?

I suggest either re-assign the cached head->effects to one from a still
live controller when current path is removed, or move the saved effects
to the subsystem instead of the controller. All controllers in the
subsystem should be reporting the same effects log anyway, so
duplicating all that per-controller is kind of wasteful.

