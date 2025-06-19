Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C063C7115C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oraECPr+Te7ewJ/0LGmIukMK/dZc0SlzG7EMp7HkyHg=; b=Ya7jdFHyJIRDSZsf1l5BBbixnH
	VGJ2JW7f5DohAKsZDQubshCyd2x8KlHML5bwOmVTiHWeJEmg8E2uQdc8Ha895ICUVxIZym5TxobRO
	WR677394Zeq+D1+MWbjjT9GHQ0v3OhqhGMVLOsoBS0mDPZ3WqHHUZnXSZMzkE/itabbDzQgkta7k6
	A8co1GNH1DUBNiQlAyxn9lhRuJIAl0qOapYH6xOacRDCjNaIbwF/VXtTjo7qNXEqTe8gnjBhVrF7n
	bw56O44n8x5orjUMry07UVs7U3ykVAmqQIAPVsKDw+PP/+GFJREfNni48DS8M5dprhfOWbCkiFLqU
	Lu63mhow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHS0-0000000DSGE-49uG;
	Thu, 19 Jun 2025 15:45:17 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDUr-0000000CsyB-2Jqg
	for linux-nvme@lists.infradead.org;
	Thu, 19 Jun 2025 11:31:59 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNQ3SB4zYQv86
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6C2A41A11CC
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S8;
	Thu, 19 Jun 2025 19:31:49 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 4/9] scsi: sd: set max_hw_wzeroes_unmap_sectors if device supports SD_ZERO_*_UNMAP
Date: Thu, 19 Jun 2025 19:18:01 +0800
Message-ID: <20250619111806.3546162-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH618Y9VNoihn_Pw--.51230S8
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3tF18AF48uFyDGryUWrg_yoWDKrc_ur
	4fuFs7JrWjyF1IkrW7ZF43Ar9Iva1UZFy8uFnYv3ySvw4xXFnYkF10vF1a93WUXayUKFZx
	CwsrXrySvr1DAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRRtCztUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_043157_759727_7E8B1B43 
X-CRM114-Status: UNSURE (   9.34  )
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

From: Zhang Yi <yi.zhang@huawei.com>

When the device supports the Write Zeroes command and the zeroing mode
is set to SD_ZERO_WS16_UNMAP or SD_ZERO_WS10_UNMAP, this means that the
device supports unmap Write Zeroes, so set the corresponding
max_hw_write_zeroes_unmap_sectors to max_write_zeroes_sectors on the
device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/scsi/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3f6e87705b62..877dc34e8f37 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1141,6 +1141,11 @@ static void sd_config_write_same(struct scsi_disk *sdkp,
 out:
 	lim->max_write_zeroes_sectors =
 		sdkp->max_ws_blocks * (logical_block_size >> SECTOR_SHIFT);
+
+	if (sdkp->zeroing_mode == SD_ZERO_WS16_UNMAP ||
+	    sdkp->zeroing_mode == SD_ZERO_WS10_UNMAP)
+		lim->max_hw_wzeroes_unmap_sectors =
+				lim->max_write_zeroes_sectors;
 }
 
 static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
-- 
2.46.1


