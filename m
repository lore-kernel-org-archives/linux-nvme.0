Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D2D3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n6Fn5P5m85QFxX97U9nzSHpVsE86jbDQKS45kO71lE4=; b=R4md5Ka9sWdeaBNIoaGVkLYTPk
	3S/kA+ZGwS6xZGj87LAZ/+SGOVka9KDuBcdtytQQ+bquphEBiHYpL3k6V7dr10o+0FQXDaNp6X9pI
	UIs6Xn22fmBlHLKqkj78W7vwIlAXPNlW4JLmHLSKVO3BbuT+e+57HNkXKF9zcuokkPwGUKIEaucjk
	HOlW2ArqoTmVXTSEUuZdXfUVwteafrbL/lwERJgM7zZcj9FhXQEPUb3D9hEpJzcoYvWjLNRlbiZXU
	ci1n1f96Xd6QR5GYV8H6JLAY1hBWSwKMqIjchasG2HlvHzb7Of+YMGQbfndbEvjM/aJbvrsmxLzKT
	/0rKI9Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbDq-0000000D7RQ-1lN4;
	Mon, 08 Dec 2025 13:24:14 +0000
Received: from relay2.mymailcheap.com ([151.80.165.199])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbDo-0000000D7QV-1eKB
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 13:24:13 +0000
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id AA8333E88F;
	Mon,  8 Dec 2025 13:24:05 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id D679A40085;
	Mon,  8 Dec 2025 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1765200244; bh=1eOsjkVyqljHHAUvFpsqS6srjVsOgv5YZkpVTLepo4g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJ4W4an23CnzAybbzVa1H/xtTGhIQWmIo1MRzNKq3tVe20Dgz6RxAgcGtF85vYh2a
	 Ik36MErxSiXoDV5+ZRKUzVGJ8UoTDJjeI1qFI8l/dnw10m2FOOj1eg2gaNCT26TNJd
	 LDFnz8KwypTnX+Vdhf31Y3i5BxJq3ej/KA1iV9vI=
Received: from DESKTOP-FDAJS95.localdomain (unknown [111.40.58.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7211143C40;
	Mon,  8 Dec 2025 13:23:59 +0000 (UTC)
From: Ilikara Zheng <ilikara@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Wu Haotian <rigoligo03@gmail.com>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Ilikara Zheng <ilikara@aosc.io>,
	stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER)
Subject: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to disable secondary temp thresholds
Date: Mon,  8 Dec 2025 21:23:40 +0800
Message-ID: <20251208132340.1317531-1-ilikara@aosc.io>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: D679A40085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[42.12%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[11];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[ilikara.aosc.io:server fail,stable.vger.kernel.org:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,aosc.io,vger.kernel.org,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_052412_602024_883F5A08 
X-CRM114-Status: GOOD (  12.52  )
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

Secondary temperature thresholds (temp2_{min,max}) were not reported
properly on this NVMe SSD. This resulted in an error while attempting to
read these values with sensors(1):

  ERROR: Can't get value of subfeature temp2_min: I/O error
  ERROR: Can't get value of subfeature temp2_max: I/O error

Add the device to the nvme_id_table with the
NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
composite temperature thresholds.

Cc: stable@vger.kernel.org
Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..31049f33f27d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3997,6 +3997,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.52.0


