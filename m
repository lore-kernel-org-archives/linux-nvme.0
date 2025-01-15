Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D96EC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrmmfZtakvKrBwu3Oq3wH4549Pu26MGeJJYEIIHW2Io=; b=vHs7wWwYCEwxwBw/M+wJ1g0U3j
	VUviw9ymo0NiRcwTLU/JQX5T30Qk28srQn2wy6Ts6gz9F2euKayAPWvx3kszQiorD3Hce106193sp
	pdT0NH70QjKF9VOarhWW3BK2ZNWdCwd8o2i4z7lW2brpf/fQG36NAe8RCSdbQFyYvg1JiaPPNGxWD
	mQ6/ufRU6aFnKQJZEiVRO1ATwXdk+CxMz2bYg518IzJvblfCHhflv76/ckuwprugNTGaaKw5EOcBw
	M2iZ55iIz9YspJA0hd8t6Hbq/g1fGumJP5Spf0TBc+T/kA+GckI4CJb447g1Zm6Z4SbzjWaqhPxvn
	SimpIDiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1xd-0000000BkpR-2s73;
	Wed, 15 Jan 2025 11:53:25 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1wY-0000000BkR5-0bSC
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:52:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY4956lXpz4f3jqx
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:51:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2BABD1A14CD
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:52:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S7;
	Wed, 15 Jan 2025 19:52:09 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 3/8] scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports unmap zeroing mode
Date: Wed, 15 Jan 2025 19:46:32 +0800
Message-Id: <20250115114637.2705887-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Gl9aoYdnvK0ZBA--.21959S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3tF18AF48ur4kZFW5Wrg_yoWDXwc_Ca
	1furZ7Jr4vyFyIyrZaqr4avryvvan7u340grnFqryFyrZ2vrs5t3Wv9r1a9a1UJw4jgwnx
	AayDXr1SyryDJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JULBMNUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_035218_337501_904D2010 
X-CRM114-Status: UNSURE (   9.15  )
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
BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/scsi/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8947dab132d7..95e115c69286 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1122,6 +1122,11 @@ static void sd_config_write_same(struct scsi_disk *sdkp,
 	else
 		sdkp->zeroing_mode = SD_ZERO_WRITE;
 
+	if (sdkp->max_ws_blocks &&
+	    (sdkp->zeroing_mode == SD_ZERO_WS16_UNMAP ||
+	     sdkp->zeroing_mode == SD_ZERO_WS10_UNMAP))
+		lim->features |= BLK_FEAT_WRITE_ZEROES_UNMAP;
+
 	if (sdkp->max_ws_blocks &&
 	    sdkp->physical_block_size > logical_block_size) {
 		/*
-- 
2.39.2


