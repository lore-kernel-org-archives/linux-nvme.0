Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E12C531C9
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNlCqWN9rYlM7R3wxguszrDK0t4TEHNES9xZZYsPYhg=; b=NF/Sge1sb58WUZa6nfJdw0LFpo
	V66H96mtt9J7WL/Zafs3bjD3eOLWBv1+saC/VZX9I1F/VXS/KPE4v3iSwOhLjA2n1p68rYOPjmy4k
	KCTlTjYmvxGuAeOXHs7zxY8Kg567DXgrDSe+wD7Sd1jNG++K+SjUsh8LO1essYPzafcrZP8rYU+US
	tagfVORemWMF5greoQsq8x+I1jWME9DrCsQkE5S4dsMonFqVusBcFLfLPLbj2xTWb4Y5eGD02wb9m
	7+qrl7sYbfM+d4VPVQNNOy3m5pkBAZ4dKRE5N4/ZckMBX0e01b6YpaO/yyaHMRqTHm06+Ee7hXwds
	APkBkFzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncmk-00000000PWE-2lpk;
	Sat, 25 Jul 2026 13:51:26 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncmi-00000000PUt-0w68
	for linux-nvme@lists.infradead.org;
	Sat, 25 Jul 2026 13:51:25 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so1841798a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2026 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784987482; x=1785592282; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BNlCqWN9rYlM7R3wxguszrDK0t4TEHNES9xZZYsPYhg=;
        b=lA2tP+5oYaDdczzl3N1U5PoVBkj+db8DPYnRsa1PFz9+Iq7yGb0T3rC9ukKLlqN4wR
         Wyh8L5fvdUEPS10h4qLXn0VEoFzlemwH2Z3TiTZUKiLG94ng2PiKI4DXFVOfnuQifz+b
         86ThOQPPpj84aY0OwJ0UJy/1FPY9nU4L2Ap8Rkt/FDq2aU9doZsTipEZeFIkZiva0sHw
         t1ce+EKk5t09TcBSqG+Dct8kOS9wadwFdVDPVa5pvanfDuqpIMRXHq7LE87bOqwAJ0ch
         yv+7EN6Ncc73WqXKkw1qk352xzowveQT+HBXOpE40UJb5vrTRBIgPH0X3NrzIhLFzWNY
         kVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987482; x=1785592282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNlCqWN9rYlM7R3wxguszrDK0t4TEHNES9xZZYsPYhg=;
        b=HrS9Hjr3JJxVsWDs4E3sjiaBOrOxFjT0cd5EfNyqlBH2ACLY46BOKg5dzIFM9ZPF0R
         Wxc7YaNXcAAORQQ7fQUm87yBDOvzPEvvPV8UZkkNsE6w1qYoomtdFk+xReJWqjBrEkb8
         9f1aH4qwdpYqiGEx6bS/xdv4/vRqXuN33iFddCll1cPPr0/qpjm887BZvrCeaB5Xgxco
         LHETaqMQkNzn5BGdAdK+JpNrFYDaC0J7OT5txh9ZaAvOeQdZmnCVlcT6n3u3LsxFD89l
         roL55VEMbhwpBL7Y1Jb6LZhZgBPJ3cCSz0iqAsDNhb5gn8//7+VxoGOnd7z3YwBYfT1R
         i47Q==
X-Forwarded-Encrypted: i=1; AHgh+RrcJ640xNxvZjcO9rG4y5o1vv495Ce5IIzBcNH0RTDKAC1dhIwDIeRmiEhuvm/zx5wMQt0GF/bjATq4@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/cEual2p21pGI3hnIjjDL5qzy0uiAncLrnytfTww03XtMJ1vz
	VElggZzZsNPad2UIyz+0ORnvEJyCafUGr7HRBsppDoib7eU3orODEBK/
X-Gm-Gg: AR+sD10TWmfCESD8CBt5/hltYtfoiupFwk4EskOtjLZVvR0k4EGSFSJr+dBdn256Kpm
	G61w4bmPgUf+vEAd2DuwR2xkWaZWOqKWBRAdj/aqD9+nKMDUPZzw4W/gcjwLMLTom5BhiiSjJlY
	He/UXQ9t3pX1gb2OvVb2IRUzwvQYKXWPNG/gG0sAUk1oE/LGX0W5A2GPijRpZl1l71WFJkiWDb3
	sWrzFJ1UPyn8VFk64JXPjfRJaL3i/mw1cSJmlKIX7k1Zfvi2NSnAnVPTHdm4jb1HiNVy6KwuT1N
	saB6xylZ/u6jszLyscZ+wu5Cq985FaVZ34gdRrnSrAJX6Wd9ju+KI/+2HiW0M/BrYa3UtKHbyPD
	NzBGj4hOs6yHYmDUer5Wq0avKF8FR5Qzxj7KCzn2G3MVud3zYeMUJlonezSjrhlc5UX85LTR4eh
	KzQCDgaZS+FHZM/3K5+HIBGcy/Ho7YBPKH/nZ9F7QAKTLX7NuUSigJILv+f1EoMnU=
