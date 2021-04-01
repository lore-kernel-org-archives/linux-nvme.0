Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5687EC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68F261007
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68F261007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Db2GPcFe1ccXKOkBeIVwxIj2xTr2/qBTKi1lnWm1HzI=; b=BWX3glRqkh4pKaWslVdU90OmpE
	bCsrSBEJxd0jczB/y7tMOh90FNieBnljB8JR9iAqVHP0yqv7BvtSqhshtWPTm3Xv+fzQ6Xw6DViTk
	f97CpVn2RXIC7CQiSJI9w6vm8KI2Wq9Hftn9YS8U2IGPHm9URLCk+2W0Ggl2hScyIuxzhsAbXpnFy
	YOKRc2UIFTTHiQJh1ieNaS2/FJbclailo31G/2zkj+YmZqjX+vOAjgLUzGpD2T+F+af/moMb5p2DW
	TgjdBOvab6OSNkruE6ui8wcjn9STv7Oz91X5Z2aW97uAs0EXdfmVTk5GdSXxHm2Q0mC2xKcCmCPxu
	Gh655Wkg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRu1x-0098Y1-Cy; Thu, 01 Apr 2021 09:54:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRu1t-0098Wi-Bb
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 09:54:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9C985AEA6;
 Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/3] Export fast_io_fail_tmo to sysfs
Date: Thu,  1 Apr 2021 11:54:09 +0200
Message-Id: <20210401095412.84254-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_105421_545950_730B64AC 
X-CRM114-Status: UNSURE (   7.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

changes since v1:
 - use sysfs_emit instead sprintf
 - simplify logic in nvme_ctrl_loss_tmo_store() and
   nvme_ctrl_io_fail_tmo
 - updated commit message (dropped wrong statement about
   hard coded value)

Daniel Wagner (3):
  nvme: Use sysfs_emit instead of sprintf
  nvme: Remove superflues else in nvme_ctrl_loss_tmo_store
  nvme: Export fast_io_fail_tmo to sysfs

 drivers/nvme/host/core.c      | 73 +++++++++++++++++++++++++----------
 drivers/nvme/host/multipath.c |  8 ++--
 2 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
