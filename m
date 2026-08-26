Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7270C5DF97
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Cc:
	Content-Type:Subject:To:Content-Transfer-Encoding:Mime-Version:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=leJGtjT6VJnlSqCeouDDEKRSkd/fnUEKHKxccF7vyy4=; b=DcOiiDsAHxEZXue5fsgWmck3+m
	N3hm59LJeqbsGESy7ShBspy3OwSsdDamzwIHn/7Q/8/4z+P+HpaXpnXeuH0MdX9aNJDzQFgFepIkk
	N+lBjYoMqqXlr2SFHXhtMawCVStQ8oRIo0U8h1+9KJ19tNcME6sP45wnAyLh+a4w0SYiVcB1IWWNX
	4neRe4FZbW5Qq3EBdqUgIw+MtCXlUEhw+r+fQiiXMzC50H6eO3qGL+E5C5cIfokFVUpJrl7GdVnat
	XMDO/8m1/+LM4SzbOkzhnIUfnTD8Vi4YQ2wdGL5nkErn0FIOd2v+l4OBKjdzHmlIg4NNl/bBIwKSl
	Tj1lRJCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6wd-00000001xOF-3x9C;
	Wed, 26 Aug 2026 06:17:07 +0000
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6wa-00000001xNp-3ZFy
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 06:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787725012; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=leJGtjT6VJnlSqCeouDDEKRSkd/fnUEKHKxccF7vyy4=;
 b=q0sBgf/wPt6beYSa+dJ1Hreh2KNIWKL72+xbnT1vo+fREd4SMZ0KKs/4nD93IwlWyj9HA0
 YyETEi7PprsK4wrpzBcBBKAlHW5pdM6J3k7TEDmz6BOL0tI2R1AI2fm9Hay0lg0D6CwJlE
 /kKhxvJ9eI2AoHi/HzjadL5Vq7sZD7vx/inwe7mDrPDKHflnG8FCzkEVzcEEkiBeiJD7rz
 c217W9IQpiejWUZrmEzsBHjDBX+18K1eNiHZv+2wWcXgtU4WsQ+jBNC1Oz035DtQgTWNUD
 hHMpC5rXvOrTQtZodfuQuhhI7uQtIp8KWGdJH0sxv0pB72q/73gxoqkcxLLZVg==
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
From: "Fengnan Chang" <changfengnan@bytedance.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, <anuj1072538@gmail.com>
Subject: [PATCH v2 0/2] nvme-pci: add adaptive interrupt polling
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a8e84d2+e3a4ec+lists.infradead.org+changfengnan@bytedance.com>
Cc: <guzebing@bytedance.com>, "Fengnan Chang" <changfengnan@bytedance.com>
Date: Wed, 26 Aug 2026 14:15:44 +0800
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
Message-Id: <20260826061546.56006-1-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_231704_983028_FC2E45CA 
X-CRM114-Status: UNSURE (   9.36  )
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

At high IOPS, interrupt handling can limit throughput, especially when
multiple drives contend for CPU time.

Add an opt-in adaptive policy for I/O queues that use a dedicated MSI-X
vector and do not use threaded interrupts. Each queue independently
switches between interrupt and poll mode based on its recent completion
rate.

In interrupt mode, wait for at least 8192 completions. If they arrive
no more than 10 us apart on average, try polling. While polling, an
hrtimer runs irq_poll to drain the completion queue. Before a window
is full, polling may fall 20 us behind the interrupt-mode pace. After
8192 completions, polling must be strictly faster than interrupt mode.

If a try fails, go back to interrupt mode and measure again. After
three failures in a row, stay in interrupt mode for 64 windows of
completions before measuring again. If polling works, keep it for at
most 64 windows, then go back to interrupt mode and measure again.

The module parameter is off by default and only sets the initial
mode for new controllers. A per-controller sysfs file can change
the mode later. The change freezes the namespace queues and waits
for in-flight I/O to finish. Queues that use threaded, MSI, or
legacy interrupts keep the regular interrupt handler.

Measured with 4 KiB random reads on Solidigm SB5PH27X076T, adaptive
polling on versus off:
                                     QD32      QD64      QD128
one device, one job                 -0.08%    +31.56%   +30.95%
fifteen devices, eight jobs/device  +188.03%  +236.46%  +231.38%

The fifteen-device aggregate with eight jobs per device increases
from 13.48M / 13.47M / 13.47M IOPS to 38.83M / 45.31M / 44.64M IOPS.

Changes since v1:
- Split the nvme_poll_cq() return-count change into a separate prep patch
  (patch 1/2) so the functional change stands on its own.
- Factor out nvme_irq_complete_batch() so the regular and adaptive
  interrupt handlers share one batch-completion path.
- Only call irq_poll_complete() when completions < budget, matching the
  irq_poll contract; the previous boundary case could return the poll
  object to the softirq list after it was already removed.
- Clarify comments: document the NVMEQ_ADAPTIVE_* flags and the
  dual-purpose retry_completions field, and reword the constant rationale.
- Minor style/indentation fixes per review.


Fengnan Chang (2):
  nvme-pci: return completion count from nvme_poll_cq
  nvme-pci: add adaptive interrupt polling

 Documentation/ABI/testing/sysfs-nvme |  17 +
 drivers/nvme/host/Kconfig            |   1 +
 drivers/nvme/host/pci.c              | 542 +++++++++++++++++++++++++--
 3 files changed, 536 insertions(+), 24 deletions(-)

-- 
2.39.5 (Apple Git-154)

