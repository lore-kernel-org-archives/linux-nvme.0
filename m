Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87465CFD36C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KD9mOy62HqGMPaOYo+qJ4jLF6S4k7Y6n0q2fK45fvpw=; b=MxST6lrBfJP0ROkN0wmM7SsdFj
	lGPkvWdXNcbLyNlELMC0NXzuw7CZ3zeA9RWQIpJ9kVTAD14fx5Z3N9G6NLDkeB87/ZCKnR15ua0TE
	eloQDLrKHiYH5ls8bhjqdOZLy3DsMWey8OcmoQtJYR1Qw+l2KonOBrdKmp6i9Sa30Vq7GOFiQyN7J
	9Z2xQOk7XmW3HNLbQUtFQabZx54VpSMnEY9imtSe9/eDHmArz4RdlNc6RpjkcrvQkxYaAaR/01WWS
	dhfovdA0h1bTN1A/uu3kb0YrtGcQRuf93H1riI4dKU2JHe43hUxKkWdBhkUjS2chUhGQDg/OzHbr/
	fHPc4zgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgII-0000000CTey-2pzG;
	Mon, 24 Nov 2025 23:48:30 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIF-0000000CTc8-3Cin
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:28 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so1596942a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028107; x=1764632907; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD9mOy62HqGMPaOYo+qJ4jLF6S4k7Y6n0q2fK45fvpw=;
        b=PfEJWc81SKNx3Z7cCV9zZAN1EGmoofusT1+AkuLTm6RHnwiP8KMFC19r9DgCaTUEJJ
         dphjaa2GoSRxcwGBgABjqHdp2+CpkfEDPEY//E6A4jFVY3wR+m05Nbt3/MM6qcZFtvNl
         1k3BvNrvaVavtQmK3+ao711qlleHAbIahArbebg/p85n1OEwz7Y7ZC3Ro1zbICrvEP2f
         KDSpN/0i//zTva02WPJecWUg4rtXQB7aaPgnxDcbOSv7IKx6LvoKbE7INeMGynZgaRkh
         uIjdp78fnGi534RB+5UgfYbgAMYJOoYvQcMpeU93ChACHa+M/zg6Te6k902FaEIzCCOd
         PIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028107; x=1764632907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KD9mOy62HqGMPaOYo+qJ4jLF6S4k7Y6n0q2fK45fvpw=;
        b=su+4nDzX7MbBJwfQPZyu+G+x3HU4EUWcNAk1lYWbKW/lt7THPP9QzuGZqdXBV+lQrf
         5etS7CrRX/eMlYYI39YYEMQB1YnAkR7mPBRg4WBmQZyztCdtwf02Nv3iN9YBJE4QS2YH
         MNB1beXQ7Nz3E6Rnh5Iwf4DxSQH7DR1A/IOyengeVOXAgz0px2ZrSwFYT1itR4l1DNhs
         istg7p1ka3h/h1KOIPcACXxIolXnMidK/YJEoT/WY9C6J1A4mH9HXvvno5Xx58N23yIr
         7HfUIUonNuCVM7MvTcAAL8jOiCqbk20Y93WD/1gKgVgJUZZRQOxyw10A4NTVtT3ffm0N
         YaQw==
X-Forwarded-Encrypted: i=1; AJvYcCXOqbPonr0evfxc0K3XPDAUZlgKXikEnUvQQ/gvXg2xnYtUaIQMYNZJh2l14+1uZHIumWwD19csH1lK@lists.infradead.org
X-Gm-Message-State: AOJu0YwBscOf0a5UWCLvxFRUmsloKzrcrrC1+61D/VH8xm33gBLBSSed
	1hzoE8bUhhlinUbBysJqVW9+OXaiFe8k3uEDnlnGrHiff4AaJi2fua2/
X-Gm-Gg: ASbGncv7TBkKRNicuUb+JQPYgbvLDYxfCmYZYSBmf1wzCyI2MS3xIA1R8x4N5qRmB5n
	Hb0nAXBMNS1OOIlK2XC9XUPOZoDgUZTUQqJeClGB9MilRHBJBXkVM9wcE0Kdf0E9g2Vr7fN5MEJ
	GzIm5ihhtqT0XrbbiSL7ZT8G6p1tNig63/ISD3cSi3OfkGoMSORsdYI0XniVFB0ve3VxcxkKW4/
	BX5BGKtfOANBYJYhVU5HN9NLp6s834VyjTxLH9abFdI6sq5zO4TDlX8VuldzJwvyCPwz8nFbSRE
	GvDPrc2OwrYqDbWKfZs6/v6G6pDr6g2sYLSCPq8rRZHbYosCVcry8b0xVpnxlD4p6qlJ8OvJNy4
	ZCfQlpFZvYtJiL3LaLdPF2D5ufftSuUfrYFyvaN4GQozXRFSC1S3YF6TSDaD0K6JFcoYZfy5937
	88CReVmK/pbRVk2tYjKrxpgJ7MpyuRWnHRC4I7Nsz0iXXM8D4=
X-Google-Smtp-Source: AGHT+IGqGWPp3dbaz9P/oMvxkH8tM768OBnx1ym9H6OndIwxHy5XjYnjyPQDBtMIVrKtoM7S3ehYMw==
X-Received: by 2002:a05:693c:810c:b0:2a4:3593:9697 with SMTP id 5a478bee46e88-2a719279965mr8848102eec.20.1764028106837;
        Mon, 24 Nov 2025 15:48:26 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5b122dsm56253333eec.5.2025.11.24.15.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:26 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 4/6] nvmet: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:04 -0800
Message-Id: <20251124234806.75216-5-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154827_805077_E4972D74 
X-CRM114-Status: GOOD (  11.92  )
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

__blkdev_issue_discard() always returns 0, making the error checking
in nvmet_bdev_discard_range() dead code.

Kill the function nvmet_bdev_discard_range() and call
__blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
since no error handling is needed anymore for __blkdev_issue_discard()
call.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..ca7731048940 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -362,29 +362,14 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
 	return 0;
 }
 
-static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
-		struct nvme_dsm_range *range, struct bio **bio)
-{
-	struct nvmet_ns *ns = req->ns;
-	int ret;
-
-	ret = __blkdev_issue_discard(ns->bdev,
-			nvmet_lba_to_sect(ns, range->slba),
-			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, bio);
-	if (ret && ret != -EOPNOTSUPP) {
-		req->error_slba = le64_to_cpu(range->slba);
-		return errno_to_nvme_status(req, ret);
-	}
-	return NVME_SC_SUCCESS;
-}
-
 static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 {
+	struct nvmet_ns *ns = req->ns;
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
+	sector_t nr_sects;
 	int i;
-	u16 status;
+	u16 status = NVME_SC_SUCCESS;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
@@ -392,9 +377,10 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		status = nvmet_bdev_discard_range(req, &range, &bio);
-		if (status)
-			break;
+		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
+		__blkdev_issue_discard(ns->bdev,
+				nvmet_lba_to_sect(ns, range.slba), nr_sects,
+				GFP_KERNEL, &bio);
 	}
 
 	if (bio) {
-- 
2.40.0


