Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED70C3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13A4208CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UmZ7zby7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A4208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FoZ5UoS/yrvfKMJhrHF3q2Q9LxHvxl84kr20jXGvQ7c=; b=UmZ7zby7FOqBD5
	AkX6UnxhDPEOdw4vGVt++c5ymWn7+0PUz6REM4/n3LxJiiQgHjTWsfCToijaTkJaDBh/T3GvT7TIW
	hi8m/Ch1ZeU5AEHN4h1GflkSTKDaO7vVGqkh7LLeI3HMwD0bWGGCvb5OxKXWorhc3a9xih7DmciNm
	vmibYd6tqr2Qzt/caXXiCJQ3pzoiIzgt7ca1lFqDqRJcYlwbZCr5HEeQRkyL1xytA1xY6m0q11IX2
	9o+q/vAPkjSwaoAZttUdU2+CPlXawCMz5LmQvda91+lKCad2Z8ocqxIqPBauQG6F03VZ3YeTfNPOh
	j0w9yHlv52JatXzuJhLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9oRy-0004s0-Ef; Thu, 05 Mar 2020 11:13:58 +0000
Received: from mo-csw1116.securemx.jp ([210.130.202.158]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9oRu-0004rE-2I
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 11:13:56 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 025BDX1V015860;
 Thu, 5 Mar 2020 20:13:33 +0900
X-Iguazu-Qid: 2wGrZsIRE8pQSV7Fy5
X-Iguazu-QSIG: v=2; s=0; t=1583406813; q=2wGrZsIRE8pQSV7Fy5;
 m=McYGfV8dxJXuSzrIAY5pjF/E2qWawJI35af6F8TIVNI=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1111) id 025BDVrV006451;
 Thu, 5 Mar 2020 20:13:32 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 025BDVip015915;
 Thu, 5 Mar 2020 20:13:31 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 025BDVfC004108;
 Thu, 5 Mar 2020 20:13:31 +0900
From: <masahiro31.yamada@kioxia.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXy3d6dwSgpOC+0SI6LHpzHuGP6yQ==
Date: Thu, 5 Mar 2020 11:13:29 +0000
X-TSB-HOP: ON
Message-ID: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.116.224.115]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_031354_383117_CD4F1DD9 
X-CRM114-Status: GOOD (  12.55  )
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
v2:
- Add a comment explaining what is going on in nvme_compat_ioctl()
- Put nvme_compat_ioctl() under CONFIG_COMPAT and add #else branch
- Move struct nvme_user_io32 #ifdef CONFIG_COMPAT block in core.c
- Fix packed pragma warning by checkpatch.pl
  WARNING: __packed is preferred over __attribute__((packed))

 drivers/nvme/host/core.c | 45 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 641c07347e8d..8c6998920b2a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1584,6 +1584,47 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
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
+} __attribute__((__packed__));
+
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
+
+static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	/*
+	 * Corresponds to the difference of NVME_IOCTL_SUBMIT_IO
+	 * between 32 bit programs and 64 bit kernel.
+	 * The cause is that the results of sizeof(struct nvme_user_io),
+	 * which is used to define NVME_IOCTL_SUBMIT_IO,
+	 * are not same between 32 bit compiler and 64 bit compiler.
+	 * NVME_IOCTL_SUBMIT_IO32 is for 64 bit kernel handling
+	 * NVME_IOCTL_SUBMIT_IO issued from 32 bit programs.
+	 * Other IOCTL numbers are same between 32 bit and 64 bit.
+	 * So there is nothing to do regarding to other IOCTL numbers.
+	 */
+	if (cmd == NVME_IOCTL_SUBMIT_IO32)
+		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
+
+	return nvme_ioctl(bdev, mode, cmd, arg);
+}
+#else
+#define nvme_compat_ioctl	NULL
+#endif /* CONFIG_COMPAT */
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
@@ -2027,7 +2068,7 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
@@ -2055,7 +2096,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
 	.getgeo		= nvme_getgeo,
 	.pr_ops		= &nvme_pr_ops,
 };
-- 
2.20.1




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
