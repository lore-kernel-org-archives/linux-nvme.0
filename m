Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC822C5CFCF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yxq818myupXhtwcrZIn4DVpAwIlvbEBii869YtzAJT8=; b=P4cqquRTrNpWyZvekC3P+kcRiM
	pxsRlkojdir8ORhFT7Eb5+PB26GNR7VpOYZ1vq6ygVZNVn6Dff/feinfVCeHKDNwscJUuihci1Zyq
	3uc2bj/plnib60TohpsGLf4UISvOzHqGDZksKbQRwbHTSMWxE8pEeny07ewc8QLiSyng3cGL3kvF2
	rg85+1f5CJtyvEsdYuwe/iqEnqee1IP7UDhUAhojf/6Tbxgd9YFWrd5boDG9uoK+Qz68HD6F/RffA
	nsv2U0b+VdX+hIHsKEuXPq3c86o5zsqKS/MxveFGiS6E/J7/r+9l59jyRjZoVQgbdRq6ehoDDxWLu
	VBdX6HUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuuTs-00000002txr-3Dwf;
	Fri, 14 Aug 2026 16:10:04 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuuTp-00000002txQ-3s4w
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 16:10:03 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-836c91bd782so18233907b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786723800; x=1787328600; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxq818myupXhtwcrZIn4DVpAwIlvbEBii869YtzAJT8=;
        b=WTpHrRZsmOwomWKrYWgKOCIBdQezOxS9D6ayAvJTmwXTTeUTK5P3vG4iFfUGaSmiOV
         x91T+zuq39hvsaUGSwpt7+zwhXcMy9NEWaSJvFbX45B91NuDkDOPZuHRAo8+WvsaFzc2
         mu5N4nlqEyeRe74UWuppk45UFewNM18TrBM/2IH6m8oYy7e1on4v9k4ZpB/YWYthLFUr
         dzX+mkxLXZlKL5vnIvWALrxc+96jCN5MfL+RVEMG6HjNUM181InY7g+bjXMikxdG3GOx
         2Nf+K+6YMahNdy6FsHkcznTuJSRQMM4CvGVlJxCb1kbzbKeRiea5U4dMx2Z/BQmY2JS7
         mwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723800; x=1787328600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxq818myupXhtwcrZIn4DVpAwIlvbEBii869YtzAJT8=;
        b=A46nzLPS3mswLWxI3sn0EBJDEge5q/AOQDPjgVfCKKMcGo9yvGFc3nx/3cooJCRCRJ
         YWk+L3xjtkbYGlAik2arGLb+fJX9FA7kRpHHB5nV2bs4tOdEk9oqOUylyJc1hZf1gCl7
         gNM85S8QAwCS1s+tj4aXKjS9H7z79LJ4qTz96iUDRAfkLDYE4BxymSH4Ud8/uNGGmMd/
         Wnvlf66hsz9RN/wSxyk36V1wEmwB3PmIXRfh9472CzX+Y5eU9I9KCiUX1vfcWrZ1DXw7
         41P5IRvlQEqZp/VDyiKEBWtsK+fYwCQXbZjjvVSseelZUUF1evUkUm/hMld5n/ZzcL+r
         darQ==
X-Forwarded-Encrypted: i=1; AHgh+RpszduTiA+k62/x9zz9odNHkL8rNMsCVlVu+NQKm3DCuYb+5EhUIq+E6C/HZqeht0NssoWcXvuNCHcY@lists.infradead.org
X-Gm-Message-State: AOJu0YxyKhs8L/xgePFf/eMTtZ5I9EVtTa/rGalewXMNQkpc8r+S0Ag8
	1acCewPqXDUSQR2bV6DwA86zxmDq1gRw2bzD653tQpPhO/QfSs+zps36
