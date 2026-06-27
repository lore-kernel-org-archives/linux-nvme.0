Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D34C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 06:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXbtz+s99vB1QCMmnC1aR8CIIYeKhTXyxwg1XNiOcIg=; b=3Mn3ytuYW3HkGlJJpok/I1yM2S
	WuEEL1O7rQFf8nMW2CCipYP41IbE6EwkRIJf519x2ktbEBpk1KjELtFNwY2I43SbgLrTYPNbgzEzI
	q9yT3hkmb1auOJ252LsbEgqKo4zha0nNZ0JX9MDiJKrQcmKjx//SCovy1mUG0C63ZCNaDJuN39LDP
	h9HPAnWdKAvaC9qZpag/dR9wQKmXITHmQ/lLUdEM+UgsAIwpnB4cvnD2rt5AbUn+JqL81g0GDL/23
	2NQjxZlk+55O/R62MJU8wGgg+9ZdkLBnMOUskR0hI8epAm3XkHpCRW1JMxleuffM6wzi1Jw/h/Dta
	VRYgfgXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOG-0000000CC4x-1390;
	Sat, 27 Jun 2026 06:19:44 +0000
Received: from mail-vk1-xa65.google.com ([2607:f8b0:4864:20::a65])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOD-0000000CC3W-1ruC
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 06:19:42 +0000
Received: by mail-vk1-xa65.google.com with SMTP id 71dfb90a1353d-59db60df4d4so42491e0c.3
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541179; x=1783145979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXbtz+s99vB1QCMmnC1aR8CIIYeKhTXyxwg1XNiOcIg=;
        b=I+nGPO+1NNkbUfeKaGWvDpSQb9C1biPP52nchI+SMNVF+EjC22rVLvZi61m94mVnPx
         rRnyPdy7LKs0fuKz6RyN9en6rlhn4dPSa3sNmM3Q4hrHdo0VXrbQbMHM7kDb+zqmkKw7
         GCYTXFin5V+ReOJJzYY1LeZ4oasTIcuFpod0C1TVR9aPOZlqDVWhtGpl1aGTaJbrGQ05
         /HqrlY4enYZzndJoU7n+Lrp8kkyiZu3A+eH4P3hEneyB+qgcYrkEo5KxognjxBCRWqZ5
         431tgc/EP0NnrWVpUppOUxXPYlF/PlXg2uGaNp6iT4D54lO6ByQocG6Ds8KI46Ql3XbB
         onLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541179; x=1783145979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXbtz+s99vB1QCMmnC1aR8CIIYeKhTXyxwg1XNiOcIg=;
        b=dQTjzyjMdnhMutC9FRPW9WUtyQn6Ve/XPW9S7b4UUl3bGBsAIVZuw6oa9dPNQYngK5
         yPPDCkkPFVexaagicMkDXVJWhIUOiq5H0kkAZeBBBIQHJ6NTnUPe94VUjV+c14fn5Qi5
         lOB1G+MF1xbDgKZq2LL4rwvHpVTNd/OEAkuo+42/3/6bf2T0pZmV0TD57VNrQoR2wHfL
         n8KZxA5hDyreD1QLdm72tnbPyj4cj4w/RyfsVC8gaWmw12e3GrtcS89jh6Bukr841JWA
         dPXHz8EeCPyGDU4hqsIlbv1Y5hARvFwF/xc+6Y9GHfg88yAKhDKYYfh7LOWduhcZvptJ
         wERw==
X-Forwarded-Encrypted: i=1; AHgh+RpX3kQv7hpUMLfVf57HGsfh0K3yEpasT/6Wr+SNEZauR9URLvZlfLZDqddtss+Zmj1LhCwYPbhZhTnJ@lists.infradead.org
X-Gm-Message-State: AOJu0Ywb1WOeK5l8n9aBz4IhTAZpbkb0O2cUSzWkXKIsmkh29m3TePmq
	bK8G8Io6HEaoDCO5PsaVlGLAKNQlUBgNwFq045bTyayUkv6OFYwZcRa1arzTnqI60oQeEBfBQK8
	hq7fLw4FFnO59sSwrffz8BqDkRr2SHl2k6KUlNO7DfjaNEaCbWUYC
