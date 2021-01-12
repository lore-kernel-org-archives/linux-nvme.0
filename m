Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8923C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB4723117
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB4723117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PfbOaMSvbbjp2ZqN4ihRAEFa9O0Lpq0YlguDpKsM+Bk=; b=heFNimNTLqSv4KaMH+roGYkO8
	WEwc0Y2/1+B/4rwjp1DWA0pi1MHfN6NUfajdiR3VXoqqAD8ae+H76Zs/qD8KHLsEbaLKbjf1Fvae5
	sz/8H1Wzni/LOybBdrzma5SDYSD/6qKfnMCx6LRCfvVfScFJQgYP9ho4f8w+iL9JV0spcn5FsmxxX
	enGc4q78JU/gQmbol0Z7WZ3O5H+/q6IZvGepu5u8uHHOUWULSLrnDEf9OXTKy4jFvyIb3k8Rf1Ij1
	4Gekomu4cencYJK1EBg3O3ieEw04gAMCOwMfuvLzQ50bp+mg4hJaVt5JiQsHwy+SjzTzljZqF4jNh
	4EKNoc8Bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzQzs-00054u-So; Tue, 12 Jan 2021 21:14:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzQzn-00051Y-5a
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610486071; x=1642022071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hp67gzrm5MZjnu6FHhnVqwkw5yYlP6S4XEYsRtwasWg=;
 b=RiAJse61UzqP/RhMLtst2ZrdawU8HU34GEvFjxSeH2iqQeJ2gSif8kGC
 AdbEodf5zpfKTjtfc47qo/scKvH56i45fHy4xnVfPYdVKnex+0W3GyTG7
 QzJ1kepbesqZObKi8LTdHpoDhJBsNVgNKaBrG7S9GVn5nBrH8g7tPjWcX
 zygTdUiKiru1e9FBTE65yTpdEqLp2k/IelYQbJ5TC2S7llTawufLz3HxK
 gTpNoqFbBcAR/Pfrdm7ufZqU/T613SXpjAr1t2LGIsx8bJhLYLJ+R3AfL
 4zKjU+E7n+RTOEJ+t2v51+xyzqRHHrAawxhQJg/nmNArzJ/HpGlDeZso/ g==;
IronPort-SDR: fJ8BW0gfnVaa6kfHyM2DqlWrJMaX0XSeNmLnSSBvpjRRkX6cgH+xt/7Vdyrc9V05JValXWUmQ9
 REc8Wgu21ys0xAGwZswUVLvxES3t5W/WwcAQKpuNZQJTb+XHMGkw1WSgaTu+WtcPlt3a9E7e8f
 msRnqMUpDrP6E/OgtqqICgS7qjVqGAhYV1Q2AfRqBcuCJK6yM+LDanF/v2tY5MI3BrjZgtl29F
 yu0nKNTvrR3/6EroraEphbNI1n0CtKxKHKMvb598K2yR/3YkZRwIzFaigOvboj+lB3FBgIAWKO
 Qwg=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; d="scan'208";a="161715712"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 05:14:29 +0800
IronPort-SDR: gcxMik9brXycbIXouFwJUzIdfcgcLIv/ku9zjlnD+ADqQUE2+l/cjASUIfebWGNnWxvVm6iAjg
 M88cgp+dj3Rp+Lhb8nlwp1oRMoX1Mo3QhXe1I74cZSpRe/1OZfnMXvtaeoB3LyGiEskkoGNPM3
 cK/Zg5MWSLL/KuWMctmDXh0QY9EophY0eMJ4NAIVDMVzqjNUuGNKErOmFbT7QlPGaa74n5bGUe
 jGSttdBz4iHBkeoisvAGX+ugGehKNS8+vHLHYY5j58RxDof6nGHPl0m7664ECBrHW46iHEL11g
 orTkreOS95tfj/QJX0yR4UvK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 12:57:22 -0800
IronPort-SDR: eXrooKYu0S2M35+Q1e4aU+hShchiiAby58XxH/PPYKYTbUOjB19Oz900REJ7s2IRSxElI7yCKi
 60XV6KzU/BZ/fXCCPoVmDuOJW2FsEuN/mcC/i7mTBvLaTMVrR2ZoEkRLTqcrMlWiBL1QmRUwyg
 3FB9w3sBWhI6AvrkgXrfGifsXT40hgB6iiGFMX2YjH/OepL8G/lHsUvqJeC3Wz1AD18r4ZadtY
 Hk4gfzHM23byD4SKe1G9oO3OD6NEXf8GsGkRMoOU+QMalfe9AbiWKgmIq4Sej5sUtbeagomAxV
 fXM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2021 13:14:30 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [V3 2/4] nvmet: remove extra variable in smart log nsid
Date: Tue, 12 Jan 2021 13:14:08 -0800
Message-Id: <20210112211410.24742-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_161431_479074_13C131F5 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We remove the extra local variable struct nvmet_ns in
nvmet_get_smart_log_nsid() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9bf1fd6933cc..d6713139708a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -74,11 +74,11 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	struct nvmet_ns *ns;
 	u64 host_reads, host_writes, data_units_read, data_units_written;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl,
+				       req->cmd->get_log_page.nsid);
+	if (!req->ns) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
@@ -86,23 +86,21 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	}
 
 	/* we don't have the right data for file backed ns */
-	if (!ns->bdev)
+	if (!req->ns->bdev)
 		goto out;
 
-	host_reads = part_stat_read(ns->bdev, ios[READ]);
+	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
 	data_units_read =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[READ]), 1000);
-	host_writes = part_stat_read(ns->bdev, ios[WRITE]);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
+	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
 	data_units_written =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[WRITE]), 1000);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
 out:
-	nvmet_put_namespace(ns);
-
 	return NVME_SC_SUCCESS;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