X-Received: by 2002:a05:6402:360f:b0:69f:aca0:3b9f with SMTP id 4fb4d7f45d1cf-69fc1009d18mr832970a12.15.1784987482213;
        Sat, 25 Jul 2026 06:51:22 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-7475-eec2-a79e-2db.fixed6.kpn.net. [2a02:a463:a071:0:7475:eec2:a79e:2db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543aacsm836431a12.14.2026.07.25.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:51:20 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
Date: Sat, 25 Jul 2026 15:51:10 +0200
Message-ID: <20260725135111.14041-2-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725135111.14041-1-harimishal1@gmail.com>
References: <20260725135111.14041-1-harimishal1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260725_065124_288261_1BCBB30E 
X-CRM114-Status: GOOD (  25.65  )
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

nvme_query_fdp_info() populates head->nr_plids and head->plids the first
time a namespace's FDP configuration is registered, guarded only by a
check-then-act "if (head->nr_plids) return 0" with no locking. Since a
namespace's nvme_ns_head can be shared across multiple nvme_ns paths,
two controller paths scanning the same namespace at the same time can
race to populate this pair concurrently:

 - Two unsynchronized writers can each set nr_plids/plids
   independently, so the last writer of each field can differ,
   producing a count that doesn't match the actual size of the
   published array.
 - A concurrent reader in nvme_setup_rw() or
   nvme_update_ns_info_block() can observe a non-zero nr_plids
   while plids is still NULL, or sized for a different count,
   leading to a NULL dereference or an out-of-bounds read of
   ns->head->plids[].

Add a spinlock to nvme_ns_head and take it around every access to
nr_plids/plids, both the writer in nvme_query_fdp_info() and the
readers, so the pair is always observed and updated as a single
consistent unit. Use scoped_guard() so the lock covers the entire
read-and-use in both readers rather than being released before the
values are actually used.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/nvme/host/core.c | 63 ++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..bdc5f07f5bf0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1018,15 +1018,19 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
-	if (op == nvme_cmd_write && ns->head->nr_plids) {
-		u16 write_stream = req->bio->bi_write_stream;
-
-		if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
-			return BLK_STS_INVAL;
-
-		if (write_stream) {
-			dsmgmt |= ns->head->plids[write_stream - 1] << 16;
-			control |= NVME_RW_DTYPE_DPLCMT;
+	if (op == nvme_cmd_write) {
+		scoped_guard(spinlock, &ns->head->fdp_lock) {
+			u16 write_stream = req->bio->bi_write_stream;
+
+			if (ns->head->nr_plids) {
+				if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
+					return BLK_STS_INVAL;
+
+				if (write_stream) {
+					dsmgmt |= ns->head->plids[write_stream - 1] << 16;
+					control |= NVME_RW_DTYPE_DPLCMT;
+				}
+			}
 		}
 	}
 
@@ -2317,6 +2321,8 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	struct nvme_fdp_ruh_status *ruhs;
 	struct nvme_fdp_config fdp;
 	struct nvme_command c = {};
+	u16 nr_plids;
+	u16 *plids;
 	size_t size;
 	int i, ret;
 
@@ -2325,8 +2331,10 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	 * so return immediately if we've already registered this namespace's
 	 * streams.
 	 */
-	if (head->nr_plids)
-		return 0;
+	scoped_guard(spinlock, &head->fdp_lock) {
+		if (head->nr_plids)
+			return 0;
+	}
 
 	ret = nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
 				&fdp);
@@ -2357,23 +2365,34 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		goto free;
 	}
 
-	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
-	if (!head->nr_plids)
+	nr_plids = le16_to_cpu(ruhs->nruhsd);
+	if (!nr_plids)
 		goto free;
 
-	head->plids = kcalloc(head->nr_plids, sizeof(*head->plids),
-			      GFP_KERNEL);
-	if (!head->plids) {
+	plids = kcalloc(nr_plids, sizeof(*plids), GFP_KERNEL);
+	if (!plids) {
 		dev_warn(ctrl->device,
 			 "failed to allocate %u FDP placement IDs\n",
-			 head->nr_plids);
-		head->nr_plids = 0;
+			 nr_plids);
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	for (i = 0; i < head->nr_plids; i++)
-		head->plids[i] = le16_to_cpu(ruhs->ruhsd[i].pid);
+	for (i = 0; i < nr_plids; i++)
+		plids[i] = le16_to_cpu(ruhs->ruhsd[i].pid);
+
+	/*
+	 * Publish the fully-populated array; if another path already won
+	 * the race, drop our redundant copy.
+	 */
+	scoped_guard(spinlock, &head->fdp_lock) {
+		if (head->nr_plids) {
+			kfree(plids);
+			goto free;
+		}
+		head->plids = plids;
+		head->nr_plids = nr_plids;
+	}
 free:
 	kfree(ruhs);
 	return ret;
@@ -2468,7 +2487,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
-	lim.max_write_streams = ns->head->nr_plids;
+	scoped_guard(spinlock, &ns->head->fdp_lock)
+		lim.max_write_streams = ns->head->nr_plids;
 	if (lim.max_write_streams)
 		lim.write_stream_granularity = min(info->runs, U32_MAX);
 	else
@@ -3991,6 +4011,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ids = info->ids;
 	head->shared = info->is_shared;
 	head->rotational = info->is_rotational;
+	spin_lock_init(&head->fdp_lock);
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..22a68e09b065 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -560,6 +560,7 @@ struct nvme_ns_head {
 
 	u16			nr_plids;
 	u16			*plids;
+	spinlock_t		fdp_lock;	/* protects nr_plids and plids */
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.43.0


