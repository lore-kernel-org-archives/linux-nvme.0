Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4601D216A2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Rn/S75aztWbJt/H4N5UJIv0XmOY88cOcp+499zOyeeQ=; b=aeIN2mcLKT/TNk
	MZXwDYIiYYcYi1jajjOA3AwxZaXN0u2g+GFCX+BHmLozSkaaVej0FG5pvctWVkmQUpfOLqkxY3tvF
	SNuwBPtrX8/tPELPw8++UEacxmeJY7bexTGAhiV23S50m9n79z6oR7Y60xZF+/IFQvPD/NROI7wrc
	dRx8nWqFGmmKqMIzdKnNk9kj5LSfsYDQ5wQKZ/0pi8zh7XQ0Y0OuBHgOGN3WlsdyMJUsQ7qVh/95I
	RqxhAyH8xVDwPV55cTyVgyaGePNsO6nNK8fp0NvHHhsk7nKkPyP2h5piahdBkc0jvyGuw584a4efG
	G3oXkeN6dxJ1T0f01paQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0haX-00000008LgA-005x;
	Tue, 15 Oct 2024 13:27:49 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0hZf-00000008LYL-3vEd
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 13:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728998816; x=1760534816;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rn/S75aztWbJt/H4N5UJIv0XmOY88cOcp+499zOyeeQ=;
  b=gohJiB7q+EImeGF4e5BttKKpBRQQhEwts+ozT1EYZPn5GPimRkCHNHOJ
   GCpasPT5f/enZtHUGjoWhAknvMXwH9mlBKZW/33cEHDZnsAvAmaWkveu3
   rVKcUnKq77qbjFcPzm5Bjsemc2sCciZcMYSp8R5kAN6evuCY2KMVCt8Oj
   g=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="431586673"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 13:26:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:55320]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 47c84b81-4899-4a77-8934-fc9402f33562; Tue, 15 Oct 2024 13:26:49 +0000 (UTC)
X-Farcaster-Flow-ID: 47c84b81-4899-4a77-8934-fc9402f33562
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 13:26:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 13:26:49 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 15 Oct 2024 13:26:49 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com [10.15.97.110])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id E9C7DC03E3;
	Tue, 15 Oct 2024 13:26:48 +0000 (UTC)
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 7FE2C20845; Tue, 15 Oct 2024 13:26:48 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<puranjay12@gmail.com>
Subject: [PATCH 5.10] nvme: fix metadata handling in nvme-passthrough
Date: Tue, 15 Oct 2024 13:26:45 +0000
Message-ID: <20241015132645.115399-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_062656_148759_1CED7543 
X-CRM114-Status: GOOD (  14.50  )
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

[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]

On an NVMe namespace that does not support metadata, it is possible to
send an IO command with metadata through io-passthru. This allows issues
like [1] to trigger in the completion code path.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward. It also allows admin commands with metadata
to be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Move the changes from nvme_map_user_request() to nvme_submit_user_cmd()
  to make it work on 5.10 ]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30a642c8f5374..bee55902fe6ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1121,11 +1121,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	bool supports_metadata = disk && blk_get_integrity(disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct request *req;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -1141,7 +1146,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 			goto out;
 		bio = req->bio;
 		bio->bi_disk = disk;
-		if (disk && meta_buffer && meta_len) {
+		if (has_metadata) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
 			if (IS_ERR(meta)) {
-- 
2.40.1


