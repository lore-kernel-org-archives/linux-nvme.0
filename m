Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B7B60E90
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97B7B60E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crZRJgOkjYi3EiJOxDBxffWr9S5JpN7jYdBxf7e+8rk=; b=00952zc+TiUluy1HLCm0BnEjTn
	7n2ivbzlpSwwb/FVCAWbrlmiCVZ0gCPNbzwmT289Rkcwl7HSSnAPsoHDEk9Ml07XO1yk0p4Wto+vK
	2/DHjNYZ1H8DOwy2Vu2WX4wIct5Vkok1I6J99Sbn0sCzoqGrPSlR4YMjMpWrvNLZ3Kkzf2tlvlJPj
	HbjuMg4CDNoAk9Q7bvH0ytR9h6XIim4Ukf5q5Yf/ExlZXreqE2RkNWkXHdd76PR0YdfC+w8KwrHeV
	65jGZ4jnaIlMIkhQdr25E/ak3WJYc9uIfhYs8xaMkfuxr6od16qQGCnYHExMW35L7wjweUaUJMzJm
	F9qKL7dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcPhD-00ExBX-Mr; Mon, 18 Oct 2021 10:16:43 +0000
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcPcY-00Eu6p-Hz; Mon, 18 Oct 2021 10:11:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, "Theodore Ts'o" <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 08/30] target/iblock: use bdev_nr_bytes instead of open coding
 it
Date: Mon, 18 Oct 2021 12:11:08 +0200
Message-Id: <20211018101130.1838532-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Oct 2021 03:14:03 -0700
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

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/target/target_core_iblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 31df20abe141f..b1ef041cacd81 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -232,9 +232,9 @@ static unsigned long long iblock_emulate_read_cap_with_block_size(
 	struct block_device *bd,
 	struct request_queue *q)
 {
-	unsigned long long blocks_long = (div_u64(i_size_read(bd->bd_inode),
-					bdev_logical_block_size(bd)) - 1);
 	u32 block_size = bdev_logical_block_size(bd);
+	unsigned long long blocks_long =
+		div_u64(bdev_nr_bytes(bd), block_size) - 1;
 
 	if (block_size == dev->dev_attrib.block_size)
 		return blocks_long;
-- 
2.30.2


