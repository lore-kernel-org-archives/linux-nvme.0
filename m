Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42778606A327
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z63kY8Hu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fzc7kAr5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=IjmuRlFL2bJRVADp4MlBFh4B4IKstGbergvo3kG0xeo=; b=Z63kY8HulWSo8xpas3j1+ZQA/9
	TAVT0nlA6ZK8rZeOsjgNhedVkZXSIHbmQVGcgBDkNHnsQpnBvF2KE7T8/rHD2cldM43ws++Fmz4Wr
	jKDSSVlTOPsTBqbW32GRhT8OSprIrmoV5qNznNY0EA44bFEQPMAj4Ytyk/0osFclEabYSaH+/tBDr
	7OidEZmzj0DGL31uEWxn9p9ah0N0aOiEGdIZPtnqcilinaXcZzrCGTVdXEOloudd5A06BpM7qVpFm
	Ch7aEmNgqiLJp6udyJVC/iVbxV6iKLf+fETHl9qhSRD+tauel5QjfkAOr/GvCqw3V2X8ICkR1HBRZ
	efpI9ZYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Hd-00000008Xy3-40g4;
	Wed, 25 Nov 2026 06:15:09 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6HV-00000008Xvv-3q1Q
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795587298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IjmuRlFL2bJRVADp4MlBFh4B4IKstGbergvo3kG0xeo=;
	b=Fzc7kAr5BSzyv/AE2rDA6HGSmN1y217gmWCtlvTpJf9mvxRCgKSQU4BF8BLgoC1kawV5BowyVBoyum5xw00kUPKlKJ+Nb3tpPFbCbCJpD6fufhFgA6/ihywvB5CjcASxTtrp1PaAzmZeuSE+7AP73KWrscaStO91Nwnbco2W2t4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQiE-L_1795587297;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQiE-L_1795587297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:14:57 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: zero the reservation report tail beyond NUMD
Date: Wed, 25 Nov 2026 14:14:52 +0800
Message-ID: <20261125061453.230238-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_221502_164251_319A0254 
X-CRM114-Status: GOOD (  12.81  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reservation report handler allocates a buffer of 4 * (NUMD + 1)
bytes and copies it to the command SGL, but the data is sent back to
the host using the SGL length, which is independent of NUMD. When the
host supplies a buffer larger than NUMD, the tail beyond the copied
data is returned uninitialised, leaking kernel heap contents to a
fabric host.

Zero the SGL tail beyond the transferred data, as the discovery log
page handler already does.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Found by code inspection, reproduced and verified on a QEMU loopback
nvmet-tcp target (7.3.0, KASAN, init_on_alloc=0) with a null_blk
namespace and reservations enabled.

Reproduction: issue a Reservation Report passthru with NUMD=15 (64
bytes) and a 64 KiB host buffer, after a 64 KiB write to dirty the
page allocator. On the unpatched target the returned tail beyond the
64-byte data structure contains stale kernel heap data (kernel
pointers and strings, 30/30 runs). With this patch the same recipe
returns an all-zero tail (15/15 runs).

Regression: register/acquire/report flows return correct data; a
NUMD below the extended structure size still fails with Invalid
Field, and EDS=0 with a 128-bit host identifier still fails with
Host Identifier Inconsistent Format.

Note: with init_on_alloc=1 the page allocator zeroes the SGL pages
and the leak is not observable; the reproduction above disables it.

 drivers/nvme/target/pr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 8c818f24815b..63ea607d4864 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -900,6 +900,9 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
 
 	put_unaligned_le16(num_ctrls, data->regctl);
 	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
+	if (!status && req->transfer_len > num_bytes)
+		status = nvmet_zero_sgl(req, num_bytes,
+					req->transfer_len - num_bytes);
 	kfree(data);
 out:
 	nvmet_req_complete(req, status);
-- 
2.43.7


