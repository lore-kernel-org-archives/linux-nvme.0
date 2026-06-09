Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA1FCD6E79
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6UGyKMXXXmGqe2qS3wrzUMyqvTpuCxsGlIWJalEc7/k=; b=0cWdaeAkEQcMhfvxBomuq8eMfK
	tBBZWchtgh2CnL6Ay7MnJVECKdwcF9GpBzPb7oHxefGIY1z0+id9laJ3SeYj3zdzFJDWCdaYbDTV3
	XUgw5DC4Ml+r0ZHL67UGSRyl2qX4NzwuDHe8Y1ERRVK+JcjWDl3uabPBztYELjdGGU75ky5KibrfC
	Pyftvk0q2+ObUvXKCgAKzMz10mw7wU+5B4lT2Zf35EHmo8m+u8Zvci0vWOLc7MoYmWGysMQzPG/TC
	k5TAsXNVvp3erc3mzNnwrNI13Q9m6zyVqMuQEcENTU7G/wz1MES+WeEhKaWcPmSf8OADnT5U2/KUT
	J/AlSMyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtB0-00000005H0T-3OK7;
	Tue, 09 Jun 2026 09:55:18 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtAx-00000005Gzj-28Ka
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 09:55:17 +0000
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Ov4A4ydqy9DQEg--.477S2;
	Tue, 09 Jun 2026 17:55:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet: fix refcount leak in nvmet_sq_create()
Date: Tue,  9 Jun 2026 09:55:05 +0000
Message-Id: <20260609095505.227496-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC3Ov4A4ydqy9DQEg--.477S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF15Gr4UWrW5WryDWF4rXwb_yoWkAFbE9w
	1UJrn7GFyruw4DKa47Wr43ZryxKr95Xw1Iyws8trW3tr90gFy3G3sYvr93Gr1fur48Xr15
	C3W7Jrn5C3yS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JURyIUUUU
	UU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcNA2onpvzyXAAAs8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_025515_937459_4DDC570E 
X-CRM114-Status: GOOD (  10.05  )
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

In nvmet_sq_create(), a reference on the ctrl is taken
via kref_get_unless_zero() before calling nvmet_check_sqid().
If nvmet_check_sqid() fails, the function returns the error
directly without releasing the reference, leading to a leak.

Fix this by jumping to the "ctrl_put" label, which already
performs the necessary nvmet_ctrl_put(ctrl). This ensures the
reference is properly released on this error path.

Cc: stable@vger.kernel.org
Fixes: 1eb380caf527 ("nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f..4477c4d6b1ee 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -944,7 +944,7 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 
 	status = nvmet_check_sqid(ctrl, sqid, true);
 	if (status != NVME_SC_SUCCESS)
-		return status;
+		goto ctrl_put;
 
 	ret = nvmet_sq_init(sq, cq);
 	if (ret) {
-- 
2.34.1


