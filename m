Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE9C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RS8TQAAQJ+ErOBgjsOEm2SqNf0pnIqK5EFfRKzUBDmY=; b=S5RXFNSEayyXeKD69sndFyrQpV
	2wmzGxRdV+qiktbGqpG5QGsXe/PCpli6vRXo1gvLgC0SzTj/wOaTjwdlF5zi/FsVni/YbCzbfTfFW
	j9qor++AS6MesW72ThDyTP6P92P2rSA6ZVbFwVzJfdYBtTnPXDVNkxuxH5mUNc+ejG+ahjCofcNu/
	yfbuSLaky15qFPe3Hiv/dZKR4j7NgmdHSu+7Ujq42/zS3WucpsUWrV0WJT16RDYA22oypRXfR8Eqc
	LZuEv5s9QepnEjQo9qRpdWbtouEruAL2XkeRoxg17Rou7CRwwCp99gWlrzHxRclBNPuUUARcbEwKN
	SBHnFU5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTT-00000004vtn-0rzG;
	Tue, 18 Mar 2025 07:34:55 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTN-00000004vmf-1HW8
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:34:51 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WL5kJPz4f3m6g
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DCA381A058E
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S9;
	Tue, 18 Mar 2025 15:34:46 +0800 (CST)
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
Subject: [PATCH xfstests 5/5] fsx: add fallocate write zeroes support
Date: Tue, 18 Mar 2025 15:26:15 +0800
Message-ID: <20250318072615.3505873-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
References: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8EItlnJDdYGw--.56140S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGF48Zr4DCrWfWF4kAF4fXwb_yoWrKw4DpF
	WkK3yrKFy0qF9xAr4fC3WkWFs0gwn5uryfCrW2yr1rZ3y3ta4fKan0gry0gr1UWr47Ja13
	J3WYv39F9F4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRJ3kZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_003449_679959_C7A940A4 
X-CRM114-Status: GOOD (  12.66  )
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

Add fsx to suppoet fallocate FALLOC_FL_WRITE_ZEROES command by
introducing OP_WRITE_ZEROES operation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 ltp/fsx.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..0c5dc93f 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -111,6 +111,7 @@ enum {
 	OP_FALLOCATE,
 	OP_PUNCH_HOLE,
 	OP_ZERO_RANGE,
+	OP_WRITE_ZEROES,
 	OP_COLLAPSE_RANGE,
 	OP_INSERT_RANGE,
 	OP_CLONE_RANGE,
@@ -175,6 +176,7 @@ int     keep_size_calls = 1;            /* -K flag disables */
 int     unshare_range_calls = 1;        /* -u flag disables */
 int     punch_hole_calls = 1;           /* -H flag disables */
 int     zero_range_calls = 1;           /* -z flag disables */
+int	write_zeroes_calls = 1;		/* -M flag disables */
 int	collapse_range_calls = 1;	/* -C flag disables */
 int	insert_range_calls = 1;		/* -I flag disables */
 int	mapped_reads = 1;		/* -R flag disables it */
@@ -273,6 +275,7 @@ static const char *op_names[] = {
 	[OP_FALLOCATE] = "fallocate",
 	[OP_PUNCH_HOLE] = "punch_hole",
 	[OP_ZERO_RANGE] = "zero_range",
+	[OP_WRITE_ZEROES] = "write_zeroes",
 	[OP_COLLAPSE_RANGE] = "collapse_range",
 	[OP_INSERT_RANGE] = "insert_range",
 	[OP_CLONE_RANGE] = "clone_range",
@@ -450,6 +453,13 @@ logdump(void)
 			if (overlap)
 				prt("\t******ZZZZ");
 			break;
+		case OP_WRITE_ZEROES:
+			prt("WZERO    0x%x thru 0x%x\t(0x%x bytes)",
+			    lp->args[0], lp->args[0] + lp->args[1] - 1,
+			    lp->args[1]);
+			if (overlap)
+				prt("\t******ZZZZ");
+			break;
 		case OP_COLLAPSE_RANGE:
 			prt("COLLAPSE 0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
@@ -1352,6 +1362,58 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 }
 #endif
 
+#ifdef FALLOC_FL_WRITE_ZEROES
+void
+do_write_zeroes(unsigned offset, unsigned length)
+{
+	unsigned end_offset;
+	int mode = FALLOC_FL_WRITE_ZEROES;
+
+	if (length == 0) {
+		if (!quiet && testcalls > simulatedopcount)
+			prt("skipping zero length write zeroes\n");
+		log4(OP_WRITE_ZEROES, offset, length, FL_SKIPPED);
+		return;
+	}
+
+	end_offset = offset + length;
+	if (end_offset > biggest) {
+		biggest = end_offset;
+		if (!quiet && testcalls > simulatedopcount)
+			prt("write_zeroes to largest ever: 0x%x\n", end_offset);
+	}
+
+	log4(OP_WRITE_ZEROES, offset, length, FL_NONE);
+
+	if (end_offset > file_size)
+		update_file_size(offset, length);
+
+	if (testcalls <= simulatedopcount)
+		return;
+
+	if ((progressinterval && testcalls % progressinterval == 0) ||
+	    (debug && (monitorstart == -1 || monitorend == -1 ||
+		      end_offset <= monitorend))) {
+		prt("%lld write zeroes\tfrom 0x%x to 0x%x, (0x%x bytes)\n", testcalls,
+			offset, offset+length, length);
+	}
+	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
+		prt("write zeroes: 0x%x to 0x%x\n", offset, offset + length);
+		prterr("do_write_zeroes: fallocate");
+		report_failure(161);
+	}
+
+	memset(good_buf + offset, '\0', length);
+}
+
+#else
+void
+do_write_zeroes(unsigned offset, unsigned length)
+{
+	return;
+}
+#endif
+
 #ifdef FALLOC_FL_COLLAPSE_RANGE
 void
 do_collapse_range(unsigned offset, unsigned length)
@@ -2296,6 +2358,12 @@ have_op:
 			goto out;
 		}
 		break;