X-Gm-Gg: AR+sD10aPE8p4K6sbFT9mmj8w3FdDUKGzuJ5GUj5aNNbVurJbfj4khlHRgXf4zfaX2t
	zC5YBqTLLL4AJ3Yg6MJFJKYB3tJhx6LwvTEbM+j36Jrx6oDMnMkn7wCIpPHLDWMeXN7AK/bK+0E
	QkgySzLc5dXimIpl4L/4aUxgUpQcb+4i7eD/luLRPbykh75EjJ5MwE/0fIVSzhRTKcWwiwomlCR
	6mLYY72oFcTJ+ZlWzZcZsdWeRA3LfQELi+f871h0pFN8F4N2zNxpvy9Q1w45zbmA1dyJGjo52+m
	Wnfmg1NKzz7GVXAJIfsv0G2bTcDjY2kMD2nj7ELZRYIvmym1Qcz531ccZXES30CEl5x1xy0GAr1
	GhEDPD6pi3Ypk9rZKBxTipawFatdjW1TiGdmwh4dS9Ba3RM67w02oIt1nA5VvoJE99UYhYKEswn
	gKO1vQ39TGf558BrY8/wWcsl+v23SxR0rshHi1GtpT+DdJ2tWql7VChYN4/R+0rPSKeeeD+I23h
	pet8f/l8LbnJ/tYlw==
X-Received: by 2002:a05:690c:6310:b0:7cf:d242:d94a with SMTP id 00721157ae682-8371431484fmr27885107b3.25.1786723800495;
        Fri, 14 Aug 2026 09:10:00 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c261a59csm15358717b3.36.2026.08.14.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:10:00 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joshi.k@samsung.com,
	weizhu@fiu.edu,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH] nvme: reject zoned namespaces whose zone info query failed
Date: Fri, 14 Aug 2026 12:09:54 -0400
Message-ID: <20260814160954.2839507-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_091001_973251_7DC00214 
X-CRM114-Status: GOOD (  14.63  )
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

nvme_query_zone_info() returns either a negative errno or a positive NVMe
status code, but nvme_update_ns_info_block() only tests for the negative
case:

	ret = nvme_query_zone_info(ns, lbaf, &zi);
	if (ret < 0)
		goto out;

If the Identify Namespace (I/O Command Set specific) command fails on the
device, or if the Identify Controller command issued by
nvme_set_max_append() fails, the positive status falls through and setup
continues with the zero-initialized "struct nvme_zone_info zi = {}".

nvme_update_zone_info() then configures the queue from those zeroes:

	lim->features |= BLK_FEAT_ZONED;
	lim->max_open_zones = zi->max_open_zones;
	lim->max_active_zones = zi->max_active_zones;
	lim->chunk_sectors = ns->head->zsze =
		nvme_lba_to_sect(ns->head, zi->zone_size);

so the queue ends up marked zoned with a zone size of zero.  This is
reachable by a malicious NVMe device, a buggy firmware, or an
attacker-controlled NVMe-oF target that fails this one command.

blk_validate_zoned_limits() does not look at chunk_sectors, so the limits
commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
size, but by then the limits are committed and the queue is unfrozen and
nothing rolls them back, so block devices that are already open keep
submitting I/O to a zoned queue whose zone size is zero.  disk_zone_no()
then shifts by ilog2(0):

  nvme0n1: Invalid non power of two zone size (0)
  UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
  shift exponent -1 is negative
   disk_zone_no include/linux/blkdev.h:747 [inline]
   bio_zone_no include/linux/blkdev.h:1052 [inline]
   bio_straddles_zones include/linux/blkdev.h:1058 [inline]
   blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
   blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
   blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
   __submit_bio+0x315/0xa70 block/blk-core.c:637
   submit_bio_noacct_nocheck+0x488/0xba0 block/blk-core.c:755
   submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
   __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933
   wb_workfn+0x8c9/0xd50 fs/fs-writeback.c:2403

Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
caller tested "if (ret)" and bailed out on any non-zero return.  Restore
that behaviour.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..dd7859826d2b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2417,7 +2417,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_query_zone_info(ns, lbaf, &zi);
-		if (ret < 0)
+		if (ret)
 			goto out;
 	}
 
-- 
2.43.0


