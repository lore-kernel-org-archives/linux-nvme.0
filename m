Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93133C87FCF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 04:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6YGs7neiL7iTizP6MdZ7ZelY5j/XMDSmhwxJUQnZask=; b=0SmYt9WbxBYEXSTmPvYLuiMTU9
	tnQKBtXi1Chxt05KfsvnYBA0LESoEsbsww5nDSTMs9O/j9FejqZgBOP9VEuwAXBBxyTvs0AqQ1UMt
	yAH37zrzxWdvL08Ua+dQ8/DhVhZVRKY90wCRpqhc+gaOcl4onPwbI5Ne5cPqNSaKkScJGi94i5R91
	PVMp2cUAgoWOxqzyVzbzR4wRSpNFB4bbIkhwImW2z2y19QW16bfDXfEFtdECg0FG3bMAL7A6Sx5Ig
	9CZwSRgBOF7OwU0FKyVVxqxeDlsiMqs1Mkg1BzkCABEVNaiTrKEDJ9KVIF+S6jdZIg379AwQQI/ss
	alktc/eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2fi-0000000CYSv-3LJN;
	Wed, 13 Aug 2025 04:01:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1Zr-0000000CSDa-3tep
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Aug 2025 02:51:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6YGs7neiL7iTizP6MdZ7ZelY5j/XMDSmhwxJUQnZask=; b=Qt//LGBg0f3b+mJsP92S20OwCy
	J04kE0/ybSLY5aR2+CqtuxLMWhax4wKxBOxjrNCSF4T7Gn05josIB5/SfOGQyaEyGwZYmDDgjSqND
	G9kk5muYlspvVpsKGL1KOIdBosaOklFHHbgoKTiuF37Y0ggThqmnQtqw7TmVLXuAf8WFNw7YZY+jg
	2zmNwa3BoX7ZW0pekj52I5DtjfVL3Xz36EdmkdCdEw1MJTEUZBU6J1l151CXFE8BCQ9rUpGp4U2Q8
	n3MCJAKmwi4urKtcWV/Rv48uEjkRYNR0IjHjm6e1NjAfhwAINNpRymq50Vntd7w0PR7VTFX5mfWZU
	cONMxPUQ==;
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um1Zm-0000000FwkJ-34Cx
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 02:50:58 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1tCg1bhszYQv5N
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:50:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D11C91A0A22
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 10:50:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxB2_ZtofKcBDg--.14943S4;
	Wed, 13 Aug 2025 10:50:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH xfsprogs v2] xfs_io: add FALLOC_FL_WRITE_ZEROES support
Date: Wed, 13 Aug 2025 10:42:50 +0800
Message-Id: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHjxB2_ZtofKcBDg--.14943S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur17Jw1kCF1rXw15JF15twb_yoW5Xr1Up3
	9rXF1UKa45Xry7WayfGws7WFn8Wws2kr1fJr4xWr1UZ3W5AFyxKFn8G3Z5X3s7WFWxCa1U
	JFnIqFy5G3WSy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-CRM114-CacheID: sfid-20250813_035055_713906_B2557EED 
X-CRM114-Status: GOOD (  11.48  )
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

The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
fallocate utility by introducing a new 'fwzero' command in the xfs_io
tool.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Minor description modification to align with the kernel.

 io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
 man/man8/xfs_io.8 |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/io/prealloc.c b/io/prealloc.c
index 8e968c9f..9a64bf53 100644
--- a/io/prealloc.c
+++ b/io/prealloc.c
@@ -30,6 +30,10 @@
 #define FALLOC_FL_UNSHARE_RANGE 0x40
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+#define FALLOC_FL_WRITE_ZEROES 0x80
+#endif
+
 static cmdinfo_t allocsp_cmd;
 static cmdinfo_t freesp_cmd;
 static cmdinfo_t resvsp_cmd;
@@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
 static cmdinfo_t finsert_cmd;
 static cmdinfo_t fzero_cmd;
 static cmdinfo_t funshare_cmd;
+static cmdinfo_t fwzero_cmd;
 
 static int
 offset_length(
@@ -377,6 +382,27 @@ funshare_f(
 	return 0;
 }
 
+static int
+fwzero_f(
+	int		argc,
+	char		**argv)
+{
+	xfs_flock64_t	segment;
+	int		mode = FALLOC_FL_WRITE_ZEROES;
+
+	if (!offset_length(argv[1], argv[2], &segment)) {
+		exitcode = 1;
+		return 0;
+	}
+
+	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
+		perror("fallocate");
+		exitcode = 1;
+		return 0;
+	}
+	return 0;
+}
+
 void
 prealloc_init(void)
 {
@@ -489,4 +515,14 @@ prealloc_init(void)
 	funshare_cmd.oneline =
 	_("unshares shared blocks within the range");
 	add_command(&funshare_cmd);
+
+	fwzero_cmd.name = "fwzero";
+	fwzero_cmd.cfunc = fwzero_f;
+	fwzero_cmd.argmin = 2;
+	fwzero_cmd.argmax = 2;
+	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
+	fwzero_cmd.args = _("off len");
+	fwzero_cmd.oneline =
+	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
+	add_command(&fwzero_cmd);
 }
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index b0dcfdb7..0a673322 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -550,6 +550,12 @@ With the
 .B -k
 option, use the FALLOC_FL_KEEP_SIZE flag as well.
 .TP
+.BI fwzero " offset length"
+Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
+.BR fallocate (2)
+manual page to allocate and zero blocks within the range by submitting write
+zeroes.
+.TP
 .BI zero " offset length"
 Call xfsctl with
 .B XFS_IOC_ZERO_RANGE
-- 
2.39.2


