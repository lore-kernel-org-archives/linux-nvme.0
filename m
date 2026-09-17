Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97094C982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OgGmZb6jMSQm7J0WUsd7EqZXeayHVzyN5G7uVzAochY=; b=ar5ZGs+VHmdXWtYrUWEMvglMeq
	GZa/FP0KeWwnJS+ocHjpeoen4FAJMDMDfSMJWcmen343TxShYo1Plk0tmZqgaDn8SMWLcak5uOyyM
	Xy+aFGI1G6rlk85v9dHD5S9NoCpuupmg2t+I0YUPqNvFlEvsEY+0/LX6wFe4WNK6KoU26MEgqNXnE
	08okYsodqnG8mc5dzw/m+PMEjst81OaEMdfxnyxfGXZ2y/nH1XGmeagCpJanvWS0RzkVTZ9DTHbgL
	E30qcso0sHovh9442BUvTgMRQn0NRDOTXPxJ5SCXBfYr8FfRFB5GCbQjP5TGP4iZfI0+wUmufFSoL
	H/JcIKXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x75Oo-0000000AeH2-04aQ;
	Thu, 17 Sep 2026 06:15:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x75Om-0000000AeGw-2kP5
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 06:15:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A32C860A54;
	Thu, 17 Sep 2026 06:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6641F000FF;
	Thu, 17 Sep 2026 06:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625707;
	bh=OgGmZb6jMSQm7J0WUsd7EqZXeayHVzyN5G7uVzAochY=;
	h=From:To:Cc:Subject:Date;
	b=OLji/J+SlPtFVwXDRTALtfJybOnuplFckZevJIzuYursj8ciOQMlHbILFsICymUjv
	 qynbKVkW4UWXHZf4VsrF+ji0dLO4XW2j3vaxvoTifnH6v41foHf1QMHzT8K9i0U35M
	 HT4vw54G/YIZVgsxhz993xI3XHmfh8PAr8gPcionqGk3+X77PiaaWXOqQbsnNXSR2Q
	 mE0JB0aDKtSdiHBa0SfjRfnxCAKobxi8GiTRX/5rvjEEkb7+T13fzSbu7kCd6oeaG7
	 IVePExkfyrNAjXyRnLcp4dyfHWFmSMULRnpIWF5G1Z8z4qG2wj97ywgWnFN3ms9/U0
	 sCciQf/QAUsIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: work around all -Wformat-security warnings
Date: Thu, 17 Sep 2026 08:04:03 +0200
Message-ID: <20260917061459.1486026-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Arnd Bergmann <arnd@arndb.de>

The sysfs code passes two string variables into sysfs_emit(), which is safe
in this instance but causes the compiler to warn when -Wformat-security
is enabled:

host/sysfs.c: In function ‘cntrltype_show’:
host/sysfs.c:682:9: error: format not a string literal and no format arguments [-Werror=format-security]
   682 |         return sysfs_emit(buf, type[ctrl->cntrltype]);

Print these using a "%s" format like all other instances in the same file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 02a2490a9ed7..e1e3dcfd084b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -679,7 +679,7 @@ static ssize_t cntrltype_show(struct device *dev,
 	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
 		return sysfs_emit(buf, "reserved\n");
 
-	return sysfs_emit(buf, type[ctrl->cntrltype]);
+	return sysfs_emit(buf, "%s", type[ctrl->cntrltype]);
 }
 static DEVICE_ATTR_RO(cntrltype);
 
@@ -696,7 +696,7 @@ static ssize_t dctype_show(struct device *dev,
 	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
 		return sysfs_emit(buf, "reserved\n");
 
-	return sysfs_emit(buf, type[ctrl->dctype]);
+	return sysfs_emit(buf, "%s", type[ctrl->dctype]);
 }
 static DEVICE_ATTR_RO(dctype);
 
-- 
2.53.0


