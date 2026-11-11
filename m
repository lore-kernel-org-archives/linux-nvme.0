Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B5606A337
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UrSjmCh7;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DTjA449H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Is2Qw4KwfsCgWxutP7xyosQOwa+vDqMv8BX4qqT0dxI=; b=UrSjmCh7aaXrCvZ9lH05H6JsVv
	DoFgLBTQXkHac3JD9f9zMEZ9fvLVlMMvuWvLIqm1EUT7TOz/k85P5TzIHWF3BU187qReWbds21N5z
	t5miLfW6Rp8oVsiVTBXIjEouQVPRKRBAzyowSUxCvp1NaAb+rcjQMCc+nWiol5mhxNwZOSvgR+9Eq
	6fXOhLA5sQfP0Ixmg49+dTvuQJrd1RrgiW3l0dtZ6tpq77yEQM8dRGN8z5/fl+U463pOJrjvbht5d
	H0smigegEGKFAdWr+Fa5z1o0cIz8TUuLYyNzDiszsO6ZCKkCimBYkBNQlcQ02MYCCdWt6LHoVaS5F
	g4rEKb8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFiB-00000007m49-0px6;
	Wed, 11 Nov 2026 21:18:31 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR9XK-00000006zlU-24GQ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 14:42:56 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmTR4mlCz5BNS0;
	Wed, 11 Nov 2026 22:42:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408171;
	bh=IzuiCSP5pU3bvzUwHFnQ1wq0w2ckTj4EwbmRQgtXJyw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=DTjA449HmBnNWm7D/JJKB9ay7DNFMz82Jnsuoy/GFxzWlzBut3T8FdOKsf7DEjtUK
	 +7GEsprgD4XTwYN+UXB7bwbzKs4r3stLs64utWqTtXob4WesdCPJPlsptp1ia6H9og
	 BGl4Pdz89grcQkeaMZwq9PWcV9X7RCBxRC2AONCIP/a62WLNy7iQMFdLCXztHUtvET
	 csJ4Qxt06HJpdQsdDAVAA5SiOoeF0Kp6jq1Uply/9KVC6YcW28PizUg51B71xhprog
	 b1C0qy9Ql9wULtX7StY81L2aQ8Og0RfoVbbLF1ruRfCCB+j1r6nAElSUaEKdU1WYlF
	 LWW/vMQ+fibFQ==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ABEgjjl064559;
	Wed, 11 Nov 2026 22:42:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:42:47 +0800 (CST)
X-Zmail-TransId: 2afa6af47ee7701-7a5d3
X-Mailer: Zmail v1.0
Message-ID: <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
In-Reply-To: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn
Date: Wed, 11 Nov 2026 22:42:47 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IHVzZSBvdmVyZmxvdy1zYWZlIHJhbmdlIGNoZWNrcyBpbiB0aGUgZmlsZSBiYWNrZW5k?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6ABEgjjl064559
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 22:42:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EEB.000/4jPmTR4mlCz5BNS0
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_064255_106458_134E1C4D 
X-CRM114-Status: GOOD (  11.98  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The file backend shifts a host-supplied SLBA to form a byte offset
before checking it against the namespace size. The shift can discard
high bits: with a 4 KiB block size, SLBA 2^52 + 1 becomes offset 4096.
The range check then accepts a command aimed outside the namespace and
the backend accesses data at the wrapped offset.

Reject overflowing LBA-to-byte conversions and check the transfer
length against the remaining namespace size without adding it to the
offset. Apply the checks to reads, writes, discard and write zeroes.

Fixes: 9c891c139894 ("nvmet: check fileio lba range access boundaries")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and a 4 MiB file-backed namespace.

A Write with SLBA = 2^52 + 1 and a 4 KiB block size yields a byte
offset that wraps to 0x1000 and passes the size check:

  unpatched                            patched
  ret=0 (write accepted at 0x1000)     ret=24705 (Capacity Exceeded)
  drivers/nvme/target/io-cmd-file.c |   41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..d59dbf61b1b0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -125,17 +125,22 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
+	u64 pos64;
 	int i;
 	struct scatterlist *sg;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
 
-	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
-	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+	if (unlikely(check_shl_overflow(le64_to_cpu(req->cmd->rw.slba),
+					req->ns->blksize_shift,
+					&pos64) ||
+		     pos64 > req->ns->size ||
+		     req->transfer_len > req->ns->size - pos64)) {
 		ret = -ENOSPC;
 		goto complete;
 	}
+	pos = pos64;
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
@@ -269,6 +274,16 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static bool nvmet_file_check_lba_range(struct nvmet_req *req, u64 slba,
+				       u64 nlb, u64 *offset, u64 *len)
+{
+	if (check_shl_overflow(slba, req->ns->blksize_shift, offset) ||
+	    check_shl_overflow(nlb, req->ns->blksize_shift, len))
+		return false;
+
+	return *offset <= req->ns->size && *len <= req->ns->size - *offset;
+}
+
 static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
@@ -279,19 +294,22 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int i;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
+		u64 offset64, len64;
+
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
 		if (status)
 			break;
 
-		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-		len = le32_to_cpu(range.nlb);
-		len <<= req->ns->blksize_shift;
-		if (offset + len > req->ns->size) {
+		if (!nvmet_file_check_lba_range(req, le64_to_cpu(range.slba),
+						le32_to_cpu(range.nlb),
+						&offset64, &len64)) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, -ENOSPC);
 			break;
 		}
+		offset = offset64;
+		len = len64;
 
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
 		if (ret && ret != -EOPNOTSUPP) {
@@ -336,16 +354,17 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	u64 offset64, len64;
 	int ret;
 
-	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
-	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
-			req->ns->blksize_shift);
-
-	if (unlikely(offset + len > req->ns->size)) {
+	if (!nvmet_file_check_lba_range(req, le64_to_cpu(write_zeroes->slba),
+					(u64)le16_to_cpu(write_zeroes->length) + 1,
+					&offset64, &len64)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return;
 	}
+	offset = offset64;
+	len = len64;
 
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);

