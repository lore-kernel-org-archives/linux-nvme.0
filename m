Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC21606A338
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wV9gIWVH;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=caLjPQaC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eofb4rt//CPwrsXnyaQEibO9rgJnVVcYMlLVW1+iWbw=; b=wV9gIWVHGG7Tg6xRmPYVzpFP2p
	24i0KjbbQ53G1ATUpboHIkFtT+tGLx7oKwkinQZQhkQWONiUmd7tXNmDTGbW8z1SdJqXrAZQeIfsn
	J6pt8QuuWznrIPKYj/GLXdo4BHFArP8jbvhAXueGGoTNXumsoLpb0S4iTarVoOAzP7gEFpNBiDP5p
	tRHh5AYC4EWPhVU/xu5k88qLujRM1vfSi1s3XCKOH3oLESeS3nSLgT1yWuXQeu8Z9mokWJtMNHzSD
	TMElsQ189fTvhbrN7RWcuLJWM1Ynh+XUhZyzkEhcEbzsAc5VRmHOJ+dhNNKFqT3h/gIr0oDUWGSb6
	g15r03og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFiC-00000007m7o-0QBA;
	Wed, 11 Nov 2026 21:18:32 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR9XO-00000006znO-39D7
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 14:43:03 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jPmTM1l34z4xPSJ;
	Wed, 11 Nov 2026 22:42:47 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408167;
	bh=TtW33jKya7yf+pIUAp6NxKrTz7rbR+eAywMN6yjOfLc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=caLjPQaC9uVHp6phKWlY2a2p2VxatWLEpBOT6ZJrHEKosCsF/OlvgUOOr04hkhEQ4
	 SHJmQeh7a6zCTOPF2B2+fkFXX0aKrCvweJdRU67X48vykmx7g+bGjEEwrTI8vpOgBh
	 zc8PUqOg7YUU0frMASA/J8gxjZcYpbShoOeiGGyh9j5qm2WZDkXLZCc3N6HQ+gJR1K
	 /cybsQxozOi4Uc0FCmkUm32DAqb6CRGJNsGEMsfzEgh9SuqEAeUI3OA4iEAR1dR7jU
	 06fsHSCtupHO2QL0zfRDtsN6CHKsM2INgmtsXM6l0f+7ppuO+FHzJ3TSTKBUSmKpey
	 uYifJ6Yg5r1yQ==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ABEgiEQ094719;
	Wed, 11 Nov 2026 22:42:44 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:42:45 +0800 (CST)
X-Zmail-TransId: 2afa6af47ee5690-7a562
X-Mailer: Zmail v1.0
Message-ID: <20261111224245786kBVGPR0wSFFqHjmtHwtAJ@zte.com.cn>
In-Reply-To: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn
Date: Wed, 11 Nov 2026 22:42:45 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IGhhbmRsZSBzaG9ydCByZWFkcyBhbmQgd3JpdGVzIGluIHRoZSBmaWxlIGJhY2tlbmQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ABEgiEQ094719
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:42:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EE7.000/4jPmTM1l34z4xPSJ
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_064258_948970_D1966153 
X-CRM114-Status: GOOD (  14.46  )
X-Spam-Score: -4.4 (----)
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
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

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
  drivers/nvme/target/io-cmd-file.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..e95ab1f08cff 100644
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

