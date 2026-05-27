Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19617CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ab2HJ8Za032F8Qytnn6DKP9PrueMPVV04mFMTh1CmjM=; b=DWfA9JZhmT36VnsZIfMs0h1L8Z
	fPTlYIcf1qQMaWQzhd8ShRz6P1JCior5bvawhn64H8wXw/aAkMoGLxfAfg4hgC/wFxn0ZQhljjThn
	HCJ71JfOuHaz9QXMUtjTk+HIcmkZAeKWmu68sNSaCcPR1TQCcbId5P/SyxUOjBu7JTfY8Kn1mFHBO
	nyef0zmk4agJvzHNAoCxCbLQ8Q5jsWL8VYBhXtLY9ce6dB6GtHSRbae3wZFa4OPxb9h1O1kEKXlYN
	QjPusSMUA5t+FYQT5ASHIlY8N7Td6jvW+N+HS3710LZGa8TP2jOJMeHqLCrkk1GxyTDLziNdD0ln7
	NYzu4y0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuD-00000004NZ4-1asY;
	Wed, 27 May 2026 15:10:49 +0000
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuB-00000004NYP-1aYb;
	Wed, 27 May 2026 15:10:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: clean up bvec iter helpers
Date: Wed, 27 May 2026 17:10:19 +0200
Message-ID: <20260527151043.2349900-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
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

this series converts the bvec_iter helpers from macros to inline
functions, and to facilitate that cleans up a little bit of code
in the loop and nvme-tcp drivers first.

Diffstat:
 drivers/block/loop.c    |   24 ++++-------
 drivers/nvme/host/tcp.c |   27 ++++--------
 include/linux/bvec.h    |  101 ++++++++++++++++++++++++++++++------------------
 3 files changed, 84 insertions(+), 68 deletions(-)

