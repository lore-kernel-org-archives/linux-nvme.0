Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85488C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573A360720
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 573A360720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eZtWEg8RFhEVXL60WgstW7U2u2C0E8QASWxDHVHvq6A=; b=4ePjDLOBPlRVZZzRrjGsHjRHtq
	fxiXTzjHLaBEPBTSfaIfw0liIolTUBntgskxnDD/azwSnaej1TkDwqbrqbWjPX2gKEJvs1MTZU0EM
	PK4IOsBzuNHMrrl8mSvCHZjT+K1WLwa4r4/DMUbF5y6LaJPo+98aWqvoQKyCSomX2B724JG1UKVqt
	OKPLjJwd9r47SSJB4nvO7AuAV3TIaknqZARfPrp9HGyaacCMoqOLCM9ZmlJZhp17m8C3/RLMf52oi
	x6R8uv6Li+z8qSLhRjk2SD1fvv/VtwTWWYgZZp9AEsIZa/iHchb2swTLfUSlHVtTDvVxwdSVHObB/
	oTV0T6pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg6PJ-008AFT-CO; Thu, 28 Oct 2021 14:29:29 +0000
Received: from [2001:4bb8:199:7b1d:487c:3190:e387:3394] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg6LF-0088Xh-2l; Thu, 28 Oct 2021 14:25:17 +0000
Date: Thu, 28 Oct 2021 16:25:13 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YXqyyRRUV4GJis4I@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 9fbfabfda25d8774c5a08634fdd2da000a924890:

  block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-28

for you to fetch changes up to 86aeda32b887cdaeb0f4b7bfc9971e36377181c7:

  nvmet-tcp: fix header digest verification (2021-10-27 09:20:50 +0200)

----------------------------------------------------------------
nvme fixe for Linux 5.15

 - fix nvmet-tcp header digest verification (Amit Engel)
 - fix a memory leak in nvmet-tcp when releasing a queue
   (Maurizio Lombardi)
 - fix nvme-tcp H2CData PDU send accounting again (Sagi Grimberg)
 - fix digest pointer calculation in nvme-tcp and nvmet-tcp
   (Varun Prakash)
 - fix possible nvme-tcp req->offset corruption (Varun Prakash)

----------------------------------------------------------------
Amit Engel (1):
      nvmet-tcp: fix header digest verification

Maurizio Lombardi (1):
      nvmet-tcp: fix a memory leak when releasing a queue

Sagi Grimberg (1):
      nvme-tcp: fix H2CData PDU send accounting (again)

Varun Prakash (3):
      nvme-tcp: fix possible req->offset corruption
      nvme-tcp: fix data digest pointer calculation
      nvmet-tcp: fix data digest pointer calculation

 drivers/nvme/host/tcp.c   | 9 ++++++---
 drivers/nvme/target/tcp.c | 7 +++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

