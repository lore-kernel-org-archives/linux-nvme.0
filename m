Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03A5C61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i10FjmX67zefyeXKozkB0Kmfyho0gXqWl4rPPjjJZ9s=; b=LiU61CFohht+eiXHaYPGVXMZ0+
	s5AehkZHL59RlIjKQLSnftxmvGd5MlfT6L0rEg5De5Zy75HuQmtTyaaGlOhZxE44F0MTweNbggRQK
	38dpNaT48ZbmvRGWupgjJfYtl5Jtr54enK/s5YXSI8dFedWKDPt8yUhFDz/v/zaQeaNJ/r6bKJgPA
	2tEIaUsz4ii+755nDXzS++lNFvucccPAtfM/q6+g9qfPeHl4w1hCed308AWJGWnP/CQIjJOzODKRf
	L9tpdobExtr1CjgTvnsrKnVKAeH9q+sHpcBqHFi4U9EtCcZWTaw83tPAywAWHxzGGFjwibWPFdWPF
	sReeTGtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfIB-00000004emf-2rag;
	Thu, 27 Aug 2026 18:57:39 +0000
Received: from mail-vk1-xa61.google.com ([2607:f8b0:4864:20::a61])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfI5-00000004ekU-0BWQ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 18:57:37 +0000
Received: by mail-vk1-xa61.google.com with SMTP id 71dfb90a1353d-5c2b6d3f2f6so7624e0c.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787857051; x=1788461851; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i10FjmX67zefyeXKozkB0Kmfyho0gXqWl4rPPjjJZ9s=;
        b=KLp+Q3iUr7Tj5uroS+/2ue+/LPR7qbIArO6U9zsgA9xRieUiQ46Dn5d3zDsGPQDzV6
         EnvndWcNgJ3uhPlbYDg4uEyRNXUsYuQCLfpf1qTV8+ewDJgay96REOp8d0zJGb9sP8qU
         rj+i39IHpePpiyDrfFLV/VUfItUMXYA3FwEcnOASCUJj46UF3+yHZOaMXI9RuKWp6wxZ
         WLYXreEduhHs4InYTy5VSfxpdkl+Mhsk7B7YATp+uUi1yndU+jWQa0WlNgQ/kT1CmWLK
         pxRfUgjd9baaSSITeo96TSTmZmZgDVNyfMtsFJ/81AETEWo9ssyQ4NFyTNlcxyt2Yui/
         AsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857051; x=1788461851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i10FjmX67zefyeXKozkB0Kmfyho0gXqWl4rPPjjJZ9s=;
        b=UNOvWstJnE1/PwlvRNdmifCcOOgeTTB8YvQn8E4yKHKWx6yPKQ/RWwBkH3WmSMyVSa
         S5dXXxFxNeSMpQCb9qkeQwJI0Qo08u7Vswd34bFi4BS65FV4/Rahz302WIkTF2I48gfW
         gSg+hioIsa2aiMFdaiTjtn37J2tq+Y5yYQ9GWOVlAFzCS6ePFNHsLhuzXE1E0jcG5hUW
         1E9j8IC9W41xmZE7OEqF5qyqxlewoScGpYuxyjBQOHQpBnKPWEWqIpNj2krwcSzuDI3E
         Cc4m8XASOAJZyyY4bg3lWFxW00wP+yb/PgZhqsHnXu+vbbkshuAq/B4shJpGcUbJ61fI
         pSPg==
X-Forwarded-Encrypted: i=1; AHgh+RrAC7JKGb+EGWWtIo4DuKkqnYQ+Y+zq45l5Is64r8QOlXXMB1w00l7DgXqQkH5Ei750ym5hYuk9MeOm@lists.infradead.org
X-Gm-Message-State: AFuF++mtHbf2y7ZFApnPZ04KDNuf2hHePZsXhQcraDmjxr01xAxKbA6h
	99XBQRTNbFIJ+T93bQRdbPWophbExi0BKnNdd/0fkaJzGimRoN0U2Li2Nkio7tz3jH6csm0AkVr
	8f5dfivy43/lyiAtw/af9ySenqgUTKpCWy1C3Bad57ytZ44vvPMCi
X-Gm-Gg: AR+sD13UrxUtS2NKkxoYGaO890ps3Uba7njqFOwzzCHW2cyJfWnNJQ2CwtOxBL3j0+T
	X34In8rvDS3g114vhYc3GypRVu60SI0iodaeoCjBKKzactDn+vEiigfkVPzzFTLA1zBBXX/I4WA
	YdBJ3+8vnlSFPlbDg85yfnITwFwLL1XJf9j9NrOWsdE0BuWiJRFOSfMwjC5rRl1PYq7upPAW7aE
	mywTK+TfVJ0QFcTBIMh1NJPy/XU0tZyKcsGLLXVaH0LNEcQvk/0VkhwJHt2/TW/nO7gIpYhIIfz
	6hVv/evmXFibzp9wCxDE5kGDGb9AebHlJzleYQt1zxpviN+pZiBmjKQ08oYg7tvsm3SPv4NE5Jv
	7g4CX8uAF9nGsx39D
X-Received: by 2002:a05:6123:593:20b0:5c3:a1f5:7569 with SMTP id 71dfb90a1353d-5c680feb0f7mr218849e0c.1.1787857051036;
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c6600147edsm1730496e0c.8.2026.08.27.11.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 64D774013B;
	Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5A653E404C2; Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] io_uring passthru: set result on blk-mq request completion
Date: Thu, 27 Aug 2026 12:57:19 -0600
Message-ID: <20260827185722.3234622-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_115733_212340_33D7E6B4 
X-CRM114-Status: GOOD (  10.26  )
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

io_uring NVMe passthru currently receives the NVMe status and result in
the blk-mq request completion callback nvme_uring_cmd_end_io() but
doesn't post the io_uring CQE until the io_uring task work callback
nvme_uring_task_cb(). The status and result must be plumbed through
struct nvme_uring_cmd_pdu, taking up 16 bytes of the 32 available.

Store the status and result on the io_uring request in
nvme_uring_cmd_end_io() instead of nvme_uring_task_cb() so it doesn't
need to be passed through struct nvme_uring_cmd_pdu.

Caleb Sander Mateos (2):
  io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
  nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()

 block/ioctl.c                | 10 ++++++----
 drivers/block/ublk_drv.c     | 26 ++++++++++++++++++--------
 drivers/nvme/host/ioctl.c    | 19 +++++++++----------
 drivers/scsi/scsi_bsg.c      |  4 ++--
 fs/btrfs/ioctl.c             |  3 ++-
 fs/fuse/dev_uring.c          | 15 ++++++++++-----
 include/linux/io_uring/cmd.h | 29 +++++++++++++----------------
 io_uring/uring_cmd.c         | 34 ++++++++++++++++++++++------------
 8 files changed, 82 insertions(+), 58 deletions(-)

-- 
2.55.0


