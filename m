Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE430CD8CA7
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IUQsLPsseuIJFFTAaM0vcgwWoBDUdQMZYmplwdgTJrM=; b=NdWu4TlUw09n6C3VvnBrEQREZC
	dENvC9baJxY/gkUeFRexr6GA+DvAUHAgmcT18dp3B5zUPTk5IshhaRvXGIYhN4Glghp/Lkq+ctzVH
	j3Bx5K5gq+gn18i1xIobPTxHL841e6g2dlEvITe4uZBmVK/4XC20okodetziwsNQxJq7pgr+ie3bt
	7D1+8bj+exmwo9TGJ8rx4jm4+3S5+4jrcf2AcU/mAk5lP77sgmqcRoC0SfDHovsJtuhb5dYZI7E3E
	BDhgHDSWDU3Auno8+LKGGnxlZRzi4OOitbeJgtwrLl9msh/nxITheHXFc7V9zulvLtTIVV/2mQ3ih
	9TknScNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJl-00000003RMM-19TK;
	Mon, 08 Jun 2026 11:38:57 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJh-00000003RKp-3I9X
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 11:38:56 +0000
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gYqmK2TBzzKHMw7
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 34F054058F
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with SMTP id cCh0CgAndzzBqSZqe2I+BA--.24728S4;
	Mon, 08 Jun 2026 19:38:43 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH 0/2] avoid possible double completions for the same request
Date: Mon,  8 Jun 2026 19:34:23 +0800
Message-Id: <20260608113425.3836619-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAndzzBqSZqe2I+BA--.24728S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW7Ww4rur1Uuw4UWr4DJwb_yoW3XrX_Cr
	9YvFy3JFyxZFZxXFy7WFnrZ34jkFs0vFn7Jayvkry5Z347Wr98Jws7Zr98Xw15ua15AFWD
	Cr1UJryrJ3y5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_043854_004997_58DB1E6C 
X-CRM114-Status: UNSURE (   7.93  )
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

From: Ye Bin <yebin10@huawei.com>

This patchset fix possible double completions for the same request.
Refer to the comit f1342709d18a ("scsi: no longer depend on blk-mq for
double completion") to implement a mechanism that does not rely on the
block layer.

Ye Bin (2):
  nvme: operate nvme_request->flags with atomic api
  nvme: avoid possible double completions for the same request

 drivers/nvme/host/apple.c     |  4 ++--
 drivers/nvme/host/core.c      | 13 ++++++++++---
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/ioctl.c     |  4 ++--
 drivers/nvme/host/multipath.c | 12 ++++++------
 drivers/nvme/host/nvme.h      | 13 ++++++++-----
 drivers/nvme/host/pci.c       | 11 ++++++-----
 7 files changed, 35 insertions(+), 24 deletions(-)

-- 
2.34.1


