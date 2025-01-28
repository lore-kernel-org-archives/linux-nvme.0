Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C0FC02192
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 19:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++CcFDhMGmgcKwzaiNwx3lMiN5jr5twzkm9Lzfmspqc=; b=AOJthyvv3cyxfPBIbqEcq5V+8Z
	HX3LmkBS6+wEChjxExQiNYrASRQNpVwlnFGj+h9CElvZjQBXsl02ro6+IvACfLhtsdls5UHGWZqA+
	CyVSXUitm58+IvqEboQHIuAwQEtCXT9UtP8oAANcuyhXTEg8EMXTnsGbQTM3N7N7skn62Tc9KaEtM
	iYxk6Sy8epEVZBfaAeIEtcrT4miuQdsYsVtouJBSXVWAqH4x2B/nXf7ERNujP4swvNXfWVynSbuIJ
	Ea3//skfmfId9dg5gfukZp0KC1G/9p1E+CJgf+fb+QQ0EPbBTmjKhU8oa3lPHG8Lnx4KOf9Ste1wk
	mSd/v6LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcqpV-00000005eGd-3Ymk;
	Tue, 28 Jan 2025 19:00:57 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcqDq-00000005YwQ-0Neh;
	Tue, 28 Jan 2025 18:22:04 +0000
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB2792037180;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB2792037180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=++CcFDhMGmgcKwzaiNwx3lMiN5jr5twzkm9Lzfmspqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nOvIreoPo3EtPXnqT78hdGSPjS+BJfm76bfob6LjYY8fpAzAx+SSWBMemjjxO+8RL
	 gtA/N4PvBwCgX5MwsErpmvFLEJEFEicnjVAtYs/DImfDKgiY3inNNwt6TIW4w8Mj2E
	 eLHR2MK1+CS1Dd52E6DvRE+gXgt4inmHotPghBSw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:55 +0000
Subject: [PATCH 10/16] power: supply: da9030: convert timeouts to
 secs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-10-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
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
X-CRM114-CacheID: sfid-20250128_102202_249108_7E1E0288 
X-CRM114-Status: GOOD (  11.37  )
X-Mailman-Approved-At: Tue, 28 Jan 2025 11:00:48 -0800
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
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

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
 drivers/power/supply/da9030_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index ac2e319e95179039279dacaed1744136f679fbac..d25279c260308b6c82acb2aabf44f3749f71b703 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -502,8 +502,7 @@ static int da9030_battery_probe(struct platform_device *pdev)
 
 	/* 10 seconds between monitor runs unless platform defines other
 	   interval */
-	charger->interval = msecs_to_jiffies(
-		(pdata->batmon_interval ? : 10) * 1000);
+	charger->interval = secs_to_jiffies(pdata->batmon_interval ? : 10);
 
 	charger->charge_milliamp = pdata->charge_milliamp;
 	charger->charge_millivolt = pdata->charge_millivolt;

-- 
2.43.0


