Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F27C49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC4B2089F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kysJnVbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC4B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=09hb9wGomsI0sbU3VW3nhb7jwAFf2jYCh3b1pfKzchs=; b=kysJnVbgKduG8Xc5Hr0+w5YX8Z
	b8Ivhu7KHXULWfzF+iZnVVXrJqjGuL3N5pdmnD5RArkEQ2QDZ99EBndZmRLo+fhepjXpytiuOn4Jz
	6fwtsUr8vg0fb0vU5ougdMnO7Vql4Zp+0ne4pwA/yaum3sBIwylL/kKCOYsRUB2WOXwJS4xSTQyA7
	N82gsoQAoq2DXQ2xlFYraLvhR+7OjTnQFTdXCvMZ+ERDF7RqFmKKIL32V+LUjO0P7CJ6A/aJIidL+
	8YyO8K1nsMza/yDSfrGGz/RyujZ951CKz7eJ+zP5nkQG4O3VQVd6Kjwek2sXhUae09h5CAPv3NSrm
	IJ/0pKsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8jZD-0005Y0-Pe; Fri, 13 Sep 2019 11:16:44 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8jYq-0005Ow-9C
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 11:16:21 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Sep 2019 04:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; d="scan'208";a="336865389"
Received: from rbaldyga-mobl2.ger.corp.intel.com (HELO vm.ger.corp.intel.com)
 ([10.249.130.185])
 by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 04:16:15 -0700
From: Robert Baldyga <robert.baldyga@intel.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme: add API for sending admin commands by bdev
Date: Fri, 13 Sep 2019 13:16:09 +0200
Message-Id: <20190913111610.9958-2-robert.baldyga@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913111610.9958-1-robert.baldyga@intel.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_041620_539791_E1A1E00C 
X-CRM114-Status: GOOD (  13.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: michal.rakowski@intel.com, Robert Baldyga <robert.baldyga@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michal Rakowski <michal.rakowski@intel.com>

Add kernel API function for sending nvme admin commands.

Signed-off-by: Michal Rakowski <michal.rakowski@intel.com>
Signed-off-by: Robert Baldyga <robert.baldyga@intel.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/nvme.h     |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd6903..06f917f391c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -812,6 +812,29 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
+		struct nvme_command *c, void *buffer, unsigned int bufflen)
+{
+	struct nvme_ns *ns;
+	struct nvme_ctrl *ctrl;
+	int error;
+
+	if (!bdev && !c)
+		return -EINVAL;
+
+	ns = bdev->bd_disk->private_data;
+	ctrl = ns->ctrl;
+
+	error = nvme_submit_sync_cmd(ctrl->admin_q, c, buffer, bufflen);
+	if (error) {
+		dev_warn(ctrl->device, "Admin command failed (%d)\n", error);
+		return error;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(nvme_submit_admin_cmd_by_bdev);
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..6f26c5654514 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1392,4 +1392,7 @@ struct nvme_completion {
 #define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
+int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
+		struct nvme_command *c, void *buffer, unsigned int bufflen);
+
 #endif /* _LINUX_NVME_H */
-- 
2.17.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
