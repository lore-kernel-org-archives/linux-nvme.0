Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E82C35FFA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X6YSe4dlZijBYmdjy4Nf+7K2Ob2D2oO9voAr88MuDMA=; b=tU19Apt/US5LD+iDuX/xNsn1QQ
	A647QWfpRbr6L26yUxBcJbydyxRlAka9RPir9L+OrxwHCOeXZn98dm89+k7Zy7ZEa88zhkI/f2VAJ
	iwbjZl5fDtPsU0brF28B1Ym41EPLuEGdK42bLJ/JqmLfJEYhHleOF+4JbAH5Y0GNX4bMwN5/P+IZb
	cXX4HAXhJA//jGKgSfI/aUBJAuRmaKZfE3Z6c8K8uCODbH3A7Rg9EGHrQ0XKWP9nX31twV/DEwq9b
	1pWU+sEhDV4VLtnIX9vdwF2fDvAi8gb0aWnWoePuTJqZepv5FGySWLRdnyuqfyhNIXloMgRmvqZ/h
	kNDv/4qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTR-00000004vrk-3FD1;
	Tue, 18 Mar 2025 07:34:53 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTN-00000004vlj-0iur
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:34:50 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WJ3vFmz4f3kGD
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2BBF71A058E
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S4;
	Tue, 18 Mar 2025 15:34:40 +0800 (CST)
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
Subject: [PATCH xfstests 0/5] fstests: add fallocate write zeroes tests
Date: Tue, 18 Mar 2025 15:26:10 +0800
Message-ID: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8EItlnJDdYGw--.56140S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWfWryDtr43uFWfXr1DWrg_yoW8AF1kpa
	1vgr15tr4UGF17Crs3Gr1Dtrn5Aws7Gr4Ykr4xt34avFy8Aw18GF9Ygr1UXr93Cw18uw4Y
	yrs8Kryagw47A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTR_OzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003449_600633_FBD9C5D4 
X-CRM114-Status: GOOD (  11.32  )
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
fallocate(2). Add tests for the newly added fallocate
FALLOC_FL_WRITE_ZEROES command. This series depends on the changes to
xfs_io [1] that introduced the 'fwzero' command.

 - generic/764 is an extension of generic/008, it is designed to test
   page boundaries for fwzero.
 - generic/765 is an extension of generic/009, it is designed to do
   generic functions tests for fwzero.
 - generic/766 is and extension of generic/349 and generic/351, it is
   designed to test fwzero on raw block device.
 - Finally, add FALLOC_FL_WRITE_ZEROES support for fstress and fsx.

[1] https://lore.kernel.org/linux-fsdevel/20250318072318.3502037-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (5):
  generic/764: add page boundaries tests for fallocate write zeroes
  generic/765: add generic tests for fallocate write zeroes
  generic/766: test fallocate write zeroes on block device
  fstress: add fallocate write zeroes support
  fsx: add fallocate write zeroes support

 common/rc             |   2 +-
 ltp/fsstress.c        |  12 ++
 ltp/fsx.c             |  80 ++++++++
 src/global.h          |   4 +
 tests/generic/764     |  34 ++++
 tests/generic/764.out | 433 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/765     |  40 ++++
 tests/generic/765.out | 269 ++++++++++++++++++++++++++
 tests/generic/766     |  80 ++++++++
 tests/generic/766.out |  23 +++
 10 files changed, 976 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out
 create mode 100755 tests/generic/765
 create mode 100644 tests/generic/765.out
 create mode 100755 tests/generic/766
 create mode 100644 tests/generic/766.out

-- 
2.46.1