+	case OP_WRITE_ZEROES:
+		if (!write_zeroes_calls) {
+			log4(OP_WRITE_ZEROES, offset, size, FL_SKIPPED);
+			goto out;
+		}
+		break;
 	case OP_COLLAPSE_RANGE:
 		if (!collapse_range_calls) {
 			log4(OP_COLLAPSE_RANGE, offset, size, FL_SKIPPED);
@@ -2372,6 +2440,10 @@ have_op:
 		TRIM_OFF_LEN(offset, size, maxfilelen);
 		do_zero_range(offset, size, keep_size);
 		break;
+	case OP_WRITE_ZEROES:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		do_write_zeroes(offset, size);
+		break;
 	case OP_COLLAPSE_RANGE:
 		TRIM_OFF_LEN(offset, size, file_size - 1);
 		offset = rounddown_64(offset, block_size);
@@ -2519,6 +2591,9 @@ usage(void)
 #ifdef FALLOC_FL_ZERO_RANGE
 "	-z: Do not use zero range calls\n"
 #endif
+#ifdef FALLOC_FL_WRITE_ZEROES
+"	-z: Do not use write zeroes calls\n"
+#endif
 #ifdef FALLOC_FL_COLLAPSE_RANGE
 "	-C: Do not use collapse range calls\n"
 #endif
@@ -3019,6 +3094,9 @@ main(int argc, char **argv)
 		case 'z':
 			zero_range_calls = 0;
 			break;
+		case 'M':
+			write_zeroes_calls = 0;
+			break;
 		case 'C':
 			collapse_range_calls = 0;
 			break;
@@ -3281,6 +3359,8 @@ main(int argc, char **argv)
 		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
 	if (zero_range_calls)
 		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
+	if (write_zeroes_calls)
+		write_zeroes_calls = test_fallocate(FALLOC_FL_WRITE_ZEROES);
 	if (collapse_range_calls)
 		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
 	if (insert_range_calls)
-- 
2.46.1


