Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A79CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 02:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yM07gxXcww6SbHsmNbeAya7IJnK50a3GieKo41XtHCo=; b=IadzRNkS5IIvG0Isy7b8Q8TWr0
	66ldcv1ZMW30Tj0b4LBXcTj6EPIZg3ce5oyjN94nN90CdaNtqIEDAT06+BO3fpBaMVMUqXjw4XWhg
	bp5VgHWCv0NoLoD8fTGzJotD0QDxIIgz6mayPGO5yeFkpnzMDhnBmYaaCjuNr/Zr7O+vpPU82NLJZ
	1oc7nR+9PlGxzWKZvaO1681DZGr+RwxLLpCW9YpMuHNLFR1zeXPkcmB+iPAyjyA+/4TNoqGoT0qqd
	b2YjH0cTye1YFoiXee5aANA4OkWeYyiKpdL900CejH0GAdidT1R7TNEELSl5VtFgbk1pRMyauuyXf
	ApaiBOHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1bD-0000000CSSU-2jpR;
	Wed, 13 Aug 2025 02:52:23 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1bA-0000000CSPL-0cj9
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 02:52:21 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFT2LgLzKHMSw
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:52:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8EFD51A018D
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:52:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S4;
	Wed, 13 Aug 2025 10:52:12 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
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
Subject: [PATCH blktests v2 0/3] blktest: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:18 +0800
Message-Id: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHwhLQ_ZtoAscBDg--.14424S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4rtr43GrW7tw1xWw43Awb_yoW8tr15p3
	yUKFy5twn3KF17JasxXa1jgF15Jw4xJr1ak3Wxtr1UAry8ZFyfWF4qgr1aqr1xGrn3Ww10
	va1DtF9Y9w1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7sRiKsUtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_195220_537543_C958074F 
X-CRM114-Status: GOOD (  11.29  )
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

Change since v2:
 - Modify the sysfs interfaces according to the kernel implementation.
 - Determine whether the kernel supports it by directly checking the
   existence of the sysfs interface, instead of using device_requries(). 
 - Drop _short_dev() helper and directly use _real_dev() to acquire dm
   path.
 - Check the return value of setup_test_device().
 - Fix the '"make check'" errors.


The Linux kernel (since version 6.17)[1] supports FALLOC_FL_WRITE_ZEROES
in fallocate(2) and add max_{hw|user}_wzeroes_unmap_sectors parameters
to the block device queue limit. These tests test those block device
unmap write zeroes sysfs interface

        /sys/block/<disk>/queue/write_zeroes_max_bytes
        /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes

with various SCSI/NVMe/device-mapper devices.

The value of /sys/block//queue/write_zeroes_unmap_max_hw_bytes should be
equal to a nonzero value of /sys/block//queue/write_zeroes_max_bytes if
the block device supports the unmap write zeroes command; otherwise, it
should return 0. We can also disable unmap write zeroes command by
setting /sys/block/<disk>/queue/write_zeroes_max_bytes to 0.

 - scsi/010 test SCSI devices.
 - dm/003 test device mapper stacked devices.
 - nvme/065 test NVMe devices.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c

Thanks,
Yi.

Zhang Yi (3):
  scsi/010: add unmap write zeroes tests
  dm/003: add unmap write zeroes tests
  nvme/065: add unmap write zeroes tests

 common/rc          | 10 +++++
 tests/dm/003       | 86 +++++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out   |  2 +
 tests/nvme/065     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/065.out |  4 ++
 tests/scsi/010     | 84 ++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 +
 7 files changed, 284 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out
 create mode 100755 tests/nvme/065
 create mode 100644 tests/nvme/065.out
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

-- 
2.39.2


