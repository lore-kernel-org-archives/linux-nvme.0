Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5225FFA3743
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ah7oCz9YH54CFoCX1EkEoJSBMdrCqyTbs8bEDIs1R6g=; b=wB0GuH1lzCzZjOnyOwWEanZWW/
	Eg3fWR8vDhaCYYi0oRgbyr3rGPz+gilE4SlB5bUjdjcwYJlxfzICrn46LxdTCYVLvV9Z8h63EY+l0
	PSkc+j3zvXVUFIktmE7xIKqK9akJHR1BQ4kRxyKUrepPPmxtoOqw4coEAU+Tcv9YKelQ6xPxmnGCr
	KKu+zDJsaOF/JRk7EbGtQ04bkYpjQ0sNlrItGD0hYNLgz6u9YhgATHKY35qZa6fZdXmByQF/mo9yU
	xX0wfANJ3aYSvlngjyVht+p+qpXSZ0UeQb2YFkKPScz//bCWd/CD/pZdlzj37jst2luLByg4pozYn
	rIawcyOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyfV-00BkiQ-St; Sun, 30 Oct 2022 03:07:25 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyfS-00BkgM-8s
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 03:07:24 +0000
Received: from localhost.localdomain (unknown [10.14.30.251])
	by mail-app3 (Coremail) with SMTP id cC_KCgAXlrpJ6l1jv9B1CA--.27265S2;
	Sun, 30 Oct 2022 11:07:14 +0800 (CST)
From: Jinlong Chen <nickyc975@zju.edu.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nickyc975@zju.edu.cn
Subject: [PATCH v2 0/3] queue freezing improvement and cleanups
Date: Sun, 30 Oct 2022 11:06:45 +0800
Message-Id: <cover.1667098953.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgAXlrpJ6l1jv9B1CA--.27265S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4DCF48AF4kXr43AF15twb_yoWxtFc_ua
	4UAFyxtrs7GF13ZFyjk3W5AFWvkw4UXr18tFWDtrW5Ar97AF45Ja1S9rWkWws8WanrC3Wk
	Gr1UGr1xJr4xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
	xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAggTB1ZdtcKM4AABsP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_200722_649101_8D58BE39 
X-CRM114-Status: UNSURE (   6.32  )
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

Hi!

This series of patches improves and cleans up queue freezing in blk-mq.c
to build a clearer blk_mq_* namespace.

Changes in v2:
- improved descriptions in patch series title and patch 1.

Jinlong Chen (3):
  blk-mq: remove redundant call to blk_freeze_queue_start in
    blk_mq_destroy_queue
  blk-mq: remove blk_freeze_queue
  block: hide back blk_freeze_queue_start and export its blk-mq alias

 block/blk-core.c              | 13 +++++++++
 block/blk-mq.c                | 52 ++++++++++++++---------------------
 block/blk-pm.c                |  2 +-
 block/blk.h                   |  2 +-
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 include/linux/blk-mq.h        |  2 +-
 7 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.31.1


