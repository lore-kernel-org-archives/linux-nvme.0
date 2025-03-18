Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED74C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PDU4bb+Ogt+oj6h179aHcWr4C0xHFENG0LuzvTuW8pw=; b=ElDL7xk2pyQbGCV69FnQ2Hb6nj
	4UCStktS6DjgJkm/hazqLuYK/5E/3ZBOuNmroqCuF2fsC68+jx+Jc2koMe2FBnCdAug1g0IbLoEk/
	2OUDX9zw5mYHjGc42eLNLmMEmXun4mwPV20jOhNglgY5Ay3nbY20LUkexr9ugmOdqRupNQdlcbv34
	NcIlC+XfW5YF3ei3DlPymVpEpAhPPfwFWomQZjdSUf7bb0bmzzvH0vIFWazNJNDBt8BaHzc1J0Ee5
	5ssy2kZmPLMRUwXswzwzq3dUVVW1jrsniEJ+LM0Xt21dnPMYMvsWng2myETtwt3G6UveLtyIdLrfv
	QxKNfrTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRWn-00000004xMJ-2Byk;
	Tue, 18 Mar 2025 07:38:21 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRVV-00000004x1U-3Epm
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:37:05 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Yw2WqLz4f3khc
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:36:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F03891A06DC
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:36:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S4;
	Tue, 18 Mar 2025 15:36:58 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 0/3] blktest: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:32 +0800
Message-ID: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXu1+PItlnS19YGw--.63204S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw48try5XFy5Kw1kJFy3XFb_yoW8GFyxp3
	WDKF15tr1xKF17W3ZxWa1UXr15J3yxJryYyw4Iqr1UAry8Zry3Cryqg34YyryfGr1xWw1v
	yF1DXr95uF1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjTR_OzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003702_003093_BE9BBC1F 
X-CRM114-Status: UNSURE (   9.59  )
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

The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add tests for the newly added BLK_FEAT_WRITE_ZEROES_UNMAP
feature flag on the block device queue limit. These tests test block
device unmap write zeroes sysfs interface

        /sys/block/<disk>/queue/write_zeroes_unmap

with various SCSI/NVMe/device-mapper devices.

The /sys/block/<disk>/queue/write_zeroes_unmap interface should return
1 if the block device supports unmap write zeroes command, and it should
return 0 otherwise.

 - scsi/010 test SCSI devices.
 - dm/003 test device mapper stacked devices.
 - nvme/060 test NVMe devices.

Thanks,
Yi.

Zhang Yi (3):
  scsi/010: add unmap write zeroes tests
  dm/003: add unmap write zeroes tests
  nvme/060: add unmap write zeroes tests

 common/rc          | 16 +++++++++++
 tests/dm/003       | 57 ++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out   |  2 ++
 tests/nvme/060     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  4 +++
 tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 7 files changed, 205 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out
 create mode 100755 tests/nvme/060
 create mode 100644 tests/nvme/060.out
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

-- 
2.46.1


