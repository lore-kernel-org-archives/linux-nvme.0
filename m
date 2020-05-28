Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D81C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 13:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A5E207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uf10DSs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A5E207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nwRcEWMRrHg9Mu7KBHiG38Sfsf4571SCjMlzQdy+nAU=; b=uf10DSs2A1WOc8
	Yqc63/MEOlwbFitZYJPzEoFsuuK3WYTCxN5vVfD9VGGtbceRpEozPScTCnRYuQ/RyqphvvElbtILp
	V9H03Dax3wnXfejXyECa/AOq6m6W5k5mRiAGmjUbBJuhYZvG6m3rj+vhmhP2bEgSJF9kwpQ3x0Ohg
	Opt0JmxGK27zoQ2Y1fIow590PM+M1GLesrm+LD2VA5QdwYnUpoEmqSW1FvI3o7T0AGER2nIQ4jwU6
	lpT0WuyVh76fxvFOXDvHYNHvU/8N+QrG7355eFHCuaJUG9F0mkF27Gvbf2OLckIk8wGfpDHHG4CPM
	mkaUKRKQB5XqAL7F+hXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeIUX-0004o1-Fx; Thu, 28 May 2020 13:22:37 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeIUT-0004mt-Ts; Thu, 28 May 2020 13:22:34 +0000
Date: Thu, 28 May 2020 15:22:31 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@fb.com
Subject: [GIT PULL] nvme fix for 5.7
Message-ID: <20200528132231.GA837884@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:

  nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to 9210c075cef29c1f764b4252f93105103bdfb292:

  nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll() (2020-05-27 20:32:56 +0200)

----------------------------------------------------------------
Dongli Zhang (1):
      nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll()

 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
