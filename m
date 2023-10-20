Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A42C00A98
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kf4RajCGehVqMz4/tGShkbjuztEMw0lM0gM6nSOge2w=; b=F2uixV+ZgQ8Zz0AoK6hQNe0I1+
	lrEysQRFIedYc3u/3WoCdRJTH24tsi84tCc5nj3wBOhsWbGYK1TvBd1x9Lea5MhXhCo1hq6R1rOMh
	sACXxVz7GJmJ8QgCq0Rfm/Md9VVNaMKY614eoZybhmEssA7DbMYZ9GFk3ZXYJRwUgbGAHBE2jJ42t
	CUveAIeofvice1SeTohAbygX92WzbIR9XQE4pQSxJTB+nmZwF3qVPTSfjaeyS8q2SkymmNvAaMrgm
	Hi0wUfMm/OUcnyNBg9NFCR1khvWzZ9oglQ83gmkfEvWLbGqSK5obP9jdKieKPgwHUqh5X2eLaqG0/
	DuI+cdwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrSS-002bq3-26;
	Fri, 20 Oct 2023 15:30:40 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrSP-002bp9-1D
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 15:30:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 64F36B82215;
	Fri, 20 Oct 2023 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2749C433C9;
	Fri, 20 Oct 2023 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697815831;
	bh=Hu/X55yQ3W/gV7nnfr9dOtpZvKMzpbyyg48V3U8X8Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfJ3Ik2r0xw4sLebVQ6I9LHwNpEvJvB2hpbK8OpEqzRYzMrTfNzeh9FAwMXJMTISF
	 3ktIxArnbyh7tJkFsRDtckN2PcdelnOScXTtoEljgIdsVAMLyYKg8ZcZHw0DkgEFwF
	 B9mubWJwhX++seWTDba6UY3dUFfmigswgKzv9VrSOG8RXXAcSTCkf0mqU8mhozNpaX
	 4HgGdfQygOoSlZxuIjXt0iVJLpbe0kinsE1FwW7t2jX/83Fgfhjc7Jc+JNHmeIwuFh
	 MecMYA/QSbFmvgmDJqqQaMMADpD2HybLn0HXcPsIsoA++4lD0/upTkVNBsvbn6Ts/Z
	 I/YEqZbNfGLyg==
Date: Fri, 20 Oct 2023 09:30:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] nvme: start keep-alive after admin queue setup
Message-ID: <ZTKdFHTw3949UKTv@kbusch-mbp>
References: <20231020142600.47246-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020142600.47246-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_083037_568430_868C2DF6 
X-CRM114-Status: GOOD (  17.10  )
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

On Fri, Oct 20, 2023 at 04:25:56PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> Setting up I/O queues might take quite some time on larger and/or
> busy setups, so KATO might expire on the admin queue before all
> I/O queues can be setup.
> This patchset fixes this issue by moving the calls to starting
> and stopping KATO into the quiesce/unquiesce functions.
> That requires some refactoring/alignment with some transport
> drivers which do not always quiesce and unquiesce the admin
> queue.
> 
> As usual, comments and reviews are welcome.

The pci transport doesn't care about keep-alive, so I don't think we
should force everyone to have to consider it.

Wouldn't you want to start the keep-alive on the connecting state
transition? Something like this:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa2..a44b1206b20ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -583,6 +583,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
        } else if (ctrl->state == NVME_CTRL_CONNECTING &&
                old_state == NVME_CTRL_RESETTING) {
                nvme_start_failfast_work(ctrl);
+               if (ctrl->ops->flags & NVME_F_FABRICS) {
+                       nvme_start_keep_alive(ctrl);
        }
        return changed;
 }
--

