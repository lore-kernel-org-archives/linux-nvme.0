Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B4FCAC5AE
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bArikHf3YzB/z6MTBugIgxuLVx8s1w11i41gqhM3VBU=; b=osm1kyju479Xa3dg8X8j55ChgY
	vMRd1yD+283hOwMu//wdSxf+/jOtAyHDYS8iKvblQjOjkMHsDyLBme58WtPvhzqb/AhefLBytu883
	BMhaCnjNE3YqVQXGxVREo/mmlhesCKK8gh5nZYsSNjc2KccELnUPjiatSbyP9W4md9u/NuZG936t4
	HosZg4u6txp8T/aPc+Pow/pU1lFDS1Y6nkFGFol9e6qQFi05Vq8E6TOObHTsw45l2CmhDO7k1tVy8
	lO/z1dXmamcSm6WQlXk5nizoE7pDTf3siJOabzQ0zHGAlebHt5/sRIoV21Dr/ID6u8cgX9mfpaeqP
	qvWLuBLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1XkQ-00000004Bvv-2Hnl;
	Wed, 24 Sep 2025 22:14:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1XkO-00000004Bv6-3d1j
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 22:14:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E750602CB;
	Wed, 24 Sep 2025 22:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65FDC4CEE7;
	Wed, 24 Sep 2025 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758752040;
	bh=nadUpJjkhRUZQ1NwhFr41xFgTZlYmYP+QMIs1UV38JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kb5OO1wrYMox3ZFTdYIPffxEJdqOH/QdjT4FGpC/8Ji93tv8MWHNE8Ii4B5CQ7sTg
	 OnadgNhqIgOuYwYIDxLuSXeAZWsAfMbOrtN77oEje67gS45p8ICuOMWrJK4mFysRI9
	 7ie1PJ+M4fBBr6/LGfF15lMj43J9J69fazN3H5a9l1jgEXQRMoKWHWBoD1CXL6OIiK
	 l9NfjbkT6V1409jCELadLV7tzmlJyDs1cjKZ7PjCHDV1aMtzfSxoEueq/2Fi6V5Nu2
	 OgI92L2lzkb/aFDHdZcWsl7LbzkWFhuACYqp5SYns86RNNcP7Mc+MuLpLMQnT0uKot
	 11LNxAmaA8s0A==
Date: Wed, 24 Sep 2025 16:13:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kch@nvidia.com, dwagner@suse.de, israelr@nvidia.com
Subject: Re: [PATCH 0/4] nvmet: fix configfs attr update handling for
 discovered subsystems
Message-ID: <aNRtJZL7uxRaHifz@kbusch-mbp>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924202604.7201-1-mgurtovoy@nvidia.com>
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

On Wed, Sep 24, 2025 at 11:26:00PM +0300, Max Gurtovoy wrote:
> 1. Forbid changes to controller ID min/max attributes values on already
>    discovered subsystems.
> 2. Switch cntlid ida allocation from global to per-subsystem scope,
>    matching the granularity of controller ID ranges.
> 3. Forbid changes to vendor ID and subsystem vendor ID attributes values
>    on already discovered subsystems.
> 4. Forbid changes to max_qid attribute values on already discovered
>    subsystems.

Is there a reason these should be changeable after they're initialized
even prior to being discovered?

