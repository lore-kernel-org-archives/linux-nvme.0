Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16E606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jMMe2+9q;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=1QNNjn2g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v8quR/qQbHP8x5qxLl+rCpSGM4ITARqPB9AodIBRjJo=; b=jMMe2+9qr5fnhoxfPojG8pUh72
	l5YXXOdYSx2vLgbXG4goRUKZl3ghQR7mmxdqofNCBnvikI9rKwGKgfbOeRgZzIFuGn9WtLSbzDZJk
	W9Eo5apor/NZefl2tzT9tPIM8pK/alE6oCHdYh5/1tQiN8W6KltJH7mw57QRZo8MOqrZ2tZ2AUji1
	Q4A1/RDY9fIpGqFh8iPDIuy5rk+eP7D5B5ELiBpXgZ/0QvgkIwlkfGkTN5MwGamDLPiGG7lh6Yxoa
	UImQJu/FW2cyW8rXHWkEkJDiKdtfz+A48RnnxGx2Hii6pgyCrmaLz56w9r8cPTt2pt2dblZ7sclbh
	ZBhJXAXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3H-0000000ECe2-1qWo;
	Fri, 13 Nov 2026 19:35:11 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVMV-0000000AAMA-1wvo
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 14:01:14 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMVq6fc9z4yjjL;
	Thu, 12 Nov 2026 22:01:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492067;
	bh=BlI3/KUCsukXz3p66Ixal03TgAg+1W0oe+w4087oj8I=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=1QNNjn2gKlKr5SNab8kUc6RUpuXXr3CWkmanGJ7ZPWH1S5sOrSWmwTKa0IRupi3G1
	 bAAIu4YPB8t67UkY/VRMfALIfCO4k15oW4s6V47NCmUnP4hP2KFQuceZ5Vtzabix5P
	 SKgNDwV1z0WBJpN+jZKxk/13eIzciyc8AFO88xlFLFi4jwRmp0Q5rL2SmLTD1LGPE6
	 DjJgiSweIvnD4KfqAld0oJ5W7owfYQncxoR4hCScW7TauxpMDw1hlHQ2IFLWhc/Sjq
	 ezIXpYURkJQci1f55EnQSbej05vSoY0c1g7uY+vdry1EcrhAimJ9l19acNim7SEk2g
	 KiDFOjO0gTGIg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ACE12cf036815;
	Thu, 12 Nov 2026 22:01:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:05 +0800 (CST)
X-Zmail-TransId: 2afc6af5c6a1517-d6c93
X-Mailer: Zmail v1.0
Message-ID: <20261112220105340AIwfaxoF7-iONJ2bZlEqI@zte.com.cn>
In-Reply-To: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
References: 20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:05 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gbnZtZXQ6IGhhbmRsZSBzaG9ydCByZWFkcyBhbmQgd3JpdGVzIGluIHRoZSBmaWxlIGJhY2tlbmQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6ACE12cf036815
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6A3.002/4jQMVq6fc9z4yjjL
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_060112_785195_FD887455 
X-CRM114-Status: GOOD (  15.97  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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

When the file backend falls back to its bvec mempool, large requests
are submitted in synchronous chunks.  A short completion advances the
file position by the full chunk length and is eventually overwritten
with the total request length.  The target reports success for an
incomplete write or returns unread buffer contents as valid data.

The common completion path has another short-I/O case: a zero-byte
return, such as a read at EOF after the backing file is truncated, is
passed to errno_to_nvme_status() and becomes success.

Stop at any incomplete chunk and convert nonnegative short completions
to -EIO in both paths.  Preserve negative errors and full completions.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code unchanged; add the Christoph Hellwig Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261111224245786kBVGPR0wSFFqHjmtHwtAJ@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG) with the loop transport and a
file-backed namespace on tmpfs (buffered_io=1).

The chunked path is only taken when the bio_vec allocation falls back
to the mempool, so failslab was used to fail that allocation, limited to
nvmet_file_execute_rw() with the stack-trace filter (times=1,
ignore-gfp-wait=N).  The short completion was made deterministic by
shrinking the backing file behind nvmet's back (ns->size is only
revalidated on enable) and by leaving only 4 KiB of space in the tmpfs
for the last 64 KiB chunk of a 128 KiB write.  The values below are the
status words returned by NVME_IOCTL_IO_CMD:

                              unpatched    patched
  read  512 KiB               ret=0        ret=24582 (0x6006)
  read  256 KiB               ret=0        ret=24582
  read  128 KiB               ret=0        ret=24582
  write 128 KiB               ret=0        ret=24582

0x6006 contains NVME_SC_INTERNAL plus the Do Not Retry and More bits;
the More bit records the associated error-log entry.
Without the patch the reads report success although the tail of the
host buffer still holds the 0x5a pattern, and the write reports success
although only 68 KiB of 128 KiB reached the file.  Controls: without the
injection the short read already fails with 0x6006 on both kernels
(non-chunked path), and with the injection but a full-length read both
return 0.

 drivers/nvme/target/io-cmd-file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932ee758b7b89cf7a3d017407a3a6716..e95ab1f08cff39b0a1147e53bbd7749a831d29a6 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -113,7 +113,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 	}
 
 	if (unlikely(ret != req->transfer_len))
-		status = errno_to_nvme_status(req, ret);
+		status = errno_to_nvme_status(req, ret < 0 ? ret : -EIO);
 	nvmet_req_complete(req, status);
 }
 
@@ -150,8 +150,11 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		if (unlikely(is_sync) &&
 		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
 			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
-			if (ret < 0)
+			if (ret != len) {
+				if (ret >= 0)
+					ret = -EIO;
 				goto complete;
+			}
 
 			pos += len;
 			bv_cnt = 0;

