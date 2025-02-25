Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E78C19777
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KYPN268bDbdUIUQETKGlB40kZ2e2KCK68/xpxhMiE60=; b=k5+g0O66j26m2XuoTaObhvW205
	4LZR9TH+BwzmRDrtgF8339LZtPjsE8a3Jcmri3DFWA1nm4O4jBD8Zr+LZBDfkg/oxWl9GJLw+D0Go
	RGrWAKKQt0eNu1KWsZA8j2XqOS5jpWr2Hki6MZkp6PXvAIWM3QsGI2BwP6bzlaRg+WATkVuKW90CO
	dYvnUASwFhEbp/ak9ZfqhkjHVT85xVR7nWPkxH+cbsGKYUdppLFTB5R6eM7iQCshMZVoJnUrhUq1/
	WGD0YYkkuv0yT7uxhiSIeop4yxS0XidMQdaJ7UxyiXH1K7xwG+KlNoVnXRkeCEqPdrPHmkQ0tt1bd
	I9K+Tu5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jN-00000001v4q-3J83;
	Wed, 26 Feb 2025 00:56:57 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Mn-00000001KrF-2J4g;
	Tue, 25 Feb 2025 20:17:22 +0000
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F342203CDFF;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F342203CDFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=KYPN268bDbdUIUQETKGlB40kZ2e2KCK68/xpxhMiE60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e42hykosxujhPhv78giqAldREjaCd3tOogFdPdzoqAYHeLsN/ZNksfZFwl/WtAZQB
	 XiF+xYeoTrVtF5AAhyZwWPDpveaqk+oc2J+05Jy4aLPcUnA1GUi/8dla7xvl3N8/O7
	 MmnJD7+9WUmiZmh++Xb1njp/a3RFDwYsLoo+1ke4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:17 +0000
Subject: [PATCH v3 03/16] accel/habanalabs: convert timeouts to
 secs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-3-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_121721_649874_A3BE7248 
X-CRM114-Status: GOOD (  12.60  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:54 -0800
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

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
 (E
- * \( 1000 \| MSEC_PER_SEC \)
 )

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/accel/habanalabs/common/command_submission.c | 2 +-
 drivers/accel/habanalabs/common/debugfs.c            | 2 +-
 drivers/accel/habanalabs/common/device.c             | 2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 59823e3c3bf7a4fafc0b112fd7b4b2209149973c..dee487724918554c24c3e78df4e8715dd1c73acd 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -2586,7 +2586,7 @@ int hl_cs_ioctl(struct drm_device *ddev, void *data, struct drm_file *file_priv)
 		cs_seq = args->in.seq;
 
 	timeout = flags & HL_CS_FLAGS_CUSTOM_TIMEOUT
-			? msecs_to_jiffies(args->in.timeout * 1000)
+			? secs_to_jiffies(args->in.timeout)
 			: hpriv->hdev->timeout_jiffies;
 
 	switch (cs_type) {
diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index ca7677293a55822f703a3a1cbf947c4c44fdc569..4b391807e5f2e2a2570a38b9dfdf6be4299dbfb6 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -1403,7 +1403,7 @@ static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
 		return rc;
 
 	if (value)
-		hdev->timeout_jiffies = msecs_to_jiffies(value * 1000);
+		hdev->timeout_jiffies = secs_to_jiffies(value);
 	else
 		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 
diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 30277ae410d4b742ffb7bddc35498564ff96fe62..68eebed3b050f72f81e55b86da869b56b4cdeadf 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2091,7 +2091,7 @@ int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask)
 	dev_dbg(hdev->dev, "Device is going to be hard-reset in %u sec unless being released\n",
 		hdev->device_release_watchdog_timeout_sec);
 	schedule_delayed_work(&hdev->device_release_watchdog_work.reset_work,
-				msecs_to_jiffies(hdev->device_release_watchdog_timeout_sec * 1000));
+				secs_to_jiffies(hdev->device_release_watchdog_timeout_sec));
 	hdev->reset_info.watchdog_active = 1;
 out:
 	spin_unlock(&hdev->reset_info.lock);
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 596c52e8aa266bf48e2be45e719adb202604577b..0035748f3228246da235f227b2cf3939d64af350 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -386,7 +386,7 @@ static int fixup_device_params(struct hl_device *hdev)
 	hdev->fw_comms_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
 	if (tmp_timeout)
-		hdev->timeout_jiffies = msecs_to_jiffies(tmp_timeout * MSEC_PER_SEC);
+		hdev->timeout_jiffies = secs_to_jiffies(tmp_timeout);
 	else
 		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 

-- 
2.43.0


