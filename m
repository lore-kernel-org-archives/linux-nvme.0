Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66881C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uKOVHziYsiU1y+MgVuXiBUXHStQJ8opX9xrQUMAXIJw=; b=DMw+Q4SSM55Zhh07NqYOZ8VCY6
	YfNfOOHYZz0fVgrszCx+OMVXJIGNSqEmUyVhvSBZtrb2BplfIkpaVC3Xh7SbFJY/ap+W2HXeSudb1
	nRfVqywqjgD27Jr+iK4HifCdRlvb5YSZjrrb1frFwe8E11F59CVY0HtdaIsmbuX/cGzEPnwPyYcjj
	XAmPuE5hcyuTyBabc4mQmV0iRP/f7ITxxokEfBxoaeutWiH2Xu3g+hc3WCXH9d/FdeQsBUQYEvnCk
	t8HSwzRf/5AVhx1QpBtfHQV8FFsx7ROf5JtH9Iwko1kakiItl2aFahTCaUu+YyEuef0CXSdx+35qn
	GB2Tseuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYGa-007s7b-59; Mon, 01 Aug 2022 16:27:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYGM-007rzC-TT
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 16:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659371239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uKOVHziYsiU1y+MgVuXiBUXHStQJ8opX9xrQUMAXIJw=;
	b=C98jFrX4pKlVdE7BxOtAN6y048vQOZKKd/rVLV/e6b4xnyqDiQzD9KVxpARSW/2yZEZZgF
	f4iIsjCYVsqCphxyWxnxSrScdjatEC51/BG92jAULFhMfhSfOok7w/2hb02KlwzB3g5eAt
	HL/ShMeElVz/AQw/IWhGaDYN6MwS3TA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-d5Vbs5rFPZGodkSsEFNFVw-1; Mon, 01 Aug 2022 12:27:14 -0400
X-MC-Unique: d5Vbs5rFPZGodkSsEFNFVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F8228032F6;
	Mon,  1 Aug 2022 16:27:14 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16A812166B26;
	Mon,  1 Aug 2022 16:27:14 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	muneendra.kumar@broadcom.com,
	james.smart@broadcom.com,
	stable@vger.kernel.org
Subject: [PATCH] Revert "nvme-fc: fold t fc_update_appid into fc_appid_store"
Date: Mon,  1 Aug 2022 12:27:13 -0400
Message-Id: <20220801162713.17324-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_092727_078735_24BB49A1 
X-CRM114-Status: GOOD (  15.27  )
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

This reverts commit c814153c83a892dfd42026eaa661ae2c1f298792.

The commit c814153c83a8 "nvme-fc: fold t fc_update_appid into fc_appid_store"
changed the userspace interface, because the code that decrements "count"
to remove a trailing '\n' in the parsing results in the decremented value being
incorrectly be returned from the sysfs write.  Fix this by revering the commit.

Cc: stable@vger.kernel.org
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/fc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9987797620b6..27f6dfad5d3b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3873,10 +3873,12 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
 }
 
 /*
- * Parse and update the appid in the blkcg associated with the cgroupid.
+ * fc_update_appid: Parse and update the appid in the blkcg associated with
+ * cgroupid.
+ * @buf: buf contains both cgrpid and appid info
+ * @count: size of the buffer
  */
-static ssize_t fc_appid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static int fc_update_appid(const char *buf, size_t count)
 {
 	u64 cgrp_id;
 	int appid_len = 0;
@@ -3904,6 +3906,17 @@ static ssize_t fc_appid_store(struct device *dev,
 		return ret;
 	return count;
 }
+
+static ssize_t fc_appid_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret  = 0;
+
+	ret = fc_update_appid(buf, count);
+	if (ret < 0)
+		return -EINVAL;
+	return count;
+}
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 #endif /* CONFIG_BLK_CGROUP_FC_APPID */
 
-- 
2.20.1