X-Gm-Gg: AfdE7cncSZvdQ3cFUGxwQWWrTPvacCQT/qhpWs+WSVym61hhm63NRPml6/9PdYqUo6x
	KgX1TL4DGwHLyxCA3v5Syx6EG2IJ36s5G143JSWRqVxLBjC1p7ahgYnZKKrUijl7zaRPU0+e1Fv
	bV8d1wqVH50Kcme8xFgCC/SID8ntnnVpPFc38DOo/fGCnrIPPvunUXgR4zHaMYC0IPKLr02V4dL
	ZbG6avh/PVS2KDw7pfG4zaD9t9PZKnhltDKTBS3DHIqx+MC2KLXfbRmeGl4+1l1HNGpZ83KN0PS
	f1DOxYmwOIrnMoWxnwiUCAJ8jTyB5n/BVPUtaVjwMipI6aSeKVoM4kE32asmcNrISTnadZEZXog
	t7XZRqbEvXJUXrr+t08JVI5SnBm6d
X-Received: by 2002:a05:6122:1079:b0:5aa:82ce:d15a with SMTP id 71dfb90a1353d-5bd69dc9a16mr1359420e0c.3.1782541178906;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bd78e656cdsm515052e0c.1.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 056FF402B1;
	Sat, 27 Jun 2026 00:19:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 032BEE40789; Sat, 27 Jun 2026 00:19:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
Date: Sat, 27 Jun 2026 00:19:33 -0600
Message-ID: <20260627061933.2187447-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627061933.2187447-1-csander@purestorage.com>
References: <20260627061933.2187447-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_231941_490519_7AB13989 
X-CRM114-Status: GOOD (  15.29  )
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

NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field to
specify the expected initial reference tag for the controller to check
against the ref tags in the protection information buffer. However, the
NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA.
The block integrity layer generates/verifies the PI ref tags according
to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
for the difference between the ref tag seed and the absolute integrity
interval number (= LBA).

If a request has an integrity payload, set (E)ILBRT to its ref tag seed
so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE in
NVMe devices' enum blk_integrity_flags to skip the block integrity layer
ref tag remapping.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++----------
 include/linux/t10-pi.h   |  5 -----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..8202ca706c97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,34 +914,34 @@ static void nvme_set_app_tag(struct request *req, struct nvme_command *cmnd)
 }
 
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
-	u32 upper, lower;
-	u64 ref48;
+	u64 ref_tag;
 
 	/* only type1 and type 2 PI formats have a reftag */
 	switch (ns->head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
 		break;
 	default:
 		return;
 	}
 
+	ref_tag = full_pi_ref_tag(req);
+	if (blk_integrity_rq(req))
+		ref_tag = bio_integrity(req->bio)->bip_iter.bi_sector;
+
 	/* both rw and write zeroes share the same reftag format */
 	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_16B_GUARD:
-		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		cmnd->rw.reftag = cpu_to_le32(lower_32_bits(ref_tag));
 		break;
 	case NVME_NVM_NS_64B_GUARD:
-		ref48 = ext_pi_ref_tag(req);
-		lower = lower_32_bits(ref48);
-		upper = upper_32_bits(ref48);
-
-		cmnd->rw.reftag = cpu_to_le32(lower);
-		cmnd->rw.cdw3 = cpu_to_le32(upper);
+		ref_tag = lower_48_bits(ref_tag);
+		cmnd->rw.reftag = cpu_to_le32(lower_32_bits(ref_tag));
+		cmnd->rw.cdw3 = cpu_to_le32(upper_32_bits(ref_tag));
 		break;
 	default:
 		break;
 	}
 }
@@ -1889,11 +1889,11 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		break;
 	default:
 		break;
 	}
 
-	bi->flags |= BLK_SPLIT_INTERVAL_CAPABLE;
+	bi->flags |= BLK_SPLIT_INTERVAL_CAPABLE | BLK_EXPECTED_REF_TAG_CAPABLE;
 	bi->metadata_size = head->ms;
 	if (bi->csum_type) {
 		bi->pi_tuple_size = head->pi_size;
 		bi->pi_offset = info->pi_offset;
 	}
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index b6c2496866ea..5cf4859877f5 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -66,11 +66,6 @@ struct crc64_pi_tuple {
 static inline u64 lower_48_bits(u64 n)
 {
 	return n & ((1ull << 48) - 1);
 }
 
-static inline u64 ext_pi_ref_tag(struct request *rq)
-{
-	return lower_48_bits(full_pi_ref_tag(rq));
-}
-
 #endif
-- 
2.54.0


