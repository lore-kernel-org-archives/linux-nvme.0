Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7429DECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LfByY2ZEH3vA5t9jzfkKtac9gkUPV4cP+QjyySZ2GFk=; b=vU0i0gHJd/4OBul0mT2VQivfNu
	2Fq8nI36w87Ybzhyg6oflFnN77mu2q7fOjz5N8Nbsmw/SrM7XGheh5SQhk3FCJYKx0M12JrsKEGyR
	tzouRsuKOfBqn+dRkB4ocJeRTFUZD0ORrID3iZDuq/bmqbF6DAYgI90WmP8adFc9yHKQHNZiVZBX7
	pRGIWrM/JP1wtM0lLCEgRTC4EQYY4pMKifvPSONR4ZvyvinXfU7TvKPFFPrLgmKtJ4Js16vLE6BwQ
	Qpr/T6WyFS9q05Y9yShZuVqNK6PnOhxJGJdU88MhZAj6fwXBa937HInTRF5gYynrsIRa3vvIDzOKx
	Ca3EmFdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPks-00HS7k-5H; Fri, 28 Oct 2022 13:50:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPko-00HS3M-8n
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 13:50:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0F13621B75;
	Fri, 28 Oct 2022 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666965029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LfByY2ZEH3vA5t9jzfkKtac9gkUPV4cP+QjyySZ2GFk=;
	b=okxWIVipoZAkEqUOcuN0GCNdtTGseaoaOoagyAr90/ltfCIXw7ha9+KXeS6gbGV+ww4DRg
	VYOOW0zUKz0AJb4Y+Qv6AzEJT5JyMsV/G0FghRr+SwlTBA25tzASlQxgM0/dFmZ+HEUht3
	+nbHIi4ilUWSF1kErj83cuIaBlQJ3UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666965029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LfByY2ZEH3vA5t9jzfkKtac9gkUPV4cP+QjyySZ2GFk=;
	b=mwVOy3LqkbWwlOwTmiWb+u/xqwrz8gzDWx/nS/tKu5XzJ8csvvrHIz6OPDrdlDiASW8LQx
	uxNHxjTWGgUtapAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0672B2C143;
	Fri, 28 Oct 2022 13:50:28 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 7E85C51AD2C5; Fri, 28 Oct 2022 15:50:28 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvme-auth: avoid locking during authentication
Date: Fri, 28 Oct 2022 15:50:25 +0200
Message-Id: <20221028135027.116044-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_065034_502076_8950D54E 
X-CRM114-Status: UNSURE (   7.94  )
X-CRM114-Notice: Please train this message.
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

Hi all,

blktests have uncovered a possible locking issue in the authentication
code. These patches rework the authentication context handling to
avoid long-running allocations and switch over to using xarray.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-auth: allocate authentication buffer only during transaction
  nvme-auth: use xarray instead of linked list

 drivers/nvme/host/auth.c | 163 +++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h |   3 +-
 2 files changed, 88 insertions(+), 78 deletions(-)

-- 
2.35.3


