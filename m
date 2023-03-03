Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021C1C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Mar 2023 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z5vCHFhYPeAkT+c1PkPwMKEFL4FjgQ8idohZ/LdWkTU=; b=abIXZEG+lSCinZ+Iqp/uV4FvM1
	cG0wNH/HDI7evLtJi55ngnDyyZSKa/5aogFvVmNj2oxDqKdYyvUOaP7uzPq5IoWpZ1XUnvkbavS2V
	VWkAF4NRze32GdgKTT1XK05VmYk3blfAbGq2jL5eijz/RPRPi3vC+fmCD0azT6ai91vyyHN7TcIzg
	EqTXg+sVlRp7LENGqzTeckVosE8Z2LurnO3fA1tENsS1XY69CIhGAeJ8qw8QmsNMwGi2bIbCvfpGq
	GFJcjErYTDElU1jUmkn+lvoXml6sPlikmJ1n7IpcPgJpwNhNfBNHd7MEc8sCKeS05HD2BZLZTH5cR
	d8fFquKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYEbH-007n2n-7a; Fri, 03 Mar 2023 23:14:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYEbB-007n0f-CE
	for linux-nvme@lists.infradead.org; Fri, 03 Mar 2023 23:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677885238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z5vCHFhYPeAkT+c1PkPwMKEFL4FjgQ8idohZ/LdWkTU=;
	b=P4uc1Hkc+0VG+WKAA1+UP7V+OBj7qaxzrroWmv7NPus3oi/KQeXqtQz0iKK4MY0peRCfnL
	x0jn34Xf7nUgprGvgZRgyL8gmFMTsrtKo1H+TJRZAA0NaXWSI06CRewnSbiXAyIzocpUWm
	eRP8RVSOANFjxng4RfX3r6rjdeI0Pvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-Y2rkx_arNcaQBf8pxk-ikw-1; Fri, 03 Mar 2023 18:13:54 -0500
X-MC-Unique: Y2rkx_arNcaQBf8pxk-ikw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3CE80D0F0;
	Fri,  3 Mar 2023 23:13:54 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 602C32166B26;
	Fri,  3 Mar 2023 23:13:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] nvme: fix handling single range discard request
Date: Sat,  4 Mar 2023 07:13:45 +0800
Message-Id: <20230303231345.119652-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_151401_527939_344AAA7F 
X-CRM114-Status: GOOD (  12.42  )
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

When investigating one customer report on warning in nvme_setup_discard,
we observed the controller(nvme/tcp) actually exposes
queue_max_discard_segments(req->q) == 1.

Obviously the current code can't handle this situation, since contiguity
merge like normal RW request is taken.

Fix the issue by building range from request sector/nr_sectors directly.

Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc6..d4be525f8100 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		range = page_address(ns->ctrl->discard_page);
 	}
 
-	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
-
-		if (n < segments) {
-			range[n].cattr = cpu_to_le32(0);
-			range[n].nlb = cpu_to_le32(nlb);
-			range[n].slba = cpu_to_le64(slba);
+	if (queue_max_discard_segments(req->q) == 1) {
+		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
+		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
+
+		range[0].cattr = cpu_to_le32(0);
+		range[0].nlb = cpu_to_le32(nlb);
+		range[0].slba = cpu_to_le64(slba);
+		n = 1;
+	} else {
+		__rq_for_each_bio(bio, req) {
+			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+
+			if (n < segments) {
+				range[n].cattr = cpu_to_le32(0);
+				range[n].nlb = cpu_to_le32(nlb);
+				range[n].slba = cpu_to_le64(slba);
+			}
+			n++;
 		}
-		n++;
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-- 
2.39.2


