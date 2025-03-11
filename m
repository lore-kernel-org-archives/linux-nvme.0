Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB52C28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zChzazY5Qs69YLs+3oCkq+znIcewTAfGgKLRQW/XwDA=; b=4r58nCy1MTXjFbDQbECvFER5gy
	ygBXnhNoMwrmX86kXtSHI7/meiA1NkE3NMhrEgPADudFV0VD7GyI4iUA1ALHJMeU7GR8GuMJKdm2+
	0EftEiBV8ws9mGY4NMD/CKiC36Cg3vNhR77waXEO2KPBuba8GBIFxqfmKFi5eQ1yXJyoaVyu/0yIw
	5XqvuAAW+UqN/R/CkjTFPMQ1q/G0z+ZHdo4SOWbcP0cMlg+G2hjIU7BPCtgVE49XprGalz3lkClJb
	sc88xEdnMWePBD/qAPLWY/uO/pf//MZQ143Daw35wcbO26s6UXaICPg881vCRLr7/PnlTH4BSkpnm
	VBSGrpuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trx60-00000005Mmg-1yVw;
	Tue, 11 Mar 2025 10:44:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trx5h-00000005MfT-07oy;
	Tue, 11 Mar 2025 10:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689844; x=1773225844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOzGi1+oE4i2IJoUxhsL9xdE2CFvuKnrU3TH/IWp1Uw=;
  b=BjpZsULbilcSnAjMkrPcJw1GqGExL/hdHjTD6zCZIHCqiFgEQ3iv/1Pv
   k4/+iLklVyyQ6fo4KTNGblxFJrCBbu65y2Hco/arOUKSARKVh6CxKeeNI
   SNpcNBegtIJM8+aVlddfSySbFDTJ2Gu+DJykvYVnusr6CP4VraZaQvUv8
   r5e3PxkQqa+OCvjgsliyIxSckB584RxR9DP97H2djnm1bXrxfUMkFKpnZ
   U24k8aQYM509DPCnPGgZ1iRkL4cW0Np94kDl3BNJGnJt9PYm/VYCmcmxd
   Clwd5BN0QaVWyD8iCu3y9ZNfcsCEKYLirpD5UOHTLe0VVyA/mYKSH69Vo
   Q==;
X-CSE-ConnectionGUID: o4nn1c09ROaedkSHt0hvnQ==
X-CSE-MsgGUID: kza1Qjr0Ql2WdaapsclNQQ==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="46946034"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:02 +0800
IronPort-SDR: 67d0061d_J5oZsACSYuZGqn5Cm7inlAb/ZJdqj5C/XRY9omFgeYp88g8
 Bnp6EeycVOlsHwtJdLXC0IDrUBFPYY9IWp+dquQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:43:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 19:43:57 +0900
Message-ID: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_034405_064298_B31968B1 
X-CRM114-Status: GOOD (  10.15  )
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

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
failure [1].

The test case injects errors to the NVMe driver and confirms the errors
are logged. The first half of the test checks it for non-passthrough
requests, and the second half checks for passthrough requests. The
commit made both halves fail.

This series addresses the test case failure. The first patch covers the
passthrough requests, and the second patch covers the non-passthrough
requests.

[1] https://lkml.kernel.org/linux-block/y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3/

Changes from v1:
* 1st patch: Added Reviewed-by tags
* 2nd patch: Replaced argument blk_status_t with boolean 'is_error'
             Added kerneldoc of blk_mq_add_to_batch() arguments

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to bool

 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 12 ++++++------
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 11 ++++++++---
 6 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.47.0


