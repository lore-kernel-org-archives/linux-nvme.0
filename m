Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F9C55179
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 02:15:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3181722249
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 02:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZIK8Y2yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3181722249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yJGfHos35lt6ZJETyaj2BEL2BzDlSUBLPpz0b7/AROQ=; b=ZIK8Y2yWvOV76RlJDwFMwdbX5F
	Qcsyxbd5XuodMU3os919PgtahAdaZidMwt0Mxb9ucqVl09V08xgnhT5Er5ivJD5nUu/t4VgVgWKAC
	Rw+QdFARJIw4jXcNDz4ABBZ305E48oNvWDLFeK1ikPMU+oHqlycCTiPPZ5I8PYkIcweoF2CY0aDem
	XxdhBkG4dgJiHFVHI5LI3DLMZhIf0kgFRRuwfqioVAXd5BKOeRcvqiOiBqvJ32xZKdm5i9fMuTCP8
	tUiTNv1wryS+przieusJSofivaSqu5jRZxZ8mtbK9F0HHKOL/PdT74Fxd3GCdc35PFdJUcpkITaDx
	bKlz2ONQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVQ8O-0001cZ-3z; Thu, 22 Oct 2020 02:15:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVQ8F-0001bg-CO
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 02:15:12 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A826E827E5E5123A2BAF;
 Thu, 22 Oct 2020 10:15:03 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 10:14:52 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 0/5] avoid race for time out
Date: Thu, 22 Oct 2020 10:14:52 +0800
Message-ID: <20201022021452.10971-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_221511_680500_FE16194D 
X-CRM114-Status: UNSURE (   6.35  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

First avoid race between time out and tear down for rdma and tcp.
Second avoid repeated request completion in time out for rdma and tcp.

V2:
	- add avoiding repeated request completion in time out

Chao Leng (3):
  nvme-core: introduce sync io queues
  nvme-rdma: avoid race between time out and tear down
  nvme-tcp: avoid race between time out and tear down

Sagi Grimberg (2):
  nvme-rdma: avoid repeated request completion
  nvme-tcp: avoid repeated request completion

 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c | 14 +++-----------
 drivers/nvme/host/tcp.c  | 16 ++++------------
 4 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
