Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B54C04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=684w/N8yQzC6Tn8Ze9K1madA6uBopMwCq6oINoaC0Mk=; b=GzEuT4QCpCmoV0tBgcOCYyVN8T
	4FzgE/SC+kdYPah2ENZqjX7KnmVZr3htOiJtIIRFvy7bPAHd7qJgHN7f72d17VFugcTmsV1Tdivht
	6mkh+SfEjjVpPaTVu2rlny/0iMuYFz3lgvpaVnkcAkjkgspSpO5otrW5P5KcWfT0KdvrN2edJK0bp
	v647AKuafB1lhE7nnO+nUolTX6G1xV8I2eyndXBFlcZOyH1Zfv6KAnCs3PIr4iufeOLLZjBl4cvK6
	M1Bb9rYgfrnyPGrLrr7FjQag0wZjFq9OxqHLSDtSLmk/3kJ02bqvDaJBYJAY45uRDHirrjj91I1kK
	YMvwCV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92dL-0000000EWV1-3ZGh;
	Mon, 20 May 2024 13:00:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91Tt-0000000ELLe-00He
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 May 2024 11:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=684w/N8yQzC6Tn8Ze9K1madA6uBopMwCq6oINoaC0Mk=; b=hNg/Xt0AZF2LNFHoqYlY/Zgnl6
	WiXtgkwZf/LL7pGY4iBvDP5NO4T079BAwyNpiDnV2ZkEtDClgFwmxr1bEFV906cY62RbB9gnLR5yh
	uGJLS/axMK+gRlwR8uWTscFwjNhjzNs9FG8u7kzdJ0S3OIyeaozQYsnzkei5kCnczsC/CDAI4fxXR
	bkJqUZYWi1mlMCUR0P+JjR4X7Lrp6LS31j5yh7VeKmUnXLGQWb2aWzBJZFzF/njjmtS1Y6px3Irb4
	YeA4iSwXfzjhWeb2NT04rPt9fLBNHQM3dPe8SPkZjBaDjNYeuU09wHel1dKfXAXb1viIPucjSr2mj
	+Y8kc2Hg==;
Received: from mailout3.samsung.com ([203.254.224.33])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91SX-00000006S1Y-1luo
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 11:47:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240520114537epoutp037f380e1f81c53b5dcf14c1d63f9d6960~RL9fqfdVt1837618376epoutp03B
	for <linux-nvme@lists.infradead.org>; Mon, 20 May 2024 11:45:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240520114537epoutp037f380e1f81c53b5dcf14c1d63f9d6960~RL9fqfdVt1837618376epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205537;
	bh=684w/N8yQzC6Tn8Ze9K1madA6uBopMwCq6oINoaC0Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4BBaoiCg7eO3NbkyQRj20qNXHD/Cb4YTJ/QwhNs+nRp6U6K3WTtYgLBhYAvh8rB3
	 f+jEdjjnoc9gPqhk0Ol9g6yQeLiyQypbwdyXqovOgDrQNzp1X8hbYdZTg/wtua3cMI
	 dA3op2tJo3arCHZNMIzTy1/nPpg1yhhsgOAWX/7E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240520114536epcas5p4b47a99e3eb8f8fbcfb7db37da5dd4812~RL9e0A5aO0859008590epcas5p4U;
	Mon, 20 May 2024 11:45:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VjbNb0ddLz4x9Px; Mon, 20 May
	2024 11:45:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.92.09688.ED73B466; Mon, 20 May 2024 20:45:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240520103039epcas5p4373f7234162a32222ac225b976ae30ce~RK8DBSwIz0626706267epcas5p4I;
	Mon, 20 May 2024 10:30:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520103039epsmtrp14db3a1d303b0f5c58bde00b466dac9a4~RK8DAL2vU2229722297epsmtrp10;
	Mon, 20 May 2024 10:30:39 +0000 (GMT)
X-AuditID: b6c32a4a-5dbff700000025d8-99-664b37de4891
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.98.08924.F462B466; Mon, 20 May 2024 19:30:39 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520103035epsmtip2856ca038c4c00631139b63e93b5062cd~RK7-I3dqL2512325123epsmtip2W;
	Mon, 20 May 2024 10:30:35 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 12/12] null_blk: add support for copy offload
