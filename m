Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97248C982CF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k9c1YqA744VIL73U1eUH5sZHV7Ay/TCbbmHbavrq83M=; b=cfPUW4xmZUGwdQ/mkeO57lFkYa
	P5Pz5L/Wcy8ZvsrCmHHnqkzmDPQEle9D/Ttupd72zxIgMWi50aGDjuvJzIqkjGLJuWeFuiwm3OIKc
	9cAfkyTdnguWlG8MdyVEr7bjv8RPLbhAeqdS6LscNPtVSpPVmNTVotlbm0pdTYORkdgGSqHEp7JHP
	FRbBtLR7ZPrvGfd+1oUrmtFRK125l2NEk6u58pl0Pk3K1WKIJkXGyFya2yQyx/3D8D1q083LtIAXO
	945xRvxU7WVvnjny4iSNUGU6WECCMFPNlPA8dIw7+1loiAug4drqLrbSoyNzlaVMXhx9iCF+RFwNB
	vjILn2KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7BGg-0000000BIRr-346M;
	Thu, 17 Sep 2026 12:31:10 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7BGc-0000000BIR0-2sq7
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 12:31:09 +0000
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB34jyF3atq5YuACA--.2756S2;
	Thu, 17 Sep 2026 20:31:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hch@lst.de
Cc: james_p_freyensee@linux.intel.com,
	jsmart2021@gmail.com,
	jthumshirn@suse.de,
	justin.tee@broadcom.com,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-fc: Fix tgtport reference leak in nvmet_fc_alloc_target_assoc()
Date: Thu, 17 Sep 2026 12:31:01 +0000
Message-Id: <20260917123101.2151173-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB34jyF3atq5YuACA--.2756S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4UZr1UuF4rtr17Gry8Zrb_yoW8Xw43pF
	sxGr1xKFW7CFW5twn5AFs0vFy7A3W8W3s7C34fW3ykuF4rt348CFWDKas29F98AF18GFyj
	gF4DAw18tr45ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU2U73DUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwINA2qrrRmTSwABsn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_053107_092048_F634D28E 
X-CRM114-Status: UNSURE (   9.76  )
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

nvmet_fc_alloc_target_assoc() takes a reference on the target port for
the new association, but nvmet_fc_target_assoc_free() never drops it.
The reference is only released by nvmet_fc_delete_target_assoc(), which
is not reached when nvmet_fc_alloc_target_queue() fails and the caller
tears the association down with nvmet_fc_tgt_a_put() alone, leaking the
target port reference.

Release the reference in the association destructor, which pairs with
the reference taken at allocation time, instead of in
nvmet_fc_delete_target_assoc().

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d161707559ce..a6431f4c5420 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1186,6 +1186,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	ida_free(&tgtport->assoc_cnt, assoc->a_id);
 	pr_info("{%d:%d}: Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
@@ -1222,8 +1223,6 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 
 	pr_info("{%d:%d}: Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-
-	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
-- 
2.34.1


