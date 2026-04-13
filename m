Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47547F34C63
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QU6H28LoAmjDN6oT30Cs3wR+ut2/Ximz1NUOhIF22q8=; b=kcuCGPa3lkSz17TnOLJPYxsT65
	hA3s3EgnHuCBxuc1jSU5+qwP2ZUHJwLI14ERPzghCgVSPXhP/Iuk+jP9jmiugA/P22t6Z8m6fgV+w
	mWusRiucsj8zuu4jGyDNLADxhFH5cifwv7I9Z968CjR5BJjYIk/iEyvcLGzeuxszpmG62ebAYSpNi
	zSdJy5JHKf5bghwiYcosrMZvJy1LgT04z19w3YUL3tnODCxb49FFXfMIuecl8zXlDIfXPrcHuvYAO
	frsVm9/2KZztyRGcFmjmyU+33ICH+RlST7jyjKiDZUf03hqiHFjKVo5RfhOEULcOc55TkMOrsRjwZ
	9rdXkhtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKe1-0000000G6Ow-1Qf7;
	Mon, 13 Apr 2026 17:00:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKe0-0000000G6Oj-1TKf
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 17:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7569161858;
	Mon, 13 Apr 2026 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14B0C2BCAF;
	Mon, 13 Apr 2026 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099615;
	bh=ZWntAkkj+FDQR+Wh+BTq5BACdUov9m/5CpM5nrE0wOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ei2CfFetzMDdYZLezjtaK/fs3jUYp73cQj9l3iL/rh6oLIdoLc+qdOnrtOWl4/OPN
	 r/koPj3RxpdBskppyS5Py1hl2YsVHx8t/kLP0olNONCZv2/EEJ7XHnT9kj1SKdZEha
	 FbT/EAinJewmeSzmuNJLD7h+gAWYAeTpDxbOOTc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	YunJe Shin <ioerts@kookmin.ac.kr>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Cengiz Can <cengiz.can@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 408/491] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Mon, 13 Apr 2026 18:00:53 +0200
Message-ID: <20260413155834.306257066@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cengiz Can <cengiz.can@canonical.com>

The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
the iov_len calculation:

    while (length) {
        u32 iov_len = min_t(u32, length, sg->length - sg_offset);

        if (!sg_remaining) {    /* too late: sg already dereferenced */

In mainline, the checks come first because C99 allows mid-block variable
declarations. The stable backport moved the declaration to the top of the
loop to satisfy C89 declaration rules, but this ended up placing the
sg->length dereference before the sg_remaining and sg->length guards.

If sg_next() returns NULL at the end of the scatterlist, the next
iteration dereferences a NULL pointer in the iov_len calculation before
the sg_remaining check can prevent it.

Fix this by moving the iov_len declaration to function scope and
keeping the assignment after the bounds checks, matching the ordering
in mainline.

Fixes: 043b4307a99f ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Cc: stable@vger.kernel.org
Cc: YunJe Shin <ioerts@kookmin.ac.kr>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5d8e57e5fdb18..6db9dcdbb3c34 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -300,7 +300,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
-	u32 length, offset, sg_offset;
+	u32 length, offset, sg_offset, iov_len;
 	unsigned int sg_remaining;
 	int nr_pages;
 
@@ -317,8 +317,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
-
 		if (!sg_remaining) {
 			nvmet_tcp_fatal_error(cmd->queue);
 			return;
@@ -328,6 +326,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 			return;
 		}
 
+		iov_len = min_t(u32, length, sg->length - sg_offset);
+
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = iov_len;
 		iov->bv_offset = sg->offset + sg_offset;
-- 
2.53.0




