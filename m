Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047AEC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AD261166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AD261166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfjVv1xbKFl0rxlVCRxMujzq6JqXgx+PTyuyuUzMn9o=; b=jA7fnC+4aPwFfjYkqty6nSuWZX
	rYbeOcHa7i/Gld3fh5S7MeAhsXz9JJfoThHOPiwn68mj+WN3g+C44J+H6dlM8CJRom5/mtgnOeQXI
	YeFiPSJmj6biEHr6NOSPTtAUz1BdkhjkMGZs52pu1kyS4xQ3Fa+9THbP3W05eNI8Oct3zBNj5KqBU
	GLkru+oNgl27QzBInpRevnAA52ZXD+h6e9qCqBK6Ig+J3O1By3JYftRpqEwbqygYwQ/U68DNJ6ewp
	nhSc28qYzdS80yF6gLLLj7tCe66GdfHrvl41StwO3Hgh845+JjfVDx2tr98WQiyJuzIs6zvPTGNHs
	SN7ke3Wg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXWc9-003XDM-GE; Fri, 16 Apr 2021 22:07:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbu-003XBB-Ry
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 22:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=; b=UVvgB+PIsOIYoHby8fiVwzqH5o
 i1VzRgRlAzIJ75Vp2fOYHXhAE9UaL2YNH3K90RHLI21y9Va2tfuVT0S5uRWy+BpyP6BeI88xRWuSZ
 3eZCdEsY8bmNLkmAsDw6xpWheV2dhM1Xq+4snqhcSBxxglPPZIX44ntMYAbE6ie3yfw3ZRDfm0Vds
 6kVTOu6dZYTUZhzqW1f9Pj4e/OD+00g6ir4tlOA4OcmFLZXZw7ZWsvQAYVWd/fIPsOoCFmDu6L4Hn
 d2z+28WvyAzI87I5x+MBaauryFzijNML16f7LonYvjGKi9NYJhhPm7RGq3HDlPQVVXZrqba2oTMYp
 PWt4A/vQ==;
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbp-009jjf-Be
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 22:06:45 +0000
Received: by mail-qk1-x72c.google.com with SMTP id s5so21697407qkj.5
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
 b=LgIcZlSDZxZaNxg+glWRfcMpcC9dR6quQulhPwYdpCRhwy+iqE6s3gcU3jlWt7L12D
 1kiwiB3lXhdhOdnWcADpTiOKxv7IiiVuIZyeyE6YvWgNlq/JEVIo1HRefy1w8zWA5ceB
 1mb/pNNjloYkz2+1x6BtCxttrywhEZqAOdcbl7BlZ95td7M+BtvNNysjGrgqymGFiaDB
 HUTtTF2bH+D/azHxQmu6aZvhzBR/5AK2Xno7qgC/0siHsVU1gDLhkeLD91LTWf9lyGOX
 reEfb+qSTwZnOIM0+XYF2A1AnNvbtmNaOn8m9oZ5dh2PhEZriCaBe7dFKzC9bhZt/nLh
 rjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
 b=eAoEnwFiJt5ETbnk6nbi+7KdK535PQTt0WiTdig1Wou7Qq0TGZgmWmgJ5kChQ54VPQ
 +Pf5eADr9GDyem23JYhpmPPN7pwvX9RnbkMqY24xGdPOkI9AhOZy0y50Ug5HR0Z/N495
 g/NGVX4v6+uconR+dOySQztx1g55OuViZI9+vSEuZWx5Fep3NWgFEfOq7WOdHqBaqVwc
 x4Y7xGAumY0H7V24DcKT0np8SuuT9tEsT7MkA7bDYSDKJN8M7HIHa5C47ECX4oCqQqYX
 XhQ6Xzj9cv31I8WYwajq7ReyutQR9PfxF83KIqO2YFzQFiBTEaYPKBuHcG1p/wQX8aWJ
 +KNg==
X-Gm-Message-State: AOAM532lQ/8tNhbHSepYtReBEeWppj+VkIf+Wh+drXTTQXCz+7rf/3ux
 LPhFgQclD+uk1sePIJcJ4w0=
X-Google-Smtp-Source: ABdhPJw7ppGOCSahVk+duKk+ADJkHO9EgUt1Epe+BpmeIZB5SJVOeurj1Lrnnmi1p9nftS5OkFYZjg==
X-Received: by 2002:a05:620a:1112:: with SMTP id
 o18mr1476969qkk.52.1618610800275; 
 Fri, 16 Apr 2021 15:06:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id x4sm4972979qkp.78.2021.04.16.15.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 15:06:39 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date: Fri, 16 Apr 2021 18:06:34 -0400
Message-Id: <20210416220637.41111-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_150641_419905_EA326229 
X-CRM114-Status: GOOD (  18.10  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the DNR bit is set we should not retry the command.

We care about the retryable vs not retryable distinction at the block
layer so propagate the equivalent of the DNR bit by introducing
BLK_STS_DO_NOT_RETRY. Update blk_path_error() to _not_ retry if it
is set.

This change runs with the suggestion made here:
https://lore.kernel.org/linux-nvme/20190813170144.GA10269@lst.de/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  | 3 +++
 include/linux/blk_types.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..540d6fd8ffef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
+	if (unlikely(status & NVME_SC_DNR))
+		return BLK_STS_DO_NOT_RETRY;
+
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..1ca724948c56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -142,6 +142,13 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
 
+/*
+ * BLK_STS_DO_NOT_RETRY is returned from the driver in the completion path
+ * if the device returns a status indicating that if the same command is
+ * re-submitted it is expected to fail.
+ */
+#define BLK_STS_DO_NOT_RETRY	((__force blk_status_t)17)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
@@ -157,6 +164,7 @@ typedef u8 __bitwise blk_status_t;
 static inline bool blk_path_error(blk_status_t error)
 {
 	switch (error) {
+	case BLK_STS_DO_NOT_RETRY:
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
