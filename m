Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4ADC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JU0RHM3LhfHpd/Z5hHY05Fgimq/QoxL5zXExBc+3S9E=; b=lG89X9++dv/OOm6fQRQBOTatv/
	+dYKCt3M1UWcgo0klrk0lFeJJl43zHM2ZG6KU/aRiC+xi/yD4U5fcJulv12N4xjgxBECJ0PEP0axJ
	NdJ4rY2kVHpelhah2hHlpy0QG0P2PAMUy2Dr1ctjx1GgJka9iN2u8sgp1glV8+iXeDlT6570nFVmJ
	xct3KfXdtdpZXD+pXh9HR0qBPjNhXxrKlfPSjTaBeIMirkjLChQF+820jzwmVbQgu9h9tldbDq/Pw
	dsx27X5H9WAaD9AW2QaEbA29M0MV+I2efYiFFGQcqACLXOxgiR24lKfaPQDgxzq4NHKv8KZhzt9iZ
	XBgiO5xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79VW-00000006TIB-3N5f;
	Tue, 22 Apr 2025 09:01:34 +0000
Received: from smtpbgjp3.qq.com ([54.92.39.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797F-00000006L7c-3qN8
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 08:36:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745310926;
	bh=JU0RHM3LhfHpd/Z5hHY05Fgimq/QoxL5zXExBc+3S9E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZXpC/fPctka+9qXUBdjclQbhACdJTYhapimN3OqCiTNs2F6lJDkRkxGLgdZBqVsbE
	 0XOJQTSQM9Lrgx/TEx59K8DoxYUkLK5pFt8Cj/k5QfUhd2o+ModbkFkOuujd4oEIV5
	 uy4HbmJI46RFo/Oeok3MrvdDA4WrG5ifrtwpnlVg=
X-QQ-mid: zesmtpip3t1745310920t8b1bb162
X-QQ-Originating-IP: xDaMskdxdpmttZVyDVx0vXx2WDh0zl++cOZsOP5r3rE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Apr 2025 16:35:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7588482841693843882
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.12/6.14] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 16:34:31 +0800
Message-ID: <56AA32057D5B8285+20250422083431.96652-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtJoEQFRGvIzFftxGMkZ/AEm+5UDCmqNmKwWbuiBZy2fJTtEfcgljhf3
	OKuNR89Oir+i1EI7OSwRiki0hOAN48+UEaFqwYk7wcC4CjbAAo8zCi2yNkvsNGpPS+ZDT+M
	j0NYmn8p8htVLqN5h6lSCnYB/U8Z7GfJnOVHS/Df4wUXfo1b3NukB2YlhD3xlbfPJdA+joD
	jLX0NAcQm4bqN/wbc+31Lf8JTb3plKQMqITgdrJQy+a51bcrFTY8nTEr2YDLwJRHxgUWNVO
	/ADPLKSiQi6DdIliBYWCVVWr9VAv9kWuUdMbp3flBNsnbI0wIkCPuN6EkrrVICz2GVtYlE4
	8OAYGTfwu9pmtmuyNUsDYi/RXdTxYH6Bttaid7NE6DvSaJuOfnJnIuv45sVDvhTDpLKSYZI
	l75wmR4cmgjX35mqL5cpOAUPjXwgwnJR66h/eX37/e1Mk7TzdBzxFOJlr2JPV42UDmtW7yB
	Q2ph7EQZJKsV7NwHzTBdiCPTKM7PIi8GdYZoZYnKKoCcbiAMK0iQ+zhnj05uWhmtUGSgmEl
	kBT7d0kTbfcM6K8AT89DvVRhmanjCakhKyc+VFdZD751tRkUI5BouYpWbIBqkyLWv3Or5uQ
	em2VDnV8LZkHw5vjUzrajp5VHTEawrGaZNkoahZ7I9lqcupqPTH8ydpFsRswHwesyWbUUft
	uniwveDjxAIzmMWjxDsFO13RWq0+ksiTsuqECQjR/R6kPzXU0rD5ktX3wud1x/y5RPDV7d0
	6oDdoWPPjsSK/8FeEyfBQ8zYYNdSfzBClSlkXDOHpTdZus8xy+kX+3+CQ15LtOuq8ZvlN8+
	UrVKgklOjr+k60lVaDkgOrIIXmnwqJwH4cjpcTc6cKdsVa21r+mkKtiRZEGPElDo0yH9X8c
	StUW/FfP2/IFGDE1IIvYOzqGG1ZXH4j3dIYqdCNnSafVuiCYmHXf6NJ1w0joLXIVfHo3RT0
	bb8vGfPSTH3QkiIMJqXWOPyxZfXBJlNdQsJ/97KgZ7sWVpS04QknHjfv8YSCUOGO7BKnhRD
	u6gOFKdg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_013630_314466_0FA1D053 
X-CRM114-Status: UNSURE (   9.16  )
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

[ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]

The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
unutilized.

Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
transport"), which introduced these two functions, they have not been
used at all in practice.

Remove them to resolve the compiler warnings.

Fix follow errors with clang-19 when W=1e:
  drivers/nvme/target/fc.c:177:1: error: unused function 'nvmet_fc_iodnum' [-Werror,-Wunused-function]
    177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
        | ^~~~~~~~~~~~~~~
  drivers/nvme/target/fc.c:183:1: error: unused function 'nvmet_fc_fodnum' [-Werror,-Wunused-function]
    183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
        | ^~~~~~~~~~~~~~~
  2 errors generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/nvme/target/fc.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/nvme/target] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/nvme] Error 2
  make[6]: *** Waiting for unfinished jobs....

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde32..7318b736d414 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.49.0


