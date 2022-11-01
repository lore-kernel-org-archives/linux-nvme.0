Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AC8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h76+5d/iC4L1V1jcubbcI5HntloJCHxklBhBHsPzTWc=; b=NU2diYOl6FdM4fUUaDB8zHFoO9
	dUE9ffs4jHBqq0xEswWKMaUOpfkPAPwomhgezMOWI9CVbx9ciMo0SoZYKRN2/skuzUnRMiYCXmtDf
	dn0kUYEk6Gq+sPzt4VA/wtFpoknxqIy4vbHXnZOEf5rosTiEw2OmuM4BE3HAvLVbi3WFSoOtqgvwF
	HmG1YbFwZVtWOvYr5Vx85Qp2hZzzkjWRDZ29i5JPmY32/5ksK1j6Z/7u6WAdNjvRXTOLmRkjT5Yg6
	g5Cp18bd8541I7usGgq09vAuubjpicKV/L7HFk9ymKgbp7rYfHLezU71XdEOKJBLzz7FUgELWSg41
	ax4HYL5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opsl9-005gdQ-3j; Tue, 01 Nov 2022 15:00:59 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opsl3-005gcI-N8; Tue, 01 Nov 2022 15:00:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: per-tagset SRCU struct and quiesce v3
Date: Tue,  1 Nov 2022 16:00:36 +0100
Message-Id: <20221101150050.3510-1-hch@lst.de>
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

this series moves the SRCU struct used for quiescing to the tag_set
as the SRCU critical sections for dispatch take about the same time
on all queues anyway, and then adopts the series from Chao that provides
tagset-wide quiesce to use that infrastructure.

To do so this series cleans up a lot of code in nvme that is related
to quiescing queues.

Changes since v2:
 - check blk_queue_skip_tagset_quiesce in blk_mq_unquiesce_tagset
 - drop "nvme-pci: don't warn about the lack of I/O queues for admin
   controllers"
 - drop "nvme: don't call nvme_kill_queues from nvme_remove_namespaces"
 - drop "nvme-pci: mark the namespaces dead earlier in nvme_remove"
 - minor fixups for the above dropped patches
 - fix up a few commit messages

Changes since v1:
 - a whole bunch of new nvme cleanups
 - use the notify version of set_capacity in blk_mark_disk_dead
 - improve the documentation for blk_mq_wait_quiesce_done
 - dynamically allocate the srcu_struct in struct blk_mq_tag_set
 - minor spelling fixes

