Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C66CD98CE
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2026 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PJU0H19oVBOoGpAxF82MIlReI1ckqan9KS5n6LAXZDA=; b=P8blkepq4bwclzv3dzLlGiPKgv
	5VW+bnLYm5FyqNaSDY9u3lXD6wzlhqP+6RMeWNNOannJ3Es7dJ1D4DSr4P7o8INIt6BdD4/z+8bFk
	fX2jqSJV+jEUNnoQ2JJQBc6lqItYMSnEY2xJiJRLGubPtc2wgAYJSrVSdlXZPU7fcAngCUMiCpmYb
	lbDKI3RODtOyx99MWTXqagmhG4mSJYDZvd5CEFdHXyNrg9oQXgPdxjmwQmmq/n/ES+Ta2zkH1PiBm
	dJ4QiDuqaynDZsK3usMjQmN+kGbiZO+IgNdwyecuY59CMTIovZVmQtp4zehh65jec2K8Yi/4ekG11
	CCf9wwZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXyNP-0000000Agnt-1U8i;
	Fri, 12 Jun 2026 09:40:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXyNO-0000000Agnn-1YEL
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jun 2026 09:40:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 709466001D;
	Fri, 12 Jun 2026 09:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 188C9C2BCB4;
	Fri, 12 Jun 2026 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781257233;
	bh=dvvJGP8seoXJbEB71BwDcA4pq9Th3sDnGpORJL37W/Y=;
	h=From:Date:Subject:To:Cc:From;
	b=ULqaJ8fUzhj4HVRdD64HPGpbmXE0K/UXbeWVe1pOqxBnR3CjEyNuplpV3rZyYsXiu
	 MsNCYN4Ep2YttrN9u2hj0+ZTkgoAuiNrI70/bixFJ33agDhDbPZ3fGsZm3sSlDlUyI
	 xTttBtY6bOJDEz/dbbWHDdB9kNOh+pEfBvwA9U/2ENNguzuKq5YDAiWGLJ1lqUk9xg
	 B3UL3X3gNO575Izv7Vq2kJl/JvBt+yVMc75qjWGZC0kS9zw6+hxwtIO8loa4v21F3E
	 csc3HXuDsAyP84pohNJkmkDYzyB0UFpHohVS4FINi9OfNHQ8Jy7Q0LMEnrq/t27iwE
	 g3lKUIqoiz/YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00085CD98CE;
	Fri, 12 Jun 2026 09:40:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 12 Jun 2026 11:40:23 +0200
Subject: [PATCH] nvme: unmap the data buffer when metadata mapping fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-jag-fixes-v1-1-24423dc8afdb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAbUK2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mj3azEdN20zIrUYl2zJBNTy9REQ7MUU2MloPqColSwBFB5dGxtLQA
 lPQ6SWwAAAA==
X-Change-ID: 20260612-jag-fixes-6b459ea16d53
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Gomez <da.gomez@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=dvvJGP8seoXJbEB71BwDcA4pq9Th3sDnGpORJL37W/Y=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGor1A9zkZhR0quHNS7DbnQa0qQrZeirRUPDJ
 WfxBHF28lrPUokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqK9QPAAoJELqXzVK3
 lkFP0ocMAIDSLx7nSaxQ7ggaIDFrId2MZPWz9f1Rw6YK1Vj1JiUN264k04uTf2mRv21tas1tQtX
 9+CXnCc4F8USqxZyfeZ32om1CDVOpzr5vuDtIiE/bPl+uhxTvysgMpzOVEAl9Z+JzmvpSClrOct
 StKUznKNkQOKPFoWh7Cx0/ZdI68xILH9k6k1SE7XkaP0Z7MAqxhRXjyfcKE79z7Se8LTNqNfNgf
 L6LJp9FnTBcfC9Pnjjuwfr19lXKNNi7ynWQlzF9lsbqEpqk+r5rXbvBAhXB6YfrczfiuaGoaRSO
 n52pY3PYFWIJtKNIzN+VJixbHJ8gAy+aKa7XiwMaSch37xE1kOSHO7S3+om9bxceXBHnah8pJCE
 KIUJ0zXwweFDIrtJ+u7Ym86EZ6JmO9J207BKWr+etachqxg7x38WxLU8lfSAMSCHyjbzFNV41Y+
 wNBlR+pALmcjIwQmHpwYlNvOaBw6aV8Mt1wh/t+CQCijwfrKuqbUkS/RNeTvHskzKBhGME+DvC5
 +Q=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Commit d0d1d522316e ("blk-map: provide the bdev to bio if one exists")
dropped the "bio = req->bio" assignment in nvme_map_user_request(), but
left the local bio variable initialized to NULL and still used it in the
out_unmap error path.  The "if (bio)" test is therefore always false, so
a failure of blk_rq_integrity_map_user() no longer unmaps the already
mapped data buffer.  The callers only call blk_mq_free_request(), which
does not unmap user pages, leaking the bio and its pinned user pages.

Use req->bio directly to unmap the data buffer on the error path, and
drop the now unused local variable.

Fixes: d0d1d522316e ("blk-map: provide the bdev to bio if one exists")

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Did we forget to unmap?
---
 drivers/nvme/host/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9597a87cf05dc32a7eb0373485f575502c32a105..9ae3c0aadfb8f35790c8e57619d1af69ca41af0c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -122,7 +122,6 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	bool has_metadata = meta_buffer && meta_len;
-	struct bio *bio = NULL;
 	int ret;
 
 	if (!nvme_ctrl_sgl_supported(ctrl))
@@ -154,8 +153,8 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	return ret;
 
 out_unmap:
-	if (bio)
-		blk_rq_unmap_user(bio);
+	if (req->bio)
+		blk_rq_unmap_user(req->bio);
 	return ret;
 }
 

---
base-commit: adeac771f4901bb66267eaddb9fcc538925f92a4
change-id: 20260612-jag-fixes-6b459ea16d53

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