Date: Mon, 20 May 2024 15:50:25 +0530
Message-Id: <20240520102033.9361-13-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHc+693LZLOm4KwzOQScqmAuFRoHDYYJsM9TI0IfE5NKuFXh4D
	Su1j6GLkWcZjjJcoMjaQwdioAQblOZhdEdCypRpegwkDeYjCBEnEDbJhS0H/+/y+5/f45nfy
	Y+O8LdKeHSdVMnKpOIFP7iHael1c3Kf8w6K9crOFqNHQj6P0wqc40kwWkGipdw2gL1ef4GhO
	dx6gzXtGHGn7pwCqqr5MoHFdJ4a6q4sxdEPTh6FLX2VgqG/rEYmK9aMAzY+UY6hnwg19k1VD
	oO6eHwk01FVBospr8yxUN/AMQ0XZIxjqmEsDqG2zEkcNSysE+mHCAc3mZQNkfDpgddyRHhoO
	ow3VkO4sn2TRxqmbBD10T0U31+eQdEtNCr3Y8jWgb42nkvTViyVWdH7GnyTdqX5oRf81P0HQ
	K7dHSPqith7Qd6u+Z4XbRMQHxjJiCSN3YqRRSZI4aUwQP+wt0QmR0M9L4C4IQP58J6k4kQni
	h7wR7v5aXIJpTXyns+IElUkKFysUfM+jgfIklZJxik1SKIP4jEySIPOVeSjEiQqVNMZDyigP
	C7y8vIWmxI/iY1e0PJk29JOM5cRUYAjMBRw2pHxhW+kCyAV72DzqFoBZv03i5gcetQZgzqqr
	hdcBXGt32S242jRAWgp6AByu2cAtgRqD6soNUys2m6Tc4OAW26zbUhoc5rUUEeYAp+7jsLZp
	ATO3sqFegQ8yNdtMUIegdmYFmJlLHYZ/N/wELONegJom3bYljknXta5ue4VUCwfWLmpIS1II
	zLyfhlvYBv4xoGVZ2B7+XpC1w8nwxhfXSUtxJoDlY+U7E45BtaEAN9vGKRfY2OVpkR1hqaFh
	2xxO7YX5m3OYRefCjiu77Ay/baza8bAfjv6TtsM0XO6f31lqPoATHbWsQnCg/P8RVQDUg/2M
	TJEYwyiEMm8pk/zfp0UlJTaD7UtwPdkBZqZXPfQAYwM9gGycb8tt1oZG87gS8afnGHmSSK5K
	YBR6IDRtsAi33xeVZDolqVIk8A3w8vXz8/MN8PET8J/jLqkvS3hUjFjJxDOMjJHv1mFsjn0q
	lndIVTI/E3z7+uk+weeVGcKOI1YuR96PjL8zbq3/eeim9dpYybtB6cqi/IC9dRvD1h5nqkPO
	vrQuupJ+p+Cd41sO3DMHZh92X2oZ7o0qGwvOcj517rFBqPcMXBibD/2VmE5+m/wO9q5/QJzI
	Xe9RsQ1l0+LPCPC87jxayXnyavqHj91TrgkmT98tNLz8XoORqhgU1VWwjM4X9ultPB2Xwod6
	ph4VWHGrTvFLM2YjotR2i7YPAsftfFrLWW3L6byI13X+bTORrDKvwlSHN40c6Wjws+J2/8Gj
	v6Smt5707/KIPZZie3CQtIlp93nRvvWgMjI6T2W3nspTLdQ3uElmHD725vAJRaxY4IrLFeJ/
	AV/DHzSSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSvK6/mneaweR36hbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IWj7s7GC3O/z3O6iDrcfmKt8epRRIeO2fdZfc4f28j
	i8fls6Uem1Z1snlsXlLv8WLzTEaP3Tcb2DwW901m9ehtfsfmsbP1PqvHx6e3WDze77vK5tG3
	ZRWjx5kFR9gDhKO4bFJSczLLUov07RK4Mt5vESrY4lnR/Ca3gfGUTRcjJ4eEgInE4g3H2boY
	uTiEBHYzSvya+I0RIiEpsezvEWYIW1hi5b/n7BBFzUwSHet2AyU4ONgEtCVO/+cAiYsIbGeW
	+NjczQTiMAu8YZY4+/0KO0i3sICjxO2W1UwgNouAqsSWh+/BNvAKWEl8XXcBapu8xOoNB8C2
	cQLFD2z9ABYXErCUuHv9A9sERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC
	o1ZLcwfj9lUf9A4xMnEwHmKU4GBWEuHdtMUzTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+Ive
	FCGB9MSS1OzU1ILUIpgsEwenVANT6rmL7QlpPx+HFgq+znct9/FxVXpo2GH/6XbL8eLqxZmf
	Qu74B8ndFq18KeznE71uAvOkjU3eezQcpvEoaTVYX2Z+//BhSmPi9ezZMwUmqxmKWTsyqm8M
	ecAY5d53OWeK/EyPmxZVtfmfE4y3hC2O1RHvVvglo3Pam0viP99izlvTv4T/0nlVtP20WdeD
	508bRC2P/hHgedaWYqDaFeF36OWR3bvnLVxnf1L0uPAP7tzjG0vWzhY4Ua3LFlibX6sby7S2
	bZJZEY9c9ebYRxv4elm6ykuKm05tvuOq0vvBZu8miUkZq8RCt717E+yjKSed7XDl0DqWjH6b
	lIVPGc/9nuDKNdXh6dYze150xCmxFGckGmoxFxUnAgBu3X+ISQMAAA==
