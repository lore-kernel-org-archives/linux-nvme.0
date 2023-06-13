Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF2EB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rz+MvUN0L8ibBl9HEERCSlFQiDhgrt46iEHzqWHPbRk=; b=fTbseNhBtIdypKorBXCRAccaiQ
	1HkNX4Qq6L8efZPvDJMvaFEAuj3tlS8lQassFmN2Tnj1th5tu8bpgTrarbIL91d85FwwHxVTlr5yh
	jCk/g7RM73WtvTgtli+eNSCB72j8J2V4Ki9oE1YAGU4drZkba8ibfWa3xovuVy8e11iloYEMn9noT
	avslydDNLnIRxDEtThqlMHli3qQxsvD5vX/hgyALh9wVMGJnm9HUWrlTNhyolFxbbd2ys3qaBhK01
	yzuj7yONa/J97BQ6Nb6wMpjoyZrrBWPGmXY4hyqVv1qT15L5LSmLDsdHUFR/lScQuGUGWaRICWkrl
	6NXSNPbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q95DW-008MIR-1V;
	Tue, 13 Jun 2023 14:41:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q95DS-008MHf-2t
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 14:41:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6A75063718;
	Tue, 13 Jun 2023 14:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59122C433F0;
	Tue, 13 Jun 2023 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686667309;
	bh=rz+MvUN0L8ibBl9HEERCSlFQiDhgrt46iEHzqWHPbRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFF5lZue2Y5RtMYy4iJ03ENWntYI/A6FEw/W3rnw6uAcCsBQpDAuoviVkYjf/QQ/O
	 z3NR7BMuUChnsyON/8PvNmeGoO9RGg03SPPLp8AHnQ+OmMvuE8uJHeR8JqJBlt7Jo6
	 3GoDzJ6jJgHAI4Npdb2gNb0J6e7oFqPsSwybFt1HRPv9rn+w6D9sTolLUVwUuoghN1
	 EuVhNu1yBQm6rY1Coo543hjPHZserD7V0nIqwmtTO46FSpAkzWT7EBHhO8ql3rbXA8
	 s6ecfZibxgvgRYFJjg+H52m4yN4GS+YCHcSHCpNpUln4O9Vd1oixaCwbAI1yAFTz41
	 y3ys/ygefEjJw==
Date: Tue, 13 Jun 2023 08:41:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613005847.1762378-3-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_074150_975890_E159998D 
X-CRM114-Status: GOOD (  13.93  )
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

On Tue, Jun 13, 2023 at 08:58:47AM +0800, Ming Lei wrote:
> And this way is correct because quiesce is enough for driver to handle
> error recovery. The only difference is where to wait during error recovery.
> With this way, IO is just queued in block layer queue instead of
> __bio_queue_enter(), finally waiting for completion is done in upper
> layer. Either way, IO can't move on during error recovery.

The point was to contain the fallout from modifying the hctx mappings.
If you allow IO to queue in the blk-mq layer while a reset is in
progress, they may be entering a context that won't be as expected on
the other side of the reset.

