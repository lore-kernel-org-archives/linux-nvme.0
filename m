Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B059BC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jz7y2Yhezni9yPEb9lCUlYteShCkjN5wd9fBoAC50o8=; b=YgGwnScUWImlDqTXYbN3wA++Mw
	ZjE5vuD5lRgC8fwwAdJLWnkURNfLgRLqEAKGtN5SoHuVx+Lv0C7mcetpI3m+v2iA0hHem7h8ZA+Uh
	MZFRiATUXelh8TlZAA4WdfgeyHWB1Blh/qtaHQfHmqMZ1QEri0dd27VkZYDyNKit6BqLRE2Oo+rxu
	bpwaXFfsU/arT5iwohWAslPGoI5a0VSC3EICeqyAhPx5U7vVR9TVkavYOE2bmRym1WO68bO7MSRgq
	r+9KLlTpZEey4Kw9nfPvr69UwPD13+ty2vBNkaxSkV130PU2UN64kVJJZJ+PtrXKu15vJ0Vu1zUKU
	VSN05RDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6gqx-00000003PgB-45A0;
	Mon, 21 Apr 2025 02:25:48 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6gqn-00000003PWf-2jog
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 02:25:42 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zgq305mwFz4f3jq5
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 10:25:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 56D161A1B73
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 10:25:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+MrAVoFxZkKA--.3102S14;
	Mon, 21 Apr 2025 10:25:35 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v4 10/11] block: add FALLOC_FL_WRITE_ZEROES support
Date: Mon, 21 Apr 2025 10:15:08 +0800
Message-ID: <20250421021509.2366003-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3m1+MrAVoFxZkKA--.3102S14
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry7Wr4xCr18Cw13ury3Arb_yoW8Xry7pF
	WDXF15JFZYgas3GF1fCF4q9rn5Za1kJryrGa1xK3WF9wsxJF97Kr1DWF45ta4UWFy7Aw4k
	Zr9Igr98ua17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_192537_988954_FA5FD0FC 
X-CRM114-Status: GOOD (  12.17  )
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

Add support for FALLOC_FL_WRITE_ZEROES. It directly calls
blkdev_issue_zeroout() with flags set to 0. The underlying process will
attempt to use the fastest method for issuing zeroes. First, the block
layer will try to issue a write zeroes command if the storage device
supports it; if not, it will fall back to issuing zeroed data. Then, the
storage device driver may attempt to submit an unmap write zero command
if the device supports it; if not, the driver may fall back to
submitting a no-unmap write zeroes command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 block/fops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 77a5465309e7..e590c8997689 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -803,7 +803,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_WRITE_ZEROES)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -847,6 +847,9 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
 		flags = BLKDEV_ZERO_NOFALLBACK;
 		break;
+	case FALLOC_FL_WRITE_ZEROES:
+		flags = 0;
+		break;
 	default:
 		error = -EOPNOTSUPP;
 		goto fail;
-- 
2.46.1


