Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFECA9EC5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/oPHUN39m0Ic+wQfl+2jkv0p3LC0GdWlez6ws3xAFII=; b=gVqRWB5WoVNm33OAZ7+hlrTEe9
	J79Eyhw0PRkSIXdxZb4Vq4dCzb/vl5nS4nD43A8gt+EmGpXA+LBR0Cb9IHCn5E6uN4BKE1Ok/3O4F
	MF4Tk8ysAnjDXCI4LH+U9/HFvOzf/mvlgXJxWVOBWGN1has8m7qk37hW8rsUggYoQxjI3EQqCELxw
	Lbu8pdQZdxJEeWkahWVFJOiBo4QVOPEMOQ/GIfOGLp/ol58gvIHBFKSLnfiFiPUg3SomrV/fksF9/
	gECMNIibWZ/tBfbmkqhqL0MW1a1FMi4ih5gfizRDYpSAaqtZEUtPJhlDlcE2pQ02Ks84/XVbig78e
	eG3IT7KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm1-0000000Aecw-2q44;
	Mon, 12 Oct 2026 14:13:05 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGlz-0000000Aeat-02j4
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:13:04 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-48c6955a7c3so398241f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814381; x=1792419181; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oPHUN39m0Ic+wQfl+2jkv0p3LC0GdWlez6ws3xAFII=;
        b=LF+P5wSWXjTjBxbPzyxWLc/6O+VWrLzBdiUzWdWST0PQQ0X4PgUyM7ZgBrY13w/9FL
         vd3Bm1V13DVljfDCj5NAX/JqoAWdwL/XwRzcYU65d/KnavHuuiUDsCbvZGP0NJ7gHkfv
         tyoF42HniaMggL0drDwJERYVsyDHJAaM+nj5AuxAl33nOSmXwBaus0IXdltMs+It/8a6
         ZJq+KcLLPRTBrx0cTq33ogYmP5ekaLWYBsQy8/vjrEtGLxTVEpzy/VmLs8NkcixMpICh
         1sWHsi4UjQToKxD4rRR6FHzj/CyPPV4gE3UB0YixXuNT/Mn5iBZWw4LPe+ryRSBUSeqO
         v0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814381; x=1792419181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oPHUN39m0Ic+wQfl+2jkv0p3LC0GdWlez6ws3xAFII=;
        b=ds4VG+9iUsKxL3usXMw5QTyeAiAMEcQ1GRSso6ohqHQOdhJFd+wwq1vgHZ8WmoIOyN
         1bpZhFkuCfMl8VW3COSK+F3OOxgRaDPLiAgl6h0GQjmDsZ1XHjMIDbKm45ywDC+KK+9W
         RLPYuRXxySUD/yqGPJ/9Hcgk2xxcA4OnuQXhysyftfw8uJ/78MDjgGyTlGRpAcs7+FnC
         P/KF0/UAg7HcTXWAKs6LP9IoiICqlfF+9DH+doEDMMWjGYa0vKd5rEcJ00O+1IRcSxcE
         izw1Wquu8/ZQkryw+Tvyz6Bwncn561oqBCqzA+6f9WXKjRD9vpr4ZaC6XgdOp71h01Gb
         LORw==
X-Forwarded-Encrypted: i=1; AKwUvBxJtkGDpxL0s+nz8BBLXXNt6JHa5atvjzKunufhvQSR/DJGEhoT0K7uVHDcJtTqhzilGiUkHRMXGo6H@lists.infradead.org
X-Gm-Message-State: AFq9FYIgF+3vv3y8Yh1hfSpfMSS7oDNF9C6EY7DcZeEiJp97SApmpewh
	1VqrwjecoePtUp3tTw09imZK7qTUND2Z8MCfPtETNDerc6SIzg+vmnNq
X-Gm-Gg: AYBFou1oVMVMs2H6qitT1x1quVF+/jkjIODY55LfyYHcJVPzBJGTcVyHMpVa4RNMGBi
	Jr6tHUbXLBH3/rkMTlSkXo4rftVTJwsX3ZSlbxPukQuuaCxYt6KMCd814K/i71hLcZFF1oYOco5
	LBhVYjwu0gu8drl+IUQl3Capicu1bWG4fz2QtuBEJck2FGXUahmwqwYzEKPh3UYHahPo8rSqHAu
	ztvQL9ncYWiJMmVMcHtdH5ijug+7Ggxh75HqrQmvBn7TMjoJBz3foAtCIZzyJhe+bPcoVXaiTD7
	kB3u+5HDssLzwx5J3i82bRt31B2O1EzebepGs8ExBqfhf/EO4R2bLGP26x7Dqw5n1K+6bhtUDGF
	/3RQuh4anNTXXVIbsqt9kj69xGbtADcnBBRDVFHPUv2ClNI1FT9tMMCIhcCZtFy6J45Zq2Xugr1
	MgqWQPbdnW8rAdoy92qFxhdzdDSN+vaZpCivlGmSAmyLC5G4dzdQKSyX8ox8ClmQK937wBMOmhA
	i9SDrZwnbAL76+qAxRCcaMr3JYrQBGM4a8ZDeKjaWv9
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr16554793f8f.5.1791814380792;
        Mon, 12 Oct 2026 07:13:00 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:13:00 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] nvmet: zns: reject a NUMD whose byte count wraps
Date: Mon, 12 Oct 2026 16:12:30 +0200
Message-ID: <20261012141239.156408-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071303_600846_F6DB0E83 
X-CRM114-Status: GOOD (  13.82  )
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

Zone Management Receive computes its buffer size as (numd + 1) << 2 in
u32, in nvmet_bdev_validate_zone_mgmt_recv(),
nvmet_bdev_zone_zmgmt_recv_work() and
nvmet_bdev_execute_zone_mgmt_recv(). NUMD is a 32-bit dword count, so
any NUMD from 0x3fffffff up wraps.

The data length check in nvmet_bdev_execute_zone_mgmt_recv() sees the
same wrapped value, so such a command can pass it. A data length that
does not match the wrapped size is already rejected by that check, with
Data SGL Length Invalid. Every site agrees on the wrapped size, so the
target zeroes and fills only that many bytes and nothing leaks, but it
answers a command whose NUMD asks for 4 GiB or more.

Reject a NUMD from U32_MAX / 4 up with Invalid Field, next to the
existing check for a NUMD smaller than the report header. Computing the
size in size_t instead would still wrap on 32-bit kernels, where
nvmet_check_transfer_len() and req->transfer_len are 32 bits wide.

nvmet_io_cmd_transfer_len() in core.c uses the same expression and is
left alone here.

Tested over the loop, tcp, rdma and fc transports with a zoned
null_blk namespace: a wrapping NUMD, sent with a data length that
matches the wrapped size, was accepted before this patch and now fails
with Invalid Field, while ordinary NUMD values still succeed.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/zns.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 78d82b6ff1214..14689ca0c38af 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -150,14 +150,17 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
-	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	u32 numd = le32_to_cpu(req->cmd->zmr.numd);
+	u32 out_bufsize = (numd + 1) << 2;
 
 	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
 		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	}
 
-	if (out_bufsize < sizeof(struct nvme_zone_report)) {
+	/* From U32_MAX / 4 up, the byte count wraps and no longer matches NUMD. */
+	if (numd >= U32_MAX / 4 ||
+	    out_bufsize < sizeof(struct nvme_zone_report)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
-- 
2.53.0


