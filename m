Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA2C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A88D2312D
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A88D2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9/YS0nT176WF68HzwI9p/mphLX4VwJ6QU4oqXJurtrw=; b=oZTfsEH8JSXitUNcNA53oLy4E
	BMU54NcFIlpFhBxEqJLXkn6tfySQUxT5FowHYj/xTb7N0vGH8G9S7DJVTqA/jWaMmbDGwhaIogfw0
	YvewqUZvLOZzNP7ShZTJepChy/HQRId2DiIqE/g4Auxb5QQc/ZIN1kZ/QgzoaWeX+S4S3ZZ08K+Nu
	VyH6upOwb7e/2bmRWYvANJV1sVU4bbRbmJZz6JEg306cGU7d4i5r8V3rJ72SzH3L0/80B2wtItpwF
	AyS5K876ZbWScbsMhcVyY+ubvRbvQ2kBUJyRihI7XYJI2aM7hG3sGAaTXGAEr3QyNbTWkc/CQaJDm
	ebudnplxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koKI0-0005ol-Oo; Sun, 13 Dec 2020 05:51:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koKHI-0005j9-Jp
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 05:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607838640; x=1639374640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yOc8tZLY9aTLtJqoqcpsKtJ8jkH3U8ob/P06alAcQUU=;
 b=H7U+xC0Q6Lmb2QHz5ll0vonIXfRSEmlhp1zYuK4uyLu7K1NZkbnLbf+f
 T+BjU0rprQaiBar8UG9Ssf7uUlv/xxnTrqs1fPtFLtqeRtVhy8QULKpol
 gi4Gl6qlYeqE33c6lJXb4lfymf9CnfpOvpPgn3JJxs/T8Ww82ZfvKArn1
 lQDQJ6SvgurZAAz3sDooTw9y/K/RsbI3NT751cekEDvKYfO7pQLS3YZ/Q
 Lxln1+x9/zEu9CTUZ4vBlF1hJ96ON7WMEsgAdnY7vbfxL2/wuPBIadg1B
 4SM8iXRzifNf8mh0CHqJNBjxFi3iD4c1MtKwYFLW9iGg8kvjzs28ppk4l g==;
IronPort-SDR: pBDYZ93Fy9mjq6Ojj3g+ylFrFaGqqnO3oDNN5iiS3IAMSy9EDosWEbXf6xRiZKSpQ5q+8vuA0r
 TKev1WDOaluYbXS0c0M0eAZKSyjzgW02bXpnA3T0SJZ/RCX6vCU7YND19jNk5rFmMD3whQIEek
 E8tFD5y1eBUyG58zejfrE0+lC6ju5CpdOQLvRPkuZFtrZVoGkzq05Xy7kk1Wcluy1SnctQlWYg
 90LSKwjmucjxySxBlISrcSlbMLaNf+FqVJ10qd/Rx50UckU5hbKpmjDwTYq2oG394YC5aZ55e0
 F9o=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; d="scan'208";a="155013127"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:50:38 +0800
IronPort-SDR: s70t4bl884X/7L2aERfT3ymKI/dttlQtviCOwJvXEOsEHfWrckQ6rafoQ4rR0DO6XmBHMk2lzD
 7Zb1OtS8v/W/O2jOz3T3RdFHygI7zJE+KzIjr3HbINxOuDaEPOy+Lnn2w0K9yLcJWhFKcvqwIC
 yThWZLmlFzbgjwOByaeQalrOKFBPy640OfxYQkcjiI5McH44ji+fmEfQia/pawBviQRdvRu48k
 nEncGh8wrbVv8DPzdHg/TwvClHPW8sqb8JI/9rn4S0iex/59V5enSUMFIUqZb1iBduhZxrOZR+
 7cfBoVy+94SVh/jrY7RNqzZa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 21:34:27 -0800
IronPort-SDR: Rq29Z41v6bhT35mkqiAaWLroxMzffXCIvBTBplW7hOo6BhlFdgz7wfw9pUWdkPUTc2MckfGmkq
 m/dR0pek1JebsG0jZk0X6+Hx7WgJT65J7jweF8mwZGAbHlGG2uI3eYTBDAqDvzlmBSnFFJClCU
 fP5v5WVPhPAwDSQDMfZS5Kk5AGBGqm+CsfgZGTFLrH60xbC8YJxar08aPaS0fyy1dI0TfDZec7
 PPYIeWq2UliJ3u48O1934O5pY0a1SbxET7irQNB3VKNuwHmyrkQ0k8CP4E8PGPmJK0sr6SStXR
 Cbc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V6 2/6] nvmet: add lba to sect conversion helpers
Date: Sat, 12 Dec 2020 21:50:13 -0800
Message-Id: <20201213055017.7141-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_005040_780062_865CD9FF 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In this preparation patch we add helpers to convert lbas to sectors and
sectors to lba. This is needed to eliminate code duplication in the ZBD
backend.

Use these helpers in the block device backennd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
