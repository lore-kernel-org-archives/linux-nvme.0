Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F30FC3F2D2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 06:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA17624695
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 06:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1kr4MVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA17624695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=W0JE7SeDE+jGTaDxYtY9MNs3S045Mb/IrRzhB9bXK8g=; b=d1kr4MVT6k1+QH
	OXdPlsdMl9dRjtSXe/1tO3Qpk31a0Vvq92ej9OVQYjMW+5XutUOtDAcmDdY6Tt0RY0b0cuQMWW/FM
	uvGBrQJ/A/DE3ECYJ7hJM1HAhBP7rRBB+bL8QCgjFBICop+FoSU/r5G3p8jG9hIdLWRKobELjoPIv
	LgqjKGvQ2hiAUU+rxHefDfNHXr7Mz/pSKqhojc8tv8J6tD92HwYwC6v1O10/Q/K68dlr6+zFMPXdB
	Oin/Gq2Ri2IrHHIjLpum77l+3EYUcIOkr7/yYCwLW9dqD6tBBaTPd4ww+37+qdeG/rn2qlTFJLJZY
	dZ4gBZ6vG/YLATtB8V8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8eZi-0001qt-RE; Mon, 02 Mar 2020 06:29:10 +0000
Received: from mo-csw1115.securemx.jp ([210.130.202.157]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8eZe-0001qN-Fi
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 06:29:09 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0226SYIB024592;
 Mon, 2 Mar 2020 15:28:34 +0900
X-Iguazu-Qid: 2wGrZsIRE3OS1b6YEL
X-Iguazu-QSIG: v=2; s=0; t=1583130514; q=2wGrZsIRE3OS1b6YEL;
 m=X60almfTyOdz9J+1VrluHbhCEEh2o3p2cHwKn7ITjqA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1112) id 0226SW51018421;
 Mon, 2 Mar 2020 15:28:32 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 0226SVbh001454;
 Mon, 2 Mar 2020 15:28:31 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 0226SVF0030943;
 Mon, 2 Mar 2020 15:28:31 +0900
From: <masahiro31.yamada@kioxia.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXwWtP+3uT/YWciSkKTlF+qgQWgkQ==
Date: Mon, 2 Mar 2020 06:28:29 +0000
X-TSB-HOP: ON
Message-ID: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.177.171]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_222906_801490_7FE77D6A 
X-CRM114-Status: UNSURE (   9.05  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently 32 bit application gets ENOTTY when it calls
compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.

The cause is that the results of sizeof(struct nvme_user_io),
which is used to define NVME_IOCTL_SUBMIT_IO,
are not same between 32 bit compiler and 64 bit compiler.

* 32 bit: the result of sizeof nvme_user_io is 44.
* 64 bit: the result of sizeof nvme_user_io is 48.

64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.

This patch adds a compat_ioctl handler.
The handler replaces NVME_IOCTL_SUBMIT_IO32 with NVME_IOCTL_SUBMIT_IO
in case 32 bit application calls compat_ioctl for submit in 64 bit kernel.
Then, it calls nvme_ioctl as usual.

Signed-off-by: Masahiro Yamada (KIOXIA) <masahiro31.yamada@kioxia.com>
---
 drivers/nvme/host/core.c        | 13 +++++++++++--
 include/uapi/linux/nvme_ioctl.h | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 641c07347e8d..7bc1e39b7cc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1584,6 +1584,15 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	if (cmd == NVME_IOCTL_SUBMIT_IO32)
+		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
+
+	return nvme_ioctl(bdev, mode, cmd, arg);
+}
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
@@ -2027,7 +2036,7 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
@@ -2055,7 +2064,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.getgeo		= nvme_getgeo,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..52699a26b9b3 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -24,6 +24,21 @@ struct nvme_user_io {
 	__u16	appmask;
 };
 
+struct nvme_user_io32 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((packed));
+
 struct nvme_passthru_cmd {
 	__u8	opcode;
 	__u8	flags;
@@ -72,6 +87,7 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_ID		_IO('N', 0x40)
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
-- 
2.20.1




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
