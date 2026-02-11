Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577A6EB5954
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 09:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Em7u1rH1bKPldoBrPL1xmPJfYMLFO4FyjIoF6fJcOg=; b=gBCz7YjqICLrVlhUDtzn8vC0hz
	HGfmEOpBm01U+smS4oaKdfL4d4MVSCmvvcGwlmUcw0cTHr/ZbZTNtY+R77BnM7J/i/atZp+bBNsWN
	aEuKVTjwNTF1c3u7XsUpO2MpzJ5dMpHt15c2IHERWfZ8JxvaAb+Ud2ZUkb8Lil+I45vFhko/yN2BN
	zicB3B96NClnvAeWgI+hccxRwD1l+agcGSFngQU5Jd3BOss70hJdOobOok1XX3bYppaSs+bl9bD3j
	sRnXXBPf4rBaNImoxxLf4VCYMYGzruhtq8AmDYy9PNrohydndW4FnmMzjAcfquM2x5Yx/jc9uS5/s
	XQ7S6StQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq6pb-00000000SIG-2hXc;
	Wed, 11 Feb 2026 09:48:23 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq6pY-00000000SHj-1nFj
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 09:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5E
	m7u1rH1bKPldoBrPL1xmPJfYMLFO4FyjIoF6fJcOg=; b=qa12udyJnRbz77E8TZ
	MMxwUu3Fir2K5Vlacano/NQVwsomlgeV7ERW81YKmJPpzieqRqH+7/pBuvq7r7jw
	P7A1tBz3eQa078WE//0l30k8jZrTcy5ng7ePT42qV5jhPxxY/l+3n1vXDXRXIXDo
	hT7x2dryp80toM7UWFcO0Boy4=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHJ7BBUIxpQjM2KQ--.40582S2;
	Wed, 11 Feb 2026 17:47:45 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: zhangjn_dev@163.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	liuyx92@chinatelecom.cn,
	sagi@grimberg.me,
	sunshx@chinatelecom.cn,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	zhangzl68@chinatelecom.cn
Subject: Re: [PATCH] nvme-pci: fix potential I/O hang when CQ is full
Date: Wed, 11 Feb 2026 17:47:44 +0800
Message-ID: <20260211094744.32366-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209121020.119853-1-zhangjn_dev@163.com>
References: <20260209121020.119853-1-zhangjn_dev@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHJ7BBUIxpQjM2KQ--.40582S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18ur4DJF48GryfZw4UXFb_yoW8KF4DpF
	W3K3y7ta1kGF18t3sFvr48XFW3Aa98ArWjqF1ktry8Cr9xCF1FgryfKrW8Xa4rW34kWw1Y
	qrWjqrs7uF47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piSdgtUUUUU=
X-Originating-IP: [118.112.177.142]
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbCxgGhN2mMUEG6sAAA3v
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_014820_843144_200F68DF 
X-CRM114-Status: GOOD (  14.72  )
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

On Tue, 10 Feb 2026 16:57:12 +0100, Christoph Hellwig wrote:

> We can't update the CQ head before consuming the CQEs, otherwise
> the device can reuse them.  And devices must not discard completions
> when there is no completion queue entry, nvme does allow SQs and CQs
> to be smaller than the number of outstanding commands.

Updating the CQ head before consuming the CQE would not cause the device to 
reuse these entries, as new commands can only be submitted by the driver after
the CQE is consumed. Therefore, the device does not have the opportunity 
to reuse these entries.

Actually, the root cause of the issue is that the underlying device received 
more commands from the NVMe driver than the queue depth (q_depth), leading 
to a CQ full problem.

In my environment, the NVMe admin queue depth is 32, allowing a maximum of 
32 commands to be processed concurrently. During the NVMe disk removal process, 
the NVMe driver sends commands via the admin queue to delete all I/O queues.
When the NVMe driver has already submitted more than 32 commands, any additional
commands beyond 32 will wait for the previous ones to complete.

During NVMe interrupt handling, the current implementation first processes the 
CQE and then updates the CQ head. The commands allocated by nvme_delete_queue
are not processed through the batch flow during interrupt response. After
consuming the CQE, the tag is released and the upper-layer NVMe driver is notified
(note: at this point, the CQ head has not yet been updated, meaning the entire 
previous process is not yet complete). Upon receiving the notification, the NVMe 
driver immediately submits new commands to the SQ. When the underlying device 
completes command processing and writes the result back to the CQ (while the CQ 
head remains unupdated), the number of commands processed by the underlying device
exceeds the NVMe queue depth. Since there is no available space in the CQ to place 
the completion, a CQ full error is reported.

The above process can be illustrated by the following diagram:

          driver              irq             underlying(virtual/hardware)
          ------             ------                     ------
      1. Wait for tag
                            1. Read CQE      CQ is full, wait for head update
                            2. Handle CQE
                            3. Wake up tag
      2. Get tag
      (blk_mq_put_tag)
      3. Issue new cmd
                                              1. Process cmd
                                              2. Try write to CQ
                                              3. CQ is full, discard cmd!
                            4. Update CQ head
                                (LATE!)
      4. Cmd timeout

Best regards,
Junnan Zhang