X-CMS-MailID: 20240520103039epcas5p4373f7234162a32222ac225b976ae30ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103039epcas5p4373f7234162a32222ac225b976ae30ce
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_124542_889071_BD837B33 
X-CRM114-Status: GOOD (  29.65  )
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

Implementation is based on existing read and write infrastructure.
copy_max_bytes: A new configfs and module parameter is introduced, which
can be used to set hardware/driver supported maximum copy limit.
Only request based queue mode will support for copy offload.
Added tracefs support to copy IO tracing.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst  |   5 ++
 drivers/block/null_blk/main.c     | 102 +++++++++++++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |   1 +
 drivers/block/null_blk/trace.h    |  23 +++++++
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_blk.rst
index 4dd78f24d10a..6153e02fcf13 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -149,3 +149,8 @@ zone_size=[MB]: Default: 256
 zone_nr_conv=[nr_conv]: Default: 0
   The number of conventional zones to create when block device is zoned.  If
   zone_nr_conv >= nr_zones, it will be reduced to nr_zones - 1.
+
+copy_max_bytes=[size in bytes]: Default: COPY_MAX_BYTES
+  A module and configfs parameter which can be used to set hardware/driver
+  supported maximum copy offload limit.
+  COPY_MAX_BYTES(=128MB at present) is defined in fs.h
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b33b9ebfebd2..dcfbd5275414 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -172,6 +172,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned long g_copy_max_bytes = BLK_COPY_MAX_BYTES;
+module_param_named(copy_max_bytes, g_copy_max_bytes, ulong, 0444);
+MODULE_PARM_DESC(copy_max_bytes, "Maximum size of a copy command (in bytes)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -433,6 +437,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(copy_max_bytes, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -577,6 +582,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_copy_max_bytes,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -687,7 +693,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"shared_tags,size,submit_queues,use_per_node_hctx,"
 			"virt_boundary,zoned,zone_capacity,zone_max_active,"
 			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size,zone_append_max_sectors\n");
+			"zone_size,zone_append_max_sectors,copy_max_bytes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -753,6 +759,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->copy_max_bytes = g_copy_max_bytes;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1221,6 +1228,81 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
+static inline int nullb_setup_copy(struct nullb *nullb, struct request *req,
+				   bool is_fua)
+{
+	sector_t sector_in = 0, sector_out = 0;
+	loff_t offset_in, offset_out;
+	void *in, *out;
+	ssize_t chunk, rem = 0;
+	struct bio *bio;
+	struct nullb_page *t_page_in, *t_page_out;
+	u16 seg = 1;
+	int status = -EIO;
+
+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
+		return status;
+
+	/*
+	 * First bio contains information about destination and last bio
+	 * contains information about source.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			sector_in = bio->bi_iter.bi_sector;
+			if (rem != bio->bi_iter.bi_size)
+				return status;
+		} else {
+			sector_out = bio->bi_iter.bi_sector;
+			rem = bio->bi_iter.bi_size;
+		}
+		seg++;
+	}
+
+	trace_nullb_copy_op(req, sector_out << SECTOR_SHIFT,
+			    sector_in << SECTOR_SHIFT, rem);
+
+	spin_lock_irq(&nullb->lock);
+	while (rem > 0) {
+		chunk = min_t(size_t, nullb->dev->blocksize, rem);
+		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
+		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
+
+		if (null_cache_active(nullb) && !is_fua)
+			null_make_cache_space(nullb, PAGE_SIZE);
+
+		t_page_in = null_lookup_page(nullb, sector_in, false,
+					     !null_cache_active(nullb));
+		if (!t_page_in)
+			goto err;
+		t_page_out = null_insert_page(nullb, sector_out,
+					      !null_cache_active(nullb) ||
+					      is_fua);
+		if (!t_page_out)
+			goto err;
+
+		in = kmap_local_page(t_page_in->page);
+		out = kmap_local_page(t_page_out->page);
+
+		memcpy(out + offset_out, in + offset_in, chunk);
+		kunmap_local(out);
+		kunmap_local(in);
+		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
+
+		if (is_fua)
+			null_free_sector(nullb, sector_out, true);
+
+		rem -= chunk;
+		sector_in += chunk >> SECTOR_SHIFT;
+		sector_out += chunk >> SECTOR_SHIFT;
+	}
+
+	status = 0;
+err:
+	spin_unlock_irq(&nullb->lock);
+	return status;
+}
+
 static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
@@ -1230,13 +1312,16 @@ static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
 	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
+	bool fua = rq->cmd_flags & REQ_FUA;
+
+	if (op_is_copy(req_op(rq)))
+		return nullb_setup_copy(nullb, rq, fua);
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
-				     rq->cmd_flags & REQ_FUA);
+				     op_is_write(req_op(rq)), sector, fua);
 		if (err)
 			break;
 		sector += len >> SECTOR_SHIFT;
@@ -1721,6 +1806,12 @@ static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
 	lim->max_hw_discard_sectors = UINT_MAX >> 9;
 }
 
+static void null_config_copy(struct nullb *nullb, struct queue_limits *lim)
+{
+	lim->max_copy_hw_sectors = nullb->dev->copy_max_bytes >> SECTOR_SHIFT;
+	lim->max_copy_sectors = nullb->dev->copy_max_bytes >> SECTOR_SHIFT;
+}
+
 static const struct block_device_operations null_ops = {
 	.owner		= THIS_MODULE,
 	.report_zones	= null_report_zones,
@@ -1843,6 +1934,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->queue_mode == NULL_Q_BIO)
+		dev->copy_max_bytes = 0;
+
 	return 0;
 }
 
@@ -1909,6 +2003,8 @@ static int null_add_dev(struct nullb_device *dev)
 	if (dev->virt_boundary)
 		lim.virt_boundary_mask = PAGE_SIZE - 1;
 	null_config_discard(nullb, &lim);
+	null_config_copy(nullb, &lim);
+
 	if (dev->zoned) {
 		rv = null_init_zoned_dev(dev, &lim);
 		if (rv)
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 3234e6c85eed..c588729c17bd 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -91,6 +91,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned long copy_max_bytes; /* Max copy offload length in bytes */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index f9eadac6b22f..cda1a2249978 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -76,6 +76,29 @@ TRACE_EVENT(nullb_report_zones,
 );
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+TRACE_EVENT(nullb_copy_op,
+		TP_PROTO(struct request *req,
+			 sector_t dst, sector_t src, size_t len),
+		TP_ARGS(req, dst, src, len),
+		TP_STRUCT__entry(
+				 __array(char, disk, DISK_NAME_LEN)
+				 __field(enum req_op, op)
+				 __field(sector_t, dst)
+				 __field(sector_t, src)
+				 __field(size_t, len)
+		),
+		TP_fast_assign(
+			       __entry->op = req_op(req);
+			       __assign_disk_name(__entry->disk, req->q->disk);
+			       __entry->dst = dst;
+			       __entry->src = src;
+			       __entry->len = len;
+		),
+		TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
+			  __print_disk_name(__entry->disk),
+			  blk_op_str(__entry->op),
+			  __entry->dst, __entry->src, __entry->len)
+);
 #endif /* _TRACE_NULLB_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1


