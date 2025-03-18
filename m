Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7FC35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQO7dVNEgWH3T/RkVp08P5pAS5PmBYOFbz23aQiL+RE=; b=gCaCmMOqKNJAnJ8EJA/gEaoBlX
	MxHGqxI6NkTMTlnmjGIds1OoZdnC9Is7s/XfWHJ+Xp8l91sH0tg/DEcUfFMdfLNnW1wd+JHsLZhBX
	7Bm/rl9wTDYNZs10gQnUGNH74169cjRuI7MSrUGpATQBOj1dKBbCFGL5OjIwMKYiekD1aLXd2LF4Q
	bv1v1foA0Y/QqCZm6rurdc19xCYBEngr9I5/suyB28LoaXAbOm1ceZviXuV3GKYysaXQ4HzlEk1O1
	z8w7S0TnO6s0jF8O+sbxcrrsjeZ+4Bh3Q8/G+bE0fs88dy96DAwIgr1BYNZ39BZZLtetvDuo1hiOK
	yKMk54Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTQ-00000004vpt-10yD;
	Tue, 18 Mar 2025 07:34:52 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRTM-00000004vmL-2q48
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 07:34:50 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WS6HQNz4f3jjr
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 291F41A08FC
	for <linux-nvme@lists.infradead.org>; Tue, 18 Mar 2025 15:34:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S8;
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
Subject: [PATCH xfstests 4/5] fstress: add fallocate write zeroes support
Date: Tue, 18 Mar 2025 15:26:14 +0800
Message-ID: <20250318072615.3505873-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
References: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnCl8EItlnJDdYGw--.56140S8
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDAr45Kw4UXFWDurWUXFb_yoW8uFy3pa
	yDtFW8Cay8Wa4ayr18urs5WFn0qrsYqr15C397Kr1IvayYyr9Igrn0g3s5Gw1DXFWDtay5
	ZF90gFyq93WUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250318_003449_013847_3C8A2BF9 
X-CRM114-Status: UNSURE (   8.66  )
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

Add fstress to suppoet fallocate FALLOC_FL_WRITE_ZEROES command by
introducing OP_WZERO operation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 ltp/fsstress.c | 12 ++++++++++++
 src/global.h   |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 3d248ee2..ed2a54ab 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -114,6 +114,7 @@ typedef enum {
 	OP_MWRITE,
 	OP_PUNCH,
 	OP_ZERO,
+	OP_WZERO,
 	OP_COLLAPSE,
 	OP_INSERT,
 	OP_READ,
@@ -245,6 +246,7 @@ void	mread_f(opnum_t, long);
 void	mwrite_f(opnum_t, long);
 void	punch_f(opnum_t, long);
 void	zero_f(opnum_t, long);
+void	wzero_f(opnum_t, long);
 void	collapse_f(opnum_t, long);
 void	insert_f(opnum_t, long);
 void	unshare_f(opnum_t, long);
@@ -312,6 +314,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_MWRITE]	   = {"mwrite",	       mwrite_f,	2, 1 },
 	[OP_PUNCH]	   = {"punch",	       punch_f,		1, 1 },
 	[OP_ZERO]	   = {"zero",	       zero_f,		1, 1 },
+	[OP_WZERO]	   = {"wzero",	       wzero_f,		1, 1 },
 	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
 	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
 	[OP_READ]	   = {"read",	       read_f,		1, 0 },
@@ -3758,6 +3761,7 @@ struct print_flags falloc_flags [] = {
 	{ FALLOC_FL_NO_HIDE_STALE, "NO_HIDE_STALE"},
 	{ FALLOC_FL_COLLAPSE_RANGE, "COLLAPSE_RANGE"},
 	{ FALLOC_FL_ZERO_RANGE, "ZERO_RANGE"},
+	{ FALLOC_FL_WRITE_ZEROES, "WRITE_ZEROES"},
 	{ FALLOC_FL_INSERT_RANGE, "INSERT_RANGE"},
 	{ FALLOC_FL_UNSHARE_RANGE, "UNSHARE_RANGE"},
 	{ -1, NULL}
@@ -4446,6 +4450,14 @@ zero_f(opnum_t opno, long r)
 #endif
 }
 
+void
+wzero_f(opnum_t opno, long r)
+{
+#ifdef HAVE_LINUX_FALLOC_H
+	do_fallocate(opno, r, FALLOC_FL_WRITE_ZEROES);
+#endif
+}
+
 void
 collapse_f(opnum_t opno, long r)
 {
diff --git a/src/global.h b/src/global.h
index fbc0a0b5..6b1e30c9 100644
--- a/src/global.h
+++ b/src/global.h
@@ -175,6 +175,10 @@
 #define FALLOC_FL_ZERO_RANGE		0x10
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+#define FALLOC_FL_WRITE_ZEROES		0x80
+#endif
+
 #ifndef FALLOC_FL_INSERT_RANGE
 #define FALLOC_FL_INSERT_RANGE		0x20
 #endif
-- 
2.46.1


