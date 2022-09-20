Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A5C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oM+405BEQkBFDNlhDQU9OSDLk8UPzWyy5EMFLMdN+2E=; b=K1f3r8nRlWqSvI4pHN1cKB+9A7
	+mLC2xvppjKW4HrAxyAtSyBSd1GJZDo2nC1iXr6X1JyPGUwCNwjIyO6fvwwChlPyjQ5HnRfwGZ8lr
	mGyc78PdPS58h9Y6hXyTz/1QsAvOYtqK52nH7NqPfIW/ixHlwqCfd2jSjflH6Q2l8qQd1CIKsysxn
	C1A1H92b7lR7EbvJ82vmVsmnttTc8dKjywrwqQnfBacJnINhZTjm1ZoX/QRFUkVnKfEPxYTfycWHk
	giVV8I1foulNbH3yX5dbIC/SR6RxuBETYPMmfSrYnsFdl9CilCKnfub1e6Z1YtpHU1pLAIFQ42VgF
	2A+3F+4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguK-005NQO-W8; Tue, 20 Sep 2022 17:19:41 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguE-005NLi-J0; Tue, 20 Sep 2022 17:19:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: nvme fabrics authentication fixups
Date: Tue, 20 Sep 2022 19:19:28 +0200
Message-Id: <20220920171931.1289669-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

this little series fixed a debugobjects complaint with the new
authentication code, and some other bits while looking at it.

Btw: Hannes, can we add you as a co-maintainer for the auth code?

Diffstat:
 drivers/nvme/target/core.c             |    1 +
 drivers/nvme/target/fabrics-cmd-auth.c |   13 ++++---------
 drivers/nvme/target/fabrics-cmd.c      |   18 ++++++++----------
 drivers/nvme/target/nvmet.h            |    7 ++++---
 include/linux/nvme.h                   |    4 ++--
 5 files changed, 19 insertions(+), 24 deletions(-)

